package room

type RoomData struct {
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
	Room      *RoomData        `json:"room"`
	Message   *RoomMessageData `json:"message"`
	MemberIDs []string         `json:"memberIds"`
}
