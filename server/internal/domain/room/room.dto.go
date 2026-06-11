package room

type RoomBrief struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	ImageURL string `json:"imageUrl,omitempty"`
}

type RoomMessageData struct {
	ID           string `json:"id"`
	RoomID       string `json:"roomId"`
	SenderID     string `json:"senderId"`
	SenderName   string `json:"senderName,omitempty"`
	SenderAvatar string `json:"senderAvatar,omitempty"`
	Content      string `json:"content"`
	CreatedAt    string `json:"createdAt"`
}

type RoomMessageCreatedEvent struct {
	Room    *RoomBrief       `json:"room"`
	Message *RoomMessageData `json:"message"`
}

type RoomMessageDeletedEvent struct {
	RoomID    string `json:"roomId"`
	MessageID string `json:"messageId"`
}
