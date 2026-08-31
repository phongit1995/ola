package xiangqi

import (
	"encoding/json"
	"fmt"
	"testing"
)

func mv(from, to int) json.RawMessage {
	return json.RawMessage(fmt.Sprintf(`{"from":%d,"to":%d}`, from, to))
}

func testState(overrides map[int]string, moveCount int) *State {
	board := fixtureBoard(overrides)
	side := moveCount % 2
	return &State{
		Board:         board,
		MoveCount:     moveCount,
		HalfmoveClock: 0,
		History:       []string{positionKey(board, side)},
		HistoryChecks: []bool{inCheck(board, side)},
		LastFrom:      -1,
		LastTo:        -1,
		Check:         inCheck(board, side),
		Winner:        noneWin,
	}
}

func TestInitState(t *testing.T) {
	s := Logic{}.Init(1).(*State)
	for i := range s.Board {
		if s.Board[i] != startBoard[i] {
			t.Fatal("init board must equal start board")
		}
	}
	if s.MoveCount != 0 || s.HalfmoveClock != 0 || s.LastFrom != -1 || s.LastTo != -1 || s.Check {
		t.Fatal("init scalar fields wrong")
	}
	if len(s.History) != 1 || s.History[0] != positionKey(startBoard, SideRed) || len(s.HistoryChecks) != 1 || s.HistoryChecks[0] {
		t.Fatal("init history wrong")
	}
	if over, _ := (Logic{}).Result(s); over {
		t.Fatal("init state must not be over")
	}
}

func TestValidateMoveErrors(t *testing.T) {
	s := newGame()
	cases := []struct {
		name      string
		playerIdx int
		move      json.RawMessage
	}{
		{"missing fields", 0, json.RawMessage(`{}`)},
		{"malformed payload", 0, json.RawMessage(`"x"`)},
		{"out of board", 0, mv(-1, 5)},
		{"same square", 0, mv(10, 10)},
		{"empty source", 0, mv(sq(4, 4), sq(4, 5))},
		{"opponent piece", 0, mv(sq(0, 9), sq(0, 8))},
		{"not your turn", 1, mv(sq(0, 9), sq(0, 8))},
		{"capture own piece", 0, mv(sq(0, 0), sq(0, 3))},
		{"blocked chariot", 0, mv(sq(0, 0), sq(0, 4))},
		{"illegal pattern", 0, mv(sq(4, 0), sq(4, 2))},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			if err := (Logic{}).ValidateMove(s, tc.playerIdx, tc.move); err == nil {
				t.Fatal("expected error")
			}
		})
	}
	if err := (Logic{}).ValidateMove(s, 0, mv(sq(1, 2), sq(4, 2))); err != nil {
		t.Fatalf("central cannon opening must be legal: %v", err)
	}
}

func TestApplyMoveAndCaptureClocks(t *testing.T) {
	game := Logic{}
	state := any(newGame())
	steps := [][2]int{
		{sq(0, 3), sq(0, 4)},
		{sq(0, 6), sq(0, 5)},
		{sq(0, 4), sq(0, 5)},
	}
	for i, m := range steps {
		next, err := game.Apply(state, i%2, mv(m[0], m[1]))
		if err != nil {
			t.Fatalf("ply %d: %v", i, err)
		}
		state = next
	}
	s := state.(*State)
	if s.MoveCount != 3 || s.HalfmoveClock != 0 {
		t.Fatalf("capture must reset halfmove clock, got %d/%d", s.MoveCount, s.HalfmoveClock)
	}
	if len(s.History) != 1 || len(s.HistoryChecks) != 1 {
		t.Fatalf("capture must reset history, got %d", len(s.History))
	}
	if s.Board[sq(0, 5)] != pieceFor(SideRed, KindSoldier) || s.Board[sq(0, 4)] != Empty {
		t.Fatal("capture board result wrong")
	}
	if len(s.Steps) != 1 || s.Steps[0].Kind != StepCapture || s.Steps[0].Captured != pieceFor(SideBlack, KindSoldier) {
		t.Fatalf("capture step wrong: %+v", s.Steps)
	}
	if s.LastFrom != sq(0, 4) || s.LastTo != sq(0, 5) {
		t.Fatal("last move wrong")
	}
}

