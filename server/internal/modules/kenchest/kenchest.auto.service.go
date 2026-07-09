package kenchest

import (
	"context"
	"errors"
	"strings"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

var ErrInvalidSchedule = errors.New("invalid ken chest auto schedule configuration")

func (s *Service) ListAutoJobs() ([]AutoJobView, error) {
	jobs, err := s.repo.ListAutoJobs()
	if err != nil {
		return nil, err
	}
	items := make([]AutoJobView, len(jobs))
	for i := range jobs {
		items[i] = toAutoJobView(&jobs[i])
	}
	return items, nil
}

func (s *Service) CreateAutoJob(adminID uuid.UUID, req AutoJobRequest) (*AutoJobView, error) {
	if err := validateAndNormalizeAutoJob(&req); err != nil {
		return nil, err
	}
	job := requestToAutoJob(req)
	job.CreatedBy = &adminID
	s.assignNextRun(&job)
	if err := s.repo.CreateAutoJob(&job); err != nil {
		return nil, err
	}
	view := toAutoJobView(&job)
	return &view, nil
}

func (s *Service) UpdateAutoJob(id uuid.UUID, req AutoJobRequest) (*AutoJobView, error) {
	if err := validateAndNormalizeAutoJob(&req); err != nil {
		return nil, err
	}
	job, err := s.repo.FindAutoJobByID(id)
	if err != nil {
		return nil, ErrChestNotFound
	}
	updated := requestToAutoJob(req)
	updated.ID = job.ID
	updated.CreatedBy = job.CreatedBy
	updated.CreatedAt = job.CreatedAt
	updated.LastRunAt = job.LastRunAt
	updated.RunCount = job.RunCount
	s.assignNextRun(&updated)
	if err := s.repo.UpdateAutoJob(&updated); err != nil {
		return nil, err
	}
	view := toAutoJobView(&updated)
	return &view, nil
}

func (s *Service) DeleteAutoJob(id uuid.UUID) error {
	return s.repo.DeleteAutoJob(id)
}

func (s *Service) GetAutoSettings() (*AutoSettingsView, error) {
	settings, err := s.repo.GetAutoSettings()
	if err != nil {
		return nil, err
	}
	return &AutoSettingsView{Enabled: settings.Enabled, UpdatedAt: settings.UpdatedAt}, nil
}

func (s *Service) UpdateAutoSettings(adminID uuid.UUID, enabled bool) (*AutoSettingsView, error) {
	if err := s.repo.UpdateAutoSettings(enabled, &adminID); err != nil {
		return nil, err
	}
	return s.GetAutoSettings()
}

func (s *Service) EarliestEnabledNextRun() (bool, *time.Time, error) {
	return s.repo.EarliestEnabledNextRun()
}

func (s *Service) MasterEnabled() bool {
	settings, err := s.repo.GetAutoSettings()
	if err != nil {
		s.logger.Warnw("Failed to read ken chest auto settings", "error", err.Error())
		return false
	}
	return settings.Enabled
}

func (s *Service) RunDueAutoJobs(ctx context.Context) {
	if !s.MasterEnabled() {
		return
	}
	now := time.Now().UTC()
	jobs, err := s.repo.ListEnabledDueJobs(now)
	if err != nil {
		s.logger.Warnw("Failed to list due ken chest jobs", "error", err.Error())
		return
	}
	for i := range jobs {
		job := jobs[i]
		next := s.computeNext(&job, now)
		if next == nil {
			continue
		}
		claimed, err := s.repo.ClaimDueJob(job.ID, job.NextRunAt, *next, now)
		if err != nil {
			s.logger.Warnw("Failed to claim ken chest job", "job_id", job.ID, "error", err.Error())
			continue
		}
		if !claimed {
			continue
		}
		req := CreateChestRequest{
			RewardMode:      string(job.RewardMode),
			KenAmount:       job.KenAmount,
			KenMin:          job.KenMin,
			KenMax:          job.KenMax,
			MaxRecipients:   job.MaxRecipients,
			DurationSeconds: job.DurationSeconds,
		}
		if _, err := s.createChest(ctx, nil, req, models.KenChestSourceAuto, &job.ID); err != nil {
			s.logger.Errorw("Failed to auto-create ken chest", "job_id", job.ID, "error", err.Error())
		}
	}
}

func (s *Service) assignNextRun(job *models.KenChestAutoJob) {
	if job.Enabled {
		job.NextRunAt = s.computeNext(job, time.Now().UTC())
	} else {
		job.NextRunAt = nil
	}
}

func (s *Service) computeNext(job *models.KenChestAutoJob, from time.Time) *time.Time {
	switch job.ScheduleType {
	case models.KenChestScheduleInterval:
		lo, hi := 1, 1
		if job.IntervalMinMinutes != nil {
			lo = *job.IntervalMinMinutes
		}
		if job.IntervalMaxMinutes != nil {
			hi = *job.IntervalMaxMinutes
		}
		if hi < lo {
			hi = lo
		}
		mins := lo
		if hi > lo {
			mins = lo + int(utils.CryptoFloat()*float64(hi-lo+1))
		}
		if mins < 1 {
			mins = 1
		}
		next := from.Add(time.Duration(mins) * time.Minute)
		return &next
	case models.KenChestScheduleDaily:
		return nextDaily(job.DailyTimes, from)
	}
	return nil
}

func nextDaily(times models.DailyTimes, from time.Time) *time.Time {
	loc := time.FixedZone("ICT", 7*3600)
	fromLocal := from.In(loc)
	var best *time.Time
	for _, hhmm := range times {
		t, err := time.Parse("15:04", strings.TrimSpace(hhmm))
		if err != nil {
			continue
		}
		candidate := time.Date(fromLocal.Year(), fromLocal.Month(), fromLocal.Day(), t.Hour(), t.Minute(), 0, 0, loc)
		if !candidate.After(fromLocal) {
			candidate = candidate.Add(24 * time.Hour)
		}
		utc := candidate.UTC()
		if best == nil || utc.Before(*best) {
			b := utc
			best = &b
		}
	}
	return best
}

func validateAndNormalizeAutoJob(req *AutoJobRequest) error {
	reward := CreateChestRequest{
		RewardMode:      req.RewardMode,
		KenAmount:       req.KenAmount,
		KenMin:          req.KenMin,
		KenMax:          req.KenMax,
		MaxRecipients:   req.MaxRecipients,
		DurationSeconds: req.DurationSeconds,
	}
	if err := normalizeAndValidate(&reward); err != nil {
		return err
	}
	req.KenAmount = reward.KenAmount
	req.KenMin = reward.KenMin
	req.KenMax = reward.KenMax
	req.DurationSeconds = reward.DurationSeconds

	if req.RemainingRuns != nil && *req.RemainingRuns <= 0 {
		req.RemainingRuns = nil
	}

	switch req.ScheduleType {
	case string(models.KenChestScheduleInterval):
		if req.IntervalMinMinutes == nil || req.IntervalMaxMinutes == nil ||
			*req.IntervalMinMinutes <= 0 || *req.IntervalMaxMinutes < *req.IntervalMinMinutes {
			return ErrInvalidSchedule
		}
		req.DailyTimes = nil
	case string(models.KenChestScheduleDaily):
		if len(req.DailyTimes) == 0 {
			return ErrInvalidSchedule
		}
		for _, hhmm := range req.DailyTimes {
			if _, err := time.Parse("15:04", strings.TrimSpace(hhmm)); err != nil {
				return ErrInvalidSchedule
			}
		}
		req.IntervalMinMinutes = nil
		req.IntervalMaxMinutes = nil
	default:
		return ErrInvalidSchedule
	}
	return nil
}

func requestToAutoJob(req AutoJobRequest) models.KenChestAutoJob {
	return models.KenChestAutoJob{
		Name:               req.Name,
		Enabled:            req.Enabled,
		ScheduleType:       models.KenChestScheduleType(req.ScheduleType),
		IntervalMinMinutes: req.IntervalMinMinutes,
		IntervalMaxMinutes: req.IntervalMaxMinutes,
		DailyTimes:         models.DailyTimes(req.DailyTimes),
		RewardMode:         models.KenChestRewardMode(req.RewardMode),
		KenAmount:          req.KenAmount,
		KenMin:             req.KenMin,
		KenMax:             req.KenMax,
		MaxRecipients:      req.MaxRecipients,
		DurationSeconds:    req.DurationSeconds,
		RemainingRuns:      req.RemainingRuns,
	}
}

func toAutoJobView(j *models.KenChestAutoJob) AutoJobView {
	return AutoJobView{
		ID:                 j.ID,
		Name:               j.Name,
		Enabled:            j.Enabled,
		ScheduleType:       string(j.ScheduleType),
		IntervalMinMinutes: j.IntervalMinMinutes,
		IntervalMaxMinutes: j.IntervalMaxMinutes,
		DailyTimes:         []string(j.DailyTimes),
		RewardMode:         string(j.RewardMode),
		KenAmount:          j.KenAmount,
		KenMin:             j.KenMin,
		KenMax:             j.KenMax,
		MaxRecipients:      j.MaxRecipients,
		DurationSeconds:    j.DurationSeconds,
		RemainingRuns:      j.RemainingRuns,
		RunCount:           j.RunCount,
		NextRunAt:          j.NextRunAt,
		LastRunAt:          j.LastRunAt,
		CreatedAt:          j.CreatedAt,
	}
}
