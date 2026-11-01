//go:generate go run ../../../../cmd/tycoongen -parity testdata/parity.json
package tycoon

import (
	"encoding/json"
	"strconv"
)

const (
	parityVersion       = 1
	parityMaxTurns      = 120
	parityScenarioTurns = 60
	stressMaxTurns      = 5000
	explorerProbePct    = 3
	explorerQuitOdds    = 400
	explorerSeedMix     = 0x5DEECE66D
	explorerTravelPct   = 70
	explorerJailCard    = 50
	explorerJailPay     = 30
	explorerBuyPct      = 85
	explorerTakeover    = 50
	explorerFestival    = 80
	explorerBuildPct    = 45
	explorerSellPct     = 10
	explorerDebtSell    = 35
	explorerDebtPay     = 55
	explorerDebtSettle  = 95
)

type ParityConstants struct {
	TurnSeconds        int      `json:"turnSeconds"`
	TimeLimitMs        int64    `json:"timeLimitMs"`
	BoardSize          int      `json:"boardSize"`
	StartCash          int      `json:"startCash"`
	GoSalary           int      `json:"goSalary"`
	JailFine           int      `json:"jailFine"`
	JailTile           int      `json:"jailTile"`
	MaxHouses          int      `json:"maxHouses"`
	MaxRounds          int      `json:"maxRounds"`
	TakeoverMultiplier int      `json:"takeoverMultiplier"`
	WinGroups          int      `json:"winGroups"`
	MaxDoubles         int      `json:"maxDoubles"`
	JailMaxTurns       int      `json:"jailMaxTurns"`
	BirthdayGift       int      `json:"birthdayGift"`
	FestivalMultiplier int      `json:"festivalMultiplier"`
	TaxRate            float64  `json:"taxRate"`
	StationRent        []int    `json:"stationRent"`
	Phases             []string `json:"phases"`
	MoveTypes          []string `json:"moveTypes"`
	StepKinds          []string `json:"stepKinds"`
	EndReasons         []string `json:"endReasons"`
}

type ParityTurn struct {
	Seat  int    `json:"seat"`
	Move  *Move  `json:"move,omitempty"`
	Quit  bool   `json:"quit,omitempty"`
	Error string `json:"error,omitempty"`
	Steps []Step `json:"steps,omitempty"`
	State *State `json:"state,omitempty"`
}

type ParityGame struct {
	Name    string       `json:"name,omitempty"`
	Seed    int64        `json:"seed"`
	Players int          `json:"players"`
	Initial *State       `json:"initial,omitempty"`
	Turns   []ParityTurn `json:"turns"`
	Final   *State       `json:"final"`
}

type parityScenario struct {
	name      string
	state     *State
	quitFirst int
}

type ParityFixture struct {
	Version   int             `json:"version"`
	Constants ParityConstants `json:"constants"`
	Board     []Tile          `json:"board"`
	Cards     []Card          `json:"cards"`
	Games     []ParityGame    `json:"games"`
}

func ExportParityFixture() ParityFixture {
	fixture := newParityFixture()
	for _, game := range []struct {
		seed    int64
		players int
	}{{20261101, 2}, {7, 3}, {42, 4}} {
		fixture.Games = append(fixture.Games, PlayParityGame(game.seed, game.players, parityMaxTurns, false))
	}
	fixture.Games = append(fixture.Games, scenarioGames(parityScenarioTurns, false)...)
	return fixture
}

func ExportStressFixture(games int) ParityFixture {
	fixture := newParityFixture()
	for i := 0; i < games; i++ {
		fixture.Games = append(fixture.Games, PlayParityGame(int64(i+1), MinPlayers+i%(MaxPlayers-MinPlayers+1), stressMaxTurns, true))
	}
	fixture.Games = append(fixture.Games, scenarioGames(stressMaxTurns, true)...)
	return fixture
}

func scenarioGames(maxTurns int, withStates bool) []ParityGame {
	var games []ParityGame
	for _, sc := range parityScenarios() {
		game := playParityFrom(sc.state, explorerSeedFor(sc.state), maxTurns, withStates, sc.quitFirst)
		game.Name = sc.name
		game.Initial = cloneState(sc.state)
		games = append(games, game)
	}
	return games
}

func explorerSeedFor(s *State) int64 {
	z, _ := strconv.ParseUint(s.Rng, 10, 64)
	return int64(z)
}

