package tycoon

import "encoding/json"

type Move struct {
	Type string `json:"type"`
	Tile *int   `json:"tile,omitempty"`
}

func parseMove(raw json.RawMessage) (Move, error) {
	var mv Move
	if err := json.Unmarshal(raw, &mv); err != nil || mv.Type == "" {
		return Move{}, ruleError(ErrInvalidMove)
	}
	return mv, nil
}
