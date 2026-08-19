//go:generate go run ../../../../cmd/thirteengen -constants ../../../../../game/thirteen/logic/constants.gen.ts -parity testdata/parity.json
package thirteen

type ClientConfig struct {
	GameID        string
	TurnSeconds   int
	HandSize      int
	DeckSize      int
	RankTwo       int
	ThreeOfSpades int
	ComboKinds    []string
	InstantWins   []string
	StepKinds     []string
}

func ExportClientConfig() ClientConfig {
	return ClientConfig{
		GameID:        GameID,
		TurnSeconds:   TurnSeconds,
		HandSize:      HandSize,
		DeckSize:      DeckSize,
		RankTwo:       RankTwo,
		ThreeOfSpades: ThreeOfSpades,
		ComboKinds: []string{
			string(ComboSingle), string(ComboPair), string(ComboTriple),
			string(ComboQuad), string(ComboStraight), string(ComboDoubleRun),
		},
		InstantWins: []string{InstantFourTwos, InstantDragon, InstantFourPairRun, InstantSixPairs},
		StepKinds:   []string{StepDeal, StepPlay, StepPass, StepClear, StepFinish, StepInstant},
	}
}

type ParityFixture struct {
	Version     int                `json:"version"`
	Classify    []ParityClassify   `json:"classify"`
	Beats       []ParityBeats      `json:"beats"`
	InstantWins []ParityInstantWin `json:"instantWins"`
	Deals       []ParityDeal       `json:"deals"`
}

type ParityClassify struct {
	Cards  []int  `json:"cards"`
	Kind   string `json:"kind,omitempty"`
	Length int    `json:"length,omitempty"`
	Key    int    `json:"key,omitempty"`
	Valid  bool   `json:"valid"`
}

type ParityBeats struct {
	Next []int `json:"next"`
	Prev []int `json:"prev"`
	Want bool  `json:"want"`
}

type ParityInstantWin struct {
	Hand []int  `json:"hand"`
	Want string `json:"want"`
}

type ParityDeal struct {
	Seed    int64   `json:"seed"`
	Players int     `json:"players"`
	Hands   [][]int `json:"hands"`
	Starter int     `json:"starter"`
	Rng     string  `json:"rng"`
}

func mkCard(rank, suit int) int { return rank*4 + suit }

