package room

import (
	roomEvents "ola-chat-server/internal/domain/room"
	"ola-chat-server/internal/models"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"
	"context"
	"encoding/json"
	"errors"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo      *Repository
	redisMsg  *RedisMessageRepository
	userCache *userModule.CacheService
	wsServer  *websocket.Server
	producer  *kafka.Producer
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, redisMsg *RedisMessageRepository, userCache *userModule.CacheService, wsServer *websocket.Server, producer *kafka.Producer, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		redisMsg:  redisMsg,
		userCache: userCache,
		wsServer:  wsServer,
		producer:  producer,
		logger:    logger.Named("[room_service]"),
	}
}

func (s *Service) Create(adminID uuid.UUID, req *CreateRoomRequest) (*RoomResponse, error) {
	room := &models.Room{
		Name:        req.Name,
		Description: req.Description,
		ImageURL:    req.ImageURL,
		MaxMembers:  req.MaxMembers,
		Enabled:     true,
		CreatedBy:   adminID,
	}
	if err := s.repo.Create(room); err != nil {
		return nil, err
	}
	s.logger.Infow("Room created", "room_id", room.ID, "admin_id", adminID)
	return toRoomResponse(room, 0), nil
}

func (s *Service) Update(ctx context.Context, id uuid.UUID, req *UpdateRoomRequest) (*RoomResponse, error) {
	room, err := s.getRoom(id)
	if err != nil {
		return nil, err
	}
	if req.Name != nil {
		room.Name = *req.Name
	}
	if req.Description != nil {
		room.Description = *req.Description
	}
	if req.ImageURL != nil {
		room.ImageURL = *req.ImageURL
	}
	if req.MaxMembers != nil {
		room.MaxMembers = *req.MaxMembers
	}
	if req.Enabled != nil {
		room.Enabled = *req.Enabled
	}
	if err := s.repo.Save(room); err != nil {
		return nil, err
	}
	count, _ := s.wsServer.GetRoomPresence().MemberCount(ctx, room.ID.String())
	return toRoomResponse(room, count), nil
}

func (s *Service) Delete(id uuid.UUID) error {
	if _, err := s.getRoom(id); err != nil {
		return err
	}
	return s.repo.SoftDelete(id)
}

