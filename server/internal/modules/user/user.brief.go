package user

import (
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

type UserBrief struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"john_doe"`
	FullName string `json:"fullName,omitempty" example:"John Doe"`
	Avatar   string `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
}

type UserSummary struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"john_doe"`
	FullName string `json:"fullName" example:"John Doe"`
	Avatar   string `json:"avatar" example:"https://example.com/avatar.jpg"`
}

func ToUserBrief(u *models.User) *UserBrief {
	if u == nil {
		return nil
	}
	return &UserBrief{
		ID:       u.ID.String(),
		Username: u.Username,
		FullName: u.FullName,
		Avatar:   u.Avatar,
	}
}

func UserBriefOf(id uuid.UUID, username, fullName, avatar string) UserBrief {
	if username == "" {
		return UserBrief{ID: id.String(), Username: unknownUsername(id)}
	}
	return UserBrief{ID: id.String(), Username: username, FullName: fullName, Avatar: avatar}
}

func UserSummaryOf(id uuid.UUID, username, fullName, avatar string) UserSummary {
	if username == "" {
		return UserSummary{ID: id.String(), Username: unknownUsername(id)}
	}
	return UserSummary{ID: id.String(), Username: username, FullName: fullName, Avatar: avatar}
}

func unknownUsername(id uuid.UUID) string {
	return id.String()[:unknownUsernameLength]
}
