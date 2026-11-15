package tycoon

import (
	"encoding/json"
	"errors"
	"fmt"
	"slices"
	"strconv"

	"ola-chat-server/internal/game/splitmix"
)

type CardRef struct {
	Deck string `json:"deck"`
	ID   string `json:"id"`
}

type PlayerState struct {
	Cash      int       `json:"cash"`
	Pos       int       `json:"pos"`
	InJail    bool      `json:"inJail"`
	JailTurns int       `json:"jailTurns"`
	JailCards []CardRef `json:"jailCards"`
	Bankrupt  bool      `json:"bankrupt"`
	Doubles   int       `json:"doubles"`
	Quit      bool      `json:"quit"`
	Travel    bool      `json:"travel"`
}

type TileState struct {
	Owner  int `json:"owner"`
	Houses int `json:"houses"`
}

type Debt struct {
	Creditor int    `json:"creditor"`
	Amount   int    `json:"amount"`
	By       int    `json:"by"`
	ReturnTo int    `json:"returnTo"`
	After    string `json:"after,omitempty"`
	Reason   string `json:"reason"`
}

type Step struct {
	Kind     string `json:"kind"`
	By       int    `json:"by"`
	Dice     []int  `json:"dice,omitzero"`
	Double   *bool  `json:"double,omitempty"`
	From     *int   `json:"from,omitempty"`
	To       *int   `json:"to,omitempty"`
	PassedGo *bool  `json:"passedGo,omitempty"`
	Tile     *int   `json:"tile,omitempty"`
	Amount   *int   `json:"amount,omitempty"`
	Reason   string `json:"reason,omitempty"`
	Target   *int   `json:"target,omitempty"`
	Deck     string `json:"deck,omitempty"`
	Card     string `json:"card,omitempty"`
	How      string `json:"how,omitempty"`
	Houses   *int   `json:"houses,omitempty"`
	Creditor *int   `json:"creditor,omitempty"`
	Tiles    []int  `json:"tiles,omitzero"`
	Round    *int   `json:"round,omitempty"`
	Rankings []int  `json:"rankings,omitzero"`
	Worth    []int  `json:"worth,omitzero"`
	End      string `json:"end,omitempty"`
}

type State struct {
	Players       []PlayerState `json:"players"`
	Tiles         []TileState   `json:"tiles"`
	Turn          int           `json:"turn"`
	Phase         string        `json:"phase"`
	Dice          [2]int        `json:"dice"`
	Debt          *Debt         `json:"debt"`
	PendingDebts  []Debt        `json:"pendingDebts"`
	Card          *CardRef      `json:"card"`
	Festival      int           `json:"festival"`
	Bought        int           `json:"bought"`
	ChanceDeck    []int         `json:"chanceDeck"`
	ChestDeck     []int         `json:"chestDeck"`
	Rng           string        `json:"rng"`
	Round         int           `json:"round"`
	BankruptOrder []int         `json:"bankruptOrder"`
	Finished      bool          `json:"finished"`
	Winner        int           `json:"winner"`
	EndReason     *string       `json:"endReason"`
	MoveCount     int           `json:"moveCount"`
	StartedAt     int64         `json:"startedAt"`
	Steps         []Step        `json:"steps"`
}

func intp(v int) *int { return &v }

func boolp(v bool) *bool { return &v }

func newState(seed int64, playerCount int) *State {
	count := min(max(playerCount, MinPlayers), MaxPlayers)
	s := &State{
		Players:       make([]PlayerState, count),
		Tiles:         make([]TileState, BoardSize),
		Phase:         PhaseRoll,
		PendingDebts:  []Debt{},
		Festival:      -1,
		Bought:        -1,
		ChanceDeck:    deckOrder(len(chanceCards)),
		ChestDeck:     deckOrder(len(chestCards)),
		Rng:           strconv.FormatUint(uint64(seed), 10),
		Round:         1,
		BankruptOrder: []int{},
		Winner:        -1,
		Steps:         []Step{},
	}
	for i := range s.Players {
		s.Players[i] = PlayerState{Cash: StartCash, JailCards: []CardRef{}}
	}
	for i := range s.Tiles {
		s.Tiles[i] = TileState{Owner: -1}
	}
	s.shuffle(s.ChanceDeck)
	s.shuffle(s.ChestDeck)
	return s
}

func deckOrder(n int) []int {
	deck := make([]int, n)
	for i := range deck {
		deck[i] = i
	}
	return deck
}

func (s *State) rngNext() uint64 {
	z, _ := strconv.ParseUint(s.Rng, 10, 64)
	v := splitmix.Next(&z)
	s.Rng = strconv.FormatUint(z, 10)
	return v
}

func (s *State) rngInt(n int) int {
	return int(s.rngNext() % uint64(n))
}

func (s *State) shuffle(deck []int) {
	for i := len(deck) - 1; i > 0; i-- {
		j := s.rngInt(i + 1)
		deck[i], deck[j] = deck[j], deck[i]
	}
}

func cloneState(s *State) *State {
	next := *s
	next.Players = make([]PlayerState, len(s.Players))
	for i, p := range s.Players {
		p.JailCards = append([]CardRef{}, p.JailCards...)
		next.Players[i] = p
	}
	next.Tiles = append([]TileState{}, s.Tiles...)
	if s.Debt != nil {
		debt := *s.Debt
		next.Debt = &debt
	}
	next.PendingDebts = append([]Debt{}, s.PendingDebts...)
	if s.Card != nil {
		card := *s.Card
		next.Card = &card
	}
	next.ChanceDeck = append([]int{}, s.ChanceDeck...)
	next.ChestDeck = append([]int{}, s.ChestDeck...)
	next.BankruptOrder = append([]int{}, s.BankruptOrder...)
	if s.EndReason != nil {
		reason := *s.EndReason
		next.EndReason = &reason
	}
	next.Steps = []Step{}
	return &next
}

