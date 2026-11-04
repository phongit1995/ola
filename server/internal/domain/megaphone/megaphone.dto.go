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

type Megaphone struct {
	ID             string    `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Sender         Sender    `json:"sender"`
	Content        string    `json:"content" example:"Chúc cả nhà buổi tối vui vẻ 🎉"`
	ShowAt         time.Time `json:"showAt" example:"2026-11-06T10:00:00Z"`
	DisplaySeconds int       `json:"displaySeconds" example:"10"`
	CreatedAt      time.Time `json:"createdAt" example:"2026-11-06T09:59:50Z"`
}

func (m Megaphone) EndsAt() time.Time {
	return m.ShowAt.Add(time.Duration(m.DisplaySeconds) * time.Second)
}

type CreatedEvent struct {
	Megaphone Megaphone `json:"megaphone"`
}

type RemovedEvent struct {
	ID string `json:"id"`
}
