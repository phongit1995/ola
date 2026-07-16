package appnotification

import "encoding/json"

type Event struct {
	RecipientID  string          `json:"recipientId"`
	Notification json.RawMessage `json:"notification,omitempty"`
	RemovedID    string          `json:"removedId,omitempty"`
	UnreadCount  int64           `json:"unreadCount"`
}
