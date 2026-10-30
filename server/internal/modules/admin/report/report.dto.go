package adminreport

import (
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

type ListFilter struct {
	Status         string
	TargetType     string
	ReportedUserID *uuid.UUID
	Query          string
	Limit          int
	Offset         int
}

type UserBrief struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
	IsActive bool   `json:"isActive"`
}

type AdminBrief struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
}

type ReportItem struct {
	ID                string                 `json:"id"`
	TargetType        string                 `json:"targetType"`
	TargetID          string                 `json:"targetId"`
	ContextID         string                 `json:"contextId,omitempty"`
	Reason            string                 `json:"reason"`
	Note              string                 `json:"note,omitempty"`
	Snapshot          map[string]interface{} `json:"snapshot,omitempty"`
	Status            string                 `json:"status"`
	Reporter          *UserBrief             `json:"reporter,omitempty"`
	ReportedUser      *UserBrief             `json:"reportedUser,omitempty"`
	HandledBy         *AdminBrief            `json:"handledBy,omitempty"`
	HandledAt         string                 `json:"handledAt,omitempty"`
	HandlerNote       string                 `json:"handlerNote,omitempty"`
	SameTargetPending int64                  `json:"sameTargetPending"`
	CreatedAt         string                 `json:"createdAt"`
}

type ReportListResponse struct {
	Items  []ReportItem `json:"items"`
	Total  int64        `json:"total"`
	Limit  int          `json:"limit"`
	Offset int          `json:"offset"`
}

type ReportSummaryResponse struct {
	Pending int64 `json:"pending"`
}

type UpdateStatusRequest struct {
	Status string `json:"status" binding:"required,oneof=resolved dismissed" example:"resolved"`
	Note   string `json:"note" binding:"omitempty,max=1000" example:"Đã xoá tin nhắn và khoá tài khoản"`
}

type UpdateStatusResponse struct {
	Report   ReportItem `json:"report"`
	Affected int64      `json:"affected"`
}

type TestAlertRequest struct {
	Channel string `json:"channel" binding:"required,oneof=discord telegram" example:"discord"`
}

type TestAlertResponse struct {
	Channel string `json:"channel"`
}

type TestAlertSuccessResponse = utils.BaseResponse[TestAlertResponse]
