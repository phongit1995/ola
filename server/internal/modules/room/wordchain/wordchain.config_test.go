package wordchain

import (
	"context"
	"errors"
	"testing"
	"time"

	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

type fakeSettings struct {
	cfg setting.WordChainConfig
	err error
}

func (f *fakeSettings) GetWordChain() (setting.WordChainConfig, error) {
	return f.cfg, f.err
}

func hasErrorCode(err error, code string) bool {
	var httpErr *utils.HTTPError
	return errors.As(err, &httpErr) && httpErr.Code == code
}

func TestDisabledRoomRejectsPlayAndHint(t *testing.T) {
	wallet := &fakeWallet{balance: 2000}
	svc := newHintService(t, newSession("mặt trời", time.Now()), wallet)
	svc.settings = &fakeSettings{cfg: setting.WordChainConfig{Enabled: false, HintPrice: 500}}
	ctx := context.Background()
	userID := uuid.New()

	if _, err := svc.Overview(ctx, userID); !errors.Is(err, ErrDisabled) {
		t.Fatalf("overview: err = %v, want ErrDisabled", err)
	}
	if _, err := svc.HandleMove(ctx, userID, &MoveRequest{Content: "trời đất"}); !errors.Is(err, ErrDisabled) {
		t.Fatalf("move: err = %v, want ErrDisabled", err)
	}
	if _, err := svc.Hint(ctx, userID); !errors.Is(err, ErrDisabled) {
		t.Fatalf("hint: err = %v, want ErrDisabled", err)
	}
	if len(wallet.charges) != 0 {
		t.Fatalf("disabled room must not charge: %+v", wallet.charges)
	}
	messages, err := svc.store.ListMessages(ctx, MessagePageSize, "")
	if err != nil {
		t.Fatal(err)
	}
	if len(messages) != 0 {
		t.Fatalf("disabled room must not store messages: %+v", messages)
	}
}

func TestOverviewReturnsConfiguredHintPrice(t *testing.T) {
	svc := newTestService(t)
	saveState(t, svc, newSession("mặt trời", time.Now()))
	svc.settings = &fakeSettings{cfg: setting.WordChainConfig{Enabled: true, HintPrice: 1200}}

	resp, err := svc.Overview(context.Background(), uuid.New())
	if err != nil {
		t.Fatal(err)
	}
	if resp.HintPrice != 1200 {
		t.Fatalf("hintPrice = %d, want 1200", resp.HintPrice)
	}
}

func TestSettingsErrorFallsBackToDefaults(t *testing.T) {
	svc := newTestService(t)
	saveState(t, svc, newSession("mặt trời", time.Now()))
	svc.settings = &fakeSettings{err: errors.New("db down")}

	resp, err := svc.Overview(context.Background(), uuid.New())
	if err != nil {
		t.Fatal(err)
	}
	if resp.HintPrice != setting.DefaultWordChainConfig().HintPrice {
		t.Fatalf("hintPrice = %d, want default", resp.HintPrice)
	}
}

func TestAdminOverviewDoesNotStartSession(t *testing.T) {
	svc := newTestService(t)
	ctx := context.Background()

	resp, err := svc.AdminOverview(ctx)
	if err != nil {
		t.Fatal(err)
	}
	if resp.State != nil || len(resp.History) != 0 || resp.Players != 0 || resp.Winners != 0 {
		t.Fatalf("unexpected overview for empty room: %+v", resp)
	}
	state, err := svc.store.LoadState(ctx)
	if err != nil {
		t.Fatal(err)
	}
	if state.Active() {
		t.Fatal("admin overview must not start a session")
	}
}

func TestAdminOverviewShowsCurrentGame(t *testing.T) {
	svc := newTestService(t)
	ctx := context.Background()
	state := newSession("mặt trời", time.Now())
	state.History = []string{"mặt trời", "trời đất"}
	state.Word = "trời đất"
	saveState(t, svc, state)
	winner := uuid.NewString()
	if _, err := svc.store.Apply(ctx, &Mutation{ScoreUserID: winner, WinUserID: winner}); err != nil {
		t.Fatal(err)
	}
	if _, err := svc.store.Apply(ctx, &Mutation{ScoreUserID: uuid.NewString()}); err != nil {
		t.Fatal(err)
	}

	resp, err := svc.AdminOverview(ctx)
	if err != nil {
		t.Fatal(err)
	}
	if resp.State == nil || resp.State.Word != "trời đất" || resp.State.RequiredSyllable != "đất" {
		t.Fatalf("state = %+v", resp.State)
	}
	if len(resp.History) != 2 || resp.History[1] != "trời đất" {
		t.Fatalf("history = %v", resp.History)
	}
	if resp.Players != 2 || resp.Winners != 1 || resp.WordOwner != nil {
		t.Fatalf("players = %d, winners = %d, owner = %+v", resp.Players, resp.Winners, resp.WordOwner)
	}
}
