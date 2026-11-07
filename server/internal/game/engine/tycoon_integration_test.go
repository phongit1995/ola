package engine

import (
	"encoding/json"
	"strings"
	"testing"

	"ola-chat-server/internal/game/games/tycoon"
	"ola-chat-server/internal/game/protocol"
)

func startTycoonMatch(t *testing.T, playerCount int) (*Engine, *captureEmitter, *Match) {
	t.Helper()
	return startTycoonBetMatch(t, playerCount, 0, nil)
}

func startTycoonBetMatch(t *testing.T, playerCount, bet int, settlement Settlement) (*Engine, *captureEmitter, *Match) {
	t.Helper()
	gameEngine, _, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
	if settlement != nil {
		gameEngine.SetSettlement(settlement)
	}
	names := []string{"ty-a", "ty-b", "ty-c", "ty-d"}
	players := make([]protocol.PlayerInfo, 0, playerCount)
	for i := 0; i < playerCount; i++ {
		players = append(players, protocol.PlayerInfo{ID: names[i], Name: names[i]})
	}
	if err := gameEngine.startMatchWithRoom(tycoon.GameID, tycoon.Logic{}, players, bet, nil, false, nil); err != nil {
		t.Fatalf("start tycoon match: %v", err)
	}
	for _, match := range gameEngine.matches {
		return gameEngine, emitter, match
	}
	t.Fatal("tycoon match was not created")
	return nil, nil, nil
}

func tycoonBotMove(t *testing.T, match *Match) (string, json.RawMessage) {
	t.Helper()
	match.mu.Lock()
	defer match.mu.Unlock()
	state := match.state.(*tycoon.State)
	if state.Turn != match.turnIdx {
		t.Fatalf("engine turn %d differs from game turn %d", match.turnIdx, state.Turn)
	}
	player := state.Players[state.Turn]
	if state.Phase == tycoon.PhaseDecide && player.Cash >= tycoon.Board[player.Pos].Price {
		return match.players[match.turnIdx].ID, json.RawMessage(`{"type":"BUY"}`)
	}
	raw, ok := tycoon.Logic{}.MoveOnTimeout(state, match.turnIdx)
	if !ok {
		t.Fatalf("no move for phase %s", state.Phase)
	}
	return match.players[match.turnIdx].ID, raw
}

func playTycoonToEnd(t *testing.T, gameEngine *Engine, emitter *captureEmitter, match *Match) {
	t.Helper()
	for i := 0; i < 5000 && !match.over; i++ {
		userID, raw := tycoonBotMove(t, match)
		before := match.state
		gameEngine.Move(match.GameID, userID, match.ID, raw)
		if !match.over && match.state == before {
			env, _ := emitter.last(userID, protocol.S2CError)
			t.Fatalf("move %s rejected: %+v", raw, env.Data)
		}
	}
	if !match.over {
		t.Fatal("match did not finish")
	}
}

func TestTycoonFourPlayerMatchPlaysToRankedFinish(t *testing.T) {
	gameEngine, emitter, match := startTycoonMatch(t, 4)
	defer stopEngineTimers(gameEngine)

	playTycoonToEnd(t, gameEngine, emitter, match)
	final := match.state.(*tycoon.State)
	if final.EndReason == nil || final.MoveCount < 20 {
		t.Fatalf("match ended early: reason %v after %d moves", final.EndReason, final.MoveCount)
	}
	t.Logf("tycoon match ended by %s after %d moves in round %d", *final.EndReason, final.MoveCount, final.Round)

	overEnv, ok := emitter.last(match.players[0].ID, protocol.S2CMatchOver)
	if !ok {
		t.Fatal("no MATCH_OVER")
	}
	result := overEnv.Data.(protocol.MatchOverData)
	if len(result.Rankings) != 4 || result.Rankings[0].UserID != result.WinnerID || result.Reason != "win" {
		t.Fatalf("result = %+v", result)
	}
	seen := map[string]bool{}
	for i, entry := range result.Rankings {
		if entry.Place != i+1 || seen[entry.UserID] {
			t.Fatalf("rankings = %+v", result.Rankings)
		}
		seen[entry.UserID] = true
	}

	for idx, player := range match.players {
		env, ok := emitter.last(player.ID, protocol.S2CState)
		if !ok {
			t.Fatalf("player %d got no STATE", idx)
		}
		view, ok := env.Data.(protocol.StateData).State.(tycoon.PlayerView)
		if !ok || view.You != idx {
			t.Fatalf("player %d STATE payload %T", idx, env.Data.(protocol.StateData).State)
		}
		raw, _ := json.Marshal(view)
		if strings.Contains(string(raw), `"rng"`) || strings.Contains(string(raw), `"chanceDeck"`) {
			t.Fatalf("player %d view leaks hidden state", idx)
		}
	}
}

