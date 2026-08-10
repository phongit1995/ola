package wargod

import (
	"encoding/json"
	"fmt"
	"reflect"
	"strconv"
	"testing"
)

func stripedBoard() []int {
	board := make([]int, boardSize)
	for y := 0; y < grid; y++ {
		for x := 0; x < grid; x++ {
			if y%2 == 0 {
				board[y*grid+x] = x % 2
			} else {
				board[y*grid+x] = 2 + x%2
			}
		}
	}
	return board
}

func noMoveBoard() []int {
	rows := [grid][grid]int{
		{0, 0, 1, 1, 2, 2, 0, 0},
		{3, 3, 4, 4, 5, 5, 3, 3},
		{1, 1, 2, 2, 0, 0, 1, 1},
		{4, 4, 5, 5, 3, 3, 4, 4},
		{2, 2, 0, 0, 1, 1, 2, 2},
		{5, 5, 3, 3, 4, 4, 5, 5},
		{0, 0, 1, 1, 2, 2, 0, 0},
		{3, 3, 4, 4, 5, 5, 3, 3},
	}
	board := make([]int, 0, boardSize)
	for _, row := range rows {
		board = append(board, row[:]...)
	}
	return board
}

func stateWith(board []int, fighters [2]Fighter, seed uint64) *State {
	return &State{
		Board:    append([]int(nil), board...),
		Fighters: fighters,
		Rng:      strconv.FormatUint(seed, 10),
	}
}

func stepKinds(steps []Step) []string {
	kinds := make([]string, len(steps))
	for i, step := range steps {
		kinds[i] = step.Kind
	}
	return kinds
}

func TestPRNGGoldenSequences(t *testing.T) {
	golden := map[uint64][]uint64{
		0:  {16294208416658607535, 7960286522194355700, 487617019471545679, 17909611376780542444, 1961750202426094747},
		42: {13679457532755275413, 2949826092126892291, 5139283748462763858, 6349198060258255764, 701532786141963250},
	}
	for seed, want := range golden {
		r := &rng{z: seed}
		for i, expected := range want {
			if got := r.next(); got != expected {
				t.Fatalf("seed %d next #%d: got %d want %d", seed, i, got, expected)
			}
		}
	}
}

func TestWeightedSpawnDistribution(t *testing.T) {
	r := &rng{z: 1}
	const samples = 60_000
	base := map[int]int{}
	for range samples {
		base[baseTile(r.tile())]++
	}
	if got := base[tileSword]; got < samples*18/100 || got > samples*26/100 {
		t.Fatalf("sword share off: %d/%d (~expect 22%%)", got, samples)
	}
	for _, tile := range []int{tilePeach, tileHeart, tileLightning} {
		if base[tile] < samples*12/100 {
			t.Fatalf("tile %s under-spawned: %d/%d", tileNames[tile], base[tile], samples)
		}
	}
	for _, tile := range []int{tileWater, tileShield} {
		if base[tile] < samples*11/100 {
			t.Fatalf("tile %s under-spawned: %d/%d", tileNames[tile], base[tile], samples)
		}
	}
}

func TestSpecialTilesAreRare(t *testing.T) {
	r := &rng{z: 1}
	const samples = 40_000
	counts := [tileCount]int{}
	for range samples {
		counts[r.tile()]++
	}
	for _, tile := range []int{tileFireSword, tileGreaterHeart} {
		rate := counts[tile]
		if rate < samples/120 || rate > samples/50 {
			t.Fatalf("special %s rate outside ~1/60 band: %d/%d", tileNames[tile], rate, samples)
		}
	}
}

