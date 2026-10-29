package moment

import (
	"errors"
	"strings"
	"testing"
)

func TestNormalizeCommentTrimsAndCountsRunes(t *testing.T) {
	got, err := normalizeComment("  Đẹp quá [s:1]  \n")
	if err != nil || got != "Đẹp quá [s:1]" {
		t.Fatalf("got %q, %v", got, err)
	}
	if _, err := normalizeComment(strings.Repeat("ạ", MaxMomentCommentRunes)); err != nil {
		t.Fatalf("a comment of exactly %d runes must pass, got %v", MaxMomentCommentRunes, err)
	}
	if _, err := normalizeComment(strings.Repeat("ạ", MaxMomentCommentRunes+1)); !errors.Is(err, errCommentTooLong) {
		t.Fatalf("expected errCommentTooLong, got %v", err)
	}
	for _, blank := range []string{"", "   ", "\n\t"} {
		if _, err := normalizeComment(blank); !errors.Is(err, errCommentEmpty) {
			t.Fatalf("expected errCommentEmpty for %q, got %v", blank, err)
		}
	}
}

func TestNextCommentOffsetNeedsAnExtraRow(t *testing.T) {
	if next := nextCommentOffset(0, 30, 30); next != nil {
		t.Fatalf("a full page without the extra row is the last page, got %d", *next)
	}
	if next := nextCommentOffset(30, 31, 30); next == nil || *next != 60 {
		t.Fatalf("expected next offset 60, got %v", next)
	}
	if next := nextCommentOffset(0, 0, 30); next != nil {
		t.Fatalf("an empty page has no next page, got %d", *next)
	}
}
