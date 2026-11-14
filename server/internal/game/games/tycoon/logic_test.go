package tycoon

import (
	"encoding/json"
	"slices"
	"strconv"
	"strings"
	"testing"
	"time"
)

func testState(players int) *State {
	return newState(1, players)
}

func setDice(t *testing.T, s *State, a, b int) {
	t.Helper()
	for z := uint64(1); z < 100000; z++ {
		probe := &State{Rng: strconv.FormatUint(z, 10)}
		if probe.rngInt(6)+1 == a && probe.rngInt(6)+1 == b {
			s.Rng = strconv.FormatUint(z, 10)
			return
		}
	}
	t.Fatalf("no rng seed rolls %d,%d", a, b)
}

func play(t *testing.T, s *State, seat int, mv Move) *State {
	t.Helper()
	next, err := applyMove(s, seat, mv)
	if err != nil {
		t.Fatalf("%s by %d: %v", mv.Type, seat, err)
	}
	return next
}

func expectCode(t *testing.T, s *State, seat int, mv Move, code string) {
	t.Helper()
	_, err := applyMove(s, seat, mv)
	if RuleCode(err) != code {
		t.Fatalf("%s by %d: got %v, want %s", mv.Type, seat, err, code)
	}
}

func rawMove(t *testing.T, mv Move) json.RawMessage {
	t.Helper()
	raw, err := json.Marshal(mv)
	if err != nil {
		t.Fatal(err)
	}
	return raw
}

func hasStep(s *State, kind string) bool {
	return slices.ContainsFunc(s.Steps, func(step Step) bool { return step.Kind == kind })
}

func TestInitDealsCashAndShuffledDecks(t *testing.T) {
	fixed := time.Date(2026, 11, 1, 10, 0, 0, 0, time.UTC)
	now = func() time.Time { return fixed }
	defer func() { now = time.Now }()

	for _, tc := range []struct{ asked, want int }{{1, 2}, {3, 3}, {4, 4}, {9, 4}} {
		s := Logic{}.InitPlayers(99, tc.asked).(*State)
		if s.playerCount() != tc.want {
			t.Fatalf("players for %d = %d, want %d", tc.asked, s.playerCount(), tc.want)
		}
		if s.StartedAt != fixed.UnixMilli() {
			t.Fatalf("startedAt = %d", s.StartedAt)
		}
		for i, p := range s.Players {
			if p.Cash != StartCash || p.Pos != 0 || p.JailCards == nil {
				t.Fatalf("player %d starts as %+v", i, p)
			}
		}
	}
	s := testState(4)
	if validateDeck(s.ChanceDeck, len(chanceCards)) != nil || len(s.ChanceDeck) != 12 || len(s.ChestDeck) != 12 {
		t.Fatalf("decks = %v / %v", s.ChanceDeck, s.ChestDeck)
	}
	if slices.Equal(s.ChanceDeck, deckOrder(12)) && slices.Equal(s.ChestDeck, deckOrder(12)) {
		t.Fatal("decks were not shuffled")
	}
}

func TestPassingAndLandingOnGoPaySalary(t *testing.T) {
	s := testState(2)
	s.Players[0].Pos = 30
	setDice(t, s, 1, 2)
	s = play(t, s, 0, Move{Type: MoveRoll})
	if s.Players[0].Pos != 1 || s.Players[0].Cash != StartCash+GoSalary || s.Phase != PhaseDecide {
		t.Fatalf("after passing go: %+v phase %s", s.Players[0], s.Phase)
	}

	s = testState(2)
	s.Players[0].Pos = 29
	setDice(t, s, 1, 2)
	s = play(t, s, 0, Move{Type: MoveRoll})
	if s.Players[0].Pos != 0 || s.Players[0].Cash != StartCash+GoSalary || s.Phase != PhaseManage {
		t.Fatalf("after landing on go: %+v phase %s", s.Players[0], s.Phase)
	}
}

