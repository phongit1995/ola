package wargod

import (
	"encoding/json"
	"fmt"
	"reflect"
	"sort"
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
		Board:          append([]int(nil), board...),
		Fighters:       fighters,
		Rng:            strconv.FormatUint(seed, 10),
		ExtraTurnOwner: -1,
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
		// ~1/60 target: band [1/75, 1/50] bắt được lệch như 1/81 (Tim cũ) hay 1/45.
		if rate < samples/75 || rate > samples/50 {
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
	if first.Fighters != expectedFighters || first.MoveCount != 0 || first.ExtraTurn ||
		first.ExtraTurns != 0 || first.ExtraTurnOwner != -1 {
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

func doubleRunFourBoard() []int {
	board := stripedBoard()
	// Swap 18<->26 completes two separate maximal runs of four:
	// row 2 cells 16..19 are Swords; row 3 cells 25..28 are Water.
	board[16], board[17], board[19] = tileSword, tileSword, tileSword
	board[18] = tileWater
	board[20] = tileShield
	board[25], board[27], board[28] = tileWater, tileWater, tileWater
	board[26] = tileSword
	board[29] = tileShield
	return board
}

func TestMatchBonusTurnsCountsDistinctLongRuns(t *testing.T) {
	rowFive := stripedBoard()
	for i := 1; i <= 5; i++ {
		rowFive[i] = tileHeart
	}
	cells, _, _ := findMatches(rowFive)
	if got := matchBonusTurns(rowFive, cells); got != 1 {
		t.Fatalf("one run of five earned %d turns, want 1", got)
	}

	double := doubleRunFourBoard()
	if cells, _, _ := findMatches(double); cells != nil {
		t.Fatalf("double-run board must be match-free before swap: %v", cells)
	}
	double[18], double[26] = double[26], double[18]
	cells, _, _ = findMatches(double)
	if got := matchBonusTurns(double, cells); got != 2 {
		t.Fatalf("two runs of four earned %d turns, want 2 (cells=%v)", got, cells)
	}

	twoTriples := doubleMatchBoard()
	twoTriples[18], twoTriples[19] = twoTriples[19], twoTriples[18]
	cells, _, _ = findMatches(twoTriples)
	if got := matchBonusTurns(twoTriples, cells); got != 0 {
		t.Fatalf("cascade wave made only from triples earned %d turns, want 0", got)
	}

	tShape := stripedBoard()
	for _, index := range []int{19, 26, 27, 28, 35} {
		tShape[index] = tileLightning
	}
	cells, _, maxRun := findMatches(tShape)
	if len(cells) != 5 || maxRun != 3 {
		t.Fatalf("invalid T-shape fixture: cells=%v maxRun=%d", cells, maxRun)
	}
	if got := matchBonusTurns(tShape, cells); got != 1 {
		t.Fatalf("connected T-shape of five earned %d turns, want 1", got)
	}
}

func TestCascadeWaveBonusRequiresRunOfFour(t *testing.T) {
	tests := []struct {
		name string
		run  int
		want int
	}{
		{name: "three", run: 3, want: 0},
		{name: "four", run: 4, want: 1},
		{name: "five", run: 5, want: 1},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			board := stripedBoard()
			for x := 0; x < tt.run; x++ {
				board[(grid-1)*grid+x] = tileLightning
			}
			cells, _, maxRun := findMatches(board)
			if len(cells) != tt.run || maxRun != tt.run {
				t.Fatalf("invalid cascade fixture: cells=%v maxRun=%d", cells, maxRun)
			}
			if got := matchBonusTurns(board, cells); got != tt.want {
				t.Fatalf("cascade run %d earned %d turns, want %d", tt.run, got, tt.want)
			}
		})
	}
}

func TestApplyResolvesDeterministicMultiWaveCascade(t *testing.T) {
	state := (Logic{}).Init(1).(*State)
	move := json.RawMessage(`{"type":"swap","a":41,"b":42}`)
	if err := (Logic{}).ValidateMove(state, 0, move); err != nil {
		t.Fatal(err)
	}

	nextAny, err := (Logic{}).Apply(state, 0, move)
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)
	wantKinds := []string{stepSwap, stepMatch, stepGravity, stepMatch, stepGravity, stepMatch, stepGravity}
	if got := stepKinds(next.Steps); !reflect.DeepEqual(got, wantKinds) {
		t.Fatalf("cascade steps=%v, want %v", got, wantKinds)
	}

	matchSteps := []Step{next.Steps[1], next.Steps[3], next.Steps[5]}
	if got := []int{matchSteps[0].CascadeLevel, matchSteps[1].CascadeLevel, matchSteps[2].CascadeLevel}; !reflect.DeepEqual(got, []int{0, 1, 2}) {
		t.Fatalf("cascade levels=%v, want [0 1 2]", got)
	}
	if !reflect.DeepEqual(matchSteps[0].Cells, []int{25, 33, 34, 41, 42, 50}) || matchSteps[0].BonusTurns != 0 {
		t.Fatalf("first wave should be separate triples without a bonus: %+v", matchSteps[0])
	}
	if !reflect.DeepEqual(matchSteps[1].Cells, []int{42, 43, 44, 48, 49, 50}) || matchSteps[1].BonusTurns != 1 {
		t.Fatalf("second wave should award one turn for its connected 6-cell group: %+v", matchSteps[1])
	}
	if !reflect.DeepEqual(matchSteps[2].Cells, []int{1, 9, 17}) || matchSteps[2].BonusTurns != 0 {
		t.Fatalf("third wave should be a triple without a bonus: %+v", matchSteps[2])
	}
	if next.ExtraTurns != 1 || !next.ExtraTurn || next.ExtraTurnOwner != 0 || !(Logic{}).KeepTurn(next) {
		t.Fatalf("cascade bonus was not banked for the acting player: %+v", next)
	}
	if cells, _, _ := findMatches(next.Board); cells != nil {
		t.Fatalf("cascade left unresolved matches: %v", cells)
	}
}

