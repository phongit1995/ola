package progression

import "testing"

func TestExpBaseForLevel(t *testing.T) {
	cases := []struct {
		level int
		base  int64
	}{
		{0, 0},
		{1, 0},
		{2, 100},
		{3, 300},
		{5, 1000},
		{10, 4500},
		{20, 19000},
		{99, 485100},
		{150, 485100},
	}
	for _, c := range cases {
		if got := ExpBaseForLevel(c.level); got != c.base {
			t.Errorf("ExpBaseForLevel(%d) = %d, want %d", c.level, got, c.base)
		}
	}
}

func TestLevelFromExp(t *testing.T) {
	cases := []struct {
		exp   int64
		level int
	}{
		{-10, 1},
		{0, 1},
		{99, 1},
		{100, 2},
		{299, 2},
		{300, 3},
		{4499, 9},
		{4500, 10},
		{485100, 99},
		{10000000, 99},
	}
	for _, c := range cases {
		if got := LevelFromExp(c.exp); got != c.level {
			t.Errorf("LevelFromExp(%d) = %d, want %d", c.exp, got, c.level)
		}
	}
}

func TestLevelRoundTrip(t *testing.T) {
	for level := 1; level < MaxLevel; level++ {
		base := ExpBaseForLevel(level)
		if got := LevelFromExp(base); got != level {
			t.Fatalf("LevelFromExp(base %d) = %d, want %d", base, got, level)
		}
		if got := LevelFromExp(base + ExpToNext(level)); got != level+1 {
			t.Fatalf("LevelFromExp(base+next of %d) = %d, want %d", level, got, level+1)
		}
	}
}

func TestMatchExp(t *testing.T) {
	if got := MatchExp("u1", "win", "u1", 0); got != ExpWin {
		t.Errorf("winner exp = %d, want %d", got, ExpWin)
	}
	if got := MatchExp("u1", "forfeit", "u2", 0); got != ExpLoss {
		t.Errorf("loser exp = %d, want %d", got, ExpLoss)
	}
	if got := MatchExp("", "draw", "u1", 0); got != ExpDraw {
		t.Errorf("draw exp = %d, want %d", got, ExpDraw)
	}
	if got := MatchExp("", "disconnect", "u1", 0); got != ExpDraw {
		t.Errorf("disconnect draw exp = %d, want %d", got, ExpDraw)
	}
	if got := MatchExp("u1", "void", "u1", 100); got != 0 {
		t.Errorf("void exp = %d, want 0", got)
	}
	if got := MatchExp("u1", "win", "u2", 30); got != ExpLoss+15 {
		t.Errorf("loser exp with 30 moves = %d, want %d", got, ExpLoss+15)
	}
	if got := MatchExp("u1", "win", "u1", 200); got != ExpWin+ExpMoveCap/2 {
		t.Errorf("winner exp with capped moves = %d, want %d", got, ExpWin+ExpMoveCap/2)
	}
}

func TestMoveBonus(t *testing.T) {
	cases := []struct{ moves, bonus int }{
		{-5, 0}, {0, 0}, {1, 0}, {2, 1}, {9, 4}, {40, 20}, {41, 20}, {1000, 20},
	}
	for _, c := range cases {
		if got := MoveBonus(c.moves); got != c.bonus {
			t.Errorf("MoveBonus(%d) = %d, want %d", c.moves, got, c.bonus)
		}
	}
}
