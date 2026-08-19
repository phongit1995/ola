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
		if move.Skill == "" {
			move.Skill = skillMyriadSwords
		}
		if move.Skill != skillLightningGod && move.Skill != skillMyriadSwords {
			return nil, errors.New("unknown ultimate skill")
		}
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

	switch move.Type {
	case moveSwap:
		a, b := *move.A, *move.B
		s.Board[a], s.Board[b] = s.Board[b], s.Board[a]
		s.Steps = append(s.Steps, Step{Kind: stepSwap, A: intPtr(a), B: intPtr(b)})
		furyChainActive := false
		resolveCascades(s, attacker, defender, r, &remainingExtraTurns, 0, &furyChainActive)
		if attacker.HP > 0 && defender.HP > 0 {
			ensurePlayable(s, r)
		}
	case moveUlt:
		if attacker.MP < ultCost {
			return current, errors.New("not enough mana")
		}
		damage := 0
		armorDamage := 0
		attacker.MP = 0
		if move.Skill == skillLightningGod {
			damage, armorDamage = applyDamageThroughArmor(defender, lightningGodDamage)
			blocks := randomFourTwoByTwoBlocks(r)
			cells := make([]int, 0, len(blocks)*4)
			for _, block := range blocks {
				cells = append(cells, block...)
			}
			removed := make(map[int]bool, len(cells))
			lightningSources := make(map[int]bool, len(cells))
			for _, cell := range cells {
				removed[cell] = true
				if s.Board[cell] == tileLightning {
					lightningSources[cell] = true
				}
			}
			lightningArcs := pickLightningArcs(s.Board, lightningSources, removed, func(limit int) int {
				return int(r.next() % uint64(limit))
			})
			exploded := make([]int, 0, len(lightningArcs))
			for _, arc := range lightningArcs {
				removed[arc.Target] = true
				exploded = append(exploded, arc.Target)
			}
			counts := make(map[int]int, len(removed))
			for cell := range removed {
				counts[s.Board[cell]]++
			}
			furyChainActive := false
			strikeEffects := applyTileEffectsInCascadeChain(
				attacker, defender, counts, 0, &furyChainActive,
			)
			s.Steps = append(s.Steps, Step{
				Kind: stepUlt, Skill: move.Skill, Cells: cells,
				Damage: damage, ArmorDamage: armorDamage,
				Exploded: exploded, LightningArcs: lightningArcs,
				Counts: namedCounts(counts), Effects: &strikeEffects,
			})
			falls, spawns := applyGravity(s.Board, removed, r)
			s.Steps = append(s.Steps, Step{Kind: stepGravity, Falls: falls, Spawns: spawns})
			if attacker.HP > 0 && defender.HP > 0 {
				resolveCascades(s, attacker, defender, r, &remainingExtraTurns, 1, &furyChainActive)
			}
			if attacker.HP > 0 && defender.HP > 0 {
				ensurePlayable(s, r)
			}
		} else {
			damage, armorDamage = applyDamageThroughArmor(defender, ultCost/2)
			s.Steps = append(s.Steps, Step{
				Kind: stepUlt, Skill: move.Skill, Damage: damage, ArmorDamage: armorDamage,
			})
		}
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

func twoByTwoCells(topLeft int) []int {
	return []int{topLeft, topLeft + 1, topLeft + grid, topLeft + grid + 1}
}

func randomFourTwoByTwoBlocks(r *rng) [][]int {
	candidates := make([]int, 0, (grid-1)*(grid-1))
	for row := 0; row < grid-1; row++ {
		for col := 0; col < grid-1; col++ {
			candidates = append(candidates, row*grid+col)
		}
	}
	blocks := make([][]int, 0, 4)
	occupied := make(map[int]bool, 16)
	for len(blocks) < 4 && len(candidates) > 0 {
		pick := int(r.next() % uint64(len(candidates)))
		cells := twoByTwoCells(candidates[pick])
		blocks = append(blocks, cells)
		for _, cell := range cells {
			occupied[cell] = true
		}
		available := candidates[:0]
		for _, topLeft := range candidates {
			overlaps := false
			for _, cell := range twoByTwoCells(topLeft) {
				if occupied[cell] {
					overlaps = true
					break
				}
			}
			if !overlaps {
				available = append(available, topLeft)
			}
		}
		candidates = available
	}
	return blocks
}

func resolveCascades(
	s *State,
	attacker, defender *Fighter,
	r *rng,
	remainingExtraTurns *int,
	startingCascadeLevel int,
	furyChainActive *bool,
) {
	cascadeLevel := startingCascadeLevel
	for {
		matchedCells, counts, maxRun := findMatches(s.Board)
		if matchedCells == nil {
			break
		}
		bonusTurns := matchBonusTurns(s.Board, matchedCells)
		*remainingExtraTurns += bonusTurns
		removed := make(map[int]bool, len(matchedCells))
		for _, index := range matchedCells {
			removed[index] = true
		}
		exploded, lightningArcs := computeExplosions(s.Board, removed, r)
		for _, index := range exploded {
			counts[s.Board[index]]++
			removed[index] = true
		}
		waveEffects := applyTileEffectsInCascadeChain(
			attacker, defender, counts, cascadeLevel, furyChainActive,
		)
		s.Steps = append(s.Steps, Step{
			Kind:          stepMatch,
			Cells:         matchedCells,
			Exploded:      exploded,
			LightningArcs: lightningArcs,
			Counts:        namedCounts(counts),
			MaxRun:        maxRun,
			BonusTurns:    bonusTurns,
			CascadeLevel:  cascadeLevel,
			Effects:       &waveEffects,
		})
		falls, spawns := applyGravity(s.Board, removed, r)
		s.Steps = append(s.Steps, Step{Kind: stepGravity, Falls: falls, Spawns: spawns})
		cascadeLevel++
		if defender.HP <= 0 || attacker.HP <= 0 {
			break
		}
	}
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