func TestApplyCopyOnWrite(t *testing.T) {
	s := newGame()
	before := append([]int(nil), s.Board...)
	historyLen := len(s.History)
	next, err := Logic{}.Apply(s, 0, mv(sq(1, 2), sq(4, 2)))
	if err != nil {
		t.Fatal(err)
	}
	if next == any(s) {
		t.Fatal("apply must return a new state")
	}
	for i := range s.Board {
		if s.Board[i] != before[i] {
			t.Fatal("apply mutated the input board")
		}
	}
	if len(s.History) != historyLen || s.MoveCount != 0 || len(s.Steps) != 0 {
		t.Fatal("apply mutated input state")
	}
}

func TestCheckStepEmitted(t *testing.T) {
	s := testState(map[int]string{0: "....K....", 5: "...r.....", 9: "...k....."}, 1)
	next, err := Logic{}.Apply(s, 1, mv(sq(3, 5), sq(4, 5)))
	if err != nil {
		t.Fatal(err)
	}
	ns := next.(*State)
	if !ns.Check {
		t.Fatal("check flag must be set")
	}
	foundCheck := false
	for _, step := range ns.Steps {
		if step.Kind == StepCheck {
			foundCheck = true
		}
	}
	if !foundCheck {
		t.Fatalf("expected check step, got %+v", ns.Steps)
	}
	if over, _ := (Logic{}).Result(ns); over {
		t.Fatal("escapable check must not end the match")
	}
}

func TestDiscoveredCannonCheckFromOpening(t *testing.T) {
	game := Logic{}
	state := any(newGame())
	moves := [][2]int{
		{sq(1, 2), sq(4, 2)}, // centralize the red cannon
		{sq(0, 6), sq(0, 5)},
		{sq(4, 3), sq(4, 4)},
		{sq(2, 6), sq(2, 5)},
		{sq(4, 4), sq(4, 5)},
		{sq(6, 6), sq(6, 5)},
		{sq(4, 5), sq(4, 6)}, // capture leaves exactly one cannon screen
	}
	for ply, move := range moves {
		next, err := game.Apply(state, ply%2, mv(move[0], move[1]))
		if err != nil {
			t.Fatalf("ply %d: %v", ply, err)
		}
		state = next
	}
	s := state.(*State)
	if !s.Check || !inCheck(s.Board, SideBlack) {
		t.Fatal("opening sequence must leave black in cannon check")
	}
	if over, _ := game.Result(s); over {
		t.Fatal("the discovered check is escapable and must not end the game")
	}
	found := false
	for _, step := range s.Steps {
		found = found || step.Kind == StepCheck
	}
	if !found {
		t.Fatalf("opening check did not emit a check step: %+v", s.Steps)
	}
}