func TestApplyGravityCompactsColumnsAndReportsMovement(t *testing.T) {
	board := stripedBoard()
	original := append([]int(nil), board...)
	removed := map[int]bool{18: true, 42: true, 58: true}
	fallWant := []Fall{
		{From: 50, To: 58},
		{From: 34, To: 50},
		{From: 26, To: 42},
		{From: 10, To: 34},
		{From: 2, To: 26},
	}
	spawnLocations := []Spawn{
		{Index: 18, FromRow: -1},
		{Index: 10, FromRow: -2},
		{Index: 2, FromRow: -3},
	}

	falls, spawns := applyGravity(board, removed, &rng{z: 17})
	if !reflect.DeepEqual(falls, fallWant) {
		t.Fatalf("falls=%v, want %v", falls, fallWant)
	}
	if len(spawns) != len(spawnLocations) {
		t.Fatalf("spawns=%v, want %d entries", spawns, len(spawnLocations))
	}
	for i, want := range spawnLocations {
		got := spawns[i]
		if got.Index != want.Index || got.FromRow != want.FromRow || got.Type < 0 || got.Type >= tileCount {
			t.Fatalf("spawn #%d=%+v, want index=%d fromRow=%d and a valid tile", i, got, want.Index, want.FromRow)
		}
		if board[got.Index] != got.Type {
			t.Fatalf("spawn #%d reports type %d but board contains %d", i, got.Type, board[got.Index])
		}
	}
	for _, fall := range fallWant {
		if board[fall.To] != original[fall.From] {
			t.Fatalf("fall %+v lost tile %d; target contains %d", fall, original[fall.From], board[fall.To])
		}
	}
	for i := range board {
		if i%grid != 2 && board[i] != original[i] {
			t.Fatalf("gravity changed untouched cell %d from %d to %d", i, original[i], board[i])
		}
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

	lightning := swordBoard()
	lightning[27] = tileLightning
	r1, r2 := &rng{z: 7}, &rng{z: 7}
	got, arcs := computeExplosions(lightning, map[int]bool{27: true}, r1)
	gotAgain, arcsAgain := computeExplosions(lightning, map[int]bool{27: true}, r2)
	if !reflect.DeepEqual(got, gotAgain) || !reflect.DeepEqual(arcs, arcsAgain) || r1.z != r2.z {
		t.Fatalf("lightning targets are not deterministic: got=%v/%v again=%v/%v", got, arcs, gotAgain, arcsAgain)
	}
	if len(got) != 1 || len(arcs) != 1 {
		t.Fatalf("one matched lightning must eat one cell: exploded=%v arcs=%v", got, arcs)
	}
	seen := map[int]bool{}
	for _, arc := range arcs {
		if arc.Source != 27 || arc.Target == 27 || arc.Target < 0 || arc.Target >= boardSize || seen[arc.Target] {
			t.Fatalf("invalid lightning arc: %+v (all=%v)", arc, arcs)
		}
		seen[arc.Target] = true
	}
	for _, target := range got {
		if !seen[target] {
			t.Fatalf("exploded cell %d has no lightning arc: %v", target, arcs)
		}
	}

	block := swordBoard()
	block[27] = tileFireSword
	if got, arcs := computeExplosions(block, map[int]bool{27: true}, &rng{z: 1}); !reflect.DeepEqual(got, []int{18, 19, 20, 26, 28, 34, 35, 36}) || len(arcs) != 0 {
		t.Fatalf("fire sword 3x3: %v", got)
	}

	chained := swordBoard()
	chained[0], chained[27], chained[28] = tileLightning, tileFireSword, tileLightning
	chainedExploded, chainedArcs := computeExplosionsWithPicker(chained, map[int]bool{27: true}, func(int) int { return 0 })
	chainedBlast := map[int]bool{18: true, 19: true, 20: true, 26: true, 28: true, 34: true, 35: true, 36: true}
	if len(chainedExploded) != len(chainedBlast)+1 || len(chainedArcs) != 1 {
		t.Fatalf("fire sword must trigger lightning caught in its blast: exploded=%v arcs=%v", chainedExploded, chainedArcs)
	}
	if chainedArcs[0].Source != 28 || chainedArcs[0].Target != 0 || chainedBlast[chainedArcs[0].Target] || chainedArcs[0].Target == 27 {
		t.Fatalf("invalid fire-to-lightning chain: %+v", chainedArcs[0])
	}
	foundChainedTarget := false
	for _, index := range chainedExploded {
		if index == chainedArcs[0].Target {
			foundChainedTarget = true
			break
		}
	}
	if !foundChainedTarget {
		t.Fatalf("lightning target %d is missing from exploded=%v", chainedArcs[0].Target, chainedExploded)
	}

	mixedChain := swordBoard()
	mixedChain[10], mixedChain[27], mixedChain[28] = tileLightning, tileFireSword, tileLightning
	mixedChainMatch := map[int]bool{10: true, 27: true}
	mixedChainExploded, mixedChainArcs := computeExplosionsWithPicker(mixedChain, mixedChainMatch, func(int) int { return 0 })
	if len(mixedChainArcs) != 2 || mixedChainArcs[0].Source != 10 || mixedChainArcs[1].Source != 28 {
		t.Fatalf("direct and fire-triggered lightning must each fire once: %v", mixedChainArcs)
	}
	if mixedChainArcs[0].Target == mixedChainArcs[1].Target {
		t.Fatalf("direct and fire-triggered lightning targets must be unique: %v", mixedChainArcs)
	}
	for _, arc := range mixedChainArcs {
		if mixedChainMatch[arc.Target] || chainedBlast[arc.Target] {
			t.Fatalf("mixed lightning targeted an existing removal: arcs=%v exploded=%v", mixedChainArcs, mixedChainExploded)
		}
	}

	overlap := swordBoard()
	overlap[26], overlap[27], overlap[28] = tileFireSword, tileLightning, tileFireSword
	_, overlapArcs := computeExplosionsWithPicker(overlap, map[int]bool{26: true, 28: true}, func(int) int { return 0 })
	if len(overlapArcs) != 1 || overlapArcs[0].Source != 27 {
		t.Fatalf("overlapping fire blasts must trigger one arc per lightning: %v", overlapArcs)
	}

	corner := swordBoard()
	corner[0] = tileFireSword
	if got, arcs := computeExplosions(corner, map[int]bool{0: true}, &rng{z: 1}); !reflect.DeepEqual(got, []int{1, 8, 9}) || len(arcs) != 0 {
		t.Fatalf("fire sword clipped at corner: %v", got)
	}

	plain := swordBoard()
	if got, arcs := computeExplosions(plain, map[int]bool{27: true}, &rng{z: 1}); len(got) != 0 || len(arcs) != 0 {
		t.Fatalf("plain tile must not explode: %v", got)
	}

	multiple := swordBoard()
	for _, i := range []int{26, 27, 28} {
		multiple[i] = tileLightning
	}
	_, arcs = computeExplosions(multiple, map[int]bool{26: true, 27: true, 28: true}, &rng{z: 11})
	wantSources := []int{26, 27, 28}
	for i, arc := range arcs {
		if arc.Source != wantSources[i] {
			t.Fatalf("lightning sources are not distributed round-robin: %v", arcs)
		}
	}
	four := swordBoard()
	fourMatch := map[int]bool{}
	for _, i := range []int{25, 26, 27, 28} {
		four[i] = tileLightning
		fourMatch[i] = true
	}
	fourExploded, fourArcs := computeExplosions(four, fourMatch, &rng{z: 13})
	if len(fourExploded) != 4 || len(fourArcs) != 4 {
		t.Fatalf("four matched lightning tiles must eat four cells: exploded=%v arcs=%v", fourExploded, fourArcs)
	}

	mixed := swordBoard()
	mixed[27], mixed[28] = tileFireSword, tileLightning
	mixedMatch := map[int]bool{27: true, 28: true}
	mixedExploded, mixedArcs := computeExplosions(mixed, mixedMatch, &rng{z: 19})
	fireArea := map[int]bool{18: true, 19: true, 20: true, 26: true, 34: true, 35: true, 36: true}
	if len(mixedExploded) != len(fireArea)+1 || len(mixedArcs) != 1 {
		t.Fatalf("mixed wave did not add one target for one lightning: exploded=%v arcs=%v", mixedExploded, mixedArcs)
	}
	for _, arc := range mixedArcs {
		if fireArea[arc.Target] || mixedMatch[arc.Target] {
			t.Fatalf("lightning wasted a target in an existing removal: %+v", arc)
		}
	}

	nearlyFull := make([]int, boardSize)
	nearlyFullMatch := map[int]bool{}
	for i := 0; i < boardSize-2; i++ {
		nearlyFull[i] = tileLightning
		nearlyFullMatch[i] = true
	}
	limited, limitedArcs := computeExplosions(nearlyFull, nearlyFullMatch, &rng{z: 23})
	if !reflect.DeepEqual(limited, []int{62, 63}) || len(limitedArcs) != 2 {
		t.Fatalf("lightning must safely use the remaining target pool: exploded=%v arcs=%v", limited, limitedArcs)
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
			name:         "peach fills but does not consume same wave",
			attacker:     Fighter{HP: 100, Fury: 90},
			defender:     Fighter{HP: 100},
			counts:       map[int]int{tilePeach: 1, tileSword: 2},
			wantAttacker: Fighter{HP: 100, Fury: 100},
			wantDefender: Fighter{HP: 86},
			wantEffects:  Effects{Damage: 14, Fury: 10},
		},
		{
			name:         "full fury consumes then peach recharges",
			attacker:     Fighter{HP: 100, Fury: 100},
			defender:     Fighter{HP: 100},
			counts:       map[int]int{tileSword: 2, tilePeach: 1},
			wantAttacker: Fighter{HP: 100, Fury: 10},
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

func TestCascadeScalesEveryCollectedTileValueAndCapsAtThirtyPercent(t *testing.T) {
	tests := []struct {
		level int
		want  Effects
	}{
		{level: 0, want: Effects{Damage: 21, Heal: 15, Mana: 21, Armor: 15, Fury: 30}},
		{level: 1, want: Effects{Damage: 23, Heal: 17, Mana: 23, Armor: 17, Fury: 33}},
		{level: 2, want: Effects{Damage: 25, Heal: 18, Mana: 25, Armor: 18, Fury: 36}},
		{level: 3, want: Effects{Damage: 27, Heal: 20, Mana: 27, Armor: 20, Fury: 39}},
		{level: 4, want: Effects{Damage: 27, Heal: 20, Mana: 27, Armor: 20, Fury: 39}},
	}
	counts := map[int]int{
		tileSword: 3, tileHeart: 3, tileWater: 3, tileShield: 3, tilePeach: 3,
	}
	for _, test := range tests {
		t.Run(fmt.Sprintf("level_%d", test.level), func(t *testing.T) {
			attacker := Fighter{HP: 100}
			defender := Fighter{HP: maxHP}
			got := applyTileEffectsAtCascade(&attacker, &defender, counts, test.level)
			if got != test.want {
				t.Fatalf("effects=%+v, want %+v", got, test.want)
			}
		})
	}

	attacker := Fighter{HP: maxHP}
	defender := Fighter{HP: maxHP, Armor: maxArmor}
	reflected := applyTileEffectsAtCascade(
		&attacker,
		&defender,
		map[int]int{tileSword: 3},
		maximumCascadeLevel,
	)
	if reflected.Reflect != reflectDamage {
		t.Fatalf("fixed reflect damage was scaled: %+v", reflected)
	}
}

func TestFullFuryDoublesSwordDamageForEntireCascadeChain(t *testing.T) {
	attacker := Fighter{HP: maxHP, Fury: maxFury}
	defender := Fighter{HP: maxHP}
	furyChainActive := false
	counts := map[int]int{tileSword: 3}

	firstWave := applyTileEffectsInCascadeChain(
		&attacker, &defender, counts, 0, &furyChainActive,
	)
	firstCascade := applyTileEffectsInCascadeChain(
		&attacker, &defender, counts, 1, &furyChainActive,
	)
	secondCascade := applyTileEffectsInCascadeChain(
		&attacker, &defender, counts, 2, &furyChainActive,
	)

	if !firstWave.Furied || firstWave.Damage != 42 {
		t.Fatalf("first wave effects=%+v, want 42 damage with Fury activation", firstWave)
	}
	if firstCascade.Damage != 46 || secondCascade.Damage != 50 {
		t.Fatalf(
			"cascade damage=(%d, %d), want (46, 50)",
			firstCascade.Damage,
			secondCascade.Damage,
		)
	}
	if attacker.Fury != 0 || defender.HP != 62 || !furyChainActive {
		t.Fatalf(
			"attacker=%+v defender=%+v furyChainActive=%v",
			attacker,
			defender,
			furyChainActive,
		)
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
	state := stateWith(board, [2]Fighter{{HP: 100, MP: 100, Armor: 10}, {HP: 100}}, 1)
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
	if len(matchStep.Exploded) != 3 || len(matchStep.LightningArcs) != 3 {
		t.Fatalf("three lightning tiles must eat three random cells: exploded=%v arcs=%v", matchStep.Exploded, matchStep.LightningArcs)
	}
	wantSources := []int{56, 57, 58}
	wantExploded := make([]int, 0, 3)
	wantCounts := map[int]int{tileLightning: 3}
	swapped := append([]int(nil), board...)
	swapped[58], swapped[59] = swapped[59], swapped[58]
	seen := map[int]bool{}
	for i, arc := range matchStep.LightningArcs {
		if arc.Source != wantSources[i] || arc.Target < 0 || arc.Target >= boardSize || seen[arc.Target] {
			t.Fatalf("invalid lightning arc mapping: %v", matchStep.LightningArcs)
		}
		if arc.Target == 56 || arc.Target == 57 || arc.Target == 58 {
			t.Fatalf("lightning targeted a matched cell: %v", matchStep.LightningArcs)
		}
		seen[arc.Target] = true
		wantExploded = append(wantExploded, arc.Target)
		wantCounts[swapped[arc.Target]]++
	}
	sort.Ints(wantExploded)
	if !reflect.DeepEqual(matchStep.Exploded, wantExploded) {
		t.Fatalf("exploded cells do not match arcs: exploded=%v arcs=%v", matchStep.Exploded, matchStep.LightningArcs)
	}
	if !reflect.DeepEqual(matchStep.Counts, namedCounts(wantCounts)) {
		t.Fatalf("unexpected counts: %v", matchStep.Counts)
	}
	wantAttacker, wantDefender := Fighter{HP: 100}, Fighter{HP: 100}
	wantEffects := applyTileEffects(&wantAttacker, &wantDefender, wantCounts)
	if *matchStep.Effects != wantEffects {
		t.Fatalf("unexpected effects: %+v", *matchStep.Effects)
	}
	encoded, err := json.Marshal(matchStep)
	if err != nil {
		t.Fatal(err)
	}
	decoded := Step{}
	if err := json.Unmarshal(encoded, &decoded); err != nil {
		t.Fatal(err)
	}
	if !reflect.DeepEqual(decoded.LightningArcs, matchStep.LightningArcs) {
		t.Fatalf("lightning arc mapping did not survive JSON: got=%v want=%v", decoded.LightningArcs, matchStep.LightningArcs)
	}
	againAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"swap","a":58,"b":59}`))
	if err != nil {
		t.Fatal(err)
	}
	again := againAny.(*State)
	if !reflect.DeepEqual(again.Steps, next.Steps) || again.Rng != next.Rng || !reflect.DeepEqual(again.Board, next.Board) {
		t.Fatal("same state and move produced different lightning targets or final state")
	}
	if matchedCells, _, _ := findMatches(next.Board); matchedCells != nil {
		t.Fatal("apply left unresolved matches")
	}
}

func TestApplySwapFourLightningHitsFourTargets(t *testing.T) {
	board := stripedBoard()
	board[50], board[56], board[57], board[59] = tileLightning, tileLightning, tileLightning, tileLightning
	state := stateWith(board, [2]Fighter{{HP: 100}, {HP: 100}}, 17)

	nextAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"swap","a":58,"b":50}`))
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)
	matchStep := next.Steps[1]
	if !reflect.DeepEqual(matchStep.Cells, []int{56, 57, 58, 59}) {
		t.Fatalf("unexpected four-lightning match: %v", matchStep.Cells)
	}
	if len(matchStep.Exploded) != 4 || len(matchStep.LightningArcs) != 4 {
		t.Fatalf("four lightning tiles must eat four targets: exploded=%v arcs=%v", matchStep.Exploded, matchStep.LightningArcs)
	}
	for i, arc := range matchStep.LightningArcs {
		if arc.Source != matchStep.Cells[i] {
			t.Fatalf("each matched lightning must fire once: cells=%v arcs=%v", matchStep.Cells, matchStep.LightningArcs)
		}
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

func TestApplySwapTwoRunsBanksTwoTurns(t *testing.T) {
	board := doubleRunFourBoard()
	state := stateWith(board, [2]Fighter{{HP: 100}, {HP: 1}}, 1)

	nextAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"swap","a":18,"b":26}`))
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)
	matchStep := next.Steps[1]
	if matchStep.Kind != stepMatch || matchStep.BonusTurns != 2 {
		t.Fatalf("two simultaneous runs must earn two turns: %+v", matchStep)
	}
	if next.ExtraTurns != 2 || !next.ExtraTurn || next.ExtraTurnOwner != 0 || !(Logic{}).KeepTurn(next) {
		t.Fatalf("unexpected two-turn bank: %+v", next)
	}
}

func TestApplyConsumesOneBankedTurnPerAction(t *testing.T) {
	state := stateWith(
		stripedBoard(),
		[2]Fighter{{HP: 100, MP: 100}, {HP: 100}},
		7,
	)
	state.ExtraTurn = true
	state.ExtraTurns = 2
	state.ExtraTurnOwner = 0

	firstAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"ult"}`))
	if err != nil {
		t.Fatal(err)
	}
	first := firstAny.(*State)
	if first.ExtraTurns != 1 || !first.ExtraTurn || first.ExtraTurnOwner != 0 || !(Logic{}).KeepTurn(first) {
		t.Fatalf("first bonus action did not leave one turn: %+v", first)
	}

	first.Fighters[0].MP = 100
	secondAny, err := (Logic{}).Apply(first, 0, json.RawMessage(`{"type":"ult"}`))
	if err != nil {
		t.Fatal(err)
	}
	second := secondAny.(*State)
	if second.ExtraTurns != 0 || second.ExtraTurn || second.ExtraTurnOwner != -1 || (Logic{}).KeepTurn(second) {
		t.Fatalf("second bonus action did not exhaust the bank: %+v", second)
	}
}

