package engine

import (
	"encoding/json"
	"strings"
	"testing"
	"time"

	"ola-chat-server/internal/game/protocol"
)

func (e *captureEmitter) clear() {
	e.mu.Lock()
	defer e.mu.Unlock()
	e.messages = nil
}

func (e *captureEmitter) count(userID, messageType string) int {
	e.mu.Lock()
	defer e.mu.Unlock()
	count := 0
	for _, message := range e.messages {
		if message.userID == userID && message.env.Type == messageType {
			count++
		}
	}
	return count
}

func requireErrorCode(t *testing.T, emitter *captureEmitter, userID, code string) {
	t.Helper()
	envelope, ok := emitter.last(userID, protocol.S2CError)
	if !ok {
		t.Fatalf("expected error %s for %s", code, userID)
	}
	data, ok := envelope.Data.(protocol.ErrorData)
	if !ok || data.Code != code {
		t.Fatalf("expected error %s, got %#v", code, envelope.Data)
	}
}

func requireRoomUpsert(t *testing.T, emitter *captureEmitter, roomID string, players int) {
	t.Helper()
	envelope, ok := emitter.last("", protocol.S2CRoomUpsert)
	if !ok {
		t.Fatalf("expected ROOM_UPSERT for %s", roomID)
	}
	data, ok := envelope.Data.(protocol.RoomUpsertData)
	if !ok || data.Room.ID != roomID || data.Room.Players != players {
		t.Fatalf("unexpected room upsert: %#v", envelope.Data)
	}
}

func requireRoomRemoved(t *testing.T, emitter *captureEmitter, roomID string) {
	t.Helper()
	envelope, ok := emitter.last("", protocol.S2CRoomRemoved)
	if !ok {
		t.Fatalf("expected ROOM_REMOVED for %s", roomID)
	}
	data, ok := envelope.Data.(protocol.RoomRemovedData)
	if !ok || data.RoomID != roomID {
		t.Fatalf("unexpected room removal: %#v", envelope.Data)
	}
}

func lifecyclePlayer(id string) protocol.PlayerInfo {
	return protocol.PlayerInfo{ID: id, Name: strings.ToUpper(id)}
}

func lifecycleRoom(id string) Room {
	return Room{
		ID:        id,
		GameID:    persistenceTestGameID,
		OwnerID:   "owner",
		OwnerName: "OWNER",
		Bet:       25,
		CreatedAt: time.Now().UnixMilli(),
	}
}

func onlyRoom(t *testing.T, store *memoryRoomStore) Room {
	t.Helper()
	rooms, err := store.List(persistenceTestGameID)
	if err != nil {
		t.Fatal(err)
	}
	if len(rooms) != 1 {
		t.Fatalf("expected one room, got %d", len(rooms))
	}
	return rooms[0]
}

func TestCreateRoomValidationAndIdempotency(t *testing.T) {
	t.Run("validation", func(t *testing.T) {
		tests := []struct {
			name     string
			gameID   string
			bet      int
			password string
			code     string
		}{
			{name: "unknown game", gameID: "missing-game", code: "UNKNOWN_GAME"},
			{name: "negative bet", gameID: persistenceTestGameID, bet: -1, code: "INVALID_BET"},
			{name: "long password", gameID: persistenceTestGameID, password: strings.Repeat("x", 65), code: "INVALID_PASSWORD"},
		}
		for _, test := range tests {
			t.Run(test.name, func(t *testing.T) {
				gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
				gameEngine.CreateRoom(test.gameID, lifecyclePlayer("owner"), test.bet, test.password)
				requireErrorCode(t, emitter, "owner", test.code)
				if len(rooms.rooms) != 0 {
					t.Fatal("invalid request created a room")
				}
			})
		}
	})

	t.Run("store failure", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		rooms.failSave = true
		gameEngine.CreateRoom(persistenceTestGameID, lifecyclePlayer("owner"), 10, "")
		requireErrorCode(t, emitter, "owner", "ROOM_CREATE_FAILED")
	})

	t.Run("success leaves queue and is idempotent", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		gameEngine.queues[persistenceTestGameID] = []protocol.PlayerInfo{lifecyclePlayer("owner")}
		gameEngine.CreateRoom(persistenceTestGameID, lifecyclePlayer("owner"), 10, "secret")
		room := onlyRoom(t, rooms)
		if room.Bet != 10 || room.Password != "secret" || len(gameEngine.queues[persistenceTestGameID]) != 0 {
			t.Fatalf("unexpected created room: %+v", room)
		}
		if emitter.count("owner", protocol.S2CRoomWaiting) != 1 || emitter.count("owner", protocol.S2CRoomState) != 1 {
			t.Fatal("owner did not receive initial room events")
		}
		requireRoomUpsert(t, emitter, room.ID, 1)

		gameEngine.CreateRoom(persistenceTestGameID, lifecyclePlayer("owner"), 999, "different")
		if repeated := onlyRoom(t, rooms); repeated.ID != room.ID || repeated.Bet != room.Bet {
			t.Fatalf("idempotent create replaced the room: %+v", repeated)
		}
	})
}

