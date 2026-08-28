package xiangqi

import (
	"encoding/json"
	"errors"

	"ola-chat-server/internal/game/logic"
)

type Logic struct{}

func init() {
	logic.Register(Logic{})
}

func (Logic) ID() string { return GameID }

func (Logic) StateVersion() int { return 1 }

func (Logic) Init(seed int64) any { return newGame() }

func (Logic) TurnSeconds() int { return TurnSeconds }

func (Logic) DecodeState(data json.RawMessage) (any, error) {
	return decodeState(data)
}

func (Logic) ValidateMove(state any, playerIdx int, move json.RawMessage) error {
	s, ok := state.(*State)
	if !ok {
		return errors.New("invalid state")
	}
	from, to, err := parseMove(move)
	if err != nil {
		return err
	}
	return checkMove(s, playerIdx, from, to)
}

func (Logic) Apply(state any, playerIdx int, move json.RawMessage) (any, error) {
	s, ok := state.(*State)
	if !ok {
		return state, errors.New("invalid state")
	}
	from, to, err := parseMove(move)
	if err != nil {
		return state, err
	}
	if err := checkMove(s, playerIdx, from, to); err != nil {
		return state, err
	}
	next := cloneState(s)
	applyMove(next, playerIdx, from, to)
	return next, nil
}

func (Logic) MoveOnTimeout(state any, playerIdx int) (json.RawMessage, bool) {
	s, ok := state.(*State)
	if !ok || s.Winner != noneWin || playerIdx != s.MoveCount%2 {
		return nil, false
	}
	move, ok := chooseBestMove(s.Board, playerIdx, timeoutMoveDepth, timeoutMoveBudget)
	if !ok {
		return nil, false
	}
	raw, err := json.Marshal(Move{From: &move.From, To: &move.To})
	if err != nil {
		return nil, false
	}
	return raw, true
}

func (Logic) Result(state any) (bool, int) {
	s, ok := state.(*State)
	if !ok {
		return false, -1
	}
	switch s.Winner {
	case noneWin:
		return false, -1
	case drawWin:
		return true, -1
	default:
		return true, s.Winner
	}
}

func (Logic) MoveCount(state any) int {
	s, ok := state.(*State)
	if !ok {
		return 0
	}
	return s.MoveCount
}
