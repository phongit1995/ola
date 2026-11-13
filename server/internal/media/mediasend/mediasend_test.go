package mediasend

import (
	"errors"
	"fmt"
	"net"
	"strconv"
	"testing"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/media"
	"ola-chat-server/internal/services"

	miniredis "github.com/alicebob/miniredis/v2"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type cached struct{ ID string }

func newHelper(t *testing.T) (Helper, *miniredis.Miniredis) {
	t.Helper()
	server := miniredis.RunT(t)
	host, portValue, err := net.SplitHostPort(server.Addr())
	if err != nil {
		t.Fatal(err)
	}
	port, err := strconv.Atoi(portValue)
	if err != nil {
		t.Fatal(err)
	}
	cache, err := services.NewCacheService(&config.Config{RedisHost: host, RedisPort: port}, zap.NewNop().Sugar())
	if err != nil {
		t.Fatalf("create cache service: %v", err)
	}
	t.Cleanup(func() { _ = cache.Close() })
	return Helper{Cache: cache, Logger: zap.NewNop().Sugar(), Label: "media"}, server
}

func noExisting() (*cached, error) { return nil, nil }

func TestAcquireUploadLocksUntilReleased(t *testing.T) {
	h, server := newHelper(t)

	existing, release, err := AcquireUpload(h, "lock", noExisting)
	if err != nil || existing != nil {
		t.Fatalf("first acquire: existing=%v err=%v", existing, err)
	}
	if !server.Exists("lock") {
		t.Fatal("lock key not set")
	}

	_, _, err = AcquireUpload(h, "lock", noExisting)
	if !errors.Is(err, media.ErrUploadInProgress) {
		t.Fatalf("second acquire err = %v", err)
	}

	release()
	if server.Exists("lock") {
		t.Fatal("lock key not released")
	}
	if _, _, err := AcquireUpload(h, "lock", noExisting); err != nil {
		t.Fatalf("acquire after release: %v", err)
	}
}

func TestAcquireUploadReturnsExistingWithoutLocking(t *testing.T) {
	h, server := newHelper(t)

	existing, release, err := AcquireUpload(h, "lock", func() (*cached, error) { return &cached{ID: "m1"}, nil })
	if err != nil || existing == nil || existing.ID != "m1" {
		t.Fatalf("existing=%v err=%v", existing, err)
	}
	release()
	if server.Exists("lock") {
		t.Fatal("lock should not be taken when a cached message exists")
	}
}

func TestAcquireUploadReturnsExistingWhenLockHeld(t *testing.T) {
	h, _ := newHelper(t)
	if _, _, err := AcquireUpload(h, "lock", noExisting); err != nil {
		t.Fatal(err)
	}
	existing, _, err := AcquireUpload(h, "lock", func() (*cached, error) { return &cached{ID: "m2"}, nil })
	if err != nil || existing == nil || existing.ID != "m2" {
		t.Fatalf("existing=%v err=%v", existing, err)
	}
}

func TestAllowUploadEnforcesLimit(t *testing.T) {
	h, server := newHelper(t)
	userID := uuid.New()
	for i := 0; i < constants.RateLimitUploadMaxRequests; i++ {
		if !h.AllowUpload(userID) {
			t.Fatalf("request %d rejected", i+1)
		}
	}
	if h.AllowUpload(userID) {
		t.Fatal("request over the limit allowed")
	}
	key := fmt.Sprintf(constants.CacheKeyRateLimitUpload, userID.String())
	if ttl := server.TTL(key); ttl <= 0 {
		t.Fatalf("rate limit key ttl = %v", ttl)
	}
}

func TestLockReactionFailsWhileHeld(t *testing.T) {
	h, server := newHelper(t)

	key, err := h.LockReaction("m1", "token")
	if err != nil {
		t.Fatalf("lock: %v", err)
	}
	if key != fmt.Sprintf(constants.CacheKeyReactionLock, "m1") || !server.Exists(key) {
		t.Fatalf("key = %s", key)
	}
	if _, err := h.LockReaction("m1", "other"); !errors.Is(err, ErrReactionInProgress) {
		t.Fatalf("second lock err = %v", err)
	}
}

func TestCleanupWithoutStorageIsNoop(t *testing.T) {
	h, _ := newHelper(t)
	h.Cleanup("messages/a.jpg")
	h.Cleanup("")
}
