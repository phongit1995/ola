package wargod

import "sort"

const (
	grid          = 8
	boardSize     = grid * grid
	baseTileCount = 6
	tileCount     = 10
	// Divisor riêng cho từng ô gốc để cả hai ô đặc biệt ra ~1/60:
	//   Kiếm Lửa   ≈ 22% / 13 ≈ 1/59
	//   Đại Trái Tim ≈ 16% / 10 ≈ 1/62
	specialSwordOneIn = 13
	specialHeartOneIn = 10
	// Phi Tiêu chỉ có thể sinh ngẫu nhiên ở các ô bù sau khi bàn sập.
	// Nguồn xuất hiện chính vẫn là ghép một hàng/cột 5 ô Nước.
	specialFlyingDartOneIn = 400
	maxFlyingDartsOnBoard  = 2
)

const (
	tileSword = iota
	tilePeach
	tileHeart
	tileWater
	tileShield
	tileLightning
	tileFireSword
	tileGreaterHeart
	tileFlyingDartHorizontal
	tileFlyingDartVertical
)

// tileNames is the wire-format order shared with the TypeScript client.
// Run `go generate` in this package after changing it or any exported balance value.
var tileNames = [tileCount]string{
	"sword",
	"peach",
	"heart",
	"water",
	"shield",
	"lightning",
	"fireSword",
	"greaterHeart",
	"flyingDartHorizontal",
	"flyingDartVertical",
}

const (
	dartAxisHorizontal = "horizontal"
	dartAxisVertical   = "vertical"
)

type DartCreation struct {
	Index int `json:"index"`
	Type  int `json:"type"`
}

type DartActivation struct {
	Source int    `json:"source"`
	Axis   string `json:"axis"`
}

type rng struct {
	z uint64
}

func (r *rng) next() uint64 {
	r.z += 0x9E3779B97F4A7C15
	v := r.z
	v ^= v >> 30
	v *= 0xBF58476D1CE4E5B9
	v ^= v >> 27
	v *= 0x94D049BB133111EB
	v ^= v >> 31
	return v
}

func weightedBase(r uint64) int {
	switch {
	case r < 22:
		return tileSword
	case r < 38:
		return tilePeach
	case r < 54:
		return tileHeart
	case r < 69:
		return tileWater
	case r < 84:
		return tileShield
	default:
		return tileLightning
	}
}

func (r *rng) tile() int {
	return r.tileWithFlyingDart(false)
}

func (r *rng) refillTile(allowFlyingDart bool) int {
	return r.tileWithFlyingDart(allowFlyingDart)
}

func (r *rng) tileWithFlyingDart(allowFlyingDart bool) int {
	roll := r.next()
	if allowFlyingDart && roll%specialFlyingDartOneIn == 0 {
		if (roll/specialFlyingDartOneIn)%2 == 0 {
			return tileFlyingDartHorizontal
		}
		return tileFlyingDartVertical
	}
	tile := weightedBase(roll % 100)
	sel := roll / 100
	switch tile {
	case tileSword:
		if sel%specialSwordOneIn == 0 {
			return tileFireSword
		}
	case tileHeart:
		if sel%specialHeartOneIn == 0 {
			return tileGreaterHeart
		}
	}
	return tile
}

func createBoard(r *rng) []int {
	for {
		board := make([]int, boardSize)
		for i := 0; i < boardSize; i++ {
			tile := r.tile()
			for createsMatchAt(board, i, tile) {
				tile = r.tile()
			}
			board[i] = tile
		}
		if len(validSwaps(board)) > 0 {
			return board
		}
	}
}

func createsMatchAt(board []int, i, tile int) bool {
	x := i % grid
	y := i / grid
	matchType := baseTile(tile)
	if x >= 2 && baseTile(board[i-1]) == matchType && baseTile(board[i-2]) == matchType {
		return true
	}
	if y >= 2 && baseTile(board[i-grid]) == matchType && baseTile(board[i-grid*2]) == matchType {
		return true
	}
	return false
}

func baseTile(tile int) int {
	switch tile {
	case tileFireSword:
		return tileSword
	case tileGreaterHeart:
		return tileHeart
	case tileFlyingDartHorizontal, tileFlyingDartVertical:
		return tileWater
	default:
		return tile
	}
}

func isFlyingDart(tile int) bool {
	return tile == tileFlyingDartHorizontal || tile == tileFlyingDartVertical
}

func flyingDartAxis(tile int) string {
	if tile == tileFlyingDartVertical {
		return dartAxisVertical
	}
	return dartAxisHorizontal
}

