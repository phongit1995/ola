package megaphone

import (
	"encoding/json"
	"fmt"
	"strings"
	"time"

	megaphoneEvents "ola-chat-server/internal/domain/megaphone"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

type LuckyReward struct {
	Label     string
	KenAmount *int
	VipDays   *int
	VipTypeID *int16
}

func (r LuckyReward) Text() string {
	if r.KenAmount != nil && *r.KenAmount > 0 {
		return models.GroupThousands(*r.KenAmount) + " Ken"
	}
	if label := strings.TrimSpace(r.Label); label != "" {
		return label
	}
	if r.VipDays != nil && *r.VipDays > 0 {
		return fmt.Sprintf("%d ngày VIP", *r.VipDays)
	}
	if r.VipTypeID != nil {
		return fmt.Sprintf("VIP %d", *r.VipTypeID)
	}
	return ""
}

type LuckyAnnouncement struct {
	Client   setting.Client
	Game     string
	PlayID   uuid.UUID
	PlayerID uuid.UUID
	Reward   LuckyReward
}

func luckyContent(game string, reward string) string {
	verb := "vừa đập trứng trúng"
	if game == LuckyGameWheel {
		verb = "vừa quay trúng"
	}
	content := fmt.Sprintf("%s %s 🎉", verb, reward)
	runes := []rune(content)
	if len(runes) > systemContentRunes {
		return string(runes[:systemContentRunes])
	}
	return content
}

func (in LuckyAnnouncement) info() megaphoneEvents.LuckyInfo {
	return megaphoneEvents.LuckyInfo{
		Game:      in.Game,
		Label:     in.Reward.Text(),
		KenAmount: in.Reward.KenAmount,
		VipDays:   in.Reward.VipDays,
		VipTypeID: in.Reward.VipTypeID,
	}
}

func luckyRewardJSONB(info megaphoneEvents.LuckyInfo) models.JSONB {
	raw, err := json.Marshal(info)
	if err != nil {
		return nil
	}
	var out models.JSONB
	if err := json.Unmarshal(raw, &out); err != nil {
		return nil
	}
	return out
}

func luckyInfoFrom(value models.JSONB) *megaphoneEvents.LuckyInfo {
	if len(value) == 0 {
		return nil
	}
	raw, err := json.Marshal(value)
	if err != nil {
		return nil
	}
	var info megaphoneEvents.LuckyInfo
	if err := json.Unmarshal(raw, &info); err != nil {
		return nil
	}
	return &info
}

func (s *Service) AnnounceLuckyLater(in LuckyAnnouncement) {
	time.AfterFunc(luckyAnnounceDelay, func() {
		utils.SafeCall(s.logger, func() { s.AnnounceLucky(in) })
	})
}

func (s *Service) AnnounceLucky(in LuckyAnnouncement) bool {
	reward := in.Reward.Text()
	if reward == "" {
		return false
	}
	cfg := s.config()
	if !cfg.EnabledFor(in.Client) {
		return false
	}
	now := time.Now().UTC()
	record, err := s.repo.CreateSystem(SystemParams{
		Type:            models.MegaphoneTypeLucky,
		SenderID:        in.PlayerID,
		ClientRequestID: luckyRequestPrefix + in.Game + ":" + in.PlayID.String(),
		LuckyReward:     luckyRewardJSONB(in.info()),
		Content:         luckyContent(in.Game, reward),
		Weight:          cfg.MessageWeight,
		DisplaySeconds:  cfg.DisplaySeconds,
		QueueLimit:      cfg.GiftQueueLimit(),
		ExpiresAt:       now.Add(cfg.LiveDuration()),
		Cooldown:        cooldownOf(cfg),
		Now:             now,
	})
	if err != nil {
		s.logger.Errorw("Failed to create lucky megaphone", "game", in.Game, "play_id", in.PlayID, "error", err.Error())
		return false
	}
	if record == nil {
		return false
	}
	s.enqueue(s.ToView(record), record.Weight)
	return true
}