func TestTurnSkipClearsBankedTurns(t *testing.T) {
	state := stateWith(stripedBoard(), [2]Fighter{{HP: 100}, {HP: 100}}, 7)
	state.ExtraTurn = true
	state.ExtraTurns = 2
	state.ExtraTurnOwner = 0

	(Logic{}).OnTurnSkipped(state, 1)
	if !state.ExtraTurn || state.ExtraTurns != 2 || state.ExtraTurnOwner != 0 || !(Logic{}).KeepTurn(state) {
		t.Fatalf("another player's skip consumed the owner's bonus turns: %+v", state)
	}

	(Logic{}).OnTurnSkipped(state, 0)
	if state.ExtraTurn || state.ExtraTurns != 0 || state.ExtraTurnOwner != -1 || (Logic{}).KeepTurn(state) {
		t.Fatalf("turn skip left bonus turns behind: %+v", state)
	}

	legacy := stateWith(stripedBoard(), [2]Fighter{{HP: 100}, {HP: 100}}, 8)
	legacy.ExtraTurn = true
	(Logic{}).OnTurnSkipped(legacy, 1)
	if legacy.ExtraTurn || legacy.ExtraTurns != 0 || legacy.ExtraTurnOwner != -1 {
		t.Fatalf("legacy extra-turn flag survived a skip: %+v", legacy)
	}

	(Logic{}).OnTurnSkipped(nil, 0)
	(Logic{}).OnTurnSkipped("not a war-god state", 0)
}

