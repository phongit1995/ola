package thirteen

import (
	"encoding/json"
	"errors"
	"sort"
)

const (
	MoveTypePlay = "play"
	MoveTypePass = "pass"
)

type Move struct {
	Type  string `json:"type"`
	Cards []int  `json:"cards,omitempty"`
}

func parseMove(raw json.RawMessage) (Move, error) {
	var mv Move
	if err := json.Unmarshal(raw, &mv); err != nil {
		return Move{}, errors.New("invalid move payload")
	}
	switch mv.Type {
	case MoveTypePlay:
		if len(mv.Cards) == 0 || len(mv.Cards) > HandSize {
			return Move{}, errors.New("a play needs between 1 and 13 cards")
		}
	case MoveTypePass:
		if len(mv.Cards) != 0 {
			return Move{}, errors.New("a pass carries no cards")
		}
	default:
		return Move{}, errors.New("unknown move type")
	}
	return mv, nil
}

func checkMove(s *State, playerIdx int, mv Move) (Combo, error) {
	if playerIdx < 0 || playerIdx >= s.playerCount() {
		return Combo{}, errors.New("invalid player")
	}
	if s.InstantWin != "" {
		return Combo{}, errors.New("the round already ended")
	}
	if !s.isActive(playerIdx) || !s.hasCards(playerIdx) {
		return Combo{}, errors.New("player can no longer act")
	}
	if mv.Type == MoveTypePass {
		if s.Table == nil {
			return Combo{}, errors.New("the leader must play a combination")
		}
		return Combo{}, nil
	}

	hand := s.Hands[playerIdx]
	seen := make(map[int]bool, len(mv.Cards))
	for _, card := range mv.Cards {
		if seen[card] {
			return Combo{}, errors.New("duplicate card in play")
		}
		seen[card] = true
		if !containsCard(hand, card) {
			return Combo{}, errors.New("card is not in hand")
		}
	}
	combo, err := classify(mv.Cards)
	if err != nil {
		return Combo{}, err
	}
	if s.RequireThreeSpades && !seen[ThreeOfSpades] {
		return Combo{}, errors.New("the first play must include the three of spades")
	}
	if s.Table != nil {
		prev, prevErr := classify(s.Table.Cards)
		if prevErr != nil {
			return Combo{}, errors.New("table state is invalid")
		}
		if !beats(combo, prev) {
			return Combo{}, errors.New("this combination does not beat the table")
		}
	}
	return combo, nil
}

func applyMove(s *State, playerIdx int, mv Move) error {
	combo, err := checkMove(s, playerIdx, mv)
	if err != nil {
		return err
	}

	if mv.Type == MoveTypePass {
		s.Passed[playerIdx] = true
		s.Steps = append(s.Steps, Step{Kind: StepPass, By: playerIdx})
		s.MoveCount++
		s.advanceAfter(playerIdx)
		return nil
	}

	chop := false
	if s.Table != nil {
		if prev, prevErr := classify(s.Table.Cards); prevErr == nil {
			chop = combo.Kind != prev.Kind || combo.Length != prev.Length
		}
	}

	remaining := make([]int, 0, len(s.Hands[playerIdx])-len(mv.Cards))
	played := make(map[int]bool, len(mv.Cards))
	for _, card := range mv.Cards {
		played[card] = true
	}
	for _, card := range s.Hands[playerIdx] {
		if !played[card] {
			remaining = append(remaining, card)
		}
	}
	s.Hands[playerIdx] = remaining

	playedCards := append([]int(nil), mv.Cards...)
	sort.Ints(playedCards)
	s.Table = &Play{Cards: playedCards, By: playerIdx}
	s.RequireThreeSpades = false
	s.Steps = append(s.Steps, Step{Kind: StepPlay, By: playerIdx, Cards: playedCards, Chop: chop})
	s.MoveCount++

	if len(remaining) == 0 {
		s.FinishOrder = append(s.FinishOrder, playerIdx)
		s.Steps = append(s.Steps, Step{Kind: StepFinish, By: playerIdx, Place: len(s.FinishOrder)})
	}
	if active := s.activeWithCards(); len(active) == 1 {
		last := active[0]
		s.FinishOrder = append(s.FinishOrder, last)
		s.Steps = append(s.Steps, Step{Kind: StepFinish, By: last, Place: len(s.FinishOrder)})
		return nil
	}
	s.advanceAfter(playerIdx)
	return nil
}

func cloneState(s *State) *State {
	next := &State{
		Hands:              make([][]int, len(s.Hands)),
		Passed:             append([]bool(nil), s.Passed...),
		Quit:               append([]bool(nil), s.Quit...),
		FinishOrder:        append([]int(nil), s.FinishOrder...),
		QuitOrder:          append([]int(nil), s.QuitOrder...),
		Turn:               s.Turn,
		Starter:            s.Starter,
		RequireThreeSpades: s.RequireThreeSpades,
		InstantWin:         s.InstantWin,
		Rng:                s.Rng,
		MoveCount:          s.MoveCount,
		Steps:              []Step{},
	}
	for i, hand := range s.Hands {
		next.Hands[i] = append([]int(nil), hand...)
	}
	if s.Table != nil {
		next.Table = &Play{Cards: append([]int(nil), s.Table.Cards...), By: s.Table.By}
	}
	return next
}