func ExportParityFixture() ParityFixture {
	classifyCases := [][]int{
		{mkCard(5, 2)},
		{mkCard(7, 0), mkCard(7, 3)},
		{mkCard(2, 0), mkCard(2, 1), mkCard(2, 2)},
		{mkCard(9, 0), mkCard(9, 1), mkCard(9, 2), mkCard(9, 3)},
		{mkCard(0, 0), mkCard(1, 2), mkCard(2, 3)},
		{mkCard(8, 0), mkCard(9, 1), mkCard(10, 1), mkCard(11, 3)},
		{mkCard(10, 0), mkCard(11, 1), mkCard(12, 1)},
		{mkCard(3, 0), mkCard(3, 1), mkCard(4, 0), mkCard(4, 2), mkCard(5, 1), mkCard(5, 3)},
		{mkCard(3, 0), mkCard(3, 1), mkCard(4, 0), mkCard(4, 2), mkCard(5, 1), mkCard(5, 3), mkCard(6, 0), mkCard(6, 1)},
		{mkCard(10, 0), mkCard(10, 1), mkCard(11, 0), mkCard(11, 2), mkCard(12, 1), mkCard(12, 3)},
		{mkCard(1, 0), mkCard(5, 1)},
		{mkCard(5, 1), mkCard(6, 1), mkCard(6, 2)},
	}
	classifyFixtures := make([]ParityClassify, 0, len(classifyCases))
	for _, cards := range classifyCases {
		entry := ParityClassify{Cards: cards}
		if combo, err := classify(cards); err == nil {
			entry.Valid = true
			entry.Kind = string(combo.Kind)
			entry.Length = combo.Length
			entry.Key = combo.Key
		}
		classifyFixtures = append(classifyFixtures, entry)
	}

	beatsCases := [][2][]int{
		{{mkCard(5, 3)}, {mkCard(5, 2)}},
		{{mkCard(5, 0)}, {mkCard(5, 2)}},
		{{mkCard(8, 1)}, {mkCard(8, 0)}},
		{{mkCard(10, 2), mkCard(10, 3)}, {mkCard(10, 0), mkCard(10, 1)}},
		{{mkCard(3, 0), mkCard(3, 1)}, {mkCard(12, 0)}},
		{{mkCard(5, 0), mkCard(5, 1), mkCard(5, 2), mkCard(5, 3)}, {mkCard(12, 0)}},
		{{mkCard(3, 0), mkCard(3, 1), mkCard(4, 0), mkCard(4, 1), mkCard(5, 0), mkCard(5, 1)}, {mkCard(12, 3)}},
		{{mkCard(3, 0), mkCard(3, 1), mkCard(4, 0), mkCard(4, 1), mkCard(5, 0), mkCard(5, 1)}, {mkCard(12, 2), mkCard(12, 3)}},
		{{mkCard(5, 0), mkCard(5, 1), mkCard(5, 2), mkCard(5, 3)}, {mkCard(12, 2), mkCard(12, 3)}},
		{{mkCard(3, 0), mkCard(3, 1), mkCard(4, 0), mkCard(4, 1), mkCard(5, 0), mkCard(5, 1), mkCard(6, 0), mkCard(6, 1)}, {mkCard(12, 2), mkCard(12, 3)}},
		{{mkCard(3, 0), mkCard(3, 1), mkCard(4, 0), mkCard(4, 1), mkCard(5, 0), mkCard(5, 1), mkCard(6, 0), mkCard(6, 1)}, {mkCard(11, 0), mkCard(11, 1), mkCard(11, 2), mkCard(11, 3)}},
		{{mkCard(11, 0), mkCard(11, 1), mkCard(11, 2), mkCard(11, 3)}, {mkCard(3, 0), mkCard(3, 1), mkCard(4, 0), mkCard(4, 1), mkCard(5, 0), mkCard(5, 1), mkCard(6, 0), mkCard(6, 1)}},
		{{mkCard(3, 0), mkCard(3, 1), mkCard(3, 2), mkCard(3, 3)}, {mkCard(6, 0), mkCard(6, 1), mkCard(7, 0), mkCard(7, 1), mkCard(8, 0), mkCard(8, 1)}},
		{{mkCard(7, 0), mkCard(7, 1), mkCard(7, 2), mkCard(7, 3)}, {mkCard(5, 0), mkCard(5, 1), mkCard(5, 2), mkCard(5, 3)}},
		{{mkCard(5, 0), mkCard(5, 1), mkCard(5, 2), mkCard(5, 3)}, {mkCard(11, 3)}},
		{{mkCard(0, 0), mkCard(1, 1), mkCard(2, 2)}, {mkCard(3, 0), mkCard(4, 1), mkCard(5, 2)}},
		{{mkCard(4, 0), mkCard(5, 1), mkCard(6, 2)}, {mkCard(3, 0), mkCard(4, 1), mkCard(5, 2)}},
	}
	beatsFixtures := make([]ParityBeats, 0, len(beatsCases))
	for _, pair := range beatsCases {
		want := false
		next, errNext := classify(pair[0])
		prev, errPrev := classify(pair[1])
		if errNext == nil && errPrev == nil {
			want = beats(next, prev)
		}
		beatsFixtures = append(beatsFixtures, ParityBeats{Next: pair[0], Prev: pair[1], Want: want})
	}

	instantHands := [][]int{
		{mkCard(12, 0), mkCard(12, 1), mkCard(12, 2), mkCard(12, 3), 1, 2, 5, 9, 13, 17, 21, 25, 29},
		{mkCard(0, 0), mkCard(1, 0), mkCard(2, 0), mkCard(3, 0), mkCard(4, 0), mkCard(5, 0), mkCard(6, 0), mkCard(7, 0), mkCard(8, 0), mkCard(9, 0), mkCard(10, 0), mkCard(11, 0), mkCard(12, 0)},
		{mkCard(3, 0), mkCard(3, 1), mkCard(4, 0), mkCard(4, 1), mkCard(5, 0), mkCard(5, 1), mkCard(6, 0), mkCard(6, 1), mkCard(8, 0), mkCard(9, 1), mkCard(10, 2), mkCard(11, 3), mkCard(12, 0)},
		{mkCard(0, 0), mkCard(0, 1), mkCard(2, 0), mkCard(2, 1), mkCard(4, 0), mkCard(4, 1), mkCard(6, 0), mkCard(6, 1), mkCard(8, 0), mkCard(8, 1), mkCard(10, 0), mkCard(10, 1), mkCard(12, 0)},
		{0, 5, 9, 13, 18, 22, 27, 31, 36, 40, 45, 49, 51},
	}
	instants := make([]ParityInstantWin, 0, len(instantHands))
	for _, hand := range instantHands {
		instants = append(instants, ParityInstantWin{Hand: hand, Want: instantWinKind(hand)})
	}

	deals := make([]ParityDeal, 0, 6)
	for _, seed := range []int64{1, 42, 20260819} {
		for _, players := range []int{2, 4} {
			state := newDeal(seed, players)
			deals = append(deals, ParityDeal{
				Seed:    seed,
				Players: players,
				Hands:   state.Hands,
				Starter: state.Starter,
				Rng:     state.Rng,
			})
		}
	}

	return ParityFixture{
		Version:     1,
		Classify:    classifyFixtures,
		Beats:       beatsFixtures,
		InstantWins: instants,
		Deals:       deals,
	}
}
