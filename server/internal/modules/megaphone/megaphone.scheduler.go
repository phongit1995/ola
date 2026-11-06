package megaphone

import (
	"context"
	"time"

	megaphoneEvents "ola-chat-server/internal/domain/megaphone"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Scheduler struct {
	service       *Service
	cache         *services.CacheService
	lastReconcile time.Time
	logger        *zap.SugaredLogger
}

func NewScheduler(service *Service, cache *services.CacheService, logger *zap.SugaredLogger) *Scheduler {
	return &Scheduler{service: service, cache: cache, logger: logger.Named("[megaphone_scheduler]")}
}

func (s *Scheduler) Start(ctx context.Context) {
	utils.SafeGo(s.logger, func() { s.loop(ctx) })
}

func (s *Scheduler) loop(ctx context.Context) {
	ticker := time.NewTicker(schedulerTick)
	defer ticker.Stop()
	for {
		select {
		case <-ctx.Done():
			return
		case <-ticker.C:
		case <-s.service.wake:
		}
		s.tick(ctx)
	}
}

func (s *Scheduler) tick(ctx context.Context) {
	token := uuid.NewString()
	acquired, err := s.cache.SetNX(CacheKeyMegaphoneLock, token, schedulerLockTTL)
	if err != nil {
		s.logger.Warnw("Failed to lock megaphone schedule", "error", err.Error())
		return
	}
	if !acquired {
		return
	}
	defer func() {
		if _, err := s.cache.DeleteIfValue(CacheKeyMegaphoneLock, token); err != nil {
			s.logger.Warnw("Failed to unlock megaphone schedule", "error", err.Error())
		}
	}()

	now := time.Now().UTC()
	if now.Sub(s.lastReconcile) >= reconcileEvery {
		s.reconcile(now)
		s.lastReconcile = now
	}
	cfg := s.service.config()
	if !cfg.Enabled {
		return
	}
	nextSlot, err := s.service.schedule.NextSlot()
	if err != nil {
		s.logger.Warnw("Failed to read megaphone slot", "error", err.Error())
		return
	}
	if now.Before(nextSlot) {
		return
	}
	s.playNext(ctx, cfg, now)
}

func (s *Scheduler) playNext(ctx context.Context, cfg setting.MegaphoneConfig, now time.Time) {
	entries, err := s.service.schedule.Entries()
	if err != nil {
		s.logger.Warnw("Failed to read megaphone schedule", "error", err.Error())
		return
	}
	for _, entry := range entries {
		if entry.expired(now) {
			s.drop(entry.ID)
		}
	}
	index := selectNext(entries, now, cfg.RepeatBaseSeconds)
	if index < 0 {
		return
	}
	s.play(ctx, entries[index], cfg, now)
}

func (s *Scheduler) play(ctx context.Context, entry scheduleEntry, cfg setting.MegaphoneConfig, now time.Time) {
	virtualPass, err := s.service.schedule.VirtualPass()
	if err != nil {
		s.logger.Warnw("Failed to read megaphone pass", "error", err.Error())
		return
	}
	nextSlot := now.Add(time.Duration(entry.Item.Megaphone.DisplaySeconds+cfg.GapSeconds) * time.Second)
	if err := s.service.schedule.SetNextSlot(nextSlot); err != nil {
		s.logger.Warnw("Failed to move megaphone slot", "error", err.Error())
		return
	}
	if err := s.publish(ctx, entry.Item.Megaphone, now); err != nil {
		s.logger.Errorw("Failed to publish megaphone play", "megaphone_id", entry.ID, "error", err.Error())
		return
	}
	if entry.Item.LastPlayedAt == nil {
		s.markPlayed(entry.ID, now)
	}
	pass, virtualPass := advancePass(entry.Pass, virtualPass, cfg.RepeatBaseSeconds, entry.Item.Weight)
	if err := s.service.schedule.RecordPlay(entry, pass, virtualPass, now); err != nil {
		s.logger.Warnw("Failed to record megaphone play", "megaphone_id", entry.ID, "error", err.Error())
	}
}

func (s *Scheduler) publish(ctx context.Context, view megaphoneEvents.Megaphone, now time.Time) error {
	publishCtx, cancel := context.WithTimeout(ctx, publishTimeout)
	defer cancel()
	return s.service.producer.PublishMegaphonePlay(publishCtx, &megaphoneEvents.PlayEvent{Megaphone: view, PlayedAt: now})
}

func (s *Scheduler) markPlayed(id string, at time.Time) {
	parsed, err := uuid.Parse(id)
	if err != nil {
		return
	}
	if err := s.service.repo.MarkPlayed(parsed, at); err != nil {
		s.logger.Warnw("Failed to mark megaphone played, reconcile will retry", "megaphone_id", id, "error", err.Error())
	}
}

func (s *Scheduler) drop(id string) {
	if err := s.service.schedule.Remove(id); err != nil {
		s.logger.Warnw("Failed to drop megaphone from schedule", "megaphone_id", id, "error", err.Error())
	}
}

func (s *Scheduler) reconcile(now time.Time) {
	entries, err := s.service.schedule.Entries()
	if err != nil {
		s.logger.Warnw("Failed to read megaphone schedule for reconcile", "error", err.Error())
		return
	}
	rows, err := s.service.repo.ListSchedulable(now)
	if err != nil {
		s.logger.Warnw("Failed to load megaphones for reconcile", "error", err.Error())
		return
	}
	wanted := make(map[string]*models.Megaphone, len(rows))
	for i := range rows {
		wanted[rows[i].ID.String()] = &rows[i]
	}
	scheduled := make(map[string]bool, len(entries))
	for _, entry := range entries {
		row, ok := wanted[entry.ID]
		if !ok || entry.Item == nil {
			s.drop(entry.ID)
			continue
		}
		scheduled[entry.ID] = true
		if row.FirstPlayedAt == nil && entry.Item.LastPlayedAt != nil {
			s.markPlayed(entry.ID, *entry.Item.LastPlayedAt)
		}
	}
	missing := make([]models.Megaphone, 0)
	for i := range rows {
		if !scheduled[rows[i].ID.String()] {
			missing = append(missing, rows[i])
		}
	}
	if len(missing) == 0 {
		return
	}
	views := s.service.toViews(missing)
	for i := range views {
		item := scheduledItem{Megaphone: views[i], Weight: missing[i].Weight, LastPlayedAt: missing[i].FirstPlayedAt}
		if err := s.service.schedule.Add(item); err != nil {
			s.logger.Warnw("Failed to restore megaphone to schedule", "megaphone_id", views[i].ID, "error", err.Error())
		}
	}
}
