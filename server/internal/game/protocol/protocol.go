package protocol

import "encoding/json"

const RoomStatusPlaying = "playing"

const (
	C2SQueueJoin     = "QUEUE_JOIN"
	C2SQueueLeave    = "QUEUE_LEAVE"
	C2SMove          = "MOVE"
	C2SChatSend      = "CHAT_SEND"
	C2SReactionSend  = "REACTION_SEND"
	C2SForfeit       = "FORFEIT"
	C2SRoomCreate    = "ROOM_CREATE"
	C2SRoomJoin      = "ROOM_JOIN"
	C2SRoomLeave     = "ROOM_LEAVE"
	C2SRoomList      = "ROOM_LIST"
	C2SRoomKick      = "ROOM_KICK"
	C2SRoomReady     = "ROOM_READY"
	C2SRoomStart     = "ROOM_START"
	C2SLeaderboard   = "LEADERBOARD"
	C2SHistory       = "HISTORY"
	C2SSpectateList  = "SPECTATE_LIST"
	C2SSpectateJoin  = "SPECTATE_JOIN"
	C2SSpectateLeave = "SPECTATE_LEAVE"

	S2CUserInfo             = "USER_INFO"
	S2CQueueWaiting         = "QUEUE_WAITING"
	S2CMatchFound           = "MATCH_FOUND"
	S2CState                = "STATE"
	S2CChatMessage          = "CHAT_MESSAGE"
	S2CReaction             = "REACTION"
	S2CMatchOver            = "MATCH_OVER"
	S2CError                = "ERROR"
	S2CRoomList             = "ROOM_LIST"
	S2CRoomUpsert           = "ROOM_UPSERT"
	S2CRoomRemoved          = "ROOM_REMOVED"
	S2CRoomWaiting          = "ROOM_WAITING"
	S2CRoomState            = "ROOM_STATE"
	S2CRoomSync             = "ROOM_SYNC"
	S2CRoomClosed           = "ROOM_CLOSED"
	S2CRoomKicked           = "ROOM_KICKED"
	S2COpponentDisconnected = "OPPONENT_DISCONNECTED"
	S2COpponentReconnected  = "OPPONENT_RECONNECTED"
	S2CLeaderboard          = "LEADERBOARD"
	S2CHistory              = "HISTORY"
	S2CSpectateList         = "SPECTATE_LIST"
	S2CSpectateJoined       = "SPECTATE_JOINED"
	S2CSpectateLeft         = "SPECTATE_LEFT"
)

const (
	SpectateLeftReasonLeft      = "left"
	SpectateLeftReasonMatchOver = "match_over"
)

const (
	ErrorCodeAlreadyInRoom        = "ALREADY_IN_ROOM"
	ErrorCodeBetNotAllowed        = "BET_NOT_ALLOWED"
	ErrorCodeChatRateLimited      = "CHAT_RATE_LIMITED"
	ErrorCodeChatTooLong          = "CHAT_TOO_LONG"
	ErrorCodeInsufficientKen      = "INSUFFICIENT_KEN"
	ErrorCodeInvalidBet           = "INVALID_BET"
	ErrorCodeInvalidChat          = "INVALID_CHAT"
	ErrorCodeInvalidMove          = "INVALID_MOVE"
	ErrorCodeInvalidPassword      = "INVALID_PASSWORD"
	ErrorCodeInvalidReaction      = "INVALID_REACTION"
	ErrorCodeInRoom               = "IN_ROOM"
	ErrorCodeMatchMismatch        = "MATCH_MISMATCH"
	ErrorCodeMatchStartFailed     = "MATCH_START_FAILED"
	ErrorCodeNotRoomMember        = "NOT_ROOM_MEMBER"
	ErrorCodeNotRoomOwner         = "NOT_ROOM_OWNER"
	ErrorCodeNotYourTurn          = "NOT_YOUR_TURN"
	ErrorCodeNoMatch              = "NO_MATCH"
	ErrorCodeOwnRoom              = "OWN_ROOM"
	ErrorCodeRoomBusy             = "ROOM_BUSY"
	ErrorCodeRoomCreateFailed     = "ROOM_CREATE_FAILED"
	ErrorCodeRoomFull             = "ROOM_FULL"
	ErrorCodeRoomJoinFailed       = "ROOM_JOIN_FAILED"
	ErrorCodeRoomLeaveFailed      = "ROOM_LEAVE_FAILED"
	ErrorCodeRoomListFailed       = "ROOM_LIST_FAILED"
	ErrorCodeRoomMemberNotFound   = "ROOM_MEMBER_NOT_FOUND"
	ErrorCodeRoomMismatch         = "ROOM_MISMATCH"
	ErrorCodeRoomNotFound         = "ROOM_NOT_FOUND"
	ErrorCodeRoomNotFull          = "ROOM_NOT_FULL"
	ErrorCodeRoomNotReady         = "ROOM_NOT_READY"
	ErrorCodeRoomStartFailed      = "ROOM_START_FAILED"
	ErrorCodeRoomUpdateFailed     = "ROOM_UPDATE_FAILED"
	ErrorCodeReactionRateLimited  = "REACTION_RATE_LIMITED"
	ErrorCodeSpectateFailed       = "SPECTATE_FAILED"
	ErrorCodeSpectateFull         = "SPECTATE_FULL"
	ErrorCodeSpectateNotSupported = "SPECTATE_NOT_SUPPORTED"
	ErrorCodeSpectateOwnMatch     = "SPECTATE_OWN_MATCH"
	ErrorCodeMatchNotFound        = "MATCH_NOT_FOUND"
	ErrorCodeStateSaveFailed      = "STATE_SAVE_FAILED"
	ErrorCodeUnknownGame          = "UNKNOWN_GAME"
	ErrorCodeUserInfoFailed       = "USER_INFO_FAILED"
	ErrorCodeWrongPassword        = "WRONG_PASSWORD"
)

