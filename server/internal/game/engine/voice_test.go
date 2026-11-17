package engine

import (
	"slices"
	"sync"
	"testing"
)

type voiceRevokeCall struct {
	gameID string
	roomID string
	userID string
}

type fakeVoiceRevoker struct {
	mu      sync.Mutex
	removed []voiceRevokeCall
	closed  []voiceRevokeCall
}

func (f *fakeVoiceRevoker) RemoveVoiceMember(gameID, roomID, userID string) {
	f.mu.Lock()
	defer f.mu.Unlock()
	f.removed = append(f.removed, voiceRevokeCall{gameID: gameID, roomID: roomID, userID: userID})
}

func (f *fakeVoiceRevoker) CloseVoiceRoom(gameID, roomID string) {
	f.mu.Lock()
	defer f.mu.Unlock()
	f.closed = append(f.closed, voiceRevokeCall{gameID: gameID, roomID: roomID})
}

func (f *fakeVoiceRevoker) snapshot() ([]voiceRevokeCall, []voiceRevokeCall) {
	f.mu.Lock()
	defer f.mu.Unlock()
	return slices.Clone(f.removed), slices.Clone(f.closed)
}

func newVoiceRevokeTestEngine(t *testing.T, room Room) (*Engine, *fakeVoiceRevoker) {
	t.Helper()
	gameEngine, rooms, _ := newPersistenceTestEngine(newMemoryActiveMatchStore())
	t.Cleanup(func() { stopEngineTimers(gameEngine) })
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}
	revoker := &fakeVoiceRevoker{}
	gameEngine.SetVoiceRevoker(revoker)
	return gameEngine, revoker
}

func voiceRoom(id string, voice bool, guestIDs ...string) Room {
	room := thirteenRoom(id, guestIDs...)
	room.VoiceEnabled = voice
	return room
}

func TestVoiceRevokedWhenGuestLeaves(t *testing.T) {
	room := voiceRoom("voice-room", true, "tl-b", "tl-c")
	gameEngine, revoker := newVoiceRevokeTestEngine(t, room)
	gameEngine.LeaveRoom(room.GameID, "tl-b", room.ID)
	removed, closed := revoker.snapshot()
	want := []voiceRevokeCall{{gameID: room.GameID, roomID: room.ID, userID: "tl-b"}}
	if !slices.Equal(removed, want) || len(closed) != 0 {
		t.Fatalf("removed %+v closed %+v, want removed %+v", removed, closed, want)
	}
}

func TestVoiceRevokedWhenGuestIsKicked(t *testing.T) {
	room := voiceRoom("voice-room", true, "tl-b", "tl-c")
	gameEngine, revoker := newVoiceRevokeTestEngine(t, room)
	gameEngine.KickRoomMember(room.GameID, room.OwnerID, room.ID, "tl-b")
	removed, closed := revoker.snapshot()
	want := []voiceRevokeCall{{gameID: room.GameID, roomID: room.ID, userID: "tl-b"}}
	if !slices.Equal(removed, want) || len(closed) != 0 {
		t.Fatalf("removed %+v closed %+v, want removed %+v", removed, closed, want)
	}
	if access, err := gameEngine.VoiceAccess(room.GameID, "tl-b", room.ID, "", false); err != nil || access.Role != VoiceRoleNone {
		t.Fatalf("kicked guest still gets voice: %+v (%v)", access, err)
	}
}

func TestVoiceRoomClosedWhenOwnerLeaves(t *testing.T) {
	room := voiceRoom("voice-room", true, "tl-b")
	gameEngine, revoker := newVoiceRevokeTestEngine(t, room)
	gameEngine.LeaveRoom(room.GameID, room.OwnerID, room.ID)
	removed, closed := revoker.snapshot()
	want := []voiceRevokeCall{{gameID: room.GameID, roomID: room.ID}}
	if len(removed) != 0 || !slices.Equal(closed, want) {
		t.Fatalf("removed %+v closed %+v, want closed %+v", removed, closed, want)
	}
}

func TestVoiceRevokeSkipsRoomsWithoutVoice(t *testing.T) {
	room := voiceRoom("silent-room", false, "tl-b", "tl-c")
	gameEngine, revoker := newVoiceRevokeTestEngine(t, room)
	gameEngine.KickRoomMember(room.GameID, room.OwnerID, room.ID, "tl-b")
	gameEngine.LeaveRoom(room.GameID, "tl-c", room.ID)
	gameEngine.LeaveRoom(room.GameID, room.OwnerID, room.ID)
	if removed, closed := revoker.snapshot(); len(removed) != 0 || len(closed) != 0 {
		t.Fatalf("voiceless room touched voice: removed %+v closed %+v", removed, closed)
	}
}

func TestVoiceRevokedWhenPlayerQuitsMatchAndLeaves(t *testing.T) {
	room := voiceRoom("voice-room", true, "tl-b", "tl-c")
	var (
		gameEngine *Engine
		revoker    *fakeVoiceRevoker
		match      *Match
	)
	for attempt := 0; attempt < 20 && match == nil; attempt++ {
		var rooms *memoryRoomStore
		gameEngine, rooms, _ = newPersistenceTestEngine(newMemoryActiveMatchStore())
		if err := rooms.Save(room); err != nil {
			t.Fatal(err)
		}
		revoker = &fakeVoiceRevoker{}
		gameEngine.SetVoiceRevoker(revoker)
		gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)
		if match = onlyMatch(t, gameEngine); match == nil {
			stopEngineTimers(gameEngine)
		}
	}
	if match == nil {
		t.Fatal("every deal ended in an instant win")
	}
	defer stopEngineTimers(gameEngine)

	gameEngine.ForfeitAndLeave(room.GameID, "tl-c", match.ID)
	removed, _ := revoker.snapshot()
	want := []voiceRevokeCall{{gameID: room.GameID, roomID: room.ID, userID: "tl-c"}}
	if !slices.Equal(removed, want) {
		t.Fatalf("removed %+v, want %+v", removed, want)
	}
	if access, err := gameEngine.VoiceAccess(room.GameID, "tl-c", "", match.ID, false); err != nil || access.Role == VoiceRoleSpeaker {
		t.Fatalf("player who left still speaks: %+v (%v)", access, err)
	}
	if access, err := gameEngine.VoiceAccess(room.GameID, "tl-b", "", match.ID, false); err != nil || access.Role != VoiceRoleSpeaker {
		t.Fatalf("remaining player lost voice: %+v (%v)", access, err)
	}
}
