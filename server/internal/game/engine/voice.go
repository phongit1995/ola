package engine

type VoiceRole uint8

const (
	VoiceRoleNone VoiceRole = iota
	VoiceRoleListener
	VoiceRoleSpeaker
)

type VoiceAccess struct {
	RoomID  string
	Enabled bool
	Role    VoiceRole
}

// VoiceAccess resolves a voice seat for a waiting room or, once the room has
// moved into a match, from the persisted match snapshot so any game instance
// can answer. watchingRoom tells whether the caller's socket watches roomID.
func (e *Engine) VoiceAccess(gameID, userID, roomID, matchID string, watchingRoom bool) (VoiceAccess, error) {
	if roomID != "" {
		if room, ok := e.store.Get(gameID, roomID); ok {
			return roomVoiceAccess(room, userID, watchingRoom), nil
		}
	}
	if matchID == "" {
		if m := e.matchForUser(gameID, userID); m != nil {
			matchID = m.ID
		}
	}
	if matchID == "" {
		return VoiceAccess{}, nil
	}
	access, err := e.matchVoiceAccess(gameID, userID, matchID)
	if err != nil || (roomID != "" && access.RoomID != roomID) {
		return VoiceAccess{}, err
	}
	return access, nil
}

func roomVoiceAccess(room Room, userID string, watchingRoom bool) VoiceAccess {
	access := VoiceAccess{RoomID: room.ID, Enabled: room.VoiceEnabled}
	switch {
	case room.hasMember(userID):
		access.Role = VoiceRoleSpeaker
	case watchingRoom && spectatorsAllowed(&room):
		access.Role = VoiceRoleListener
	}
	return access
}

func (e *Engine) matchVoiceAccess(gameID, userID, matchID string) (VoiceAccess, error) {
	snapshot, ok, err := e.activeStore.Get(gameID, matchID)
	if err != nil {
		return VoiceAccess{}, err
	}
	if !ok || snapshot.Status != matchStatusPlaying || snapshot.Room == nil {
		return VoiceAccess{}, nil
	}
	access := VoiceAccess{RoomID: snapshot.Room.ID, Enabled: snapshot.Room.VoiceEnabled}
	if seatOf(snapshot.Players, userID) >= 0 {
		access.Role = VoiceRoleSpeaker
		return access, nil
	}
	if !spectatorsAllowed(snapshot.Room) {
		return access, nil
	}
	viewers, err := e.activeStore.Spectators(gameID, matchID)
	if err != nil {
		return VoiceAccess{}, err
	}
	if seatOf(viewers, userID) >= 0 {
		access.Role = VoiceRoleListener
	}
	return access, nil
}
