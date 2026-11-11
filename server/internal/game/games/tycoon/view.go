package tycoon

type PlayerView struct {
	You           int           `json:"you"`
	Players       []PlayerState `json:"players"`
	Tiles         []TileState   `json:"tiles"`
	Turn          int           `json:"turn"`
	Phase         string        `json:"phase"`
	Dice          [2]int        `json:"dice"`
	Debt          *Debt         `json:"debt"`
	PendingDebts  []Debt        `json:"pendingDebts"`
	Card          *CardRef      `json:"card"`
	Festival      int           `json:"festival"`
	ChanceLeft    int           `json:"chanceLeft"`
	ChestLeft     int           `json:"chestLeft"`
	Round         int           `json:"round"`
	BankruptOrder []int         `json:"bankruptOrder"`
	Finished      bool          `json:"finished"`
	Winner        int           `json:"winner"`
	EndReason     *string       `json:"endReason"`
	MoveCount     int           `json:"moveCount"`
	StartedAt     int64         `json:"startedAt"`
	Steps         []Step        `json:"steps"`
}

func (Logic) ViewFor(state any, playerIdx int) any {
	s, ok := state.(*State)
	if !ok {
		return nil
	}
	return viewFor(s, playerIdx)
}

func viewFor(s *State, playerIdx int) PlayerView {
	snapshot := cloneState(s)
	if playerIdx < 0 || playerIdx >= s.playerCount() {
		playerIdx = -1
	}
	return PlayerView{
		You:           playerIdx,
		Players:       snapshot.Players,
		Tiles:         snapshot.Tiles,
		Turn:          snapshot.Turn,
		Phase:         snapshot.Phase,
		Dice:          snapshot.Dice,
		Debt:          snapshot.Debt,
		PendingDebts:  snapshot.PendingDebts,
		Card:          snapshot.Card,
		Festival:      snapshot.Festival,
		ChanceLeft:    len(s.ChanceDeck),
		ChestLeft:     len(s.ChestDeck),
		Round:         snapshot.Round,
		BankruptOrder: snapshot.BankruptOrder,
		Finished:      snapshot.Finished,
		Winner:        snapshot.Winner,
		EndReason:     snapshot.EndReason,
		MoveCount:     snapshot.MoveCount,
		StartedAt:     snapshot.StartedAt,
		Steps:         append([]Step{}, s.Steps...),
	}
}

func (Logic) SpectatorView(state any) any {
	s, ok := state.(*State)
	if !ok {
		return nil
	}
	return viewFor(s, -1)
}
