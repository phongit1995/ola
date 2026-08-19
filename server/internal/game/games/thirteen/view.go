package thirteen

type PlayerView struct {
	You                int    `json:"you"`
	YourHand           []int  `json:"yourHand"`
	HandCounts         []int  `json:"handCounts"`
	Table              *Play  `json:"table,omitempty"`
	Passed             []bool `json:"passed"`
	Quit               []bool `json:"quit"`
	FinishOrder        []int  `json:"finishOrder"`
	Turn               int    `json:"turn"`
	Starter            int    `json:"starter"`
	RequireThreeSpades bool   `json:"require3s"`
	InstantWin         string `json:"instantWin,omitempty"`
	MoveCount          int    `json:"moveCount"`
	Steps              []Step `json:"steps,omitempty"`
}

func (Logic) ViewFor(state any, playerIdx int) any {
	s, ok := state.(*State)
	if !ok {
		return state
	}
	if playerIdx < 0 || playerIdx >= s.playerCount() {
		return s
	}
	view := PlayerView{
		You:                playerIdx,
		YourHand:           append([]int(nil), s.Hands[playerIdx]...),
		HandCounts:         make([]int, s.playerCount()),
		Passed:             append([]bool(nil), s.Passed...),
		Quit:               append([]bool(nil), s.Quit...),
		FinishOrder:        append([]int(nil), s.FinishOrder...),
		Turn:               s.Turn,
		Starter:            s.Starter,
		RequireThreeSpades: s.RequireThreeSpades,
		InstantWin:         s.InstantWin,
		MoveCount:          s.MoveCount,
		Steps:              append([]Step(nil), s.Steps...),
	}
	for i, hand := range s.Hands {
		view.HandCounts[i] = len(hand)
	}
	if s.Table != nil {
		view.Table = &Play{Cards: append([]int(nil), s.Table.Cards...), By: s.Table.By}
	}
	return view
}
