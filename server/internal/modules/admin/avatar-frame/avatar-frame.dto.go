package adminavatarframe

import "time"

type GrantUserFrameRequest struct {
	FrameID       string `json:"frameId" binding:"required" example:"001"`
	ExpiresInDays int    `json:"expiresInDays" binding:"omitempty,min=0,max=3650" example:"7"`
	Locked        bool   `json:"locked" example:"true"`
}

type UpdateUserFrameRequest struct {
	ExpiresAt *time.Time `json:"expiresAt" example:"2026-11-25T13:00:00Z"`
	Locked    bool       `json:"locked" example:"true"`
}
