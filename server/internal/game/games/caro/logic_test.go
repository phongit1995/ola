package caro

import (
	"encoding/json"
	"testing"
)

func TestDecodeStateRestoresCaroBoard(t *testing.T) {
	gameLogic := Logic{}
	state := gameLogic.Init(1).(*State)
	next, err := gameLogic.Apply(state, 0, json.RawMessage(`{"x":3,"y":4}`))
	if err != nil {
		t.Fatal(err)
	}
	data, err := json.Marshal(next)
	if err != nil {
		t.Fatal(err)
	}
	restoredAny, err := gameLogic.DecodeState(data)
	if err != nil {
		t.Fatal(err)
	}
	restored := restoredAny.(*State)
	if restored.Board[4*Size+3] != 1 || restored.MoveCount != 1 || restored.LastX != 3 || restored.LastY != 4 {
		t.Fatalf("unexpected restored state: %+v", restored)
	}
	if restored.Winner != noneWin {
		t.Fatalf("active restored state has unexpected winner: %d", restored.Winner)
	}
}

func TestApplyDoesNotMutatePreviousCaroState(t *testing.T) {
	gameLogic := Logic{}
	initial := gameLogic.Init(1).(*State)
	nextAny, err := gameLogic.Apply(initial, 0, json.RawMessage(`{"x":1,"y":2}`))
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)
	if initial == next || initial.Board[2*Size+1] != 0 || initial.MoveCount != 0 {
		t.Fatal("Apply mutated the previous state")
	}
	if next.Board[2*Size+1] != 1 || next.MoveCount != 1 {
		t.Fatal("Apply did not create the expected next state")
	}
}

func TestDecodeStateRejectsInvalidCaroSnapshots(t *testing.T) {
	tests := []struct {
		name string
		data json.RawMessage
	}{
		{name: "malformed json", data: json.RawMessage(`{"board":`)},
		{name: "wrong board size", data: json.RawMessage(`{"board":[0,0],"moveCount":0,"lastX":-1,"lastY":-1}`)},
		{
			name: "invalid cell",
			data: snapshotWith(func(state *State) {
				state.Board[0] = 3
				state.MoveCount = 1
				state.LastX = 0
				state.LastY = 0
			}),
		},
		{
			name: "inconsistent move count",
			data: snapshotWith(func(state *State) {
				state.Board[0] = 1
				state.MoveCount = 0
			}),
		},
		{
			name: "invalid last move",
			data: snapshotWith(func(state *State) {
				state.Board[0] = 1
				state.MoveCount = 1
				state.LastX = Size
				state.LastY = 0
			}),
		},
		{
			name: "wrong last player",
			data: snapshotWith(func(state *State) {
				state.Board[0] = 1
				state.Board[1] = 2
				state.MoveCount = 2
				state.LastX = 0
				state.LastY = 0
			}),
		},
		{
			name: "completed board",
			data: snapshotWith(func(state *State) {
				for x := 0; x < WinLen; x++ {
					state.Board[x] = 1
					if x < WinLen-1 {
						state.Board[Size+x] = 2
					}
				}
				state.MoveCount = WinLen*2 - 1
				state.LastX = WinLen - 1
				state.LastY = 0
			}),
		},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			if _, err := (Logic{}).DecodeState(test.data); err == nil {
				t.Fatal("invalid snapshot was accepted")
			}
		})
	}
}

func snapshotWith(update func(*State)) json.RawMessage {
	state := &State{
		Board:  make([]int, Size*Size),
		LastX:  -1,
		LastY:  -1,
		Winner: noneWin,
	}
	update(state)
	data, err := json.Marshal(state)
	if err != nil {
		panic(err)
	}
	return data
}

func TestCaroStateVersion(t *testing.T) {
	if version := (Logic{}).StateVersion(); version != 1 {
		t.Fatalf("unexpected state version: %d", version)
	}
}
