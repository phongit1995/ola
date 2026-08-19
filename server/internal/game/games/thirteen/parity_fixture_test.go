package thirteen

import (
	"bytes"
	"encoding/json"
	"os"
	"testing"
)

func TestParityFixtureIsCurrent(t *testing.T) {
	want, err := os.ReadFile("testdata/parity.json")
	if err != nil {
		t.Fatal(err)
	}
	got, err := json.MarshalIndent(ExportParityFixture(), "", "  ")
	if err != nil {
		t.Fatal(err)
	}
	got = append(got, '\n')
	if !bytes.Equal(got, want) {
		t.Fatal("testdata/parity.json is stale; run `go generate ./internal/game/games/thirteen`")
	}
}
