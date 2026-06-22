package marriage

import "ola-chat-server/internal/utils"

type ProposeRequest struct {
	AddresseeUsername string `json:"addresseeUsername" binding:"required,min=1,max=100" example:"john_doe"`
	Message           string `json:"message" binding:"omitempty,max=500" example:"Em đồng ý làm vợ anh nhé?"`
}

type UserBrief struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"john_doe"`
	FullName string `json:"fullName,omitempty" example:"John Doe"`
	Avatar   string `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
}

type ProposalItem struct {
	ID          string     `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Status      string     `json:"status" example:"pending"`
	Message     string     `json:"message,omitempty" example:"Em đồng ý làm vợ anh nhé?"`
	Proposer    *UserBrief `json:"proposer,omitempty"`
	Addressee   *UserBrief `json:"addressee,omitempty"`
	CreatedAt   string     `json:"createdAt" example:"2026-06-22T10:00:00Z"`
	RespondedAt string     `json:"respondedAt,omitempty" example:"2026-06-22T10:05:00Z"`
}

type ProposalListResponse struct {
	Total  int            `json:"total" example:"1"`
	Limit  int            `json:"limit" example:"20"`
	Offset int            `json:"offset" example:"0"`
	Items  []ProposalItem `json:"items"`
}

type SpouseInfo struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"jane_doe"`
	FullName string `json:"fullName,omitempty" example:"Jane Doe"`
	Avatar   string `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
}

type MarriageStatusResponse struct {
	Spouse    *SpouseInfo `json:"spouse,omitempty"`
	MarriedAt string      `json:"marriedAt,omitempty" example:"2026-06-22T10:05:00Z"`
}

type ProposeResponse struct {
	ProposalID        string `json:"proposalId" example:"550e8400-e29b-41d4-a716-446655440000"`
	AddresseeUsername string `json:"addresseeUsername" example:"jane_doe"`
	Status            string `json:"status" example:"pending"`
}

type MessageResponse struct {
	Message string `json:"message" example:"ok"`
}

type ProposeSuccessResponse = utils.BaseResponse[ProposeResponse]
type ProposalListSuccessResponse = utils.BaseResponse[ProposalListResponse]
type MarriageStatusSuccessResponse = utils.BaseResponse[MarriageStatusResponse]
type MessageSuccessResponse = utils.BaseResponse[MessageResponse]
