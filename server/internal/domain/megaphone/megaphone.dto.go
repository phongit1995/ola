package megaphone

import "time"

type Sender struct {
	ID         string  `json:"id" example:"550e8400-e29b-41d4-a716-446655440001"`
	Username   string  `json:"username" example:"minh"`
	FullName   string  `json:"fullName,omitempty" example:"Minh"`
	Avatar     string  `json:"avatar,omitempty" example:"https://cdn.ola.vn/a.png"`
	Gender     string  `json:"gender,omitempty" example:"female"`
	VipUsed    *string `json:"vipUsed,omitempty"`
	VipEndTime *string `json:"vipEndTime,omitempty"`
}

type GiftInfo struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440002"`
	Name     string `json:"name" example:"Hoa hồng"`
	NameEn   string `json:"nameEn,omitempty" example:"Rose"`
	ImageURL string `json:"imageUrl" example:"https://cdn.ola.vn/gifts/rose.png"`
	Quantity int    `json:"quantity" example:"5"`
}

type Megaphone struct {
	ID             string    `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Type           string    `json:"type" example:"message"`
	Sender         Sender    `json:"sender"`
	Receiver       *Sender   `json:"receiver,omitempty"`
	Gift           *GiftInfo `json:"gift,omitempty"`
	Content        string    `json:"content" example:"Chúc cả nhà buổi tối vui vẻ 🎉"`
	ShowAt         time.Time `json:"showAt" example:"2026-11-06T10:00:00Z"`
	DisplaySeconds int       `json:"displaySeconds" example:"12"`
	ExpiresAt      time.Time `json:"expiresAt" example:"2026-11-06T10:30:00Z"`
	CreatedAt      time.Time `json:"createdAt" example:"2026-11-06T09:59:50Z"`
}

type PlayEvent struct {
	Megaphone Megaphone `json:"megaphone"`
	PlayedAt  time.Time `json:"playedAt"`
}

func (e PlayEvent) Stale(now time.Time) bool {
	maxAge := time.Duration(e.Megaphone.DisplaySeconds) * time.Second
	return !now.Before(e.Megaphone.ExpiresAt) || now.Sub(e.PlayedAt) > maxAge
}

type RemovedEvent struct {
	ID string `json:"id"`
}