// findFlyingDartCreation turns one straight Water run of 5+ into a Phi Tiêu.
// The swapped destination is preferred so the reward appears where the player
// acted; cascade-created runs fall back to their center-most plain Water tile.
func findFlyingDartCreation(board []int, preferred []int) *DartCreation {
	type waterRun struct {
		cells []int
		tile  int
	}
	runs := make([]waterRun, 0, 2)
	appendRun := func(cells []int, tile int) {
		if len(cells) < 5 {
			return
		}
		copied := append([]int(nil), cells...)
		runs = append(runs, waterRun{cells: copied, tile: tile})
	}
	for y := 0; y < grid; y++ {
		for start := 0; start < grid; {
			if board[y*grid+start] != tileWater {
				start++
				continue
			}
			end := start + 1
			for end < grid && board[y*grid+end] == tileWater {
				end++
			}
			cells := make([]int, 0, end-start)
			for x := start; x < end; x++ {
				cells = append(cells, y*grid+x)
			}
			appendRun(cells, tileFlyingDartHorizontal)
			start = end
		}
	}
	for x := 0; x < grid; x++ {
		for start := 0; start < grid; {
			if board[start*grid+x] != tileWater {
				start++
				continue
			}
			end := start + 1
			for end < grid && board[end*grid+x] == tileWater {
				end++
			}
			cells := make([]int, 0, end-start)
			for y := start; y < end; y++ {
				cells = append(cells, y*grid+x)
			}
			appendRun(cells, tileFlyingDartVertical)
			start = end
		}
	}
	if len(runs) == 0 {
		return nil
	}

	contains := func(cells []int, index int) bool {
		for _, cell := range cells {
			if cell == index {
				return true
			}
		}
		return false
	}
	for _, index := range preferred {
		if index < 0 || index >= len(board) || board[index] != tileWater {
			continue
		}
		for _, run := range runs {
			if contains(run.cells, index) {
				return &DartCreation{Index: index, Type: run.tile}
			}
		}
	}
	// Prefer the longest run, retaining scan order for deterministic ties.
	chosen := runs[0]
	for _, run := range runs[1:] {
		if len(run.cells) > len(chosen.cells) {
			chosen = run
		}
	}
	middle := (len(chosen.cells) - 1) / 2
	for distance := 0; distance < len(chosen.cells); distance++ {
		for _, offset := range []int{distance, -distance} {
			position := middle + offset
			if position < 0 || position >= len(chosen.cells) {
				continue
			}
			index := chosen.cells[position]
			if board[index] == tileWater {
				return &DartCreation{Index: index, Type: chosen.tile}
			}
		}
	}
	return nil
}

func findMatches(board []int) ([]int, map[int]int, int) {
	matched := map[int]bool{}
	maxRun := 0
	type lineRun struct {
		start int
		end   int
	}
	scanLine := func(start, step, length int) {
		// A Phi Tiêu replaces at most one tile: a contiguous run is valid
		// when it has no more than one dart and all other tiles share one
		// base type. Pick longest non-overlapping runs so an ambiguous dart
		// is consumed by only one group.
		runs := make([]lineRun, 0, length)
		for runStart := 0; runStart <= length-3; runStart++ {
			matchType := -1
			dartCount := 0
			for end := runStart; end < length; end++ {
				tile := board[start+end*step]
				if isFlyingDart(tile) {
					dartCount++
					if dartCount > 1 {
						break
					}
				} else {
					base := baseTile(tile)
					if matchType < 0 {
						matchType = base
					} else if matchType != base {
						break
					}
				}
				if end-runStart+1 >= 3 {
					runs = append(runs, lineRun{start: runStart, end: end + 1})
					if end-runStart+1 > maxRun {
						maxRun = end - runStart + 1
					}
				}
			}
		}
		sort.SliceStable(runs, func(i, j int) bool {
			left, right := runs[i], runs[j]
			leftLen, rightLen := left.end-left.start, right.end-right.start
			if leftLen != rightLen {
				return leftLen > rightLen
			}
			return left.start < right.start
		})
		occupied := map[int]bool{}
		for _, run := range runs {
			overlaps := false
			for offset := run.start; offset < run.end; offset++ {
				if occupied[start+offset*step] {
					overlaps = true
					break
				}
			}
			if overlaps {
				continue
			}
			for offset := run.start; offset < run.end; offset++ {
				index := start + offset*step
				occupied[index] = true
				matched[index] = true
			}
		}
	}
	for y := 0; y < grid; y++ {
		scanLine(y*grid, 1, grid)
	}
	for x := 0; x < grid; x++ {
		scanLine(x, grid, grid)
	}
	if len(matched) == 0 {
		return nil, nil, 0
	}
	cellIndexes := make([]int, 0, len(matched))
	for i := range matched {
		cellIndexes = append(cellIndexes, i)
	}
	sort.Ints(cellIndexes)
	counts := map[int]int{}
	for _, i := range cellIndexes {
		counts[board[i]]++
	}
	return cellIndexes, counts, maxRun
}