func TestDoublesRollAgainAndThirdDoubleJails(t *testing.T) {
	s := testState(2)
	setDice(t, s, 3, 3)
	s = play(t, s, 0, Move{Type: MoveRoll})
	s = play(t, s, 0, Move{Type: MoveDecline})
	s = play(t, s, 0, Move{Type: MoveEndTurn})
	if s.Turn != 0 || s.Phase != PhaseRoll || s.Players[0].Doubles != 1 {
		t.Fatalf("double did not keep the turn: turn %d phase %s doubles %d", s.Turn, s.Phase, s.Players[0].Doubles)
	}

	s.Players[0].Doubles = MaxDoubles - 1
	setDice(t, s, 2, 2)
	s = play(t, s, 0, Move{Type: MoveRoll})
	p := s.Players[0]
	if !p.InJail || p.Pos != JailTile || p.Doubles != 0 || s.Phase != PhaseManage {
		t.Fatalf("third double: %+v phase %s", p, s.Phase)
	}
	s = play(t, s, 0, Move{Type: MoveEndTurn})
	if s.Turn != 1 || s.Phase != PhaseRoll {
		t.Fatalf("turn did not pass after jail: %d %s", s.Turn, s.Phase)
	}
}

func TestRentRules(t *testing.T) {
	s := testState(2)
	s.Tiles[1] = TileState{Owner: 1}
	if got := s.computeRent(1, 1); got != 6 {
		t.Fatalf("single street rent = %d", got)
	}
	s.Tiles[3] = TileState{Owner: 1}
	if got := s.computeRent(1, 1); got != 12 {
		t.Fatalf("full group rent = %d", got)
	}
	s.Tiles[1].Houses = 2
	if got := s.computeRent(1, 1); got != 145 {
		t.Fatalf("level 2 rent = %d", got)
	}
	s.Festival = 1
	if got := s.computeRent(1, 1); got != 290 {
		t.Fatalf("festival rent = %d", got)
	}
	for count, want := range []int{25, 50, 100, 200} {
		s.Tiles[[]int{6, 10, 22, 26}[count]] = TileState{Owner: 1}
		if got := s.computeRent(6, 1); got != want {
			t.Fatalf("rent with %d airports = %d, want %d", count+1, got, want)
		}
	}
}

func TestNearestAirportCardDoublesRent(t *testing.T) {
	s := testState(2)
	s.Players[0].Pos = 4
	s.Tiles[6] = TileState{Owner: 1}
	s.Phase = PhaseCard
	s.Card = &CardRef{Deck: DeckChance, ID: "ch05"}
	s = play(t, s, 0, Move{Type: MoveCardAck})
	if s.Players[0].Pos != 6 || s.Players[0].Cash != StartCash-50 || s.Players[1].Cash != StartCash+50 {
		t.Fatalf("airport card: %+v / %+v", s.Players[0], s.Players[1])
	}
}

func TestTaxTakesTenPercentOfWorth(t *testing.T) {
	s := testState(2)
	s.Players[0].Pos = 10
	s.Tiles[1] = TileState{Owner: 0}
	setDice(t, s, 1, 1)
	s = play(t, s, 0, Move{Type: MoveRoll})
	if s.Players[0].Pos != 12 || s.Players[0].Cash != StartCash-156 {
		t.Fatalf("tax: %+v", s.Players[0])
	}
}

func TestTravel(t *testing.T) {
	s := testState(2)
	s.Players[0].Pos = 22
	setDice(t, s, 1, 1)
	s = play(t, s, 0, Move{Type: MoveRoll})
	if s.Turn != 0 || s.Phase != PhaseTravel || s.Players[0].Doubles != 0 || !hasStep(s, StepTravel) {
		t.Fatalf("landing on travel: turn %d phase %s %+v", s.Turn, s.Phase, s.Players[0])
	}
	expectCode(t, s, 0, Move{Type: MoveTravel, Tile: intp(24)}, ErrInvalidTile)
	expectCode(t, s, 0, Move{Type: MoveRoll}, ErrWrongPhase)
	if mv, ok := moveOnTimeout(s, 0); !ok || mv.Type != MoveDecline {
		t.Fatalf("travel timeout: %+v", mv)
	}
	flown := play(t, s, 0, Move{Type: MoveTravel, Tile: intp(3)})
	if flown.Players[0].Pos != 3 || flown.Players[0].Cash != StartCash+GoSalary || flown.Phase != PhaseDecide || flown.Turn != 0 {
		t.Fatalf("travel flight: %+v phase %s", flown.Players[0], flown.Phase)
	}
	stayed := play(t, s, 0, Move{Type: MoveDecline})
	if stayed.Players[0].Pos != 24 || stayed.Phase != PhaseManage {
		t.Fatalf("decline travel: %+v phase %s", stayed.Players[0], stayed.Phase)
	}
	stayed = play(t, stayed, 0, Move{Type: MoveEndTurn})
	if stayed.Turn != 1 || stayed.Phase != PhaseRoll {
		t.Fatalf("landing on travel kept the double: turn %d phase %s", stayed.Turn, stayed.Phase)
	}
}

