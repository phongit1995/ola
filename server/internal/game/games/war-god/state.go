package wargod

import (
	"encoding/json"
	"errors"
	"strconv"
)

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
	// -1 keeps older version-2 snapshots without ExtraTurnOwner distinct from
	// snapshots whose bonus turns belong to player zero.
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
		if fighter.HP > maxHP || fighter.MP < 0 || fighter.MP > maxMP ||
			fighter.Armor < 0 || fighter.Armor > maxArmor ||
			fighter.Fury < 0 || fighter.Fury > maxFury {
			return nil, errors.New("invalid saved war-god fighter")
		}
	}
	if state.MoveCount < 0 {
		return nil, errors.New("invalid saved war-god move count")
	}
	if state.ExtraTurns < 0 {
		return nil, errors.New("invalid saved war-god extra turns")
	}
	// Older version-2 snapshots may contain an uncapped bonus-turn bank.
	// Preserve the match while migrating that bank to the current rule.
	if state.ExtraTurns > maxExtraTurns {
		state.ExtraTurns = maxExtraTurns
	}
	if state.ExtraTurns > 0 {
		if state.ExtraTurnOwner < 0 || state.ExtraTurnOwner >= len(state.Fighters) {
			return nil, errors.New("invalid saved war-god extra turn owner")
		}
		state.ExtraTurn = true
	} else {
		// Legacy snapshots may carry ExtraTurn=true for the one bonus action
		// already granted by the engine. The next move consumes it.
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