// matchBonusTurns counts one bonus turn for every orthogonally connected group
// of 4+ matched tiles with the same base type. T/L/cross shapes therefore count,
// while two separate groups of three do not. Each cascade wave is independent.
func matchBonusTurns(board, matchedCells []int) int {
	matched := make(map[int]bool, len(matchedCells))
	baseTypes := make(map[int]bool)
	for _, i := range matchedCells {
		matched[i] = true
		if !isFlyingDart(board[i]) {
			baseTypes[baseTile(board[i])] = true
		}
	}
	bonusTurns := 0
	for tile := range baseTypes {
		visited := make(map[int]bool, len(matchedCells))
		compatible := func(index int) bool {
			return isFlyingDart(board[index]) || baseTile(board[index]) == tile
		}
		for _, start := range matchedCells {
			if visited[start] || !compatible(start) {
				continue
			}
			queue := []int{start}
			visited[start] = true
			size := 0
			for len(queue) > 0 {
				last := len(queue) - 1
				index := queue[last]
				queue = queue[:last]
				size++
				x, y := index%grid, index/grid
				neighbors := make([]int, 0, 4)
				if x > 0 {
					neighbors = append(neighbors, index-1)
				}
				if x < grid-1 {
					neighbors = append(neighbors, index+1)
				}
				if y > 0 {
					neighbors = append(neighbors, index-grid)
				}
				if y < grid-1 {
					neighbors = append(neighbors, index+grid)
				}
				for _, neighbor := range neighbors {
					if matched[neighbor] && !visited[neighbor] && compatible(neighbor) {
						visited[neighbor] = true
						queue = append(queue, neighbor)
					}
				}
			}
			if size >= 4 {
				bonusTurns++
			}
		}
	}
	return bonusTurns
}

func computeExplosions(board []int, matched map[int]bool, r *rng) ([]int, []LightningArc, []DartActivation) {
	exploded, arcs, darts, _ := computeExplosionsWithPickerDetailed(board, matched, func(limit int) int {
		return int(r.next() % uint64(limit))
	})
	return exploded, arcs, darts
}

func pickLightningArcs(
	board []int,
	sourceCandidates, removed map[int]bool,
	pickIndex func(int) int,
) []LightningArc {
	sources := make([]int, 0, len(sourceCandidates))
	for index := range sourceCandidates {
		if board[index] == tileLightning {
			sources = append(sources, index)
		}
	}
	sort.Ints(sources)

	unavailable := make(map[int]bool, len(removed)+len(sources))
	for index := range removed {
		unavailable[index] = true
	}
	for _, source := range sources {
		unavailable[source] = true
	}
	pool := make([]int, 0, boardSize-len(unavailable))
	for index := 0; index < boardSize; index++ {
		if !unavailable[index] {
			pool = append(pool, index)
		}
	}

	targetCount := len(sources)
	if len(pool) < targetCount {
		targetCount = len(pool)
	}
	arcs := make([]LightningArc, 0, targetCount)
	for order := 0; order < targetCount; order++ {
		pick := pickIndex(len(pool))
		if pick < 0 {
			pick = 0
		} else if pick >= len(pool) {
			pick = len(pool) - 1
		}
		target := pool[pick]
		pool[pick] = pool[len(pool)-1]
		pool = pool[:len(pool)-1]
		arcs = append(arcs, LightningArc{Source: sources[order], Target: target})
	}
	return arcs
}

