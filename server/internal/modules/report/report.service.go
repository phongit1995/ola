package report

import (
	"context"
	"encoding/json"
	"errors"
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/message"
	momentModule "ola-chat-server/internal/modules/moment"
	"ola-chat-server/internal/modules/room"
	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrInvalidTargetType = utils.NewHTTPError(http.StatusBadRequest, "invalid report target type")
	ErrInvalidReason     = utils.NewHTTPError(http.StatusBadRequest, "invalid report reason")
	ErrInvalidTarget     = utils.NewHTTPError(http.StatusBadRequest, "invalid report target")
	ErrContextRequired   = utils.NewHTTPError(http.StatusBadRequest, "report context is required")
	ErrTargetNotFound    = utils.NewHTTPError(http.StatusNotFound, "report target not found")
	ErrReportSelf        = utils.NewHTTPError(http.StatusBadRequest, "cannot report yourself")
	ErrNotMember         = utils.NewHTTPError(http.StatusForbidden, "not a conversation member")
	ErrReportExists      = utils.NewHTTPErrorWithCode(http.StatusConflict, "report already submitted", ErrorCodeReportExists)
)

var validTargetTypes = map[string]bool{
	constants.ReportTargetAccount:      true,
	constants.ReportTargetPost:         true,
	constants.ReportTargetComment:      true,
	constants.ReportTargetStoryComment: true,
	constants.ReportTargetMessage:      true,
	constants.ReportTargetRoomMessage:  true,
	constants.ReportTargetMoment:       true,
}

var uuidTargetTypes = map[string]bool{
	constants.ReportTargetAccount:      true,
	constants.ReportTargetPost:         true,
	constants.ReportTargetComment:      true,
	constants.ReportTargetStoryComment: true,
	constants.ReportTargetMessage:      true,
	constants.ReportTargetMoment:       true,
}

var validReasons = map[string]bool{
	ReportReasonSpam:       true,
	ReportReasonSensitive:  true,
	ReportReasonScam:       true,
	ReportReasonHarassment: true,
	ReportReasonOther:      true,
}

type resolvedTarget struct {
	reportedUserID *uuid.UUID
	contextID      *string
	snapshot       models.JSONB
}

type Service struct {
	repo     *Repository
	rooms    *room.Service
	messages *message.Service
	alerter  *Alerter
	logger   *zap.SugaredLogger
}

func NewService(repo *Repository, rooms *room.Service, messages *message.Service, alerter *Alerter, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, rooms: rooms, messages: messages, alerter: alerter, logger: logger.Named("[report_service]")}
}

func (s *Service) Create(ctx context.Context, reporterID uuid.UUID, req *CreateReportRequest) (*ReportResponse, error) {
	targetType := strings.TrimSpace(req.TargetType)
	if !validTargetTypes[targetType] {
		return nil, ErrInvalidTargetType
	}
	if !validReasons[req.Reason] {
		return nil, ErrInvalidReason
	}
	targetID := canonicalTargetID(targetType, strings.TrimSpace(req.TargetID))
	if targetID == "" || len(targetID) > ReportTargetIDMaxLen {
		return nil, ErrInvalidTarget
	}

	exists, err := s.repo.HasPending(reporterID, targetType, targetID)
	if err != nil {
		return nil, err
	}
	if exists {
		return nil, ErrReportExists
	}

	target, err := s.resolve(ctx, reporterID, targetType, targetID, strings.TrimSpace(req.ContextID))
	if err != nil {
		return nil, err
	}
	if target.reportedUserID != nil && *target.reportedUserID == reporterID {
		return nil, ErrReportSelf
	}

	report := &models.Report{
		ReporterID:     reporterID,
		TargetType:     targetType,
		TargetID:       targetID,
		ContextID:      target.contextID,
		ReportedUserID: target.reportedUserID,
		Reason:         req.Reason,
		Note:           utils.TruncateRunes(strings.TrimSpace(req.Note), ReportNoteMaxRunes),
		Snapshot:       target.snapshot,
		Status:         constants.ReportStatusPending,
	}
	if err := s.save(report); err != nil {
		switch {
		case errors.Is(err, errDuplicateReport):
			return nil, ErrReportExists
		case errors.Is(err, gorm.ErrRecordNotFound):
			return nil, ErrTargetNotFound
		}
		return nil, err
	}

	s.logger.Infow("Report created", "report_id", report.ID, "reporter_id", reporterID, "target_type", targetType, "target_id", targetID)
	utils.SafeGo(s.logger, func() { s.alerter.ReportCreated(report) })
	return &ReportResponse{
		ID:        report.ID.String(),
		Status:    report.Status,
		CreatedAt: report.CreatedAt.UTC().Format(time.RFC3339),
	}, nil
}