func parityScenarios() []parityScenario {
	return []parityScenario{
		{name: "birthday-two-debtors", state: birthdayScenario(), quitFirst: -1},
		{name: "birthday-debtor-quits", state: birthdayScenario(), quitFirst: 1},
		{name: "birthday-drawer-quits", state: birthdayScenario(), quitFirst: 0},
		{name: "forced-jail-fine-debt", state: forcedJailFineScenario(), quitFirst: -1},
		{name: "bankrupt-transfer-wins", state: bankruptTransferScenario(), quitFirst: -1},
	}
}

func grantGroup(s *State, seat int, group string, houses int) {
	for _, idx := range tilesOfGroup(group) {
		s.Tiles[idx] = TileState{Owner: seat, Houses: houses}
	}
}

func birthdayScenario() *State {
	s := newState(11, 4)
	s.Phase = PhaseCard
	s.Card = &CardRef{Deck: DeckChest, ID: "cm07"}
	s.Players[0].Pos = 2
	grantGroup(s, 0, GroupPink, 0)
	grantGroup(s, 1, GroupBrown, 1)
	s.Players[1].Cash = 5
	grantGroup(s, 2, GroupSky, 2)
	s.Players[2].Cash = 0
	s.Players[3].Cash = 3
	return s
}

func forcedJailFineScenario() *State {
	for seed := int64(5); ; seed++ {
		s := newState(seed, 3)
		s.Turn = 1
		s.Phase = PhaseJail
		s.Players[1] = PlayerState{Cash: 20, Pos: JailTile, InJail: true, JailTurns: JailMaxTurns - 1, JailCards: []CardRef{}}
		grantGroup(s, 1, GroupBrown, 1)
		probe := cloneState(s)
		if a, b := probe.rollDice(); a != b {
			return s
		}
	}
}

func bankruptTransferScenario() *State {
	s := newState(23, 4)
	grantGroup(s, 0, GroupBrown, 0)
	grantGroup(s, 0, GroupSky, 0)
	s.Tiles[9] = TileState{Owner: 0}
	s.Tiles[11] = TileState{Owner: 1}
	s.Players[1].Cash = 0
	s.Players[1].Pos = 25
	s.Turn = 1
	s.Phase = PhaseDebt
	s.Debt = &Debt{Creditor: 0, Amount: 500, By: 1, ReturnTo: 1, Reason: PayRent}
	return s
}

func EncodeParityFixture(fixture ParityFixture) ([]byte, error) {
	data, err := json.Marshal(fixture)
	if err != nil {
		return nil, err
	}
	return append(data, '\n'), nil
}

func newParityFixture() ParityFixture {
	return ParityFixture{
		Version: parityVersion,
		Constants: ParityConstants{
			TurnSeconds:        TurnSeconds,
			TimeLimitMs:        TimeLimit.Milliseconds(),
			BoardSize:          BoardSize,
			StartCash:          StartCash,
			GoSalary:           GoSalary,
			JailFine:           JailFine,
			JailTile:           JailTile,
			MaxHouses:          MaxHouses,
			MaxRounds:          MaxRounds,
			TakeoverMultiplier: TakeoverMultiplier,
			WinGroups:          WinGroups,
			MaxDoubles:         MaxDoubles,
			JailMaxTurns:       JailMaxTurns,
			BirthdayGift:       BirthdayGift,
			FestivalMultiplier: FestivalMultiplier,
			TaxRate:            TaxRate,
			StationRent:        StationRent[:],
			Phases:             Phases,
			MoveTypes:          MoveTypes,
			StepKinds:          StepKinds,
			EndReasons:         EndReasons,
		},
		Board: Board,
		Cards: Cards,
		Games: []ParityGame{},
	}
}

func PlayParityGame(seed int64, players, maxTurns int, withStates bool) ParityGame {
	return playParityFrom(newState(seed, players), seed, maxTurns, withStates, -1)
}

