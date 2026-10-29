package admincommon

import "github.com/google/uuid"

type UserBrief struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"john_doe"`
	FullName string `json:"fullName" example:"John Doe"`
	Avatar   string `json:"avatar" example:"https://example.com/avatar.jpg"`
}

func UserBriefOf(id uuid.UUID, username, fullName, avatar string) UserBrief {
	if username == "" {
		return UserBrief{ID: id.String(), Username: id.String()[:8]}
	}
	return UserBrief{
		ID:       id.String(),
		Username: username,
		FullName: fullName,
		Avatar:   avatar,
	}
}
