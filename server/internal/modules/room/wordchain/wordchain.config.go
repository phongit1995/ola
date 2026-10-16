package wordchain

import (
	"ola-chat-server/internal/modules/setting"
	userModule "ola-chat-server/internal/modules/user"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Settings interface {
	GetWordChain() (setting.WordChainConfig, error)
}

type Access struct {
	settings  Settings
	userCache *userModule.CacheService
	logger    *zap.SugaredLogger
}

func NewAccess(settings *setting.Service, userCache *userModule.CacheService, logger *zap.SugaredLogger) *Access {
	return &Access{settings: settings, userCache: userCache, logger: logger.Named("[word_chain_access]")}
}

func (a *Access) enabledConfig() (setting.WordChainConfig, error) {
	cfg, err := a.settings.GetWordChain()
	if err != nil {
		a.logger.Warnw("Failed to load word chain settings, keeping the room closed", "error", err)
		return cfg, ErrUnavailable
	}
	if !cfg.Enabled {
		return cfg, ErrDisabled
	}
	return cfg, nil
}

func vipAccess(cfg setting.WordChainConfig, vip bool) (canView, canPlay bool) {
	canView = vip || !cfg.VipRequiredToView
	canPlay = canView && (vip || !cfg.VipRequiredToPlay)
	return canView, canPlay
}

func (a *Access) accessConfig(userID uuid.UUID) (setting.WordChainConfig, bool, error) {
	cfg, err := a.enabledConfig()
	if err != nil {
		return cfg, false, err
	}
	vip := false
	if cfg.VipRequiredToView || cfg.VipRequiredToPlay {
		u, err := a.userCache.GetUserCache(userID, true)
		vip = err == nil && u.HasActiveVip(time.Now())
	}
	canView, canPlay := vipAccess(cfg, vip)
	if !canView {
		return cfg, false, ErrVipToView
	}
	return cfg, canPlay, nil
}

func (a *Access) playConfig(userID uuid.UUID) (setting.WordChainConfig, error) {
	cfg, canPlay, err := a.accessConfig(userID)
	if err == nil && !canPlay {
		err = ErrVipToPlay
	}
	return cfg, err
}

func (a *Access) CanViewWordChain(userID string) error {
	id, err := uuid.Parse(userID)
	if err != nil {
		return err
	}
	_, _, err = a.accessConfig(id)
	return err
}