func TestBuildOnlyWhereStanding(t *testing.T) {
	s := testState(2)
	s.Phase = PhaseManage
	s.Tiles[1] = TileState{Owner: 0}
	s.Tiles[3] = TileState{Owner: 0}
	s.Players[0].Pos = 1
	expectCode(t, s, 0, Move{Type: MoveBuild, Tile: intp(3)}, ErrNotHere)
	s = play(t, s, 0, Move{Type: MoveBuild, Tile: intp(1)})
	s = play(t, s, 0, Move{Type: MoveBuild, Tile: intp(1)})
	if s.Tiles[1].Houses != 2 || s.Tiles[3].Houses != 0 || s.Players[0].Cash != StartCash-40-50 {
		t.Fatalf("after build: %+v %+v cash %d", s.Tiles[1], s.Tiles[3], s.Players[0].Cash)
	}
	s.Tiles[3] = TileState{Owner: 0, Houses: 1}
	s = play(t, s, 0, Move{Type: MoveSellHouse, Tile: intp(3)})
	s = play(t, s, 0, Move{Type: MoveSellHouse, Tile: intp(1)})
	if s.Tiles[1].Houses != 1 || s.Tiles[3].Houses != 0 || s.Players[0].Cash != StartCash-40-50+20+25 {
		t.Fatalf("after sell: %+v %+v cash %d", s.Tiles[1], s.Tiles[3], s.Players[0].Cash)
	}
	s.Players[0].Pos = 6
	expectCode(t, s, 0, Move{Type: MoveBuild, Tile: intp(6)}, ErrNotStreet)
	expectCode(t, s, 0, Move{Type: MoveBuild}, ErrInvalidTile)
	s.Players[0].Pos = 1
	s.Players[0].Cash = 10
	expectCode(t, s, 0, Move{Type: MoveBuild, Tile: intp(1)}, ErrNoCash)
}

func TestNoBuildOnJustBoughtTile(t *testing.T) {
	s := testState(2)
	s.Phase = PhaseDecide
	s.Players[0].Pos = 17
	s = play(t, s, 0, Move{Type: MoveBuy})
	if s.Bought != 17 {
		t.Fatalf("bought %d", s.Bought)
	}
	expectCode(t, s, 0, Move{Type: MoveBuild, Tile: intp(17)}, ErrJustBought)
	s = play(t, s, 0, Move{Type: MoveEndTurn})
	if s.Bought != -1 {
		t.Fatalf("bought after turn %d", s.Bought)
	}
	s.Turn = 0
	s.Phase = PhaseManage
	s = play(t, s, 0, Move{Type: MoveBuild, Tile: intp(17)})
	if s.Tiles[17].Houses != 1 {
		t.Fatalf("houses %d", s.Tiles[17].Houses)
	}
}

func TestTakeoverPaysOwnerAndKeepsHousesAndFestival(t *testing.T) {
	s := testState(2)
	s.Tiles[17] = TileState{Owner: 1, Houses: 1}
	s.Tiles[19] = TileState{Owner: 1, Houses: 1}
	s.Festival = 17
	s.Players[0].Pos = 15
	setDice(t, s, 1, 1)
	s = play(t, s, 0, Move{Type: MoveRoll})
	if s.Phase != PhaseTakeover || s.Players[0].Cash != StartCash-260 {
		t.Fatalf("after rent: phase %s cash %d", s.Phase, s.Players[0].Cash)
	}
	s = play(t, s, 0, Move{Type: MoveTakeover})
	if s.Tiles[17] != (TileState{Owner: 0, Houses: 1}) || s.Festival != 17 {
		t.Fatalf("takeover tile %+v festival %d", s.Tiles[17], s.Festival)
	}
	if s.Players[0].Cash != StartCash-260-495 || s.Players[1].Cash != StartCash+260+495 {
		t.Fatalf("takeover cash %d / %d", s.Players[0].Cash, s.Players[1].Cash)
	}

	hotel := testState(2)
	hotel.Tiles[17] = TileState{Owner: 1, Houses: MaxHouses}
	hotel.Tiles[19] = TileState{Owner: 1, Houses: MaxHouses}
	hotel.Players[0].Pos = 15
	setDice(t, hotel, 1, 1)
	hotel = play(t, hotel, 0, Move{Type: MoveRoll})
	if hotel.Phase != PhaseManage {
		t.Fatalf("hotel offered takeover: %s", hotel.Phase)
	}
}

