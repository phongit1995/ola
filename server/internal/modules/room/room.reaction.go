package room

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"slices"

	"ola-chat-server/internal/constants"
	roomEvents "ola-chat-server/internal/domain/room"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func (s *Service) ToggleReaction(ctx context.Context, userID, roomID uuid.UUID, messageID, reactionType string) (*RoomMessageResponse, error) {
	if !slices.Contains(constants.AllowedReactionTypes, reactionType) {
		return nil, fmt.Errorf("invalid reaction type: %s", reactionType)
	}
	if _, err := uuid.Parse(messageID); err != nil {
		return nil, errors.New("invalid message id")
	}

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

	sender := s.mediaSender()
	if !sender.AllowReaction(userID) {
		return nil, errRoomTooManyRequests
	}
	actor, _ := s.userCache.GetUserCache(userID, true)
	actorUsername := ""
	if actor != nil {
		actorUsername = actor.Username
	}

	lockToken := uuid.NewString()
	lockKey, err := sender.LockReaction(messageID, lockToken)
	if err != nil {
		return nil, err
	}
	lockReleased := false
	releaseLock := func() {
		if lockReleased {
			return
		}
		lockReleased = true
		if _, err := s.cache.DeleteIfValue(lockKey, lockToken); err != nil {
			s.logger.Warnw("Failed to release room reaction lock", "message_id", messageID, "error", err)
		}
	}
	defer releaseLock()

	data, err := s.redisMsg.Get(ctx, roomID.String(), messageID)
	if err != nil {
		return nil, err
	}
	if data == nil {
		return nil, errors.New("message not found")
	}
	var stored storedRoomMessage
	if err := json.Unmarshal(data, &stored); err != nil {
		return nil, err
	}

	if stored.Reactions == nil {
		stored.Reactions = map[string][]RoomReactor{}
	}
	action := applyRoomReactionReplace(stored.Reactions, reactionType, RoomReactor{UserID: userID.String(), Username: actorUsername})
	if len(stored.Reactions) == 0 {
		stored.Reactions = nil
	}

	updated, err := json.Marshal(stored)
	if err != nil {
		return nil, err
	}
	if err := s.redisMsg.Update(ctx, roomID.String(), messageID, updated); err != nil {
		return nil, err
	}
	releaseLock()

	if err := s.producer.PublishRoomMessageReactionUpdated(ctx, &roomEvents.RoomMessageReactionUpdatedEvent{
		RoomID:        roomID.String(),
		MessageID:     messageID,
		Reactions:     toEventReactions(stored.Reactions),
		ActorUserID:   userID.String(),
		ActorUsername: actorUsername,
		Type:          reactionType,
		Action:        action,
	}); err != nil {
		s.logger.Errorw("Failed to publish room reaction updated", "room_id", roomID, "message_id", messageID, "error", err)
	}

	var msgSender *models.User
	if senderUUID, err := uuid.Parse(stored.SenderID); err == nil {
		msgSender, _ = s.userCache.GetUserCache(senderUUID, true)
	}
	return toRoomMessageResponse(stored, msgSender), nil
}

func applyRoomReactionReplace(reactions map[string][]RoomReactor, reactionType string, reactor RoomReactor) string {
	hadSameType := false
	for t, users := range reactions {
		filtered := make([]RoomReactor, 0, len(users))
		for _, u := range users {
			if u.UserID == reactor.UserID {
				if t == reactionType {
					hadSameType = true
				}
				continue
			}
			filtered = append(filtered, u)
		}
		if len(filtered) == 0 {
			delete(reactions, t)
		} else {
			reactions[t] = filtered
		}
	}
	if hadSameType {
		return constants.ReactionActionRemoved
	}
	reactions[reactionType] = append(reactions[reactionType], reactor)
	return constants.ReactionActionAdded
}

func toEventReactions(reactions map[string][]RoomReactor) map[string][]roomEvents.RoomReactor {
	out := map[string][]roomEvents.RoomReactor{}
	for t, users := range reactions {
		converted := make([]roomEvents.RoomReactor, 0, len(users))
		for _, u := range users {
			converted = append(converted, roomEvents.RoomReactor{UserID: u.UserID, Username: u.Username})
		}
		out[t] = converted
	}
	return out
}
