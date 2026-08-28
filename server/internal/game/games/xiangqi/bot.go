package xiangqi

import (
	"sort"
	"time"
)

const (
	mateScore = 1_000_000
	infScore  = 1 << 30

	timeoutMoveDepth  = 3
	timeoutMoveBudget = 300 * time.Millisecond
)

var pieceValue = func() [MaxPiece + 1]int {
	byKind := [KindSoldier + 1]int{
		KindGeneral:  100_000,
		KindAdvisor:  210,
		KindElephant: 210,
		KindHorse:    420,
		KindChariot:  900,
		KindCannon:   450,
		KindSoldier:  100,
	}
	var table [MaxPiece + 1]int
	for piece := 1; piece <= MaxPiece; piece++ {
		table[piece] = byKind[pieceKind(piece)]
	}
	return table
}()

type botMove struct {
	From int
	To   int
}

func legalMovesForSide(board []int, side int) []botMove {
	var moves []botMove
	for from := 0; from < len(board); from++ {
		piece := board[from]
		if piece == Empty || pieceSide(piece) != side {
			continue
		}
		for _, to := range legalMovesFrom(board, from) {
			moves = append(moves, botMove{From: from, To: to})
		}
	}
	return moves
}

func afterMove(board []int, move botMove) []int {
	next := make([]int, len(board))
	copy(next, board)
	next[move.To] = next[move.From]
	next[move.From] = Empty
	return next
}

func centerBonus(x int) int {
	d := 4 - x
	if d < 0 {
		d = -d
	}
	return 4 - d
}

func pieceSquareBonus(piece, square int) int {
	side := pieceSide(piece)
	x, y := boardX(square), boardY(square)
	switch pieceKind(piece) {
	case KindSoldier:
		advance := y
		if side != SideRed {
			advance = BoardHeight - 1 - y
		}
		score := advance * 8
		if crossedRiver(y, side) {
			score += 36 + centerBonus(x)*4
		}
		return score
	case KindHorse, KindCannon:
		return centerBonus(x) * 4
	case KindChariot:
		return centerBonus(x) * 2
	}
	return 0
}

func evaluate(board []int, perspective int) int {
	score := 0
	for square, piece := range board {
		if piece == Empty {
			continue
		}
		value := pieceValue[piece] + pieceSquareBonus(piece, square)
		if pieceSide(piece) == perspective {
			score += value
		} else {
			score -= value
		}
	}
	if inCheck(board, 1-perspective) {
		score += 28
	}
	if inCheck(board, perspective) {
		score -= 28
	}
	return score
}

func movePriority(board []int, move botMove) int {
	captured := board[move.To]
	mover := board[move.From]
	score := 0
	if captured != Empty {
		score = pieceValue[captured]*10 - pieceValue[mover]
	}
	if inCheck(afterMove(board, move), 1-pieceSide(mover)) {
		score += 180
	}
	return score
}

type ratedMove struct {
	Move     botMove
	Priority int
}

func orderedMoves(board []int, side int) []ratedMove {
	moves := legalMovesForSide(board, side)
	rated := make([]ratedMove, len(moves))
	for i, move := range moves {
		rated[i] = ratedMove{Move: move, Priority: movePriority(board, move)}
	}
	sort.SliceStable(rated, func(i, j int) bool {
		return rated[i].Priority > rated[j].Priority
	})
	return rated
}

type searchContext struct {
	perspective int
	deadline    time.Time
	nodes       int
}

func (c *searchContext) outOfTime() bool {
	return !time.Now().Before(c.deadline)
}

func search(board []int, side, depth, alpha, beta, ply int, context *searchContext) int {
	context.nodes++
	if context.nodes&127 == 0 && context.outOfTime() {
		return evaluate(board, context.perspective)
	}
	if !hasLegalMove(board, side) {
		if side == context.perspective {
			return -mateScore + ply
		}
		return mateScore - ply
	}
	if depth == 0 {
		return evaluate(board, context.perspective)
	}

	maximizing := side == context.perspective
	best := infScore
	if maximizing {
		best = -infScore
	}
	for _, rated := range orderedMoves(board, side) {
		score := search(afterMove(board, rated.Move), 1-side, depth-1, alpha, beta, ply+1, context)
		if maximizing {
			if score > best {
				best = score
			}
			if best > alpha {
				alpha = best
			}
		} else {
			if score < best {
				best = score
			}
			if best < beta {
				beta = best
			}
		}
		if beta <= alpha || context.outOfTime() {
			break
		}
	}
	return best
}

// chooseBestMove mirrors the "hard" difficulty of the client bot in
// game/xiangqi/logic/bot.ts, minus the randomness the client uses to vary
// easy and medium play.
func chooseBestMove(board []int, side int, depth int, budget time.Duration) (botMove, bool) {
	moves := orderedMoves(board, side)
	if len(moves) == 0 {
		return botMove{}, false
	}
	context := &searchContext{perspective: side, deadline: time.Now().Add(budget)}
	scores := make([]int, len(moves))
	for i, rated := range moves {
		scores[i] = search(afterMove(board, rated.Move), 1-side, depth-1, -infScore, infScore, 1, context)
	}
	bestIdx := 0
	for i := 1; i < len(moves); i++ {
		if scores[i] > scores[bestIdx] ||
			(scores[i] == scores[bestIdx] && moves[i].Priority > moves[bestIdx].Priority) {
			bestIdx = i
		}
	}
	return moves[bestIdx].Move, true
}
