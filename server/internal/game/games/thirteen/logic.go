package thirteen

import (
	"encoding/json"
	"errors"
	"time"

	"ola-chat-server/internal/game/logic"
)

const (
	GameID      = "thirteen"
	TurnSeconds = 30
)

type Logic struct{}

func init() {
	logic.Register(Logic{})
}

func (Logic) ID() string { return GameID }

func (Logic) StateVersion() int { return 1 }

func (Logic) Init(seed int64) any { return newDeal(seed, 4) }

func (Logic) InitPlayers(seed int64, playerCount int) any {
	if playerCount < 2 {
		playerCount = 2
	}
	if playerCount > 4 {
		playerCount = 4
	}
	return newDeal(seed, playerCount)
}

func (Logic) MinPlayers() int { return 2 }

func (Logic) MaxPlayers() int { return 4 }

func (Logic) TurnSeconds() int { return TurnSeconds }

func (Logic) TimeoutSkipsTurn() bool { return true }

func (Logic) DecodeState(data json.RawMessage) (any, error) {
	return decodeState(data)
}

func (Logic) ValidateMove(state any, playerIdx int, move json.RawMessage) error {
	s, ok := state.(*State)
	if !ok {
		return errors.New("invalid state")
	}
	mv, err := parseMove(move)
	if err != nil {
		return err
	}
	_, err = checkMove(s, playerIdx, mv)
	return err
}

func (Logic) Apply(state any, playerIdx int, move json.RawMessage) (any, error) {
	s, ok := state.(*State)
	if !ok {
		return state, errors.New("invalid state")
	}
	mv, err := parseMove(move)
	if err != nil {
		return state, err
	}
	next := cloneState(s)
	if err := applyMove(next, playerIdx, mv); err != nil {
		return state, err
	}
	return next, nil
}

func (Logic) Result(state any) (bool, int) {
	s, ok := state.(*State)
	if !ok {
		return false, -1
	}
	if s.InstantWin != "" {
		if len(s.FinishOrder) > 0 {
			return true, s.FinishOrder[0]
		}
		return true, -1
	}
	if len(s.activeWithCards()) > 1 {
		return false, -1
	}
	if len(s.FinishOrder) > 0 {
		return true, s.FinishOrder[0]
	}
	if active := s.activeWithCards(); len(active) == 1 {
		return true, active[0]
	}
	return true, -1
}

func (Logic) NextTurn(state any, currentIdx int) int {
	s, ok := state.(*State)
	if !ok {
		return -1
	}
	return s.Turn
}

func (Logic) OnTurnSkipped(state any, playerIdx int) {
	s, ok := state.(*State)
	if !ok {
		return
	}
	s.Steps = nil
	if !s.isActive(playerIdx) || !s.hasCards(playerIdx) {
		return
	}
	if s.Table == nil {
		card := s.Hands[playerIdx][0]
		if s.RequireThreeSpades && containsCard(s.Hands[playerIdx], ThreeOfSpades) {
			card = ThreeOfSpades
		}
		if err := applyMove(s, playerIdx, Move{Type: MoveTypePlay, Cards: []int{card}}); err == nil {
			return
		}
	}
	if err := applyMove(s, playerIdx, Move{Type: MoveTypePass, Cards: nil}); err != nil {
		s.Passed[playerIdx] = true
		s.MoveCount++
		s.advanceAfter(playerIdx)
	}
}

func (Logic) OnPlayerQuit(state any, playerIdx int) {
	s, ok := state.(*State)
	if !ok {
		return
	}
	if playerIdx < 0 || playerIdx >= s.playerCount() || s.Quit[playerIdx] {
		return
	}
	s.Steps = nil
	s.Quit[playerIdx] = true
	s.Passed[playerIdx] = false
	alreadyRanked := false
	for _, idx := range s.FinishOrder {
		if idx == playerIdx {
			alreadyRanked = true
			break
		}
	}
	if !alreadyRanked {
		s.QuitOrder = append(s.QuitOrder, playerIdx)
	}
	if s.Turn == playerIdx {
		s.advanceAfter(playerIdx)
	}
}

func (Logic) Rankings(state any) []int {
	s, ok := state.(*State)
	if !ok {
		return nil
	}
	n := s.playerCount()
	ranked := make([]int, 0, n)
	seen := make(map[int]bool, n)
	for _, idx := range s.FinishOrder {
		if !seen[idx] {
			ranked = append(ranked, idx)
			seen[idx] = true
		}
	}
	for idx := 0; idx < n; idx++ {
		if !seen[idx] && s.isActive(idx) {
			ranked = append(ranked, idx)
			seen[idx] = true
		}
	}
	for i := len(s.QuitOrder) - 1; i >= 0; i-- {
		idx := s.QuitOrder[i]
		if !seen[idx] {
			ranked = append(ranked, idx)
			seen[idx] = true
		}
	}
	return ranked
}

func (Logic) MoveCount(state any) int {
	s, ok := state.(*State)
	if !ok {
		return 0
	}
	return s.MoveCount
}

func (Logic) TurnStartDelay(state any, previousPlayerIdx, nextPlayerIdx int) time.Duration {
	s, ok := state.(*State)
	if !ok {
		return 0
	}
	if previousPlayerIdx < 0 {
		return 4 * time.Second
	}
	delay := 400 * time.Millisecond
	for _, step := range s.Steps {
		switch step.Kind {
		case StepPlay:
			delay += 500 * time.Millisecond
			if step.Chop {
				delay += 400 * time.Millisecond
			}
		case StepClear:
			delay += 500 * time.Millisecond
		case StepFinish:
			delay += 600 * time.Millisecond
		}
	}
	if delay > 3*time.Second {
		delay = 3 * time.Second
	}
	return delay
}