func playParityFrom(s *State, seed int64, maxTurns int, withStates bool, quitFirst int) ParityGame {
	e := &explorer{z: uint64(seed) ^ explorerSeedMix}
	game := ParityGame{Seed: seed, Players: s.playerCount(), Turns: []ParityTurn{}}
	record := func(turn ParityTurn, state *State) {
		if withStates {
			turn.State = state
		}
		game.Turns = append(game.Turns, turn)
	}
	if quitFirst >= 0 {
		next := cloneState(s)
		quitPlayer(next, quitFirst)
		s = next
		record(ParityTurn{Seat: quitFirst, Quit: true, Steps: s.Steps}, s)
	}
	for len(game.Turns) < maxTurns && !s.isOver() {
		if active := s.activeSeats(); e.intn(explorerQuitOdds) == 0 {
			seat := active[e.intn(len(active))]
			next := cloneState(s)
			quitPlayer(next, seat)
			s = next
			record(ParityTurn{Seat: seat, Quit: true, Steps: s.Steps}, s)
			continue
		}
		seat := s.Turn
		mv := e.pick(s)
		next, err := applyMove(s, seat, mv)
		if err != nil {
			record(ParityTurn{Seat: seat, Move: &mv, Error: RuleCode(err)}, s)
			continue
		}
		s = next
		record(ParityTurn{Seat: seat, Move: &mv, Steps: s.Steps}, s)
	}
	game.Final = s
	return game
}

type explorer struct {
	z uint64
}

func (e *explorer) next() uint64 {
	e.z += 0x9E3779B97F4A7C15
	v := e.z
	v ^= v >> 30
	v *= 0xBF58476D1CE4E5B9
	v ^= v >> 27
	v *= 0x94D049BB133111EB
	v ^= v >> 31
	return v
}

func (e *explorer) intn(n int) int {
	return int(e.next() % uint64(n))
}

func (e *explorer) chance(pct int) bool {
	return e.intn(100) < pct
}

func (e *explorer) tileMove(moveType string, tiles []int) (Move, bool) {
	if len(tiles) == 0 {
		return Move{}, false
	}
	return Move{Type: moveType, Tile: intp(tiles[e.intn(len(tiles))])}, true
}

func (e *explorer) pick(s *State) Move {
	seat := s.Turn
	p := s.Players[seat]
	if e.chance(explorerProbePct) {
		return Move{Type: MoveTypes[e.intn(len(MoveTypes))], Tile: intp(e.intn(BoardSize+2) - 1)}
	}
	switch s.Phase {
	case PhaseTravel:
		if e.chance(explorerTravelPct) {
			return Move{Type: MoveTravel, Tile: intp(e.intn(BoardSize))}
		}
		return Move{Type: MoveRoll}
	case PhaseJail:
		if len(p.JailCards) > 0 && e.chance(explorerJailCard) {
			return Move{Type: MoveJailCard}
		}
		if e.chance(explorerJailPay) {
			return Move{Type: MoveJailPay}
		}
		return Move{Type: MoveJailRoll}
	case PhaseDecide:
		if e.chance(explorerBuyPct) {
			return Move{Type: MoveBuy}
		}
		return Move{Type: MoveDecline}
	case PhaseTakeover:
		if e.chance(explorerTakeover) {
			return Move{Type: MoveTakeover}
		}
		return Move{Type: MoveDecline}
	case PhaseFestival:
		if mv, ok := e.tileMove(MoveFestival, ownedStreets(s, seat, false, false)); ok && e.chance(explorerFestival) {
			return mv
		}
		return Move{Type: MoveDecline}
	case PhaseCard:
		return Move{Type: MoveCardAck}
	case PhaseManage:
		if e.chance(explorerBuildPct) {
			if mv, ok := e.tileMove(MoveBuild, ownedStreets(s, seat, true, false)); ok {
				return mv
			}
		}
		if e.chance(explorerSellPct) {
			if mv, ok := e.tileMove(MoveSellHouse, ownedStreets(s, seat, false, true)); ok {
				return mv
			}
		}
		return Move{Type: MoveEndTurn}
	case PhaseDebt:
		roll := e.intn(100)
		switch {
		case roll < explorerDebtSell:
			if mv, ok := e.tileMove(MoveSellHouse, ownedStreets(s, seat, false, true)); ok {
				return mv
			}
			return Move{Type: MoveSettleDebt}
		case roll < explorerDebtPay:
			return Move{Type: MovePayDebt}
		case roll < explorerDebtSettle:
			return Move{Type: MoveSettleDebt}
		default:
			return Move{Type: MoveDeclareBankrupt}
		}
	}
	return Move{Type: MoveRoll}
}

func ownedStreets(s *State, seat int, fullGroup, withHouses bool) []int {
	var tiles []int
	for idx, t := range s.Tiles {
		tile := Board[idx]
		if t.Owner != seat || tile.Kind != KindStreet {
			continue
		}
		if fullGroup && !s.ownsGroup(seat, tile.Group) {
			continue
		}
		if withHouses && t.Houses == 0 {
			continue
		}
		tiles = append(tiles, idx)
	}
	return tiles
}