func TestInitDeterministicAndValid(t *testing.T) {
	first := (Logic{}).Init(9).(*State)
	second := (Logic{}).Init(9).(*State)
	if !reflect.DeepEqual(first, second) {
		t.Fatal("Init is not deterministic for the same seed")
	}
	if len(first.Board) != boardSize {
		t.Fatalf("unexpected board size: %d", len(first.Board))
	}
	for i, tile := range first.Board {
		if tile < 0 || tile >= tileCount {
			t.Fatalf("cell %d has invalid tile %d", i, tile)
		}
	}
	if matchedCells, _, _ := findMatches(first.Board); matchedCells != nil {
		t.Fatal("initial board has pre-existing matches")
	}
	if len(ValidSwaps(first.Board)) == 0 {
		t.Fatal("initial board has no valid swaps")
	}
	expectedFighters := [2]Fighter{{HP: maxHP}, {HP: maxHP}}
	if first.Fighters != expectedFighters || first.MoveCount != 0 || first.ExtraTurn {
		t.Fatalf("unexpected initial state: %+v", first)
	}
	other := (Logic{}).Init(10).(*State)
	if reflect.DeepEqual(first.Board, other.Board) {
		t.Fatal("different seeds produced identical boards")
	}
}

func TestFindMatches(t *testing.T) {
	if matchedCells, _, _ := findMatches(stripedBoard()); matchedCells != nil {
		t.Fatal("striped board should have no matches")
	}

	rowThree := stripedBoard()
	rowThree[56], rowThree[57], rowThree[58] = 0, 0, 0
	cells, counts, maxRun := findMatches(rowThree)
	if !reflect.DeepEqual(cells, []int{56, 57, 58}) || counts[tileSword] != 3 || maxRun != 3 {
		t.Fatalf("row of three: cells=%v counts=%v maxRun=%d", cells, counts, maxRun)
	}

	rowFour := stripedBoard()
	rowFour[26], rowFour[27], rowFour[28], rowFour[29] = 5, 5, 5, 5
	cells, counts, maxRun = findMatches(rowFour)
	if !reflect.DeepEqual(cells, []int{26, 27, 28, 29}) || counts[tileLightning] != 4 || maxRun != 4 {
		t.Fatalf("row of four: cells=%v counts=%v maxRun=%d", cells, counts, maxRun)
	}

	rowFive := stripedBoard()
	for i := 1; i <= 5; i++ {
		rowFive[i] = 2
	}
	cells, counts, maxRun = findMatches(rowFive)
	if !reflect.DeepEqual(cells, []int{1, 2, 3, 4, 5}) || counts[tileHeart] != 5 || maxRun != 5 {
		t.Fatalf("row of five: cells=%v counts=%v maxRun=%d", cells, counts, maxRun)
	}

	column := stripedBoard()
	column[21], column[29], column[37] = 4, 4, 4
	cells, counts, maxRun = findMatches(column)
	if !reflect.DeepEqual(cells, []int{21, 29, 37}) || counts[tileShield] != 3 || maxRun != 3 {
		t.Fatalf("column of three: cells=%v counts=%v maxRun=%d", cells, counts, maxRun)
	}
}

func TestFindMatchesSpecialTilesWithBaseTiles(t *testing.T) {
	tests := []struct {
		name         string
		row          [3]int
		wantCounts   map[int]int
		wantBaseTile int
	}{
		{
			name:         "fire sword matches swords",
			row:          [3]int{tileSword, tileFireSword, tileSword},
			wantCounts:   map[int]int{tileSword: 2, tileFireSword: 1},
			wantBaseTile: tileSword,
		},
		{
			name:         "greater heart matches hearts",
			row:          [3]int{tileHeart, tileGreaterHeart, tileHeart},
			wantCounts:   map[int]int{tileHeart: 2, tileGreaterHeart: 1},
			wantBaseTile: tileHeart,
		},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			board := stripedBoard()
			board[56], board[57], board[58] = test.row[0], test.row[1], test.row[2]
			cells, counts, maxRun := findMatches(board)
			if !reflect.DeepEqual(cells, []int{56, 57, 58}) ||
				!reflect.DeepEqual(counts, test.wantCounts) ||
				maxRun != 3 {
				t.Fatalf("cells=%v counts=%v maxRun=%d", cells, counts, maxRun)
			}
			if baseTile(test.row[1]) != test.wantBaseTile {
				t.Fatalf("special tile mapped to base %d, want %d", baseTile(test.row[1]), test.wantBaseTile)
			}
		})
	}
}

