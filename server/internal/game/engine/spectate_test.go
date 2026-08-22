package engine

import (
	"fmt"
	"testing"

	"ola-chat-server/internal/game/protocol"
)

type inbox struct {
	messages []protocol.OutEnvelope
}

func (b *inbox) deliver(envelope protocol.OutEnvelope) {
	b.messages = append(b.messages, envelope)
}

func (b *inbox) last(t *testing.T, messageType string) protocol.OutEnvelope {
	t.Helper()
	for i := len(b.messages) - 1; i >= 0; i-- {
		if b.messages[i].Type == messageType {
			return b.messages[i]
		}
	}
	t.Fatalf("inbox has no %s: %+v", messageType, b.messages)
	return protocol.OutEnvelope{}
}

func (b *inbox) lastError(t *testing.T) protocol.ErrorData {
	t.Helper()
	return b.last(t, protocol.S2CError).Data.(protocol.ErrorData)
}

func joinAs(gameEngine *Engine, match *Match, userID, socketID string) (*inbox, bool) {
	box := &inbox{}
	ok := gameEngine.SpectateJoin(match.GameID, userID, match.ID, socketID, box.deliver)
	return box, ok
}

func TestSpectateJoinReceivesSnapshotAndStateUpdates(t *testing.T) {
	gameEngine, activeStore, emitter, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)

	box, ok := joinAs(gameEngine, match, "watcher", "sock-1")
	if !ok {
		t.Fatalf("spectate join failed: %+v", box.lastError(t))
	}
	joined := box.last(t, protocol.S2CSpectateJoined).Data.(protocol.SpectateJoinedData)
	if joined.MatchID != match.ID || len(joined.Players) != 2 || joined.Spectators != 1 {
		t.Fatalf("unexpected SPECTATE_JOINED payload: %+v", joined)
	}
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 1 {
		t.Fatalf("expected 1 spectator, got %d", count)
	}

	gameEngine.Move(match.GameID, match.players[0].ID, match.ID, caroMoveRaw(t, caroPoint{3, 3}))
	states := emitter.matchMessages(match.ID, protocol.S2CState)
	if len(states) != 1 {
		t.Fatalf("expected 1 STATE to match room, got %d", len(states))
	}
	state := states[0].Data.(protocol.StateData)
	if state.Turn != 1 || state.LastBy != 0 {
		t.Fatalf("unexpected STATE for spectators: %+v", state)
	}

	gameEngine.Move(match.GameID, "watcher", match.ID, caroMoveRaw(t, caroPoint{4, 4}))
	envelope, found := emitter.last("watcher", protocol.S2CError)
	if !found || envelope.Data.(protocol.ErrorData).Code != protocol.ErrorCodeNoMatch {
		t.Fatalf("spectator move should be rejected with NO_MATCH, got %+v", envelope)
	}

	gameEngine.SpectateLeave(match.GameID, match.ID, "sock-1", box.deliver)
	box.last(t, protocol.S2CSpectateLeft)
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 0 {
		t.Fatalf("expected 0 spectators after leave, got %d", count)
	}
}

func TestSpectateJoinRejectsPlayersAndFullMatches(t *testing.T) {
	gameEngine, activeStore, _, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)

	if box, ok := joinAs(gameEngine, match, match.players[0].ID, "sock-p0"); ok || box.lastError(t).Code != protocol.ErrorCodeSpectateOwnMatch {
		t.Fatalf("player should get SPECTATE_OWN_MATCH, got %+v", box.messages)
	}
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 0 {
		t.Fatalf("rejected player must not hold a seat, got %d", count)
	}

	missing := &inbox{}
	if gameEngine.SpectateJoin(match.GameID, "watcher", "missing-match", "sock-x", missing.deliver) {
		t.Fatal("unknown match should be rejected")
	}
	if err := missing.lastError(t); err.Code != protocol.ErrorCodeMatchNotFound {
		t.Fatalf("expected MATCH_NOT_FOUND, got %+v", err)
	}

	for i := 0; i < MaxSpectators; i++ {
		if _, ok := joinAs(gameEngine, match, "same-user", fmt.Sprintf("tab-%d", i)); !ok {
			t.Fatalf("socket %d of the same user should hold its own seat", i)
		}
	}
	if box, ok := joinAs(gameEngine, match, "watcher-overflow", "sock-overflow"); ok || box.lastError(t).Code != protocol.ErrorCodeSpectateFull {
		t.Fatalf("expected SPECTATE_FULL, got %+v", box.messages)
	}
	gameEngine.SpectateLeave(match.GameID, match.ID, "tab-0", nil)
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != MaxSpectators-1 {
		t.Fatalf("leaving one tab must free exactly one seat, got %d", count)
	}
}

func TestSpectateJoinRejectsFinishedMatch(t *testing.T) {
	gameEngine, activeStore, _, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)

	gameEngine.Forfeit(match.GameID, match.players[1].ID, match.ID)
	if box, ok := joinAs(gameEngine, match, "late", "sock-late"); ok || box.lastError(t).Code != protocol.ErrorCodeMatchNotFound {
		t.Fatalf("finished match must reject spectators, got %+v", box.messages)
	}
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 0 {
		t.Fatalf("finished match must not keep a spectator set, got %d", count)
	}
}

func TestSpectateRejectsHiddenInformationGames(t *testing.T) {
	gameEngine, _, match := startThirteenMatch(t, 4)
	defer stopEngineTimers(gameEngine)
	matchID := "any"
	if match != nil {
		matchID = match.ID
	}

	box := &inbox{}
	if gameEngine.SpectateJoin("thirteen", "watcher", matchID, "sock", box.deliver) {
		t.Fatal("thirteen should not be spectatable")
	}
	if err := box.lastError(t); err.Code != protocol.ErrorCodeSpectateNotSupported {
		t.Fatalf("expected SPECTATE_NOT_SUPPORTED, got %+v", err)
	}
}

func TestSpectateListAndMatchOverCleanup(t *testing.T) {
	gameEngine, activeStore, emitter, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)

	joinAs(gameEngine, match, "watcher", "sock-1")
	gameEngine.SpectateList(match.GameID, "lurker")
	envelope, ok := emitter.last("lurker", protocol.S2CSpectateList)
	if !ok {
		t.Fatal("lurker did not receive SPECTATE_LIST")
	}
	list := envelope.Data.(protocol.SpectateListData)
	if len(list.Matches) != 1 || list.Matches[0].MatchID != match.ID || list.Matches[0].Spectators != 1 {
		t.Fatalf("unexpected SPECTATE_LIST: %+v", list)
	}

	gameEngine.Forfeit(match.GameID, match.players[1].ID, match.ID)
	if !match.over {
		t.Fatal("forfeit did not finish the match")
	}
	overs := emitter.matchMessages(match.ID, protocol.S2CMatchOver)
	if len(overs) != 1 {
		t.Fatalf("expected 1 MATCH_OVER to match room, got %d", len(overs))
	}
	over := overs[0].Data.(protocol.MatchOverData)
	if over.WinnerID != match.players[0].ID || over.Payout != 0 || over.KenDelta != 0 {
		t.Fatalf("spectator MATCH_OVER should carry no money fields: %+v", over)
	}
	lefts := emitter.matchMessages(match.ID, protocol.S2CSpectateLeft)
	if len(lefts) != 1 || lefts[0].Data.(protocol.SpectateLeftData).Reason != protocol.SpectateLeftReasonMatchOver {
		t.Fatalf("expected SPECTATE_LEFT match_over, got %+v", lefts)
	}
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 0 {
		t.Fatalf("spectators were not cleared, got %d", count)
	}
}
