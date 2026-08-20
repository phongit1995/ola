package xiangqi

import (
	"reflect"
	"testing"
)

func sq(x, y int) int { return boardIdx(x, y) }

func TestLegalMovesPerPiece(t *testing.T) {
	cases := []struct {
		name      string
		overrides map[int]string
		from      int
		want      []int
	}{
		{
			name: "general palace bounds",
			from: sq(3, 0),
			want: []int{sq(4, 0), sq(3, 1)},
		},
		{
			name:      "advisor diagonals in palace",
			overrides: map[int]string{1: "....A...."},
			from:      sq(4, 1),
			want:      []int{sq(5, 0), sq(3, 2), sq(5, 2)},
		},
		{
			name:      "elephant blocked eye",
			overrides: map[int]string{2: "....E....", 3: ".....P..."},
			from:      sq(4, 2),
			want:      []int{sq(2, 0), sq(6, 0), sq(2, 4)},
		},
		{
			name:      "elephant cannot cross river",
			overrides: map[int]string{4: "..E......"},
			from:      sq(2, 4),
			want:      []int{sq(0, 2), sq(4, 2)},
		},
		{
			name:      "horse free",
			overrides: map[int]string{4: "....H...."},
			from:      sq(4, 4),
			want:      []int{sq(3, 2), sq(5, 2), sq(2, 3), sq(6, 3), sq(2, 5), sq(6, 5), sq(3, 6), sq(5, 6)},
		},
		{
			name:      "horse leg blocked",
			overrides: map[int]string{4: "....H....", 5: "....P...."},
			from:      sq(4, 4),
			want:      []int{sq(3, 2), sq(5, 2), sq(2, 3), sq(6, 3), sq(2, 5), sq(6, 5)},
		},
		{
			name:      "chariot rays and capture",
			overrides: map[int]string{4: "..p.R....", 6: "....P...."},
			from:      sq(4, 4),
			want: []int{
				sq(4, 0), sq(4, 1), sq(4, 2), sq(4, 3),
				sq(2, 4), sq(3, 4), sq(5, 4), sq(6, 4), sq(7, 4), sq(8, 4),
				sq(4, 5),
			},
		},
		{
			name:      "cannon capture over single screen",
			overrides: map[int]string{2: "....C....", 6: "....P....", 8: "....r...."},
			from:      sq(4, 2),
			want: []int{
				sq(4, 0), sq(4, 1),
				sq(0, 2), sq(1, 2), sq(2, 2), sq(3, 2), sq(5, 2), sq(6, 2), sq(7, 2), sq(8, 2),
				sq(4, 3), sq(4, 4), sq(4, 5),
				sq(4, 8),
			},
		},
		{
			name:      "cannon cannot capture adjacent without screen",
			overrides: map[int]string{2: "....C....", 3: "....p...."},
			from:      sq(4, 2),
			want: []int{
				sq(4, 0), sq(4, 1),
				sq(0, 2), sq(1, 2), sq(2, 2), sq(3, 2), sq(5, 2), sq(6, 2), sq(7, 2), sq(8, 2),
			},
		},
		{
			name:      "cannon cannot jump two screens",
			overrides: map[int]string{2: "....C....", 4: "....P....", 5: "....P....", 8: "....r...."},
			from:      sq(4, 2),
			want: []int{
				sq(4, 0), sq(4, 1),
				sq(0, 2), sq(1, 2), sq(2, 2), sq(3, 2), sq(5, 2), sq(6, 2), sq(7, 2), sq(8, 2),
				sq(4, 3),
			},
		},
		{
			name:      "soldier before river only forward",
			overrides: map[int]string{3: "....P...."},
			from:      sq(4, 3),
			want:      []int{sq(4, 4)},
		},
		{
			name:      "soldier after river forward and sideways",
			overrides: map[int]string{6: "....P...."},
			from:      sq(4, 6),
			want:      []int{sq(3, 6), sq(5, 6), sq(4, 7)},
		},
		{
			name:      "soldier on last rank edge",
			overrides: map[int]string{9: "P....k..."},
			from:      sq(0, 9),
			want:      []int{sq(1, 9)},
		},
		{
			name:      "chariot pinned to file by facing generals",
			overrides: map[int]string{0: "....K....", 5: "....R....", 9: "....k...."},
			from:      sq(4, 5),
			want: []int{
				sq(4, 1), sq(4, 2), sq(4, 3), sq(4, 4),
				sq(4, 6), sq(4, 7), sq(4, 8), sq(4, 9),
			},
		},
		{
			name:      "horse fully pinned by chariot",
			overrides: map[int]string{3: "...H.....", 7: "...r....."},
			from:      sq(3, 3),
			want:      []int{},
		},
		{
			name:      "advisor must block check",
			overrides: map[int]string{0: "...AK....", 5: "....r...."},
			from:      sq(3, 0),
			want:      []int{sq(4, 1)},
		},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			board := fixtureBoard(tc.overrides)
			got := legalMovesFrom(board, tc.from)
			want := append([]int(nil), tc.want...)
			sortInts(want)
			if len(got) == 0 && len(want) == 0 {
				return
			}
			if !reflect.DeepEqual(got, want) {
				t.Fatalf("got %v want %v", got, want)
			}
		})
	}
}

