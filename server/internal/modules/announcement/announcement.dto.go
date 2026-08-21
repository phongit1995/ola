package announcement

import "ola-chat-server/internal/models"

type CreateAnnouncementRequest struct {
	Title    string  `json:"title" binding:"required,min=1,max=200"`
	Content  string  `json:"content"`
	Link     string  `json:"link" binding:"omitempty,url,max=500"`
	IsActive *bool   `json:"isActive"`
	StartsAt *string `json:"startsAt"`
	EndsAt   *string `json:"endsAt"`
}

type UpdateAnnouncementRequest struct {
	Title    *string `json:"title" binding:"omitempty,min=1,max=200"`
	Content  *string `json:"content" binding:"omitempty"`
	Link     *string `json:"link" binding:"omitempty,url,max=500"`
	IsActive *bool   `json:"isActive"`
	StartsAt *string `json:"startsAt"`
	EndsAt   *string `json:"endsAt"`
}

type AnnouncementResponse = models.Announcement

type AnnouncementListResponse struct {
	Total int64                 `json:"total"`
	Items []models.Announcement `json:"items"`
}

type LatestAnnouncementResponse struct {
	Announcement *models.Announcement `json:"announcement"`
}
