package wordchain

import (
	"context"
	"ola-chat-server/internal/constants"
	roomEvents "ola-chat-server/internal/domain/room"
	"time"
)

type EventPublisher interface {
	PublishWordChainEvent(ctx context.Context, event *roomEvents.WordChainEvent) error
}

type storedMessage struct {
	ID               string `json:"id"`
	Seq              int64  `json:"seq"`
	SessionID        string `json:"sessionId"`
	Type             string `json:"type"`
	SenderType       string `json:"senderType"`
	SenderID         string `json:"senderId,omitempty"`
	Content          string `json:"content"`
	Word             string `json:"word,omitempty"`
	Code             string `json:"code,omitempty"`
	Reaction         string `json:"reaction,omitempty"`
	RequiredSyllable string `json:"requiredSyllable,omitempty"`
	RemainingGuesses *int   `json:"remainingGuesses,omitempty"`
	CreatedAt        string `json:"createdAt"`
}

type Message struct {
	storedMessage
	SenderName   string  `json:"senderName,omitempty"`
	SenderAvatar string  `json:"senderAvatar,omitempty"`
	SenderGender string  `json:"senderGender,omitempty"`
	SenderVip    *string `json:"senderVip,omitempty"`
	SenderVipEnd *string `json:"senderVipEnd,omitempty"`
}

type MessageListResponse struct {
	Items      []Message `json:"items"`
	HasMore    bool      `json:"hasMore"`
	NextBefore string    `json:"nextBefore,omitempty"`
}

type MoveRequest struct {
	Content   string `json:"content" binding:"required,min=1,max=200" example:"chân trời"`
	SessionID string `json:"sessionId" example:"7b0c8f3e-2a51-4c1e-9d2f-5a6b7c8d9e0f"`
	Turn      *int64 `json:"turn" binding:"omitempty,min=0" example:"3"`
}

type MoveResponse struct {
	Message          Message        `json:"message"`
	BotMessages      []Message      `json:"botMessages"`
	State            *StateResponse `json:"state"`
	Points           int64          `json:"points"`
	RemainingGuesses int            `json:"remainingGuesses"`
}

type StateResponse struct {
	SessionID        string `json:"sessionId,omitempty"`
	Revision         int64  `json:"revision"`
	Turn             int64  `json:"turn"`
	GuessLimit       int    `json:"guessLimit"`
	Word             string `json:"word,omitempty"`
	RequiredSyllable string `json:"requiredSyllable,omitempty"`
	HistoryCount     int    `json:"historyCount"`
	SessionStartedAt string `json:"sessionStartedAt,omitempty"`
	LastProgressAt   string `json:"lastProgressAt,omitempty"`
	WordExpiresAt    string `json:"wordExpiresAt,omitempty"`
	WordOwnerID      string `json:"wordOwnerId,omitempty"`
}

type OverviewResponse struct {
	State            *StateResponse `json:"state"`
	Points           int64          `json:"points"`
	RemainingGuesses int            `json:"remainingGuesses"`
	HintPrice        int            `json:"hintPrice"`
}

type HintResponse struct {
	SessionID  string   `json:"sessionId"`
	Turn       int64    `json:"turn"`
	Word       string   `json:"word"`
	Hints      []string `json:"hints"`
	Price      int      `json:"price"`
	KenBalance int      `json:"kenBalance"`
	Charged    bool     `json:"charged"`
}

type LeaderboardEntry struct {
	Rank     int    `json:"rank"`
	UserID   string `json:"userId"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
	Points   int64  `json:"points"`
	Wins     int64  `json:"wins"`
}

type LeaderboardResponse struct {
	Items  []LeaderboardEntry `json:"items"`
	Total  int64              `json:"total"`
	Me     *LeaderboardEntry  `json:"me"`
	Sort   string             `json:"sort"`
	Period string             `json:"period"`
}

type WinEntry struct {
	ID           string `json:"id"`
	UserID       string `json:"userId"`
	Username     string `json:"username"`
	FullName     string `json:"fullName,omitempty"`
	Avatar       string `json:"avatar,omitempty"`
	Word         string `json:"word"`
	PreviousWord string `json:"previousWord"`
	CreatedAt    string `json:"createdAt"`
}

type WinListResponse struct {
	Items      []WinEntry `json:"items"`
	HasMore    bool       `json:"hasMore"`
	NextBefore string     `json:"nextBefore,omitempty"`
}

type LookupMeaning struct {
	Definition string `json:"definition"`
	Pos        string `json:"pos,omitempty"`
	SubPos     string `json:"subPos,omitempty"`
	Example    string `json:"example,omitempty"`
}

type LookupTranslation struct {
	Translation string `json:"translation"`
	LangName    string `json:"langName"`
}

type LookupRelation struct {
	Word string `json:"word"`
	Type string `json:"type"`
}

type LookupResult struct {
	LangCode     string              `json:"langCode"`
	LangName     string              `json:"langName"`
	Meanings     []LookupMeaning     `json:"meanings"`
	Translations []LookupTranslation `json:"translations"`
	Relations    []LookupRelation    `json:"relations"`
}

type LookupResponse struct {
	Word    string         `json:"word"`
	Found   bool           `json:"found"`
	Message string         `json:"message,omitempty"`
	Results []LookupResult `json:"results"`
	Source  string         `json:"source"`
}

type AdminPlayer struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type AdminOverviewResponse struct {
	State     *StateResponse `json:"state"`
	History   []string       `json:"history"`
	WordOwner *AdminPlayer   `json:"wordOwner,omitempty"`
	Players   int64          `json:"players"`
	Winners   int64          `json:"winners"`
}

func toStateView(state GameState) *StateResponse {
	view := &StateResponse{
		Revision:     state.Revision,
		Turn:         state.Turn,
		GuessLimit:   constants.WordChainMaxWrongGuesses,
		Word:         state.Word,
		HistoryCount: len(state.History),
		WordOwnerID:  state.WordOwnerID,
	}
	if state.Word != "" {
		view.RequiredSyllable = lastWord(state.Word)
	}
	if state.Active() {
		view.SessionID = state.SessionID.String()
		view.SessionStartedAt = state.SessionStartedAt.UTC().Format(time.RFC3339)
		view.LastProgressAt = state.LastProgressAt.UTC().Format(time.RFC3339)
	}
	if state.CanExpire() {
		view.WordExpiresAt = state.ExpiresAt().UTC().Format(time.RFC3339)
	}
	return view
}