func sortInts(a []int) {
	for i := 1; i < len(a); i++ {
		for j := i; j > 0 && a[j-1] > a[j]; j-- {
			a[j-1], a[j] = a[j], a[j-1]
		}
	}
}

func TestInCheckDetection(t *testing.T) {
	cases := []struct {
		name      string
		overrides map[int]string
		want      bool
	}{
		{"chariot check", map[int]string{0: "....K....", 5: "....r...."}, true},
		{"cannon check over screen", map[int]string{0: "....K....", 3: "....P....", 7: "....c...."}, true},
		{"cannon needs screen", map[int]string{0: "....K....", 7: "....c...."}, false},
		{"horse check", map[int]string{0: "....K....", 2: ".....h..."}, true},
		{"horse leg blocked no check", map[int]string{0: "....K....", 1: ".....P...", 2: ".....h..."}, false},
		{"soldier forward check", map[int]string{0: "....K....", 1: "....p...."}, true},
		{"soldier sideways after river", map[int]string{0: "...pK...."}, true},
		{"quiet board", nil, false},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			board := fixtureBoard(tc.overrides)
			if got := inCheck(board, SideRed); got != tc.want {
				t.Fatalf("got %v want %v", got, tc.want)
			}
		})
	}
}

func TestGeneralsFacing(t *testing.T) {
	if !generalsFacing(fixtureBoard(map[int]string{0: "....K....", 9: "....k...."})) {
		t.Fatal("open file must face")
	}
	if generalsFacing(fixtureBoard(map[int]string{0: "....K....", 5: "....P....", 9: "....k...."})) {
		t.Fatal("blocked file must not face")
	}
	if generalsFacing(fixtureBoard(nil)) {
		t.Fatal("different files must not face")
	}
}

func TestHasLegalMoveTerminals(t *testing.T) {
	mate := fixtureBoard(map[int]string{0: "....K....", 1: "....r....", 2: "..h......"})
	if hasLegalMove(mate, SideRed) {
		t.Fatal("mate position must have no legal moves")
	}
	if !inCheck(mate, SideRed) {
		t.Fatal("mate position must be check")
	}
	stalemate := fixtureBoard(map[int]string{0: "...K.....", 2: "...p.....", 9: "....k...."})
	if hasLegalMove(stalemate, SideRed) {
		t.Fatal("stalemate position must have no legal moves")
	}
	if inCheck(stalemate, SideRed) {
		t.Fatal("stalemate position must not be check")
	}
	escapable := fixtureBoard(map[int]string{0: "r...K....", 1: "....r...."})
	if !hasLegalMove(escapable, SideRed) {
		t.Fatal("escapable check must have moves")
	}
}
