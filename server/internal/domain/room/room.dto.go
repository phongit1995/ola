package room

type RoomBrief struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	ImageURL string `json:"imageUrl,omitempty"`
}

type RoomReplySnapshot struct {
	MessageID  string `json:"messageId"`
	SenderID   string `json:"senderId"`
	SenderName string `json:"senderName,omitempty"`
	Excerpt    string `json:"excerpt"`
	Type       string `json:"type,omitempty"`
	ImageURL   string `json:"imageUrl,omitempty"`
}

type RoomReactor struct {
	UserID   string `json:"userId"`
	Username string `json:"username"`
}

type RoomMessageData struct {
	ID           string             `json:"id"`
	RoomID       string             `json:"roomId"`
	SenderID     string             `json:"senderId"`
	SenderName   string             `json:"senderName,omitempty"`
	SenderAvatar string             `json:"senderAvatar,omitempty"`
	SenderGender string             `json:"senderGender,omitempty"`
	SenderVip    *string            `json:"senderVip,omitempty"`
	SenderVipEnd *string            `json:"senderVipEnd,omitempty"`
	Type         string             `json:"type,omitempty"`
	Content      string             `json:"content"`
	ImageURL     string             `json:"imageUrl,omitempty"`
	CreatedAt    string             `json:"createdAt"`
	ReplyTo      *RoomReplySnapshot `json:"replyTo,omitempty"`
}

type RoomMessageCreatedEvent struct {
	Room    *RoomBrief       `json:"room"`
	Message *RoomMessageData `json:"message"`
}

type RoomMessageDeletedEvent struct {
	RoomID    string `json:"roomId"`
	MessageID string `json:"messageId"`
}

type RoomMessageReactionUpdatedEvent struct {
	RoomID        string                   `json:"roomId"`
	MessageID     string                   `json:"messageId"`
	Reactions     map[string][]RoomReactor `json:"reactions"`
	ActorUserID   string                   `json:"actorUserId"`
	ActorUsername string                   `json:"actorUsername"`
	Type          string                   `json:"type"`
	Action        string                   `json:"action"`
}
