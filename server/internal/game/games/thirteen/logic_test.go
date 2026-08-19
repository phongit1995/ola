package thirteen

import (
	"encoding/json"
	"math/rand"
	"testing"
)

func card(rank, suit int) int { return rank*4 + suit }

func TestClassify(t *testing.T) {
	tests := []struct {
		name   string
		cards  []int
		kind   ComboKind
		length int
		valid  bool
	}{
		{"single", []int{card(5, 2)}, ComboSingle, 1, true},
		{"pair", []int{card(7, 0), card(7, 3)}, ComboPair, 2, true},
		{"triple", []int{card(2, 0), card(2, 1), card(2, 2)}, ComboTriple, 3, true},
		{"quad", []int{card(9, 0), card(9, 1), card(9, 2), card(9, 3)}, ComboQuad, 4, true},
		{"straight3", []int{card(0, 0), card(1, 2), card(2, 3)}, ComboStraight, 3, true},
		{"straight to ace", []int{card(8, 0), card(9, 1), card(10, 1), card(11, 3)}, ComboStraight, 4, true},
		{"straight with two invalid", []int{card(10, 0), card(11, 1), card(12, 1)}, ComboInvalidKind, 0, false},
		{"double run 3", []int{card(3, 0), card(3, 1), card(4, 0), card(4, 2), card(5, 1), card(5, 3)}, ComboDoubleRun, 3, true},
		{"double run with two invalid", []int{card(10, 0), card(10, 1), card(11, 0), card(11, 2), card(12, 1), card(12, 3)}, ComboInvalidKind, 0, false},
		{"mixed junk", []int{card(1, 0), card(5, 1)}, ComboInvalidKind, 0, false},
		{"duplicate card", []int{card(5, 1), card(5, 1)}, ComboInvalidKind, 0, false},
		{"empty", nil, ComboInvalidKind, 0, false},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			combo, err := classify(test.cards)
			if test.valid && err != nil {
				t.Fatalf("expected valid combo, got error: %v", err)
			}
			if !test.valid {
				if err == nil {
					t.Fatalf("expected invalid combo, got %+v", combo)
				}
				return
			}
			if combo.Kind != test.kind || combo.Length != test.length {
				t.Fatalf("combo = %+v, want kind %s length %d", combo, test.kind, test.length)
			}
		})
	}
}

const ComboInvalidKind = ComboKind("")

func TestBeats(t *testing.T) {
	single := func(rank, suit int) Combo { return Combo{Kind: ComboSingle, Length: 1, Key: card(rank, suit)} }
	pair := func(rank, suit int) Combo { return Combo{Kind: ComboPair, Length: 2, Key: card(rank, suit)} }
	quad := func(rank int) Combo { return Combo{Kind: ComboQuad, Length: 4, Key: card(rank, 3)} }
	run := func(length, topRank int) Combo {
		return Combo{Kind: ComboDoubleRun, Length: length, Key: card(topRank, 3)}
	}

	tests := []struct {
		name       string
		next, prev Combo
		want       bool
	}{
		{"higher single", single(5, 3), single(5, 2), true},
		{"lower single", single(5, 0), single(5, 2), false},
		{"suit breaks rank tie", single(8, 1), single(8, 0), true},
		{"pair beats pair", pair(10, 3), pair(10, 2), true},
		{"pair cannot beat single", pair(10, 3), single(3, 0), false},
		{"quad chops single two", quad(5), single(12, 0), true},
		{"run3 chops single two", run(3, 5), single(12, 3), true},
		{"run3 cannot chop pair of twos", run(3, 5), pair(12, 3), false},
		{"quad chops pair of twos", quad(5), pair(12, 3), true},
		{"run4 chops pair of twos", run(4, 6), pair(12, 3), true},
		{"run4 chops quad", run(4, 6), quad(11), true},
		{"quad cannot chop run4", quad(11), run(4, 6), false},
		{"quad chops run3", quad(3), run(3, 8), true},
		{"run4 chops run3", run(4, 6), run(3, 8), true},
		{"higher quad beats quad", quad(7), quad(5), true},
		{"nothing chops single non-two", quad(5), single(11, 3), false},
		{"straight only same length", Combo{Kind: ComboStraight, Length: 4, Key: card(9, 3)}, Combo{Kind: ComboStraight, Length: 3, Key: card(5, 0)}, false},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			if got := beats(test.next, test.prev); got != test.want {
				t.Fatalf("beats(%+v, %+v) = %v, want %v", test.next, test.prev, got, test.want)
			}
		})
	}
}

