package thirteen

import (
	"encoding/json"
	"errors"
	"sort"
	"strconv"
)

const (
	StepDeal    = "deal"
	StepPlay    = "play"
	StepPass    = "pass"
	StepClear   = "clear"
	StepFinish  = "finish"
	StepInstant = "instant"
)

const (
	InstantFourTwos    = "fourTwos"
	InstantDragon      = "dragonStraight"
	InstantFourPairRun = "fourPairRun"
	InstantSixPairs    = "sixPairs"
)

type Play struct {
	Cards []int `json:"cards"`
	By    int   `json:"by"`
}

type Step struct {
	Kind  string `json:"kind"`
	By    int    `json:"by"`
	Cards []int  `json:"cards,omitempty"`
	Chop  bool   `json:"chop,omitempty"`
	Place int    `json:"place,omitempty"`
	Win   string `json:"win,omitempty"`
}

type State struct {
	Hands              [][]int `json:"hands"`
	Table              *Play   `json:"table,omitempty"`
	Passed             []bool  `json:"passed"`
	Quit               []bool  `json:"quit"`
	FinishOrder        []int   `json:"finishOrder"`
	QuitOrder          []int   `json:"quitOrder,omitempty"`
	Turn               int     `json:"turn"`
	Starter            int     `json:"starter"`
	RequireThreeSpades bool    `json:"require3s"`
	InstantWin         string  `json:"instantWin,omitempty"`
	Rng                string  `json:"rng"`
	MoveCount          int     `json:"moveCount"`
	Steps              []Step  `json:"steps,omitempty"`
}

func (s *State) StartingTurn() int { return s.Starter }

func (s *State) playerCount() int { return len(s.Hands) }

func (s *State) isActive(idx int) bool {
	return idx >= 0 && idx < s.playerCount() && !s.Quit[idx]
}

func (s *State) hasCards(idx int) bool {
	return idx >= 0 && idx < s.playerCount() && len(s.Hands[idx]) > 0
}

func (s *State) activeWithCards() []int {
	idxs := make([]int, 0, s.playerCount())
	for i := range s.Hands {
		if s.isActive(i) && s.hasCards(i) {
			idxs = append(idxs, i)
		}
	}
	return idxs
}

func (s *State) nextEligible(from int) int {
	n := s.playerCount()
	for i := 1; i <= n; i++ {
		j := (from + i) % n
		if s.isActive(j) && s.hasCards(j) && !s.Passed[j] {
			return j
		}
	}
	return -1
}

func (s *State) firstActiveFrom(from int) int {
	n := s.playerCount()
	for i := 0; i < n; i++ {
		j := (from + i) % n
		if s.isActive(j) && s.hasCards(j) {
			return j
		}
	}
	return -1
}

func (s *State) clearTrick() {
	s.Table = nil
	for i := range s.Passed {
		s.Passed[i] = false
	}
}

func (s *State) advanceAfter(actorIdx int) {
	next := s.nextEligible(actorIdx)
	if s.Table == nil {
		if next >= 0 {
			s.Turn = next
		}
		return
	}
	if next < 0 {
		by := s.Table.By
		s.clearTrick()
		s.Steps = append(s.Steps, Step{Kind: StepClear, By: by})
		if leader := s.firstActiveFrom((by + 1) % s.playerCount()); leader >= 0 {
			s.Turn = leader
		}
		return
	}
	if next == s.Table.By {
		s.clearTrick()
		s.Steps = append(s.Steps, Step{Kind: StepClear, By: next})
		s.Turn = next
		return
	}
	s.Turn = next
}

type rng struct {
	z uint64
}

func (r *rng) next() uint64 {
	r.z += 0x9E3779B97F4A7C15
	v := r.z
	v ^= v >> 30
	v *= 0xBF58476D1CE4E5B9
	v ^= v >> 27
	v *= 0x94D049BB133111EB
	v ^= v >> 31
	return v
}

func (r *rng) shuffle(deck []int) {
	for i := len(deck) - 1; i > 0; i-- {
		j := int(r.next() % uint64(i+1))
		deck[i], deck[j] = deck[j], deck[i]
	}
}

