package wargod

type ParityFixture struct {
	Version        int                   `json:"version"`
	TileOrder      []string              `json:"tileOrder"`
	FindMatches    []ParityMatchCase     `json:"findMatches"`
	TileEffects    []ParityEffectsCase   `json:"tileEffects"`
	ExplosionPlans []ParityExplosionCase `json:"explosionPlans"`
}

type ParityMatchCase struct {
	Name       string         `json:"name"`
	Board      []int          `json:"board"`
	Cells      []int          `json:"cells"`
	Counts     map[string]int `json:"counts"`
	MaxRun     int            `json:"maxRun"`
	BonusTurns int            `json:"bonusTurns"`
}

type ParityEffectsCase struct {
	Name         string         `json:"name"`
	Attacker     Fighter        `json:"attacker"`
	Defender     Fighter        `json:"defender"`
	Counts       map[string]int `json:"counts"`
	WantAttacker Fighter        `json:"wantAttacker"`
	WantDefender Fighter        `json:"wantDefender"`
	WantEffects  Effects        `json:"wantEffects"`
}

type ParityExplosionCase struct {
	Name          string         `json:"name"`
	Board         []int          `json:"board"`
	Matched       []int          `json:"matched"`
	Random        []float64      `json:"random"`
	Exploded      []int          `json:"exploded"`
	LightningArcs []LightningArc `json:"lightningArcs"`
}

// ExportParityFixture produces deterministic golden cases consumed by both
// Go tests and Vitest. It intentionally exercises pure rules only; live replay
// damage continues to use the authoritative values serialized in Step.
func ExportParityFixture() ParityFixture {
	matchCases := []struct {
		name  string
		board []int
	}{
		{
			name: "special tile shares its base match",
			board: func() []int {
				board := parityStripedBoard()
				board[56], board[57], board[58] = tileSword, tileFireSword, tileSword
				return board
			}(),
		},
		{
			name: "connected T shape earns one bonus turn",
			board: func() []int {
				board := parityStripedBoard()
				for _, index := range []int{19, 26, 27, 28, 35} {
					board[index] = tileLightning
				}
				return board
			}(),
		},
	}
	matches := make([]ParityMatchCase, 0, len(matchCases))
	for _, test := range matchCases {
		cells, counts, maxRun := findMatches(test.board)
		matches = append(matches, ParityMatchCase{
			Name:       test.name,
			Board:      test.board,
			Cells:      cells,
			Counts:     parityNamedCounts(counts, false),
			MaxRun:     maxRun,
			BonusTurns: matchBonusTurns(test.board, cells),
		})
	}

	effectInputs := []struct {
		name     string
		attacker Fighter
		defender Fighter
		counts   map[int]int
	}{
		{
			name:     "caps gains and resolves armor damage",
			attacker: Fighter{HP: 150, MP: 90, Armor: 28, Fury: 90},
			defender: Fighter{HP: 200, Armor: 20},
			counts: map[int]int{
				tileSword: 3, tilePeach: 2, tileHeart: 4, tileWater: 3, tileShield: 2,
			},
		},
		{
			name:     "armor absorbs full fury damage and special healing caps",
			attacker: Fighter{HP: 195, Fury: 100},
			defender: Fighter{HP: 30, Armor: 30},
			counts: map[int]int{
				tileSword: 1, tileFireSword: 1, tileGreaterHeart: 1,
			},
		},
	}
	effects := make([]ParityEffectsCase, 0, len(effectInputs))
	for _, test := range effectInputs {
		attacker, defender := test.attacker, test.defender
		want := applyTileEffects(&attacker, &defender, test.counts)
		effects = append(effects, ParityEffectsCase{
			Name:         test.name,
			Attacker:     test.attacker,
			Defender:     test.defender,
			Counts:       parityNamedCounts(test.counts, true),
			WantAttacker: attacker,
			WantDefender: defender,
			WantEffects:  want,
		})
	}

	fireBoard := parityStripedBoard()
	fireBoard[25], fireBoard[26], fireBoard[27] = tileSword, tileFireSword, tileSword
	lightningBoard := parityStripedBoard()
	lightningBoard[0], lightningBoard[1], lightningBoard[2] = tileLightning, tileLightning, tileLightning
	fireLightningBoard := parityStripedBoard()
	fireLightningBoard[0] = tileLightning
	fireLightningBoard[26], fireLightningBoard[27] = tileFireSword, tileLightning
	explosions := []ParityExplosionCase{
		makeExplosionFixture(
			"fire sword clears its surrounding 3x3",
			fireBoard,
			[]int{25, 26, 27},
			nil,
		),
		makeExplosionFixture(
			"lightning targets remain unique",
			lightningBoard,
			[]int{0, 1, 2},
			[]float64{0, 0, 0},
		),
		makeExplosionFixture(
			"fire sword triggers lightning inside its blast",
			fireLightningBoard,
			[]int{26},
			[]float64{0},
		),
	}

	return ParityFixture{
		Version:        5,
		TileOrder:      append([]string(nil), tileNames[:]...),
		FindMatches:    matches,
		TileEffects:    effects,
		ExplosionPlans: explosions,
	}
}

func parityStripedBoard() []int {
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

func parityNamedCounts(counts map[int]int, includeZeros bool) map[string]int {
	named := make(map[string]int, tileCount)
	for tile, name := range tileNames {
		if count := counts[tile]; includeZeros || count != 0 {
			named[name] = count
		}
	}
	return named
}

func makeExplosionFixture(name string, board, matchedCells []int, random []float64) ParityExplosionCase {
	matched := make(map[int]bool, len(matchedCells))
	for _, index := range matchedCells {
		matched[index] = true
	}
	randomIndex := 0
	exploded, arcs := computeExplosionsWithPicker(board, matched, func(limit int) int {
		if randomIndex >= len(random) {
			return 0
		}
		value := random[randomIndex]
		randomIndex++
		return int(value * float64(limit))
	})
	return ParityExplosionCase{
		Name:          name,
		Board:         board,
		Matched:       matchedCells,
		Random:        random,
		Exploded:      exploded,
		LightningArcs: arcs,
	}
}
