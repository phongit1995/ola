package story

import (
	"context"
	"fmt"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
)

var freeReadScript = redis.NewScript(`
if ARGV[1] ~= '' and redis.call('SISMEMBER', KEYS[1], ARGV[1]) == 1 then
	return {1, redis.call('SCARD', KEYS[1]), 0}
end
local used = redis.call('SCARD', KEYS[1])
if ARGV[4] == '1' and used < tonumber(ARGV[2]) then
	redis.call('SADD', KEYS[1], ARGV[1])
	redis.call('PEXPIRE', KEYS[1], ARGV[3])
	return {1, used + 1, 1}
end
return {0, used, 0}
`)

type readGrant struct {
	access    StoryAccessResponse
	allowed   bool
	refundKey string
}

type readingSettings interface {
	GetStoryReading() (setting.StoryReadingConfig, error)
}

type userLookup interface {
	GetUserCache(userID uuid.UUID, fallbackToDB bool) (*models.User, error)
	GetUsersBatch(userIDs []uuid.UUID, fallbackToDB bool) map[uuid.UUID]*models.User
}

func readingDay(now time.Time) string {
	return now.UTC().Add(StoryReadingUTCOffset * time.Second).Format("20060102")
}

func (s *Service) readingConfig() setting.StoryReadingConfig {
	if s.settings == nil {
		cfg := setting.DefaultStoryReadingConfig()
		cfg.Enabled = false
		return cfg
	}
	s.readingMu.Lock()
	defer s.readingMu.Unlock()
	if !s.readingAt.IsZero() && time.Since(s.readingAt) < StoryReadingConfigTTL {
		return s.reading
	}
	cfg, err := s.settings.GetStoryReading()
	if err != nil {
		s.logger.Warnw("load story_reading config failed", "error", err)
		if !s.readingAt.IsZero() {
			return s.reading
		}
		return cfg
	}
	s.reading, s.readingAt = cfg, time.Now()
	return cfg
}

func (s *Service) isVip(userID uuid.UUID) bool {
	if s.users == nil {
		return false
	}
	user, err := s.users.GetUserCache(userID, true)
	if err != nil || user == nil {
		return false
	}
	return user.VipEndTime != nil && user.VipEndTime.After(time.Now())
}

func (s *Service) access(ctx context.Context, viewerID, storyID uuid.UUID, chapterID *uuid.UUID, consume bool) readGrant {
	cfg := s.readingConfig()
	grant := readGrant{
		access: StoryAccessResponse{
			Enabled:         cfg.Enabled,
			FreeLimit:       cfg.FreeChaptersPerDay,
			CommentMinChars: cfg.CommentUnlockMinChars,
		},
		allowed: true,
	}
	if !cfg.Enabled {
		return grant
	}
	if s.isVip(viewerID) {
		grant.access.Vip = true
		return grant
	}
	unlocked, err := s.comments.HasUnlock(ctx, viewerID, storyID)
	if err != nil {
		s.logger.Warnw("check story unlock failed, allowing read", "storyId", storyID, "error", err)
		return grant
	}
	if unlocked {
		grant.access.Unlocked = true
		return grant
	}
	allowed, used, refundKey, err := s.useFreeRead(ctx, viewerID, chapterID, cfg.FreeChaptersPerDay, consume)
	if err != nil {
		s.logger.Warnw("check free reads failed, allowing read", "storyId", storyID, "error", err)
		return grant
	}
	grant.access.FreeUsed = used
	grant.allowed = allowed
	grant.refundKey = refundKey
	return grant
}

func (s *Service) refundFreeRead(ctx context.Context, grant readGrant, chapterID uuid.UUID) {
	if grant.refundKey == "" {
		return
	}
	refundCtx, cancel := context.WithTimeout(context.WithoutCancel(ctx), StoryFreeReadRefundTimeout)
	defer cancel()
	if err := s.cache.GetClient().SRem(refundCtx, grant.refundKey, chapterID.String()).Err(); err != nil {
		s.logger.Warnw("refund free read failed", "chapterId", chapterID, "error", err)
	}
}

func (s *Service) useFreeRead(ctx context.Context, viewerID uuid.UUID, chapterID *uuid.UUID, limit int, consume bool) (bool, int, string, error) {
	if s.cache == nil {
		return true, 0, "", nil
	}
	member, flag := "", "0"
	if chapterID != nil {
		member = chapterID.String()
	}
	if consume && member != "" {
		flag = "1"
	}
	key := fmt.Sprintf(CacheKeyStoryFreeReads, viewerID.String(), readingDay(time.Now()))
	result, err := freeReadScript.Run(ctx, s.cache.GetClient(), []string{key},
		member, limit, StoryFreeReadsTTL.Milliseconds(), flag,
	).Int64Slice()
	if err != nil {
		return false, 0, "", err
	}
	if len(result) != 3 {
		return false, 0, "", fmt.Errorf("unexpected free read result %v", result)
	}
	refundKey := ""
	if result[2] == 1 {
		refundKey = key
	}
	return result[0] == 1, int(result[1]), refundKey, nil
}
