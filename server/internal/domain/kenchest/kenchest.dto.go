package kenchest

import "time"

type ChestAvailableEvent struct {
	ID              string    `json:"id"`
	ExpiresAt       time.Time `json:"expiresAt"`
	DurationSeconds int       `json:"durationSeconds"`
}

type ChestClosedEvent struct {
	ID string `json:"id"`
}
