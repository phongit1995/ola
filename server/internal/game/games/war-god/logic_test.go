package wargod

import (
	"encoding/json"
	"testing"
)

func TestDecodeStateRestoresWarGodState(t *testing.T) {
	stateAny, err := (Logic{}).DecodeState(json.RawMessage(`{"placeholder":true}`))
	if err != nil {
		t.Fatal(err)
	}
	if !stateAny.(*State).Placeholder {
		t.Fatal("War God state was not restored")
	}
}

func TestDecodeStateRejectsMalformedWarGodState(t *testing.T) {
	if _, err := (Logic{}).DecodeState(json.RawMessage(`{"placeholder":`)); err == nil {
		t.Fatal("malformed War God state was accepted")
	}
}

func TestWarGodStateVersion(t *testing.T) {
	if version := (Logic{}).StateVersion(); version != 1 {
		t.Fatalf("unexpected state version: %d", version)
	}
}