func TestComputeExplosions(t *testing.T) {
	swordBoard := func() []int {
		board := make([]int, boardSize)
		for i := range board {
			board[i] = tileSword
		}
		return board
	}

	cross := swordBoard()
	cross[27] = tileLightning
	if got := computeExplosions(cross, map[int]bool{27: true}); !reflect.DeepEqual(got, []int{19, 26, 28, 35}) {
		t.Fatalf("lightning cross: %v", got)
	}

	block := swordBoard()
	block[27] = tileFireSword
	if got := computeExplosions(block, map[int]bool{27: true}); !reflect.DeepEqual(got, []int{18, 19, 20, 26, 28, 34, 35, 36}) {
		t.Fatalf("fire sword 3x3: %v", got)
	}

	corner := swordBoard()
	corner[0] = tileFireSword
	if got := computeExplosions(corner, map[int]bool{0: true}); !reflect.DeepEqual(got, []int{1, 8, 9}) {
		t.Fatalf("fire sword clipped at corner: %v", got)
	}

	plain := swordBoard()
	if got := computeExplosions(plain, map[int]bool{27: true}); len(got) != 0 {
		t.Fatalf("plain tile must not explode: %v", got)
	}
}

func TestApplyTileEffects(t *testing.T) {
	tests := []struct {
		name         string
		attacker     Fighter
		defender     Fighter
		counts       map[int]int
		wantAttacker Fighter
		wantDefender Fighter
		wantEffects  Effects
	}{
		{
			name:         "armor absorbs part of physical",
			attacker:     Fighter{HP: 100},
			defender:     Fighter{HP: 100, Armor: 10},
			counts:       map[int]int{tileSword: 3},
			wantAttacker: Fighter{HP: 100},
			wantDefender: Fighter{HP: 89},
			wantEffects:  Effects{Damage: 11, ArmorDamage: 10},
		},
		{
			name:         "armor absorbs all physical and reflects",
			attacker:     Fighter{HP: 100},
			defender:     Fighter{HP: 100, Armor: 30},
			counts:       map[int]int{tileSword: 3},
			wantAttacker: Fighter{HP: 98},
			wantDefender: Fighter{HP: 100, Armor: 9},
			wantEffects:  Effects{ArmorDamage: 21, Reflect: 2},
		},
		{
			name:         "fire sword pierces armor and triggers reflect",
			attacker:     Fighter{HP: 100},
			defender:     Fighter{HP: 100, Armor: 30},
			counts:       map[int]int{tileFireSword: 1},
			wantAttacker: Fighter{HP: 98},
			wantDefender: Fighter{HP: 88, Armor: 30},
			wantEffects:  Effects{Damage: 12, Reflect: 2},
		},
		{
			name:         "reflect skipped when defender dies",
			attacker:     Fighter{HP: 100},
			defender:     Fighter{HP: 5, Armor: 25},
			counts:       map[int]int{tileFireSword: 1},
			wantAttacker: Fighter{HP: 100},
			wantDefender: Fighter{HP: 0, Armor: 25},
			wantEffects:  Effects{Damage: 12},
		},
		{
			name:         "sword blocked plus fire sword pierces",
			attacker:     Fighter{HP: 100},
			defender:     Fighter{HP: 100, Armor: 10},
			counts:       map[int]int{tileSword: 2, tileFireSword: 1},
			wantAttacker: Fighter{HP: 100},
			wantDefender: Fighter{HP: 84},
			wantEffects:  Effects{Damage: 16, ArmorDamage: 10},
		},
		{
			name:         "lightning deals no direct damage",
			attacker:     Fighter{HP: 100},
			defender:     Fighter{HP: 100, Armor: 5},
			counts:       map[int]int{tileLightning: 3},
			wantAttacker: Fighter{HP: 100},
			wantDefender: Fighter{HP: 100, Armor: 5},
			wantEffects:  Effects{},
		},
		{
			name:         "peach charges fury",
			attacker:     Fighter{HP: 100},
			defender:     Fighter{HP: 100},
			counts:       map[int]int{tilePeach: 3},
			wantAttacker: Fighter{HP: 100, Fury: 30},
			wantDefender: Fighter{HP: 100},
			wantEffects:  Effects{Fury: 30},
		},
		{
			name:         "peach fury capped without consuming",
			attacker:     Fighter{HP: 100, Fury: 95},
			defender:     Fighter{HP: 100},
			counts:       map[int]int{tilePeach: 2},
			wantAttacker: Fighter{HP: 100, Fury: 100},
			wantDefender: Fighter{HP: 100},
			wantEffects:  Effects{Fury: 5},
		},
		{
			name:         "full fury doubles and pierces sword",
			attacker:     Fighter{HP: 100, Fury: 100},
			defender:     Fighter{HP: 100, Armor: 30},
			counts:       map[int]int{tileSword: 3},
			wantAttacker: Fighter{HP: 98, Fury: 0},
			wantDefender: Fighter{HP: 58, Armor: 30},
			wantEffects:  Effects{Damage: 42, Furied: true, Reflect: 2},
		},
		{
			name:         "peach fills and consumes same wave",
			attacker:     Fighter{HP: 100, Fury: 90},
			defender:     Fighter{HP: 100},
			counts:       map[int]int{tilePeach: 1, tileSword: 2},
			wantAttacker: Fighter{HP: 100, Fury: 0},
			wantDefender: Fighter{HP: 72},
			wantEffects:  Effects{Damage: 28, Fury: 10, Furied: true},
		},
		{
			name:         "heal capped at max hp",
			attacker:     Fighter{HP: 195},
			defender:     Fighter{HP: 100},
			counts:       map[int]int{tileHeart: 4},
			wantAttacker: Fighter{HP: 200},
			wantDefender: Fighter{HP: 100},
			wantEffects:  Effects{Heal: 5},
		},
		{
			name:         "greater heart heals more",
			attacker:     Fighter{HP: 100},
			defender:     Fighter{HP: 100},
			counts:       map[int]int{tileHeart: 2, tileGreaterHeart: 1},
			wantAttacker: Fighter{HP: 120},
			wantDefender: Fighter{HP: 100},
			wantEffects:  Effects{Heal: 20},
		},
		{
			name:         "mana capped at max mp",
			attacker:     Fighter{HP: 100, MP: 98},
			defender:     Fighter{HP: 100},
			counts:       map[int]int{tileWater: 3},
			wantAttacker: Fighter{HP: 100, MP: 100},
			wantDefender: Fighter{HP: 100},
			wantEffects:  Effects{Mana: 2},
		},
		{
			name:         "armor gain capped at max armor",
			attacker:     Fighter{HP: 100, Armor: 28},
			defender:     Fighter{HP: 100},
			counts:       map[int]int{tileShield: 3},
			wantAttacker: Fighter{HP: 100, Armor: 30},
			wantDefender: Fighter{HP: 100},
			wantEffects:  Effects{Armor: 2},
		},
		{
			name:         "hp does not go negative",
			attacker:     Fighter{HP: 100},
			defender:     Fighter{HP: 5},
			counts:       map[int]int{tileSword: 5},
			wantAttacker: Fighter{HP: 100},
			wantDefender: Fighter{HP: 0},
			wantEffects:  Effects{Damage: 35},
		},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			attacker, defender := test.attacker, test.defender
			effects := applyTileEffects(&attacker, &defender, test.counts)
			if attacker != test.wantAttacker || defender != test.wantDefender || effects != test.wantEffects {
				t.Fatalf("attacker=%+v defender=%+v effects=%+v", attacker, defender, effects)
			}
		})
	}
}