func TestJoinRoomValidationAndSuccess(t *testing.T) {
	t.Run("missing room id", func(t *testing.T) {
		gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		gameEngine.JoinRoom(persistenceTestGameID, lifecyclePlayer("guest"), "", "")
		requireErrorCode(t, emitter, "guest", "ROOM_NOT_FOUND")
	})

	t.Run("room busy", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		rooms.claimOK = false
		gameEngine.JoinRoom(persistenceTestGameID, lifecyclePlayer("guest"), "room", "")
		requireErrorCode(t, emitter, "guest", "ROOM_BUSY")
	})

	t.Run("room not found", func(t *testing.T) {
		gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		gameEngine.JoinRoom(persistenceTestGameID, lifecyclePlayer("guest"), "missing", "")
		requireErrorCode(t, emitter, "guest", "ROOM_NOT_FOUND")
	})

	t.Run("own room without membership index", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("room")
		rooms.rooms[memoryRoomKey(room.GameID, room.ID)] = room
		gameEngine.JoinRoom(persistenceTestGameID, lifecyclePlayer("owner"), room.ID, "")
		requireErrorCode(t, emitter, "owner", "OWN_ROOM")
	})

	t.Run("wrong password", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("room")
		room.Password = "secret"
		_ = rooms.Save(room)
		gameEngine.JoinRoom(persistenceTestGameID, lifecyclePlayer("guest"), room.ID, "wrong")
		requireErrorCode(t, emitter, "guest", "WRONG_PASSWORD")
	})

	t.Run("room full", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("room")
		room.GuestID = "existing"
		room.GuestName = "EXISTING"
		_ = rooms.Save(room)
		gameEngine.JoinRoom(persistenceTestGameID, lifecyclePlayer("guest"), room.ID, "")
		requireErrorCode(t, emitter, "guest", "ROOM_FULL")
	})

	t.Run("already in another room", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		current := lifecycleRoom("current")
		current.GuestID = "guest"
		current.GuestName = "GUEST"
		target := lifecycleRoom("target")
		target.OwnerID = "other-owner"
		_ = rooms.Save(current)
		_ = rooms.Save(target)
		gameEngine.JoinRoom(persistenceTestGameID, lifecyclePlayer("guest"), target.ID, "")
		requireErrorCode(t, emitter, "guest", "ALREADY_IN_ROOM")
	})

	t.Run("save failure", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("room")
		_ = rooms.Save(room)
		rooms.failSave = true
		gameEngine.JoinRoom(persistenceTestGameID, lifecyclePlayer("guest"), room.ID, "")
		requireErrorCode(t, emitter, "guest", "ROOM_JOIN_FAILED")
	})

	t.Run("success and idempotent retry", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("room")
		room.Password = "secret"
		_ = rooms.Save(room)
		gameEngine.queues[persistenceTestGameID] = []protocol.PlayerInfo{lifecyclePlayer("guest")}

		gameEngine.JoinRoom(persistenceTestGameID, lifecyclePlayer("guest"), room.ID, "secret")
		joined, ok := rooms.Get(room.GameID, room.ID)
		if !ok || joined.GuestID != "guest" || joined.GuestReady || len(gameEngine.queues[persistenceTestGameID]) != 0 {
			t.Fatalf("unexpected joined room: %+v", joined)
		}
		if emitter.count("owner", protocol.S2CRoomState) != 1 || emitter.count("guest", protocol.S2CRoomState) != 1 {
			t.Fatal("room state was not broadcast to both players")
		}
		requireRoomUpsert(t, emitter, room.ID, 2)

		emitter.clear()
		gameEngine.JoinRoom(persistenceTestGameID, lifecyclePlayer("guest"), room.ID, "secret")
		if emitter.count("guest", protocol.S2CRoomWaiting) != 1 || emitter.count("guest", protocol.S2CRoomState) != 1 {
			t.Fatal("idempotent join did not restore the guest room view")
		}
	})
}

