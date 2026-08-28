package xiangqi

import (
	"encoding/json"
	"testing"
	"time"
)

const testBudget = 200 * time.Millisecond

func boardFrom(t *testing.T, rows [BoardHeight]string) []int {
	t.Helper()
	board, err := parseBoardRows(rows)
	if err != nil {
		t.Fatalf("parse board: %v", err)
	}
	return board
}

func TestChooseBestMoveReturnsLegalOpeningMove(t *testing.T) {
	board := append([]int(nil), startBoard...)
	move, ok := chooseBestMove(board, SideRed, timeoutMoveDepth, testBudget)
	if !ok {
		t.Fatal("no move chosen for the opening position")
	}
	if pieceSide(board[move.From]) != SideRed {
		t.Fatalf("chose a move for the wrong side: %+v", move)
	}
	legal := false
	for _, to := range legalMovesFrom(board, move.From) {
		if to == move.To {
			legal = true
		}
	}
	if !legal {
		t.Fatalf("chose an illegal move: %+v", move)
	}
}

func TestChooseBestMoveTakesFreeChariot(t *testing.T) {
	board := boardFrom(t, [BoardHeight]string{
		"...K.....",
		".........",
		".........",
		".R.......",
		".r.......",
		".........",
		".........",
		".........",
		".........",
		".....k...",
	})
	move, ok := chooseBestMove(board, SideRed, timeoutMoveDepth, testBudget)
	if !ok {
		t.Fatal("no move chosen")
	}
	if move.From != boardIdx(1, 3) || move.To != boardIdx(1, 4) {
		t.Fatalf("did not capture the undefended chariot: %+v", move)
	}
}

func TestChooseBestMoveAvoidsHangingTheChariot(t *testing.T) {
	board := boardFrom(t, [BoardHeight]string{
		"...K.....",
		".........",
		".........",
		"R........",
		"........r",
		".........",
		".........",
		".........",
		".........",
		".....k...",
	})
	move, ok := chooseBestMove(board, SideRed, timeoutMoveDepth, testBudget)
	if !ok {
		t.Fatal("no move chosen")
	}
	// (0,4) is the enemy chariot's rank and (8,3) its file; both drop the
	// chariot for nothing.
	if move.To == boardIdx(0, 4) || move.To == boardIdx(8, 3) {
		t.Fatalf("left the chariot hanging for free: %+v", move)
	}
}

func TestChooseBestMoveFindsMateInOne(t *testing.T) {
	board := boardFrom(t, [BoardHeight]string{
		"...K.....",
		".........",
		".........",
		".........",
		".........",
		".........",
		".........",
		"........R",
		"R........",
		"....k....",
	})
	move, ok := chooseBestMove(board, SideRed, timeoutMoveDepth, testBudget)
	if !ok {
		t.Fatal("no move chosen")
	}
	next := afterMove(board, move)
	if hasLegalMove(next, SideBlack) || !inCheck(next, SideBlack) {
		t.Fatalf("missed mate in one, played %+v", move)
	}
}

func TestChooseBestMoveReportsNoMove(t *testing.T) {
	board := boardFrom(t, [BoardHeight]string{
		"....K....",
		".........",
		".........",
		".........",
		".........",
		".........",
		".........",
		".........",
		".........",
		".........",
	})
	if _, ok := chooseBestMove(board, SideBlack, timeoutMoveDepth, testBudget); ok {
		t.Fatal("chose a move for a side with no pieces")
	}
}

func TestMoveOnTimeoutProducesAnApplicableMove(t *testing.T) {
	gameLogic := Logic{}
	state := newGame()

	raw, ok := gameLogic.MoveOnTimeout(state, SideRed)
	if !ok {
		t.Fatal("no timeout move produced for the opening position")
	}
	var move Move
	if err := json.Unmarshal(raw, &move); err != nil {
		t.Fatalf("timeout move is not valid JSON: %v", err)
	}
	if move.From == nil || move.To == nil {
		t.Fatalf("timeout move is missing squares: %s", raw)
	}
	if err := gameLogic.ValidateMove(state, SideRed, raw); err != nil {
		t.Fatalf("timeout move rejected by ValidateMove: %v", err)
	}
	next, err := gameLogic.Apply(state, SideRed, raw)
	if err != nil {
		t.Fatalf("timeout move rejected by Apply: %v", err)
	}
	if next.(*State).MoveCount != 1 {
		t.Fatalf("timeout move did not advance the move count: %d", next.(*State).MoveCount)
	}
}

func TestMoveOnTimeoutRejectsOffTurnAndFinishedStates(t *testing.T) {
	gameLogic := Logic{}

	if _, ok := gameLogic.MoveOnTimeout(newGame(), SideBlack); ok {
		t.Fatal("produced a move for the side that is not on turn")
	}

	finished := newGame()
	finished.Winner = SideRed
	if _, ok := gameLogic.MoveOnTimeout(finished, SideRed); ok {
		t.Fatal("produced a move for a finished match")
	}

	if _, ok := gameLogic.MoveOnTimeout("not a state", SideRed); ok {
		t.Fatal("produced a move for an invalid state")
	}
}