func TestCheckingMovesForBothSides(t *testing.T) {
	cases := []struct {
		name      string
		overrides map[int]string
		moveCount int
		from      int
		to        int
		checked   int
	}{
		{
			name:      "red chariot checks black",
			overrides: map[int]string{0: "...K.....", 4: "...R.....", 9: "....k...."},
			moveCount: 0,
			from:      sq(3, 4),
			to:        sq(4, 4),
			checked:   SideBlack,
		},
		{
			name:      "black chariot checks red",
			overrides: map[int]string{0: "....K....", 5: "...r.....", 9: "...k....."},
			moveCount: 1,
			from:      sq(3, 5),
			to:        sq(4, 5),
			checked:   SideRed,
		},
		{
			name:      "red cannon checks over one screen",
			overrides: map[int]string{0: "...K.....", 4: "...C.....", 7: "....p....", 9: "....k...."},
			moveCount: 0,
			from:      sq(3, 4),
			to:        sq(4, 4),
			checked:   SideBlack,
		},
		{
			name:      "red horse checks black",
			overrides: map[int]string{0: "...K.....", 6: "...H.....", 9: "....k...."},
			moveCount: 0,
			from:      sq(3, 6),
			to:        sq(5, 7),
			checked:   SideBlack,
		},
		{
			name:      "red soldier checks black",
			overrides: map[int]string{0: "...K.....", 7: "....P....", 9: "....k...."},
			moveCount: 0,
			from:      sq(4, 7),
			to:        sq(4, 8),
			checked:   SideBlack,
		},
	}

	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			next, err := (Logic{}).Apply(testState(tc.overrides, tc.moveCount), tc.moveCount%2, mv(tc.from, tc.to))
			if err != nil {
				t.Fatal(err)
			}
			ns := next.(*State)
			if !ns.Check || !inCheck(ns.Board, tc.checked) {
				t.Fatal("checking move did not leave the opponent in check")
			}
			found := false
			for _, step := range ns.Steps {
				found = found || step.Kind == StepCheck
			}
			if !found {
				t.Fatalf("checking move did not emit check step: %+v", ns.Steps)
			}
		})
	}
}

func TestGeneralCaptureTerminatesDefensively(t *testing.T) {
	s := testState(map[int]string{0: "...K.....", 8: "....R....", 9: "....k...."}, SideRed)
	next, err := (Logic{}).Apply(s, SideRed, mv(sq(4, 8), sq(4, 9)))
	if err != nil {
		t.Fatal(err)
	}
	ns := next.(*State)
	over, winner := (Logic{}).Result(ns)
	if !over || winner != SideRed {
		t.Fatalf("general capture must end the game, got over=%v winner=%d", over, winner)
	}
	last := ns.Steps[len(ns.Steps)-1]
	if last.Kind != StepMate || last.Reason != ReasonCheckmate {
		t.Fatalf("general capture must end as checkmate, got %+v", last)
	}
}

func TestCheckmateWins(t *testing.T) {
	s := testState(map[int]string{0: "....K....", 1: ".r.......", 2: "..h......"}, 1)
	next, err := Logic{}.Apply(s, 1, mv(sq(1, 1), sq(4, 1)))
	if err != nil {
		t.Fatal(err)
	}
	ns := next.(*State)
	over, winner := Logic{}.Result(ns)
	if !over || winner != 1 {
		t.Fatalf("expected black checkmate win, got %v %d", over, winner)
	}
	last := ns.Steps[len(ns.Steps)-1]
	if last.Kind != StepMate || last.Reason != ReasonCheckmate {
		t.Fatalf("expected checkmate step, got %+v", last)
	}
}

func TestStalemateWins(t *testing.T) {
	s := testState(map[int]string{0: "...K.....", 2: "..p......", 9: "....k...."}, 1)
	next, err := Logic{}.Apply(s, 1, mv(sq(2, 2), sq(3, 2)))
	if err != nil {
		t.Fatal(err)
	}
	ns := next.(*State)
	over, winner := Logic{}.Result(ns)
	if !over || winner != 1 {
		t.Fatalf("expected stalemate win for black, got %v %d", over, winner)
	}
	last := ns.Steps[len(ns.Steps)-1]
	if last.Kind != StepMate || last.Reason != ReasonStalemate {
		t.Fatalf("expected stalemate step, got %+v", last)
	}
}

func TestRepetitionDraw(t *testing.T) {
	game := Logic{}
	state := any(testState(map[int]string{0: "...K....R", 9: ".....k..r"}, 0))
	shuffle := [][2]int{
		{sq(8, 0), sq(8, 1)}, {sq(8, 9), sq(8, 8)},
		{sq(8, 1), sq(8, 0)}, {sq(8, 8), sq(8, 9)},
	}
	ply := 0
	for round := 0; round < 2; round++ {
		for _, m := range shuffle {
			next, err := game.Apply(state, ply%2, mv(m[0], m[1]))
			if err != nil {
				t.Fatalf("ply %d: %v", ply, err)
			}
			state = next
			ply++
		}
	}
	s := state.(*State)
	over, winner := game.Result(s)
	if !over || winner != -1 {
		t.Fatalf("expected repetition draw, got %v %d", over, winner)
	}
	last := s.Steps[len(s.Steps)-1]
	if last.Kind != StepDraw || last.Reason != ReasonRepetition {
		t.Fatalf("expected repetition draw step, got %+v", last)
	}
}

