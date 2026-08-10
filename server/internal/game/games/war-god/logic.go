package wargod

import (
	"encoding/json"
	"errors"
	"strconv"

	"ola-chat-server/internal/game/logic"
)

const (
	moveSwap = "swap"
	moveUlt  = "ult"

	stepSwap    = "swap"
	stepMatch   = "match"
	stepGravity = "gravity"
	stepShuffle = "shuffle"
	stepUlt     = "ult"
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

type Step struct {
	Kind       string         `json:"kind"`
	A          *int           `json:"a,omitempty"`
	B          *int           `json:"b,omitempty"`
	Cells      []int          `json:"cells,omitempty"`
	Exploded   []int          `json:"exploded,omitempty"`
	Counts     map[string]int `json:"counts,omitempty"`
	MaxRun     int            `json:"maxRun,omitempty"`
	BonusTurns int            `json:"bonusTurns,omitempty"`
	Effects    *Effects       `json:"effects,omitempty"`
	Falls      []Fall         `json:"falls,omitzero"`
	Spawns     []Spawn        `json:"spawns,omitzero"`
	Board      []int          `json:"board,omitempty"`
	Damage     int            `json:"damage,omitempty"`
}

type Move struct {
	Type string `json:"type"`
	A    *int   `json:"a"`
	B    *int   `json:"b"`
}

type Logic struct{}

func init() {
	logic.Register(Logic{})
}

func (Logic) ID() string { return "war-god" }

func (Logic) StateVersion() int { return 2 }

func (Logic) Init(seed int64) any {
	r := &rng{z: uint64(seed)}
	return &State{
		Board:          createBoard(r),
		Fighters:       [2]Fighter{{HP: maxHP}, {HP: maxHP}},
		Rng:            strconv.FormatUint(r.z, 10),
		ExtraTurnOwner: -1,
	}
}

func (Logic) DecodeState(data json.RawMessage) (any, error) {
	// -1 lets version-2 snapshots that predate ExtraTurnOwner remain
	// distinguishable from snapshots owned by player zero.
	state := &State{ExtraTurnOwner: -1}
	if err := json.Unmarshal(data, state); err != nil {
		return nil, errors.New("invalid saved war-god state")
	}
	if len(state.Board) != boardSize {
		return nil, errors.New("invalid saved war-god board")
	}
	for _, tile := range state.Board {
		if tile < 0 || tile >= tileCount {
			return nil, errors.New("invalid saved war-god tile")
		}
	}
	if matchedCells, _, _ := findMatches(state.Board); matchedCells != nil {
		return nil, errors.New("saved war-god board has unresolved matches")
	}
	if len(validSwaps(state.Board)) == 0 {
		return nil, errors.New("saved war-god board has no valid moves")
	}
	for _, fighter := range state.Fighters {
		if fighter.HP <= 0 {
			return nil, errors.New("completed war-god state cannot be restored as active")
		}
		if fighter.HP > maxHP || fighter.MP < 0 || fighter.MP > maxMP || fighter.Armor < 0 || fighter.Armor > maxArmor || fighter.Fury < 0 || fighter.Fury > maxFury {
			return nil, errors.New("invalid saved war-god fighter")
		}
	}
	if state.MoveCount < 0 {
		return nil, errors.New("invalid saved war-god move count")
	}
	if state.ExtraTurns < 0 {
		return nil, errors.New("invalid saved war-god extra turns")
	}
	if state.ExtraTurns > 0 {
		if state.ExtraTurnOwner < 0 || state.ExtraTurnOwner >= len(state.Fighters) {
			return nil, errors.New("invalid saved war-god extra turn owner")
		}
		state.ExtraTurn = true
	} else {
		// Legacy snapshots may still carry ExtraTurn=true for the one bonus
		// action already granted by the engine. It is consumed by the next move.
		state.ExtraTurnOwner = -1
	}
	if state.Rng == "" {
		return nil, errors.New("invalid saved war-god rng")
	}
	if _, err := strconv.ParseUint(state.Rng, 10, 64); err != nil {
		return nil, errors.New("invalid saved war-god rng")
	}
	state.Steps = nil
	return state, nil
}

func parseMove(raw json.RawMessage) (*Move, error) {
	var m Move
	if err := json.Unmarshal(raw, &m); err != nil {
		return nil, errors.New("invalid move payload")
	}
	switch m.Type {
	case moveUlt:
		return &m, nil
	case moveSwap:
		if m.A == nil || m.B == nil {
			return nil, errors.New("missing swap cells")
		}
		a, b := *m.A, *m.B
		if a < 0 || a >= boardSize || b < 0 || b >= boardSize {
			return nil, errors.New("swap out of board")
		}
		if a == b || !areAdjacent(a, b) {
			return nil, errors.New("swap cells not adjacent")
		}
		return &m, nil
	default:
		return nil, errors.New("unknown move type")
	}
}

func (Logic) ValidateMove(state any, playerIdx int, move json.RawMessage) error {
	s := state.(*State)
	m, err := parseMove(move)
	if err != nil {
		return err
	}
	if m.Type == moveUlt {
		if s.Fighters[playerIdx].MP < ultCost {
			return errors.New("not enough mana")
		}
		return nil
	}
	a, b := *m.A, *m.B
	board := append([]int(nil), s.Board...)
	board[a], board[b] = board[b], board[a]
	if matchedCells, _, _ := findMatches(board); matchedCells == nil {
		return errors.New("swap creates no match")
	}
	return nil
}

func (Logic) Apply(state any, playerIdx int, move json.RawMessage) (any, error) {
	current := state.(*State)
	m, err := parseMove(move)
	if err != nil {
		return current, err
	}
	z, err := strconv.ParseUint(current.Rng, 10, 64)
	if err != nil {
		return current, errors.New("invalid war-god rng state")
	}
	s := &State{
		Board:          append([]int(nil), current.Board...),
		Fighters:       current.Fighters,
		MoveCount:      current.MoveCount,
		ExtraTurnOwner: -1,
		Steps:          []Step{},
	}
	// The action being applied consumes one previously banked bonus turn.
	// Ownership prevents a timeout from handing the remaining bank to the
	// opponent before OnTurnSkipped clears it.
	remainingExtraTurns := 0
	if current.ExtraTurns > 0 && current.ExtraTurnOwner == playerIdx {
		remainingExtraTurns = current.ExtraTurns - 1
	}
	r := &rng{z: z}
	attacker := &s.Fighters[playerIdx]
	defender := &s.Fighters[1-playerIdx]

	if attacker.Armor > 0 {
		attacker.Armor -= armorDecay
		if attacker.Armor < 0 {
			attacker.Armor = 0
		}
	}

	switch m.Type {
	case moveSwap:
		a, b := *m.A, *m.B
		s.Board[a], s.Board[b] = s.Board[b], s.Board[a]
		s.Steps = append(s.Steps, Step{Kind: stepSwap, A: intPtr(a), B: intPtr(b)})
		for {
			matchedCells, counts, maxRun := findMatches(s.Board)
			if matchedCells == nil {
				break
			}
			// Mỗi đường ghép 4+ nhận một lượt; nhiều đường/cascade được cộng
			// dồn. Nếu wave chỉ có các đường 3 nhưng dọn ≥5 ô, giữ luật cũ +1.
			bonusTurns := matchBonusTurns(s.Board, len(matchedCells))
			remainingExtraTurns += bonusTurns
			removed := make(map[int]bool, len(matchedCells))
			for _, i := range matchedCells {
				removed[i] = true
			}
			exploded := computeExplosions(s.Board, removed)
			for _, i := range exploded {
				counts[s.Board[i]]++
				removed[i] = true
			}
			waveEffects := applyTileEffects(attacker, defender, counts)
			s.Steps = append(s.Steps, Step{
				Kind:       stepMatch,
				Cells:      matchedCells,
				Exploded:   exploded,
				Counts:     namedCounts(counts),
				MaxRun:     maxRun,
				BonusTurns: bonusTurns,
				Effects:    &waveEffects,
			})
			falls, spawns := applyGravity(s.Board, removed, r)
			s.Steps = append(s.Steps, Step{Kind: stepGravity, Falls: falls, Spawns: spawns})
			if defender.HP <= 0 || attacker.HP <= 0 {
				break
			}
		}
		if attacker.HP > 0 && defender.HP > 0 {
			ensurePlayable(s, r)
		}
	case moveUlt:
		if attacker.MP < ultCost {
			return current, errors.New("not enough mana")
		}
		dmg := attacker.MP / 2
		attacker.MP = 0
		defender.HP -= dmg
		if defender.HP < 0 {
			defender.HP = 0
		}
		s.Steps = append(s.Steps, Step{Kind: stepUlt, Damage: dmg})
	}

	s.ExtraTurns = remainingExtraTurns
	s.ExtraTurn = s.ExtraTurns > 0
	if s.ExtraTurn {
		s.ExtraTurnOwner = playerIdx
	}
	s.MoveCount++
	s.Rng = strconv.FormatUint(r.z, 10)
	return s, nil
}

func ensurePlayable(s *State, r *rng) {
	if len(validSwaps(s.Board)) > 0 {
		return
	}
	s.Board = createBoard(r)
	s.Steps = append(s.Steps, Step{Kind: stepShuffle, Board: append([]int(nil), s.Board...)})
}

func namedCounts(counts map[int]int) map[string]int {
	named := make(map[string]int, len(counts))
	for tile, count := range counts {
		if count > 0 {
			named[tileNames[tile]] = count
		}
	}
	return named
}

func intPtr(v int) *int { return &v }

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