func TestApplySwapSingleWave(t *testing.T) {
	board := stripedBoard()
	board[56], board[57], board[58], board[59] = 0, 0, 3, 0
	state := stateWith(board, [2]Fighter{{HP: 100}, {HP: 100, MP: 20, Armor: 5}}, 1)

	if err := (Logic{}).ValidateMove(state, 0, json.RawMessage(`{"type":"swap","a":58,"b":59}`)); err != nil {
		t.Fatal(err)
	}
	nextAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"swap","a":58,"b":59}`))
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)

	if next.Steps[0].Kind != "swap" || *next.Steps[0].A != 58 || *next.Steps[0].B != 59 {
		t.Fatalf("unexpected swap step: %+v", next.Steps[0])
	}
	matchStep := next.Steps[1]
	if matchStep.Kind != "match" ||
		!reflect.DeepEqual(matchStep.Cells, []int{56, 57, 58}) ||
		len(matchStep.Exploded) != 0 ||
		!reflect.DeepEqual(matchStep.Counts, map[string]int{"sword": 3}) ||
		matchStep.MaxRun != 3 ||
		*matchStep.Effects != (Effects{Damage: 16, ArmorDamage: 5}) {
		t.Fatalf("unexpected match step: %+v", matchStep)
	}
	if next.MoveCount != 1 {
		t.Fatalf("unexpected move count: %d", next.MoveCount)
	}
	if matchedCells, _, _ := findMatches(next.Board); matchedCells != nil {
		t.Fatal("apply left unresolved matches")
	}
}

func TestShieldReflectAndDecay(t *testing.T) {
	atk := Fighter{HP: 100}
	def := Fighter{HP: 100, Armor: 20}
	eff := applyTileEffects(&atk, &def, map[int]int{tileSword: 2})
	if atk.HP != 98 || def.Armor != 6 || def.HP != 100 || eff.Reflect != 2 || eff.ArmorDamage != 14 {
		t.Fatalf("reflect: atk=%+v def=%+v eff=%+v", atk, def, eff)
	}

	atk2 := Fighter{HP: 100}
	def2 := Fighter{HP: 100, Armor: 19}
	eff2 := applyTileEffects(&atk2, &def2, map[int]int{tileSword: 2})
	if atk2.HP != 100 || eff2.Reflect != 0 {
		t.Fatalf("below threshold reflected: atk=%+v eff=%+v", atk2, eff2)
	}

	board := stripedBoard()
	state := stateWith(board, [2]Fighter{{HP: 100, MP: 60, Armor: 10}, {HP: 100}}, 1)
	nextAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"ult"}`))
	if err != nil {
		t.Fatal(err)
	}
	if next := nextAny.(*State); next.Fighters[0].Armor != 8 {
		t.Fatalf("armor did not decay by 2 on move: %+v", next.Fighters[0])
	}
}

