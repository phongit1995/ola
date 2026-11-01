package tycoon

import (
	"bytes"
	"os"
	"testing"
)

func TestParityFixtureIsCurrent(t *testing.T) {
	want, err := os.ReadFile("testdata/parity.json")
	if err != nil {
		t.Fatal(err)
	}
	got, err := EncodeParityFixture(ExportParityFixture())
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Equal(got, want) {
		t.Fatal("testdata/parity.json is stale; run `go generate ./internal/game/games/tycoon`")
	}
}
