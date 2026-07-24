package engine

import (
	"encoding/json"
	"testing"

	"ola-chat-server/internal/game/games/caro"
	"ola-chat-server/internal/game/protocol"
)

type caroPoint struct {
	x int
	y int
}

func startCaroIntegrationMatch(t *testing.T) (*Engine, *memoryActiveMatchStore, *captureEmitter, *Match) {
	t.Helper()
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	if err := gameEngine.startMatch(
		"caro",
		caro.Logic{},
		protocol.PlayerInfo{ID: "caro-a", Name: "Caro A"},
		protocol.PlayerInfo{ID: "caro-b", Name: "Caro B"},
		0,
	); err != nil {
		t.Fatalf("start Caro match: %v", err)
	}
	for _, match := range gameEngine.matches {
		return gameEngine, activeStore, emitter, match
	}
	t.Fatal("Caro match was not created")
	return nil, nil, nil, nil
}

func caroMoveRaw(t *testing.T, point caroPoint) json.RawMessage {
	t.Helper()
	raw, err := json.Marshal(map[string]int{"x": point.x, "y": point.y})
	if err != nil {
		t.Fatal(err)
	}
	return raw
}

func TestCaroEngineDetectsWinsInEveryDirection(t *testing.T) {
	tests := []struct {
		name  string
		moves []caroPoint
	}{
		{name: "horizontal", moves: []caroPoint{{2, 2}, {3, 2}, {4, 2}, {5, 2}, {6, 2}}},
		{name: "vertical", moves: []caroPoint{{2, 2}, {2, 3}, {2, 4}, {2, 5}, {2, 6}}},
		{name: "diagonal down", moves: []caroPoint{{2, 2}, {3, 3}, {4, 4}, {5, 5}, {6, 6}}},
		{name: "diagonal up", moves: []caroPoint{{2, 6}, {3, 5}, {4, 4}, {5, 3}, {6, 2}}},
	}
	filler := []caroPoint{{10, 15}, {11, 15}, {12, 15}, {13, 15}}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			gameEngine, activeStore, emitter, match := startCaroIntegrationMatch(t)
			defer stopEngineTimers(gameEngine)
			winnerID := match.players[0].ID

			for i, point := range test.moves {
				if match.turnIdx != 0 {
					t.Fatalf("winning player lost the expected turn before move %d", i+1)
				}
				gameEngine.Move(match.GameID, match.players[0].ID, match.ID, caroMoveRaw(t, point))
				if i == len(test.moves)-1 {
					break
				}
				if match.turnIdx != 1 {
					t.Fatalf("filler player did not receive turn after move %d", i+1)
				}
				gameEngine.Move(match.GameID, match.players[1].ID, match.ID, caroMoveRaw(t, filler[i]))
			}

			if !match.over || gameEngine.matches[match.ID] != nil {
				t.Fatal("five-in-a-row did not finish the match")
			}
			if _, exists := activeStore.get(match.GameID, match.ID); exists {
				t.Fatal("finished Caro snapshot remains active")
			}
			for _, player := range match.players {
				envelope, ok := emitter.last(player.ID, protocol.S2CMatchOver)
				if !ok {
					t.Fatalf("%s did not receive MATCH_OVER", player.ID)
				}
				result := envelope.Data.(protocol.MatchOverData)
				if result.WinnerID != winnerID || result.Reason != "win" {
					t.Fatalf("unexpected win result: %+v", result)
				}
			}
		})
	}
}

func TestCaroEngineDetectsDrawOnFullBoard(t *testing.T) {
	gameEngine, activeStore, emitter, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)
	board := make([]int, caro.Size*caro.Size)
	for y := 0; y < caro.Size; y++ {
		for x := 0; x < caro.Size; x++ {
			board[y*caro.Size+x] = ((x+2*y)%4)/2 + 1
		}
	}
	last := caroPoint{x: caro.Size - 1, y: caro.Size - 1}
	board[last.y*caro.Size+last.x] = 0
	match.state = &caro.State{
		Board:     board,
		MoveCount: caro.Size*caro.Size - 1,
		LastX:     last.x - 1,
		LastY:     last.y,
		Winner:    -1,
	}
	match.turnIdx = 0

	gameEngine.Move(match.GameID, match.players[0].ID, match.ID, caroMoveRaw(t, last))
	if !match.over || gameEngine.matches[match.ID] != nil {
		t.Fatal("full board did not finish the match")
	}
	if _, exists := activeStore.get(match.GameID, match.ID); exists {
		t.Fatal("draw snapshot remains active")
	}
	for _, player := range match.players {
		envelope, ok := emitter.last(player.ID, protocol.S2CMatchOver)
		if !ok {
			t.Fatalf("%s did not receive draw result", player.ID)
		}
		result := envelope.Data.(protocol.MatchOverData)
		if result.WinnerID != "" || result.Reason != "draw" {
			t.Fatalf("unexpected draw result: %+v", result)
		}
	}
}

func TestCaroEngineRejectsOccupiedAndOutOfBoundsMoves(t *testing.T) {
	tests := []struct {
		name    string
		prepare func(*testing.T, *Engine, *Match)
		move    json.RawMessage
	}{
		{
			name: "occupied cell",
			prepare: func(t *testing.T, gameEngine *Engine, match *Match) {
				gameEngine.Move(match.GameID, match.players[match.turnIdx].ID, match.ID, json.RawMessage(`{"x":3,"y":4}`))
			},
			move: json.RawMessage(`{"x":3,"y":4}`),
		},
		{name: "negative coordinate", move: json.RawMessage(`{"x":-1,"y":0}`)},
		{name: "coordinate past board", move: json.RawMessage(`{"x":20,"y":0}`)},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			gameEngine, activeStore, emitter, match := startCaroIntegrationMatch(t)
			defer stopEngineTimers(gameEngine)
			if test.prepare != nil {
				test.prepare(t, gameEngine, match)
			}
			beforeState := match.state.(*caro.State)
			beforeMoves := beforeState.MoveCount
			beforeTurn := match.turnIdx
			beforeActions := len(match.actions)
			playerID := match.players[match.turnIdx].ID

			gameEngine.Move(match.GameID, playerID, match.ID, test.move)
			state := match.state.(*caro.State)
			if state.MoveCount != beforeMoves || match.turnIdx != beforeTurn || len(match.actions) != beforeActions {
				t.Fatal("invalid move changed match state, turn, or action history")
			}
			envelope, ok := emitter.last(playerID, protocol.S2CError)
			if !ok || envelope.Data.(protocol.ErrorData).Code != "INVALID_MOVE" {
				t.Fatal("invalid Caro move did not emit INVALID_MOVE")
			}
			snapshot, ok := activeStore.get(match.GameID, match.ID)
			if !ok || snapshot.TurnIndex != beforeTurn || len(snapshot.Actions) != beforeActions {
				t.Fatalf("invalid move changed persisted snapshot: %+v", snapshot)
			}
		})
	}
}
