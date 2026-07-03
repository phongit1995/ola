package menotification

import "encoding/json"

type Event struct {
	RecipientID  string          `json:"recipientId"`
	Notification json.RawMessage `json:"notification"`
	UnreadCount  int64           `json:"unreadCount"`
}
