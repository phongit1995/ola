package room

import (
	roomEvents "ola-chat-server/internal/domain/room"
	"ola-chat-server/internal/models"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/kafka"
	"context"
	"errors"
	"time"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo          *Repository
	msgRepo       *MessageRepository
	userCache     *userModule.CacheService
	kafkaProducer *kafka.Producer
	logger        *zap.SugaredLogger
}

func NewService(repo *Repository, msgRepo *MessageRepository, userCache *userModule.CacheService, kafkaProducer *kafka.Producer, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:          repo,
		msgRepo:       msgRepo,
		userCache:     userCache,
		kafkaProducer: kafkaProducer,
		logger:        logger.Named("[room_service]"),
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
	return toRoomResponse(room, false), nil
}

func (s *Service) Update(id uuid.UUID, req *UpdateRoomRequest) (*RoomResponse, error) {
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
	return toRoomResponse(room, false), nil
}

func (s *Service) Delete(id uuid.UUID) error {
	if _, err := s.getRoom(id); err != nil {
		return err
	}
	return s.repo.SoftDelete(id)
}

func (s *Service) ListAdmin(query string, limit, offset int) (*RoomListResponse, error) {
	rooms, total, err := s.repo.ListAll(query, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(rooms, total, limit, offset, uuid.Nil), nil
}

func (s *Service) ListPublic(userID uuid.UUID, query string, limit, offset int) (*RoomListResponse, error) {
	rooms, total, err := s.repo.ListPublic(query, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(rooms, total, limit, offset, userID), nil
}

func (s *Service) GetByID(userID, id uuid.UUID) (*RoomResponse, error) {
	room, err := s.getRoom(id)
	if err != nil {
		return nil, err
	}
	isMember, _ := s.repo.IsMember(id, userID)
	return toRoomResponse(room, isMember), nil
}

func (s *Service) Join(userID, roomID uuid.UUID) (*RoomResponse, error) {
	room, err := s.getRoom(roomID)
	if err != nil {
		return nil, err
	}
	if !room.Enabled {
		return nil, errors.New("room is disabled")
	}

	already, err := s.repo.IsMember(roomID, userID)
	if err != nil {
		return nil, err
	}
	if !already {
		if room.MaxMembers > 0 && room.MemberCount >= room.MaxMembers {
			return nil, errors.New("room is full")
		}
		if _, err := s.repo.AddMember(roomID, userID); err != nil {
			return nil, err
		}
		room.MemberCount++
		s.logger.Infow("User joined room", "room_id", roomID, "user_id", userID)
	}
	return toRoomResponse(room, true), nil
}

func (s *Service) Leave(userID, roomID uuid.UUID) error {
	if _, err := s.getRoom(roomID); err != nil {
		return err
	}
	if _, err := s.repo.RemoveMember(roomID, userID); err != nil {
		return err
	}
	s.logger.Infow("User left room", "room_id", roomID, "user_id", userID)
	return nil
}

func (s *Service) ListMembers(roomID uuid.UUID, limit, offset int) (*RoomMembersResponse, error) {
	if _, err := s.getRoom(roomID); err != nil {
		return nil, err
	}
	rows, total, err := s.repo.ListMembers(roomID, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]RoomMemberResponse, 0, len(rows))
	for _, m := range rows {
		items = append(items, RoomMemberResponse{
			UserID:   m.UserID.String(),
			Username: m.Username,
			FullName: m.FullName,
			Avatar:   m.Avatar,
			JoinedAt: m.JoinedAt.UTC().Format(time.RFC3339),
		})
	}
	return &RoomMembersResponse{Items: items, Total: total}, nil
}

func (s *Service) SendMessage(ctx context.Context, userID, roomID uuid.UUID, req *SendRoomMessageRequest) (*RoomMessageResponse, error) {
	room, err := s.getRoom(roomID)
	if err != nil {
		return nil, err
	}
	if !room.Enabled {
		return nil, errors.New("room is disabled")
	}

	isMember, err := s.repo.IsMember(roomID, userID)
	if err != nil {
		return nil, err
	}
	if !isMember {
		return nil, errors.New("not a room member")
	}

	senderName, senderAvatar := s.senderInfo(userID)
	messageID := gocql.TimeUUID()
	createdAt := time.Now().UTC()

	if err := s.msgRepo.CreateMessage(roomID, messageID, userID, senderName, senderAvatar, req.Content, createdAt); err != nil {
		return nil, err
	}

	resp := &RoomMessageResponse{
		ID:           messageID.String(),
		RoomID:       roomID.String(),
		SenderID:     userID.String(),
		SenderName:   senderName,
		SenderAvatar: senderAvatar,
		Content:      req.Content,
		CreatedAt:    createdAt.Format(time.RFC3339),
	}

	s.publishMessage(ctx, room, resp)
	return resp, nil
}

func (s *Service) GetMessages(userID, roomID uuid.UUID, limit int, beforeStr string) (*RoomMessagesListResponse, error) {
	if _, err := s.getRoom(roomID); err != nil {
		return nil, err
	}
	isMember, err := s.repo.IsMember(roomID, userID)
	if err != nil {
		return nil, err
	}
	if !isMember {
		return nil, errors.New("not a room member")
	}

	var before *gocql.UUID
	if beforeStr != "" {
		parsed, err := gocql.ParseUUID(beforeStr)
		if err != nil {
			return nil, errors.New("invalid before cursor")
		}
		before = &parsed
	}

	rows, err := s.msgRepo.GetMessages(roomID, limit, before)
	if err != nil {
		return nil, err
	}

	items := make([]RoomMessageResponse, 0, len(rows))
	for _, m := range rows {
		items = append(items, RoomMessageResponse{
			ID:           m.MessageID.String(),
			RoomID:       roomID.String(),
			SenderID:     m.SenderID.String(),
			SenderName:   m.SenderName,
			SenderAvatar: m.SenderAvatar,
			Content:      m.Content,
			CreatedAt:    m.CreatedAt.UTC().Format(time.RFC3339),
		})
	}

	resp := &RoomMessagesListResponse{Items: items, HasMore: len(rows) == limit}
	if len(items) > 0 {
		resp.NextBefore = items[len(items)-1].ID
	}
	return resp, nil
}

func (s *Service) publishMessage(ctx context.Context, room *models.Room, msg *RoomMessageResponse) {
	memberIDs, err := s.repo.MemberIDs(room.ID)
	if err != nil {
		s.logger.Errorw("Failed to load room members for emit", "room_id", room.ID, "error", err)
		return
	}
	ids := make([]string, 0, len(memberIDs))
	for _, id := range memberIDs {
		ids = append(ids, id.String())
	}

	event := &roomEvents.RoomMessageCreatedEvent{
		Room: &roomEvents.RoomData{ID: room.ID.String(), Name: room.Name, ImageURL: room.ImageURL},
		Message: &roomEvents.RoomMessageData{
			ID:           msg.ID,
			RoomID:       msg.RoomID,
			SenderID:     msg.SenderID,
			SenderName:   msg.SenderName,
			SenderAvatar: msg.SenderAvatar,
			Content:      msg.Content,
			CreatedAt:    msg.CreatedAt,
		},
		MemberIDs: ids,
	}
	if err := s.kafkaProducer.PublishRoomMessageCreated(ctx, event); err != nil {
		s.logger.Errorw("Failed to publish room message", "room_id", room.ID, "error", err)
	}
}

func (s *Service) senderInfo(userID uuid.UUID) (string, string) {
	u, err := s.userCache.GetUser(userID)
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

func (s *Service) buildList(rooms []*models.Room, total int64, limit, offset int, userID uuid.UUID) *RoomListResponse {
	memberSet := map[uuid.UUID]bool{}
	if userID != uuid.Nil {
		for _, room := range rooms {
			if ok, _ := s.repo.IsMember(room.ID, userID); ok {
				memberSet[room.ID] = true
			}
		}
	}
	items := make([]RoomResponse, 0, len(rooms))
	for _, room := range rooms {
		items = append(items, *toRoomResponse(room, memberSet[room.ID]))
	}
	return &RoomListResponse{Items: items, Total: total, Limit: limit, Offset: offset}
}

func toRoomResponse(room *models.Room, isMember bool) *RoomResponse {
	return &RoomResponse{
		ID:          room.ID.String(),
		Name:        room.Name,
		Description: room.Description,
		ImageURL:    room.ImageURL,
		MaxMembers:  room.MaxMembers,
		MemberCount: room.MemberCount,
		Enabled:     room.Enabled,
		CreatedBy:   room.CreatedBy.String(),
		CreatedAt:   room.CreatedAt.UTC().Format(time.RFC3339),
		IsMember:    isMember,
	}
}
