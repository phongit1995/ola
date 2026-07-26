package wargod

import "sort"

const (
	grid      = 8
	boardSize = grid * grid
	tileCount = 6
)

const (
	tileSword = iota
	tileFire
	tileHeart
	tileWater
	tileShield
	tileStone
)

var tileNames = [tileCount]string{"sword", "fire", "heart", "water", "shield", "stone"}

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

func (r *rng) tile() int {
	return int(r.next() % tileCount)
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
	if x >= 2 && board[i-1] == tile && board[i-2] == tile {
		return true
	}
	if y >= 2 && board[i-grid] == tile && board[i-grid*2] == tile {
		return true
	}
	return false
}

func findMatches(board []int) ([]int, map[int]int, int) {
	matched := map[int]bool{}
	maxRun := 0
	scanLine := func(start, step, length int) {
		runStart := 0
		for k := 1; k <= length; k++ {
			same := k < length && board[start+k*step] == board[start+runStart*step]
			if same {
				continue
			}
			runLen := k - runStart
			if runLen >= 3 {
				if runLen > maxRun {
					maxRun = runLen
				}
				for r := runStart; r < k; r++ {
					matched[start+r*step] = true
				}
			}
			runStart = k
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
			tile := r.tile()
			board[target] = tile
			spawns = append(spawns, Spawn{Index: target, Type: tile, FromRow: spawnRow})
			spawnRow--
		}
	}
	return falls, spawns
}
