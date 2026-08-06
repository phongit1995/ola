package call

import (
	"context"
	"crypto/sha256"
	"encoding/base64"
	"encoding/json"
	"errors"
	"fmt"
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	callEvents "ola-chat-server/internal/domain/call"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/conversation"
	"ola-chat-server/internal/modules/message"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/utils"
	"sync"
	"time"

	"github.com/google/uuid"
	"github.com/livekit/protocol/auth"
	"go.uber.org/zap"
)

var (
	ErrConversationNotFound = errors.New("conversation not found or user not a member")
	ErrCallNotFound         = errors.New("call not found")
	ErrCallNotPending       = errors.New("call is not pending")
	ErrNotAuthorized        = errors.New("not authorized for this call")
	ErrLiveKitNotConfigured = errors.New("livekit is not configured")
	ErrCallNotDirect        = errors.New("calls are only available in direct conversations")
	ErrCallBlocked          = errors.New("cannot call this user")
	ErrCallNotFriend        = errors.New("you can only call friends")
	ErrCallAlreadyOngoing   = errors.New("another call is already ongoing")
)

const directCallMemberCount = 2

type Service struct {
	repo         *Repository
	convService  *conversation.Service
	relationship *relationships.Service
	msgService   *message.Service
	producer     *kafka.Producer
	cfg          *config.Config
	logger       *zap.SugaredLogger

	timers   map[uuid.UUID]*time.Timer
	timersMu sync.Mutex
}

func NewService(
	repo *Repository,
	convService *conversation.Service,
	relationship *relationships.Service,
	msgService *message.Service,
	producer *kafka.Producer,
	cfg *config.Config,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:         repo,
		convService:  convService,
		relationship: relationship,
		msgService:   msgService,
		producer:     producer,
		cfg:          cfg,
		logger:       logger.Named("[call_service]"),
		timers:       make(map[uuid.UUID]*time.Timer),
	}
}

func (s *Service) StartCall(ctx context.Context, callerID, conversationID uuid.UUID, callType string) (*CallTokenResponse, error) {
	if s.cfg.LiveKitAPIKey == "" || s.cfg.LiveKitAPISecret == "" {
		return nil, ErrLiveKitNotConfigured
	}

	members, err := s.convService.GetMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("get members: %w", err)
	}

	if !conversation.IsActiveMember(members, callerID) {
		return nil, ErrConversationNotFound
	}
	memberIDs := conversation.ActiveMemberIDs(members)

	if err := s.ensureDirectCallAllowed(conversationID, callerID, memberIDs); err != nil {
		return nil, err
	}

	if ongoing, err := s.findOngoingCall(ctx, callerID); err != nil {
		return nil, err
	} else if ongoing != nil {
		return nil, ErrCallAlreadyOngoing
	}

	roomName := fmt.Sprintf("call_%s_%s", conversationID.String(), uuid.New().String()[:8])

	participantsStr := uuidsToStrings(memberIDs)

	now := time.Now()
	call := &models.Call{
		ConversationID: conversationID,
		CallerID:       callerID,
		CallType:       models.CallType(callType),
		RoomName:       roomName,
		Status:         models.CallStatusRinging,
		Participants:   participantsStr,
		StartedAt:      now,
	}

	created, err := s.repo.CreateIfNoOngoing(call, memberIDs, callerID, s.ringingSince())
	if err != nil {
		return nil, fmt.Errorf("create call: %w", err)
	}
	if !created {
		return nil, ErrCallAlreadyOngoing
	}

	token, err := s.mintToken(callerID.String(), roomName)
	if err != nil {
		return nil, fmt.Errorf("mint token: %w", err)
	}

	recipients := excludeUserStr(participantsStr, callerID.String())
	if err := s.producer.PublishCallInvited(ctx, &callEvents.InvitedEvent{
		CallID:             call.ID.String(),
		ConversationID:     conversationID.String(),
		CallerID:           callerID.String(),
		CallType:           callType,
		RoomName:           roomName,
		Recipients:         recipients,
		StartedAt:          now,
		RingTimeoutSeconds: s.ringTimeoutSeconds(),
	}); err != nil {
		s.logger.Warnw("Failed to publish CallInvited", "error", err)
	}

	s.scheduleTimeout(call.ID)

	return &CallTokenResponse{
		CallID:             call.ID.String(),
		RoomName:           roomName,
		Token:              token,
		WsURL:              s.cfg.LiveKitURL,
		ConversationID:     conversationID.String(),
		CallerID:           callerID.String(),
		CallType:           callType,
		Status:             string(call.Status),
		StartedAt:          now,
		RingTimeoutSeconds: s.ringTimeoutSeconds(),
	}, nil
}