func (s *Service) save(report *models.Report) error {
	if report.TargetType == constants.ReportTargetRoomMessage {
		return s.repo.CreateWhileRoomImagesKept(report)
	}
	if report.TargetType != constants.ReportTargetMoment {
		return s.repo.Create(report)
	}
	momentID, err := uuid.Parse(report.TargetID)
	if err != nil {
		return ErrInvalidTarget
	}
	return s.repo.CreateWhileMomentKept(report, momentID)
}

func canonicalTargetID(targetType, targetID string) string {
	if !uuidTargetTypes[targetType] {
		return targetID
	}
	if id, err := uuid.Parse(targetID); err == nil {
		return id.String()
	}
	return targetID
}

func (s *Service) resolve(ctx context.Context, reporterID uuid.UUID, targetType, targetID, contextID string) (*resolvedTarget, error) {
	switch targetType {
	case constants.ReportTargetRoomMessage:
		return s.resolveRoomMessage(ctx, targetID, contextID)
	case constants.ReportTargetMessage:
		return s.resolveDirectMessage(reporterID, targetID, contextID)
	}

	id, err := uuid.Parse(targetID)
	if err != nil {
		return nil, ErrInvalidTarget
	}
	switch targetType {
	case constants.ReportTargetAccount:
		user, err := s.repo.FindUser(id)
		if err != nil {
			return nil, notFoundOr(err)
		}
		return &resolvedTarget{
			reportedUserID: &user.ID,
			snapshot: compactSnapshot(models.JSONB{
				"username": user.Username,
				"fullName": user.FullName,
				"avatar":   user.Avatar,
			}),
		}, nil
	case constants.ReportTargetPost:
		post, err := s.repo.FindPost(id)
		if err != nil {
			return nil, notFoundOr(err)
		}
		imageURLs := make([]string, 0, len(post.Images))
		for _, image := range post.Images {
			if image.URL != "" {
				imageURLs = append(imageURLs, image.URL)
			}
		}
		return &resolvedTarget{
			reportedUserID: &post.AuthorID,
			snapshot: compactSnapshot(models.JSONB{
				"text":      post.Content,
				"imageUrls": imageURLs,
				"sticker":   post.Sticker,
				"sentAt":    post.CreatedAt.UTC().Format(time.RFC3339),
			}),
		}, nil
	case constants.ReportTargetComment:
		comment, err := s.repo.FindMeComment(id)
		if err != nil {
			return nil, notFoundOr(err)
		}
		postID := comment.PostID.String()
		return &resolvedTarget{
			reportedUserID: &comment.AuthorID,
			contextID:      &postID,
			snapshot: compactSnapshot(models.JSONB{
				"text":   comment.Content,
				"sentAt": comment.CreatedAt.UTC().Format(time.RFC3339),
			}),
		}, nil
	case constants.ReportTargetStoryComment:
		comment, err := s.repo.FindStoryComment(id)
		if err != nil {
			return nil, notFoundOr(err)
		}
		storyID := comment.StoryID.String()
		return &resolvedTarget{
			reportedUserID: &comment.AuthorID,
			contextID:      &storyID,
			snapshot: compactSnapshot(models.JSONB{
				"text":   comment.Content,
				"sentAt": comment.CreatedAt.UTC().Format(time.RFC3339),
			}),
		}, nil
	case constants.ReportTargetMoment:
		moment, err := s.repo.FindMoment(id)
		if err != nil {
			return nil, notFoundOr(err)
		}
		return &resolvedTarget{
			reportedUserID: &moment.AuthorID,
			snapshot:       compactSnapshot(momentSnapshot(moment)),
		}, nil
	}
	return nil, ErrInvalidTargetType
}