func TestRoomLeaveAndDisconnectLifecycle(t *testing.T) {
	tests := []struct {
		name           string
		userID         string
		disconnect     bool
		closedReason   string
		roomShouldLive bool
	}{
		{name: "owner leaves", userID: "owner", closedReason: "owner_left"},
		{name: "owner disconnects", userID: "owner", disconnect: true, closedReason: "owner_disconnected"},
		{name: "guest leaves", userID: "guest", roomShouldLive: true},
		{name: "guest disconnects", userID: "guest", disconnect: true, roomShouldLive: true},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
			room := lifecycleRoom("room")
			room.GuestID = "guest"
			room.GuestName = "GUEST"
			room.GuestReady = true
			_ = rooms.Save(room)

			if test.disconnect {
				gameEngine.OnDisconnect(room.GameID, test.userID)
			} else {
				gameEngine.LeaveRoom(room.GameID, test.userID, room.ID)
			}

			stored, exists := rooms.Get(room.GameID, room.ID)
			if exists != test.roomShouldLive {
				t.Fatalf("room existence = %v, want %v", exists, test.roomShouldLive)
			}
			if test.roomShouldLive {
				if stored.GuestID != "" || stored.GuestReady {
					t.Fatalf("guest was not removed cleanly: %+v", stored)
				}
				if _, ok := rooms.RoomByUser(room.GameID, "guest"); ok {
					t.Fatal("guest membership index remains")
				}
				if emitter.count("owner", protocol.S2CRoomState) != 1 {
					t.Fatal("owner did not receive updated room state")
				}
				wantGuestClose := 1
				if test.disconnect {
					wantGuestClose = 0
				}
				if emitter.count("guest", protocol.S2CRoomClosed) != wantGuestClose {
					t.Fatal("unexpected guest close event count")
				}
				if !test.disconnect {
					envelope, ok := emitter.last("guest", protocol.S2CRoomClosed)
					if !ok || envelope.Data.(protocol.RoomClosedData).Reason != "guest_left" {
						t.Fatalf("guest did not receive its leave confirmation: %#v", envelope.Data)
					}
				}
				requireRoomUpsert(t, emitter, room.ID, 1)
				return
			}
			requireRoomRemoved(t, emitter, room.ID)

			for _, userID := range []string{"owner", "guest"} {
				if _, ok := rooms.RoomByUser(room.GameID, userID); ok {
					t.Fatalf("membership remains for %s", userID)
				}
				envelope, ok := emitter.last(userID, protocol.S2CRoomClosed)
				if !ok || envelope.Data.(protocol.RoomClosedData).Reason != test.closedReason {
					t.Fatalf("unexpected room close for %s: %#v", userID, envelope.Data)
				}
			}
		})
	}

	t.Run("owner delete failure keeps room visible", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("room-delete-failure")
		room.GuestID = "guest"
		room.GuestName = "GUEST"
		_ = rooms.Save(room)
		rooms.failDelete = true

		gameEngine.LeaveRoom(room.GameID, room.OwnerID, room.ID)
		if _, exists := rooms.Get(room.GameID, room.ID); !exists {
			t.Fatal("room disappeared after failed Redis delete")
		}
		requireErrorCode(t, emitter, room.OwnerID, "ROOM_LEAVE_FAILED")
		if emitter.count("", protocol.S2CRoomRemoved) != 0 || emitter.count(room.GuestID, protocol.S2CRoomClosed) != 0 {
			t.Fatal("failed room delete emitted a false removal")
		}
	})
}