func newDeal(seed int64, playerCount int) *State {
	r := &rng{z: uint64(seed)}
	deck := make([]int, DeckSize)
	for i := range deck {
		deck[i] = i
	}
	r.shuffle(deck)

	s := &State{
		Hands:              make([][]int, playerCount),
		Passed:             make([]bool, playerCount),
		Quit:               make([]bool, playerCount),
		FinishOrder:        []int{},
		RequireThreeSpades: true,
		Rng:                strconv.FormatUint(r.z, 10),
		Steps:              []Step{{Kind: StepDeal, By: -1}},
	}
	for p := 0; p < playerCount; p++ {
		hand := append([]int(nil), deck[p*HandSize:(p+1)*HandSize]...)
		sort.Ints(hand)
		s.Hands[p] = hand
	}

	s.Starter = 0
	starterFound := false
	for p := 0; p < playerCount; p++ {
		if containsCard(s.Hands[p], ThreeOfSpades) {
			s.Starter = p
			starterFound = true
			break
		}
	}
	if !starterFound {
		lowestCard := DeckSize
		for p := 0; p < playerCount; p++ {
			if s.Hands[p][0] < lowestCard {
				lowestCard = s.Hands[p][0]
				s.Starter = p
			}
		}
		s.RequireThreeSpades = false
	}
	s.Turn = s.Starter

	applyInstantWins(s)
	return s
}

func containsCard(hand []int, card int) bool {
	for _, c := range hand {
		if c == card {
			return true
		}
	}
	return false
}

func applyInstantWins(s *State) {
	n := s.playerCount()
	for i := 0; i < n; i++ {
		p := (s.Starter + i) % n
		win := instantWinKind(s.Hands[p])
		if win == "" {
			continue
		}
		s.InstantWin = win
		s.FinishOrder = make([]int, 0, n)
		s.FinishOrder = append(s.FinishOrder, p)
		for j := 1; j < n; j++ {
			s.FinishOrder = append(s.FinishOrder, (p+j)%n)
		}
		s.Steps = append(s.Steps, Step{Kind: StepInstant, By: p, Win: win})
		return
	}
}

func instantWinKind(hand []int) string {
	rankCounts := make(map[int]int, HandSize)
	for _, card := range hand {
		rankCounts[rankOf(card)]++
	}
	if rankCounts[RankTwo] == 4 {
		return InstantFourTwos
	}
	dragon := true
	for rank := RankThree; rank < RankTwo; rank++ {
		if rankCounts[rank] == 0 {
			dragon = false
			break
		}
	}
	if dragon {
		return InstantDragon
	}
	pairs := 0
	for _, count := range rankCounts {
		pairs += count / 2
	}
	if pairs >= 6 {
		return InstantSixPairs
	}
	runLength := 0
	for rank := RankThree; rank < RankTwo; rank++ {
		if rankCounts[rank] >= 2 {
			runLength++
			if runLength >= 4 {
				return InstantFourPairRun
			}
		} else {
			runLength = 0
		}
	}
	return ""
}

func decodeState(data json.RawMessage) (*State, error) {
	state := &State{}
	if err := json.Unmarshal(data, state); err != nil {
		return nil, errors.New("invalid saved tien len state")
	}
	state.Steps = nil
	if err := validateSavedState(state); err != nil {
		return nil, err
	}
	return state, nil
}

func validateSavedState(s *State) error {
	n := s.playerCount()
	if n < 2 || n > 4 {
		return errors.New("invalid saved player count")
	}
	if len(s.Passed) != n || len(s.Quit) != n {
		return errors.New("inconsistent saved seat flags")
	}
	if s.Turn < 0 || s.Turn >= n || s.Starter < 0 || s.Starter >= n {
		return errors.New("invalid saved turn")
	}
	if _, err := strconv.ParseUint(s.Rng, 10, 64); err != nil {
		return errors.New("invalid saved rng")
	}
	if s.MoveCount < 0 {
		return errors.New("invalid saved move count")
	}
	seen := make(map[int]bool, DeckSize)
	track := func(cards []int, maxLen int) error {
		if len(cards) > maxLen {
			return errors.New("invalid saved hand size")
		}
		for _, card := range cards {
			if !validCard(card) || seen[card] {
				return errors.New("invalid saved card")
			}
			seen[card] = true
		}
		return nil
	}
	for _, hand := range s.Hands {
		if err := track(hand, HandSize); err != nil {
			return err
		}
	}
	if s.Table != nil {
		if s.Table.By < 0 || s.Table.By >= n {
			return errors.New("invalid saved table owner")
		}
		if _, err := classify(s.Table.Cards); err != nil {
			return errors.New("invalid saved table cards")
		}
		if err := track(s.Table.Cards, HandSize); err != nil {
			return err
		}
	}
	if len(s.FinishOrder) > n || len(s.QuitOrder) > n {
		return errors.New("invalid saved orders")
	}
	seenIdx := make(map[int]bool, n)
	for _, idx := range append(append([]int(nil), s.FinishOrder...), s.QuitOrder...) {
		if idx < 0 || idx >= n || seenIdx[idx] {
			return errors.New("invalid saved finish order")
		}
		seenIdx[idx] = true
	}
	return nil
}