func TestApplySwapLightningExplodes(t *testing.T) {
	board := stripedBoard()
	board[56], board[57], board[59] = 5, 5, 5
	state := stateWith(board, [2]Fighter{{HP: 100}, {HP: 100}}, 1)

	if err := (Logic{}).ValidateMove(state, 0, json.RawMessage(`{"type":"swap","a":58,"b":59}`)); err != nil {
		t.Fatal(err)
	}
	nextAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"swap","a":58,"b":59}`))
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)

	matchStep := next.Steps[1]
	if matchStep.Kind != "match" {
		t.Fatalf("expected match step, got %+v", matchStep)
	}
	if !reflect.DeepEqual(matchStep.Cells, []int{56, 57, 58}) {
		t.Fatalf("unexpected matched cells: %v", matchStep.Cells)
	}
	if !reflect.DeepEqual(matchStep.Exploded, []int{48, 49, 50, 59}) {
		t.Fatalf("unexpected exploded cells: %v", matchStep.Exploded)
	}
	if !reflect.DeepEqual(matchStep.Counts, map[string]int{"lightning": 3, "sword": 2, "peach": 1, "heart": 1}) {
		t.Fatalf("unexpected counts: %v", matchStep.Counts)
	}
	if *matchStep.Effects != (Effects{Damage: 14, Heal: 5, Fury: 10}) {
		t.Fatalf("unexpected effects: %+v", *matchStep.Effects)
	}
	if matchedCells, _, _ := findMatches(next.Board); matchedCells != nil {
		t.Fatal("apply left unresolved matches")
	}
}

func TestApplySwapRunOfFourKeepsTurn(t *testing.T) {
	board := stripedBoard()
	board[56], board[57], board[58], board[59] = 0, 0, 3, 0
	state := stateWith(board, [2]Fighter{{HP: 100}, {HP: 100}}, 1)

	nextAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"swap","a":58,"b":50}`))
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)

	matchStep := next.Steps[1]
	if !reflect.DeepEqual(matchStep.Cells, []int{56, 57, 58, 59}) ||
		!reflect.DeepEqual(matchStep.Counts, map[string]int{"sword": 4}) ||
		matchStep.MaxRun != 4 ||
		*matchStep.Effects != (Effects{Damage: 28}) {
		t.Fatalf("unexpected match step: %+v", matchStep)
	}
	if !next.ExtraTurn || !(Logic{}).KeepTurn(next) {
		t.Fatal("run of four must keep the turn")
	}
}