func TestRoomReadyKickAndActionErrors(t *testing.T) {
	t.Run("ready is saved and broadcast", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("room")
		room.GuestID = "guest"
		room.GuestName = "GUEST"
		_ = rooms.Save(room)
		gameEngine.SetRoomReady(room.GameID, "guest", room.ID, true)
		updated, _ := rooms.Get(room.GameID, room.ID)
		if !updated.GuestReady {
			t.Fatalf("ready state was not saved: %+v", updated)
		}
		if emitter.count("owner", protocol.S2CRoomState) != 1 || emitter.count("guest", protocol.S2CRoomState) != 1 {
			t.Fatal("ready state was not broadcast")
		}
	})

	t.Run("action validation", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		gameEngine.SetRoomReady(persistenceTestGameID, "guest", "", true)
		requireErrorCode(t, emitter, "guest", "ROOM_NOT_FOUND")

		room := lifecycleRoom("room")
		room.GuestID = "guest"
		room.GuestName = "GUEST"
		_ = rooms.Save(room)
		rooms.claimOK = false
		gameEngine.SetRoomReady(room.GameID, "guest", room.ID, true)
		requireErrorCode(t, emitter, "guest", "ROOM_BUSY")
	})

	t.Run("ready save failure", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("room")
		room.GuestID = "guest"
		room.GuestName = "GUEST"
		_ = rooms.Save(room)
		rooms.failSave = true
		gameEngine.SetRoomReady(room.GameID, "guest", room.ID, true)
		requireErrorCode(t, emitter, "guest", "ROOM_UPDATE_FAILED")
	})

	t.Run("kick validation and success", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("room")
		room.GuestID = "guest"
		room.GuestName = "GUEST"
		room.GuestReady = true
		_ = rooms.Save(room)

		gameEngine.KickRoomMember(room.GameID, "guest", room.ID, "owner")
		requireErrorCode(t, emitter, "guest", "NOT_ROOM_OWNER")
		gameEngine.KickRoomMember(room.GameID, "owner", room.ID, "someone-else")
		requireErrorCode(t, emitter, "owner", "ROOM_MEMBER_NOT_FOUND")

		emitter.clear()
		gameEngine.KickRoomMember(room.GameID, "owner", room.ID, "guest")
		updated, _ := rooms.Get(room.GameID, room.ID)
		if updated.GuestID != "" || updated.GuestReady {
			t.Fatalf("kicked guest remains in room: %+v", updated)
		}
		if _, ok := rooms.RoomByUser(room.GameID, "guest"); ok {
			t.Fatal("kicked guest membership remains")
		}
		if emitter.count("guest", protocol.S2CRoomKicked) != 1 || emitter.count("owner", protocol.S2CRoomState) != 1 {
			t.Fatal("kick events were not sent")
		}
		requireRoomUpsert(t, emitter, room.ID, 1)
	})
}

func TestStartRoomValidationAndSuccess(t *testing.T) {
	tests := []struct {
		name      string
		room      Room
		actor     string
		configure func(*memoryRoomStore)
		code      string
	}{
		{name: "not owner", room: func() Room { r := lifecycleRoom("room"); r.GuestID = "guest"; return r }(), actor: "guest", code: "NOT_ROOM_OWNER"},
		{name: "not full", room: lifecycleRoom("room"), actor: "owner", code: "ROOM_NOT_FULL"},
		{name: "not ready", room: func() Room { r := lifecycleRoom("room"); r.GuestID = "guest"; return r }(), actor: "owner", code: "ROOM_NOT_READY"},
		{name: "delete failure", room: func() Room {
			r := lifecycleRoom("room")
			r.GuestID = "guest"
			r.GuestReady = true
			return r
		}(), actor: "owner", configure: func(s *memoryRoomStore) { s.failDelete = true }, code: "ROOM_START_FAILED"},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
			test.room.GuestName = "GUEST"
			_ = rooms.Save(test.room)
			if test.configure != nil {
				test.configure(rooms)
			}
			gameEngine.StartRoom(test.room.GameID, test.actor, test.room.ID)
			requireErrorCode(t, emitter, test.actor, test.code)
			if len(gameEngine.matches) != 0 {
				t.Fatal("invalid room start created a match")
			}
		})
	}

	t.Run("success", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		defer stopEngineTimers(gameEngine)
		room := lifecycleRoom("room")
		room.GuestID = "guest"
		room.GuestName = "GUEST"
		room.GuestReady = true
		_ = rooms.Save(room)
		gameEngine.StartRoom(room.GameID, "owner", room.ID)
		if _, ok := rooms.Get(room.GameID, room.ID); ok || len(gameEngine.matches) != 1 {
			t.Fatal("ready room was not converted into a match")
		}
		for _, userID := range []string{"owner", "guest"} {
			if emitter.count(userID, protocol.S2CMatchFound) != 1 {
				t.Fatalf("%s did not receive MATCH_FOUND", userID)
			}
		}
		for _, match := range gameEngine.matches {
			if match.bet != room.Bet {
				t.Fatalf("room bet was not carried into match: %d", match.bet)
			}
		}
		requireRoomRemoved(t, emitter, room.ID)
	})
}

