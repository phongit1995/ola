package kenchest

import (
	"context"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/utils"

	"go.uber.org/zap"
)

type Scheduler struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewScheduler(service *Service, logger *zap.SugaredLogger) *Scheduler {
	return &Scheduler{service: service, logger: logger.Named("[ken_chest_scheduler]")}
}

func (s *Scheduler) Start(ctx context.Context) {
	utils.SafeGo(s.logger, func() { s.loop(ctx) })
}

func (s *Scheduler) loop(ctx context.Context) {
	maxSleep := time.Duration(constants.KenChestAutoMaxSleepSeconds) * time.Second
	for {
		sleep := s.computeSleep(maxSleep)
		if sleep < time.Second {
			sleep = time.Second
		}
		select {
		case <-ctx.Done():
			return
		case <-time.After(sleep):
		}
		s.service.RunDueAutoJobs(ctx)
	}
}

func (s *Scheduler) computeSleep(maxSleep time.Duration) time.Duration {
	if !s.service.MasterEnabled() {
		return maxSleep
	}
	hasJob, earliest, err := s.service.EarliestEnabledNextRun()
	if err != nil {
		s.logger.Warnw("Failed to read earliest ken chest job", "error", err.Error())
		return maxSleep
	}
	if !hasJob {
		return maxSleep
	}
	if earliest == nil {
		return 0
	}
	d := time.Until(*earliest)
	if d < 0 {
		d = 0
	}
	if d > maxSleep {
		d = maxSleep
	}
	return d
}