func TestUltimateScalesWithMana(t *testing.T) {
	board := stripedBoard()
	poor := stateWith(board, [2]Fighter{{HP: 100, MP: 49}, {HP: 100}}, 7)
	if err := (Logic{}).ValidateMove(poor, 0, json.RawMessage(`{"type":"ult"}`)); err == nil {
		t.Fatal("ult without enough mana was accepted")
	}

	state := stateWith(board, [2]Fighter{{HP: 100, MP: 80}, {HP: 100}}, 7)
	if err := (Logic{}).ValidateMove(state, 0, json.RawMessage(`{"type":"ult"}`)); err != nil {
		t.Fatal(err)
	}
	nextAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"ult"}`))
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)
	if next.Fighters != [2]Fighter{{HP: 100, MP: 0}, {HP: 60}} {
		t.Fatalf("unexpected fighters: %+v", next.Fighters)
	}
	if len(next.Steps) != 1 || next.Steps[0].Kind != "ult" || next.Steps[0].Damage != 40 {
		t.Fatalf("unexpected steps: %+v", next.Steps)
	}
	if next.ExtraTurn || next.MoveCount != 1 || next.Rng != "7" {
		t.Fatalf("unexpected state: %+v", next)
	}
	if !reflect.DeepEqual(next.Board, board) {
		t.Fatal("ult must not touch the board")
	}

	lethal := stateWith(board, [2]Fighter{{HP: 100, MP: 50}, {HP: 20}}, 7)
	nextAny, err = (Logic{}).Apply(lethal, 0, json.RawMessage(`{"type":"ult"}`))
	if err != nil {
		t.Fatal(err)
	}
	if over, winner := (Logic{}).Result(nextAny); !over || winner != 0 {
		t.Fatalf("lethal ult: over=%v winner=%d", over, winner)
	}
}

func TestValidateMoveRejects(t *testing.T) {
	state := stateWith(stripedBoard(), [2]Fighter{{HP: 100}, {HP: 100}}, 1)
	tests := []struct {
		name string
		move string
	}{
		{name: "malformed json", move: `{"type":`},
		{name: "missing type", move: `{"a":0,"b":1}`},
		{name: "unknown type", move: `{"type":"bomb"}`},
		{name: "missing cells", move: `{"type":"swap","a":3}`},
		{name: "out of board low", move: `{"type":"swap","a":-1,"b":0}`},
		{name: "out of board high", move: `{"type":"swap","a":63,"b":64}`},
		{name: "same cell", move: `{"type":"swap","a":5,"b":5}`},
		{name: "not adjacent", move: `{"type":"swap","a":0,"b":2}`},
		{name: "row wrap", move: `{"type":"swap","a":7,"b":8}`},
		{name: "no match created", move: `{"type":"swap","a":0,"b":1}`},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			if err := (Logic{}).ValidateMove(state, 0, json.RawMessage(test.move)); err == nil {
				t.Fatal("invalid move was accepted")
			}
		})
	}
}

func TestEnsurePlayableShufflesDeadBoard(t *testing.T) {
	dead := noMoveBoard()
	if matchedCells, _, _ := findMatches(dead); matchedCells != nil {
		t.Fatal("dead board must not contain matches")
	}
	if len(ValidSwaps(dead)) != 0 {
		t.Fatal("dead board must not have valid swaps")
	}

	state := stateWith(dead, [2]Fighter{{HP: 100}, {HP: 100}}, 3)
	r := &rng{z: 3}
	ensurePlayable(state, r)
	if len(state.Steps) != 1 || state.Steps[0].Kind != "shuffle" {
		t.Fatalf("unexpected steps: %+v", state.Steps)
	}
	if !reflect.DeepEqual(state.Steps[0].Board, state.Board) {
		t.Fatal("shuffle step must carry the new board")
	}
	if matchedCells, _, _ := findMatches(state.Board); matchedCells != nil {
		t.Fatal("shuffled board has pre-existing matches")
	}
	if len(ValidSwaps(state.Board)) == 0 {
		t.Fatal("shuffled board has no valid swaps")
	}

	alive := stateWith(stripedBoard(), [2]Fighter{{HP: 100}, {HP: 100}}, 3)
	alive.Board[56], alive.Board[57], alive.Board[58], alive.Board[59] = 0, 0, 3, 0
	ensurePlayable(alive, &rng{z: 3})
	if len(alive.Steps) != 0 {
		t.Fatal("playable board must not be shuffled")
	}
}

func TestApplyDoesNotMutatePreviousState(t *testing.T) {
	board := stripedBoard()
	board[56], board[57], board[58], board[59] = 0, 0, 3, 0
	state := stateWith(board, [2]Fighter{{HP: 100}, {HP: 100, MP: 20, Armor: 5}}, 1)
	before, err := json.Marshal(state)
	if err != nil {
		t.Fatal(err)
	}
	nextAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"swap","a":58,"b":59}`))
	if err != nil {
		t.Fatal(err)
	}
	if nextAny.(*State) == state {
		t.Fatal("Apply returned the same state pointer")
	}
	after, err := json.Marshal(state)
	if err != nil {
		t.Fatal(err)
	}
	if string(before) != string(after) {
		t.Fatalf("Apply mutated the previous state: before=%s after=%s", before, after)
	}
}