func TestFinishedRoomMatchReturnsWithGuestUnready(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, rooms, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	room := lifecycleRoom("room-next-round")
	room.Password = "secret"
	room.GuestID = "guest"
	room.GuestName = "GUEST"
	room.GuestReady = true
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}

	gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)
	var match *Match
	for _, current := range gameEngine.matches {
		match = current
	}
	if match == nil || match.room == nil || match.room.ID != room.ID {
		t.Fatal("started match did not retain its waiting-room metadata")
	}
	snapshot, ok := activeStore.get(room.GameID, match.ID)
	if !ok || snapshot.Room == nil || snapshot.Room.ID != room.ID {
		t.Fatal("active snapshot did not persist its waiting-room metadata")
	}

	emitter.clear()
	gameEngine.Forfeit(room.GameID, room.GuestID, match.ID)
	returned, ok := rooms.Get(room.GameID, room.ID)
	if !ok {
		t.Fatal("finished room match did not restore the waiting room")
	}
	if returned.OwnerID != room.OwnerID || returned.GuestID != room.GuestID || returned.Password != room.Password {
		t.Fatalf("restored room lost its identity or members: %+v", returned)
	}
	if returned.GuestReady {
		t.Fatalf("finished room did not reset guest readiness: %+v", returned)
	}
	for _, userID := range []string{room.OwnerID, room.GuestID} {
		if emitter.count(userID, protocol.S2CMatchOver) != 1 || emitter.count(userID, protocol.S2CRoomState) != 1 {
			t.Fatalf("%s did not receive the result and next-round room state", userID)
		}
	}
	requireRoomUpsert(t, emitter, room.ID, 2)

	gameEngine.SetRoomReady(room.GameID, room.GuestID, room.ID, true)
	gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)
	if _, exists := rooms.Get(room.GameID, room.ID); exists || len(gameEngine.matches) != 1 {
		t.Fatal("next round did not start after only the guest became ready")
	}
}

func TestOwnerExitMatchDoesNotRestoreWaitingRoom(t *testing.T) {
	gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
	defer stopEngineTimers(gameEngine)
	room := lifecycleRoom("room-exit")
	room.GuestID = "guest"
	room.GuestName = "GUEST"
	room.GuestReady = true
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}

	gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)
	var match *Match
	for _, current := range gameEngine.matches {
		match = current
	}
	if match == nil {
		t.Fatal("room match was not started")
	}
	emitter.clear()
	gameEngine.ForfeitAndLeave(room.GameID, room.OwnerID, match.ID)
	if _, exists := rooms.Get(room.GameID, room.ID); exists {
		t.Fatal("explicit match exit unexpectedly restored the waiting room")
	}
	if emitter.count(room.OwnerID, protocol.S2CRoomState) != 0 || emitter.count(room.GuestID, protocol.S2CRoomState) != 0 {
		t.Fatal("explicit match exit emitted a next-round room state")
	}
}

func TestGuestExitMatchReturnsOwnerToWaitingRoom(t *testing.T) {
	gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
	defer stopEngineTimers(gameEngine)
	room := lifecycleRoom("room-guest-exit")
	room.GuestID = "guest"
	room.GuestName = "GUEST"
	room.GuestReady = true
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}

	gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)
	var match *Match
	for _, current := range gameEngine.matches {
		match = current
	}
	if match == nil {
		t.Fatal("room match was not started")
	}
	emitter.clear()
	gameEngine.ForfeitAndLeave(room.GameID, room.GuestID, match.ID)

	returned, exists := rooms.Get(room.GameID, room.ID)
	if !exists || returned.OwnerID != room.OwnerID || returned.GuestID != "" || returned.GuestReady {
		t.Fatalf("owner did not retain an empty waiting room after guest exit: %+v", returned)
	}
	if emitter.count(room.OwnerID, protocol.S2CRoomState) != 1 {
		t.Fatal("owner did not receive the restored waiting-room state")
	}
	if emitter.count(room.GuestID, protocol.S2CRoomState) != 0 {
		t.Fatal("exiting guest received the restored room state")
	}
	requireRoomUpsert(t, emitter, room.ID, 1)
}

func TestGuestDisconnectExpiryReturnsOwnerToWaitingRoom(t *testing.T) {
	gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
	defer stopEngineTimers(gameEngine)
	room := lifecycleRoom("room-guest-disconnect")
	room.GuestID = "guest"
	room.GuestName = "GUEST"
	room.GuestReady = true
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}

	gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)
	var match *Match
	for _, current := range gameEngine.matches {
		match = current
	}
	if match == nil {
		t.Fatal("room match was not started")
	}
	emitter.clear()
	gameEngine.OnDisconnect(room.GameID, room.GuestID)
	if match.graceTimer != nil {
		match.graceTimer.Stop()
	}
	gameEngine.onGraceExpire(match.ID, match.graceGen)

	returned, exists := rooms.Get(room.GameID, room.ID)
	if !exists || returned.OwnerID != room.OwnerID || returned.GuestID != "" || returned.GuestReady {
		t.Fatalf("owner did not retain an empty room after guest disconnect expiry: %+v", returned)
	}
	if emitter.count(room.OwnerID, protocol.S2CRoomState) != 1 {
		t.Fatal("owner did not receive waiting-room state after guest disconnect expiry")
	}
	requireRoomUpsert(t, emitter, room.ID, 1)
}