func TestInstantWins(t *testing.T) {
	tests := []struct {
		name string
		hand []int
		want string
	}{
		{"four twos", []int{card(12, 0), card(12, 1), card(12, 2), card(12, 3), 1, 2, 5, 9, 13, 17, 21, 25, 29}, InstantFourTwos},
		{"dragon", []int{card(0, 0), card(1, 0), card(2, 0), card(3, 0), card(4, 0), card(5, 0), card(6, 0), card(7, 0), card(8, 0), card(9, 0), card(10, 0), card(11, 0), card(12, 0)}, InstantDragon},
		{"four pair run", []int{card(3, 0), card(3, 1), card(4, 0), card(4, 1), card(5, 0), card(5, 1), card(6, 0), card(6, 1), card(8, 0), card(9, 1), card(10, 2), card(11, 3), card(12, 0)}, InstantFourPairRun},
		{"six pairs", []int{card(0, 0), card(0, 1), card(2, 0), card(2, 1), card(4, 0), card(4, 1), card(6, 0), card(6, 1), card(8, 0), card(8, 1), card(10, 0), card(10, 1), card(12, 0)}, InstantSixPairs},
		{"nothing", []int{0, 5, 9, 13, 18, 22, 27, 31, 36, 40, 45, 49, 51}, ""},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			if got := instantWinKind(test.hand); got != test.want {
				t.Fatalf("instantWinKind = %q, want %q", got, test.want)
			}
		})
	}
}

func fixedState(hands [][]int, starter int) *State {
	n := len(hands)
	s := &State{
		Hands:       make([][]int, n),
		Passed:      make([]bool, n),
		Quit:        make([]bool, n),
		FinishOrder: []int{},
		Starter:     starter,
		Turn:        starter,
		Rng:         "1",
		Steps:       []Step{},
	}
	for i, hand := range hands {
		s.Hands[i] = append([]int(nil), hand...)
	}
	return s
}

func mustPlay(t *testing.T, s *State, idx int, cards ...int) {
	t.Helper()
	s.Steps = []Step{}
	if err := applyMove(s, idx, Move{Type: MoveTypePlay, Cards: cards}); err != nil {
		t.Fatalf("play by %d failed: %v", idx, err)
	}
}

func mustPass(t *testing.T, s *State, idx int) {
	t.Helper()
	s.Steps = []Step{}
	if err := applyMove(s, idx, Move{Type: MoveTypePass}); err != nil {
		t.Fatalf("pass by %d failed: %v", idx, err)
	}
}

func TestFirstPlayRequiresThreeSpades(t *testing.T) {
	s := fixedState([][]int{{ThreeOfSpades, 10, 20}, {5, 15, 25}, {6, 16, 26}}, 0)
	s.RequireThreeSpades = true
	if err := applyMove(s, 0, Move{Type: MoveTypePlay, Cards: []int{10}}); err == nil {
		t.Fatal("first play without three of spades was accepted")
	}
	if err := applyMove(s, 0, Move{Type: MoveTypePass}); err == nil {
		t.Fatal("leader pass was accepted")
	}
	mustPlay(t, s, 0, ThreeOfSpades)
	if s.RequireThreeSpades || s.Turn != 1 {
		t.Fatalf("state after first play: require3s=%v turn=%d", s.RequireThreeSpades, s.Turn)
	}
}

func TestRoundClearAndLeadRotation(t *testing.T) {
	s := fixedState([][]int{{4, 10, 20}, {5, 15, 25}, {6, 16, 26}, {7, 17, 27}}, 0)
	mustPlay(t, s, 0, 4)
	mustPlay(t, s, 1, 5)
	mustPass(t, s, 2)
	mustPass(t, s, 3)
	mustPass(t, s, 0)
	if s.Table != nil {
		t.Fatalf("trick was not cleared: %+v", s.Table)
	}
	if s.Turn != 1 {
		t.Fatalf("round winner does not lead: turn=%d", s.Turn)
	}
	for i, passed := range s.Passed {
		if passed {
			t.Fatalf("pass flag %d not reset", i)
		}
	}
}

func TestFinishAndGameOver(t *testing.T) {
	s := fixedState([][]int{{4}, {5, 15}, {6, 16}}, 0)
	s.Steps = []Step{}
	mustPlay(t, s, 0, 4)
	if len(s.FinishOrder) != 1 || s.FinishOrder[0] != 0 {
		t.Fatalf("finish order = %v", s.FinishOrder)
	}
	over, winner := Logic{}.Result(s)
	if over {
		t.Fatal("game ended while two players still hold cards")
	}
	mustPlay(t, s, 1, 5)
	mustPass(t, s, 2)
	mustPlay(t, s, 1, 15)
	if len(s.FinishOrder) != 3 {
		t.Fatalf("finish order after game end = %v", s.FinishOrder)
	}
	over, winner = Logic{}.Result(s)
	if !over || winner != 0 {
		t.Fatalf("result = %v winner %d, want winner 0", over, winner)
	}
	ranks := Logic{}.Rankings(s)
	if len(ranks) != 3 || ranks[0] != 0 || ranks[1] != 1 || ranks[2] != 2 {
		t.Fatalf("rankings = %v", ranks)
	}
}