func TestDecodeStateRoundtrip(t *testing.T) {
	initial := (Logic{}).Init(5).(*State)
	swap := ValidSwaps(initial.Board)[0]
	move := fmt.Sprintf(`{"type":"swap","a":%d,"b":%d}`, swap[0], swap[1])
	nextAny, err := (Logic{}).Apply(initial, 0, json.RawMessage(move))
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)
	if len(next.Steps) == 0 {
		t.Fatal("Apply produced no steps")
	}
	data, err := json.Marshal(next)
	if err != nil {
		t.Fatal(err)
	}
	restoredAny, err := (Logic{}).DecodeState(data)
	if err != nil {
		t.Fatal(err)
	}
	restored := restoredAny.(*State)
	if restored.Steps != nil {
		t.Fatal("DecodeState must clear steps")
	}
	if !reflect.DeepEqual(restored.Board, next.Board) ||
		restored.Fighters != next.Fighters ||
		restored.Rng != next.Rng ||
		restored.MoveCount != next.MoveCount ||
		restored.ExtraTurn != next.ExtraTurn {
		t.Fatalf("roundtrip mismatch: %+v vs %+v", restored, next)
	}
}

func snapshotWith(update func(*State)) json.RawMessage {
	state := (Logic{}).Init(5).(*State)
	update(state)
	data, err := json.Marshal(state)
	if err != nil {
		panic(err)
	}
	return data
}

func TestDecodeStateRejectsInvalidSnapshots(t *testing.T) {
	tests := []struct {
		name string
		data json.RawMessage
	}{
		{name: "malformed json", data: json.RawMessage(`{"board":`)},
		{name: "wrong board size", data: snapshotWith(func(s *State) { s.Board = s.Board[:63] })},
		{name: "tile too high", data: snapshotWith(func(s *State) { s.Board[0] = tileCount })},
		{name: "tile negative", data: snapshotWith(func(s *State) { s.Board[0] = -1 })},
		{name: "board with match", data: snapshotWith(func(s *State) {
			s.Board[0], s.Board[1], s.Board[2] = 0, 0, 0
		})},
		{name: "board without moves", data: snapshotWith(func(s *State) { s.Board = noMoveBoard() })},
		{name: "hp zero", data: snapshotWith(func(s *State) { s.Fighters[1].HP = 0 })},
		{name: "hp above max", data: snapshotWith(func(s *State) { s.Fighters[0].HP = maxHP + 1 })},
		{name: "mp above max", data: snapshotWith(func(s *State) { s.Fighters[0].MP = maxMP + 1 })},
		{name: "mp negative", data: snapshotWith(func(s *State) { s.Fighters[0].MP = -1 })},
		{name: "armor above max", data: snapshotWith(func(s *State) { s.Fighters[1].Armor = maxArmor + 1 })},
		{name: "armor negative", data: snapshotWith(func(s *State) { s.Fighters[1].Armor = -1 })},
		{name: "fury above max", data: snapshotWith(func(s *State) { s.Fighters[0].Fury = maxFury + 1 })},
		{name: "fury negative", data: snapshotWith(func(s *State) { s.Fighters[0].Fury = -1 })},
		{name: "negative move count", data: snapshotWith(func(s *State) { s.MoveCount = -1 })},
		{name: "empty rng", data: snapshotWith(func(s *State) { s.Rng = "" })},
		{name: "non numeric rng", data: snapshotWith(func(s *State) { s.Rng = "abc" })},
		{name: "overflow rng", data: snapshotWith(func(s *State) { s.Rng = "18446744073709551616" })},
	}
	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			if _, err := (Logic{}).DecodeState(test.data); err == nil {
				t.Fatal("invalid snapshot was accepted")
			}
		})
	}

	if _, err := (Logic{}).DecodeState(snapshotWith(func(s *State) { s.Fighters[0].HP = 0 })); err == nil ||
		err.Error() != "completed war-god state cannot be restored as active" {
		t.Fatalf("unexpected completed-state error: %v", err)
	}
}

