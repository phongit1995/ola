package xiangqi

import (
	"encoding/json"
	"errors"
)

type Move struct {
	From *int `json:"from"`
	To   *int `json:"to"`
}

func parseMove(raw json.RawMessage) (int, int, error) {
	var m Move
	if err := json.Unmarshal(raw, &m); err != nil {
		return 0, 0, errors.New("invalid move payload")
	}
	if m.From == nil || m.To == nil {
		return 0, 0, errors.New("missing move squares")
	}
	from, to := *m.From, *m.To
	if from < 0 || from >= BoardCells || to < 0 || to >= BoardCells {
		return 0, 0, errors.New("move out of board")
	}
	if from == to {
		return 0, 0, errors.New("move must change square")
	}
	return from, to, nil
}

func checkMove(s *State, playerIdx, from, to int) error {
	if s.Winner != noneWin {
		return errors.New("match already finished")
	}
	if playerIdx != s.MoveCount%2 {
		return errors.New("not your turn")
	}
	p := s.Board[from]
	if p == Empty {
		return errors.New("no piece at source")
	}
	if pieceSide(p) != playerIdx {
		return errors.New("not your piece")
	}
	if t := s.Board[to]; t != Empty && pieceSide(t) == playerIdx {
		return errors.New("cannot capture own piece")
	}
	for _, m := range legalMovesFrom(s.Board, from) {
		if m == to {
			return nil
		}
	}
	return errors.New("illegal move")
}

func applyMove(s *State, playerIdx, from, to int) {
	piece := s.Board[from]
	captured := s.Board[to]
	s.Board[to] = piece
	s.Board[from] = Empty
	s.MoveCount++
	s.LastFrom = from
	s.LastTo = to
	if captured != Empty {
		s.HalfmoveClock = 0
		s.History = s.History[:0]
		s.HistoryChecks = s.HistoryChecks[:0]
	} else {
		s.HalfmoveClock++
	}
	opp := 1 - playerIdx
	key := positionKey(s.Board, opp)
	oppInCheck := inCheck(s.Board, opp)
	s.History = append(s.History, key)
	s.HistoryChecks = append(s.HistoryChecks, oppInCheck)
	s.Check = oppInCheck
	kind := StepMove
	if captured != Empty {
		kind = StepCapture
	}
	s.Steps = []Step{{Kind: kind, From: from, To: to, Piece: piece, Captured: captured}}
	if oppInCheck {
		s.Steps = append(s.Steps, Step{Kind: StepCheck, From: -1, To: -1})
	}
	if !hasLegalMove(s.Board, opp) {
		s.Winner = playerIdx
		reason := ReasonStalemate
		if oppInCheck {
			reason = ReasonCheckmate
		}
		s.Steps = append(s.Steps, Step{Kind: StepMate, From: -1, To: -1, Reason: reason})
		return
	}
	if keyCount(s.History, key) >= RepetitionLimit {
		if loser, ok := perpetualChecker(s.History, s.HistoryChecks, key, s.MoveCount); ok {
			s.Winner = 1 - loser
			s.Steps = append(s.Steps, Step{Kind: StepMate, From: -1, To: -1, Reason: ReasonPerpetual})
		} else {
			s.Winner = drawWin
			s.Steps = append(s.Steps, Step{Kind: StepDraw, From: -1, To: -1, Reason: ReasonRepetition})
		}
		return
	}
	if s.HalfmoveClock >= HalfmoveDrawPlies {
		s.Winner = drawWin
		s.Steps = append(s.Steps, Step{Kind: StepDraw, From: -1, To: -1, Reason: ReasonHalfmove})
	}
}

func keyCount(history []string, key string) int {
	n := 0
	for _, k := range history {
		if k == key {
			n++
		}
	}
	return n
}

func perpetualChecker(history []string, checks []bool, key string, moveCount int) (int, bool) {
	first := -1
	for i, k := range history {
		if k == key {
			first = i
			break
		}
	}
	if first < 0 {
		return 0, false
	}
	last := len(history) - 1
	allCheck := [2]bool{true, true}
	seen := [2]bool{}
	for j := first + 1; j <= last; j++ {
		entrySide := ((moveCount-(len(history)-1-j))%2 + 2) % 2
		mover := 1 - entrySide
		seen[mover] = true
		if !checks[j] {
			allCheck[mover] = false
		}
	}
	for side := 0; side < 2; side++ {
		if seen[side] && allCheck[side] && !(seen[1-side] && allCheck[1-side]) {
			return side, true
		}
	}
	return 0, false
}
