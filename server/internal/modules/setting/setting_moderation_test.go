package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func TestModerationDefaultsLockTwelveHoursThenForever(t *testing.T) {
	cfg := DefaultModerationConfig()
	if cfg.DeliberatePoints != 3 || cfg.ExpireHours != 0 || cfg.Threshold() != 3 {
		t.Fatalf("default config: %+v", cfg)
	}
	if len(cfg.LockSteps) != 2 || cfg.LockSteps[0] != (ModerationLockStep{Points: 2, Hours: 12}) || !cfg.LockSteps[1].Permanent() {
		t.Fatalf("default lock steps: %+v", cfg.LockSteps)
	}
	if err := cfg.validate(); err != nil {
		t.Fatalf("default config invalid: %v", err)
	}
}

func TestModerationStepReachedPicksTheHighestStepReached(t *testing.T) {
	cfg := DefaultModerationConfig()
	cases := []struct {
		total   int
		reached bool
		points  int
	}{
		{0, false, 0},
		{1, false, 0},
		{2, true, 2},
		{3, true, 3},
		{4, true, 3},
		{9, true, 3},
	}
	for _, tc := range cases {
		step, reached := cfg.StepReached(tc.total)
		if reached != tc.reached || (reached && step.Points != tc.points) {
			t.Errorf("%d: got %+v %v", tc.total, step, reached)
		}
	}
	if next, ok := cfg.NextStep(1); !ok || next.Points != 2 {
		t.Errorf("next step after 1: %+v %v", next, ok)
	}
	if _, ok := cfg.NextStep(3); ok {
		t.Error("no step should follow the permanent lock")
	}
}

func TestValidateModerationValue(t *testing.T) {
	step := func(points, hours int) map[string]interface{} {
		return map[string]interface{}{"points": points, "hours": hours}
	}
	valid := []models.JSONB{
		{"deliberatePoints": 3, "expireHours": 0, "lockSteps": []interface{}{step(2, 12), step(3, 0)}},
		{"deliberatePoints": ModerationPointsMax, "expireHours": ModerationHoursMax, "lockSteps": []interface{}{step(ModerationPointsMax, ModerationHoursMax)}},
		{"deliberatePoints": 1, "expireHours": 720, "lockSteps": []interface{}{step(1, 1), step(2, 24), step(3, 168), step(4, 720), step(5, 0)}},
	}
	for _, value := range valid {
		if err := ValidateModerationValue(value); err != nil {
			t.Fatalf("valid config rejected: %v (%v)", value, err)
		}
	}
	invalid := []models.JSONB{
		{"deliberatePoints": 0, "expireHours": 0, "lockSteps": []interface{}{step(3, 0)}},
		{"deliberatePoints": 3, "expireHours": -1, "lockSteps": []interface{}{step(3, 0)}},
		{"deliberatePoints": 3, "expireHours": 0, "lockSteps": []interface{}{}},
		{"deliberatePoints": 3, "expireHours": 0, "lockSteps": []interface{}{step(3, 12), step(2, 0)}},
		{"deliberatePoints": 3, "expireHours": 0, "lockSteps": []interface{}{step(2, 0), step(3, 12)}},
		{"deliberatePoints": 3, "expireHours": 0, "lockSteps": []interface{}{step(0, 12)}},
		{"deliberatePoints": 3, "expireHours": 0, "lockSteps": []interface{}{step(2, -1)}},
		{"deliberatePoints": 3, "expireHours": 0, "lockSteps": []interface{}{step(1, 1), step(2, 2), step(3, 3), step(4, 4), step(5, 5), step(6, 0)}},
		{"deliberatePoints": 3, "expireHours": 0, "lockSteps": []interface{}{map[string]interface{}{"points": 2, "hours": 12, "extra": true}}},
		{"deliberatePoints": 3, "expireHours": 0},
		{"deliberatePoints": 3, "expireHours": 0, "lockSteps": []interface{}{step(3, 0)}, "threshold": 3},
	}
	for _, value := range invalid {
		if err := ValidateModerationValue(value); err == nil {
			t.Fatalf("invalid config accepted: %v", value)
		}
	}
}
