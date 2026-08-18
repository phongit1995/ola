package wargod

import "ola-chat-server/internal/game/logic"

const (
	moveSwap = "swap"
	moveUlt  = "ult"

	stepSwap    = "swap"
	stepMatch   = "match"
	stepGravity = "gravity"
	stepShuffle = "shuffle"
	stepUlt     = "ult"

	skillLightningGod = "lightning-god"
	skillMyriadSwords = "myriad-swords"
)

type State struct {
	Board          []int      `json:"board"`
	Fighters       [2]Fighter `json:"fighters"`
	Rng            string     `json:"rng"`
	MoveCount      int        `json:"moveCount"`
	ExtraTurn      bool       `json:"extraTurn"`
	ExtraTurns     int        `json:"extraTurns,omitempty"`
	ExtraTurnOwner int        `json:"extraTurnOwner"`
	Steps          []Step     `json:"steps"`
}

type LightningArc struct {
	Source int `json:"source"`
	Target int `json:"target"`
}

type Step struct {
	Kind          string         `json:"kind"`
	A             *int           `json:"a,omitempty"`
	B             *int           `json:"b,omitempty"`
	Cells         []int          `json:"cells,omitempty"`
	Exploded      []int          `json:"exploded,omitempty"`
	LightningArcs []LightningArc `json:"lightningArcs,omitempty"`
	Counts        map[string]int `json:"counts,omitempty"`
	MaxRun        int            `json:"maxRun,omitempty"`
	BonusTurns    int            `json:"bonusTurns,omitempty"`
	CascadeLevel  int            `json:"cascadeLevel,omitempty"`
	Effects       *Effects       `json:"effects,omitempty"`
	Falls         []Fall         `json:"falls,omitzero"`
	Spawns        []Spawn        `json:"spawns,omitzero"`
	Board         []int          `json:"board,omitempty"`
	Damage        int            `json:"damage,omitempty"`
	ArmorDamage   int            `json:"armorDamage,omitempty"`
	Skill         string         `json:"skill,omitempty"`
}

type Move struct {
	Type  string `json:"type"`
	A     *int   `json:"a"`
	B     *int   `json:"b"`
	Skill string `json:"skill,omitempty"`
}

type Logic struct{}

func init() {
	logic.Register(Logic{})
}

func (Logic) ID() string        { return "war-god" }
func (Logic) StateVersion() int { return 2 }

func (Logic) Result(state any) (bool, int) {
	s := state.(*State)
	for idx := range s.Fighters {
		if s.Fighters[idx].HP <= 0 {
			return true, 1 - idx
		}
	}
	return false, -1
}

func (Logic) MoveCount(state any) int {
	s, ok := state.(*State)
	if !ok {
		return 0
	}
	return s.MoveCount
}

func (Logic) KeepTurn(state any) bool {
	s, ok := state.(*State)
	if !ok {
		return false
	}
	return s.ExtraTurns > 0 || s.ExtraTurn
}

func (Logic) TimeoutSkipsTurn() bool { return true }

func (Logic) TurnSeconds() int { return 30 }

func (Logic) OnTurnSkipped(state any, playerIdx int) {
	s, ok := state.(*State)
	if !ok {
		return
	}
	if s.ExtraTurns > 0 && s.ExtraTurnOwner != playerIdx {
		return
	}
	s.ExtraTurn = false
	s.ExtraTurns = 0
	s.ExtraTurnOwner = -1
}
