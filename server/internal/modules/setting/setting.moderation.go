package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"

	"ola-chat-server/internal/models"
)

const (
	KeyModeration = "moderation"

	ModerationPointsMin   = 1
	ModerationPointsMax   = 20
	ModerationHoursMax    = 24 * 365 * 10
	ModerationLockStepMax = 5

	moderationDeliberatePointsDefault = 3
)

type ModerationLockStep struct {
	Points int `json:"points"`
	Hours  int `json:"hours"`
}

func (s ModerationLockStep) Permanent() bool {
	return s.Hours == 0
}

type ModerationConfig struct {
	DeliberatePoints int                  `json:"deliberatePoints"`
	ExpireHours      int                  `json:"expireHours"`
	LockSteps        []ModerationLockStep `json:"lockSteps"`
}

func DefaultModerationConfig() ModerationConfig {
	return ModerationConfig{
		DeliberatePoints: moderationDeliberatePointsDefault,
		LockSteps: []ModerationLockStep{
			{Points: 2, Hours: 12},
			{Points: 3, Hours: 0},
		},
	}
}

func (c ModerationConfig) Threshold() int {
	return c.LockSteps[len(c.LockSteps)-1].Points
}

func (c ModerationConfig) StepReached(total int) (ModerationLockStep, bool) {
	var reached ModerationLockStep
	found := false
	for _, step := range c.LockSteps {
		if total >= step.Points {
			reached, found = step, true
		}
	}
	return reached, found
}

func (c ModerationConfig) NextStep(total int) (ModerationLockStep, bool) {
	for _, step := range c.LockSteps {
		if step.Points > total {
			return step, true
		}
	}
	return ModerationLockStep{}, false
}

func (c ModerationConfig) validate() error {
	if c.DeliberatePoints < ModerationPointsMin || c.DeliberatePoints > ModerationPointsMax {
		return fmt.Errorf("điểm cố tình vi phạm phải từ %d đến %d", ModerationPointsMin, ModerationPointsMax)
	}
	if c.ExpireHours < 0 || c.ExpireHours > ModerationHoursMax {
		return fmt.Errorf("thời gian hết hạn vi phạm phải từ 0 đến %d giờ", ModerationHoursMax)
	}
	if len(c.LockSteps) == 0 || len(c.LockSteps) > ModerationLockStepMax {
		return fmt.Errorf("cần từ 1 đến %d mốc khoá", ModerationLockStepMax)
	}
	previous := 0
	for i, step := range c.LockSteps {
		if step.Points < ModerationPointsMin || step.Points > ModerationPointsMax {
			return fmt.Errorf("điểm của mốc khoá phải từ %d đến %d", ModerationPointsMin, ModerationPointsMax)
		}
		if step.Points <= previous {
			return errors.New("điểm của các mốc khoá phải tăng dần")
		}
		if step.Hours < 0 || step.Hours > ModerationHoursMax {
			return fmt.Errorf("thời gian khoá phải từ 0 đến %d giờ", ModerationHoursMax)
		}
		if step.Permanent() && i != len(c.LockSteps)-1 {
			return errors.New("mốc khoá vĩnh viễn phải là mốc cuối cùng")
		}
		previous = step.Points
	}
	return nil
}

func (s *Service) GetModeration() (ModerationConfig, error) {
	cfg := DefaultModerationConfig()
	if err := s.getInto(KeyModeration, &cfg); err != nil {
		return DefaultModerationConfig(), err
	}
	if err := cfg.validate(); err != nil {
		s.logger.Warnw("Invalid moderation config in app_settings, using default", "error", err)
		return DefaultModerationConfig(), nil
	}
	return cfg, nil
}

func ValidateModerationValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid moderation config")
	}
	var in struct {
		DeliberatePoints *int                  `json:"deliberatePoints"`
		ExpireHours      *int                  `json:"expireHours"`
		LockSteps        *[]ModerationLockStep `json:"lockSteps"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&in); err != nil {
		return errors.New("invalid moderation config: " + err.Error())
	}
	if in.DeliberatePoints == nil || in.ExpireHours == nil || in.LockSteps == nil {
		return errors.New("cấu hình xử lý vi phạm cần đủ deliberatePoints, expireHours và lockSteps")
	}
	return ModerationConfig{
		DeliberatePoints: *in.DeliberatePoints,
		ExpireHours:      *in.ExpireHours,
		LockSteps:        *in.LockSteps,
	}.validate()
}
