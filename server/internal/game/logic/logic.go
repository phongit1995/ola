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

// PlayerCounter lets a game accept more than the default two players.
type PlayerCounter interface {
	MinPlayers() int
	MaxPlayers() int
}

// PlayerInit lets a game build its initial state for a specific player count;
// without it the engine uses Init(seed).
type PlayerInit interface {
	InitPlayers(seed int64, playerCount int) any
}

// TurnOrder lets a game control which seat plays next; the engine default is
// round-robin, which equals 1-idx for two players.
type TurnOrder interface {
	NextTurn(state any, currentIdx int) int
}

// StateViewer projects the authoritative state into what one player may see.
// Games with hidden information implement it; every non-terminal emit goes
// through the projection while Redis keeps the full state.
type StateViewer interface {
	ViewFor(state any, playerIdx int) any
}

// QuitHandler lets a match continue after a player forfeits, times out
// repeatedly, or exceeds the reconnect grace, as long as enough active
// players remain. The game marks the seat as quit inside its state.
type QuitHandler interface {
	OnPlayerQuit(state any, playerIdx int)
}

// Ranker reports the final placement of every seat (finish order, best first)
// for games that rank more than a single winner.
type Ranker interface {
	Rankings(state any) []int
}

func MinPlayers(l GameLogic) int {
	if pc, ok := l.(PlayerCounter); ok {
		if n := pc.MinPlayers(); n >= 2 {
			return n
		}
	}
	return 2
}

func MaxPlayers(l GameLogic) int {
	if pc, ok := l.(PlayerCounter); ok {
		if n := pc.MaxPlayers(); n >= 2 {
			return n
		}
	}
	return 2
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
