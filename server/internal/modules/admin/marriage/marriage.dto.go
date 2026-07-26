package adminmarriage

import (
	"time"

	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

type UserInfo struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"john_doe"`
	FullName string `json:"fullName,omitempty" example:"John Doe"`
	Avatar   string `json:"avatar,omitempty" example:"https://cdn.ola.vn/a.png"`
}

type StatsFilter struct {
	From *time.Time
	To   *time.Time
}

type ProposalStats struct {
	Total     int64 `json:"total" example:"120"`
	Pending   int64 `json:"pending" example:"5"`
	Accepted  int64 `json:"accepted" example:"80"`
	Rejected  int64 `json:"rejected" example:"25"`
	Cancelled int64 `json:"cancelled" example:"10"`
}

type MarriageStats struct {
	Total    int64 `json:"total" example:"80"`
	Active   int64 `json:"active" example:"70"`
	Divorced int64 `json:"divorced" example:"10"`
}

type StatsResponse struct {
	Proposals ProposalStats `json:"proposals"`
	Marriages MarriageStats `json:"marriages"`
}

type ListFilter struct {
	Status string
	UserID *uuid.UUID
	From   *time.Time
	To     *time.Time
}

type MarriageItem struct {
	ID         string   `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	UserA      UserInfo `json:"userA"`
	UserB      UserInfo `json:"userB"`
	Status     string   `json:"status" example:"active"`
	MarriedAt  string   `json:"marriedAt" example:"2026-07-26T10:00:00Z"`
	DivorcedAt string   `json:"divorcedAt,omitempty" example:"2026-07-26T10:00:00Z"`
	DivorcedBy string   `json:"divorcedBy,omitempty" example:"550e8400-e29b-41d4-a716-446655440000"`
}

type MarriageListResponse struct {
	Total  int64          `json:"total" example:"1"`
	Limit  int            `json:"limit" example:"20"`
	Offset int            `json:"offset" example:"0"`
	Items  []MarriageItem `json:"items"`
}

type ProposalItem struct {
	ID          string   `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Proposer    UserInfo `json:"proposer"`
	Addressee   UserInfo `json:"addressee"`
	Message     string   `json:"message,omitempty" example:"Lấy anh nhé"`
	Status      string   `json:"status" example:"accepted"`
	CreatedAt   string   `json:"createdAt" example:"2026-07-26T10:00:00Z"`
	RespondedAt string   `json:"respondedAt,omitempty" example:"2026-07-26T10:05:00Z"`
}

type ProposalListResponse struct {
	Total  int64          `json:"total" example:"1"`
	Limit  int            `json:"limit" example:"20"`
	Offset int            `json:"offset" example:"0"`
	Items  []ProposalItem `json:"items"`
}

type StatsSuccessResponse = utils.BaseResponse[StatsResponse]
type MarriageListSuccessResponse = utils.BaseResponse[MarriageListResponse]
type ProposalListSuccessResponse = utils.BaseResponse[ProposalListResponse]
