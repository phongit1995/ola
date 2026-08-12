package main

import (
	"bytes"
	"os"
	"testing"

	wargod "ola-chat-server/internal/game/games/war-god"
)

func TestGeneratedConstantsAreCurrent(t *testing.T) {
	want, err := os.ReadFile("../../../game/war-god/logic/constants.gen.ts")
	if err != nil {
		t.Fatal(err)
	}
	got := renderConstants(wargod.ExportClientConfig())
	if !bytes.Equal(got, want) {
		t.Fatal("constants.gen.ts is stale; run `go generate ./internal/game/games/war-god`")
	}
}
