package caro

import (
	"encoding/json"
	"errors"
	"ola-chat-server/internal/game/logic"
)

const (
	Size    = 20
	WinLen  = 5
	noneWin = -1
	drawWin = -2
)

type State struct {
	Board     []int `json:"board"`
	MoveCount int   `json:"moveCount"`
	LastX     int   `json:"lastX"`
	LastY     int   `json:"lastY"`
	Winner    int   `json:"-"`
}

type Move struct {
	X *int `json:"x"`
	Y *int `json:"y"`
}

type Logic struct{}

func init() {
	logic.Register(Logic{})
}

func (Logic) ID() string { return "caro" }

func (Logic) StateVersion() int { return 1 }

func (Logic) Init(seed int64) any {
	return &State{
		Board:  make([]int, Size*Size),
		LastX:  -1,
		LastY:  -1,
		Winner: noneWin,
	}
}

func (Logic) DecodeState(data json.RawMessage) (any, error) {
	state := &State{Winner: noneWin}
	if err := json.Unmarshal(data, state); err != nil {
		return nil, errors.New("invalid saved caro state")
	}
	if len(state.Board) != Size*Size {
		return nil, errors.New("invalid saved caro board")
	}
	return state, nil
}

func parseMove(raw json.RawMessage) (int, int, error) {
	var m Move
	if err := json.Unmarshal(raw, &m); err != nil {
		return 0, 0, errors.New("invalid move payload")
	}
	if m.X == nil || m.Y == nil {
		return 0, 0, errors.New("missing move coordinates")
	}
	x, y := *m.X, *m.Y
	if x < 0 || x >= Size || y < 0 || y >= Size {
		return 0, 0, errors.New("move out of board")
	}
	return x, y, nil
}

func (Logic) ValidateMove(state any, playerIdx int, move json.RawMessage) error {
	s := state.(*State)
	x, y, err := parseMove(move)
	if err != nil {
		return err
	}
	if s.Board[y*Size+x] != 0 {
		return errors.New("cell already taken")
	}
	return nil
}

func (Logic) Apply(state any, playerIdx int, move json.RawMessage) (any, error) {
	current := state.(*State)
	x, y, err := parseMove(move)
	if err != nil {
		return current, err
	}
	s := &State{
		Board:     append([]int(nil), current.Board...),
		MoveCount: current.MoveCount,
		LastX:     current.LastX,
		LastY:     current.LastY,
		Winner:    current.Winner,
	}
	s.Board[y*Size+x] = playerIdx + 1
	s.MoveCount++
	s.LastX = x
	s.LastY = y
	if wins(s.Board, x, y, playerIdx+1) {
		s.Winner = playerIdx
	} else if s.MoveCount == Size*Size {
		s.Winner = drawWin
	}
	return s, nil
}

func (Logic) MoveCount(state any) int {
	s, ok := state.(*State)
	if !ok {
		return 0
	}
	return s.MoveCount
}

func (Logic) Result(state any) (bool, int) {
	s := state.(*State)
	switch s.Winner {
	case noneWin:
		return false, -1
	case drawWin:
		return true, -1
	default:
		return true, s.Winner
	}
}

var directions = [4][2]int{{1, 0}, {0, 1}, {1, 1}, {1, -1}}

func wins(board []int, x, y, mark int) bool {
	for _, d := range directions {
		count := 1
		for _, sign := range [2]int{1, -1} {
			cx, cy := x, y
			for {
				cx += d[0] * sign
				cy += d[1] * sign
				if cx < 0 || cx >= Size || cy < 0 || cy >= Size || board[cy*Size+cx] != mark {
					break
				}
				count++
			}
		}
		if count >= WinLen {
			return true
		}
	}
	return false
}