func TestQueueLifecycleAndRoomConflict(t *testing.T) {
	t.Run("unknown game", func(t *testing.T) {
		gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		gameEngine.JoinQueue("missing-game", lifecyclePlayer("player"))
		requireErrorCode(t, emitter, "player", "UNKNOWN_GAME")
	})

	t.Run("wait duplicate and leave", func(t *testing.T) {
		gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		player := lifecyclePlayer("player")
		gameEngine.JoinQueue(persistenceTestGameID, player)
		gameEngine.JoinQueue(persistenceTestGameID, player)
		if len(gameEngine.queues[persistenceTestGameID]) != 1 || emitter.count(player.ID, protocol.S2CQueueWaiting) != 2 {
			t.Fatal("queue join was not idempotent")
		}
		gameEngine.LeaveQueue(persistenceTestGameID, player.ID)
		if len(gameEngine.queues[persistenceTestGameID]) != 0 {
			t.Fatal("player remains in queue after leave")
		}
	})

	t.Run("room member cannot queue", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("room")
		_ = rooms.Save(room)
		gameEngine.JoinQueue(room.GameID, lifecyclePlayer("owner"))
		requireErrorCode(t, emitter, "owner", "IN_ROOM")
		if len(gameEngine.queues[room.GameID]) != 0 || emitter.count("owner", protocol.S2CRoomState) != 1 {
			t.Fatal("room member entered queue or did not recover room state")
		}
	})

	t.Run("two players are matched", func(t *testing.T) {
		gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		defer stopEngineTimers(gameEngine)
		gameEngine.JoinQueue(persistenceTestGameID, lifecyclePlayer("a"))
		gameEngine.JoinQueue(persistenceTestGameID, lifecyclePlayer("b"))
		if len(gameEngine.queues[persistenceTestGameID]) != 0 || len(gameEngine.matches) != 1 {
			t.Fatal("two queued players were not matched")
		}
		if emitter.count("a", protocol.S2CMatchFound) != 1 || emitter.count("b", protocol.S2CMatchFound) != 1 {
			t.Fatal("matched players did not receive MATCH_FOUND")
		}
	})
}

func TestRoomListAndReconnectView(t *testing.T) {
	gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
	open := lifecycleRoom("open")
	locked := lifecycleRoom("locked")
	open.CreatedAt = time.Now().Add(-time.Minute).UnixMilli()
	locked.OwnerID = "other-owner"
	locked.OwnerName = "OTHER"
	locked.Password = "secret"
	locked.GuestID = "guest"
	locked.GuestName = "GUEST"
	_ = rooms.Save(open)
	_ = rooms.Save(locked)

	gameEngine.ListRooms(persistenceTestGameID, "viewer")
	envelope, ok := emitter.last("viewer", protocol.S2CRoomList)
	if !ok {
		t.Fatal("room list was not emitted")
	}
	data := envelope.Data.(protocol.RoomListData)
	if len(data.Rooms) != 2 {
		t.Fatalf("unexpected room list: %+v", data.Rooms)
	}
	if data.Rooms[0].ID != locked.ID || data.Rooms[1].ID != open.ID {
		t.Fatalf("rooms are not sorted newest first: %+v", data.Rooms)
	}
	foundLocked := false
	for _, room := range data.Rooms {
		if room.ID == locked.ID {
			foundLocked = room.Locked && room.Full && room.Players == 2
		}
	}
	if !foundLocked {
		t.Fatal("locked/full room metadata is incorrect")
	}

	emitter.clear()
	gameEngine.OnConnect(open.GameID, open.OwnerID)
	if emitter.count(open.OwnerID, protocol.S2CRoomWaiting) != 1 || emitter.count(open.OwnerID, protocol.S2CRoomState) != 1 {
		t.Fatal("room owner did not recover room view on reconnect")
	}
}

func TestRoomListFailureDoesNotLookLikeAnEmptyLobby(t *testing.T) {
	gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
	rooms.failList = true
	gameEngine.ListRooms(persistenceTestGameID, "viewer")
	requireErrorCode(t, emitter, "viewer", "ROOM_LIST_FAILED")
	if emitter.count("viewer", protocol.S2CRoomList) != 0 {
		t.Fatal("room list failure emitted an empty authoritative list")
	}
}

