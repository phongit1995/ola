package wargod

import (
	"encoding/json"
	"errors"
	"strconv"
)

func parseMove(raw json.RawMessage) (*Move, error) {
	var move Move
	if err := json.Unmarshal(raw, &move); err != nil {
		return nil, errors.New("invalid move payload")
	}
	switch move.Type {
	case moveUlt:
		return &move, nil
	case moveSwap:
		if move.A == nil || move.B == nil {
			return nil, errors.New("missing swap cells")
		}
		a, b := *move.A, *move.B
		if a < 0 || a >= boardSize || b < 0 || b >= boardSize {
			return nil, errors.New("swap out of board")
		}
		if a == b || !areAdjacent(a, b) {
			return nil, errors.New("swap cells not adjacent")
		}
		return &move, nil
	default:
		return nil, errors.New("unknown move type")
	}
}

func (Logic) ValidateMove(state any, playerIdx int, raw json.RawMessage) error {
	s := state.(*State)
	move, err := parseMove(raw)
	if err != nil {
		return err
	}
	if move.Type == moveUlt {
		if s.Fighters[playerIdx].MP < ultCost {
			return errors.New("not enough mana")
		}
		return nil
	}
	a, b := *move.A, *move.B
	board := append([]int(nil), s.Board...)
	board[a], board[b] = board[b], board[a]
	if matchedCells, _, _ := findMatches(board); matchedCells == nil {
		return errors.New("swap creates no match")
	}
	return nil
}

func (Logic) Apply(state any, playerIdx int, raw json.RawMessage) (any, error) {
	current := state.(*State)
	move, err := parseMove(raw)
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

	// Applying an action consumes one previously banked bonus turn. Ownership
	// prevents a timeout from handing the remaining bank to the opponent.
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

	switch move.Type {
	case moveSwap:
		a, b := *move.A, *move.B
		s.Board[a], s.Board[b] = s.Board[b], s.Board[a]
		s.Steps = append(s.Steps, Step{Kind: stepSwap, A: intPtr(a), B: intPtr(b)})
		for {
			matchedCells, counts, maxRun := findMatches(s.Board)
			if matchedCells == nil {
				break
			}
			// Each connected group of 4+ earns one turn, including T/L/cross
			// shapes. A collapse wave made only of groups of three earns none.
			bonusTurns := matchBonusTurns(s.Board, matchedCells)
			remainingExtraTurns += bonusTurns
			removed := make(map[int]bool, len(matchedCells))
			for _, index := range matchedCells {
				removed[index] = true
			}
			exploded, lightningArcs := computeExplosions(s.Board, removed, r)
			for _, index := range exploded {
				counts[s.Board[index]]++
				removed[index] = true
			}
			waveEffects := applyTileEffects(attacker, defender, counts)
			s.Steps = append(s.Steps, Step{
				Kind:          stepMatch,
				Cells:         matchedCells,
				Exploded:      exploded,
				LightningArcs: lightningArcs,
				Counts:        namedCounts(counts),
				MaxRun:        maxRun,
				BonusTurns:    bonusTurns,
				Effects:       &waveEffects,
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
		damage := attacker.MP / 2
		attacker.MP = 0
		defender.HP -= damage
		if defender.HP < 0 {
			defender.HP = 0
		}
		s.Steps = append(s.Steps, Step{Kind: stepUlt, Damage: damage})
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

func ensurePlayable(state *State, r *rng) {
	if len(validSwaps(state.Board)) > 0 {
		return
	}
	state.Board = createBoard(r)
	state.Steps = append(state.Steps, Step{
		Kind:  stepShuffle,
		Board: append([]int(nil), state.Board...),
	})
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

func intPtr(value int) *int { return &value }