func debtState(cash, amount int) *State {
	s := testState(3)
	s.Tiles[1] = TileState{Owner: 0, Houses: 2}
	s.Tiles[3] = TileState{Owner: 0, Houses: 2}
	s.Players[0].Cash = cash
	s.Phase = PhaseDebt
	s.Debt = &Debt{Creditor: 1, Amount: amount, By: 0, ReturnTo: 0, Reason: PayRent}
	return s
}

func TestSettleDebtSellsHousesOrBankrupts(t *testing.T) {
	s := debtState(250, 300)
	expectCode(t, s, 0, Move{Type: MovePayDebt}, ErrNoCash)
	paid := play(t, s, 0, Move{Type: MoveSettleDebt})
	if paid.Players[0].Cash != 0 || paid.Players[1].Cash != StartCash+300 || paid.Phase != PhaseManage || paid.Turn != 0 {
		t.Fatalf("settled: %+v phase %s", paid.Players[0], paid.Phase)
	}
	if paid.Tiles[1].Houses+paid.Tiles[3].Houses != 2 {
		t.Fatalf("sold houses: %+v %+v", paid.Tiles[1], paid.Tiles[3])
	}

	broke := play(t, debtState(100, 300), 0, Move{Type: MoveSettleDebt})
	if !broke.Players[0].Bankrupt || broke.Tiles[1] != (TileState{Owner: 1}) || broke.Tiles[3] != (TileState{Owner: 1}) {
		t.Fatalf("bankrupt transfer: %+v %+v %+v", broke.Players[0], broke.Tiles[1], broke.Tiles[3])
	}
	if broke.Players[1].Cash != StartCash+100+2*(25+20) || broke.Turn != 1 || broke.Phase != PhaseRoll {
		t.Fatalf("creditor cash %d turn %d phase %s", broke.Players[1].Cash, broke.Turn, broke.Phase)
	}
}

func TestBankruptToBankReleasesTilesAndFestival(t *testing.T) {
	s := debtState(0, 500)
	s.Debt.Creditor = -1
	s.Festival = 1
	s = play(t, s, 0, Move{Type: MoveDeclareBankrupt})
	if s.Tiles[1] != (TileState{Owner: -1}) || s.Festival != -1 || !slices.Equal(s.BankruptOrder, []int{0}) {
		t.Fatalf("bank bankruptcy: %+v festival %d order %v", s.Tiles[1], s.Festival, s.BankruptOrder)
	}
}

func TestBirthdayDebtorsPlayOutOfTurn(t *testing.T) {
	s := play(t, birthdayScenario(), 0, Move{Type: MoveCardAck})
	if !s.Players[3].Bankrupt || s.Players[0].Cash != StartCash+3 {
		t.Fatalf("broke guest: %+v drawer cash %d", s.Players[3], s.Players[0].Cash)
	}
	if s.Turn != 1 || s.Phase != PhaseDebt || s.Debt.ReturnTo != 0 || len(s.PendingDebts) != 1 || s.PendingDebts[0].By != 2 {
		t.Fatalf("debts: turn %d debt %+v pending %+v", s.Turn, s.Debt, s.PendingDebts)
	}
	if Logic.NextTurn(Logic{}, s, 0) != 1 {
		t.Fatal("engine turn does not move to the debtor")
	}
	expectCode(t, s, 0, Move{Type: MoveEndTurn}, ErrNotYourTurn)
	s = play(t, s, 1, Move{Type: MoveSettleDebt})
	if s.Turn != 2 || s.Debt == nil || s.Debt.By != 2 {
		t.Fatalf("second debtor: turn %d debt %+v", s.Turn, s.Debt)
	}
	s = play(t, s, 2, Move{Type: MoveSettleDebt})
	if s.Turn != 0 || s.Phase != PhaseManage || s.Debt != nil || s.Players[0].Cash != StartCash+23 {
		t.Fatalf("back to drawer: turn %d phase %s cash %d", s.Turn, s.Phase, s.Players[0].Cash)
	}
}

func TestForcedJailFineDebtMovesAfterPaying(t *testing.T) {
	s := play(t, forcedJailFineScenario(), 1, Move{Type: MoveJailRoll})
	if s.Phase != PhaseDebt || s.Debt.After != debtAfterMove || s.Players[1].Pos != JailTile {
		t.Fatalf("forced fine: phase %s debt %+v", s.Phase, s.Debt)
	}
	s = play(t, s, 1, Move{Type: MoveSettleDebt})
	if s.Players[1].InJail || s.Players[1].Pos == JailTile || !hasStep(s, StepMove) {
		t.Fatalf("player did not leave jail after paying: %+v", s.Players[1])
	}
}

