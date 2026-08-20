package engine

import (
	"encoding/json"
	"testing"

	thirteen "ola-chat-server/internal/game/games/thirteen"
	"ola-chat-server/internal/game/protocol"
)

func startThirteenMatch(t *testing.T, playerCount int) (*Engine, *captureEmitter, *Match) {
	t.Helper()
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	players := make([]protocol.PlayerInfo, 0, playerCount)
	names := []string{"tl-a", "tl-b", "tl-c", "tl-d"}
	for i := 0; i < playerCount; i++ {
		players = append(players, protocol.PlayerInfo{ID: names[i], Name: names[i]})
	}
	if err := gameEngine.startMatchWithRoom("thirteen", thirteen.Logic{}, players, 0, nil, false, nil); err != nil {
		t.Fatalf("start tien len match: %v", err)
	}
	for _, match := range gameEngine.matches {
		return gameEngine, emitter, match
	}
	if playerCount >= 2 {
		// An instant win can legitimately finish the match at deal time.
		for _, p := range players {
			if _, ok := emitter.last(p.ID, protocol.S2CMatchOver); ok {
				return gameEngine, emitter, nil
			}
		}
	}
	t.Fatal("tien len match was not created")
	return nil, nil, nil
}

func forcedThirteenState(t *testing.T, gameEngine *Engine, m *Match, hands [][]int, starter int) *thirteen.State {
	t.Helper()
	n := len(hands)
	state := &thirteen.State{
		Hands:       make([][]int, n),
		Passed:      make([]bool, n),
		Quit:        make([]bool, n),
		FinishOrder: []int{},
		Turn:        starter,
		Starter:     starter,
		Rng:         "1",
	}
	for i, hand := range hands {
		state.Hands[i] = append([]int(nil), hand...)
	}
	m.mu.Lock()
	m.state = state
	m.turnIdx = starter
	if err := gameEngine.persistMatch(m); err != nil {
		m.mu.Unlock()
		t.Fatalf("persist forced state: %v", err)
	}
	m.mu.Unlock()
	return state
}

func tienLenMoveRaw(t *testing.T, moveType string, cards ...int) json.RawMessage {
	t.Helper()
	payload := map[string]any{"type": moveType}
	if len(cards) > 0 {
		payload["cards"] = cards
	}
	raw, err := json.Marshal(payload)
	if err != nil {
		t.Fatal(err)
	}
	return raw
}

func TestThirteenFourPlayerMatchPlaysToRankedFinish(t *testing.T) {
	gameEngine, emitter, match := startThirteenMatch(t, 4)
	defer stopEngineTimers(gameEngine)
	if match == nil {
		t.Skip("instant win at deal")
	}

	hands := [][]int{
		{4, 8},
		{5, 9},
		{6, 10},
		{7, 11},
	}
	forcedThirteenState(t, gameEngine, match, hands, 0)
	players := match.players

	gameEngine.Move(match.GameID, players[0].ID, match.ID, tienLenMoveRaw(t, "play", 4))
	gameEngine.Move(match.GameID, players[1].ID, match.ID, tienLenMoveRaw(t, "play", 5))
	gameEngine.Move(match.GameID, players[2].ID, match.ID, tienLenMoveRaw(t, "play", 6))
	gameEngine.Move(match.GameID, players[3].ID, match.ID, tienLenMoveRaw(t, "play", 7))
	gameEngine.Move(match.GameID, players[0].ID, match.ID, tienLenMoveRaw(t, "play", 8))

	env, ok := emitter.last(players[0].ID, protocol.S2CState)
	if !ok {
		t.Fatal("no state was broadcast")
	}
	view, ok := env.Data.(protocol.StateData).State.(thirteen.PlayerView)
	if !ok {
		t.Fatalf("state payload is not a player view: %T", env.Data.(protocol.StateData).State)
	}
	if view.You != 0 {
		t.Fatalf("view.You = %d", view.You)
	}

	gameEngine.Move(match.GameID, players[1].ID, match.ID, tienLenMoveRaw(t, "play", 9))
	gameEngine.Move(match.GameID, players[2].ID, match.ID, tienLenMoveRaw(t, "play", 10))
	gameEngine.Move(match.GameID, players[3].ID, match.ID, tienLenMoveRaw(t, "play", 11))

	overEnv, ok := emitter.last(players[0].ID, protocol.S2CMatchOver)
	if !ok {
		t.Fatal("match did not finish")
	}
	result := overEnv.Data.(protocol.MatchOverData)
	if result.WinnerID != players[0].ID {
		t.Fatalf("winner = %s, want %s", result.WinnerID, players[0].ID)
	}
	if len(result.Rankings) != 4 {
		t.Fatalf("rankings = %+v", result.Rankings)
	}
	wantOrder := []string{players[0].ID, players[1].ID, players[2].ID, players[3].ID}
	for i, entry := range result.Rankings {
		if entry.UserID != wantOrder[i] || entry.Place != i+1 {
			t.Fatalf("ranking %d = %+v, want %s", i, entry, wantOrder[i])
		}
	}
}

