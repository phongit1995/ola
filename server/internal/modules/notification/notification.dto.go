package notification

type ActorResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName"`
	Avatar   string `json:"avatar"`
}

type AppNotificationResponse struct {
	ID        string         `json:"id"`
	Type      string         `json:"type"`
	Actor     *ActorResponse `json:"actor,omitempty"`
	RefID     string         `json:"refId,omitempty"`
	Preview   string         `json:"preview,omitempty"`
	IsRead    bool           `json:"isRead"`
	CreatedAt string         `json:"createdAt"`
}

type AppNotificationListResponse struct {
	Items       []AppNotificationResponse `json:"items"`
	UnreadCount int64                     `json:"unreadCount"`
	NextCursor  string                    `json:"nextCursor,omitempty"`
}
