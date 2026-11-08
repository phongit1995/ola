package utils

import (
	"slices"
	"testing"

	"github.com/google/uuid"
)

func TestSameIDs(t *testing.T) {
	a, b, c := uuid.New(), uuid.New(), uuid.New()
	cases := []struct {
		name          string
		current, want []uuid.UUID
		same          bool
	}{
		{"reordered", []uuid.UUID{a, b, c}, []uuid.UUID{c, a, b}, true},
		{"missing", []uuid.UUID{a, b, c}, []uuid.UUID{a, b}, false},
		{"extra", []uuid.UUID{a, b}, []uuid.UUID{a, b, c}, false},
		{"duplicate", []uuid.UUID{a, b}, []uuid.UUID{a, a}, false},
		{"unknown", []uuid.UUID{a, b}, []uuid.UUID{a, c}, false},
	}
	for _, tc := range cases {
		if got := SameIDs(tc.current, tc.want); got != tc.same {
			t.Fatalf("%s: got %v, want %v", tc.name, got, tc.same)
		}
	}
}

func TestInsertAtPosition(t *testing.T) {
	a, b, c, x, y := uuid.New(), uuid.New(), uuid.New(), uuid.New(), uuid.New()
	others := []uuid.UUID{a, b, c}
	cases := []struct {
		name     string
		placed   []uuid.UUID
		position int
		want     []uuid.UUID
		first    int
	}{
		{"top", []uuid.UUID{x}, 1, []uuid.UUID{x, a, b, c}, 1},
		{"middle", []uuid.UUID{x}, 2, []uuid.UUID{a, x, b, c}, 2},
		{"last existing slot", []uuid.UUID{x}, 3, []uuid.UUID{a, b, x, c}, 3},
		{"past the end", []uuid.UUID{x}, 9, []uuid.UUID{a, b, c, x}, 4},
		{"zero goes to the end", []uuid.UUID{x}, 0, []uuid.UUID{a, b, c, x}, 4},
		{"batch keeps its order", []uuid.UUID{x, y}, 2, []uuid.UUID{a, x, y, b, c}, 2},
	}
	for _, tc := range cases {
		got, first := insertAtPosition(others, tc.placed, tc.position)
		if !slices.Equal(got, tc.want) || first != tc.first {
			t.Fatalf("%s: got %v at %d, want %v at %d", tc.name, got, first, tc.want, tc.first)
		}
	}
}
