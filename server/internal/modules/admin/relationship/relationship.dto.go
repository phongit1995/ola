package adminrelationship

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

type RelationshipStats struct {
	Total    int64 `json:"total" example:"800"`
	Pending  int64 `json:"pending" example:"280"`
	Accepted int64 `json:"accepted" example:"240"`
	Rejected int64 `json:"rejected" example:"10"`
	Blocked  int64 `json:"blocked" example:"270"`
}

type FollowStats struct {
	Total int64 `json:"total" example:"630"`
}

type StatsResponse struct {
	Relationships RelationshipStats `json:"relationships"`
	Follows       FollowStats       `json:"follows"`
}

type ListFilter struct {
	Status string
	UserID *uuid.UUID
	From   *time.Time
	To     *time.Time
}

type RelationshipItem struct {
	ID         string   `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Requester  UserInfo `json:"requester"`
	Addressee  UserInfo `json:"addressee"`
	Status     string   `json:"status" example:"accepted"`
	CreatedAt  string   `json:"createdAt" example:"2026-07-26T10:00:00Z"`
	ActionedAt string   `json:"actionedAt,omitempty" example:"2026-07-26T10:05:00Z"`
}

type RelationshipListResponse struct {
	Total  int64              `json:"total" example:"1"`
	Limit  int                `json:"limit" example:"20"`
	Offset int                `json:"offset" example:"0"`
	Items  []RelationshipItem `json:"items"`
}

type FollowFilter struct {
	FollowerID *uuid.UUID
	FolloweeID *uuid.UUID
	UserID     *uuid.UUID
	From       *time.Time
	To         *time.Time
}

type FollowItem struct {
	ID        string   `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Follower  UserInfo `json:"follower"`
	Followee  UserInfo `json:"followee"`
	CreatedAt string   `json:"createdAt" example:"2026-07-26T10:00:00Z"`
}

type FollowListResponse struct {
	Total  int64        `json:"total" example:"1"`
	Limit  int          `json:"limit" example:"20"`
	Offset int          `json:"offset" example:"0"`
	Items  []FollowItem `json:"items"`
}

type UserStatsFilter struct {
	UserID *uuid.UUID
	From   *time.Time
	To     *time.Time
}

type UserStatsItem struct {
	User      UserInfo `json:"user"`
	Friends   int64    `json:"friends" example:"12"`
	Blocked   int64    `json:"blocked" example:"2"`
	Followers int64    `json:"followers" example:"30"`
	Following int64    `json:"following" example:"18"`
}

type UserStatsResponse struct {
	Total  int64           `json:"total" example:"1"`
	Limit  int             `json:"limit" example:"20"`
	Offset int             `json:"offset" example:"0"`
	Items  []UserStatsItem `json:"items"`
}

type StatsSuccessResponse = utils.BaseResponse[StatsResponse]
type RelationshipListSuccessResponse = utils.BaseResponse[RelationshipListResponse]
type FollowListSuccessResponse = utils.BaseResponse[FollowListResponse]
type UserStatsSuccessResponse = utils.BaseResponse[UserStatsResponse]
