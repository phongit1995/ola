package admincheckin

import (
	"time"

	"ola-chat-server/internal/models"
	admincommon "ola-chat-server/internal/modules/admin/common"

	"github.com/google/uuid"
)

type MonthDTO struct {
	Month       string     `json:"month" example:"2026-11"`
	SlotCount   int        `json:"slotCount" example:"28"`
	PublishedAt *time.Time `json:"publishedAt"`
	CreatedAt   time.Time  `json:"createdAt"`
	UpdatedAt   time.Time  `json:"updatedAt"`
}

type SlotDTO struct {
	Slot       int                 `json:"slot" example:"7"`
	Gifts      models.CheckinGifts `json:"gifts"`
	Featured   bool                `json:"featured"`
	RequireVip bool                `json:"requireVip"`
	Task       *string             `json:"task" example:"random"`
	UpdatedAt  *time.Time          `json:"updatedAt,omitempty"`
}

type MonthDetailDTO struct {
	MonthDTO
	Slots []SlotDTO `json:"slots"`
}

type MonthListResponse struct {
	Items []MonthDTO `json:"items"`
}

type CreateMonthRequest struct {
	Month     string `json:"month" binding:"required" example:"2026-12"`
	SlotCount int    `json:"slotCount" binding:"required" example:"28"`
	Source    string `json:"source" binding:"required,oneof=copy empty" example:"copy"`
	CopyFrom  string `json:"copyFrom" example:"2026-11"`
}

type UpdateMonthRequest struct {
	SlotCount int `json:"slotCount" binding:"required" example:"30"`
}

type SaveSlotsRequest struct {
	Slots []SlotDTO `json:"slots" binding:"required"`
}

type SwapSlotsRequest struct {
	From int `json:"from" binding:"required" example:"3"`
	To   int `json:"to" binding:"required" example:"7"`
}

type HistoryItem struct {
	ID           uuid.UUID              `json:"id"`
	User         admincommon.UserBrief  `json:"user"`
	Day          string                 `json:"day" example:"2026-11-19"`
	Slot         int                    `json:"slot" example:"7"`
	Box          string                 `json:"box" example:"big"`
	RequireVip   bool                   `json:"requireVip"`
	Task         *string                `json:"task" example:"me_post"`
	TaskDoneAt   *time.Time             `json:"taskDoneAt"`
	Status       string                 `json:"status" example:"claimed" enums:"claimed,pending,missed,none"`
	MissReason   string                 `json:"missReason,omitempty" example:"task" enums:"task,vip,not_opened"`
	VipAtCheckin bool                   `json:"vipAtCheckin"`
	Rewards      []models.CheckinReward `json:"rewards"`
	CreatedAt    time.Time              `json:"createdAt"`
	ClaimedAt    *time.Time             `json:"claimedAt"`
}

type UserMonthResponse struct {
	User      admincommon.UserBrief `json:"user"`
	Month     string                `json:"month"`
	SlotCount int                   `json:"slotCount"`
	Entries   []HistoryItem         `json:"entries"`
}

type StatsDay struct {
	Day   string `json:"day"`
	Users int64  `json:"users"`
}

type StatsGift struct {
	Counts []int64 `json:"counts"`
}

type StatsSlot struct {
	Slot      int         `json:"slot"`
	Box       string      `json:"box"`
	CheckedIn int64       `json:"checkedIn"`
	Opened    int64       `json:"opened"`
	Lost      int64       `json:"lost"`
	Gifts     []StatsGift `json:"gifts"`
}

type StatsTask struct {
	Task          string `json:"task"`
	Assigned      int64  `json:"assigned"`
	Done          int64  `json:"done"`
	NotDone       int64  `json:"notDone"`
	DoneNotOpened int64  `json:"doneNotOpened"`
}

type StatsResponse struct {
	Month           string           `json:"month"`
	CheckedInToday  int64            `json:"checkedInToday"`
	CheckedInUsers  int64            `json:"checkedInUsers"`
	CompletedUsers  int64            `json:"completedUsers"`
	BoxesOpened     int64            `json:"boxesOpened"`
	OpenedByType    map[string]int64 `json:"openedByType"`
	LostNoVip       int64            `json:"lostNoVip"`
	BoughtVipToOpen int64            `json:"boughtVipToOpen"`
	TicketsGranted  int64            `json:"ticketsGranted"`
	TicketsUsed     int64            `json:"ticketsUsed"`
	TicketsExpired  int64            `json:"ticketsExpired"`
	Daily           []StatsDay       `json:"daily"`
	Slots           []StatsSlot      `json:"slots"`
	Tasks           []StatsTask      `json:"tasks"`
}
