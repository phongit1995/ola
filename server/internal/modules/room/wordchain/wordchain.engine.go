package wordchain

import (
	"errors"
	"ola-chat-server/internal/constants"
	"time"

	"github.com/google/uuid"
)

var (
	errNoActiveGame  = errors.New("word chain has no active game")
	errNoGuessesLeft = errors.New("word chain player has no guesses left")
	errOwnWord       = errors.New("word chain player must wait for someone else to chain their word")
)

type GameState struct {
	SessionID        uuid.UUID      `json:"sessionId"`
	Word             string         `json:"word"`
	History          []string       `json:"history"`
	SessionStartedAt time.Time      `json:"sessionStartedAt"`
	LastProgressAt   time.Time      `json:"lastProgressAt"`
	Revision         int64          `json:"revision"`
	Turn             int64          `json:"turn"`
	WrongCounts      map[string]int `json:"wrongCounts,omitempty"`
	BotMessageID     string         `json:"botMessageId,omitempty"`
	WordOwnerID      string         `json:"wordOwnerId,omitempty"`
}

type wordRef struct {
	SessionID string
	Turn      int64
}

func (s GameState) ref() wordRef {
	return wordRef{SessionID: s.SessionID.String(), Turn: s.Turn}
}

func (r wordRef) matches(state GameState) bool {
	return state.Active() && r == state.ref()
}

func (s GameState) RemainingGuesses(userID string) int {
	return max(constants.WordChainMaxWrongGuesses-s.WrongCounts[userID], 0)
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
	return s.SessionID != uuid.Nil && s.Word != ""
}

func (s GameState) HasPlayerWord() bool {
	return len(s.History) > 1
}

func (s GameState) CanExpire() bool {
	return s.Active() && !s.HasPlayerWord()
}

func (s GameState) ExpiresAt() time.Time {
	return s.LastProgressAt.Add(constants.WordChainBotWordTimeout)
}

func (s GameState) Expired(now time.Time) bool {
	return s.CanExpire() && !now.Before(s.ExpiresAt())
}

func (s GameState) withBotWord(word string, now time.Time) GameState {
	s.Word = word
	s.History = []string{word}
	s.Turn++
	s.WrongCounts = nil
	s.WordOwnerID = ""
	s.LastProgressAt = now
	return s
}

func playable(state GameState, userID string) error {
	if state.WordOwnerID == userID {
		return errOwnWord
	}
	if state.RemainingGuesses(userID) == 0 {
		return errNoGuessesLeft
	}
	return nil
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
	State            GameState
}

func newSession(word string, now time.Time) GameState {
	return GameState{
		SessionID:        uuid.New(),
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
	if err := playable(state, userID); err != nil {
		return MoveResult{}, err
	}
	normalized := normalizeVietnamese(raw)
	res := MoveResult{
		Normalized:       normalized,
		RequiredSyllable: lastWord(state.Word),
	}
	wrong := func(code string) (MoveResult, error) {
		res.Code = code
		res.State = state.withWrongGuess(userID)
		res.RemainingGuesses = res.State.RemainingGuesses(userID)
		return res, nil
	}

	if len(splitSyllables(normalized)) != constants.WordChainWordLength {
		return wrong(constants.WordChainCodeInvalidFormat)
	}
	if firstWord(normalized) != res.RequiredSyllable {
		return wrong(constants.WordChainCodeMismatch)
	}
	history := state.historySet()
	if _, used := history[normalized]; used {
		return wrong(constants.WordChainCodeRepeated)
	}

	exists, err := oracle.Exists(normalized)
	if err != nil {
		return MoveResult{}, err
	}
	if !exists {
		return wrong(constants.WordChainCodeNotInDict)
	}

	res.Scored = true
	res.RemainingGuesses = constants.WordChainMaxWrongGuesses
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
		res.Code = constants.WordChainCodeWin
		next.Word = word
		next.History = []string{word}
		next.WordOwnerID = ""
	} else {
		res.Code = constants.WordChainCodeOK
		next.Word = normalized
		next.History = append(append([]string{}, state.History...), normalized)
		next.WordOwnerID = userID
	}
	if len(next.History) > constants.WordChainMaxHistory {
		next.History = next.History[len(next.History)-constants.WordChainMaxHistory:]
	}
	res.State = next
	return res, nil
}

func reactionFor(code string) string {
	switch code {
	case constants.WordChainCodeOK:
		return constants.WordChainReactionOK
	case constants.WordChainCodeWin:
		return constants.WordChainReactionWin
	case constants.WordChainCodeInvalidFormat:
		return constants.WordChainReactionInvalidFormat
	}
	return constants.WordChainReactionError
}