func doubleMatchBoard() []int {
	board := make([]int, boardSize)
	for y := 0; y < grid; y++ {
		for x := 0; x < grid; x++ {
			// (x+2y)%6: hàng ngang lệch 1, hàng dọc lệch 2 → không bao giờ có 3 ô
			// liền kề trùng nhau, nền hoàn toàn sạch match.
			board[y*grid+x] = (x + 2*y) % 6
		}
	}
	// Đổi ô 18<->19 sẽ hoàn tất đồng thời 2 cụm 3 rời nhau (6 ô, maxRun 3):
	//   cột 2 (10,18,26) thành Kiếm ; hàng 2 (19,20,21) thành Nước.
	board[10], board[26] = tileSword, tileSword // 18 do swap điền vào
	board[18] = tileWater
	board[19] = tileSword // được swap sang 18
	board[20] = tileWater // 21 vốn đã là Nước theo nền
	return board
}

func TestApplySwapSeparateTriplesDoesNotKeepTurn(t *testing.T) {
	board := doubleMatchBoard()
	if matchedCells, _, _ := findMatches(board); matchedCells != nil {
		t.Fatalf("board must be match-free before swap: %v", matchedCells)
	}
	state := stateWith(board, [2]Fighter{{HP: 100}, {HP: 100}}, 1)
	if err := (Logic{}).ValidateMove(state, 0, json.RawMessage(`{"type":"swap","a":18,"b":19}`)); err != nil {
		t.Fatal(err)
	}
	nextAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"swap","a":18,"b":19}`))
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)

	matchStep := next.Steps[1]
	if matchStep.Kind != "match" ||
		!reflect.DeepEqual(matchStep.Cells, []int{10, 18, 19, 20, 21, 26}) ||
		matchStep.MaxRun != 3 {
		t.Fatalf("expected a 6-cell maxRun-3 match: %+v", matchStep)
	}
	if matchStep.BonusTurns != 0 || next.ExtraTurns != 0 || next.ExtraTurn || (Logic{}).KeepTurn(next) {
		t.Fatalf("separate triples must not keep the turn: step=%+v state=%+v", matchStep, next)
	}
}

func TestMyriadSwordsCostsFullMana(t *testing.T) {
	board := stripedBoard()
	poor := stateWith(board, [2]Fighter{{HP: 100, MP: 99}, {HP: 100}}, 7)
	if err := (Logic{}).ValidateMove(poor, 0, json.RawMessage(`{"type":"ult"}`)); err == nil {
		t.Fatal("ult without enough mana was accepted")
	}

	state := stateWith(board, [2]Fighter{{HP: 100, MP: 100}, {HP: 100}}, 7)
	if err := (Logic{}).ValidateMove(state, 0, json.RawMessage(`{"type":"ult"}`)); err != nil {
		t.Fatal(err)
	}
	nextAny, err := (Logic{}).Apply(state, 0, json.RawMessage(`{"type":"ult"}`))
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)
	if next.Fighters != [2]Fighter{{HP: 100, MP: 0}, {HP: 50}} {
		t.Fatalf("unexpected fighters: %+v", next.Fighters)
	}
	if len(next.Steps) != 1 || next.Steps[0].Kind != "ult" || next.Steps[0].Skill != skillMyriadSwords || next.Steps[0].Damage != 50 {
		t.Fatalf("unexpected steps: %+v", next.Steps)
	}
	if next.ExtraTurn || next.MoveCount != 1 || next.Rng != "7" {
		t.Fatalf("unexpected state: %+v", next)
	}
	if !reflect.DeepEqual(next.Board, board) {
		t.Fatal("ult must not touch the board")
	}

	lethal := stateWith(board, [2]Fighter{{HP: 100, MP: 100}, {HP: 20}}, 7)
	nextAny, err = (Logic{}).Apply(lethal, 0, json.RawMessage(`{"type":"ult"}`))
	if err != nil {
		t.Fatal(err)
	}
	if over, winner := (Logic{}).Result(nextAny); !over || winner != 0 {
		t.Fatalf("lethal ult: over=%v winner=%d", over, winner)
	}
}

func TestLightningGodStrikesFourTwoByTwoBlocksAndAppliesGravity(t *testing.T) {
	board := stripedBoard()
	state := stateWith(board, [2]Fighter{{HP: 100, MP: 100}, {HP: 100}}, 7)
	move := json.RawMessage(`{"type":"ult","skill":"lightning-god"}`)
	if err := (Logic{}).ValidateMove(state, 0, move); err != nil {
		t.Fatal(err)
	}

	nextAny, err := (Logic{}).Apply(state, 0, move)
	if err != nil {
		t.Fatal(err)
	}
	next := nextAny.(*State)
	if next.Fighters[0].MP != 0 {
		t.Fatalf("lightning ultimate did not consume 100 mana: %+v", next.Fighters[0])
	}
	if len(next.Steps) < 2 || next.Steps[0].Kind != stepUlt || next.Steps[1].Kind != stepGravity {
		t.Fatalf("lightning ultimate must be followed by gravity: %+v", next.Steps)
	}
	ult := next.Steps[0]
	if ult.Skill != skillLightningGod || len(ult.Cells) != 16 || ult.Damage != lightningGodDamage {
		t.Fatalf("unexpected lightning step: %+v", ult)
	}
	if next.Fighters[1].HP > 100-lightningGodDamage {
		t.Fatalf("lightning damage was not applied to defender: %+v", next.Fighters[1])
	}
	for _, step := range next.Steps {
		if step.Kind == stepMatch && step.CascadeLevel < 1 {
			t.Fatalf("post-ultimate collapse must start at level 1: %+v", step)
		}
	}
	seen := make(map[int]bool, len(ult.Cells))
	for offset := 0; offset < len(ult.Cells); offset += 4 {
		cells := ult.Cells[offset : offset+4]
		if cells[1]-cells[0] != 1 || cells[2]-cells[0] != grid || cells[3]-cells[0] != grid+1 {
			t.Fatalf("ultimate cells are not four 2x2 blocks: %v", ult.Cells)
		}
		if cells[0]%grid >= grid-1 || cells[3] >= boardSize {
			t.Fatalf("ultimate block is outside the board: %v", cells)
		}
		for _, cell := range cells {
			if seen[cell] {
				t.Fatalf("ultimate blocks overlap at cell %d: %v", cell, ult.Cells)
			}
			seen[cell] = true
		}
	}
	if next.Rng == state.Rng || reflect.DeepEqual(next.Board, board) {
		t.Fatalf("lightning ultimate did not advance RNG and collapse board: rng=%s board=%v", next.Rng, next.Board)
	}
}

func TestUltimateRejectsUnknownSkill(t *testing.T) {
	state := stateWith(stripedBoard(), [2]Fighter{{HP: 100, MP: 100}, {HP: 100}}, 7)
	if err := (Logic{}).ValidateMove(state, 0, json.RawMessage(`{"type":"ult","skill":"ice"}`)); err == nil {
		t.Fatal("unknown ultimate skill was accepted")
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
		restored.ExtraTurn != next.ExtraTurn ||
		restored.ExtraTurns != next.ExtraTurns ||
		restored.ExtraTurnOwner != next.ExtraTurnOwner {
		t.Fatalf("roundtrip mismatch: %+v vs %+v", restored, next)
	}
}

func TestDecodeStateKeepsLegacyExtraTurn(t *testing.T) {
	state := (Logic{}).Init(5).(*State)
	state.ExtraTurn = true
	data, err := json.Marshal(state)
	if err != nil {
		t.Fatal(err)
	}
	restoredAny, err := (Logic{}).DecodeState(data)
	if err != nil {
		t.Fatal(err)
	}
	restored := restoredAny.(*State)
	if !restored.ExtraTurn || restored.ExtraTurns != 0 || restored.ExtraTurnOwner != -1 || !(Logic{}).KeepTurn(restored) {
		t.Fatalf("legacy extra turn was not preserved: %+v", restored)
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
		{name: "negative extra turns", data: snapshotWith(func(s *State) { s.ExtraTurns = -1 })},
		{name: "extra turn owner too high", data: snapshotWith(func(s *State) {
			s.ExtraTurns, s.ExtraTurnOwner = 1, 2
		})},
		{name: "extra turn owner negative", data: snapshotWith(func(s *State) {
			s.ExtraTurns, s.ExtraTurnOwner = 1, -1
		})},
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
	if gameLogic.KeepTurn(&State{ExtraTurn: true}) != true ||
		gameLogic.KeepTurn(&State{ExtraTurns: 2}) != true ||
		gameLogic.KeepTurn(nil) {
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
