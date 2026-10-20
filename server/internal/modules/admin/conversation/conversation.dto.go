package adminconversation

import (
	"ola-chat-server/internal/modules/message"
	"ola-chat-server/internal/utils"
)

type UserBrief struct {
	ID       string `json:"id" example:"ca4c6d54-870c-4735-b9a6-cce05a04aedb"`
	Username string `json:"username" example:"minhanh"`
	FullName string `json:"fullName,omitempty" example:"Minh Anh"`
	Avatar   string `json:"avatar,omitempty"`
}

type ConversationItem struct {
	ID                 string     `json:"id"`
	Type               string     `json:"type" example:"direct"`
	Name               string     `json:"name,omitempty"`
	Avatar             string     `json:"avatar,omitempty"`
	OtherUser          *UserBrief `json:"otherUser,omitempty"`
	LastMessageAt      string     `json:"lastMessageAt,omitempty" example:"2026-10-20T10:30:00Z"`
	LastMessagePreview string     `json:"lastMessagePreview,omitempty"`
	Hidden             bool       `json:"hidden"`
	HiddenAt           string     `json:"hiddenAt,omitempty"`
	Missing            bool       `json:"missing,omitempty"`
}

type ConversationListResponse struct {
	Items    []ConversationItem `json:"items"`
	Total    int                `json:"total"`
	HasMore  bool               `json:"hasMore"`
	Snapshot string             `json:"snapshot,omitempty"`
}

type ConversationMember struct {
	User     UserBrief `json:"user"`
	Role     string    `json:"role,omitempty"`
	IsActive bool      `json:"isActive"`
	JoinedAt string    `json:"joinedAt,omitempty"`
	LeftAt   string    `json:"leftAt,omitempty"`
}

type ConversationDetailResponse struct {
	ID        string               `json:"id"`
	Type      string               `json:"type"`
	Name      string               `json:"name,omitempty"`
	Avatar    string               `json:"avatar,omitempty"`
	CreatedAt string               `json:"createdAt,omitempty"`
	Members   []ConversationMember `json:"members"`
}

type Message struct {
	ID        string                 `json:"id"`
	Sender    UserBrief              `json:"sender"`
	Type      string                 `json:"type" example:"text"`
	Content   string                 `json:"content"`
	Metadata  string                 `json:"metadata,omitempty"`
	CreatedAt string                 `json:"createdAt"`
	EditedAt  string                 `json:"editedAt,omitempty"`
	DeletedAt string                 `json:"deletedAt,omitempty"`
	ReplyTo   *message.ReplySnapshot `json:"replyTo,omitempty"`
	Reactions map[string][]string    `json:"reactions,omitempty"`
}

type MessagesResponse struct {
	Messages   []Message `json:"messages"`
	HasMore    bool      `json:"hasMore"`
	NextBefore string    `json:"nextBefore,omitempty"`
	HasNewer   bool      `json:"hasNewer"`
}

type ConversationListSuccessResponse = utils.BaseResponse[ConversationListResponse]
type ConversationDetailSuccessResponse = utils.BaseResponse[ConversationDetailResponse]
type MessagesSuccessResponse = utils.BaseResponse[MessagesResponse]
