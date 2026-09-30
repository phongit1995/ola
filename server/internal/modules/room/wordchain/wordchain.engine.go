package wordchain

import (
	"errors"
	"time"

	"github.com/google/uuid"
)

var (
	errNoActiveGame  = errors.New("word chain has no active game")
	errNoGuessesLeft = errors.New("word chain player has no guesses left")
)

type GameState struct {
	SessionID        string         `json:"sessionId"`
	Word             string         `json:"word"`
	History          []string       `json:"history"`
	SessionStartedAt time.Time      `json:"sessionStartedAt"`
	LastProgressAt   time.Time      `json:"lastProgressAt"`
	Revision         int64          `json:"revision"`
	Turn             int64          `json:"turn"`
	WrongCounts      map[string]int `json:"wrongCounts,omitempty"`
	BotMessageID     string         `json:"botMessageId,omitempty"`
}

func (s GameState) RemainingGuesses(userID string) int {
	return max(MaxWrongGuesses-s.WrongCounts[userID], 0)
}

func (s GameState) withWrongGuess(userID string) GameState {
	counts := make(map[string]int, len(s.WrongCounts)+1)
	for id, count := range s.WrongCounts {
		counts[id] = count
	}
	counts[userID]++
	s.WrongCounts = counts
	return s
}

func (s GameState) historySet() map[string]struct{} {
	set := make(map[string]struct{}, len(s.History))
	for _, word := range s.History {
		set[word] = struct{}{}
	}
	return set
}

func (s GameState) Active() bool {
	return s.SessionID != "" && s.Word != ""
}

func (s GameState) HasPlayerWord() bool {
	return len(s.History) > 1
}

func (s GameState) CanExpire() bool {
	return s.Active() && !s.HasPlayerWord()
}

func (s GameState) ExpiresAt() time.Time {
	return s.LastProgressAt.Add(BotWordTimeout)
}

func (s GameState) Expired(now time.Time) bool {
	return s.CanExpire() && !now.Before(s.ExpiresAt())
}

func (s GameState) withBotWord(word string, now time.Time) GameState {
	s.Word = word
	s.History = []string{word}
	s.Turn++
	s.WrongCounts = nil
	s.LastProgressAt = now
	return s
}

type WordOracle interface {
	Exists(word string) (bool, error)
	HasContinuation(syllable string, used map[string]struct{}) (bool, error)
	StartWord() (string, error)
}

type MoveResult struct {
	Code             string
	Normalized       string
	RequiredSyllable string
	RemainingGuesses int
	Scored           bool
	StateChanged     bool
	State            GameState
}

func newSession(word string, now time.Time) GameState {
	return GameState{
		SessionID:        uuid.NewString(),
		Word:             word,
		History:          []string{word},
		SessionStartedAt: now,
		LastProgressAt:   now,
		Turn:             1,
	}
}

func processMove(state GameState, userID, raw string, oracle WordOracle) (MoveResult, error) {
	if !state.Active() {
		return MoveResult{}, errNoActiveGame
	}
	if state.RemainingGuesses(userID) == 0 {
		return MoveResult{}, errNoGuessesLeft
	}
	normalized := normalizeVietnamese(raw)
	res := MoveResult{
		Normalized:       normalized,
		RequiredSyllable: lastWord(state.Word),
		State:            state,
	}
	wrong := func(code string) (MoveResult, error) {
		res.Code = code
		res.StateChanged = true
		res.State = state.withWrongGuess(userID)
		res.RemainingGuesses = res.State.RemainingGuesses(userID)
		return res, nil
	}

	if len(splitSyllables(normalized)) != WordLength {
		return wrong(CodeInvalidFormat)
	}
	if firstWord(normalized) != res.RequiredSyllable {
		return wrong(CodeMismatch)
	}
	history := state.historySet()
	if _, used := history[normalized]; used {
		return wrong(CodeRepeated)
	}

	exists, err := oracle.Exists(normalized)
	if err != nil {
		return MoveResult{}, err
	}
	if !exists {
		return wrong(CodeNotInDict)
	}

	res.Scored = true
	res.StateChanged = true
	res.RemainingGuesses = MaxWrongGuesses
	history[normalized] = struct{}{}
	hasNext, err := oracle.HasContinuation(lastWord(normalized), history)
	if err != nil {
		return MoveResult{}, err
	}

	next := state
	next.Turn = state.Turn + 1
	next.WrongCounts = nil
	if !hasNext {
		word, err := oracle.StartWord()
		if err != nil {
			return MoveResult{}, err
		}
		res.Code = CodeWin
		next.Word = word
		next.History = []string{word}
	} else {
		res.Code = CodeOK
		next.Word = normalized
		next.History = append(append([]string{}, state.History...), normalized)
	}
	if len(next.History) > MaxHistory {
		next.History = next.History[len(next.History)-MaxHistory:]
	}
	res.State = next
	return res, nil
}

func reactionFor(code string) string {
	switch code {
	case CodeOK:
		return ReactionOK
	case CodeWin:
		return ReactionWin
	case CodeInvalidFormat:
		return ReactionInvalidFormat
	}
	return ReactionError
}
