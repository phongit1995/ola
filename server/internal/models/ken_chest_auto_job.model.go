package models

import (
	"database/sql/driver"
	"encoding/json"
	"errors"
	"time"

	"github.com/google/uuid"
)

type KenChestScheduleType string

const (
	KenChestScheduleInterval KenChestScheduleType = "interval"
	KenChestScheduleDaily    KenChestScheduleType = "daily"
)

type DailyTimes []string

func (d DailyTimes) Value() (driver.Value, error) {
	if d == nil {
		return nil, nil
	}
	return json.Marshal(d)
}

func (d *DailyTimes) Scan(value interface{}) error {
	if value == nil {
		*d = nil
		return nil
	}
	bytes, ok := value.([]byte)
	if !ok {
		return errors.New("failed to unmarshal DailyTimes value")
	}
	return json.Unmarshal(bytes, d)
}

type KenChestAutoJob struct {
	ID                 uuid.UUID            `gorm:"type:uuid;primary_key;default:gen_random_uuid()" json:"id"`
	Name               string               `gorm:"type:varchar(100);not null;default:''" json:"name"`
	Enabled            bool                 `gorm:"not null" json:"enabled"`
	ScheduleType       KenChestScheduleType `gorm:"type:varchar(10);not null;default:interval" json:"scheduleType"`
	IntervalMinMinutes *int                 `gorm:"column:interval_min_minutes" json:"intervalMinMinutes,omitempty"`
	IntervalMaxMinutes *int                 `gorm:"column:interval_max_minutes" json:"intervalMaxMinutes,omitempty"`
	DailyTimes         DailyTimes           `gorm:"type:jsonb" json:"dailyTimes,omitempty"`
	RewardMode         KenChestRewardMode   `gorm:"type:varchar(10);not null" json:"rewardMode"`
	KenAmount          *int                 `gorm:"column:ken_amount" json:"kenAmount,omitempty"`
	KenMin             *int                 `gorm:"column:ken_min" json:"kenMin,omitempty"`
	KenMax             *int                 `gorm:"column:ken_max" json:"kenMax,omitempty"`
	MaxRecipients      int                  `gorm:"not null" json:"maxRecipients"`
	DurationSeconds    int                  `gorm:"not null;default:90" json:"durationSeconds"`
	RemainingRuns      *int                 `gorm:"column:remaining_runs" json:"remainingRuns,omitempty"`
	RunCount           int                  `gorm:"not null;default:0" json:"runCount"`
	NextRunAt          *time.Time           `gorm:"column:next_run_at" json:"nextRunAt,omitempty"`
	LastRunAt          *time.Time           `gorm:"column:last_run_at" json:"lastRunAt,omitempty"`
	CreatedBy          *uuid.UUID           `gorm:"type:uuid" json:"createdBy,omitempty"`
	CreatedAt          time.Time            `gorm:"not null;default:CURRENT_TIMESTAMP" json:"createdAt"`
	UpdatedAt          time.Time            `gorm:"not null;default:CURRENT_TIMESTAMP" json:"updatedAt"`
}

func (KenChestAutoJob) TableName() string {
	return "ken_chest_auto_jobs"
}

type KenChestAutoSettings struct {
	ID        uuid.UUID  `gorm:"type:uuid;primary_key;default:gen_random_uuid()" json:"id"`
	Enabled   bool       `gorm:"not null;default:true" json:"enabled"`
	UpdatedBy *uuid.UUID `gorm:"type:uuid" json:"updatedBy,omitempty"`
	UpdatedAt time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP" json:"updatedAt"`
}

func (KenChestAutoSettings) TableName() string {
	return "ken_chest_auto_settings"
}