func TestInstantWins(t *testing.T) {
	for _, tc := range []struct {
		name  string
		owned []int
		buy   int
		want  string
	}{
		{"line", []int{1, 3, 5}, 7, EndLine},
		{"airports", []int{6, 10, 22}, 26, EndAirports},
		{"groups", []int{1, 3, 9, 11, 25}, 27, EndGroups},
	} {
		s := testState(3)
		for _, idx := range tc.owned {
			s.Tiles[idx] = TileState{Owner: 0}
		}
		s.Players[0].Pos = tc.buy
		s.Phase = PhaseDecide
		s = play(t, s, 0, Move{Type: MoveBuy})
		if !s.Finished || *s.EndReason != tc.want || s.Winner != 0 {
			t.Fatalf("%s: finished %v reason %v", tc.name, s.Finished, s.EndReason)
		}
		if over, winner := (Logic{}).Result(s); !over || winner != 0 {
			t.Fatalf("%s: result %v %d", tc.name, over, winner)
		}
	}
}

func TestMaxRoundsRankByWorthThenSeat(t *testing.T) {
	s := testState(3)
	s.Round = MaxRounds
	s.Turn = 2
	s.Phase = PhaseManage
	s.Players[0].Cash = 1000
	s.Players[1].Cash = 1200
	s.Players[2].Cash = 1200
	s = play(t, s, 2, Move{Type: MoveEndTurn})
	if !s.Finished || *s.EndReason != EndRounds {
		t.Fatalf("round limit: finished %v reason %v", s.Finished, s.EndReason)
	}
	if got := (Logic{}).Rankings(s); !slices.Equal(got, []int{1, 2, 0}) {
		t.Fatalf("rankings = %v", got)
	}
}

func TestTimeLimitEndsOnlyAtTheNextTurn(t *testing.T) {
	fixed := time.Date(2026, 11, 1, 10, 0, 0, 0, time.UTC)
	now = func() time.Time { return fixed }
	defer func() { now = time.Now }()

	s := testState(2)
	s.StartedAt = fixed.Add(-TimeLimit).UnixMilli()
	s.Players[0].Pos = 7
	s.Phase = PhaseDecide
	next, err := Logic{}.Apply(s, 0, rawMove(t, Move{Type: MoveBuy}))
	if err != nil || next.(*State).Finished {
		t.Fatalf("time limit cut the turn: %v", err)
	}
	next, err = Logic{}.Apply(next, 0, rawMove(t, Move{Type: MoveEndTurn}))
	if err != nil {
		t.Fatal(err)
	}
	ended := next.(*State)
	if !ended.Finished || *ended.EndReason != EndTime {
		t.Fatalf("time limit: finished %v reason %v", ended.Finished, ended.EndReason)
	}
}

func TestMoveOnTimeoutCoversEveryPhase(t *testing.T) {
	cases := map[string]func(*State) string{
		PhaseRoll: func(s *State) string { return MoveRoll },
		PhaseTravel: func(s *State) string {
			s.Players[0].Pos = 24
			return MoveDecline
		},
		PhaseJail: func(s *State) string {
			s.Players[0].InJail = true
			s.Players[0].Pos = JailTile
			return MoveJailRoll
		},
		PhaseDecide: func(s *State) string {
			s.Players[0].Pos = 1
			return MoveDecline
		},
		PhaseTakeover: func(s *State) string { return MoveDecline },
		PhaseFestival: func(s *State) string {
			s.Tiles[1] = TileState{Owner: 0}
			s.Players[0].Pos = 16
			return MoveFestival
		},
		PhaseCard: func(s *State) string {
			s.Card = &CardRef{Deck: DeckChance, ID: "ch07"}
			return MoveCardAck
		},
		PhaseManage: func(s *State) string { return MoveEndTurn },
		PhaseDebt: func(s *State) string {
			s.Debt = &Debt{Creditor: -1, Amount: 100, By: 0, ReturnTo: 0, Reason: PayTax}
			return MoveSettleDebt
		},
	}
	for _, phase := range Phases {
		s := testState(2)
		s.Phase = phase
		want := cases[phase](s)
		raw, ok := Logic{}.MoveOnTimeout(s, 0)
		if !ok {
			t.Fatalf("%s: no timeout move", phase)
		}
		var mv Move
		if err := json.Unmarshal(raw, &mv); err != nil || mv.Type != want {
			t.Fatalf("%s: timeout move %s, want %s", phase, raw, want)
		}
		if _, err := (Logic{}).Apply(s, 0, raw); err != nil {
			t.Fatalf("%s: timeout move rejected: %v", phase, err)
		}
	}
	if _, ok := (Logic{}).MoveOnTimeout(testState(2), 1); ok {
		t.Fatal("timeout move offered to a seat that is not on turn")
	}
}

