package xiangqi

import (
	"encoding/json"
	"errors"
)

const (
	StepMove    = "move"
	StepCapture = "capture"
	StepCheck   = "check"
	StepMate    = "mate"
	StepDraw    = "draw"

	ReasonCheckmate  = "checkmate"
	ReasonStalemate  = "stalemate"
	ReasonPerpetual  = "perpetual"
	ReasonRepetition = "repetition"
	ReasonHalfmove   = "halfmove"

	noneWin = -1
	drawWin = -2
)

type State struct {
	Board         []int    `json:"board"`
	MoveCount     int      `json:"moveCount"`
	HalfmoveClock int      `json:"halfmoveClock"`
	History       []string `json:"history"`
	HistoryChecks []bool   `json:"historyChecks"`
	LastFrom      int      `json:"lastFrom"`
	LastTo        int      `json:"lastTo"`
	Check         bool     `json:"check"`
	Steps         []Step   `json:"steps,omitempty"`
	Winner        int      `json:"-"`
}

type Step struct {
	Kind     string `json:"kind"`
	From     int    `json:"from"`
	To       int    `json:"to"`
	Piece    int    `json:"piece,omitempty"`
	Captured int    `json:"captured,omitempty"`
	Reason   string `json:"reason,omitempty"`
}

func newGame() *State {
	board := append([]int(nil), startBoard...)
	return &State{
		Board:         board,
		History:       []string{positionKey(board, SideRed)},
		HistoryChecks: []bool{false},
		LastFrom:      -1,
		LastTo:        -1,
		Winner:        noneWin,
	}
}

func cloneState(s *State) *State {
	return &State{
		Board:         append([]int(nil), s.Board...),
		MoveCount:     s.MoveCount,
		HalfmoveClock: s.HalfmoveClock,
		History:       append([]string(nil), s.History...),
		HistoryChecks: append([]bool(nil), s.HistoryChecks...),
		LastFrom:      s.LastFrom,
		LastTo:        s.LastTo,
		Check:         s.Check,
		Winner:        s.Winner,
	}
}

func decodeState(data json.RawMessage) (*State, error) {
	state := &State{Winner: noneWin}
	if err := json.Unmarshal(data, state); err != nil {
		return nil, errors.New("invalid saved xiangqi state")
	}
	state.Steps = nil
	state.Winner = noneWin
	if err := validateSavedState(state); err != nil {
		return nil, err
	}
	return state, nil
}

func validateSavedState(s *State) error {
	if len(s.Board) != BoardCells {
		return errors.New("invalid saved xiangqi board")
	}
	counts := make([]int, MaxPiece+1)
	for idx, p := range s.Board {
		if p < Empty || p > MaxPiece {
			return errors.New("invalid saved xiangqi cell")
		}
		if p == Empty {
			continue
		}
		counts[p]++
		side := pieceSide(p)
		x, y := boardX(idx), boardY(idx)
		switch pieceKind(p) {
		case KindGeneral:
			if !inPalace(x, y, side) {
				return errors.New("general outside palace")
			}
		case KindAdvisor:
			if !validAdvisorSpot(x, y, side) {
				return errors.New("advisor off its legal points")
			}
		case KindElephant:
			if !validElephantSpot(x, y, side) {
				return errors.New("elephant off its legal points")
			}
		case KindSoldier:
			if !validSoldierSpot(x, y, side) {
				return errors.New("soldier off its legal points")
			}
		}
	}
	for side := 0; side < 2; side++ {
		if counts[pieceFor(side, KindGeneral)] != 1 {
			return errors.New("each side must have exactly one general")
		}
		for _, kind := range []int{KindAdvisor, KindElephant, KindHorse, KindChariot, KindCannon} {
			if counts[pieceFor(side, kind)] > 2 {
				return errors.New("too many pieces of one kind")
			}
		}
		if counts[pieceFor(side, KindSoldier)] > 5 {
			return errors.New("too many soldiers")
		}
	}

	if s.MoveCount < 0 || s.HalfmoveClock < 0 || s.HalfmoveClock >= HalfmoveDrawPlies || s.HalfmoveClock > s.MoveCount {
		return errors.New("invalid saved xiangqi clocks")
	}
	if len(s.History) != s.HalfmoveClock+1 || len(s.HistoryChecks) != len(s.History) {
		return errors.New("invalid saved xiangqi history length")
	}
	sideToMove := s.MoveCount % 2
	keyCounts := make(map[string]int, len(s.History))
	for i, key := range s.History {
		if len(key) != BoardCells+1 {
			return errors.New("invalid saved xiangqi history key")
		}
		for j := 0; j < BoardCells; j++ {
			valid := false
			for k := 0; k < len(BoardAlphabet); k++ {
				if key[j] == BoardAlphabet[k] {
					valid = true
					break
				}
			}
			if !valid {
				return errors.New("invalid saved xiangqi history key")
			}
		}
		entrySide := ((s.MoveCount-(len(s.History)-1-i))%2 + 2) % 2
		expect := byte('r')
		if entrySide == SideBlack {
			expect = 'b'
		}
		if key[BoardCells] != expect {
			return errors.New("inconsistent saved xiangqi history sides")
		}
		keyCounts[key]++
	}
	for _, n := range keyCounts {
		if n >= RepetitionLimit {
			return errors.New("completed xiangqi state cannot be restored as active")
		}
	}
	if s.History[len(s.History)-1] != positionKey(s.Board, sideToMove) {
		return errors.New("inconsistent saved xiangqi history head")
	}
	if s.HalfmoveClock == s.MoveCount {
		if s.History[0] != positionKey(startBoard, SideRed) || s.HistoryChecks[0] {
			return errors.New("inconsistent saved xiangqi history root")
		}
	}

	if s.MoveCount == 0 {
		if s.LastFrom != -1 || s.LastTo != -1 || s.HalfmoveClock != 0 || s.Check {
			return errors.New("invalid saved xiangqi initial state")
		}
	} else {
		if s.LastFrom < 0 || s.LastFrom >= BoardCells || s.LastTo < 0 || s.LastTo >= BoardCells || s.LastFrom == s.LastTo {
			return errors.New("invalid saved xiangqi last move")
		}
		if s.Board[s.LastFrom] != Empty {
			return errors.New("inconsistent saved xiangqi last move")
		}
		moved := s.Board[s.LastTo]
		if moved == Empty || pieceSide(moved) != (s.MoveCount-1)%2 {
			return errors.New("inconsistent saved xiangqi last move")
		}
	}

	if generalsFacing(s.Board) {
		return errors.New("saved xiangqi generals facing")
	}
	if inCheck(s.Board, 1-sideToMove) {
		return errors.New("saved xiangqi opponent left in check")
	}
	if s.Check != inCheck(s.Board, sideToMove) {
		return errors.New("inconsistent saved xiangqi check flag")
	}
	if s.HistoryChecks[len(s.HistoryChecks)-1] != s.Check {
		return errors.New("inconsistent saved xiangqi history checks")
	}
	if !hasLegalMove(s.Board, sideToMove) {
		return errors.New("completed xiangqi state cannot be restored as active")
	}
	return nil
}
