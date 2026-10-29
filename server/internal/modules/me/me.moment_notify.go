package me

import (
	"fmt"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

func (s *Service) MomentCommented(ownerID, actorID, momentID uuid.UUID, content string) {
	if ownerID == actorID {
		return
	}
	utils.SafeGo(s.logger, func() {
		notif, err := s.repo.CreateMomentCommentNotification(ownerID, actorID, momentID, excerptText(content))
		if err != nil {
			s.logger.Warnw("Failed to create moment comment notification", "recipient_id", ownerID, "moment_id", momentID, "error", err.Error())
			return
		}
		if notif != nil {
			s.publishMeNotification(ownerID, notif)
		}
	})
}

func (s *Service) MomentReacted(ownerID, actorID, momentID uuid.UUID, reaction string) {
	if ownerID == actorID {
		return
	}
	utils.SafeGo(s.logger, func() {
		notif, err := s.repo.UpsertMomentReactionNotification(ownerID, actorID, momentID, reaction)
		if err != nil {
			s.logger.Warnw("Failed to upsert moment reaction notification", "recipient_id", ownerID, "moment_id", momentID, "error", err.Error())
			return
		}
		if notif != nil {
			s.publishMeNotificationEvent(ownerID, notif, !s.allowMomentReactionPush(ownerID, momentID))
		}
	})
}

func (s *Service) MomentDeleted(momentID uuid.UUID) {
	utils.SafeGo(s.logger, func() {
		removed, err := s.repo.DeleteMeNotificationsByMoment(momentID)
		if err != nil {
			s.logger.Warnw("Failed to cleanup moment notifications", "moment_id", momentID, "error", err.Error())
			return
		}
		for _, n := range removed {
			s.publishMeNotificationRemoval(n.RecipientID, n.ID)
		}
	})
}

func (s *Service) allowMomentReactionPush(ownerID, momentID uuid.UUID) bool {
	if s.cache == nil {
		return true
	}
	key := fmt.Sprintf(CacheKeyMeNotifPushGuard, models.MeNotificationMomentReaction, ownerID.String(), momentID.String())
	acquired, err := s.cache.SetNX(key, "1", time.Duration(MeNotifPushGuardTTLSeconds)*time.Second)
	if err != nil {
		return true
	}
	return acquired
}