func TestPerpetualCheckLoses(t *testing.T) {
	game := Logic{}
	state := any(testState(map[int]string{5: "...R.....", 9: "....k...."}, 0))
	moves := [][2]int{
		{sq(3, 5), sq(4, 5)},
		{sq(4, 9), sq(5, 9)},
		{sq(4, 5), sq(5, 5)},
		{sq(5, 9), sq(4, 9)},
		{sq(5, 5), sq(4, 5)},
		{sq(4, 9), sq(5, 9)},
		{sq(4, 5), sq(5, 5)},
		{sq(5, 9), sq(4, 9)},
		{sq(5, 5), sq(4, 5)},
	}
	for i, m := range moves {
		next, err := game.Apply(state, i%2, mv(m[0], m[1]))
		if err != nil {
			t.Fatalf("ply %d: %v", i, err)
		}
		state = next
	}
	s := state.(*State)
	over, winner := game.Result(s)
	if !over || winner != 1 {
		t.Fatalf("perpetual checker must lose, got %v %d", over, winner)
	}
	last := s.Steps[len(s.Steps)-1]
	if last.Kind != StepMate || last.Reason != ReasonPerpetual {
		t.Fatalf("expected perpetual step, got %+v", last)
	}
}

func TestMutualPerpetualIsDraw(t *testing.T) {
	history := []string{"a", "b", "c", "d", "a"}
	checks := []bool{false, true, true, true, true}
	if _, ok := perpetualChecker(history, checks, "a", 4); ok {
		t.Fatal("both sides checking must not be adjudicated as perpetual")
	}
	onesided := []bool{false, true, false, true, false}
	loser, ok := perpetualChecker(history, onesided, "a", 4)
	if !ok {
		t.Fatal("one-sided perpetual must be adjudicated")
	}
	moverOfPly1 := 1 - ((4 - 3) % 2)
	if loser != moverOfPly1 {
		t.Fatalf("wrong perpetual loser %d", loser)
	}
}

func TestHalfmoveDraw(t *testing.T) {
	s := testState(map[int]string{0: "...K....R", 9: ".....k..r"}, HalfmoveDrawPlies-1)
	s.HalfmoveClock = HalfmoveDrawPlies - 1
	next, err := Logic{}.Apply(s, (HalfmoveDrawPlies-1)%2, mv(sq(8, 9), sq(8, 8)))
	if err != nil {
		t.Fatal(err)
	}
	ns := next.(*State)
	over, winner := Logic{}.Result(ns)
	if !over || winner != -1 {
		t.Fatalf("expected halfmove draw, got %v %d", over, winner)
	}
	last := ns.Steps[len(ns.Steps)-1]
	if last.Kind != StepDraw || last.Reason != ReasonHalfmove {
		t.Fatalf("expected halfmove draw step, got %+v", last)
	}
}

func TestDecodeStateRoundTrip(t *testing.T) {
	game := Logic{}
	state := any(newGame())
	for i, m := range [][2]int{{sq(1, 2), sq(4, 2)}, {sq(1, 7), sq(4, 7)}} {
		next, err := game.Apply(state, i%2, mv(m[0], m[1]))
		if err != nil {
			t.Fatal(err)
		}
		state = next
	}
	s := state.(*State)
	raw, err := json.Marshal(s)
	if err != nil {
		t.Fatal(err)
	}
	decodedAny, err := game.DecodeState(raw)
	if err != nil {
		t.Fatal(err)
	}
	decoded := decodedAny.(*State)
	if decoded.MoveCount != s.MoveCount || decoded.HalfmoveClock != s.HalfmoveClock || decoded.LastFrom != s.LastFrom || decoded.LastTo != s.LastTo || decoded.Check != s.Check {
		t.Fatal("round trip scalar mismatch")
	}
	if len(decoded.Steps) != 0 || decoded.Winner != noneWin {
		t.Fatal("decode must strip steps and winner")
	}
	for i := range s.Board {
		if decoded.Board[i] != s.Board[i] {
			t.Fatal("round trip board mismatch")
		}
	}
}

