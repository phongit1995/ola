package pushbroadcast

import (
	"context"
	"encoding/json"
	"errors"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/push"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

const broadcastTimeout = 30 * time.Minute

type EventHandler struct {
	db     *gorm.DB
	sender *push.Sender
	logger *zap.SugaredLogger
}

func NewEventHandler(db *gorm.DB, sender *push.Sender, logger *zap.SugaredLogger) *EventHandler {
	return &EventHandler{db: db, sender: sender, logger: logger.Named("[push_broadcast_events]")}
}

func (h *EventHandler) OnRequested(ctx context.Context, message []byte) error {
	var event Event
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal PushBroadcast", "error", err)
		return err
	}
	campaignID, err := uuid.Parse(event.CampaignID)
	if err != nil {
		return errors.New("invalid campaign id")
	}

	now := time.Now()
	claim := h.db.WithContext(ctx).Model(&models.PushCampaign{}).
		Where("id = ? AND status = ?", campaignID, PushCampaignStatusQueued).
		Updates(map[string]interface{}{"status": PushCampaignStatusSending, "started_at": now})
	if claim.Error != nil {
		return claim.Error
	}
	if claim.RowsAffected == 0 {
		h.logger.Infow("Push campaign already claimed, skipping", "campaign_id", campaignID)
		return nil
	}

	var campaign models.PushCampaign
	if err := h.db.WithContext(ctx).First(&campaign, "id = ?", campaignID).Error; err != nil {
		return err
	}
	utils.SafeGo(h.logger, func() { h.run(campaign) })
	return nil
}

func (h *EventHandler) run(campaign models.PushCampaign) {
	ctx, cancel := context.WithTimeout(context.Background(), broadcastTimeout)
	defer cancel()

	req := push.BroadcastRequest{
		CampaignID:   campaign.ID.String(),
		Audience:     campaign.Audience,
		TargetUserID: campaign.TargetUserID,
		Title:        campaign.Title,
		Body:         campaign.Body,
	}
	progress, err := h.sender.Broadcast(ctx, req, func(p push.BroadcastProgress) {
		h.updateCounts(campaign.ID, p, nil)
	})

	final := map[string]interface{}{
		"status":      PushCampaignStatusDone,
		"finished_at": time.Now(),
	}
	switch {
	case err != nil:
		final["status"] = PushCampaignStatusFailed
		final["error"] = err.Error()
	case progress.Devices > 0 && progress.Success == 0:
		final["status"] = PushCampaignStatusFailed
		final["error"] = "no device accepted the push"
	}
	h.updateCounts(campaign.ID, progress, final)
	h.logger.Infow("Push campaign finished", "campaign_id", campaign.ID, "status", final["status"], "devices", progress.Devices, "success", progress.Success, "failure", progress.Failure)
}

func (h *EventHandler) updateCounts(campaignID uuid.UUID, progress push.BroadcastProgress, extra map[string]interface{}) {
	updates := map[string]interface{}{
		"total_devices": progress.Devices,
		"success_count": progress.Success,
		"failure_count": progress.Failure,
	}
	for key, value := range extra {
		updates[key] = value
	}
	if err := h.db.Model(&models.PushCampaign{}).Where("id = ?", campaignID).Updates(updates).Error; err != nil {
		h.logger.Warnw("Failed to update push campaign progress", "campaign_id", campaignID, "error", err)
	}
}