func TestTycoonIdlePlayersAreEliminatedUntilOneRemains(t *testing.T) {
	gameEngine, emitter, match := startTycoonMatch(t, 4)
	defer stopEngineTimers(gameEngine)

	idleUntilEliminated := func(idle int) {
		t.Helper()
		for i := 0; i < 500 && !match.over && !match.quit[idle]; i++ {
			if match.turnIdx == idle {
				fireTurnTimeout(gameEngine, match)
				continue
			}
			userID, raw := tycoonBotMove(t, match)
			gameEngine.Move(match.GameID, userID, match.ID, raw)
		}
	}

	for _, idle := range []int{0, 1} {
		idleUntilEliminated(idle)
		if match.over || !match.quit[idle] {
			t.Fatalf("seat %d was not eliminated (over=%v)", idle, match.over)
		}
		state := match.state.(*tycoon.State)
		if !state.Players[idle].Quit || !state.Players[idle].Bankrupt || state.Turn != match.turnIdx || match.turnIdx == idle {
			t.Fatalf("after eliminating %d: player %+v turn %d engine turn %d", idle, state.Players[idle], state.Turn, match.turnIdx)
		}
	}

	idleUntilEliminated(2)
	if !match.over {
		t.Fatal("match did not end with one player left")
	}
	overEnv, ok := emitter.last(match.players[3].ID, protocol.S2CMatchOver)
	if !ok {
		t.Fatal("no MATCH_OVER")
	}
	result := overEnv.Data.(protocol.MatchOverData)
	if result.WinnerID != match.players[3].ID || len(result.Rankings) != 4 || result.Rankings[0].UserID != match.players[3].ID {
		t.Fatalf("result = %+v", result)
	}
}

func TestTycoonMatchOverPaysTheWholeFourSeatPot(t *testing.T) {
	gameEngine, emitter, match := startTycoonBetMatch(t, 4, 1000, &fakeSettlement{commissionPercent: 5})
	defer stopEngineTimers(gameEngine)

	playTycoonToEnd(t, gameEngine, emitter, match)
	overEnv, ok := emitter.last(match.players[0].ID, protocol.S2CMatchOver)
	if !ok {
		t.Fatal("no MATCH_OVER")
	}
	result := overEnv.Data.(protocol.MatchOverData)
	if result.Bet != 1000 || result.Payout != 3950 || result.KenDelta != 2950 {
		t.Fatalf("payout = %d, kenDelta = %d; want 3950 and 2950", result.Payout, result.KenDelta)
	}
}

func TestTycoonEveryoneLeavingPaysTheRichestSeat(t *testing.T) {
	gameEngine, _, match := startTycoonMatch(t, 2)
	defer stopEngineTimers(gameEngine)

	state := match.state.(*tycoon.State)
	state.Players[0].Cash = 9000
	state.Players[1].Cash = 1
	match.mu.Lock()
	winner := gameEngine.winnerWhenEveryoneLeft(match)
	match.mu.Unlock()
	if winner != match.players[0].ID {
		t.Fatalf("winner = %s, want %s", winner, match.players[0].ID)
	}
}

func TestTycoonFinishedSnapshotKeepsRankingsForSettlement(t *testing.T) {
	gameEngine, emitter, match := startTycoonMatch(t, 4)
	defer stopEngineTimers(gameEngine)

	playTycoonToEnd(t, gameEngine, emitter, match)
	final := match.state.(*tycoon.State)
	raw, err := json.Marshal(final)
	if err != nil {
		t.Fatal(err)
	}
	overEnv, _ := emitter.last(match.players[0].ID, protocol.S2CMatchOver)
	snapshot := ActiveMatchSnapshot{
		ID:           match.ID,
		GameID:       tycoon.GameID,
		Players:      match.players,
		State:        raw,
		StateVersion: tycoon.StateVersion,
		Status:       matchStatusFinished,
		WinnerID:     overEnv.Data.(protocol.MatchOverData).WinnerID,
		ResultReason: "win",
		FinishedAt:   1,
	}
	outcome, ok := outcomeFromSnapshot(snapshot)
	if !ok {
		t.Fatal("snapshot did not produce an outcome")
	}
	if len(outcome.Rankings) != 4 || outcome.Rankings[0] != snapshot.WinnerID || outcome.MoveCount != final.MoveCount {
		t.Fatalf("outcome rankings %v moves %d, want winner %s and %d moves", outcome.Rankings, outcome.MoveCount, snapshot.WinnerID, final.MoveCount)
	}
}