// addFlyingDartActivations expands affected with every unique Phi Tiêu line
// reachable from seed cells. It is shared by normal matches and ultimates.
func addFlyingDartActivations(board []int, seed, affected map[int]bool) []DartActivation {
	activated := map[int]bool{}
	activations := make([]DartActivation, 0, 2)
	for {
		candidates := make([]int, 0)
		for i := range seed {
			if isFlyingDart(board[i]) && !activated[i] {
				candidates = append(candidates, i)
			}
		}
		for i := range affected {
			if isFlyingDart(board[i]) && !activated[i] {
				candidates = append(candidates, i)
			}
		}
		if len(candidates) == 0 {
			break
		}
		sort.Ints(candidates)
		for _, source := range candidates {
			if activated[source] {
				continue
			}
			activated[source] = true
			axis := flyingDartAxis(board[source])
			activations = append(activations, DartActivation{Source: source, Axis: axis})
			x, y := source%grid, source/grid
			if axis == dartAxisHorizontal {
				for column := 0; column < grid; column++ {
					affected[y*grid+column] = true
				}
			} else {
				for row := 0; row < grid; row++ {
					affected[row*grid+x] = true
				}
			}
		}
	}
	return activations
}

// expandDartTriggeredSpecials expands struck cells with dart lines and only
// the Fire Swords actually reached by those lines. A Fire Sword already in
// the original struck set remains an ordinary ultimate target.
func expandDartTriggeredSpecials(
	board []int,
	affected, directFireSwords map[int]bool,
) ([]DartActivation, []int) {
	seed := make(map[int]bool, len(affected))
	for index := range affected {
		seed[index] = true
	}
	dartSwept := map[int]bool{}
	activatedDarts := map[int]bool{}
	activatedFireSwords := map[int]bool{}
	dartActivations := make([]DartActivation, 0, 2)
	fireSwordActivations := make([]int, 0)

	for {
		changed := false
		for _, activation := range addFlyingDartActivations(board, seed, affected) {
			if activatedDarts[activation.Source] {
				continue
			}
			activatedDarts[activation.Source] = true
			dartActivations = append(dartActivations, activation)
			x, y := activation.Source%grid, activation.Source/grid
			if activation.Axis == dartAxisHorizontal {
				for column := 0; column < grid; column++ {
					dartSwept[y*grid+column] = true
				}
			} else {
				for row := 0; row < grid; row++ {
					dartSwept[row*grid+x] = true
				}
			}
			changed = true
		}

		fireCandidates := make([]int, 0)
		for index := range affected {
			if board[index] == tileFireSword && !directFireSwords[index] &&
				dartSwept[index] && !activatedFireSwords[index] {
				fireCandidates = append(fireCandidates, index)
			}
		}
		sort.Ints(fireCandidates)
		for _, source := range fireCandidates {
			activatedFireSwords[source] = true
			fireSwordActivations = append(fireSwordActivations, source)
			x, y := source%grid, source/grid
			for dy := -1; dy <= 1; dy++ {
				for dx := -1; dx <= 1; dx++ {
					if x+dx >= 0 && x+dx < grid && y+dy >= 0 && y+dy < grid {
						affected[(y+dy)*grid+x+dx] = true
					}
				}
			}
			changed = true
		}

		if !changed {
			break
		}
	}
	return dartActivations, fireSwordActivations
}

func computeExplosionsWithPicker(board []int, matched map[int]bool, pickIndex func(int) int) ([]int, []LightningArc, []DartActivation) {
	exploded, arcs, darts, _ := computeExplosionsWithPickerDetailed(board, matched, pickIndex)
	return exploded, arcs, darts
}

