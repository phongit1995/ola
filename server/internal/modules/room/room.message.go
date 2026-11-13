package room

import (
	"context"
	"encoding/json"
	"errors"
	"time"

	"ola-chat-server/internal/constants"
	roomEvents "ola-chat-server/internal/domain/room"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

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

	sender, _ := s.userCache.GetUserCache(userID, true)
	senderName, senderAvatar, senderGender, senderVip, senderVipEnd := senderFields(sender)
	msgID := uuid.New().String()
	createdAt := time.Now().UTC()
	createdAtStr := createdAt.Format(time.RFC3339)

	replyTo := s.resolveReplySnapshot(ctx, roomID.String(), req.ReplyToID)

	stored := storedRoomMessage{
		ID:        msgID,
		RoomID:    roomID.String(),
		SenderID:  userID.String(),
		Type:      constants.MessageTypeText,
		Content:   req.Content,
		CreatedAt: createdAtStr,
		ReplyTo:   replyTo,
	}
	data, err := json.Marshal(stored)
	if err != nil {
		return nil, err
	}
	if err := s.redisMsg.Append(ctx, roomID.String(), msgID, createdAt, data); err != nil {
		return nil, err
	}

	msg := RoomMessageResponse{
		ID:           msgID,
		RoomID:       roomID.String(),
		SenderID:     userID.String(),
		SenderName:   senderName,
		SenderAvatar: senderAvatar,
		SenderGender: senderGender,
		SenderVip:    senderVip,
		SenderVipEnd: senderVipEnd,
		Type:         constants.MessageTypeText,
		Content:      req.Content,
		CreatedAt:    createdAtStr,
		ReplyTo:      replyTo,
	}

	event := &roomEvents.RoomMessageCreatedEvent{
		Room: &roomEvents.RoomBrief{ID: room.ID.String(), Name: room.Name, ImageURL: room.ImageURL},
		Message: &roomEvents.RoomMessageData{
			ID:           msg.ID,
			RoomID:       msg.RoomID,
			SenderID:     msg.SenderID,
			SenderName:   msg.SenderName,
			SenderAvatar: msg.SenderAvatar,
			SenderGender: msg.SenderGender,
			SenderVip:    msg.SenderVip,
			SenderVipEnd: msg.SenderVipEnd,
			Type:         msg.Type,
			Content:      msg.Content,
			ImageURL:     msg.ImageURL,
			CreatedAt:    msg.CreatedAt,
			ReplyTo:      toEventReplySnapshot(replyTo),
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

func (s *Service) DeleteMessageAdmin(ctx context.Context, roomID uuid.UUID, messageID string) error {
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
	return s.fetchMessages(ctx, roomID, limit, beforeID)
}

func (s *Service) GetMessagesAdmin(ctx context.Context, roomID uuid.UUID, limit int, beforeID string) (*RoomMessagesListResponse, error) {
	if _, err := s.getRoom(roomID); err != nil {
		return nil, err
	}
	return s.fetchMessages(ctx, roomID, limit, beforeID)
}

func (s *Service) fetchMessages(ctx context.Context, roomID uuid.UUID, limit int, beforeID string) (*RoomMessagesListResponse, error) {
	raws, err := s.redisMsg.List(ctx, roomID.String(), limit, beforeID)
	if err != nil {
		return nil, err
	}

	stored := make([]storedRoomMessage, 0, len(raws))
	idSet := make(map[uuid.UUID]struct{})
	for _, raw := range raws {
		var m storedRoomMessage
		if err := json.Unmarshal(raw, &m); err != nil {
			continue
		}
		stored = append(stored, m)
		if uid, err := uuid.Parse(m.SenderID); err == nil {
			idSet[uid] = struct{}{}
		}
	}

	ids := make([]uuid.UUID, 0, len(idSet))
	for id := range idSet {
		ids = append(ids, id)
	}
	users := s.userCache.GetUsersBatch(ids, true)

	items := make([]RoomMessageResponse, 0, len(stored))
	for _, m := range stored {
		var sender *models.User
		if uid, err := uuid.Parse(m.SenderID); err == nil {
			sender = users[uid]
		}
		items = append(items, *toRoomMessageResponse(m, sender))
	}

	resp := &RoomMessagesListResponse{Items: items, HasMore: len(raws) == limit}
	if len(items) > 0 {
		resp.NextBefore = items[len(items)-1].ID
	}
	return resp, nil
}

func (s *Service) resolveReplySnapshot(ctx context.Context, roomID, replyToID string) *RoomReplySnapshot {
	if replyToID == "" {
		return nil
	}
	data, err := s.redisMsg.Get(ctx, roomID, replyToID)
	if err != nil || data == nil {
		return nil
	}
	var orig storedRoomMessage
	if err := json.Unmarshal(data, &orig); err != nil {
		return nil
	}
	snapshot := &RoomReplySnapshot{
		MessageID: orig.ID,
		SenderID:  orig.SenderID,
		Excerpt:   utils.TruncateRunes(orig.Content, RoomReplyExcerptMaxRunes),
		Type:      orig.Type,
		ImageURL:  orig.ImageURL,
	}
	if senderUUID, err := uuid.Parse(orig.SenderID); err == nil {
		if sender, _ := s.userCache.GetUserCache(senderUUID, true); sender != nil {
			snapshot.SenderName = sender.Username
		}
	}
	return snapshot
}

func toEventReplySnapshot(snapshot *RoomReplySnapshot) *roomEvents.RoomReplySnapshot {
	if snapshot == nil {
		return nil
	}
	return &roomEvents.RoomReplySnapshot{
		MessageID:  snapshot.MessageID,
		SenderID:   snapshot.SenderID,
		SenderName: snapshot.SenderName,
		Excerpt:    snapshot.Excerpt,
		Type:       snapshot.Type,
		ImageURL:   snapshot.ImageURL,
	}
}

func toRoomMessageResponse(stored storedRoomMessage, sender *models.User) *RoomMessageResponse {
	senderName, senderAvatar, senderGender, senderVip, senderVipEnd := senderFields(sender)
	return &RoomMessageResponse{
		ID:            stored.ID,
		RoomID:        stored.RoomID,
		SenderID:      stored.SenderID,
		SenderName:    senderName,
		SenderAvatar:  senderAvatar,
		SenderGender:  senderGender,
		SenderVip:     senderVip,
		SenderVipEnd:  senderVipEnd,
		Type:          stored.Type,
		Content:       stored.Content,
		ImageURL:      stored.ImageURL,
		AudioURL:      stored.AudioURL,
		AudioDuration: stored.AudioDuration,
		AudioWaveform: stored.AudioWaveform,
		AudioMimeType: stored.AudioMimeType,
		AudioSize:     stored.AudioSize,
		CreatedAt:     stored.CreatedAt,
		ReplyTo:       stored.ReplyTo,
		Reactions:     stored.Reactions,
		ClientMsgID:   stored.ClientMsgID,
	}
}

func senderFields(u *models.User) (name, avatar, gender string, vip, vipEnd *string) {
	if u == nil {
		return "", "", "", nil, nil
	}
	name = u.Username
	gender = u.Gender
	vip = u.VipUsed
	if u.VipEndTime != nil {
		formatted := u.VipEndTime.Format(time.RFC3339)
		vipEnd = &formatted
	}
	return name, u.Avatar, gender, vip, vipEnd
}