func TestResult(t *testing.T) {
	alive := &State{Fighters: [2]Fighter{{HP: 30}, {HP: 1}}}
	if over, winner := (Logic{}).Result(alive); over || winner != -1 {
		t.Fatalf("alive: over=%v winner=%d", over, winner)
	}
	firstDead := &State{Fighters: [2]Fighter{{HP: 0}, {HP: 40}}}
	if over, winner := (Logic{}).Result(firstDead); !over || winner != 1 {
		t.Fatalf("first dead: over=%v winner=%d", over, winner)
	}
	secondDead := &State{Fighters: [2]Fighter{{HP: 40}, {HP: 0}}}
	if over, winner := (Logic{}).Result(secondDead); !over || winner != 0 {
		t.Fatalf("second dead: over=%v winner=%d", over, winner)
	}
}

func TestLogicMetadata(t *testing.T) {
	gameLogic := Logic{}
	if gameLogic.ID() != "war-god" {
		t.Fatalf("unexpected id: %s", gameLogic.ID())
	}
	if gameLogic.StateVersion() != 2 {
		t.Fatalf("unexpected state version: %d", gameLogic.StateVersion())
	}
	if !gameLogic.TimeoutSkipsTurn() {
		t.Fatal("timeout must skip the turn")
	}
	if gameLogic.MoveCount(&State{MoveCount: 4}) != 4 || gameLogic.MoveCount(nil) != 0 {
		t.Fatal("unexpected move count")
	}
	if gameLogic.KeepTurn(&State{ExtraTurn: true}) != true || gameLogic.KeepTurn(nil) {
		t.Fatal("unexpected keep turn")
	}
}

func TestGravityStepAlwaysSerializesFalls(t *testing.T) {
	gravity := Step{Kind: stepGravity, Falls: []Fall{}, Spawns: []Spawn{{Index: 0, Type: 1, FromRow: -1}}}
	data, err := json.Marshal(gravity)
	if err != nil {
		t.Fatal(err)
	}
	var decoded map[string]json.RawMessage
	if err := json.Unmarshal(data, &decoded); err != nil {
		t.Fatal(err)
	}
	if string(decoded["falls"]) != "[]" {
		t.Fatalf("gravity step must carry empty falls array: %s", data)
	}
	if string(decoded["spawns"]) == "" {
		t.Fatalf("gravity step must carry spawns: %s", data)
	}
	swap := Step{Kind: stepSwap, A: intPtr(0), B: intPtr(1)}
	swapData, err := json.Marshal(swap)
	if err != nil {
		t.Fatal(err)
	}
	var swapDecoded map[string]json.RawMessage
	if err := json.Unmarshal(swapData, &swapDecoded); err != nil {
		t.Fatal(err)
	}
	if _, ok := swapDecoded["falls"]; ok {
		t.Fatalf("swap step must omit nil falls: %s", swapData)
	}
}