func TestFinisherTrickCanStillBeBeaten(t *testing.T) {
	s := fixedState([][]int{{card(11, 0)}, {card(11, 3), 15}, {6, 16}}, 0)
	mustPlay(t, s, 0, card(11, 0))
	if s.Turn != 1 {
		t.Fatalf("turn after finisher play = %d", s.Turn)
	}
	mustPlay(t, s, 1, card(11, 3))
	mustPass(t, s, 2)
	if s.Table != nil || s.Turn != 1 {
		t.Fatalf("beater did not win trick: table=%v turn=%d", s.Table, s.Turn)
	}
}

func TestClearWhenFinisherOwnedTrick(t *testing.T) {
	s := fixedState([][]int{{card(11, 0)}, {5, 15}, {6, 16}}, 0)
	mustPlay(t, s, 0, card(11, 0))
	mustPass(t, s, 1)
	mustPass(t, s, 2)
	if s.Table != nil {
		t.Fatal("trick was not cleared after all passed on finisher")
	}
	if s.Turn != 1 {
		t.Fatalf("lead after finisher clear = %d, want next active seat 1", s.Turn)
	}
}

func TestOnTurnSkipped(t *testing.T) {
	s := fixedState([][]int{{4, 10}, {5, 15}}, 0)
	Logic{}.OnTurnSkipped(s, 0)
	if s.Table == nil || len(s.Table.Cards) != 1 || s.Table.Cards[0] != 4 {
		t.Fatalf("leader skip did not auto play lowest card: %+v", s.Table)
	}
	Logic{}.OnTurnSkipped(s, 1)
	if !s.Passed[1] && s.Table != nil {
		t.Fatalf("follower skip did not pass: passed=%v table=%v", s.Passed, s.Table)
	}
}

func TestOnPlayerQuit(t *testing.T) {
	s := fixedState([][]int{{4, 10}, {5, 15}, {6, 16}, {7, 17}}, 0)
	mustPlay(t, s, 0, 4)
	Logic{}.OnPlayerQuit(s, 1)
	if !s.Quit[1] || s.Turn == 1 {
		t.Fatalf("quit state: quit=%v turn=%d", s.Quit, s.Turn)
	}
	if s.Turn != 2 {
		t.Fatalf("turn after quit = %d, want 2", s.Turn)
	}
	ranks := Logic{}.Rankings(s)
	if ranks[len(ranks)-1] != 1 {
		t.Fatalf("quitter is not last: %v", ranks)
	}
}

func TestViewForHidesOtherHands(t *testing.T) {
	s := newDeal(42, 4)
	view := Logic{}.ViewFor(s, 1).(PlayerView)
	if view.You != 1 || len(view.YourHand) != HandSize {
		t.Fatalf("view basics: %+v", view)
	}
	if len(view.HandCounts) != 4 {
		t.Fatalf("hand counts: %v", view.HandCounts)
	}
	raw, err := json.Marshal(view)
	if err != nil {
		t.Fatal(err)
	}
	var decoded map[string]any
	if err := json.Unmarshal(raw, &decoded); err != nil {
		t.Fatal(err)
	}
	if _, leaked := decoded["hands"]; leaked {
		t.Fatal("view leaks all hands")
	}
}

func TestDecodeStateRejectsCorruptSnapshots(t *testing.T) {
	valid := newDeal(7, 3)
	base, err := json.Marshal(valid)
	if err != nil {
		t.Fatal(err)
	}
	if _, err := decodeState(base); err != nil {
		t.Fatalf("valid snapshot rejected: %v", err)
	}

	mutate := func(change func(*State)) json.RawMessage {
		var s State
		if err := json.Unmarshal(base, &s); err != nil {
			t.Fatal(err)
		}
		change(&s)
		raw, err := json.Marshal(&s)
		if err != nil {
			t.Fatal(err)
		}
		return raw
	}

	cases := map[string]json.RawMessage{
		"bad rng":        mutate(func(s *State) { s.Rng = "abc" }),
		"dup card":       mutate(func(s *State) { s.Hands[0][0] = s.Hands[1][0] }),
		"bad turn":       mutate(func(s *State) { s.Turn = 9 }),
		"bad card":       mutate(func(s *State) { s.Hands[0][0] = 99 }),
		"bad finish idx": mutate(func(s *State) { s.FinishOrder = []int{7} }),
		"garbage":        json.RawMessage(`{"hands": "x"}`),
	}
	for name, raw := range cases {
		if _, err := decodeState(raw); err == nil {
			t.Fatalf("%s: corrupt snapshot accepted", name)
		}
	}
}

