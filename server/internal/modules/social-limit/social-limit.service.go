package sociallimit

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"sync"
	"time"

	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

var dailyQuotaScript = redis.NewScript(`
if redis.call('SISMEMBER', KEYS[1], ARGV[1]) == 1 then
	return {1, 0}
end
if redis.call('SCARD', KEYS[1]) < tonumber(ARGV[2]) then
	redis.call('SADD', KEYS[1], ARGV[1])
	redis.call('PEXPIRE', KEYS[1], ARGV[3])
	return {1, 1}
end
return {0, 0}
`)

type vipChecker interface {
	HasActiveVip(userID uuid.UUID, now time.Time) (bool, error)
}

type configSource interface {
	GetSocialLimit() (setting.SocialLimitConfig, error)
}

type LimitError struct {
	Code       string
	Limit      int
	Vip        bool
	Upgradable bool
}

func (e *LimitError) Error() string {
	return fmt.Sprintf("daily limit reached (%d per day)", e.Limit)
}

func HTTPError(err error) *utils.HTTPError {
	var limitErr *LimitError
	if !errors.As(err, &limitErr) {
		return nil
	}
	httpErr := utils.NewHTTPErrorWithCode(http.StatusTooManyRequests, limitErr.Error(), limitErr.Code)
	httpErr.Details = map[string]any{"limit": limitErr.Limit, "isVip": limitErr.Vip, "upgradable": limitErr.Upgradable}
	return httpErr
}

type Service struct {
	settings configSource
	posts    postLimitSource
	cache    *services.CacheService
	vip      vipChecker
	logger   *zap.SugaredLogger

	mu       sync.Mutex
	config   setting.SocialLimitConfig
	configAt time.Time
}

func NewService(settings *setting.Service, cache *services.CacheService, repo *Repository, logger *zap.SugaredLogger) *Service {
	svc := newService(settings, cache, repo, logger)
	svc.posts = settings
	return svc
}

func newService(settings configSource, cache *services.CacheService, vip vipChecker, logger *zap.SugaredLogger) *Service {
	return &Service{settings: settings, cache: cache, vip: vip, logger: logger.Named("[social_limit]")}
}

func (s *Service) currentConfig() setting.SocialLimitConfig {
	if s == nil || s.settings == nil {
		cfg := setting.DefaultSocialLimitConfig()
		cfg.Enabled = false
		return cfg
	}
	s.mu.Lock()
	defer s.mu.Unlock()
	if !s.configAt.IsZero() && time.Since(s.configAt) < ConfigTTL {
		return s.config
	}
	cfg, err := s.settings.GetSocialLimit()
	if err != nil {
		s.logger.Warnw("load social_limit config failed", "error", err)
		if !s.configAt.IsZero() {
			return s.config
		}
		return cfg
	}
	s.config, s.configAt = cfg, time.Now()
	return cfg
}

func (s *Service) isVip(userID uuid.UUID) bool {
	if s == nil || s.vip == nil {
		return false
	}
	vip, err := s.vip.HasActiveVip(userID, time.Now())
	if err != nil {
		s.logger.Warnw("check vip failed, using normal limits", "user_id", userID, "error", err)
		return false
	}
	return vip
}

func (s *Service) tier(userID uuid.UUID) (setting.SocialLimitConfig, setting.SocialLimitTier, bool) {
	cfg := s.currentConfig()
	if s.isVip(userID) {
		return cfg, cfg.Vip, true
	}
	return cfg, cfg.Normal, false
}

func (s *Service) FriendCaps(userID uuid.UUID) (maxFriends, maxPending int) {
	_, t, _ := s.tier(userID)
	return t.MaxFriends, t.MaxPendingRequests
}

func (s *Service) ConsumeNewChat(ctx context.Context, userID, targetID uuid.UUID) (func(), error) {
	cfg, t, vip := s.tier(userID)
	if !cfg.Enabled {
		return noop, nil
	}
	return s.consume(ctx, CacheKeyNewChats, &LimitError{
		Code:       ErrorCodeDailyNewChatLimit,
		Limit:      t.NewChatsPerDay,
		Vip:        vip,
		Upgradable: !vip && cfg.Vip.NewChatsPerDay > t.NewChatsPerDay,
	}, userID, targetID)
}

func (s *Service) ConsumeFriendRequest(ctx context.Context, userID, targetID uuid.UUID) (func(), error) {
	cfg, t, vip := s.tier(userID)
	if !cfg.Enabled {
		return noop, nil
	}
	return s.consume(ctx, CacheKeyFriendRequests, &LimitError{
		Code:       ErrorCodeDailyFriendRequestLimit,
		Limit:      t.FriendRequestsPerDay,
		Vip:        vip,
		Upgradable: !vip && cfg.Vip.FriendRequestsPerDay > t.FriendRequestsPerDay,
	}, userID, targetID)
}

func noop() {}

func quotaDay(now time.Time) string {
	return now.UTC().Add(DayUTCOffset * time.Second).Format("20060102")
}

func (s *Service) consume(ctx context.Context, keyFormat string, limitErr *LimitError, userID, targetID uuid.UUID) (func(), error) {
	if s.cache == nil {
		return noop, nil
	}
	key := fmt.Sprintf(keyFormat, userID.String(), quotaDay(time.Now()))
	member := targetID.String()
	result, err := dailyQuotaScript.Run(ctx, s.cache.GetClient(), []string{key},
		member, limitErr.Limit, CacheTTLDaily.Milliseconds(),
	).Int64Slice()
	if err != nil || len(result) != 2 {
		s.logger.Warnw("social limit check failed, allowing", "key", key, "error", err, "result", result)
		return noop, nil
	}
	if result[0] != 1 {
		s.logger.Infow("Daily social limit reached", "user_id", userID, "code", limitErr.Code, "limit", limitErr.Limit, "vip", limitErr.Vip)
		return noop, limitErr
	}
	if result[1] != 1 {
		return noop, nil
	}
	return s.refund(ctx, key, func(refundCtx context.Context) error {
		return s.cache.GetClient().SRem(refundCtx, key, member).Err()
	}), nil
}

func (s *Service) refund(ctx context.Context, key string, undo func(context.Context) error) func() {
	return func() {
		refundCtx, cancel := context.WithTimeout(context.WithoutCancel(ctx), RefundTimeout)
		defer cancel()
		if err := undo(refundCtx); err != nil {
			s.logger.Warnw("refund social limit failed", "key", key, "error", err)
		}
	}
}
