package auth

import "ola-chat-server/internal/utils"

type RegisterRequest struct {
	Username string `json:"username" binding:"required,min=6,max=20" example:"john_doe"`
	Password string `json:"password" binding:"required,min=6" example:"password123"`
}

type LoginRequest struct {
	Username string `json:"username" binding:"required" example:"john_doe"`
	Password string `json:"password" binding:"required" example:"password123"`
}

type RegisterResponse struct {
	User    UserResponse `json:"user"`
	Message string       `json:"message" example:"Registration successful. Please login to continue."`
}

type AuthResponse struct {
	Token        string       `json:"token" example:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."`
	RefreshToken string       `json:"refreshToken" example:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."`
	User         UserResponse `json:"user"`
}

type UserResponse struct {
	ID             string                 `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username       string                 `json:"username" example:"john_doe"`
	Email          string                 `json:"email" example:"john@example.com"`
	Avatar         string                 `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
	Phone          string                 `json:"phone,omitempty" example:"+84987654321"`
	FullName       string                 `json:"fullName,omitempty" example:"John Doe"`
	Gender         string                 `json:"gender" example:"male"`
	Bio            string                 `json:"bio,omitempty" example:"hello ola!!!"`
	DateOfBirth    string                 `json:"dateOfBirth,omitempty" example:"1990-01-01"`
	CustomInfo     map[string]interface{} `json:"customInfo,omitempty" swaggertype:"object" example:"{\"theme\":\"dark\",\"language\":\"en\"}"`
	Ken            int                    `json:"ken" example:"0"`
	VipUsed        *string                `json:"vipUsed" example:"gold"`
	VipEndTime     *string                `json:"vipEndTime" example:"2026-12-31T00:00:00Z"`
	FollowerCount  int                    `json:"followerCount" example:"0"`
	FollowingCount int                    `json:"followingCount" example:"0"`
}

type ChangePasswordRequest struct {
	CurrentPassword string `json:"currentPassword" binding:"required" example:"oldpassword123"`
	NewPassword     string `json:"newPassword" binding:"required,min=6" example:"newpassword123"`
}

type ChangePasswordResponse struct {
	Message string `json:"message" example:"Password changed successfully"`
}

type RefreshTokenRequest struct {
	RefreshToken string `json:"refreshToken" binding:"required" example:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."`
}

type RefreshTokenResponse struct {
	Token        string `json:"token" example:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."`
	RefreshToken string `json:"refreshToken" example:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."`
}

type ChangePasswordSuccessResponse = utils.BaseResponse[ChangePasswordResponse]

type RegisterSuccessResponse = utils.BaseResponse[RegisterResponse]
type AuthSuccessResponse = utils.BaseResponse[AuthResponse]