func TestMoveGuardCases(t *testing.T) {
	gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
	defer stopEngineTimers(gameEngine)
	gameEngine.Move(persistenceTestGameID, "missing", "", json.RawMessage(`{}`))
	requireErrorCode(t, emitter, "missing", "NO_MATCH")

	match := startPersistenceTestMatch(t, gameEngine)
	current := match.players[match.turnIdx].ID
	opponent := match.players[1-match.turnIdx].ID

	emitter.clear()
	gameEngine.Move(match.GameID, opponent, match.ID, json.RawMessage(`{"win":false}`))
	requireErrorCode(t, emitter, opponent, "NOT_YOUR_TURN")

	emitter.clear()
	gameEngine.Move(match.GameID, current, "different-match", json.RawMessage(`{"win":false}`))
	if emitter.count(current, protocol.S2CState) != 0 || match.state.(*persistenceTestState).MoveCount != 0 {
		t.Fatal("move for a different match was applied")
	}

	gameEngine.Move(match.GameID, current, match.ID, json.RawMessage(`{`))
	requireErrorCode(t, emitter, current, "INVALID_MOVE")
	if match.state.(*persistenceTestState).MoveCount != 0 {
		t.Fatal("invalid move changed state")
	}

	emitter.clear()
	if match.timer != nil {
		match.timer.Stop()
	}
	match.deadline = time.Now().Add(-time.Second)
	gameEngine.Move(match.GameID, current, match.ID, json.RawMessage(`{"win":false}`))
	if emitter.count(current, protocol.S2CState) != 0 || match.state.(*persistenceTestState).MoveCount != 0 {
		t.Fatal("move after deadline was applied")
	}
}

func TestMatchChatValidationAndBroadcast(t *testing.T) {
	t.Run("broadcasts server-owned sender data to both players", func(t *testing.T) {
		gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		defer stopEngineTimers(gameEngine)
		match := startPersistenceTestMatch(t, gameEngine)
		sender := match.players[0]

		gameEngine.Chat(match.GameID, sender.ID, match.ID, "  chào đối thủ  ")
		for _, player := range match.players {
			envelope, ok := emitter.last(player.ID, protocol.S2CChatMessage)
			if !ok {
				t.Fatalf("%s did not receive chat message", player.ID)
			}
			data, ok := envelope.Data.(protocol.ChatMessageData)
			if !ok || data.MatchID != match.ID || data.UserID != sender.ID || data.Name != sender.Name ||
				data.Text != "chào đối thủ" || data.SentAt <= 0 {
				t.Fatalf("unexpected chat data for %s: %#v", player.ID, envelope.Data)
			}
		}
	})

	t.Run("rate limits repeated messages from the same player", func(t *testing.T) {
		gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		defer stopEngineTimers(gameEngine)
		match := startPersistenceTestMatch(t, gameEngine)
		sender := match.players[0]

		gameEngine.Chat(match.GameID, sender.ID, match.ID, "first")
		gameEngine.Chat(match.GameID, sender.ID, match.ID, "second")
		requireErrorCode(t, emitter, sender.ID, "CHAT_RATE_LIMITED")
		gameEngine.Chat(match.GameID, match.players[1].ID, match.ID, "opponent message")
		for _, player := range match.players {
			if count := emitter.count(player.ID, protocol.S2CChatMessage); count != 2 {
				t.Fatalf("%s received %d chat messages, want 2", player.ID, count)
			}
		}
	})

	tests := []struct {
		name  string
		setup func(*Engine, *Match) (string, string, string, string)
		code  string
	}{
		{
			name: "no active match",
			setup: func(_ *Engine, _ *Match) (string, string, string, string) {
				return persistenceTestGameID, "missing", "missing-match", "hello"
			},
			code: "NO_MATCH",
		},
		{
			name: "wrong match",
			setup: func(_ *Engine, match *Match) (string, string, string, string) {
				return match.GameID, match.players[0].ID, "different-match", "hello"
			},
			code: "MATCH_MISMATCH",
		},
		{
			name: "empty message",
			setup: func(_ *Engine, match *Match) (string, string, string, string) {
				return match.GameID, match.players[0].ID, match.ID, "   "
			},
			code: "INVALID_CHAT",
		},
		{
			name: "message over rune limit",
			setup: func(_ *Engine, match *Match) (string, string, string, string) {
				return match.GameID, match.players[0].ID, match.ID, strings.Repeat("á", maxChatRunes+1)
			},
			code: "CHAT_TOO_LONG",
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
			defer stopEngineTimers(gameEngine)
			match := startPersistenceTestMatch(t, gameEngine)
			gameID, userID, matchID, message := test.setup(gameEngine, match)

			gameEngine.Chat(gameID, userID, matchID, message)
			requireErrorCode(t, emitter, userID, test.code)
			for _, player := range match.players {
				if emitter.count(player.ID, protocol.S2CChatMessage) != 0 {
					t.Fatal("invalid chat was broadcast")
				}
			}
		})
	}
}

