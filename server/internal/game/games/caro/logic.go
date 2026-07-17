package caro

import (
	"encoding/json"
	"errors"
	"ola-chat-server/internal/game/logic"
)

const (
	Size    = 15
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
	X int `json:"x"`
	Y int `json:"y"`
}

type Logic struct{}

func init() {
	logic.Register(Logic{})
}

func (Logic) ID() string { return "caro" }

func (Logic) Init(seed int64) any {
	return &State{
		Board:  make([]int, Size*Size),
		LastX:  -1,
		LastY:  -1,
		Winner: noneWin,
	}
}

func parseMove(raw json.RawMessage) (Move, error) {
	var m Move
	if err := json.Unmarshal(raw, &m); err != nil {
		return m, errors.New("invalid move payload")
	}
	if m.X < 0 || m.X >= Size || m.Y < 0 || m.Y >= Size {
		return m, errors.New("move out of board")
	}
	return m, nil
}

func (Logic) ValidateMove(state any, playerIdx int, move json.RawMessage) error {
	s := state.(*State)
	m, err := parseMove(move)
	if err != nil {
		return err
	}
	if s.Board[m.Y*Size+m.X] != 0 {
		return errors.New("cell already taken")
	}
	return nil
}

func (Logic) Apply(state any, playerIdx int, move json.RawMessage) (any, error) {
	s := state.(*State)
	m, err := parseMove(move)
	if err != nil {
		return s, err
	}
	s.Board[m.Y*Size+m.X] = playerIdx + 1
	s.MoveCount++
	s.LastX = m.X
	s.LastY = m.Y
	if wins(s.Board, m.X, m.Y, playerIdx+1) {
		s.Winner = playerIdx
	} else if s.MoveCount == Size*Size {
		s.Winner = drawWin
	}
	return s, nil
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
