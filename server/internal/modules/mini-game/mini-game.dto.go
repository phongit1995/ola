package minigame

import "ola-chat-server/internal/models"

type CreateMiniGameRequest struct {
	Slug        string `json:"slug" binding:"required,min=2,max=50"`
	Name        string `json:"name" binding:"required,min=1,max=100"`
	Description string `json:"description" binding:"max=300"`
	IconURL     string `json:"iconUrl" binding:"max=500"`
	GameURL     string `json:"gameUrl" binding:"required,url,max=500"`
	IsEnabled   *bool  `json:"isEnabled"`
	SortOrder   int    `json:"sortOrder"`
}

type UpdateMiniGameRequest struct {
	Name        *string `json:"name" binding:"omitempty,min=1,max=100"`
	Description *string `json:"description" binding:"omitempty,max=300"`
	IconURL     *string `json:"iconUrl" binding:"omitempty,max=500"`
	GameURL     *string `json:"gameUrl" binding:"omitempty,url,max=500"`
	IsEnabled   *bool   `json:"isEnabled"`
	SortOrder   *int    `json:"sortOrder"`
}

type MiniGameResponse = models.MiniGame

type MiniGameListResponse struct {
	Total int64             `json:"total"`
	Items []models.MiniGame `json:"items"`
}
