package wordchain

import "time"

const (
	WordLength              = 2
	MaxHistory              = 100
	MaxWrongGuesses         = 3
	NewWordMaxAttempts      = 100000
	StartWordMaxAttempts    = 10
	ContinuationConcurrency = 10
	BotWordRetryDelay       = 30 * time.Second
	MoveMaxAttempts         = 3
	WordExistsCacheTTL      = 24 * time.Hour
	BotWordTimeout          = 12 * time.Hour
	LeaderboardLimit        = 10
	MessagePageSize         = 50
	MessagePageMax          = 100
	MaxStoredMessages       = 5000
	BackgroundTimeout       = 30 * time.Second

	LookupURL             = "https://dict.minhqnd.com/api/v1/lookup"
	SuggestURL            = "https://dict.minhqnd.com/api/v1/suggest"
	SuggestLimit          = "50"
	LookupTimeout         = 5 * time.Second
	LookupMaxBytes        = 128 * 1024
	LookupMaxWordRunes    = 80
	LookupCooldownSeconds = 5
	LookupLangVietnamese  = "vi"

	LockTTL       = 15 * time.Second
	LockWait      = 10 * time.Second
	LockRetryWait = 25 * time.Millisecond

	CacheKeyLock           = "LOCK:WORD_CHAIN"
	CacheKeyState          = "WORD_CHAIN:STATE"
	CacheKeyPoints         = "WORD_CHAIN:POINTS"
	CacheKeyMsgIndex       = "WORD_CHAIN:MSG_INDEX"
	CacheKeyMsgData        = "WORD_CHAIN:MSG"
	CacheKeyMsgSeq         = "WORD_CHAIN:MSG_SEQ"
	CacheKeyStateRev       = "WORD_CHAIN:STATE_REV"
	CacheKeyWordExists     = "WORD_CHAIN:WORD_EXISTS:%s"
	CacheKeyLookupCooldown = "WORD_CHAIN:LOOKUP_COOLDOWN:%s"

	CodeOK            = "ok"
	CodeWin           = "win"
	CodeMismatch      = "mismatch"
	CodeRepeated      = "repeated"
	CodeNotInDict     = "not_in_dict"
	CodeInvalidFormat = "invalid_format"

	ReactionOK            = "✅"
	ReactionWin           = "🏆"
	ReactionInvalidFormat = "⚠️"
	ReactionError         = "❌"

	MessageTypeMove           = "move"
	MessageTypeWin            = "win"
	MessageTypeGameStarted    = "game_started"
	MessageTypeSessionStarted = "session_started"
	MessageTypeWrongAnswer    = "wrong_answer"

	SenderTypeUser = "user"
	SenderTypeBot  = "bot"

	ErrorCodeVerifyFailed = "WORD_CHAIN_VERIFY_FAILED"
	ErrorCodeCooldown     = "WORD_CHAIN_COOLDOWN"
	ErrorCodeNoGuesses    = "WORD_CHAIN_NO_GUESSES"
	ErrorCodeWaitTurn     = "WORD_CHAIN_WAIT_TURN"
	ErrorCodeNoHint       = "WORD_CHAIN_NO_HINT"
	ErrorCodeKenShort     = "WORD_CHAIN_INSUFFICIENT_KEN"

	HintPriceKen = 500
	HintMaxWords = 5
)