func (s *Service) ListAdmin(ctx context.Context, query string, limit, offset int) (*RoomListResponse, error) {
	rooms, total, err := s.repo.ListAll(query, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(ctx, rooms, total, limit, offset), nil
}

func (s *Service) ListPublic(ctx context.Context, query string, limit, offset int) (*RoomListResponse, error) {
	rooms, total, err := s.repo.ListPublic(query, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(ctx, rooms, total, limit, offset), nil
}

func (s *Service) GetByID(ctx context.Context, id uuid.UUID) (*RoomResponse, error) {
	room, err := s.getRoom(id)
	if err != nil {
		return nil, err
	}
	count, _ := s.wsServer.GetRoomPresence().MemberCount(ctx, id.String())
	return toRoomResponse(room, count), nil
}

func (s *Service) ListMembers(ctx context.Context, roomID uuid.UUID) (*RoomMembersResponse, error) {
	if _, err := s.getRoom(roomID); err != nil {
		return nil, err
	}
	ids, err := s.wsServer.GetRoomPresence().OnlineMembers(ctx, roomID.String())
	if err != nil {
		return nil, err
	}

	uuids := make([]uuid.UUID, 0, len(ids))
	for _, id := range ids {
		if uid, err := uuid.Parse(id); err == nil {
			uuids = append(uuids, uid)
		}
	}

	usersMap := s.userCache.GetUsersBatch(uuids, true)
	items := make([]RoomMemberResponse, 0, len(uuids))
	for _, uid := range uuids {
		u, ok := usersMap[uid]
		if !ok || u == nil {
			continue
		}
		items = append(items, RoomMemberResponse{
			UserID:   uid.String(),
			Username: u.Username,
			FullName: u.FullName,
			Avatar:   u.Avatar,
		})
	}
	return &RoomMembersResponse{Items: items, Total: len(items)}, nil
}

func (s *Service) SendMessage(ctx context.Context, userID, roomID uuid.UUID, req *SendRoomMessageRequest) (*RoomMessageResponse, error) {
	room, err := s.getRoom(roomID)
	if err != nil {
		return nil, err
	}
	if !room.Enabled {
		return nil, errors.New("room is disabled")
	}

	isMember, err := s.wsServer.GetRoomPresence().IsMember(ctx, roomID.String(), userID.String())
	if err != nil {
		return nil, err
	}
	if !isMember {
		return nil, errors.New("not a room member")
	}

	senderName, senderAvatar := s.senderInfo(userID)
	msgID := uuid.New().String()
	createdAt := time.Now().UTC()

	msg := RoomMessageResponse{
		ID:           msgID,
		RoomID:       roomID.String(),
		SenderID:     userID.String(),
		SenderName:   senderName,
		SenderAvatar: senderAvatar,
		Content:      req.Content,
		CreatedAt:    createdAt.Format(time.RFC3339),
	}

	data, err := json.Marshal(msg)
	if err != nil {
		return nil, err
	}
	if err := s.redisMsg.Append(ctx, roomID.String(), msgID, createdAt, data); err != nil {
		return nil, err
	}

	event := &roomEvents.RoomMessageCreatedEvent{
		Room: &roomEvents.RoomBrief{ID: room.ID.String(), Name: room.Name, ImageURL: room.ImageURL},
		Message: &roomEvents.RoomMessageData{
			ID:           msg.ID,
			RoomID:       msg.RoomID,
			SenderID:     msg.SenderID,
			SenderName:   msg.SenderName,
			SenderAvatar: msg.SenderAvatar,
			Content:      msg.Content,
			CreatedAt:    msg.CreatedAt,
		},
	}
	if err := s.producer.PublishRoomMessageCreated(ctx, event); err != nil {
		s.logger.Errorw("Failed to publish room message created", "room_id", roomID, "message_id", msgID, "error", err)
	}
	return &msg, nil
}

func (s *Service) DeleteMessage(ctx context.Context, userID, roomID uuid.UUID, messageID string) error {
	if _, err := s.getRoom(roomID); err != nil {
		return err
	}

	data, err := s.redisMsg.Get(ctx, roomID.String(), messageID)
	if err != nil {
		return err
	}
	if data == nil {
		return errors.New("message not found")
	}

	var existing RoomMessageResponse
	if err := json.Unmarshal(data, &existing); err != nil {
		return err
	}
	if existing.SenderID != userID.String() {
		return errors.New("you can only delete your own messages")
	}

	if err := s.redisMsg.Delete(ctx, roomID.String(), messageID); err != nil {
		return err
	}

	if err := s.producer.PublishRoomMessageDeleted(ctx, &roomEvents.RoomMessageDeletedEvent{
		RoomID:    roomID.String(),
		MessageID: messageID,
	}); err != nil {
		s.logger.Errorw("Failed to publish room message deleted", "room_id", roomID, "message_id", messageID, "error", err)
	}
	return nil
}

func (s *Service) GetMessages(ctx context.Context, roomID uuid.UUID, limit int, beforeID string) (*RoomMessagesListResponse, error) {
	room, err := s.getRoom(roomID)
	if err != nil {
		return nil, err
	}
	if !room.Enabled {
		return nil, errors.New("room is disabled")
	}

	raws, err := s.redisMsg.List(ctx, roomID.String(), limit, beforeID)
	if err != nil {
		return nil, err
	}

	items := make([]RoomMessageResponse, 0, len(raws))
	for _, raw := range raws {
		var m RoomMessageResponse
		if err := json.Unmarshal(raw, &m); err != nil {
			continue
		}
		items = append(items, m)
	}

	resp := &RoomMessagesListResponse{Items: items, HasMore: len(raws) == limit}
	if len(items) > 0 {
		resp.NextBefore = items[len(items)-1].ID
	}
	return resp, nil
}

func (s *Service) RoomEnabled(roomID string) (bool, error) {
	id, err := uuid.Parse(roomID)
	if err != nil {
		return false, errors.New("invalid room id")
	}
	room, err := s.getRoom(id)
	if err != nil {
		return false, err
	}
	return room.Enabled, nil
}

func (s *Service) senderInfo(userID uuid.UUID) (string, string) {
	u, err := s.userCache.GetUserCache(userID, true)
	if err != nil || u == nil {
		return "", ""
	}
	name := u.FullName
	if name == "" {
		name = u.Username
	}
	return name, u.Avatar
}

func (s *Service) getRoom(id uuid.UUID) (*models.Room, error) {
	room, err := s.repo.GetByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("room not found")
		}
		return nil, err
	}
	return room, nil
}

func (s *Service) buildList(ctx context.Context, rooms []*models.Room, total int64, limit, offset int) *RoomListResponse {
	ids := make([]string, 0, len(rooms))
	for _, room := range rooms {
		ids = append(ids, room.ID.String())
	}
	counts := s.wsServer.GetRoomPresence().MemberCounts(ctx, ids)

	items := make([]RoomResponse, 0, len(rooms))
	for _, room := range rooms {
		items = append(items, *toRoomResponse(room, counts[room.ID.String()]))
	}
	return &RoomListResponse{Items: items, Total: total, Limit: limit, Offset: offset}
}

func toRoomResponse(room *models.Room, memberCount int) *RoomResponse {
	return &RoomResponse{
		ID:          room.ID.String(),
		Name:        room.Name,
		Description: room.Description,
		ImageURL:    room.ImageURL,
		MaxMembers:  room.MaxMembers,
		MemberCount: memberCount,
		Enabled:     room.Enabled,
		CreatedBy:   room.CreatedBy.String(),
		CreatedAt:   room.CreatedAt.UTC().Format(time.RFC3339),
	}
}
