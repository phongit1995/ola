package xiangqi

import (
	"errors"
	"strings"
)

const (
	GameID      = "xiangqi"
	TurnSeconds = 60

	BoardWidth  = 9
	BoardHeight = 10
	BoardCells  = BoardWidth * BoardHeight

	HalfmoveDrawPlies = 120
	RepetitionLimit   = 3

	SideRed   = 0
	SideBlack = 1

	Empty = 0

	KindGeneral  = 1
	KindAdvisor  = 2
	KindElephant = 3
	KindHorse    = 4
	KindChariot  = 5
	KindCannon   = 6
	KindSoldier  = 7

	MaxPiece = 14
)

const BoardAlphabet = ".KAEHRCPkaehrcp"

var startRows = [BoardHeight]string{
	"RHEAKAEHR",
	".........",
	".C.....C.",
	"P.P.P.P.P",
	".........",
	".........",
	"p.p.p.p.p",
	".c.....c.",
	".........",
	"rheakaehr",
}

var startBoard = mustParseBoard(startRows)

func pieceSide(p int) int { return (p - 1) / 7 }

func pieceKind(p int) int { return (p-1)%7 + 1 }

func pieceFor(side, kind int) int { return side*7 + kind }

func boardX(idx int) int { return idx % BoardWidth }

func boardY(idx int) int { return idx / BoardWidth }

func boardIdx(x, y int) int { return y*BoardWidth + x }

func onBoard(x, y int) bool {
	return x >= 0 && x < BoardWidth && y >= 0 && y < BoardHeight
}

func inPalace(x, y, side int) bool {
	if x < 3 || x > 5 {
		return false
	}
	if side == SideRed {
		return y >= 0 && y <= 2
	}
	return y >= 7 && y <= 9
}

func crossedRiver(y, side int) bool {
	if side == SideRed {
		return y >= 5
	}
	return y <= 4
}

func forwardDir(side int) int {
	if side == SideRed {
		return 1
	}
	return -1
}

func validAdvisorSpot(x, y, side int) bool {
	if !inPalace(x, y, side) {
		return false
	}
	if side == SideRed {
		return (x+y)%2 == 1
	}
	return (x+y)%2 == 0
}

func validElephantSpot(x, y, side int) bool {
	ey := y
	if side == SideBlack {
		ey = BoardHeight - 1 - y
	}
	switch ey {
	case 0, 4:
		return x == 2 || x == 6
	case 2:
		return x%4 == 0
	}
	return false
}

func validSoldierSpot(x, y, side int) bool {
	ey := y
	if side == SideBlack {
		ey = BoardHeight - 1 - y
	}
	if ey < 3 {
		return false
	}
	if ey <= 4 {
		return x%2 == 0
	}
	return true
}

func parseBoardRows(rows [BoardHeight]string) ([]int, error) {
	board := make([]int, BoardCells)
	for y, row := range rows {
		if len(row) != BoardWidth {
			return nil, errors.New("invalid board row length")
		}
		for x := 0; x < BoardWidth; x++ {
			code := strings.IndexByte(BoardAlphabet, row[x])
			if code < 0 {
				return nil, errors.New("invalid board character")
			}
			board[boardIdx(x, y)] = code
		}
	}
	return board, nil
}

func mustParseBoard(rows [BoardHeight]string) []int {
	board, err := parseBoardRows(rows)
	if err != nil {
		panic(err)
	}
	return board
}

func formatBoard(board []int) [BoardHeight]string {
	var rows [BoardHeight]string
	for y := 0; y < BoardHeight; y++ {
		var b strings.Builder
		for x := 0; x < BoardWidth; x++ {
			b.WriteByte(BoardAlphabet[board[boardIdx(x, y)]])
		}
		rows[y] = b.String()
	}
	return rows
}

func positionKey(board []int, side int) string {
	var b strings.Builder
	b.Grow(BoardCells + 1)
	for _, p := range board {
		b.WriteByte(BoardAlphabet[p])
	}
	if side == SideRed {
		b.WriteByte('r')
	} else {
		b.WriteByte('b')
	}
	return b.String()
}
