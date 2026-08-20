package xiangqi

import (
	"bytes"
	"encoding/json"
	"os"
	"testing"
)

func TestParityFixtureFresh(t *testing.T) {
	got, err := json.MarshalIndent(ExportParityFixture(), "", "  ")
	if err != nil {
		t.Fatal(err)
	}
	got = append(got, '\n')
	want, err := os.ReadFile("testdata/parity.json")
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Equal(got, want) {
		t.Fatal("testdata/parity.json is stale; run `go generate ./internal/game/games/xiangqi`")
	}
}

func TestExportClientConfig(t *testing.T) {
	config := ExportClientConfig()
	if config.GameID != GameID || config.TurnSeconds != TurnSeconds || len(config.StartBoard) != BoardCells {
		t.Fatal("client config mismatch")
	}
}
