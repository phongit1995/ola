package moderation

import (
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
)

type PenaltyInput struct {
	UserID         uuid.UUID
	AdminID        uuid.UUID
	Source         string
	TargetType     string
	TargetID       string
	ReportID       *uuid.UUID
	Reason         string
	Severity       string
	Note           string
	ContentRemoved bool
}

type Penalty struct {
	Outcome   *PenaltyOutcome
	input     PenaltyInput
	violation *models.UserViolation
	result    *recordResult
	cfg       setting.ModerationConfig
}

type PenaltyOutcome struct {
	Counted     bool   `json:"counted"`
	Points      int    `json:"points"`
	Total       int    `json:"total"`
	Threshold   int    `json:"threshold"`
	Locked      bool   `json:"locked"`
	LockedUntil string `json:"lockedUntil,omitempty"`
}

type AdminBrief struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
}

type ViolationItem struct {
	ID         string      `json:"id"`
	Source     string      `json:"source"`
	TargetType string      `json:"targetType"`
	TargetID   string      `json:"targetId"`
	ReportID   string      `json:"reportId,omitempty"`
	Reason     string      `json:"reason"`
	Severity   string      `json:"severity"`
	Points     int         `json:"points"`
	Note       string      `json:"note,omitempty"`
	Admin      *AdminBrief `json:"admin,omitempty"`
	RevokedAt  string      `json:"revokedAt,omitempty"`
	RevokedBy  *AdminBrief `json:"revokedBy,omitempty"`
	CreatedAt  string      `json:"createdAt"`
}

type ViolationSummary struct {
	Items       []ViolationItem              `json:"items"`
	Total       int                          `json:"total"`
	Threshold   int                          `json:"threshold"`
	ExpireHours int                          `json:"expireHours"`
	LockSteps   []setting.ModerationLockStep `json:"lockSteps"`
}

func toAdminBrief(admin *models.AdminUser) *AdminBrief {
	if admin == nil {
		return nil
	}
	return &AdminBrief{ID: admin.ID.String(), Username: admin.Username, FullName: admin.FullName}
}

func toViolationItem(v *models.UserViolation) ViolationItem {
	item := ViolationItem{
		ID:         v.ID.String(),
		Source:     v.Source,
		TargetType: v.TargetType,
		TargetID:   v.TargetID,
		Reason:     v.Reason,
		Severity:   v.Severity,
		Points:     v.Points,
		Note:       v.Note,
		Admin:      toAdminBrief(v.Admin),
		RevokedBy:  toAdminBrief(v.Revoker),
		CreatedAt:  v.CreatedAt.UTC().Format(time.RFC3339),
	}
	if v.ReportID != nil {
		item.ReportID = v.ReportID.String()
	}
	if v.RevokedAt != nil {
		item.RevokedAt = v.RevokedAt.UTC().Format(time.RFC3339)
	}
	return item
}
