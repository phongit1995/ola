package clan

import "ola-chat-server/internal/modules/me"

type CreateClanRequest struct {
	Name        string `json:"name" binding:"required,max=64" example:"teamviet"`
	Description string `json:"description" binding:"omitempty,max=1000"`
}

type UpdateClanRequest struct {
	Description      *string `json:"description" binding:"omitempty,max=1000"`
	Policy           *int16  `json:"policy" binding:"omitempty,min=0,max=4"`
	MemberPublicPost *bool   `json:"memberPublicPost" binding:"omitempty"`
}

type AssignRoleRequest struct {
	Username string `json:"username" binding:"required" example:"phobang02"`
	Role     string `json:"role" binding:"required,oneof=deputy ambassador" example:"deputy"`
}

type UsernameRequest struct {
	Username string `json:"username" binding:"required" example:"member01"`
}

type PinRequest struct {
	PostID string `json:"postId" binding:"required,uuid"`
}

type ClanUserResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type ClanResponse struct {
	ID               string            `json:"id"`
	Handle           string            `json:"handle"`
	Description      string            `json:"description,omitempty"`
	Avatar           string            `json:"avatar,omitempty"`
	Cover            string            `json:"cover,omitempty"`
	Policy           int16             `json:"policy"`
	MemberPublicPost bool              `json:"memberPublicPost"`
	MemberCount      int               `json:"memberCount"`
	VisitCount       int64             `json:"visitCount"`
	MeTopPostID      string            `json:"meTopPostId,omitempty"`
	Owner            *ClanUserResponse `json:"owner,omitempty"`
	Deputy           *ClanUserResponse `json:"deputy,omitempty"`
	Ambassador       *ClanUserResponse `json:"ambassador,omitempty"`
	MyRole           string            `json:"myRole,omitempty"`
	MyVerified       bool              `json:"myVerified"`
	IsMember         bool              `json:"isMember"`
	IsBanned         bool              `json:"isBanned"`
	KenBalance       *int              `json:"kenBalance,omitempty"`
	CreatedAt        string            `json:"createdAt"`
}

type ClanPreviewResponse struct {
	Handle      string `json:"handle"`
	Owner       string `json:"owner,omitempty"`
	Deputy      string `json:"deputy,omitempty"`
	Ambassador  string `json:"ambassador,omitempty"`
	MemberCount int    `json:"memberCount"`
	VisitCount  int64  `json:"visitCount"`
}

type CheckNameResponse struct {
	Name      string               `json:"name"`
	Available bool                 `json:"available"`
	Cost      int                  `json:"cost"`
	Clan      *ClanPreviewResponse `json:"clan,omitempty"`
}

type MemberResponse struct {
	User     *ClanUserResponse `json:"user"`
	Role     string            `json:"role"`
	Verified bool              `json:"verified"`
	JoinedAt string            `json:"joinedAt"`
}

type MemberListResponse struct {
	Items  []MemberResponse `json:"items"`
	Total  int64            `json:"total"`
	Limit  int              `json:"limit"`
	Offset int              `json:"offset"`
}

type BanResponse struct {
	User     *ClanUserResponse `json:"user"`
	BannedAt string            `json:"bannedAt"`
}

type BanListResponse struct {
	Items  []BanResponse `json:"items"`
	Total  int64         `json:"total"`
	Limit  int           `json:"limit"`
	Offset int           `json:"offset"`
}

type ClanPostsResponse struct {
	Pinned     *me.MeResponse  `json:"pinned,omitempty"`
	Items      []me.MeResponse `json:"items"`
	NextCursor string          `json:"nextCursor,omitempty"`
}

type UploadClanImageResponse struct {
	URL string `json:"url"`
}

type MessageResponse struct {
	Message string `json:"message" example:"ok"`
}
