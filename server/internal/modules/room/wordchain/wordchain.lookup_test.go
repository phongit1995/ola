package wordchain

import (
	"context"
	"errors"
	"net/http"
	"net/http/httptest"
	"ola-chat-server/internal/utils"
	"strings"
	"sync/atomic"
	"testing"

	"github.com/google/uuid"
)

const lookupFoundBody = `{"exists":true,"word":"chân trời","results":[{"lang_code":"vi","lang_name":"Tiếng Việt","meanings":[{"definition":"Đường giới hạn của tầm mắt"}],"translations":[],"relations":[]}]}`

func serveLookup(t *testing.T, svc *Service) *atomic.Int32 {
	t.Helper()
	calls := &atomic.Int32{}
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		calls.Add(1)
		if strings.ToLower(r.URL.Query().Get("word")) != "chân trời" {
			w.WriteHeader(http.StatusNotFound)
			return
		}
		_, _ = w.Write([]byte(lookupFoundBody))
	}))
	t.Cleanup(server.Close)
	svc.verifier.lookupURL = server.URL
	return calls
}

func isCooldown(err error) bool {
	var httpErr *utils.HTTPError
	return errors.As(err, &httpErr) && httpErr.Code == ErrorCodeCooldown
}

func TestLookupServesCachedWordsWithoutCooldown(t *testing.T) {
	svc := newTestService(t)
	calls := serveLookup(t, svc)
	userID := uuid.New()
	ctx := context.Background()

	for i := range 3 {
		resp, err := svc.Lookup(ctx, userID, "Chân trời")
		if err != nil {
			t.Fatalf("lookup %d: %v", i, err)
		}
		if !resp.Found || len(resp.Results) != 1 || resp.Results[0].Meanings[0].Definition != "Đường giới hạn của tầm mắt" {
			t.Fatalf("lookup %d = %+v", i, resp)
		}
	}
	if got := calls.Load(); got != 1 {
		t.Fatalf("dictionary api calls = %d, want 1", got)
	}
	if _, err := svc.Lookup(ctx, userID, "trời xa"); !isCooldown(err) {
		t.Fatalf("uncached word within cooldown: err = %v, want cooldown", err)
	}
}

func TestPlayedWordInfoComesFromVerificationCache(t *testing.T) {
	svc := newTestService(t)
	calls := serveLookup(t, svc)
	ctx := context.Background()

	if exists, err := svc.verifier.lookupExists(ctx, "chân trời"); err != nil || !exists {
		t.Fatalf("verify = %v, %v", exists, err)
	}
	for _, userID := range []uuid.UUID{uuid.New(), uuid.New()} {
		if _, err := svc.Lookup(ctx, userID, "chân trời"); err != nil {
			t.Fatal(err)
		}
		if _, err := svc.Lookup(ctx, userID, "chân trời"); err != nil {
			t.Fatalf("second info click must not hit cooldown: %v", err)
		}
	}
	if got := calls.Load(); got != 1 {
		t.Fatalf("dictionary api calls = %d, want 1", got)
	}
}

func TestLookupCachesMissingWords(t *testing.T) {
	svc := newTestService(t)
	calls := serveLookup(t, svc)
	ctx := context.Background()

	for range 2 {
		resp, err := svc.Lookup(ctx, uuid.New(), "trời xa")
		if err != nil {
			t.Fatal(err)
		}
		if resp.Found {
			t.Fatalf("resp = %+v, want not found", resp)
		}
	}
	if got := calls.Load(); got != 1 {
		t.Fatalf("dictionary api calls = %d, want 1", got)
	}
}
