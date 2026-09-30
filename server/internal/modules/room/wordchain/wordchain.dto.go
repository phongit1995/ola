package wordchain

import (
	"context"
	roomEvents "ola-chat-server/internal/domain/room"
)

type EventPublisher interface {
	PublishWordChainEvent(ctx context.Context, event *roomEvents.WordChainEvent) error
}

type Message struct {
	ID               string  `json:"id"`
	Seq              int64   `json:"seq"`
	SessionID        string  `json:"sessionId"`
	Type             string  `json:"type"`
	SenderType       string  `json:"senderType"`
	SenderID         string  `json:"senderId,omitempty"`
	SenderName       string  `json:"senderName,omitempty"`
	SenderAvatar     string  `json:"senderAvatar,omitempty"`
	SenderGender     string  `json:"senderGender,omitempty"`
	SenderVip        *string `json:"senderVip,omitempty"`
	SenderVipEnd     *string `json:"senderVipEnd,omitempty"`
	Content          string  `json:"content"`
	Word             string  `json:"word,omitempty"`
	Code             string  `json:"code,omitempty"`
	Reaction         string  `json:"reaction,omitempty"`
	RequiredSyllable string  `json:"requiredSyllable,omitempty"`
	RemainingGuesses *int    `json:"remainingGuesses,omitempty"`
	CreatedAt        string  `json:"createdAt"`
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

type MessageListResponse struct {
	Items      []Message `json:"items"`
	HasMore    bool      `json:"hasMore"`
	NextBefore string    `json:"nextBefore,omitempty"`
}

type MoveRequest struct {
	Content string `json:"content" binding:"required,min=1,max=200" example:"chân trời"`
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
}

type OverviewResponse struct {
	State            *StateResponse `json:"state"`
	Points           int64          `json:"points"`
	RemainingGuesses int            `json:"remainingGuesses"`
}

type LeaderboardEntry struct {
	Rank     int    `json:"rank"`
	UserID   string `json:"userId"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
	Points   int64  `json:"points"`
}

type LeaderboardResponse struct {
	Items []LeaderboardEntry `json:"items"`
	Total int64              `json:"total"`
	Me    *LeaderboardEntry  `json:"me"`
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
