package user

import "ola-chat-server/internal/utils"

type UserProfileResponse struct {
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
	Spouse         *SpouseInfo            `json:"spouse,omitempty"`
	CoverPhoto     string                 `json:"coverPhoto,omitempty" example:"https://example.com/cover.jpg"`
	BioImage       *string                `json:"bioImage,omitempty" example:"https://example.com/bio.jpg"`
	Verified       bool                   `json:"verified" example:"false"`
	Kisses         int                    `json:"kisses" example:"0"`
	CreatedAt      string                 `json:"createdAt" example:"2024-01-01T00:00:00Z"`
	UpdatedAt      string                 `json:"updatedAt" example:"2024-01-01T00:00:00Z"`
}

type SpouseInfo struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"jane_doe"`
	FullName string `json:"fullName,omitempty" example:"Jane Doe"`
	Avatar   string `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
}

type SearchUsersQuery struct {
	Q     string `form:"q" binding:"required,min=1,max=100"`
	Limit int    `form:"limit" binding:"omitempty,min=1,max=100"`
}

type UpdateProfileRequest struct {
	Avatar      string                 `json:"avatar,omitempty" binding:"omitempty,url,max=500" example:"https://example.com/avatar.jpg"`
	Phone       string                 `json:"phone,omitempty" binding:"omitempty,max=20" example:"+84987654321"`
	FullName    string                 `json:"fullName,omitempty" binding:"omitempty,max=100" example:"John Doe"`
	Gender      string                 `json:"gender,omitempty" binding:"omitempty,oneof=male female" example:"male"`
	Bio         *string                `json:"bio,omitempty" binding:"omitempty,max=500" example:"hello ola!!!"`
	DateOfBirth string                 `json:"dateOfBirth,omitempty" binding:"omitempty,datetime=2006-01-02" example:"1990-01-01"`
	CoverPhoto  string                 `json:"coverPhoto,omitempty" binding:"omitempty,url,max=500" example:"https://example.com/cover.jpg"`
	BioImage    *string                `json:"bioImage,omitempty" binding:"omitempty,max=500,url|eq=" example:"https://example.com/bio.jpg"`
	CustomInfo  map[string]interface{} `json:"customInfo,omitempty" swaggertype:"object"`
}

type UserSearchResult struct {
	ID           string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username     string `json:"username" example:"john_doe"`
	FullName     string `json:"fullName,omitempty" example:"John Doe"`
	Avatar       string `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
	Bio          string `json:"bio,omitempty" example:"Software developer"`
	IsOnline     bool    `json:"isOnline" example:"true"`
	Relationship string  `json:"relationship,omitempty" example:"friend"`
	RequestID    string  `json:"requestId,omitempty" example:"550e8400-e29b-41d4-a716-446655440000"`
	VipUsed      *string `json:"vipUsed,omitempty" example:"gold"`
	VipEndTime   *string `json:"vipEndTime,omitempty" example:"2026-12-31T00:00:00Z"`
}

type SearchUsersResponse struct {
	Users []UserSearchResult `json:"users"`
	Total int                `json:"total" example:"5"`
}

type UploadAvatarResponse struct {
	URL       string `json:"url" example:"http://localhost:9000/chat-uploads/uploads/abc123.webp"`
	SecureURL string `json:"secureUrl" example:"http://localhost:9000/chat-uploads/uploads/abc123.webp"`
	PublicID  string `json:"publicId" example:"uploads/abc123.webp"`
	Format    string `json:"format" example:"webp"`
	Width     int    `json:"width" example:"0"`
	Height    int    `json:"height" example:"0"`
}

type UserPublicProfileResponse struct {
	ID             string            `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username       string            `json:"username" example:"john_doe"`
	FullName       string            `json:"fullName,omitempty" example:"John Doe"`
	Avatar         string            `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
	CoverPhoto     string            `json:"coverPhoto,omitempty" example:"https://example.com/cover.jpg"`
	BioImage       *string           `json:"bioImage,omitempty" example:"https://example.com/bio.jpg"`
	Bio            string            `json:"bio,omitempty" example:"Software developer"`
	Gender         string            `json:"gender" example:"male"`
	DateOfBirth    string            `json:"dateOfBirth,omitempty" example:"1990-01-01"`
	Spouse         *SpouseInfo       `json:"spouse,omitempty"`
	Verified       bool              `json:"verified" example:"false"`
	Kisses         int               `json:"kisses" example:"0"`
	VipUsed        *string           `json:"vipUsed" example:"gold"`
	VipEndTime     *string           `json:"vipEndTime" example:"2026-12-31T00:00:00Z"`
	FollowerCount  int               `json:"followerCount" example:"0"`
	FollowingCount int               `json:"followingCount" example:"0"`
	AntiCount      int               `json:"antiCount" example:"0"`
	IsOnline       bool              `json:"isOnline" example:"true"`
	LastActiveAt   string            `json:"lastActiveAt,omitempty" example:"2024-01-15T10:30:00Z"`
	CreatedAt      string            `json:"createdAt" example:"2024-01-01T00:00:00Z"`
	Relationship   *RelationshipInfo `json:"relationship,omitempty"`
}

type KissResponse struct {
	Kisses int `json:"kisses" example:"1"`
}

type FollowResponse struct {
	Following     bool `json:"following" example:"true"`
	FollowerCount int  `json:"followerCount" example:"1"`
}

type FollowUser struct {
	ID           string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username     string `json:"username" example:"john_doe"`
	FullName     string `json:"fullName,omitempty" example:"John Doe"`
	Avatar       string `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
	Bio          string `json:"bio,omitempty" example:"Software developer"`
	IsOnline     bool   `json:"isOnline" example:"true"`
	LastActiveAt string `json:"lastActiveAt,omitempty" example:"2024-01-15T10:30:00Z"`
}

