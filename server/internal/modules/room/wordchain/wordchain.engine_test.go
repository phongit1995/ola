package wordchain

import (
	"errors"
	"testing"
	"time"
)

type deadEndOracle struct{ next string }

func (deadEndOracle) Exists(string) (bool, error) { return true, nil }

func (deadEndOracle) HasContinuation(string, map[string]struct{}) (bool, error) { return false, nil }

func (o deadEndOracle) StartWord() (string, error) { return o.next, nil }

func mustMove(t *testing.T, state GameState, userID, word string, oracle WordOracle) MoveResult {
	t.Helper()
	res, err := processMove(state, userID, word, oracle)
	if err != nil {
		t.Fatalf("%s plays %q: %v", userID, word, err)
	}
	return res
}

func TestPlayerCannotChainTwiceInARow(t *testing.T) {
	state := newSession("mặt trời", time.Now())

	first := mustMove(t, state, "lan", "trời đất", acceptAllOracle{})
	if first.Code != CodeOK || first.State.WordOwnerID != "lan" {
		t.Fatalf("lan should own the new word: %+v", first)
	}

	_, err := processMove(first.State, "lan", "đất nước", acceptAllOracle{})
	if !errors.Is(err, errOwnWord) {
		t.Fatalf("lan chaining her own word: err = %v, want errOwnWord", err)
	}
	if first.State.RemainingGuesses("lan") != MaxWrongGuesses {
		t.Fatalf("a blocked move must not cost a guess")
	}

	second := mustMove(t, first.State, "minh", "đất nước", acceptAllOracle{})
	if second.Code != CodeOK || second.State.WordOwnerID != "minh" {
		t.Fatalf("minh should chain lan's word: %+v", second)
	}
	if third := mustMove(t, second.State, "lan", "nước mặt", acceptAllOracle{}); third.Code != CodeOK {
		t.Fatalf("lan can play again after minh: %+v", third)
	}
}

func TestOwnerIsBlockedEvenForWrongGuesses(t *testing.T) {
	state := mustMove(t, newSession("mặt trời", time.Now()), "lan", "trời đất", acceptAllOracle{}).State

	if _, err := processMove(state, "lan", "sai", acceptAllOracle{}); !errors.Is(err, errOwnWord) {
		t.Fatalf("err = %v, want errOwnWord", err)
	}
	if res := mustMove(t, state, "minh", "sai", acceptAllOracle{}); res.Code != CodeInvalidFormat {
		t.Fatalf("other players still get normal judging: %+v", res)
	}
}

func TestBotWordsHaveNoOwner(t *testing.T) {
	state := mustMove(t, newSession("mặt trời", time.Now()), "lan", "trời đất", acceptAllOracle{}).State

	won := mustMove(t, state, "minh", "đất nước", deadEndOracle{next: "hoa hồng"})
	if won.Code != CodeWin || won.State.WordOwnerID != "" {
		t.Fatalf("the new game word belongs to the bot: %+v", won)
	}
	if next := mustMove(t, won.State, "minh", "hồng hào", acceptAllOracle{}); next.Code != CodeOK {
		t.Fatalf("the winner can open the next game: %+v", next)
	}

	replaced := state.withBotWord("cánh diều", time.Now())
	if replaced.WordOwnerID != "" {
		t.Fatalf("a replaced bot word must clear the owner")
	}
	if res := mustMove(t, replaced, "lan", "diều hâu", acceptAllOracle{}); res.Code != CodeOK {
		t.Fatalf("anyone can chain a bot word: %+v", res)
	}
}