const (
	ReactionTypeLike  = "LIKE"
	ReactionTypeLove  = "LOVE"
	ReactionTypeHaha  = "HAHA"
	ReactionTypeWow   = "WOW"
	ReactionTypeSad   = "SAD"
	ReactionTypeAngry = "ANGRY"
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
	ID      string  `json:"id"`
	Name    string  `json:"name"`
	VipType *string `json:"vipType,omitempty"`
	Level   int     `json:"level,omitempty"`
}

type UserInfoData struct {
	ID       string  `json:"id"`
	Username string  `json:"username"`
	VipType  *string `json:"vipType,omitempty"`
	VipDays  int     `json:"vipDays"`
	Ken      int     `json:"ken"`
	MaxBet   int     `json:"maxBet"`
	Level    int     `json:"level"`
	Exp      int64   `json:"exp"`
}

type LeaderboardRequestData struct {
	Period string `json:"period"`
}

type LeaderboardEntry struct {
	Rank     int     `json:"rank"`
	UserID   string  `json:"userId"`
	Username string  `json:"username"`
	VipType  *string `json:"vipType,omitempty"`
	Ken      int64   `json:"ken"`
	Wins     int64   `json:"wins"`
	Losses   int64   `json:"losses"`
	Level    int     `json:"level,omitempty"`
}

type LeaderboardData struct {
	Period string             `json:"period"`
	From   int64              `json:"from"`
	To     int64              `json:"to"`
	Items  []LeaderboardEntry `json:"items"`
	Error  string             `json:"error,omitempty"`
}

type MatchHistoryEntry struct {
	ID              string  `json:"id"`
	PlayedAt        int64   `json:"playedAt"`
	OpponentID      string  `json:"opponentId"`
	OpponentName    string  `json:"opponentName"`
	OpponentVipType *string `json:"opponentVipType,omitempty"`
	Bet             int     `json:"bet"`
	Outcome         string  `json:"outcome"`
	// KenDelta is signed from the requesting player's point of view: the
	// commission-adjusted net gain when they won, -bet when they lost, 0 on a draw.
	KenDelta int `json:"kenDelta"`
}

type MatchHistoryData struct {
	Items []MatchHistoryEntry `json:"items"`
	Error string              `json:"error,omitempty"`
}

type MatchFoundData struct {
	MatchID     string       `json:"matchId"`
	GameID      string       `json:"gameId"`
	Players     []PlayerInfo `json:"players"`
	You         int          `json:"you"`
	State       any          `json:"state"`
	Turn        int          `json:"turn"`
	Deadline    int64        `json:"deadline"`
	Resumed     bool         `json:"resumed,omitempty"`
	Bet         int          `json:"bet,omitempty"`
	RoomOwnerID string       `json:"roomOwnerId,omitempty"`
}

type StateData struct {
	MatchID  string          `json:"matchId"`
	State    any             `json:"state"`
	Turn     int             `json:"turn"`
	Deadline int64           `json:"deadline"`
	LastMove json.RawMessage `json:"lastMove,omitempty"`
	LastBy   int             `json:"lastBy"`
	// AutoMoved marks a move the server played on behalf of LastBy because
	// their turn clock ran out, rather than a move that player sent.
	AutoMoved bool `json:"autoMoved,omitempty"`
}

type RankingEntry struct {
	UserID string `json:"userId"`
	Place  int    `json:"place"`
}

type ExpGainEntry struct {
	UserID string `json:"userId"`
	Exp    int    `json:"exp"`
}

type MatchOverData struct {
	MatchID  string         `json:"matchId"`
	WinnerID string         `json:"winnerId,omitempty"`
	Reason   string         `json:"reason"`
	State    any            `json:"state"`
	Bet      int            `json:"bet,omitempty"`
	Payout   int            `json:"payout,omitempty"`
	KenDelta int            `json:"kenDelta"`
	Rankings []RankingEntry `json:"rankings,omitempty"`
	ExpGains []ExpGainEntry `json:"expGains,omitempty"`
}

