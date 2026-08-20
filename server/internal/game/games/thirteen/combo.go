package thirteen

import (
	"errors"
	"sort"
)

type ComboKind string

const (
	ComboSingle    ComboKind = "single"
	ComboPair      ComboKind = "pair"
	ComboTriple    ComboKind = "triple"
	ComboQuad      ComboKind = "quad"
	ComboStraight  ComboKind = "straight"
	ComboDoubleRun ComboKind = "doubleRun"
)

type Combo struct {
	Kind   ComboKind
	Length int
	Key    int
}

var errInvalidCombo = errors.New("cards do not form a playable combination")

func classify(cards []int) (Combo, error) {
	n := len(cards)
	if n == 0 || n > HandSize {
		return Combo{}, errInvalidCombo
	}
	sorted := append([]int(nil), cards...)
	sort.Ints(sorted)
	for i, card := range sorted {
		if !validCard(card) {
			return Combo{}, errInvalidCombo
		}
		if i > 0 && sorted[i] == sorted[i-1] {
			return Combo{}, errInvalidCombo
		}
	}
	top := sorted[n-1]

	sameRank := true
	for _, card := range sorted {
		if rankOf(card) != rankOf(top) {
			sameRank = false
			break
		}
	}
	if sameRank {
		switch n {
		case 1:
			return Combo{Kind: ComboSingle, Length: 1, Key: top}, nil
		case 2:
			return Combo{Kind: ComboPair, Length: 2, Key: top}, nil
		case 3:
			return Combo{Kind: ComboTriple, Length: 3, Key: top}, nil
		case 4:
			return Combo{Kind: ComboQuad, Length: 4, Key: top}, nil
		}
		return Combo{}, errInvalidCombo
	}

	if n >= 3 && isStraight(sorted) {
		return Combo{Kind: ComboStraight, Length: n, Key: top}, nil
	}
	if n >= 6 && n%2 == 0 && isDoubleRun(sorted) {
		return Combo{Kind: ComboDoubleRun, Length: n / 2, Key: top}, nil
	}
	return Combo{}, errInvalidCombo
}

func isStraight(sorted []int) bool {
	for i, card := range sorted {
		if rankOf(card) == RankTwo {
			return false
		}
		if i > 0 && rankOf(card) != rankOf(sorted[i-1])+1 {
			return false
		}
	}
	return true
}

func isDoubleRun(sorted []int) bool {
	for i := 0; i < len(sorted); i += 2 {
		if rankOf(sorted[i]) != rankOf(sorted[i+1]) {
			return false
		}
		if rankOf(sorted[i]) == RankTwo {
			return false
		}
		if i > 0 && rankOf(sorted[i]) != rankOf(sorted[i-2])+1 {
			return false
		}
	}
	return true
}

func beats(next, prev Combo) bool {
	if next.Kind == prev.Kind && next.Length == prev.Length {
		return next.Key > prev.Key
	}
	switch {
	case prev.Kind == ComboSingle && rankOf(prev.Key) == RankTwo:
		return next.Kind == ComboQuad || (next.Kind == ComboDoubleRun && next.Length >= 3)
	case prev.Kind == ComboPair && rankOf(prev.Key) == RankTwo:
		return next.Kind == ComboQuad || (next.Kind == ComboDoubleRun && next.Length >= 4)
	case prev.Kind == ComboQuad:
		return next.Kind == ComboDoubleRun && next.Length >= 4
	case prev.Kind == ComboDoubleRun && prev.Length == 3:
		return next.Kind == ComboQuad || (next.Kind == ComboDoubleRun && next.Length >= 4)
	}
	return false
}
