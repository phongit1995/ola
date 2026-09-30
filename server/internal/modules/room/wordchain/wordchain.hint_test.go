package wordchain

import (
	"context"
	"encoding/json"
	"errors"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	"github.com/google/uuid"
)

type fakeWallet struct {
	balance int
	err     error
	charges []HintCharge
}

func (w *fakeWallet) ChargeHint(charge HintCharge) (int, error) {
	if w.err != nil {
		return 0, w.err
	}
	w.charges = append(w.charges, charge)
	w.balance -= charge.Price
	return w.balance, nil
}

type fakeDictionary struct {
	suggestions   []string
	suggestStatus int
}

func serveDictionary(t *testing.T, svc *Service, dict fakeDictionary) {
	t.Helper()
	mux := http.NewServeMux()
	mux.HandleFunc("/suggest", func(w http.ResponseWriter, _ *http.Request) {
		if dict.suggestStatus != 0 {
			w.WriteHeader(dict.suggestStatus)
			return
		}
		_ = json.NewEncoder(w).Encode(dictSuggest{Suggestions: dict.suggestions})
	})
	mux.HandleFunc("/lookup", func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusInternalServerError)
	})
	server := httptest.NewServer(mux)
	t.Cleanup(server.Close)
	svc.verifier.suggestURL = server.URL + "/suggest"
	svc.verifier.lookupURL = server.URL + "/lookup"
}

func newHintService(t *testing.T, state GameState, wallet *fakeWallet) *Service {
	t.Helper()
	svc := newTestService(t)
	svc.wallet = wallet
	serveDictionary(t, svc, fakeDictionary{})
	saveState(t, svc, state)
	return svc
}

func TestHintChargesAndReturnsValidWords(t *testing.T) {
	wallet := &fakeWallet{balance: 2000}
	svc := newHintService(t, newSession("mặt trời", time.Now()), wallet)
	userID := uuid.New()

	resp, err := svc.Hint(context.Background(), userID)
	if err != nil {
		t.Fatal(err)
	}
	if len(resp.Hints) != 1 || resp.Hints[0] != "trời đất" {
		t.Fatalf("hints = %v, want [trời đất]", resp.Hints)
	}
	if resp.Price != HintPriceKen || resp.KenBalance != 2000-HintPriceKen || resp.Word != "mặt trời" {
		t.Fatalf("unexpected response: %+v", resp)
	}
	if len(wallet.charges) != 1 || wallet.charges[0].UserID != userID || wallet.charges[0].Price != HintPriceKen {
		t.Fatalf("charges = %+v", wallet.charges)
	}
}

func TestHintSkipsWordsAlreadyPlayed(t *testing.T) {
	wallet := &fakeWallet{balance: 2000}
	state := newSession("trời đất", time.Now())
	state.History = []string{"mặt trời", "trời đất", "đất nước"}
	state.Word = "đất nước"
	svc := newHintService(t, state, wallet)

	resp, err := svc.Hint(context.Background(), uuid.New())
	if err != nil {
		t.Fatal(err)
	}
	if len(resp.Hints) != 1 || resp.Hints[0] != "nước mặt" {
		t.Fatalf("hints = %v, want [nước mặt]", resp.Hints)
	}
}

func TestHintIsFreeWhenNothingIsFound(t *testing.T) {
	wallet := &fakeWallet{balance: 2000}
	svc := newHintService(t, newSession("trời xa", time.Now()), wallet)

	_, err := svc.Hint(context.Background(), uuid.New())
	if !errors.Is(err, ErrNoHint) {
		t.Fatalf("err = %v, want ErrNoHint", err)
	}
	if len(wallet.charges) != 0 {
		t.Fatalf("no hint must not charge: %+v", wallet.charges)
	}
}

func TestHintBlockedWhenPlayerCannotMove(t *testing.T) {
	owner := uuid.New()
	state := newSession("mặt trời", time.Now())
	state.WordOwnerID = owner.String()
	state.WrongCounts = map[string]int{"out-of-guesses": MaxWrongGuesses}
	wallet := &fakeWallet{balance: 2000}
	svc := newHintService(t, state, wallet)

	if _, err := svc.Hint(context.Background(), owner); !errors.Is(err, ErrWaitTurn) {
		t.Fatalf("owner: err = %v, want ErrWaitTurn", err)
	}
	stuck := uuid.MustParse("00000000-0000-0000-0000-000000000001")
	state.WrongCounts = map[string]int{stuck.String(): MaxWrongGuesses}
	saveState(t, svc, state)
	if _, err := svc.Hint(context.Background(), stuck); !errors.Is(err, ErrNoGuessesLeft) {
		t.Fatalf("no guesses: err = %v, want ErrNoGuessesLeft", err)
	}
	if len(wallet.charges) != 0 {
		t.Fatalf("blocked players must not be charged: %+v", wallet.charges)
	}
}

func TestHintNeedsEnoughKen(t *testing.T) {
	wallet := &fakeWallet{err: errKenShort}
	svc := newHintService(t, newSession("mặt trời", time.Now()), wallet)

	if _, err := svc.Hint(context.Background(), uuid.New()); !errors.Is(err, ErrKenShort) {
		t.Fatalf("err = %v, want ErrKenShort", err)
	}
}

func TestHintIsFreeWhenAnyLookupFails(t *testing.T) {
	wallet := &fakeWallet{balance: 2000}
	svc := newHintService(t, newSession("mặt trời", time.Now()), wallet)
	serveDictionary(t, svc, fakeDictionary{suggestions: []string{"trời mưa"}})

	if _, err := svc.Hint(context.Background(), uuid.New()); !errors.Is(err, ErrVerifyFailed) {
		t.Fatalf("err = %v, want ErrVerifyFailed", err)
	}
	if len(wallet.charges) != 0 {
		t.Fatalf("failed lookup must not charge: %+v", wallet.charges)
	}
}

func TestHintIsFreeWhenSuggestFails(t *testing.T) {
	wallet := &fakeWallet{balance: 2000}
	svc := newHintService(t, newSession("mặt trời", time.Now()), wallet)
	serveDictionary(t, svc, fakeDictionary{suggestStatus: http.StatusBadGateway})

	if _, err := svc.Hint(context.Background(), uuid.New()); !errors.Is(err, ErrVerifyFailed) {
		t.Fatalf("err = %v, want ErrVerifyFailed", err)
	}
	if len(wallet.charges) != 0 {
		t.Fatalf("failed suggest must not charge: %+v", wallet.charges)
	}
}
