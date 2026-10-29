package call

import "time"

var CallRingTimeoutSeconds = 30

const (
	CallMaxDuration    = 12 * time.Hour
	CallRingStaleGrace = 15 * time.Second
)
