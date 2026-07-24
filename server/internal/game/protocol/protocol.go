package protocol

import "encoding/json"

const (
	C2SQueueJoin  = "QUEUE_JOIN"
	C2SQueueLeave = "QUEUE_LEAVE"
	C2SMove       = "MOVE"
	C2SForfeit    = "FORFEIT"
	C2SRoomCreate = "ROOM_CREATE"
	C2SRoomJoin   = "ROOM_JOIN"
	C2SRoomLeave  = "ROOM_LEAVE"
	C2SRoomList   = "ROOM_LIST"
	C2SRoomKick   = "ROOM_KICK"
	C2SRoomReady  = "ROOM_READY"
	C2SRoomStart  = "ROOM_START"

	S2CUserInfo             = "USER_INFO"
	S2CQueueWaiting         = "QUEUE_WAITING"
	S2CMatchFound           = "MATCH_FOUND"
	S2CState                = "STATE"
	S2CMatchOver            = "MATCH_OVER"
	S2CError                = "ERROR"
	S2CRoomList             = "ROOM_LIST"
	S2CRoomWaiting          = "ROOM_WAITING"
	S2CRoomState            = "ROOM_STATE"
	S2CRoomClosed           = "ROOM_CLOSED"
	S2CRoomKicked           = "ROOM_KICKED"
	S2COpponentDisconnected = "OPPONENT_DISCONNECTED"
	S2COpponentReconnected  = "OPPONENT_RECONNECTED"
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

type UserInfoData struct {
	Username string  `json:"username"`
	VipType  *string `json:"vipType,omitempty"`
	VipDays  int     `json:"vipDays"`
	Ken      int     `json:"ken"`
	Guest    bool    `json:"guest,omitempty"`
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
	Bet      int          `json:"bet,omitempty"`
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
	Bet      int    `json:"bet,omitempty"`
}

type ErrorData struct {
	Code    string `json:"code"`
	Message string `json:"message"`
}

type MoveCommand struct {
	MatchID string          `json:"matchId"`
	Move    json.RawMessage `json:"move"`
}

type ForfeitData struct {
	MatchID string `json:"matchId"`
}

type RoomCreateData struct {
	Bet      int    `json:"bet"`
	Password string `json:"password"`
}

type RoomJoinData struct {
	RoomID   string `json:"roomId"`
	Password string `json:"password"`
}

type RoomActionData struct {
	RoomID string `json:"roomId"`
}

type RoomKickData struct {
	RoomID string `json:"roomId"`
	UserID string `json:"userId"`
}

type RoomReadyData struct {
	RoomID string `json:"roomId"`
	Ready  bool   `json:"ready"`
}

type RoomInfo struct {
	ID      string `json:"id"`
	Owner   string `json:"owner"`
	Bet     int    `json:"bet"`
	Locked  bool   `json:"locked"`
	Players int    `json:"players"`
	Full    bool   `json:"full,omitempty"`
}

type RoomListData struct {
	Rooms []RoomInfo `json:"rooms"`
}

type RoomWaitingData struct {
	RoomID string `json:"roomId"`
	Bet    int    `json:"bet"`
	Locked bool   `json:"locked"`
}

type RoomMember struct {
	ID    string `json:"id"`
	Name  string `json:"name"`
	Owner bool   `json:"owner"`
	Ready bool   `json:"ready"`
}

type RoomStateData struct {
	RoomID  string       `json:"roomId"`
	OwnerID string       `json:"ownerId"`
	YouID   string       `json:"youId"`
	Bet     int          `json:"bet"`
	Locked  bool         `json:"locked"`
	Members []RoomMember `json:"members"`
}

type RoomClosedData struct {
	RoomID string `json:"roomId"`
	Reason string `json:"reason"`
}

type RoomKickedData struct {
	RoomID   string `json:"roomId"`
	ByUserID string `json:"byUserId"`
}

type OpponentDisconnectedData struct {
	GraceDeadline int64 `json:"graceDeadline"`
}
