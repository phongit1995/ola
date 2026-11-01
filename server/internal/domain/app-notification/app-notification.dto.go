package appnotification

import "encoding/json"

type PushDevice struct {
	Token    string `json:"token"`
	Platform string `json:"platform"`
}

type Event struct {
	RecipientID  string          `json:"recipientId"`
	Notification json.RawMessage `json:"notification,omitempty"`
	RemovedID    string          `json:"removedId,omitempty"`
	UnreadCount  int64           `json:"unreadCount"`
	PushDevices  []PushDevice    `json:"pushDevices,omitempty"`
}
