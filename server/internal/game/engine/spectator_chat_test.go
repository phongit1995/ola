package engine

import (
	"testing"
	"time"

	"ola-chat-server/internal/game/protocol"
)

func chatData(envelopes []protocol.OutEnvelope) []protocol.ChatMessageData {
	out := make([]protocol.ChatMessageData, 0, len(envelopes))
	for _, envelope := range envelopes {
		out = append(out, envelope.Data.(protocol.ChatMessageData))
	}
	return out
}

func TestSpectatorChatReachesPlayersAndViewers(t *testing.T) {
	gameEngine, _, emitter, _, match := startThirteenRoomMatch(t)
	defer stopEngineTimers(gameEngine)

	viewer := protocol.PlayerInfo{ID: "viewer", Name: "Người xem"}
	gameEngine.SpectatorChat(match.GameID, viewer, match.ID, "  hay quá  ")

	chats := chatData(emitter.matchMessages(match.ID, protocol.S2CChatMessage))
	if len(chats) != 1 {
		t.Fatalf("viewers got %d chats, want 1", len(chats))
	}
	if got := chats[0]; got.Text != "hay quá" || got.Name != viewer.Name || !got.Spectator || got.MatchID != match.ID {
		t.Fatalf("unexpected spectator chat %+v", got)
	}
	for _, playerID := range []string{"tl-a", "tl-b"} {
		envelope, ok := emitter.last(playerID, protocol.S2CChatMessage)
		if !ok || !envelope.Data.(protocol.ChatMessageData).Spectator {
			t.Fatalf("player %s did not get the spectator chat", playerID)
		}
	}

	gameEngine.SpectatorChat(match.GameID, viewer, match.ID, "spam")
	if code := lastErrorCode(emitter, viewer.ID); code != protocol.ErrorCodeChatRateLimited {
		t.Fatalf("second chat right away: error %q, want %q", code, protocol.ErrorCodeChatRateLimited)
	}
}

func TestSpectatorChatFromAPlayerStaysAPlayerChat(t *testing.T) {
	gameEngine, _, emitter, _, match := startThirteenRoomMatch(t)
	defer stopEngineTimers(gameEngine)

	gameEngine.SpectatorChat(match.GameID, protocol.PlayerInfo{ID: "tl-b", Name: "fake"}, match.ID, "xin chào")
	chats := chatData(emitter.matchMessages(match.ID, protocol.S2CChatMessage))
	if len(chats) != 1 || chats[0].Spectator || chats[0].Name != "tl-b" {
		t.Fatalf("player chat changed: %+v", chats)
	}
}

func TestSpectatorChatNeedsALiveMatch(t *testing.T) {
	gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
	defer stopEngineTimers(gameEngine)

	gameEngine.SpectatorChat("thirteen", protocol.PlayerInfo{ID: "viewer"}, "missing", "alo")
	if code := lastErrorCode(emitter, "viewer"); code != protocol.ErrorCodeNoMatch {
		t.Fatalf("error %q, want %q", code, protocol.ErrorCodeNoMatch)
	}
}

func TestRoomWatcherCanChat(t *testing.T) {
	room := thirteenRoom("watch-room")
	gameEngine, _, emitter := newSeatsTestEngine(t, room)

	viewer := protocol.PlayerInfo{ID: "viewer", Name: "Người xem"}
	gameEngine.WatcherRoomChat(room.GameID, viewer, room.ID, "cho xem với")

	envelope, ok := emitter.last(room.OwnerID, protocol.S2CChatMessage)
	if !ok {
		t.Fatal("owner did not get the watcher chat")
	}
	if got := envelope.Data.(protocol.ChatMessageData); !got.Spectator || got.Name != viewer.Name || got.RoomID != room.ID {
		t.Fatalf("unexpected watcher chat %+v", got)
	}
	if chats := emitter.roomWatcherMessages(room.ID, protocol.S2CChatMessage); len(chats) != 1 {
		t.Fatalf("watchers got %d chats, want 1", len(chats))
	}
}

func TestRoomWatcherChatRespectsSpectatorFlag(t *testing.T) {
	room := thirteenRoom("closed-room", "tl-b")
	room.AllowSpectators = boolPtr(false)
	gameEngine, _, emitter := newSeatsTestEngine(t, room)

	gameEngine.WatcherRoomChat(room.GameID, protocol.PlayerInfo{ID: "viewer", Name: "viewer"}, room.ID, "alo")
	if code := lastErrorCode(emitter, "viewer"); code != protocol.ErrorCodeNotRoomMember {
		t.Fatalf("error %q, want %q", code, protocol.ErrorCodeNotRoomMember)
	}
	if _, ok := emitter.last(room.OwnerID, protocol.S2CChatMessage); ok {
		t.Fatal("owner received chat from a room that refuses spectators")
	}
}

func TestRoomMemberMarkedAsWatcherChatsAsMember(t *testing.T) {
	room := thirteenRoom("member-room", "tl-b")
	gameEngine, _, emitter := newSeatsTestEngine(t, room)

	gameEngine.WatcherRoomChat(room.GameID, protocol.PlayerInfo{ID: "tl-b", Name: "fake"}, room.ID, "mình ngồi đây")
	envelope, ok := emitter.last(room.OwnerID, protocol.S2CChatMessage)
	if !ok {
		t.Fatal("owner did not get the member chat")
	}
	if got := envelope.Data.(protocol.ChatMessageData); got.Spectator || got.Name != "tl-b" {
		t.Fatalf("member chat was treated as a watcher: %+v", got)
	}
}

func TestAllowChatPrunesStaleEntries(t *testing.T) {
	last := make(map[string]time.Time)
	old := time.Now().Add(-time.Minute)
	for i := 0; i < chatRatePruneSize; i++ {
		last[string(rune('a'+i%26))+string(rune(i))] = old
	}
	if !allowChat(last, "fresh", time.Now()) {
		t.Fatal("a fresh sender was rate limited")
	}
	if len(last) != 1 {
		t.Fatalf("stale entries kept: %d", len(last))
	}
}
