package livekit

import (
	"context"
	"encoding/json"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"ola-chat-server/internal/config"

	"github.com/livekit/protocol/auth"
)

const (
	testAPIKey            = "test-key"
	testAPISecret         = "test-secret-test-secret-test-secret"
	testRemoveParticipant = "/twirp/livekit.RoomService/RemoveParticipant"
	testDeleteRoom        = "/twirp/livekit.RoomService/DeleteRoom"
)

type recordedCall struct {
	path  string
	body  map[string]string
	grant *auth.VideoGrant
}

func roomServiceStub(t *testing.T, status int, reply string) (*config.Config, *[]recordedCall) {
	t.Helper()
	calls := &[]recordedCall{}
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		raw, _ := io.ReadAll(r.Body)
		var body map[string]string
		_ = json.Unmarshal(raw, &body)
		verifier, err := auth.ParseAPIToken(strings.TrimPrefix(r.Header.Get("Authorization"), "Bearer "))
		if err != nil {
			t.Errorf("bad token: %v", err)
			return
		}
		_, claims, err := verifier.Verify(testAPISecret)
		if err != nil {
			t.Errorf("token not signed with the API secret: %v", err)
			return
		}
		*calls = append(*calls, recordedCall{path: r.URL.Path, body: body, grant: claims.Video})
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(status)
		_, _ = w.Write([]byte(reply))
	}))
	t.Cleanup(server.Close)
	cfg := &config.Config{
		LiveKitURL:       "ws://" + strings.TrimPrefix(server.URL, "http://"),
		LiveKitAPIKey:    testAPIKey,
		LiveKitAPISecret: testAPISecret,
	}
	return cfg, calls
}

func TestRemoveParticipantCallsRoomServiceAsRoomAdmin(t *testing.T) {
	cfg, calls := roomServiceStub(t, http.StatusOK, "{}")
	if err := RemoveParticipant(context.Background(), cfg, "game:thirteen:r1", "user-1"); err != nil {
		t.Fatal(err)
	}
	if len(*calls) != 1 {
		t.Fatalf("calls %+v", *calls)
	}
	call := (*calls)[0]
	if call.path != testRemoveParticipant {
		t.Fatalf("path %q", call.path)
	}
	if call.body["room"] != "game:thirteen:r1" || call.body["identity"] != "user-1" {
		t.Fatalf("body %+v", call.body)
	}
	if call.grant == nil || !call.grant.RoomAdmin || call.grant.Room != "game:thirteen:r1" {
		t.Fatalf("grant %+v", call.grant)
	}
}

func TestDeleteRoomCallsRoomServiceWithCreateGrant(t *testing.T) {
	cfg, calls := roomServiceStub(t, http.StatusOK, "{}")
	if err := DeleteRoom(context.Background(), cfg, "game:thirteen:r1"); err != nil {
		t.Fatal(err)
	}
	call := (*calls)[0]
	if call.path != testDeleteRoom || call.body["room"] != "game:thirteen:r1" {
		t.Fatalf("call %+v", call)
	}
	if call.grant == nil || !call.grant.RoomCreate {
		t.Fatalf("grant %+v", call.grant)
	}
}

func TestRoomServiceTreatsNotFoundAsDone(t *testing.T) {
	cfg, _ := roomServiceStub(t, http.StatusNotFound, `{"code":"not_found","msg":"participant not found"}`)
	if err := RemoveParticipant(context.Background(), cfg, "room", "user"); err != nil {
		t.Fatalf("not_found should be ignored, got %v", err)
	}
}

func TestRoomServiceReportsOtherErrors(t *testing.T) {
	cfg, _ := roomServiceStub(t, http.StatusUnauthorized, `{"code":"unauthenticated","msg":"invalid token"}`)
	if err := DeleteRoom(context.Background(), cfg, "room"); err == nil || !strings.Contains(err.Error(), "invalid token") {
		t.Fatalf("want unauthenticated error, got %v", err)
	}
}

func TestRoomServiceSkipsWhenNotConfigured(t *testing.T) {
	if err := RemoveParticipant(context.Background(), &config.Config{}, "room", "user"); err != nil {
		t.Fatal(err)
	}
}

func TestHTTPBaseURL(t *testing.T) {
	cases := map[string]string{
		"wss://lk.example.com":   "https://lk.example.com",
		"ws://localhost:7880/":   "http://localhost:7880",
		"https://lk.example.com": "https://lk.example.com",
	}
	for in, want := range cases {
		if got := httpBaseURL(in); got != want {
			t.Errorf("httpBaseURL(%q) = %q, want %q", in, got, want)
		}
	}
}
