package protocol

import "encoding/json"

const (
	C2SQueueJoin  = "QUEUE_JOIN"
	C2SQueueLeave = "QUEUE_LEAVE"
	C2SMove       = "MOVE"
	C2SForfeit    = "FORFEIT"

	S2CQueueWaiting = "QUEUE_WAITING"
	S2CMatchFound   = "MATCH_FOUND"
	S2CState        = "STATE"
	S2CMatchOver    = "MATCH_OVER"
	S2CError        = "ERROR"
)

type Envelope struct {
	Type string          `json:"type"`
	Data json.RawMessage `json:"data,omitempty"`
}

type OutEnvelope struct {
	Type string `json:"type"`
	Data any    `json:"data,omitempty"`
}

type PlayerInfo struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

type MatchFoundData struct {
	MatchID  string       `json:"matchId"`
	GameID   string       `json:"gameId"`
	Players  []PlayerInfo `json:"players"`
	You      int          `json:"you"`
	State    any          `json:"state"`
	Turn     int          `json:"turn"`
	Deadline int64        `json:"deadline"`
	Resumed  bool         `json:"resumed,omitempty"`
}

type StateData struct {
	MatchID  string          `json:"matchId"`
	State    any             `json:"state"`
	Turn     int             `json:"turn"`
	Deadline int64           `json:"deadline"`
	LastMove json.RawMessage `json:"lastMove,omitempty"`
	LastBy   int             `json:"lastBy"`
}

type MatchOverData struct {
	MatchID  string `json:"matchId"`
	WinnerID string `json:"winnerId,omitempty"`
	Reason   string `json:"reason"`
	State    any    `json:"state"`
}

type ErrorData struct {
	Code    string `json:"code"`
	Message string `json:"message"`
}
