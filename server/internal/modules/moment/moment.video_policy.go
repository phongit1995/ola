package moment

import (
	"fmt"
	"net/http"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var errVideoVipRequired = utils.NewHTTPErrorWithCode(http.StatusForbidden, "only VIP members can post video moments", ErrorCodeMomentVideoVipOnly)

type momentVideoSettings interface {
	GetMomentVideo() (setting.MomentVideoConfig, error)
}

type momentVipUsers interface {
	GetUserCache(userID uuid.UUID, fallbackToDB bool) (*models.User, error)
}

// An unreadable setting falls back to the default (videos open to everyone) rather than blocking every upload.
func checkVideoAllowed(settings momentVideoSettings, users momentVipUsers, userID uuid.UUID, now time.Time, logger *zap.SugaredLogger) error {
	cfg, err := settings.GetMomentVideo()
	if err != nil {
		logger.Warnw("Failed to read moment video setting, allowing video", "error", err)
		return nil
	}
	if !cfg.VipRequired {
		return nil
	}
	user, err := users.GetUserCache(userID, true)
	if err != nil {
		return fmt.Errorf("failed to check VIP status: %w", err)
	}
	if user == nil || !user.HasActiveVip(now) {
		return errVideoVipRequired
	}
	return nil
}