func computeExplosionsWithPickerDetailed(board []int, matched map[int]bool, pickIndex func(int) int) ([]int, []LightningArc, []DartActivation, []int) {
	set := map[int]bool{}
	add := func(x, y int) {
		if x >= 0 && x < grid && y >= 0 && y < grid {
			set[y*grid+x] = true
		}
	}
	fireSwordActivations := make([]int, 0)
	activatedFireSwords := map[int]bool{}
	dartActivations := make([]DartActivation, 0, 2)
	activatedDarts := map[int]bool{}
	dartSwept := map[int]bool{}

	// Special tiles form a deterministic chain through Phi Tiêu. A Fire Sword
	// reached by a dart sweep also explodes its 3x3 area; another Fire Sword
	// caught only by that blast remains an ordinary removed tile.
	for {
		changed := false
		candidates := make([]int, 0, len(matched)+len(set))
		seen := map[int]bool{}
		for i := range matched {
			if !seen[i] {
				seen[i] = true
				candidates = append(candidates, i)
			}
		}
		for i := range set {
			if !seen[i] {
				seen[i] = true
				candidates = append(candidates, i)
			}
		}
		sort.Ints(candidates)
		for _, i := range candidates {
			// A Fire Sword keeps its old direct-match behavior. The Phi Tiêu rule
			// additionally allows a dart sweep to activate it; another Fire
			// Sword's 3x3 blast alone must not start a new Fire Sword chain.
			if board[i] != tileFireSword || activatedFireSwords[i] ||
				(!matched[i] && !dartSwept[i]) {
				continue
			}
			activatedFireSwords[i] = true
			fireSwordActivations = append(fireSwordActivations, i)
			x, y := i%grid, i/grid
			for dy := -1; dy <= 1; dy++ {
				for dx := -1; dx <= 1; dx++ {
					add(x+dx, y+dy)
				}
			}
			changed = true
		}

		// addFlyingDartActivations expands all reachable dart lines. Filter the
		// result through a wave-level set so a second loop cannot replay a dart.
		for _, activation := range addFlyingDartActivations(board, matched, set) {
			if activatedDarts[activation.Source] {
				continue
			}
			activatedDarts[activation.Source] = true
			dartActivations = append(dartActivations, activation)
			x, y := activation.Source%grid, activation.Source/grid
			if activation.Axis == dartAxisHorizontal {
				for column := 0; column < grid; column++ {
					dartSwept[y*grid+column] = true
				}
			} else {
				for row := 0; row < grid; row++ {
					dartSwept[row*grid+x] = true
				}
			}
			changed = true
		}
		if !changed {
			break
		}
	}
	for i := range matched {
		delete(set, i)
	}

	// Lightning activates when matched directly or caught in a Fire Sword or
	// Phi Tiêu area. Snapshot the sources before adding random targets so those
	// targets never recurse into another chain.
	lightningSourceSet := make(map[int]bool, len(matched)+len(set))
	for i := range matched {
		if board[i] == tileLightning {
			lightningSourceSet[i] = true
		}
	}
	for i := range set {
		if board[i] == tileLightning {
			lightningSourceSet[i] = true
		}
	}
	removed := make(map[int]bool, len(matched)+len(set))
	for index := range matched {
		removed[index] = true
	}
	for index := range set {
		removed[index] = true
	}
	lightningArcs := pickLightningArcs(board, lightningSourceSet, removed, pickIndex)
	for _, arc := range lightningArcs {
		set[arc.Target] = true
	}

	out := make([]int, 0, len(set))
	for i := range set {
		out = append(out, i)
	}
	sort.Ints(out)
	return out, lightningArcs, dartActivations, fireSwordActivations
}

func areAdjacent(a, b int) bool {
	dx := a%grid - b%grid
	if dx < 0 {
		dx = -dx
	}
	dy := a/grid - b/grid
	if dy < 0 {
		dy = -dy
	}
	return dx+dy == 1
}

func validSwaps(board []int) [][2]int {
	moves := [][2]int{}
	try := func(a, b int) {
		board[a], board[b] = board[b], board[a]
		matchedCells, _, _ := findMatches(board)
		board[a], board[b] = board[b], board[a]
		if matchedCells != nil {
			moves = append(moves, [2]int{a, b})
		}
	}
	for y := 0; y < grid; y++ {
		for x := 0; x < grid; x++ {
			i := y*grid + x
			if x < grid-1 {
				try(i, i+1)
			}
			if y < grid-1 {
				try(i, i+grid)
			}
		}
	}
	return moves
}

func ValidSwaps(board []int) [][2]int {
	return validSwaps(append([]int(nil), board...))
}

type Fall struct {
	From int `json:"from"`
	To   int `json:"to"`
}

type Spawn struct {
	Index   int `json:"index"`
	Type    int `json:"type"`
	FromRow int `json:"fromRow"`
}

func applyGravity(board []int, removed map[int]bool, r *rng) ([]Fall, []Spawn) {
	falls := []Fall{}
	spawns := []Spawn{}
	flyingDarts := 0
	for index, tile := range board {
		if !removed[index] && isFlyingDart(tile) {
			flyingDarts++
		}
	}
	for x := 0; x < grid; x++ {
		write := grid - 1
		for y := grid - 1; y >= 0; y-- {
			i := y*grid + x
			if removed[i] {
				continue
			}
			target := write*grid + x
			if target != i {
				board[target] = board[i]
				falls = append(falls, Fall{From: i, To: target})
			}
			write--
		}
		spawnRow := -1
		for y := write; y >= 0; y-- {
			target := y*grid + x
			tile := r.refillTile(flyingDarts < maxFlyingDartsOnBoard)
			if isFlyingDart(tile) {
				flyingDarts++
			}
			board[target] = tile
			spawns = append(spawns, Spawn{Index: target, Type: tile, FromRow: spawnRow})
			spawnRow--
		}
	}
	return falls, spawns
}
