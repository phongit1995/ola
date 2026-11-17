package game

import "time"

const (
	VoiceRoomNameFormat = "game:%s:%s"
	VoiceTokenTTL       = 2 * time.Minute
	VoiceRevokeTimeout  = 5 * time.Second
)
