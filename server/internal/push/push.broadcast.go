package push

import (
	"context"
	"errors"
	"time"

	"firebase.google.com/go/v4/messaging"
	"github.com/google/uuid"
	"gorm.io/gorm"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
)

var ErrPushUnavailable = errors.New("push notifications are disabled or firebase is not configured")

type BroadcastRequest struct {
	CampaignID   string
	Audience     string
	TargetUserID *uuid.UUID
	Title        string
	Body         string
}

type BroadcastProgress struct {
	Devices int
	Success int
	Failure int
}

func BroadcastTokens(db *gorm.DB, audience string, targetUserID *uuid.UUID) *gorm.DB {
	query := db.Model(&models.DeviceToken{}).
		Joins("JOIN user_sessions ON user_sessions.id = device_tokens.session_id AND user_sessions.revoked_at IS NULL").
		Joins("JOIN users ON users.id = device_tokens.user_id AND users.deleted_at IS NULL AND users.is_active").
		Where("device_tokens.platform IN ?", []string{constants.PushPlatformAndroid, constants.PushPlatformIOS})
	switch audience {
	case constants.PushAudienceVIP:
		return query.Where("users.vip_end_time > ?", time.Now())
	case constants.PushAudienceUser:
		if targetUserID == nil {
			return query.Where("1 = 0")
		}
		return query.Where("device_tokens.user_id = ?", *targetUserID)
	default:
		return query
	}
}

func (s *Sender) Broadcast(ctx context.Context, req BroadcastRequest, onBatch func(BroadcastProgress)) (BroadcastProgress, error) {
	var progress BroadcastProgress
	if s.fcm == nil || !s.fcm.Enabled() || !s.store.PushEnabled() {
		return progress, ErrPushUnavailable
	}

	content := Content{
		Title:    req.Title,
		Body:     req.Body,
		NotifID:  constants.PushBroadcastNotifID(req.CampaignID),
		Channel:  constants.PushChannelSystem,
		Collapse: constants.PushCollapseBroadcast,
	}
	ttl := constants.PushTTLHours * time.Hour
	afterID := uuid.Nil

	for {
		if err := ctx.Err(); err != nil {
			return progress, err
		}

		var tokens []models.DeviceToken
		err := BroadcastTokens(s.db.WithContext(ctx), req.Audience, req.TargetUserID).
			Select("device_tokens.*").
			Where("device_tokens.id > ?", afterID).
			Order("device_tokens.id").
			Limit(constants.PushSendBatchSize).
			Find(&tokens).Error
		if err != nil {
			return progress, err
		}
		if len(tokens) == 0 {
			return progress, nil
		}
		afterID = tokens[len(tokens)-1].ID

		msgs := make([]*messaging.Message, 0, len(tokens))
		for _, token := range tokens {
			msgs = append(msgs, buildMessage(token, content, broadcastData(content, token.UserID.String()), ttl))
		}
		success, failure, _ := s.sendInChunks(content.NotifID, constants.PushSourceBroadcast, tokens, msgs)
		progress.Devices += len(tokens)
		progress.Success += success
		progress.Failure += failure
		if onBatch != nil {
			onBatch(progress)
		}

		if len(tokens) < constants.PushSendBatchSize {
			return progress, nil
		}
	}
}

func broadcastData(content Content, ownerID string) map[string]string {
	return map[string]string{
		"notifId": content.NotifID,
		"channel": content.Channel,
		"title":   content.Title,
		"body":    content.Body,
		"ownerId": ownerID,
		"type":    constants.PushDataTypeBroadcast,
	}
}