func (s *State) StartingTurn() int { return s.Turn }

func (s *State) playerCount() int { return len(s.Players) }

func decodeState(data json.RawMessage) (*State, error) {
	var s State
	if err := json.Unmarshal(data, &s); err != nil {
		return nil, err
	}
	if err := validateState(&s); err != nil {
		return nil, err
	}
	normalizeState(&s)
	return &s, nil
}

func normalizeState(s *State) {
	for i := range s.Players {
		if s.Players[i].JailCards == nil {
			s.Players[i].JailCards = []CardRef{}
		}
	}
	if s.PendingDebts == nil {
		s.PendingDebts = []Debt{}
	}
	if s.BankruptOrder == nil {
		s.BankruptOrder = []int{}
	}
	if s.ChanceDeck == nil {
		s.ChanceDeck = []int{}
	}
	if s.ChestDeck == nil {
		s.ChestDeck = []int{}
	}
	if s.Steps == nil {
		s.Steps = []Step{}
	}
}

func validateState(s *State) error {
	n := s.playerCount()
	if n < MinPlayers || n > MaxPlayers {
		return fmt.Errorf("invalid player count %d", n)
	}
	if len(s.Tiles) != BoardSize {
		return fmt.Errorf("invalid tile count %d", len(s.Tiles))
	}
	if !slices.Contains(Phases, s.Phase) {
		return fmt.Errorf("unknown phase %q", s.Phase)
	}
	if s.Turn < 0 || s.Turn >= n {
		return fmt.Errorf("invalid turn %d", s.Turn)
	}
	if _, err := strconv.ParseUint(s.Rng, 10, 64); err != nil {
		return fmt.Errorf("invalid rng: %w", err)
	}
	if s.Festival < -1 || s.Festival >= BoardSize {
		return fmt.Errorf("invalid festival %d", s.Festival)
	}
	if s.Bought < -1 || s.Bought >= BoardSize {
		return fmt.Errorf("invalid bought %d", s.Bought)
	}
	if s.Round < 1 {
		return fmt.Errorf("invalid round %d", s.Round)
	}
	for _, die := range s.Dice {
		if die < 0 || die > 6 {
			return fmt.Errorf("invalid die %d", die)
		}
	}
	for i, t := range s.Tiles {
		if t.Owner < -1 || t.Owner >= n {
			return fmt.Errorf("tile %d has invalid owner %d", i, t.Owner)
		}
		if t.Houses < 0 || t.Houses > MaxHouses || (t.Houses > 0 && (Board[i].Kind != KindStreet || t.Owner < 0)) {
			return fmt.Errorf("tile %d has invalid houses %d", i, t.Houses)
		}
	}
	for i, p := range s.Players {
		if p.Pos < 0 || p.Pos >= BoardSize {
			return fmt.Errorf("player %d has invalid position %d", i, p.Pos)
		}
		for _, card := range p.JailCards {
			if cardIndex(card) < 0 {
				return fmt.Errorf("player %d holds unknown card %s", i, card.ID)
			}
		}
	}
	if err := validateDeck(s.ChanceDeck, len(chanceCards)); err != nil {
		return fmt.Errorf("chance deck: %w", err)
	}
	if err := validateDeck(s.ChestDeck, len(chestCards)); err != nil {
		return fmt.Errorf("chest deck: %w", err)
	}
	if !s.Finished && (s.Phase == PhaseDebt) != (s.Debt != nil) {
		return errors.New("debt does not match phase")
	}
	if s.Debt != nil {
		if err := validateDebt(*s.Debt, n); err != nil {
			return err
		}
	}
	for _, debt := range s.PendingDebts {
		if err := validateDebt(debt, n); err != nil {
			return err
		}
	}
	if !s.Finished && (s.Phase == PhaseCard) != (s.Card != nil) {
		return errors.New("card does not match phase")
	}
	if s.Card != nil && cardIndex(*s.Card) < 0 {
		return fmt.Errorf("unknown card %s", s.Card.ID)
	}
	for _, seat := range s.BankruptOrder {
		if seat < 0 || seat >= n || !s.Players[seat].Bankrupt {
			return fmt.Errorf("invalid bankrupt seat %d", seat)
		}
	}
	return nil
}

func validateDeck(deck []int, size int) error {
	seen := make([]bool, size)
	for _, id := range deck {
		if id < 0 || id >= size || seen[id] {
			return fmt.Errorf("invalid card index %d", id)
		}
		seen[id] = true
	}
	return nil
}

func validateDebt(d Debt, n int) error {
	if d.By < 0 || d.By >= n || d.ReturnTo < 0 || d.ReturnTo >= n || d.Creditor < -1 || d.Creditor >= n || d.Amount <= 0 {
		return fmt.Errorf("invalid debt %+v", d)
	}
	return nil
}

func cardIndex(ref CardRef) int {
	if ref.Deck != DeckChance && ref.Deck != DeckChest {
		return -1
	}
	return slices.IndexFunc(deckCards(ref.Deck), func(c Card) bool { return c.ID == ref.ID })
}
