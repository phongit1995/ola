package marriagediary

import (
	"ola-chat-server/internal/utils"

	userModule "ola-chat-server/internal/modules/user"
)

type CreateDiaryRequest struct {
	Content string `json:"content" binding:"required,min=1,max=2000" example:"Hôm nay mình đi ăn cùng nhau 🥰"`
}

type UserBrief = userModule.UserBrief

type DiaryEntryItem struct {
	ID        string     `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Content   string     `json:"content" example:"Hôm nay mình đi ăn cùng nhau 🥰"`
	Author    *UserBrief `json:"author,omitempty"`
	CreatedAt string     `json:"createdAt" example:"2026-06-24T10:00:00Z"`
}

type DiaryListResponse struct {
	Total  int              `json:"total" example:"1"`
	Limit  int              `json:"limit" example:"20"`
	Offset int              `json:"offset" example:"0"`
	Items  []DiaryEntryItem `json:"items"`
}

type MessageResponse struct {
	Message string `json:"message" example:"ok"`
}

type CreateDiarySuccessResponse = utils.BaseResponse[DiaryEntryItem]
type DiaryListSuccessResponse = utils.BaseResponse[DiaryListResponse]
type MessageSuccessResponse = utils.BaseResponse[MessageResponse]