func TestQuitDuringDebtsAndLastPlayerWins(t *testing.T) {
	s := play(t, birthdayScenario(), 0, Move{Type: MoveCardAck})
	Logic{}.OnPlayerQuit(s, 1)
	if !s.Players[1].Quit || s.Turn != 2 || s.Debt == nil || s.Debt.By != 2 {
		t.Fatalf("debtor quit: turn %d debt %+v", s.Turn, s.Debt)
	}
	if over, _ := (Logic{}).Result(s); over {
		t.Fatal("match ended with two active players")
	}
	Logic{}.OnPlayerQuit(s, 2)
	over, winner := Logic{}.Result(s)
	if !over || winner != 0 || *s.EndReason != EndLast {
		t.Fatalf("last player: over %v winner %d", over, winner)
	}
	if got := (Logic{}).Rankings(s); !slices.Equal(got, []int{0, 2, 1, 3}) {
		t.Fatalf("rankings = %v", got)
	}
	Logic{}.OnPlayerQuit(s, 0)
	if _, winner := (Logic{}).Result(s); winner != 0 {
		t.Fatalf("quitting after the end changed the winner to %d", winner)
	}
}

func decodeRoundTrip(t *testing.T, s *State) *State {
	t.Helper()
	raw, err := json.Marshal(s)
	if err != nil {
		t.Fatal(err)
	}
	decoded, err := Logic{}.DecodeState(raw)
	if err != nil {
		t.Fatalf("state rejected: %v", err)
	}
	return decoded.(*State)
}

func TestBystanderQuitKeepsTheCardInPlay(t *testing.T) {
	s := birthdayScenario()
	Logic{}.OnPlayerQuit(s, 3)
	if s.Turn != 0 || s.Phase != PhaseCard || s.Card == nil {
		t.Fatalf("after bystander quit: turn %d phase %s card %+v", s.Turn, s.Phase, s.Card)
	}
	s = decodeRoundTrip(t, s)
	s = play(t, s, 0, Move{Type: MoveCardAck})
	if s.Card != nil || s.Debt == nil || s.Debt.By != 1 {
		t.Fatalf("card did not resolve: card %+v debt %+v", s.Card, s.Debt)
	}
}

func TestQuitOnOwnCardMovesToTheNextSeat(t *testing.T) {
	s := birthdayScenario()
	Logic{}.OnPlayerQuit(s, 0)
	if s.Turn != 1 || s.Phase != PhaseRoll || s.Card != nil {
		t.Fatalf("after drawer quit: turn %d phase %s card %+v", s.Turn, s.Phase, s.Card)
	}
}

func TestMatchEndingDuringACardClearsTheCard(t *testing.T) {
	s := testState(2)
	s.Phase = PhaseCard
	s.Card = &CardRef{Deck: DeckChest, ID: "cm07"}
	Logic{}.OnPlayerQuit(s, 1)
	if !s.Finished || s.Card != nil {
		t.Fatalf("finished %v card %+v", s.Finished, s.Card)
	}
	decodeRoundTrip(t, s)
}

func TestBirthdayStopsCollectingOnceTheGameEnds(t *testing.T) {
	s := play(t, birthdayInstantWinScenario(), 0, Move{Type: MoveCardAck})
	if !s.Finished || *s.EndReason != EndAirports || s.Winner != 0 {
		t.Fatalf("finished %v reason %v winner %d", s.Finished, s.EndReason, s.Winner)
	}
	if s.Players[2].Bankrupt || !slices.Equal(s.BankruptOrder, []int{1}) {
		t.Fatalf("seat 2 was charged after the end: %+v order %v", s.Players[2], s.BankruptOrder)
	}
}

