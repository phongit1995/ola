package adminconversation

import (
	"errors"
	"fmt"
	"net"
	"strconv"
	"testing"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/services"

	miniredis "github.com/alicebob/miniredis/v2"
	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

func newTestSnapshots(t *testing.T) (snapshotStore, *miniredis.Miniredis) {
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
	return snapshotStore{cache: cache}, server
}

func testEntries(n int) []listEntry {
	entries := make([]listEntry, n)
	for i := range entries {
		other := uuid.New()
		entries[i] = listEntry{item: ConversationItem{ID: fmt.Sprintf("conv-%d", i), Type: "direct"}, otherID: &other}
	}
	return entries
}

func TestSnapshotPagesKeepFrozenOrder(t *testing.T) {
	store, _ := newTestSnapshots(t)
	userID := uuid.New()
	entries := testEntries(1205)
	snapshotID, err := store.save(userID, false, entries)
	if err != nil {
		t.Fatal(err)
	}

	page, total, err := store.page(userID, false, snapshotID, 30, 30)
	if err != nil {
		t.Fatal(err)
	}
	if total != len(entries) || len(page) != 30 {
		t.Fatalf("total=%d len=%d", total, len(page))
	}
	for i, e := range page {
		want := entries[30+i]
		if e.item.ID != want.item.ID || *e.otherID != *want.otherID {
			t.Fatalf("page[%d] = %s, want %s", i, e.item.ID, want.item.ID)
		}
	}

	last, _, err := store.page(userID, false, snapshotID, 1200, 30)
	if err != nil || len(last) != 5 || last[4].item.ID != "conv-1204" {
		t.Fatalf("last page = %d entries, err %v", len(last), err)
	}
}

func TestSnapshotScopedToUserAndTab(t *testing.T) {
	store, _ := newTestSnapshots(t)
	userID := uuid.New()
	snapshotID, err := store.save(userID, false, testEntries(40))
	if err != nil {
		t.Fatal(err)
	}
	if _, _, err := store.page(uuid.New(), false, snapshotID, 30, 30); !errors.Is(err, ErrSnapshotExpired) {
		t.Fatalf("other user must not read the snapshot, got %v", err)
	}
	if _, _, err := store.page(userID, true, snapshotID, 30, 30); !errors.Is(err, ErrSnapshotExpired) {
		t.Fatalf("hidden tab must not read the visible snapshot, got %v", err)
	}
}

func TestSnapshotExpiresAndReadsExtendTTL(t *testing.T) {
	store, server := newTestSnapshots(t)
	userID := uuid.New()
	snapshotID, err := store.save(userID, false, testEntries(40))
	if err != nil {
		t.Fatal(err)
	}
	server.FastForward(snapshotTTL - time.Minute)
	if _, _, err := store.page(userID, false, snapshotID, 30, 30); err != nil {
		t.Fatalf("snapshot must still be readable: %v", err)
	}
	server.FastForward(snapshotTTL - time.Minute)
	if _, _, err := store.page(userID, false, snapshotID, 30, 30); err != nil {
		t.Fatalf("reading must extend the snapshot TTL: %v", err)
	}
	server.FastForward(snapshotTTL + time.Second)
	if _, _, err := store.page(userID, false, snapshotID, 30, 30); !errors.Is(err, ErrSnapshotExpired) {
		t.Fatalf("expired snapshot must return ErrSnapshotExpired, got %v", err)
	}
}

func TestInboxEntriesSortByLatestMessage(t *testing.T) {
	at := func(minutes int) *gocql.UUID {
		id := gocql.UUIDFromTime(time.Date(2026, 10, 20, 10, minutes, 0, 0, time.UTC))
		return &id
	}
	rows := []inboxRow{
		{ConversationID: gocql.TimeUUID(), LastMessageAt: at(5)},
		{ConversationID: gocql.TimeUUID()},
		{ConversationID: gocql.TimeUUID(), LastMessageAt: at(30)},
	}
	entries := inboxEntries(rows)
	if entries[0].item.ID != rows[2].ConversationID.String() || entries[1].item.ID != rows[0].ConversationID.String() {
		t.Fatalf("unexpected order: %s, %s, %s", entries[0].item.ID, entries[1].item.ID, entries[2].item.ID)
	}
	if entries[2].item.LastMessageAt != "" {
		t.Fatal("conversation without messages must sort last and have no lastMessageAt")
	}
}