func (s *Service) AnswerCall(ctx context.Context, callID, userID uuid.UUID) (*CallTokenResponse, error) {
	call, err := s.repo.FindByID(callID)
	if err != nil {
		return nil, ErrCallNotFound
	}
	if call.Status != models.CallStatusRinging {
		return nil, ErrCallNotPending
	}
	if !containsUUID(call.Participants, userID.String()) {
		return nil, ErrNotAuthorized
	}
	if call.CallerID == userID {
		return nil, ErrNotAuthorized
	}

	// The relationship can change between INVITED and ANSWER (block/unfriend
	// while ringing), so the gate is re-run here. Decline and end stay open so
	// either side can still tear the call down.
	members, err := s.convService.GetMembersCached(call.ConversationID)
	if err != nil {
		return nil, fmt.Errorf("get members: %w", err)
	}
	if !conversation.IsActiveMember(members, userID) {
		return nil, ErrConversationNotFound
	}
	if err := s.ensureDirectCallAllowed(
		call.ConversationID,
		userID,
		conversation.ActiveMemberIDs(members),
	); err != nil {
		return nil, err
	}

	if err := s.repo.MarkAnswered(callID); err != nil {
		return nil, fmt.Errorf("mark answered: %w", err)
	}

	s.cancelTimeout(callID)

	token, err := s.mintToken(userID.String(), call.RoomName)
	if err != nil {
		return nil, fmt.Errorf("mint token: %w", err)
	}

	if err := s.producer.PublishCallAccepted(ctx, &callEvents.AcceptedEvent{
		CallID:         call.ID.String(),
		ConversationID: call.ConversationID.String(),
		AnsweredBy:     userID.String(),
		Recipients:     excludeUserStr(call.Participants, userID.String()),
	}); err != nil {
		s.logger.Warnw("Failed to publish CallAccepted", "error", err)
	}

	answeredAt := time.Now()
	return &CallTokenResponse{
		CallID:             call.ID.String(),
		RoomName:           call.RoomName,
		Token:              token,
		WsURL:              s.cfg.LiveKitURL,
		ConversationID:     call.ConversationID.String(),
		CallerID:           call.CallerID.String(),
		CallType:           string(call.CallType),
		Status:             string(models.CallStatusActive),
		StartedAt:          answeredAt,
		RingTimeoutSeconds: s.ringTimeoutSeconds(),
	}, nil
}

func (s *Service) DeclineCall(ctx context.Context, callID, userID uuid.UUID) error {
	call, err := s.repo.FindByID(callID)
	if err != nil {
		return ErrCallNotFound
	}
	if call.Status != models.CallStatusRinging {
		return ErrCallNotPending
	}
	if !containsUUID(call.Participants, userID.String()) {
		return ErrNotAuthorized
	}
	if call.CallerID == userID {
		return ErrNotAuthorized
	}

	if _, err := s.repo.MarkEnded(callID, models.CallStatusDeclined); err != nil {
		return err
	}

	s.cancelTimeout(callID)

	if err := s.producer.PublishCallDeclined(ctx, &callEvents.DeclinedEvent{
		CallID:         call.ID.String(),
		ConversationID: call.ConversationID.String(),
		DeclinedBy:     userID.String(),
		Recipients:     excludeUserStr(call.Participants, userID.String()),
	}); err != nil {
		s.logger.Warnw("Failed to publish CallDeclined", "error", err)
	}

	s.sendCallLogMessage(call, models.CallStatusDeclined, 0)
	return nil
}

func (s *Service) EndCall(ctx context.Context, callID, userID uuid.UUID) error {
	call, err := s.repo.FindByID(callID)
	if err != nil {
		return ErrCallNotFound
	}
	if !containsUUID(call.Participants, userID.String()) {
		return ErrNotAuthorized
	}
	if call.Status == models.CallStatusEnded ||
		call.Status == models.CallStatusDeclined ||
		call.Status == models.CallStatusMissed {
		return nil
	}
	return s.finalizeCall(ctx, call, userID.String())
}