func TestLastRoundBankruptcyStaysDecodable(t *testing.T) {
	s := testState(3)
	s.Round = MaxRounds
	s.Turn = 2
	s.Phase = PhaseDebt
	s.Players[2].Cash = 0
	s.Debt = &Debt{Creditor: -1, Amount: 500, By: 2, ReturnTo: 2, Reason: PayRent}
	s = play(t, s, 2, Move{Type: MoveDeclareBankrupt})
	if !s.Finished || *s.EndReason != EndRounds {
		t.Fatalf("finished %v reason %v", s.Finished, s.EndReason)
	}
	decoded := decodeRoundTrip(t, s)
	if got := (Logic{}).Rankings(decoded); len(got) != 3 || got[2] != 2 {
		t.Fatalf("rankings = %v", got)
	}
	if (Logic{}).MoveCount(decoded) != s.MoveCount {
		t.Fatalf("move count = %d", (Logic{}).MoveCount(decoded))
	}
}

func TestTakeoverOwnerQuitOffersTheFreeTile(t *testing.T) {
	s := takeoverScenario()
	Logic{}.OnPlayerQuit(s, 1)
	if s.Turn != 0 || s.Phase != PhaseDecide || s.Tiles[1].Owner != -1 {
		t.Fatalf("after owner quit: turn %d phase %s tile %+v", s.Turn, s.Phase, s.Tiles[1])
	}
	s = play(t, s, 0, Move{Type: MoveBuy})
	if s.Tiles[1].Owner != 0 || s.Phase != PhaseManage {
		t.Fatalf("after buy: tile %+v phase %s", s.Tiles[1], s.Phase)
	}
}

func TestEveryoneLeftRanksByWorth(t *testing.T) {
	s := testState(3)
	s.Players[0].Cash = 9000
	s.Players[1].Cash = 1
	s.Players[2].Cash = 500
	Logic{}.OnEveryoneLeft(s)
	over, winner := Logic{}.Result(s)
	if !over || winner != 0 || *s.EndReason != EndTime {
		t.Fatalf("over %v winner %d reason %v", over, winner, s.EndReason)
	}
	if got := (Logic{}).Rankings(s); !slices.Equal(got, []int{0, 2, 1}) {
		t.Fatalf("rankings = %v", got)
	}
	if len(s.BankruptOrder) != 0 {
		t.Fatalf("seats went bankrupt: %v", s.BankruptOrder)
	}
}

func TestMovesAreRejectedWithPrefixedCodes(t *testing.T) {
	s := testState(2)
	_, err := Logic{}.Apply(s, 1, rawMove(t, Move{Type: MoveRoll}))
	if err == nil || err.Error() != ErrorPrefix+ErrNotYourTurn {
		t.Fatalf("other seat: %v", err)
	}
	if err := (Logic{}).ValidateMove(s, 0, rawMove(t, Move{Type: MoveBuy})); err == nil || err.Error() != ErrorPrefix+ErrWrongPhase {
		t.Fatalf("wrong phase: %v", err)
	}
	if err := (Logic{}).ValidateMove(s, 0, json.RawMessage(`{"type":"FLY"}`)); RuleCode(err) != ErrUnknownMove {
		t.Fatalf("unknown move: %v", err)
	}
	if err := (Logic{}).ValidateMove(s, 0, json.RawMessage(`[]`)); RuleCode(err) != ErrInvalidMove {
		t.Fatalf("malformed move: %v", err)
	}
}

func TestDecodeStateRoundTripAndRejects(t *testing.T) {
	s := play(t, birthdayScenario(), 0, Move{Type: MoveCardAck})
	raw, err := json.Marshal(s)
	if err != nil {
		t.Fatal(err)
	}
	decoded, err := Logic{}.DecodeState(raw)
	if err != nil {
		t.Fatalf("decode: %v", err)
	}
	again, _ := json.Marshal(decoded)
	if string(again) != string(raw) {
		t.Fatal("state did not survive a round trip")
	}

	mutations := map[string]func(*State){
		"one player":     func(s *State) { s.Players = s.Players[:1] },
		"short board":    func(s *State) { s.Tiles = s.Tiles[:31] },
		"bad owner":      func(s *State) { s.Tiles[1].Owner = 7 },
		"too many":       func(s *State) { s.Tiles[1] = TileState{Owner: 0, Houses: 4} },
		"house on air":   func(s *State) { s.Tiles[6] = TileState{Owner: 0, Houses: 1} },
		"unknown phase":  func(s *State) { s.Phase = "auction" },
		"bad rng":        func(s *State) { s.Rng = "seed" },
		"lost debt":      func(s *State) { s.Debt = nil },
		"duplicate card": func(s *State) { s.ChanceDeck = append(s.ChanceDeck, s.ChanceDeck[0]) },
		"bad turn":       func(s *State) { s.Turn = 9 },
	}
	for name, mutate := range mutations {
		bad := cloneState(s)
		mutate(bad)
		data, _ := json.Marshal(bad)
		if _, err := (Logic{}).DecodeState(data); err == nil {
			t.Fatalf("%s: decode accepted an invalid state", name)
		}
	}
}

