package logic

import (
	"encoding/json"
	"fmt"
)

type GameLogic interface {
	ID() string
	StateVersion() int
	Init(seed int64) any
	DecodeState(data json.RawMessage) (any, error)
	ValidateMove(state any, playerIdx int, move json.RawMessage) error
	Apply(state any, playerIdx int, move json.RawMessage) (any, error)
	Result(state any) (over bool, winnerIdx int)
}

type TurnKeeper interface {
	KeepTurn(state any) bool
}

type TimeoutSkipper interface {
	TimeoutSkipsTurn() bool
}

// TurnSkipHandler lets a game clear or consume turn-bound state when the
// engine skips an action without calling Apply (currently on turn timeout).
type TurnSkipHandler interface {
	OnTurnSkipped(state any, playerIdx int)
}

var registry = map[string]GameLogic{}

func Register(l GameLogic) {
	registry[l.ID()] = l
}

func Get(gameID string) (GameLogic, error) {
	l, ok := registry[gameID]
	if !ok {
		return nil, fmt.Errorf("unknown game: %s", gameID)
	}
	return l, nil
}

func IDs() []string {
	ids := make([]string, 0, len(registry))
	for id := range registry {
		ids = append(ids, id)
	}
	return ids
}