func TestRoomChatValidationAndBroadcast(t *testing.T) {
	t.Run("both room members can chat before a match", func(t *testing.T) {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := lifecycleRoom("chat-room")
		room.GuestID = "guest"
		room.GuestName = "GUEST"
		if err := rooms.Save(room); err != nil {
			t.Fatal(err)
		}

		gameEngine.RoomChat(room.GameID, room.OwnerID, room.ID, "  hello guest  ")
		for _, userID := range []string{room.OwnerID, room.GuestID} {
			envelope, ok := emitter.last(userID, protocol.S2CChatMessage)
			if !ok {
				t.Fatalf("%s did not receive room chat", userID)
			}
			data, ok := envelope.Data.(protocol.ChatMessageData)
			if !ok || data.RoomID != room.ID || data.MatchID != "" || data.UserID != room.OwnerID ||
				data.Name != room.OwnerName || data.Text != "hello guest" || data.SentAt <= 0 {
				t.Fatalf("unexpected room chat for %s: %#v", userID, envelope.Data)
			}
		}

		gameEngine.RoomChat(room.GameID, room.OwnerID, room.ID, "too fast")
		requireErrorCode(t, emitter, room.OwnerID, "CHAT_RATE_LIMITED")
		gameEngine.RoomChat(room.GameID, room.GuestID, room.ID, "hello owner")
		for _, userID := range []string{room.OwnerID, room.GuestID} {
			if count := emitter.count(userID, protocol.S2CChatMessage); count != 2 {
				t.Fatalf("%s received %d room messages, want 2", userID, count)
			}
		}
	})

	tests := []struct {
		name   string
		setup  func(*memoryRoomStore) (string, string, string, string)
		code   string
		userID string
	}{
		{
			name: "room not found",
			setup: func(_ *memoryRoomStore) (string, string, string, string) {
				return persistenceTestGameID, "missing", "missing-room", "hello"
			},
			code: "ROOM_NOT_FOUND", userID: "missing",
		},
		{
			name: "sender is not a member",
			setup: func(rooms *memoryRoomStore) (string, string, string, string) {
				room := lifecycleRoom("chat-room")
				room.GuestID = "guest"
				room.GuestName = "GUEST"
				_ = rooms.Save(room)
				return room.GameID, "outsider", room.ID, "hello"
			},
			code: "NOT_ROOM_MEMBER", userID: "outsider",
		},
		{
			name: "room needs two members",
			setup: func(rooms *memoryRoomStore) (string, string, string, string) {
				room := lifecycleRoom("chat-room")
				_ = rooms.Save(room)
				return room.GameID, room.OwnerID, room.ID, "hello"
			},
			code: "ROOM_NOT_FULL", userID: "owner",
		},
		{
			name: "empty message",
			setup: func(rooms *memoryRoomStore) (string, string, string, string) {
				room := lifecycleRoom("chat-room")
				room.GuestID = "guest"
				room.GuestName = "GUEST"
				_ = rooms.Save(room)
				return room.GameID, room.OwnerID, room.ID, "   "
			},
			code: "INVALID_CHAT", userID: "owner",
		},
		{
			name: "message over rune limit",
			setup: func(rooms *memoryRoomStore) (string, string, string, string) {
				room := lifecycleRoom("chat-room")
				room.GuestID = "guest"
				room.GuestName = "GUEST"
				_ = rooms.Save(room)
				return room.GameID, room.OwnerID, room.ID, strings.Repeat("a", maxChatRunes+1)
			},
			code: "CHAT_TOO_LONG", userID: "owner",
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
			gameID, userID, roomID, message := test.setup(rooms)
			gameEngine.RoomChat(gameID, userID, roomID, message)
			requireErrorCode(t, emitter, test.userID, test.code)
			if emitter.count("owner", protocol.S2CChatMessage) != 0 || emitter.count("guest", protocol.S2CChatMessage) != 0 {
				t.Fatal("invalid room chat was broadcast")
			}
		})
	}
}