func TestSelfPlayInvariants(t *testing.T) {
	for seed := int64(1); seed <= 60; seed++ {
		for _, playerCount := range []int{2, 3, 4} {
			r := rand.New(rand.NewSource(seed * 977))
			state := newDeal(seed, playerCount)
			if state.InstantWin != "" {
				if over, winner := (Logic{}).Result(state); !over || winner != state.FinishOrder[0] {
					t.Fatalf("instant win result mismatch seed=%d", seed)
				}
				continue
			}
			moves := 0
			for {
				over, _ := Logic{}.Result(state)
				if over {
					break
				}
				if moves > 500 {
					t.Fatalf("game did not terminate seed=%d players=%d", seed, playerCount)
				}
				idx := state.Turn
				if !state.isActive(idx) || !state.hasCards(idx) {
					t.Fatalf("turn on ineligible seat %d seed=%d", idx, seed)
				}
				move := pickRandomMove(r, state, idx)
				raw, _ := json.Marshal(move)
				if err := (Logic{}).ValidateMove(state, idx, raw); err != nil {
					t.Fatalf("generated move invalid seed=%d: %v", seed, err)
				}
				next, err := Logic{}.Apply(state, idx, raw)
				if err != nil {
					t.Fatalf("apply failed seed=%d: %v", seed, err)
				}
				state = next.(*State)
				checkCardConservation(t, state, playerCount)
				moves++
			}
			ranks := Logic{}.Rankings(state)
			if len(ranks) != playerCount {
				t.Fatalf("incomplete rankings %v seed=%d", ranks, seed)
			}
		}
	}
}

func pickRandomMove(r *rand.Rand, s *State, idx int) Move {
	plays := enumeratePlays(s, idx)
	if len(plays) == 0 {
		return Move{Type: MoveTypePass}
	}
	if s.Table != nil && r.Intn(3) == 0 {
		return Move{Type: MoveTypePass}
	}
	return Move{Type: MoveTypePlay, Cards: plays[r.Intn(len(plays))]}
}

func enumeratePlays(s *State, idx int) [][]int {
	hand := s.Hands[idx]
	candidates := make([][]int, 0)
	appendIfPlayable := func(cards []int) {
		if _, err := checkMove(s, idx, Move{Type: MoveTypePlay, Cards: cards}); err == nil {
			candidates = append(candidates, cards)
		}
	}
	for _, c := range hand {
		appendIfPlayable([]int{c})
	}
	byRank := map[int][]int{}
	for _, c := range hand {
		byRank[rankOf(c)] = append(byRank[rankOf(c)], c)
	}
	for _, cards := range byRank {
		if len(cards) >= 2 {
			appendIfPlayable(cards[:2])
		}
		if len(cards) >= 3 {
			appendIfPlayable(cards[:3])
		}
		if len(cards) == 4 {
			appendIfPlayable(cards[:4])
		}
	}
	for start := RankThree; start < RankTwo; start++ {
		run := []int{}
		for rank := start; rank < RankTwo; rank++ {
			cards := byRank[rank]
			if len(cards) == 0 {
				break
			}
			run = append(run, cards[0])
			if len(run) >= 3 {
				appendIfPlayable(append([]int(nil), run...))
			}
		}
		pairRun := []int{}
		for rank := start; rank < RankTwo; rank++ {
			cards := byRank[rank]
			if len(cards) < 2 {
				break
			}
			pairRun = append(pairRun, cards[0], cards[1])
			if len(pairRun) >= 6 {
				appendIfPlayable(append([]int(nil), pairRun...))
			}
		}
	}
	return candidates
}

func checkCardConservation(t *testing.T, s *State, playerCount int) {
	t.Helper()
	seen := map[int]bool{}
	total := 0
	for _, hand := range s.Hands {
		for _, c := range hand {
			if seen[c] {
				t.Fatalf("card %d duplicated", c)
			}
			seen[c] = true
			total++
		}
	}
	if s.Table != nil {
		for _, c := range s.Table.Cards {
			if seen[c] {
				t.Fatalf("table card %d duplicated in a hand", c)
			}
		}
	}
	if total > playerCount*HandSize {
		t.Fatalf("too many cards in hands: %d", total)
	}
}
