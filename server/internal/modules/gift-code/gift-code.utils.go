package giftcode

import (
	"crypto/rand"
	"fmt"
	"math/big"
	"strings"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
)

func NormalizeCode(raw string) string {
	return strings.ToUpper(strings.Join(strings.Fields(raw), ""))
}

func IsCodeInput(code string) bool {
	if code == "" || len(code) > CodeMaxLength {
		return false
	}
	for _, r := range code {
		if !(r >= 'A' && r <= 'Z') && !(r >= '0' && r <= '9') && r != '-' {
			return false
		}
	}
	return true
}

func GenerateCode(prefix string, length int) (string, error) {
	max := big.NewInt(int64(len(CodeAlphabet)))
	var b strings.Builder
	b.Grow(len(prefix) + length)
	b.WriteString(prefix)
	for i := 0; i < length; i++ {
		n, err := rand.Int(rand.Reader, max)
		if err != nil {
			return "", err
		}
		b.WriteByte(CodeAlphabet[n.Int64()])
	}
	return b.String(), nil
}

func CampaignStatus(c *models.GiftCodeCampaign, now time.Time) string {
	switch {
	case !c.Enabled:
		return StatusOff
	case c.StartsAt != nil && now.Before(*c.StartsAt):
		return StatusScheduled
	case !now.Before(c.EndsAt):
		return StatusExpired
	case c.UsedCount >= c.TotalUses:
		return StatusSoldOut
	default:
		return StatusRunning
	}
}

func PlatformAllowed(c *models.GiftCodeCampaign, platform string) bool {
	switch platform {
	case setting.PlatformAndroid:
		return c.AllowAndroid
	case setting.PlatformIOS:
		return c.AllowIOS
	default:
		return c.AllowWeb
	}
}

func RewardsText(rewards models.GiftCodeRewards) string {
	days := 0
	icons := 0
	for _, r := range rewards {
		switch r.Type {
		case models.GiftCodeRewardVipDays:
			days += r.Days
		case models.GiftCodeRewardVipIcon:
			icons++
		}
	}
	parts := make([]string, 0, 2)
	if days > 0 {
		parts = append(parts, fmt.Sprintf("%d ngày VIP", days))
	}
	switch {
	case icons == 1:
		parts = append(parts, "icon VIP")
	case icons > 1:
		parts = append(parts, fmt.Sprintf("%d icon VIP", icons))
	}
	return strings.Join(parts, RewardTextJoiner)
}

func SuccessMessage(template string, rewards models.GiftCodeRewards) string {
	message := strings.TrimSpace(template)
	if message == "" {
		message = DefaultSuccessMessage
	}
	return strings.ReplaceAll(message, RewardPlaceholder, RewardsText(rewards))
}