func (s *Service) finalizeCall(ctx context.Context, call *models.Call, endedBy string) error {
	finalStatus := models.CallStatusEnded
	if call.Status == models.CallStatusRinging {
		finalStatus = models.CallStatusMissed
	}

	updated, err := s.repo.MarkEnded(call.ID, finalStatus)
	if err != nil {
		return err
	}

	s.cancelTimeout(call.ID)

	dur := 0
	if updated.DurationSeconds != nil {
		dur = *updated.DurationSeconds
	}

	if err := s.producer.PublishCallEnded(ctx, &callEvents.EndedEvent{
		CallID:          call.ID.String(),
		ConversationID:  call.ConversationID.String(),
		EndedBy:         endedBy,
		Status:          string(finalStatus),
		DurationSeconds: dur,
		Recipients:      call.Participants,
	}); err != nil {
		s.logger.Warnw("Failed to publish CallEnded", "error", err)
	}

	s.sendCallLogMessage(call, finalStatus, dur)
	return nil
}

func (s *Service) sendCallLogMessage(call *models.Call, status models.CallStatus, durationSeconds int) {
	meta, err := json.Marshal(message.CallMetadata{
		CallID:          call.ID.String(),
		CallType:        string(call.CallType),
		CallStatus:      string(status),
		DurationSeconds: durationSeconds,
	})
	if err != nil {
		s.logger.Errorw("Failed to marshal call metadata", "callId", call.ID, "error", err)
		return
	}
	callID := call.ID
	callerID := call.CallerID
	conversationID := call.ConversationID
	utils.SafeGo(s.logger, func() {
		if _, err := s.msgService.SendMessage(
			callerID,
			conversationID,
			constants.MessageTypeCall,
			"",
			string(meta),
			nil,
			callID.String(),
		); err != nil {
			s.logger.Errorw("Failed to send call log message", "callId", callID, "error", err)
		}
	})
}

func (s *Service) HandleLiveKitRoomFinished(ctx context.Context, roomName string) error {
	call, err := s.repo.FindByRoomName(roomName)
	if err != nil {
		s.logger.Debugw("Webhook room_finished for unknown room", "room", roomName)
		return nil
	}
	if call.Status == models.CallStatusEnded ||
		call.Status == models.CallStatusDeclined ||
		call.Status == models.CallStatusMissed {
		return nil
	}
	s.logger.Infow("Finalizing call via LiveKit webhook", "callId", call.ID, "room", roomName)
	return s.finalizeCall(ctx, call, "")
}

func (s *Service) scheduleTimeout(callID uuid.UUID) {
	s.timersMu.Lock()
	if existing, ok := s.timers[callID]; ok {
		existing.Stop()
	}
	timer := time.AfterFunc(s.ringTimeout(), func() {
		s.handleTimeout(callID)
	})
	s.timers[callID] = timer
	s.timersMu.Unlock()
}

func (s *Service) cancelTimeout(callID uuid.UUID) {
	s.timersMu.Lock()
	defer s.timersMu.Unlock()
	if t, ok := s.timers[callID]; ok {
		t.Stop()
		delete(s.timers, callID)
	}
}

func (s *Service) handleTimeout(callID uuid.UUID) {
	s.timersMu.Lock()
	delete(s.timers, callID)
	s.timersMu.Unlock()

	call, err := s.repo.FindByID(callID)
	if err != nil {
		return
	}
	if call.Status != models.CallStatusRinging {
		return
	}
	s.logger.Infow("Call timed out — marking missed", "callId", callID)
	if err := s.finalizeCall(context.Background(), call, ""); err != nil {
		s.logger.Errorw("Timeout finalize failed", "callId", callID, "error", err)
	}
}

// VerifyWebhookSignature validates LiveKit's signed JWT in the Authorization
// header against the raw request body. LiveKit signs each webhook with the
// project API secret; the JWT carries a sha256 hash of the body in its claims.
func (s *Service) VerifyWebhookSignature(authHeader string, body []byte) bool {
	if authHeader == "" || s.cfg.LiveKitAPISecret == "" {
		return false
	}
	v, err := auth.ParseAPIToken(authHeader)
	if err != nil {
		return false
	}
	if v.APIKey() != s.cfg.LiveKitAPIKey {
		return false
	}
	_, grants, err := v.Verify(s.cfg.LiveKitAPISecret)
	if err != nil || grants == nil {
		return false
	}
	hash := sha256.Sum256(body)
	want := base64.StdEncoding.EncodeToString(hash[:])
	return grants.Sha256 == want
}