func momentSnapshot(moment *models.Moment) models.JSONB {
	texts := make([]string, 0, len(moment.Overlays))
	for _, overlay := range moment.Overlays {
		texts = append(texts, overlay.Text)
	}
	snapshot := models.JSONB{
		"momentType": moment.Type,
		"text":       strings.Join(texts, "\n"),
		"background": moment.Background,
		"overlays":   moment.Overlays,
		"sentAt":     moment.CreatedAt.UTC().Format(time.RFC3339),
	}
	switch moment.Type {
	case momentModule.MomentTypeImage:
		snapshot["imageUrls"] = []string{moment.MediaURL}
	case momentModule.MomentTypeVideo:
		snapshot["videoUrl"] = moment.MediaURL
		if moment.ThumbURL != "" {
			snapshot["imageUrls"] = []string{moment.ThumbURL}
		}
	}
	return snapshot
}

func (s *Service) resolveRoomMessage(ctx context.Context, messageID, contextID string) (*resolvedTarget, error) {
	if contextID == "" {
		return nil, ErrContextRequired
	}
	roomID, err := uuid.Parse(contextID)
	if err != nil {
		return nil, ErrInvalidTarget
	}
	msg, err := s.rooms.FindMessage(ctx, roomID, messageID)
	if err != nil {
		if errors.Is(err, room.ErrMessageNotFound) {
			return nil, ErrTargetNotFound
		}
		return nil, err
	}
	senderID, err := uuid.Parse(msg.SenderID)
	if err != nil {
		return nil, ErrTargetNotFound
	}
	roomIDStr := roomID.String()
	snapshot := models.JSONB{
		"messageType": msg.Type,
		"text":        msg.Content,
		"audioUrl":    msg.AudioURL,
		"sentAt":      msg.CreatedAt,
	}
	if msg.ImageURL != "" {
		snapshot["imageUrls"] = []string{msg.ImageURL}
	}
	return &resolvedTarget{
		reportedUserID: &senderID,
		contextID:      &roomIDStr,
		snapshot:       compactSnapshot(snapshot),
	}, nil
}

func (s *Service) resolveDirectMessage(reporterID uuid.UUID, messageID, contextID string) (*resolvedTarget, error) {
	if contextID == "" {
		return nil, ErrContextRequired
	}
	conversation, err := uuid.Parse(contextID)
	if err != nil {
		return nil, ErrInvalidTarget
	}
	conversationID := conversation.String()
	if _, err := gocql.ParseUUID(messageID); err != nil {
		return nil, ErrInvalidTarget
	}
	msg, err := s.messages.FindMessageForMember(reporterID, conversationID, messageID)
	if err != nil {
		switch {
		case errors.Is(err, message.ErrNotConversationMember):
			return nil, ErrNotMember
		case errors.Is(err, message.ErrMessageNotFound):
			return nil, ErrTargetNotFound
		}
		return nil, err
	}

	snapshot := models.JSONB{
		"messageType": msg.MessageType,
		"text":        msg.Content,
		"sentAt":      msg.CreatedAt.UTC().Format(time.RFC3339),
	}
	if url := metadataURL(msg.Metadata); url != "" {
		switch msg.MessageType {
		case constants.MessageTypeImage:
			snapshot["imageUrls"] = []string{url}
		case constants.MessageTypeAudio:
			snapshot["audioUrl"] = url
		default:
			snapshot["fileUrl"] = url
		}
	}
	return &resolvedTarget{
		reportedUserID: &msg.SenderID,
		contextID:      &conversationID,
		snapshot:       compactSnapshot(snapshot),
	}, nil
}

func metadataURL(metadata string) string {
	if metadata == "" {
		return ""
	}
	var parsed struct {
		URL string `json:"url"`
	}
	if err := json.Unmarshal([]byte(metadata), &parsed); err != nil {
		return ""
	}
	return parsed.URL
}

func compactSnapshot(snapshot models.JSONB) models.JSONB {
	for key, value := range snapshot {
		switch v := value.(type) {
		case string:
			if v == "" {
				delete(snapshot, key)
			}
		case []string:
			if len(v) == 0 {
				delete(snapshot, key)
			}
		}
	}
	return snapshot
}

func notFoundOr(err error) error {
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return ErrTargetNotFound
	}
	return err
}
