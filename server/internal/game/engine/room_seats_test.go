package engine

import (
	"testing"

	"ola-chat-server/internal/game/protocol"
)

func newSeatsTestEngine(t *testing.T, room Room) (*Engine, *memoryRoomStore, *captureEmitter) {
	t.Helper()
	gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
	t.Cleanup(func() { stopEngineTimers(gameEngine) })
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}
	return gameEngine, rooms, emitter
}

func storedCapacity(t *testing.T, rooms *memoryRoomStore, room Room) int {
	t.Helper()
	stored, ok := rooms.Get(room.GameID, room.ID)
	if !ok {
		t.Fatal("room disappeared")
	}
	return stored.capacity()
}

func (e *captureEmitter) lobbyMessages(messageType string) []protocol.OutEnvelope {
	e.mu.Lock()
	defer e.mu.Unlock()
	var out []protocol.OutEnvelope
	for _, message := range e.messages {
		if message.userID == "" && message.matchID == "" && message.roomID == "" && message.env.Type == messageType {
			out = append(out, message.env)
		}
	}
	return out
}

func lastErrorCode(emitter *captureEmitter, userID string) string {
	envelope, ok := emitter.last(userID, protocol.S2CError)
	if !ok {
		return ""
	}
	return envelope.Data.(protocol.ErrorData).Code
}

func TestOwnerClosesAndReopensSeats(t *testing.T) {
	room := thirteenRoom("seats-room", "tl-b")
	gameEngine, rooms, emitter := newSeatsTestEngine(t, room)

	gameEngine.SetRoomSeats(room.GameID, room.OwnerID, room.ID, 3)
	if got := storedCapacity(t, rooms, room); got != 3 {
		t.Fatalf("capacity %d, want 3", got)
	}
	state, ok := emitter.last("tl-b", protocol.S2CRoomState)
	if !ok || state.Data.(protocol.RoomStateData).MaxPlayers != 3 {
		t.Fatalf("guest did not see the closed seat: %+v", state)
	}
	upserts := emitter.lobbyMessages(protocol.S2CRoomUpsert)
	if len(upserts) == 0 || upserts[len(upserts)-1].Data.(protocol.RoomUpsertData).Room.MaxPlayers != 3 {
		t.Fatalf("lobby did not see the closed seat: %+v", upserts)
	}

	gameEngine.SetRoomSeats(room.GameID, room.OwnerID, room.ID, 2)
	gameEngine.JoinRoom(room.GameID, protocol.PlayerInfo{ID: "tl-c", Name: "tl-c"}, room.ID, "")
	if code := lastErrorCode(emitter, "tl-c"); code != protocol.ErrorCodeRoomFull {
		t.Fatalf("join into a closed seat: error %q, want %q", code, protocol.ErrorCodeRoomFull)
	}

	gameEngine.SetRoomSeats(room.GameID, room.OwnerID, room.ID, 4)
	if got := storedCapacity(t, rooms, room); got != 4 {
		t.Fatalf("capacity %d after reopening, want 4", got)
	}
}

func TestRoomSeatsRejectsInvalidChanges(t *testing.T) {
	room := thirteenRoom("seats-room", "tl-b", "tl-c")
	gameEngine, rooms, emitter := newSeatsTestEngine(t, room)

	for _, seats := range []int{1, 2, 5} {
		gameEngine.SetRoomSeats(room.GameID, room.OwnerID, room.ID, seats)
		if code := lastErrorCode(emitter, room.OwnerID); code != protocol.ErrorCodeRoomSeatsInvalid {
			t.Fatalf("%d seats: error %q, want %q", seats, code, protocol.ErrorCodeRoomSeatsInvalid)
		}
	}
	if got := storedCapacity(t, rooms, room); got != 4 {
		t.Fatalf("capacity changed to %d", got)
	}

	gameEngine.SetRoomSeats(room.GameID, "tl-b", room.ID, 3)
	if got := storedCapacity(t, rooms, room); got != 4 {
		t.Fatalf("a guest changed the seats to %d", got)
	}
}
