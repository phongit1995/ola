package engine

import (
	"encoding/json"
	"fmt"
	"testing"

	"ola-chat-server/internal/game/games/caro"
	"ola-chat-server/internal/game/protocol"
)

func TestRestoreFinishedCaroSnapshotReplaysResultAndRoom(t *testing.T) {
	gameLogic := caro.Logic{}
	state := gameLogic.Init(1)
	for i := 0; i < 9; i++ {
		x, y := i/2, i%2
		next, err := gameLogic.Apply(state, i%2, json.RawMessage(fmt.Sprintf(`{"x":%d,"y":%d}`, x, y)))
		if err != nil {
			t.Fatalf("move %d: %v", i, err)
		}
		state = next
	}
	if over, winner := gameLogic.Result(state); !over || winner != 0 {
		t.Fatalf("setup did not reach a win: over=%v winner=%d", over, winner)
	}
	raw, err := json.Marshal(state)
	if err != nil {
		t.Fatal(err)
	}
	activeStore := newMemoryActiveMatchStore()
	snapshot := ActiveMatchSnapshot{
		ID: "finished-caro", GameID: "caro",
		Players: []protocol.PlayerInfo{{ID: "player-a", Name: "A"}, {ID: "player-b", Name: "B"}},
		State:   raw, StateVersion: gameLogic.StateVersion(), Status: matchStatusFinished,
		WinnerID: "player-a", ResultReason: "win",
		Room: &Room{ID: "finished-caro-room", GameID: "caro", OwnerID: "player-a", OwnerName: "A", GuestID: "player-b", GuestName: "B", GuestReady: true},
	}
	if err := activeStore.Save(snapshot); err != nil {
		t.Fatal(err)
	}

	gameEngine, rooms, emitter := newPersistenceTestEngine(activeStore)
	if _, exists := rooms.Get("caro", snapshot.Room.ID); !exists {
		t.Fatal("waiting room of the finished caro match was not restored")
	}
	gameEngine.OnConnect("caro", "player-b")
	env, ok := emitter.last("player-b", protocol.S2CMatchOver)
	if !ok {
		t.Fatal("finished caro result was not replayed after a restart")
	}
	data := env.Data.(protocol.MatchOverData)
	if data.WinnerID != "player-a" {
		t.Fatalf("replayed winner = %q", data.WinnerID)
	}
	board, err := json.Marshal(data.State)
	if err != nil || !json.Valid(board) || string(board) == "null" {
		t.Fatalf("replayed state is not the stored board: %s %v", board, err)
	}
}
