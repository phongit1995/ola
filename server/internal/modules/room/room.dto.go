package room

type CreateRoomRequest struct {
	Name        string `json:"name" binding:"required,min=1,max=150" example:"Phòng Tán Gẫu"`
	Description string `json:"description" binding:"omitempty,max=2000" example:"Nơi chém gió"`
	ImageURL    string `json:"imageUrl" binding:"omitempty,url" example:"https://example.com/room.jpg"`
	MaxMembers  int    `json:"maxMembers" binding:"omitempty,min=0" example:"100"`
	Index       int    `json:"index" binding:"omitempty,min=0" example:"0"`
}

type UpdateRoomRequest struct {
	Name        *string `json:"name" binding:"omitempty,min=1,max=150"`
	Description *string `json:"description" binding:"omitempty,max=2000"`
	ImageURL    *string `json:"imageUrl" binding:"omitempty,url"`
	MaxMembers  *int    `json:"maxMembers" binding:"omitempty,min=0"`
	Index       *int    `json:"index" binding:"omitempty,min=0"`
	Enabled     *bool   `json:"enabled"`
}

type RoomResponse struct {
	ID          string `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description,omitempty"`
	ImageURL    string `json:"imageUrl,omitempty"`
	MaxMembers  int    `json:"maxMembers"`
	Index       int    `json:"index"`
	MemberCount int    `json:"memberCount"`
	Enabled     bool   `json:"enabled"`
	CreatedBy   string `json:"createdBy"`
	CreatedAt   string `json:"createdAt"`
}

type RoomBrief struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	ImageURL string `json:"imageUrl,omitempty"`
}

type RoomListResponse struct {
	Items  []RoomResponse `json:"items"`
	Total  int64          `json:"total"`
	Limit  int            `json:"limit"`
	Offset int            `json:"offset"`
}

type RoomMemberResponse struct {
	UserID     string  `json:"userId"`
	Username   string  `json:"username"`
	FullName   string  `json:"fullName,omitempty"`
	Avatar     string  `json:"avatar,omitempty"`
	Gender     string  `json:"gender,omitempty"`
	Bio        string  `json:"bio,omitempty"`
	VipUsed    *string `json:"vipUsed,omitempty"`
	VipEndTime *string `json:"vipEndTime,omitempty"`
}

type RoomMembersResponse struct {
	Items []RoomMemberResponse `json:"items"`
	Total int                  `json:"total"`
}

type JoinRoomResponse struct {
	Ticket    string `json:"ticket"`
	ExpiresIn int    `json:"expiresIn"`
}

type SendRoomMessageRequest struct {
	Content string `json:"content" binding:"required,min=1,max=5000" example:"Xin chào cả phòng!"`
}

type RoomMessageResponse struct {
	ID           string  `json:"id"`
	RoomID       string  `json:"roomId"`
	SenderID     string  `json:"senderId"`
	SenderName   string  `json:"senderName,omitempty"`
	SenderAvatar string  `json:"senderAvatar,omitempty"`
	SenderGender string  `json:"senderGender,omitempty"`
	SenderVip    *string `json:"senderVip,omitempty"`
	SenderVipEnd *string `json:"senderVipEnd,omitempty"`
	Content      string  `json:"content"`
	CreatedAt    string  `json:"createdAt"`
}

type storedRoomMessage struct {
	ID        string `json:"id"`
	RoomID    string `json:"roomId"`
	SenderID  string `json:"senderId"`
	Content   string `json:"content"`
	CreatedAt string `json:"createdAt"`
}

type RoomMessagesListResponse struct {
	Items      []RoomMessageResponse `json:"items"`
	HasMore    bool                  `json:"hasMore"`
	NextBefore string                `json:"nextBefore,omitempty"`
}
