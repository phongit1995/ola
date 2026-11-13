package message

import (
	"fmt"
	"time"

	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
)

func (s *Service) GetMessages(userID, conversationID uuid.UUID, limit int, beforeMessageID *string) (*MessagesListResponse, error) {
	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to get members: %w", err)
	}

	if !isActiveMember(members, userID) {
		return nil, ErrNotMember
	}

	var beforeTimeuuid *gocql.UUID
	if beforeMessageID != nil && *beforeMessageID != "" {
		parsed, err := gocql.ParseUUID(*beforeMessageID)
		if err != nil {
			return nil, fmt.Errorf("invalid beforeMessageID: %w", err)
		}
		beforeTimeuuid = &parsed
	}

	raws, exhausted, fromCache, err := s.fetchRawMessages(conversationID, limit, beforeTimeuuid)
	if err != nil {
		return nil, fmt.Errorf("failed to get messages: %w", err)
	}
	if !fromCache && beforeTimeuuid == nil && len(raws) > 0 {
		cacheRaws := raws
		utils.SafeGo(s.logger, func() {
			if err := s.cache.SetConversationMessages(conversationID, cacheRaws, exhausted); err != nil {
				s.logger.Warnw("Failed to cache messages", "conversation_id", conversationID, "error", err)
			}
		})
	}

	if marker, markerErr := s.convCache.GetClearedMarkerCached(userID, conversationID); markerErr != nil {
		s.logger.Warnw("Failed to get cleared marker", "user_id", userID, "conversation_id", conversationID, "error", markerErr)
	} else if marker != nil {
		markerTime := marker.Time()
		cut := len(raws)
		for i, msg := range raws {
			if !msg.MessageID.Time().After(markerTime) {
				cut = i
				break
			}
		}
		if cut < len(raws) {
			raws = raws[:cut]
			exhausted = true
		}
	}

	visible := make([]Message, 0, limit)
	for _, msg := range raws {
		if msg.DeletedAt == nil {
			visible = append(visible, msg)
		}
	}

	hasMore := !exhausted
	nextBefore := ""
	if len(visible) > limit {
		visible = visible[:limit]
		hasMore = true
		nextBefore = visible[limit-1].MessageID.String()
	} else if len(raws) > 0 {
		nextBefore = raws[len(raws)-1].MessageID.String()
	}
	if !hasMore {
		nextBefore = ""
	}

	senderIDSet := make(map[uuid.UUID]struct{}, len(visible))
	for _, msg := range visible {
		senderIDSet[msg.SenderID] = struct{}{}
	}
	senderIDs := make([]uuid.UUID, 0, len(senderIDSet))
	for id := range senderIDSet {
		senderIDs = append(senderIDs, id)
	}
	senders := s.userCache.GetUsersBatch(senderIDs, false)

	responses := make([]MessageResponse, 0, len(visible))
	for _, msg := range visible {
		senderName := msg.SenderName
		senderAvatar := msg.SenderAvatar
		if u, ok := senders[msg.SenderID]; ok && u != nil {
			senderName = u.Username
			senderAvatar = u.Avatar
		}

		resp := MessageResponse{
			ID:             msg.MessageID.String(),
			ConversationID: msg.ConversationID.String(),
			SenderID:       msg.SenderID.String(),
			SenderName:     senderName,
			SenderAvatar:   senderAvatar,
			Type:           msg.MessageType,
			Content:        msg.Content,
			Metadata:       msg.Metadata,
			Status:         "sent",
			CreatedAt:      msg.CreatedAt.Format(time.RFC3339),
			UpdatedAt:      msg.UpdatedAt.Format(time.RFC3339),
			Reactions:      parseReactions(msg.Reactions),
		}

		if msg.EditedAt != nil {
			resp.EditedAt = msg.EditedAt.Format(time.RFC3339)
		}

		if msg.ReplyToID != nil {
			resp.ReplyToID = msg.ReplyToID.String()
			resp.ReplyTo = parseReplySnapshot(msg.ReplySnapshot)
		}

		responses = append(responses, resp)
	}

	return &MessagesListResponse{
		Messages:   responses,
		Total:      len(responses),
		HasMore:    hasMore,
		NextBefore: nextBefore,
	}, nil
}

const messageFetchMaxRounds = 3

func (s *Service) fetchRawMessages(conversationID uuid.UUID, limit int, before *gocql.UUID) ([]Message, bool, bool, error) {
	if before == nil {
		cached, exhausted, err := s.cache.GetConversationMessages(conversationID)
		if err == nil && (exhausted || countVisibleMessages(cached) >= limit) {
			s.logger.Debugw("Cache HIT for messages", "conversation_id", conversationID)
			return cached, exhausted, true, nil
		}
	}

	s.logger.Debugw("Cache MISS for messages", "conversation_id", conversationID)
	rawLimit := limit * 2
	var raws []Message
	cursor := before
	for round := 0; round < messageFetchMaxRounds; round++ {
		batch, err := s.repo.GetMessages(conversationID, rawLimit, cursor)
		if err != nil {
			return nil, false, false, err
		}
		raws = append(raws, batch...)
		if len(batch) < rawLimit {
			return raws, true, false, nil
		}
		if countVisibleMessages(raws) >= limit {
			return raws, false, false, nil
		}
		last := batch[len(batch)-1].MessageID
		cursor = &last
	}
	return raws, false, false, nil
}

func countVisibleMessages(messages []Message) int {
	count := 0
	for _, msg := range messages {
		if msg.DeletedAt == nil {
			count++
		}
	}
	return count
}
