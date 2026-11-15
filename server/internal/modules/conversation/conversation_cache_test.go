package conversation

import (
	"fmt"
	"net"
	"strconv"
	"testing"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/services"

	miniredis "github.com/alicebob/miniredis/v2"
	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

func newTestCache(t *testing.T) (*CacheService, *miniredis.Miniredis) {
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
	base, err := services.NewCacheService(&config.Config{RedisHost: host, RedisPort: port}, zap.NewNop().Sugar())
	if err != nil {
		t.Fatalf("create cache service: %v", err)
	}
	t.Cleanup(func() { _ = base.Close() })
	return NewCacheService(base, nil, zap.NewNop().Sugar()), server
}

func mustIncrement(t *testing.T, c *CacheService, convID, userID uuid.UUID, seed int) int {
	t.Helper()
	count, err := c.IncrementUnreadSeeded(convID, userID, seed)
	if err != nil {
		t.Fatalf("increment: %v", err)
	}
	return count
}

func TestIncrementUnreadSeedsOnlyWhenCounterMissing(t *testing.T) {
	c, _ := newTestCache(t)
	convID, userID := uuid.New(), uuid.New()

	if got := mustIncrement(t, c, convID, userID, 5); got != 6 {
		t.Fatalf("first increment = %d, want 6", got)
	}
	if got := mustIncrement(t, c, convID, userID, 5); got != 7 {
		t.Fatalf("second increment = %d, want 7", got)
	}
}

func TestIncrementAfterMarkReadIgnoresStaleSeed(t *testing.T) {
	c, _ := newTestCache(t)
	convID, userID := uuid.New(), uuid.New()
	mustIncrement(t, c, convID, userID, 4)

	if err := c.ResetUnreadCount(convID, userID); err != nil {
		t.Fatalf("reset: %v", err)
	}
	if got := mustIncrement(t, c, convID, userID, 5); got != 1 {
		t.Fatalf("increment after read with stale seed = %d, want 1", got)
	}
	if got, err := c.GetUnreadCount(convID, userID); err != nil || got != 1 {
		t.Fatalf("GetUnreadCount = %d, %v, want 1", got, err)
	}
}

func TestConversationListCacheRejectsWriteFromBeforeInvalidation(t *testing.T) {
	c, _ := newTestCache(t)
	userID := uuid.New()
	stale := []ConversationByUser{{ConversationID: gocql.TimeUUID(), UnreadCount: 3}}

	genBeforeRead := c.userConversationsGen(userID)
	if err := c.DeleteUserConversations(userID); err != nil {
		t.Fatalf("invalidate: %v", err)
	}
	if err := c.SetUserConversations(userID, genBeforeRead, stale); err != nil {
		t.Fatalf("set: %v", err)
	}
	if _, ok := c.GetUserConversations(userID, c.userConversationsGen(userID)); ok {
		t.Fatal("stale list written after invalidation must not be served")
	}

	fresh := []ConversationByUser{{ConversationID: gocql.TimeUUID(), UnreadCount: 0}}
	gen := c.userConversationsGen(userID)
	if err := c.SetUserConversations(userID, gen, fresh); err != nil {
		t.Fatalf("set fresh: %v", err)
	}
	got, ok := c.GetUserConversations(userID, c.userConversationsGen(userID))
	if !ok || len(got) != 1 || got[0].UnreadCount != 0 {
		t.Fatalf("fresh list not served: ok=%v got=%+v", ok, got)
	}
}

func TestConversationListCacheTreatsLegacyFormatAsMiss(t *testing.T) {
	c, server := newTestCache(t)
	userID := uuid.New()
	if err := server.Set(fmt.Sprintf(CacheKeyConversationList, userID.String()), `[{"UnreadCount":2}]`); err != nil {
		t.Fatal(err)
	}
	if _, ok := c.GetUserConversations(userID, c.userConversationsGen(userID)); ok {
		t.Fatal("legacy array cache value must be a miss")
	}
}
