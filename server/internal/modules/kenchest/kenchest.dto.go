package kenchest

import (
	"time"

	"github.com/google/uuid"
)

type CreateChestRequest struct {
	RewardMode      string `json:"rewardMode" binding:"required,oneof=fixed random"`
	KenAmount       *int   `json:"kenAmount"`
	KenMin          *int   `json:"kenMin"`
	KenMax          *int   `json:"kenMax"`
	MaxRecipients   int    `json:"maxRecipients" binding:"required,gt=0"`
	DurationSeconds int    `json:"durationSeconds"`
}

type ChestView struct {
	ID                uuid.UUID `json:"id"`
	RewardMode        string    `json:"rewardMode"`
	KenAmount         *int      `json:"kenAmount,omitempty"`
	KenMin            *int      `json:"kenMin,omitempty"`
	KenMax            *int      `json:"kenMax,omitempty"`
	MaxRecipients     int       `json:"maxRecipients"`
	ClaimedRecipients int       `json:"claimedRecipients"`
	DurationSeconds   int       `json:"durationSeconds"`
	Status            string    `json:"status"`
	StartedAt         time.Time `json:"startedAt"`
	ExpiresAt         time.Time `json:"expiresAt"`
	ClaimsCount       int       `json:"claimsCount"`
	TotalKenGiven     int64     `json:"totalKenGiven"`
	CreatedAt         time.Time `json:"createdAt"`
}

type ChestListResponse struct {
	Items  []ChestView `json:"items"`
	Total  int64       `json:"total"`
	Limit  int         `json:"limit"`
	Offset int         `json:"offset"`
}

type OpenChestResult struct {
	ChestID    uuid.UUID `json:"chestId"`
	IsEmpty    bool      `json:"isEmpty"`
	KenAmount  int       `json:"kenAmount"`
	KenBalance int       `json:"kenBalance"`
}

type ClaimUserView struct {
	ID       uuid.UUID `json:"id"`
	Username string    `json:"username"`
	FullName string    `json:"fullName"`
	Avatar   string    `json:"avatar"`
}

type ClaimView struct {
	ID        uuid.UUID     `json:"id"`
	KenAmount int           `json:"kenAmount"`
	IsEmpty   bool          `json:"isEmpty"`
	CreatedAt time.Time     `json:"createdAt"`
	User      ClaimUserView `json:"user"`
}

type ClaimListResponse struct {
	Items  []ClaimView `json:"items"`
	Total  int64       `json:"total"`
	Limit  int         `json:"limit"`
	Offset int         `json:"offset"`
}