func TestDecodeStateRejections(t *testing.T) {
	base := func() *State {
		state := any(newGame())
		for i, m := range [][2]int{{sq(1, 2), sq(4, 2)}, {sq(1, 7), sq(4, 7)}} {
			next, err := Logic{}.Apply(state, i%2, mv(m[0], m[1]))
			if err != nil {
				t.Fatal(err)
			}
			state = next
		}
		return state.(*State)
	}
	cases := []struct {
		name   string
		mutate func(*State)
	}{
		{"short board", func(s *State) { s.Board = s.Board[:BoardCells-1] }},
		{"bad cell", func(s *State) { s.Board[sq(4, 4)] = MaxPiece + 1 }},
		{"missing general", func(s *State) { s.Board[findGeneral(s.Board, SideBlack)] = Empty }},
		{"general outside palace", func(s *State) {
			g := findGeneral(s.Board, SideRed)
			s.Board[g] = Empty
			s.Board[sq(0, 4)] = pieceFor(SideRed, KindGeneral)
		}},
		{"advisor off spot", func(s *State) {
			s.Board[sq(4, 4)] = pieceFor(SideRed, KindAdvisor)
			s.Board[sq(3, 0)] = Empty
		}},
		{"too many soldiers", func(s *State) { s.Board[sq(2, 4)] = pieceFor(SideRed, KindSoldier) }},
		{"negative clock", func(s *State) { s.HalfmoveClock = -1 }},
		{"clock above moves", func(s *State) { s.HalfmoveClock = s.MoveCount + 1 }},
		{"history length mismatch", func(s *State) { s.History = s.History[:1] }},
		{"history checks mismatch", func(s *State) { s.HistoryChecks = append(s.HistoryChecks, true) }},
		{"history head mismatch", func(s *State) { s.History[len(s.History)-1] = positionKey(startBoard, SideRed) }},
		{"check flag wrong", func(s *State) { s.Check = !s.Check }},
		{"last move empty target", func(s *State) { s.LastTo = sq(4, 4) }},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			s := base()
			tc.mutate(s)
			raw, err := json.Marshal(s)
			if err != nil {
				t.Fatal(err)
			}
			if _, err := (Logic{}).DecodeState(raw); err == nil {
				t.Fatal("expected decode rejection")
			}
		})
	}
	if _, err := (Logic{}).DecodeState(json.RawMessage(`{`)); err == nil {
		t.Fatal("expected error for malformed json")
	}
}

func TestDecodeStateRejectsTerminal(t *testing.T) {
	board := fixtureBoard(map[int]string{0: "....K....", 1: "....r....", 2: "..h......"})
	s := &State{
		Board:         board,
		MoveCount:     2,
		HalfmoveClock: 0,
		History:       []string{positionKey(board, SideRed)},
		HistoryChecks: []bool{true},
		LastFrom:      sq(1, 1),
		LastTo:        sq(4, 1),
		Check:         true,
		Winner:        noneWin,
	}
	raw, err := json.Marshal(s)
	if err != nil {
		t.Fatal(err)
	}
	if _, err := (Logic{}).DecodeState(raw); err == nil {
		t.Fatal("terminal state must be rejected")
	}
}

func TestTurnSecondsAndMoveCount(t *testing.T) {
	if (Logic{}).TurnSeconds() != TurnSeconds {
		t.Fatal("turn seconds wrong")
	}
	s := newGame()
	if (Logic{}).MoveCount(s) != 0 {
		t.Fatal("move count wrong")
	}
}