func (s *Service) ensureDirectCallAllowed(conversationID, callerID uuid.UUID, memberIDs []uuid.UUID) error {
	conv, err := s.convService.GetConversationByIDCached(conversationID)
	if err != nil {
		return fmt.Errorf("get conversation: %w", err)
	}
	if conv == nil || conv.Type != constants.ConversationTypeDirect {
		return ErrCallNotDirect
	}
	if len(memberIDs) != directCallMemberCount {
		return ErrCallNotDirect
	}

	peerID := uuid.Nil
	for _, id := range memberIDs {
		if id != callerID {
			peerID = id
			break
		}
	}
	if peerID == uuid.Nil {
		return ErrCallNotDirect
	}

	blocked, err := s.relationship.IsBlockedEither(callerID, peerID)
	if err != nil {
		return fmt.Errorf("check blocked: %w", err)
	}
	if blocked {
		return ErrCallBlocked
	}

	friends, err := s.relationship.AreFriends(callerID, peerID)
	if err != nil {
		return fmt.Errorf("check friendship: %w", err)
	}
	if !friends {
		return ErrCallNotFriend
	}
	return nil
}

func (s *Service) findOngoingCall(ctx context.Context, userID uuid.UUID) (*models.Call, error) {
	call, err := s.repo.FindOngoingByUser(userID, s.ringingSince())
	if err != nil {
		return nil, fmt.Errorf("find ongoing call: %w", err)
	}
	if call == nil {
		return nil, nil
	}
	// An active call is not time-bounded by the query, so a row whose webhook
	// never arrived would pin the user as busy forever. Close it out here
	// rather than pretending it does not exist.
	if call.Status == models.CallStatusActive && exceededMaxDuration(call) {
		s.logger.Infow("Call exceeded max duration — finalizing", "callId", call.ID)
		if err := s.finalizeCall(ctx, call, ""); err != nil {
			s.logger.Errorw("Max duration finalize failed", "callId", call.ID, "error", err)
		}
		return nil, nil
	}
	return call, nil
}

func exceededMaxDuration(call *models.Call) bool {
	start := call.StartedAt
	if call.AnsweredAt != nil {
		start = *call.AnsweredAt
	}
	return time.Since(start) > constants.CallMaxDuration
}

func (s *Service) ringTimeoutSeconds() int {
	seconds := s.cfg.CallRingTimeoutSeconds
	if seconds <= 0 {
		seconds = constants.CallRingTimeoutSeconds
	}
	return seconds
}

func (s *Service) ringTimeout() time.Duration {
	return time.Duration(s.ringTimeoutSeconds()) * time.Second
}

func (s *Service) ringingSince() time.Time {
	return time.Now().Add(-s.ringTimeout() - constants.CallRingStaleGrace)
}

func (s *Service) GetOngoingCall(ctx context.Context, userID uuid.UUID) (*CallTokenResponse, error) {
	call, err := s.findOngoingCall(ctx, userID)
	if err != nil {
		return nil, err
	}
	if call == nil {
		return nil, nil
	}

	// A ringing callee has not accepted yet, so it must not receive a room
	// token — otherwise this endpoint would be a way to join the room while
	// bypassing POST /answer. It still gets the metadata it needs to render
	// the incoming card.
	token := ""
	if call.Status == models.CallStatusActive || call.CallerID == userID {
		token, err = s.mintToken(userID.String(), call.RoomName)
		if err != nil {
			return nil, fmt.Errorf("mint token: %w", err)
		}
	}

	return &CallTokenResponse{
		CallID:             call.ID.String(),
		RoomName:           call.RoomName,
		Token:              token,
		WsURL:              s.cfg.LiveKitURL,
		ConversationID:     call.ConversationID.String(),
		CallerID:           call.CallerID.String(),
		CallType:           string(call.CallType),
		Status:             string(call.Status),
		StartedAt:          call.StartedAt,
		RingTimeoutSeconds: s.ringTimeoutSeconds(),
	}, nil
}

func (s *Service) mintToken(identity, roomName string) (string, error) {
	at := auth.NewAccessToken(s.cfg.LiveKitAPIKey, s.cfg.LiveKitAPISecret)
	canPub := true
	canSub := true
	grant := &auth.VideoGrant{
		RoomJoin:     true,
		Room:         roomName,
		CanPublish:   &canPub,
		CanSubscribe: &canSub,
	}
	at.SetVideoGrant(grant).
		SetIdentity(identity).
		SetValidFor(time.Hour)
	return at.ToJWT()
}

func uuidsToStrings(ids []uuid.UUID) []string {
	out := make([]string, 0, len(ids))
	for _, id := range ids {
		out = append(out, id.String())
	}
	return out
}

func containsUUID(list []string, target string) bool {
	for _, s := range list {
		if s == target {
			return true
		}
	}
	return false
}

func excludeUserStr(list []string, exclude string) []string {
	out := make([]string, 0, len(list))
	for _, s := range list {
		if s != exclude {
			out = append(out, s)
		}
	}
	return out
}