func TestFinishedStateDecodesWithRankings(t *testing.T) {
	s := testState(4)
	s.Round = MaxRounds
	s.Turn = 3
	s.Phase = PhaseManage
	s.Players[2].Cash = 2000
	s = play(t, s, 3, Move{Type: MoveEndTurn})
	raw, err := json.Marshal(s)
	if err != nil {
		t.Fatal(err)
	}
	decoded, err := Logic{}.DecodeState(raw)
	if err != nil {
		t.Fatalf("finished state rejected: %v", err)
	}
	if over, winner := (Logic{}).Result(decoded); !over || winner != 2 {
		t.Fatalf("result = %v %d", over, winner)
	}
	if got := (Logic{}).Rankings(decoded); len(got) != 4 || got[0] != 2 {
		t.Fatalf("rankings = %v", got)
	}
}

func TestViewHidesRngAndDeckOrder(t *testing.T) {
	s := testState(3)
	raw, err := json.Marshal(Logic{}.ViewFor(s, 1))
	if err != nil {
		t.Fatal(err)
	}
	text := string(raw)
	for _, hidden := range []string{`"rng"`, `"chanceDeck"`, `"chestDeck"`} {
		if strings.Contains(text, hidden) {
			t.Fatalf("view leaks %s", hidden)
		}
	}
	view := Logic{}.ViewFor(s, 1).(PlayerView)
	if view.You != 1 || view.ChanceLeft != 12 || view.ChestLeft != 12 {
		t.Fatalf("view = %+v", view)
	}
	if spectator := (Logic{}).ViewFor(s, 7).(PlayerView); spectator.You != -1 {
		t.Fatalf("out of range view you = %d", spectator.You)
	}
}

func TestTurnStartDelayCoversAnimations(t *testing.T) {
	s := testState(2)
	if got := (Logic{}).TurnStartDelay(s, -1, 0); got != firstTurnDelay {
		t.Fatalf("first turn delay = %v", got)
	}
	setDice(t, s, 1, 2)
	s = play(t, s, 0, Move{Type: MoveRoll})
	same := Logic{}.TurnStartDelay(s, 0, 0)
	if want := rollDelay + 3*hopDelay + landDelay; same != want {
		t.Fatalf("same seat delay = %v, want %v", same, want)
	}
	if got := (Logic{}).TurnStartDelay(s, 0, 1); got != same+turnAnnounceDelay {
		t.Fatalf("seat change delay = %v", got)
	}
	s.Steps = make([]Step, 100)
	for i := range s.Steps {
		s.Steps[i] = Step{Kind: StepBankrupt}
	}
	if got := (Logic{}).TurnStartDelay(s, 0, 1); got != maxStartDelay {
		t.Fatalf("delay not capped: %v", got)
	}
}

func TestResultDescriberReportsEndAndExitReasons(t *testing.T) {
	s := newState(7, 3)
	quitPlayer(s, 1)
	s.Players[2].Bankrupt = true
	reason := EndRounds
	s.EndReason = &reason
	if got := (Logic{}).EndReason(s); got != EndRounds {
		t.Fatalf("end reason=%q", got)
	}
	got := (Logic{}).ExitReasons(s)
	if len(got) != 3 || got[0] != "" || got[1] != ExitForfeit || got[2] != ExitBankrupt {
		t.Fatalf("exit reasons=%v", got)
	}
}

func TestSpectatorViewHidesDecksAndSeat(t *testing.T) {
	s := newState(9, 3)
	view, ok := (Logic{}).SpectatorView(s).(PlayerView)
	if !ok {
		t.Fatal("spectator view has the wrong type")
	}
	if view.You != -1 || view.ChanceLeft != len(s.ChanceDeck) || len(view.Players) != 3 {
		t.Fatalf("unexpected spectator view: you=%d chance=%d players=%d", view.You, view.ChanceLeft, len(view.Players))
	}
	data, err := json.Marshal(view)
	if err != nil {
		t.Fatal(err)
	}
	if strings.Contains(string(data), "chanceDeck") || strings.Contains(string(data), "rng") {
		t.Fatalf("spectator view leaks hidden state: %s", data)
	}
}
