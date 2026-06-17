package session

import "ola-chat-server/internal/utils"

type SessionResponse struct {
	ID           string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	DeviceName   string `json:"deviceName" example:"Chrome on Windows"`
	Platform     string `json:"platform" example:"web"`
	DeviceID     string `json:"deviceId" example:"6f1e...abc"`
	AppVersion   string `json:"appVersion" example:"1.0.0"`
	IPAddress    string `json:"ipAddress" example:"::1"`
	IsCurrent    bool   `json:"isCurrent" example:"true"`
	CreatedAt    string `json:"createdAt" example:"2026-06-17T14:46:40Z"`
	LastActiveAt string `json:"lastActiveAt" example:"2026-06-17T14:46:40Z"`
}

type ListSessionsResponse struct {
	Sessions []SessionResponse `json:"sessions"`
	Total    int               `json:"total" example:"2"`
}

type RevokeResponse struct {
	Message string `json:"message" example:"session revoked"`
}

type RevokeOthersResponse struct {
	Message string `json:"message" example:"other sessions revoked"`
	Revoked int    `json:"revoked" example:"3"`
}

type ListSessionsSuccessResponse = utils.BaseResponse[ListSessionsResponse]
type RevokeSuccessResponse = utils.BaseResponse[RevokeResponse]
type RevokeOthersSuccessResponse = utils.BaseResponse[RevokeOthersResponse]