func TestThirteenStateBroadcastsNeverLeakOtherHands(t *testing.T) {
	gameEngine, emitter, match := startThirteenMatch(t, 4)
	defer stopEngineTimers(gameEngine)
	if match == nil {
		t.Skip("instant win at deal")
	}

	for _, p := range match.players {
		for _, messageType := range []string{protocol.S2CMatchFound, protocol.S2CState} {
			env, ok := emitter.last(p.ID, messageType)
			if !ok {
				continue
			}
			var payloadState any
			switch data := env.Data.(type) {
			case protocol.MatchFoundData:
				payloadState = data.State
			case protocol.StateData:
				payloadState = data.State
			}
			raw, err := json.Marshal(payloadState)
			if err != nil {
				t.Fatal(err)
			}
			var decoded map[string]any
			if err := json.Unmarshal(raw, &decoded); err != nil {
				t.Fatal(err)
			}
			if _, leaked := decoded["hands"]; leaked {
				t.Fatalf("%s payload for %s leaks hands", messageType, p.ID)
			}
			if _, hasOwn := decoded["yourHand"]; !hasOwn {
				t.Fatalf("%s payload for %s misses yourHand", messageType, p.ID)
			}
		}
	}
}

func TestThirteenForfeitKeepsMatchRunningWithThreePlayers(t *testing.T) {
	gameEngine, emitter, match := startThirteenMatch(t, 4)
	defer stopEngineTimers(gameEngine)
	if match == nil {
		t.Skip("instant win at deal")
	}

	hands := [][]int{
		{4, 8},
		{5, 9},
		{6, 10},
		{7, 11},
	}
	forcedThirteenState(t, gameEngine, match, hands, 0)
	players := match.players

	gameEngine.Forfeit(match.GameID, players[1].ID, match.ID)

	match.mu.Lock()
	over := match.over
	quit := match.quit[1]
	match.mu.Unlock()
	if over {
		t.Fatal("match ended after one of four players forfeited")
	}
	if !quit {
		t.Fatal("forfeiting player was not marked as quit")
	}

	gameEngine.Move(match.GameID, players[0].ID, match.ID, tienLenMoveRaw(t, "play", 4))
	gameEngine.Move(match.GameID, players[2].ID, match.ID, tienLenMoveRaw(t, "play", 6))
	gameEngine.Move(match.GameID, players[3].ID, match.ID, tienLenMoveRaw(t, "play", 7))
	gameEngine.Move(match.GameID, players[0].ID, match.ID, tienLenMoveRaw(t, "play", 8))
	gameEngine.Move(match.GameID, players[2].ID, match.ID, tienLenMoveRaw(t, "play", 10))
	gameEngine.Move(match.GameID, players[3].ID, match.ID, tienLenMoveRaw(t, "play", 11))

	overEnv, ok := emitter.last(players[0].ID, protocol.S2CMatchOver)
	if !ok {
		t.Fatal("match did not finish after remaining players played out")
	}
	result := overEnv.Data.(protocol.MatchOverData)
	if result.WinnerID != players[0].ID {
		t.Fatalf("winner = %s", result.WinnerID)
	}
	if len(result.Rankings) != 4 || result.Rankings[3].UserID != players[1].ID {
		t.Fatalf("quitter is not ranked last: %+v", result.Rankings)
	}
}

func TestThirteenTwoPlayerForfeitEndsMatch(t *testing.T) {
	gameEngine, emitter, match := startThirteenMatch(t, 2)
	defer stopEngineTimers(gameEngine)
	if match == nil {
		t.Skip("instant win at deal")
	}
	players := match.players
	gameEngine.Forfeit(match.GameID, players[0].ID, match.ID)
	overEnv, ok := emitter.last(players[1].ID, protocol.S2CMatchOver)
	if !ok {
		t.Fatal("two player forfeit did not finish the match")
	}
	result := overEnv.Data.(protocol.MatchOverData)
	if result.WinnerID != players[1].ID || result.Reason != "forfeit" {
		t.Fatalf("result = %+v", result)
	}
}
