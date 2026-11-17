package sociallimit

import (
	"context"
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
)

type PostKind string

const (
	PostKindMe     PostKind = "ME"
	PostKindMoment PostKind = "MOMENT"
)

var dailyCountScript = redis.NewScript(`
local used = redis.call('INCR', KEYS[1])
if used == 1 then
	redis.call('PEXPIRE', KEYS[1], ARGV[2])
end
local limit = tonumber(ARGV[1])
if limit > 0 and used > limit then
	redis.call('DECR', KEYS[1])
	return 0
end
return 1
`)

type postLimitSource interface {
	GetMePostLimit() (setting.PostLimitConfig, error)
	GetMomentPostLimit() (setting.PostLimitConfig, error)
}

func postLimitCode(kind PostKind) string {
	if kind == PostKindMoment {
		return ErrorCodeDailyMomentPostLimit
	}
	return ErrorCodeDailyMePostLimit
}

// An unreadable setting still yields the defaults, so posting keeps a limit instead of becoming unlimited.
func (s *Service) postLimit(kind PostKind) setting.PostLimitConfig {
	var (
		cfg setting.PostLimitConfig
		err error
	)
	if kind == PostKindMoment {
		cfg, err = s.posts.GetMomentPostLimit()
	} else {
		cfg, err = s.posts.GetMePostLimit()
	}
	if err != nil {
		s.logger.Warnw("load post limit config failed, using defaults", "kind", kind, "error", err)
	}
	return cfg
}

func (s *Service) ConsumePost(ctx context.Context, userID uuid.UUID, kind PostKind) (func(), error) {
	if s == nil || s.posts == nil || s.cache == nil {
		return noop, nil
	}
	cfg := s.postLimit(kind)
	vip := s.isVip(userID)
	limit := cfg.PerDay(vip)
	key := postKey(kind, userID, quotaDay(time.Now()))
	allowed, err := dailyCountScript.Run(ctx, s.cache.GetClient(), []string{key}, limit, CacheTTLDaily.Milliseconds()).Int()
	if err != nil {
		s.logger.Warnw("post limit check failed, allowing", "key", key, "error", err)
		return noop, nil
	}
	if allowed != 1 {
		s.logger.Infow("Daily post limit reached", "user_id", userID, "kind", kind, "limit", limit, "vip", vip)
		return noop, HTTPError(&LimitError{
			Code:       postLimitCode(kind),
			Limit:      limit,
			Vip:        vip,
			Upgradable: !vip && cfg.VipRaisesLimit(),
		})
	}
	return s.refund(ctx, key, func(refundCtx context.Context) error {
		return s.cache.GetClient().Decr(refundCtx, key).Err()
	}), nil
}

func postKey(kind PostKind, userID uuid.UUID, day string) string {
	return fmt.Sprintf(CacheKeyPosts, kind, userID.String(), day)
}

func (s *Service) PostQuotas(ctx context.Context, userID uuid.UUID) PostQuotaResponse {
	if s == nil || s.posts == nil || s.cache == nil {
		return PostQuotaResponse{}
	}
	vip := s.isVip(userID)
	day := quotaDay(time.Now())
	return PostQuotaResponse{
		IsVip:  vip,
		Me:     s.postQuota(ctx, userID, PostKindMe, vip, day),
		Moment: s.postQuota(ctx, userID, PostKindMoment, vip, day),
	}
}

func (s *Service) postQuota(ctx context.Context, userID uuid.UUID, kind PostKind, vip bool, day string) PostQuota {
	cfg := s.postLimit(kind)
	quota := PostQuota{Limit: cfg.PerDay(vip), Upgradable: !vip && cfg.VipRaisesLimit()}
	key := postKey(kind, userID, day)
	used, err := s.cache.GetClient().Get(ctx, key).Int()
	if err != nil && !errors.Is(err, redis.Nil) {
		s.logger.Warnw("read post limit usage failed", "key", key, "error", err)
	}
	quota.Used = used
	return quota
}
