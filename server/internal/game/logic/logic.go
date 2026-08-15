package logic

import (
	"encoding/json"
	"fmt"
	"time"
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

// TurnStartDelayer lets games reserve server-authoritative time for entrance
// and transition animations before the next player's normal turn time elapses.
// previousPlayerIdx is -1 for the first turn of a match.
type TurnStartDelayer interface {
	TurnStartDelay(state any, previousPlayerIdx, nextPlayerIdx int) time.Duration
}

type TimeoutSkipper interface {
	TimeoutSkipsTurn() bool
}

// TurnTimer lets a game override the engine-wide turn duration.
type TurnTimer interface {
	TurnSeconds() int
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
