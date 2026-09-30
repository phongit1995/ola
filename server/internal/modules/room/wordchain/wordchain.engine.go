package wordchain

import (
	"errors"
	"time"

	"github.com/google/uuid"
)

var errNoActiveGame = errors.New("word chain has no active game")

type GameState struct {
	SessionID        string    `json:"sessionId"`
	Word             string    `json:"word"`
	History          []string  `json:"history"`
	SessionStartedAt time.Time `json:"sessionStartedAt"`
	LastProgressAt   time.Time `json:"lastProgressAt"`
	Revision         int64     `json:"revision"`
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

func (s GameState) ExpiresAt() time.Time {
	return s.LastProgressAt.Add(SessionIdleTimeout)
}

func (s GameState) Expired(now time.Time) bool {
	return !now.Before(s.ExpiresAt())
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
	}
}

func processMove(state GameState, raw string, oracle WordOracle) (MoveResult, error) {
	if !state.Active() {
		return MoveResult{}, errNoActiveGame
	}
	normalized := normalizeVietnamese(raw)
	res := MoveResult{
		Normalized:       normalized,
		RequiredSyllable: lastWord(state.Word),
		State:            state,
	}

	if len(splitSyllables(normalized)) != WordLength {
		res.Code = CodeInvalidFormat
		return res, nil
	}
	if firstWord(normalized) != res.RequiredSyllable {
		res.Code = CodeMismatch
		return res, nil
	}
	history := state.historySet()
	if _, used := history[normalized]; used {
		res.Code = CodeRepeated
		return res, nil
	}

	exists, err := oracle.Exists(normalized)
	if err != nil {
		return MoveResult{}, err
	}
	if !exists {
		res.Code = CodeNotInDict
		return res, nil
	}

	res.Scored = true
	res.StateChanged = true
	history[normalized] = struct{}{}
	hasNext, err := oracle.HasContinuation(lastWord(normalized), history)
	if err != nil {
		return MoveResult{}, err
	}

	next := state
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