type FollowListResponse struct {
	Users  []FollowUser `json:"users"`
	Total  int64        `json:"total" example:"10"`
	Limit  int          `json:"limit" example:"20"`
	Offset int          `json:"offset" example:"0"`
}

type FollowListQuery struct {
	Limit  int `form:"limit" binding:"omitempty,min=1,max=100"`
	Offset int `form:"offset" binding:"omitempty,min=0"`
}

type VisitorUser struct {
	ID           string            `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username     string            `json:"username" example:"john_doe"`
	FullName     string            `json:"fullName,omitempty" example:"John Doe"`
	Avatar       string            `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
	VipUsed      *string           `json:"vipUsed,omitempty" example:"gold"`
	VipEndTime   *string           `json:"vipEndTime,omitempty" example:"2026-12-31T00:00:00Z"`
	ViewedAt     string            `json:"viewedAt" example:"2024-01-15T10:30:00Z"`
	IsOnline     bool              `json:"isOnline" example:"true"`
	Relationship *RelationshipInfo `json:"relationship,omitempty"`
}

type VisitorListResponse struct {
	Users  []VisitorUser `json:"users"`
	Total  int64         `json:"total" example:"10"`
	Limit  int           `json:"limit" example:"20"`
	Offset int           `json:"offset" example:"0"`
}

type VisitorListSuccessResponse = utils.BaseResponse[VisitorListResponse]

// RelationshipInfo describes the viewer's relationship state with the target user.
// Status values:
//
//	self              - viewer is the target user
//	none              - no relationship row exists
//	friend            - accepted relationship
//	pending_outgoing  - viewer sent a friend request, waiting on target
//	pending_incoming  - target sent a friend request, viewer has not responded
//	blocked_by_me     - viewer has blocked the target
//	blocked_by_them   - target has blocked the viewer
type RelationshipInfo struct {
	Status      string `json:"status" example:"friend"`
	RequestID   string `json:"requestId,omitempty" example:"550e8400-e29b-41d4-a716-446655440000"`
	Since       string `json:"since,omitempty" example:"2024-01-15T10:30:00Z"`
	IsFollowing bool   `json:"isFollowing" example:"false"`
	FollowsMe   bool   `json:"followsMe" example:"false"`
}

const (
	RelationshipStatusSelf            = "self"
	RelationshipStatusNone            = "none"
	RelationshipStatusFriend          = "friend"
	RelationshipStatusPendingOutgoing = "pending_outgoing"
	RelationshipStatusPendingIncoming = "pending_incoming"
	RelationshipStatusBlockedByMe     = "blocked_by_me"
	RelationshipStatusBlockedByThem   = "blocked_by_them"
)

type PresenceBatchRequest struct {
	UserIds []string `json:"userIds" binding:"required,min=1,max=200,dive,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
}

type UserPresence struct {
	UserID       string `json:"userId" example:"550e8400-e29b-41d4-a716-446655440000"`
	IsOnline     bool   `json:"isOnline" example:"true"`
	LastActiveAt string `json:"lastActiveAt,omitempty" example:"2024-01-15T10:30:00Z"`
}

type PresenceBatchResponse struct {
	Users []UserPresence `json:"users"`
}

type PresenceBatchSuccessResponse = utils.BaseResponse[PresenceBatchResponse]

type UserPublicProfileSuccessResponse = utils.BaseResponse[UserPublicProfileResponse]
type KissSuccessResponse = utils.BaseResponse[KissResponse]
type FollowSuccessResponse = utils.BaseResponse[FollowResponse]
type FollowListSuccessResponse = utils.BaseResponse[FollowListResponse]

type UserProfileSuccessResponse = utils.BaseResponse[UserProfileResponse]
type SearchUsersSuccessResponse = utils.BaseResponse[SearchUsersResponse]
type UploadAvatarSuccessResponse = utils.BaseResponse[UploadAvatarResponse]
