package wargod

import (
	"encoding/json"
	"errors"
	"ola-chat-server/internal/game/logic"
)

type State struct {
	Placeholder bool `json:"placeholder"`
}

type Logic struct{}

func init() {
	logic.Register(Logic{})
}

func (Logic) ID() string { return "war-god" }

func (Logic) StateVersion() int { return 1 }

func (Logic) Init(seed int64) any {
	return &State{Placeholder: true}
}

func (Logic) DecodeState(data json.RawMessage) (any, error) {
	var state State
	if err := json.Unmarshal(data, &state); err != nil {
		return nil, errors.New("invalid saved war-god state")
	}
	return &state, nil
}

func (Logic) ValidateMove(state any, playerIdx int, move json.RawMessage) error {
	return errors.New("war-god is not implemented yet")
}

func (Logic) Apply(state any, playerIdx int, move json.RawMessage) (any, error) {
	return state, errors.New("war-god is not implemented yet")
}

func (Logic) Result(state any) (bool, int) {
	return false, -1
}
