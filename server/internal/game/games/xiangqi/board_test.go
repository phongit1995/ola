package xiangqi

import (
	"strings"
	"testing"
)

func TestIndexRoundTrip(t *testing.T) {
	for idx := 0; idx < BoardCells; idx++ {
		x, y := boardX(idx), boardY(idx)
		if !onBoard(x, y) || boardIdx(x, y) != idx {
			t.Fatalf("index round trip failed at %d", idx)
		}
	}
	if onBoard(-1, 0) || onBoard(9, 0) || onBoard(0, -1) || onBoard(0, 10) {
		t.Fatal("onBoard accepted out-of-range coordinates")
	}
}

func TestPalaceAndRiver(t *testing.T) {
	if !inPalace(4, 1, SideRed) || !inPalace(3, 0, SideRed) || !inPalace(5, 2, SideRed) {
		t.Fatal("red palace rejected valid squares")
	}
	if inPalace(2, 1, SideRed) || inPalace(4, 3, SideRed) || inPalace(4, 8, SideRed) {
		t.Fatal("red palace accepted invalid squares")
	}
	if !inPalace(4, 8, SideBlack) || inPalace(4, 1, SideBlack) {
		t.Fatal("black palace bounds wrong")
	}
	if crossedRiver(4, SideRed) || !crossedRiver(5, SideRed) {
		t.Fatal("red river boundary wrong")
	}
	if crossedRiver(5, SideBlack) || !crossedRiver(4, SideBlack) {
		t.Fatal("black river boundary wrong")
	}
}

func TestPieceSpots(t *testing.T) {
	redAdvisor := [][2]int{{3, 0}, {5, 0}, {4, 1}, {3, 2}, {5, 2}}
	count := 0
	for x := 0; x < BoardWidth; x++ {
		for y := 0; y < BoardHeight; y++ {
			if validAdvisorSpot(x, y, SideRed) {
				count++
				found := false
				for _, s := range redAdvisor {
					if s[0] == x && s[1] == y {
						found = true
					}
				}
				if !found {
					t.Fatalf("unexpected red advisor spot %d,%d", x, y)
				}
			}
		}
	}
	if count != 5 {
		t.Fatalf("expected 5 red advisor spots, got %d", count)
	}

	redElephant := [][2]int{{2, 0}, {6, 0}, {0, 2}, {4, 2}, {8, 2}, {2, 4}, {6, 4}}
	count = 0
	for x := 0; x < BoardWidth; x++ {
		for y := 0; y < BoardHeight; y++ {
			if validElephantSpot(x, y, SideRed) {
				count++
				found := false
				for _, s := range redElephant {
					if s[0] == x && s[1] == y {
						found = true
					}
				}
				if !found {
					t.Fatalf("unexpected red elephant spot %d,%d", x, y)
				}
			}
		}
	}
	if count != 7 {
		t.Fatalf("expected 7 red elephant spots, got %d", count)
	}

	if !validSoldierSpot(0, 3, SideRed) || validSoldierSpot(1, 3, SideRed) || !validSoldierSpot(1, 5, SideRed) || validSoldierSpot(0, 2, SideRed) {
		t.Fatal("red soldier spots wrong")
	}
	if !validSoldierSpot(2, 6, SideBlack) || validSoldierSpot(1, 6, SideBlack) || !validSoldierSpot(1, 4, SideBlack) {
		t.Fatal("black soldier spots wrong")
	}
}

func TestParseFormatRoundTrip(t *testing.T) {
	rows := formatBoard(startBoard)
	if rows != startRows {
		t.Fatalf("format mismatch: %v", rows)
	}
	board, err := parseBoardRows(rows)
	if err != nil {
		t.Fatal(err)
	}
	for i := range board {
		if board[i] != startBoard[i] {
			t.Fatalf("parse mismatch at %d", i)
		}
	}
	if _, err := parseBoardRows([BoardHeight]string{}); err == nil {
		t.Fatal("expected error for short rows")
	}
}

func TestPositionKey(t *testing.T) {
	key := positionKey(startBoard, SideRed)
	if len(key) != BoardCells+1 || !strings.HasSuffix(key, "r") {
		t.Fatalf("bad red key %q", key)
	}
	blackKey := positionKey(startBoard, SideBlack)
	if !strings.HasSuffix(blackKey, "b") || key[:BoardCells] != blackKey[:BoardCells] {
		t.Fatal("side suffix must be the only difference")
	}
}

func TestStartBoardInventory(t *testing.T) {
	counts := make([]int, MaxPiece+1)
	for _, p := range startBoard {
		counts[p]++
	}
	for side := 0; side < 2; side++ {
		if counts[pieceFor(side, KindGeneral)] != 1 {
			t.Fatal("start board must have one general per side")
		}
		for _, kind := range []int{KindAdvisor, KindElephant, KindHorse, KindChariot, KindCannon} {
			if counts[pieceFor(side, kind)] != 2 {
				t.Fatalf("start board kind %d side %d count wrong", kind, side)
			}
		}
		if counts[pieceFor(side, KindSoldier)] != 5 {
			t.Fatal("start board must have five soldiers per side")
		}
	}
	if counts[Empty] != BoardCells-32 {
		t.Fatal("start board piece total wrong")
	}
}
