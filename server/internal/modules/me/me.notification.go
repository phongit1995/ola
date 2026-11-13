package me

import (
	"context"
	"encoding/json"
	"fmt"
	"regexp"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	meNotificationEvents "ola-chat-server/internal/domain/me-notification"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

func (s *Service) ListNotifications(recipientID uuid.UUID, cursor string, limit int) (*MeNotificationListResponse, error) {
	cursorTime, cursorID, err := utils.DecodeTimeCursor(cursor)
	if err != nil {
		return nil, err
	}

	items, hasMore, err := s.repo.ListMeNotificationsPage(recipientID, cursorTime, cursorID, limit)
	if err != nil {
		return nil, err
	}
	unread, err := s.repo.CountUnreadMeNotifications(recipientID)
	if err != nil {
		return nil, err
	}

	out := make([]MeNotificationResponse, 0, len(items))
	for _, it := range items {
		out = append(out, toMeNotificationResponse(it))
	}

	var nextCursor string
	if hasMore && len(items) > 0 {
		last := items[len(items)-1]
		nextCursor = utils.EncodeTimeCursor(last.CreatedAt, last.ID)
	}

	return &MeNotificationListResponse{
		Items:       out,
		UnreadCount: unread,
		NextCursor:  nextCursor,
	}, nil
}

func (s *Service) UnreadNotificationCount(recipientID uuid.UUID) (int64, error) {
	return s.repo.CountUnreadMeNotifications(recipientID)
}

func (s *Service) MarkAllNotificationsRead(recipientID uuid.UUID) error {
	if err := s.repo.MarkAllMeNotificationsRead(recipientID); err != nil {
		return err
	}
	if s.cache == nil {
		return nil
	}
	if err := s.cache.Delete(constants.PushPendingKey(recipientID.String(), constants.PushSourceMeNotif)); err != nil {
		s.logger.Warnw("Failed to clear pending me push", "recipient_id", recipientID, "error", err)
	}
	return nil
}

func (s *Service) createMeNotification(recipientID, actorID uuid.UUID, ntype string, postID uuid.UUID, commentID *uuid.UUID, preview string) {
	if recipientID == actorID {
		return
	}
	utils.SafeGo(s.logger, func() {
		n := &models.MeNotification{
			RecipientID: recipientID,
			ActorID:     actorID,
			Type:        ntype,
			PostID:      postID,
			CommentID:   commentID,
			Preview:     preview,
		}
		created, err := s.repo.CreateMeNotification(n)
		if err != nil {
			s.logger.Warnw("Failed to create me notification", "recipient_id", recipientID, "type", ntype, "error", err.Error())
			return
		}
		if !s.allowMeNotificationPush(ntype, actorID, postID, commentID) {
			return
		}
		s.publishMeNotification(recipientID, created)
	})
}

func (s *Service) allowMeNotificationPush(ntype string, actorID, postID uuid.UUID, commentID *uuid.UUID) bool {
	if ntype != models.MeNotificationLike && ntype != models.MeNotificationCommentLike {
		return true
	}
	if s.cache == nil {
		return true
	}
	entityID := postID.String()
	if commentID != nil {
		entityID = commentID.String()
	}
	key := fmt.Sprintf(CacheKeyMeNotifPushGuard, ntype, actorID.String(), entityID)
	acquired, err := s.cache.SetNX(key, "1", time.Duration(MeNotifPushGuardTTLSeconds)*time.Second)
	if err != nil {
		return true
	}
	return acquired
}

func (s *Service) removeMeNotification(recipientID, actorID uuid.UUID, ntype string, postID uuid.UUID, commentID *uuid.UUID) {
	if recipientID == actorID {
		return
	}
	utils.SafeGo(s.logger, func() {
		removed, err := s.repo.DeleteMeNotification(recipientID, actorID, ntype, postID, commentID)
		if err != nil {
			s.logger.Warnw("Failed to remove me notification", "recipient_id", recipientID, "type", ntype, "error", err.Error())
			return
		}
		if removed == nil {
			return
		}
		s.publishMeNotificationRemoval(recipientID, removed.ID)
	})
}

func (s *Service) cleanupCommentNotifications(commentID uuid.UUID) {
	utils.SafeGo(s.logger, func() {
		removed, err := s.repo.DeleteMeNotificationsByComment(commentID)
		if err != nil {
			s.logger.Warnw("Failed to cleanup comment notifications", "comment_id", commentID, "error", err.Error())
			return
		}
		for _, n := range removed {
			s.publishMeNotificationRemoval(n.RecipientID, n.ID)
		}
	})
}

func (s *Service) publishMeNotificationRemoval(recipientID, notificationID uuid.UUID) {
	if s.kafkaProducer == nil {
		return
	}
	unread, err := s.repo.CountUnreadMeNotifications(recipientID)
	if err != nil {
		s.logger.Warnw("Failed to count unread me notifications", "recipient_id", recipientID, "error", err.Error())
		return
	}
	event := &meNotificationEvents.Event{
		RecipientID: recipientID.String(),
		RemovedID:   notificationID.String(),
		UnreadCount: unread,
	}
	utils.PublishAsync(s.logger, "me notification removal", func(ctx context.Context) error {
		return s.kafkaProducer.PublishMeNotification(ctx, event)
	})
}

func (s *Service) publishMeNotification(recipientID uuid.UUID, notif *models.MeNotification) {
	s.publishMeNotificationEvent(recipientID, notif, false)
}

func (s *Service) publishMeNotificationEvent(recipientID uuid.UUID, notif *models.MeNotification, skipPush bool) {
	if s.kafkaProducer == nil {
		return
	}
	unread, err := s.repo.CountUnreadMeNotifications(recipientID)
	if err != nil {
		s.logger.Warnw("Failed to count unread me notifications", "recipient_id", recipientID, "error", err.Error())
		return
	}
	notifBytes, err := json.Marshal(toMeNotificationResponse(notif))
	if err != nil {
		s.logger.Warnw("Failed to marshal me notification", "recipient_id", recipientID, "error", err.Error())
		return
	}
	event := &meNotificationEvents.Event{
		RecipientID:  recipientID.String(),
		Notification: notifBytes,
		UnreadCount:  unread,
		SkipPush:     skipPush,
	}
	utils.PublishAsync(s.logger, "me notification", func(ctx context.Context) error {
		return s.kafkaProducer.PublishMeNotification(ctx, event)
	})
}

var mentionPattern = regexp.MustCompile(`@([A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9])`)

func parseMentionUsernames(content string) []string {
	matches := mentionPattern.FindAllStringSubmatch(content, -1)
	seen := make(map[string]bool, len(matches))
	names := make([]string, 0, len(matches))
	for _, match := range matches {
		name := strings.ToLower(match[1])
		if !seen[name] {
			seen[name] = true
			names = append(names, name)
		}
	}
	return names
}

func (s *Service) notifyMentions(authorID, postID uuid.UUID, mentions models.MentionIDs, preview string) {
	for _, idStr := range mentions {
		mentionedID, err := uuid.Parse(idStr)
		if err != nil {
			continue
		}
		s.createMeNotification(mentionedID, authorID, models.MeNotificationMention, postID, nil, preview)
	}
}

func (s *Service) notifyCommentMentions(actorID, directRecipient uuid.UUID, postID, commentID uuid.UUID, content string) {
	for _, idStr := range s.resolveMentions(content) {
		mentionedID, err := uuid.Parse(idStr)
		if err != nil || mentionedID == directRecipient {
			continue
		}
		s.createMeNotification(mentionedID, actorID, models.MeNotificationMention, postID, &commentID, excerptText(content))
	}
}

func addedMentions(old, current models.MentionIDs) models.MentionIDs {
	existing := make(map[string]bool, len(old))
	for _, id := range old {
		existing[id] = true
	}
	added := make(models.MentionIDs, 0, len(current))
	for _, id := range current {
		if !existing[id] {
			added = append(added, id)
		}
	}
	return added
}

func (s *Service) resolveMentions(content string) models.MentionIDs {
	names := parseMentionUsernames(content)
	if len(names) == 0 {
		return nil
	}
	idMap, err := s.repo.FindUserIDsByUsernames(names)
	if err != nil {
		s.logger.Warnw("failed to resolve mentions", "error", err)
		return nil
	}
	if len(idMap) == 0 {
		return nil
	}
	ids := make(models.MentionIDs, 0, len(idMap))
	for _, id := range idMap {
		ids = append(ids, id.String())
	}
	return ids
}

func toMeNotificationResponse(n *models.MeNotification) MeNotificationResponse {
	resp := MeNotificationResponse{
		ID:        n.ID.String(),
		Type:      n.Type,
		Actor:     toAuthorResponse(n.Actor),
		PostID:    n.PostID.String(),
		Preview:   n.Preview,
		IsRead:    n.IsRead,
		CreatedAt: n.CreatedAt.UTC().Format(time.RFC3339),
	}
	if n.CommentID != nil {
		resp.CommentID = n.CommentID.String()
	}
	if n.Type == models.MeNotificationMomentReaction {
		resp.ActorCount = n.ActorCount
	}
	return resp
}

func excerptText(s string) string {
	s = strings.TrimSpace(s)
	runes := []rune(s)
	if len(runes) <= 120 {
		return s
	}
	return string(runes[:120]) + "…"
}