type SpectateJoinData struct {
	MatchID string `json:"matchId"`
}

type SpectateLeaveData struct {
	MatchID string `json:"matchId,omitempty"`
}

type SpectateListEntry struct {
	MatchID    string       `json:"matchId"`
	RoomID     string       `json:"roomId,omitempty"`
	Players    []PlayerInfo `json:"players"`
	Bet        int          `json:"bet,omitempty"`
	StartedAt  int64        `json:"startedAt"`
	Spectators int          `json:"spectators"`
}

type SpectateListData struct {
	Matches []SpectateListEntry `json:"matches"`
}

type SpectateJoinedData struct {
	MatchID     string       `json:"matchId"`
	GameID      string       `json:"gameId"`
	Players     []PlayerInfo `json:"players"`
	State       any          `json:"state"`
	Turn        int          `json:"turn"`
	Deadline    int64        `json:"deadline"`
	Bet         int          `json:"bet,omitempty"`
	RoomOwnerID string       `json:"roomOwnerId,omitempty"`
	Spectators  int          `json:"spectators"`
}

type SpectateLeftData struct {
	MatchID string `json:"matchId"`
	Reason  string `json:"reason"`
}

type ErrorData struct {
	Code    string `json:"code"`
	Message string `json:"message"`
}

type MoveCommand struct {
	MatchID string          `json:"matchId"`
	Move    json.RawMessage `json:"move"`
}

type ChatSendData struct {
	MatchID string `json:"matchId,omitempty"`
	RoomID  string `json:"roomId,omitempty"`
	Text    string `json:"text"`
}

type ChatMessageData struct {
	MatchID string `json:"matchId,omitempty"`
	RoomID  string `json:"roomId,omitempty"`
	UserID  string `json:"userId"`
	Name    string `json:"name"`
	Text    string `json:"text"`
	SentAt  int64  `json:"sentAt"`
}

type ReactionSendData struct {
	MatchID string `json:"matchId"`
	Type    string `json:"type"`
}

type ReactionData struct {
	MatchID string `json:"matchId"`
	UserID  string `json:"userId"`
	Type    string `json:"type"`
	SentAt  int64  `json:"sentAt"`
}

type ForfeitData struct {
	MatchID    string `json:"matchId"`
	LeaveAfter bool   `json:"leaveAfter,omitempty"`
}

type RoomCreateData struct {
	Bet        int    `json:"bet"`
	Password   string `json:"password"`
	MaxPlayers int    `json:"maxPlayers,omitempty"`
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
	ID           string  `json:"id"`
	Owner        string  `json:"owner"`
	OwnerVipType *string `json:"ownerVipType,omitempty"`
	Bet          int     `json:"bet"`
	Locked       bool    `json:"locked"`
	Players      int     `json:"players"`
	MaxPlayers   int     `json:"maxPlayers,omitempty"`
	Full         bool    `json:"full,omitempty"`
	Status       string  `json:"status,omitempty"`
	MatchID      string  `json:"matchId,omitempty"`
}

type RoomListData struct {
	Rooms []RoomInfo `json:"rooms"`
}

type RoomUpsertData struct {
	Room RoomInfo `json:"room"`
}

type RoomRemovedData struct {
	RoomID string `json:"roomId"`
}

type RoomWaitingData struct {
	RoomID     string `json:"roomId"`
	Bet        int    `json:"bet"`
	Locked     bool   `json:"locked"`
	MaxPlayers int    `json:"maxPlayers,omitempty"`
}

type RoomMember struct {
	ID      string  `json:"id"`
	Name    string  `json:"name"`
	VipType *string `json:"vipType,omitempty"`
	Level   int     `json:"level,omitempty"`
	Owner   bool    `json:"owner"`
	Ready   bool    `json:"ready"`
}

type RoomStateData struct {
	RoomID       string       `json:"roomId"`
	OwnerID      string       `json:"ownerId"`
	YouID        string       `json:"youId"`
	Bet          int          `json:"bet"`
	Locked       bool         `json:"locked"`
	MaxPlayers   int          `json:"maxPlayers,omitempty"`
	Members      []RoomMember `json:"members"`
	AfterMatchID string       `json:"afterMatchId,omitempty"`
}

type RoomSyncData struct {
	RoomID string `json:"roomId,omitempty"`
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
	GraceDeadline   int64  `json:"graceDeadline"`
	TurnRemainingMs int64  `json:"turnRemainingMs,omitempty"`
	UserID          string `json:"userId,omitempty"`
}

type OpponentReconnectedData struct {
	UserID   string `json:"userId,omitempty"`
	Turn     int    `json:"turn"`
	Deadline int64  `json:"deadline"`
}
