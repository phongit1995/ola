package checkin

import (
	"time"

	"ola-chat-server/internal/models"
)

type CheckInRequest struct {
	ClientRequestID string `json:"clientRequestId" binding:"required,max=64" example:"7d0f3a8e-2f6b-4c1e-9a55-3a3e1c2b9f10"`
}

type TaskState struct {
	Code string `json:"code" example:"me_post"`
	Done bool   `json:"done" example:"false"`
}

type SlotState struct {
	Slot        int                    `json:"slot" example:"7"`
	Box         string                 `json:"box" example:"big" enums:"none,normal,big"`
	RequireVip  bool                   `json:"requireVip" example:"false"`
	Status      string                 `json:"status" example:"claimed" enums:"claimed,none,missed,pending,today,upcoming,out_of_reach"`
	Items       []models.CheckinReward `json:"items,omitempty"`
	CheckedInOn string                 `json:"checkedInOn,omitempty" example:"2026-11-07"`
}

type StatusResponse struct {
	Enabled          bool                   `json:"enabled" example:"true"`
	Popup            bool                   `json:"popup" example:"true"`
	NeedsEmailVerify bool                   `json:"needsEmailVerify" example:"false"`
	Month            string                 `json:"month,omitempty" example:"2026-11"`
	SlotCount        int                    `json:"slotCount" example:"28"`
	Count            int                    `json:"count" example:"16"`
	Slot             int                    `json:"slot" example:"17"`
	Completed        bool                   `json:"completed" example:"false"`
	CheckedInToday   bool                   `json:"checkedInToday" example:"false"`
	Reachable        int                    `json:"reachable" example:"29"`
	CanOpen          bool                   `json:"canOpen" example:"false"`
	TodayTask        *TaskState             `json:"todayTask,omitempty"`
	TodayResult      []models.CheckinReward `json:"todayResult,omitempty"`
	EndsAt           time.Time              `json:"endsAt"`
	Slots            []SlotState            `json:"slots"`
}

type ActionResponse struct {
	Status *StatusResponse        `json:"status"`
	Slot   int                    `json:"slot,omitempty" example:"6"`
	Items  []models.CheckinReward `json:"items,omitempty"`
	Reason string                 `json:"reason,omitempty" example:"task_pending" enums:"task_pending,vip_required"`
}
