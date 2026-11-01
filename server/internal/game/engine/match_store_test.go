package engine

import (
	"encoding/json"
	"net"
	"strconv"
	"testing"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/services"

	miniredis "github.com/alicebob/miniredis/v2"
	"go.uber.org/zap"
)

func newRedisMatchStoreTest(t *testing.T) (*MatchStore, *miniredis.Miniredis, *services.CacheService) {
	t.Helper()
	server := miniredis.RunT(t)
	server.RequireAuth("test-password")
	host, portValue, err := net.SplitHostPort(server.Addr())
	if err != nil {
		t.Fatal(err)
	}
	port, err := strconv.Atoi(portValue)
	if err != nil {
		t.Fatal(err)
	}
	cache, err := services.NewCacheService(&config.Config{
		RedisHost:     host,
		RedisPort:     port,
		RedisPassword: "test-password",
		RedisDB:       0,
	}, zap.NewNop().Sugar())
	if err != nil {
		t.Fatalf("create cache service: %v", err)
	}
	t.Cleanup(func() { _ = cache.Close() })
	return NewMatchStore(cache), server, cache
}

func redisStoreSnapshot(gameID, matchID string) ActiveMatchSnapshot {
	return ActiveMatchSnapshot{
		ID: matchID, GameID: gameID,
		Players: []protocol.PlayerInfo{
			{ID: "player-a", Name: "A", VipType: lifecycleVipType("player-a")},
			{ID: "player-b", Name: "B", VipType: lifecycleVipType("player-b")},
		},
		State: json.RawMessage(`{"moveCount":1,"winner":-1}`), StateVersion: 1,
		TurnIndex: 1, TurnDeadline: time.Now().Add(time.Minute).UnixMilli(),
		Bet: 10, StartedAt: time.Now().UnixMilli(), Status: matchStatusPlaying,
	}
}

func TestMatchStoreSaveListUpdateAndDelete(t *testing.T) {
	store, server, _ := newRedisMatchStoreTest(t)
	snapshot := redisStoreSnapshot("caro", "match-1")
	if err := store.Save(snapshot); err != nil {
		t.Fatalf("save snapshot: %v", err)
	}

	matchKey := "GAME:caro:MATCH:match-1"
	setKey := "GAME:caro:ACTIVE_MATCHES"
	if !server.Exists(matchKey) || !server.Exists("GAME:caro:USERMATCH:player-a") || !server.Exists("GAME:caro:USERMATCH:player-b") {
		t.Fatal("match or player index keys were not created")
	}
	member, err := server.SIsMember(setKey, snapshot.ID)
	if err != nil || !member {
		t.Fatal("match id was not added to active set")
	}
	if ttl := server.TTL(matchKey); ttl != activeMatchTTL {
		t.Fatalf("unexpected match TTL: %s", ttl)
	}

	loaded, err := store.List("caro")
	if err != nil {
		t.Fatalf("list snapshots: %v", err)
	}
	if len(loaded) != 1 || loaded[0].ID != snapshot.ID {
		t.Fatalf("unexpected loaded snapshot: %+v", loaded)
	}
	for _, player := range loaded[0].Players {
		requireVipType(t, player.VipType, lifecycleVipValue(player.ID))
	}

	snapshot.TurnIndex = 0
	if err := store.Save(snapshot); err != nil {
		t.Fatalf("update snapshot: %v", err)
	}
	loaded, err = store.List("caro")
	if err != nil || len(loaded) != 1 || loaded[0].TurnIndex != 0 {
		t.Fatalf("updated snapshot was not returned: %+v, %v", loaded, err)
	}

	if err := store.Delete("caro", snapshot.ID, "player-a", "player-b"); err != nil {
		t.Fatalf("delete snapshot: %v", err)
	}
	if server.Exists(matchKey) || server.Exists("GAME:caro:USERMATCH:player-a") || server.Exists("GAME:caro:USERMATCH:player-b") {
		t.Fatal("match or player index keys remain after delete")
	}
	member, _ = server.SIsMember(setKey, snapshot.ID)
	if member {
		t.Fatal("match id remains in active set after delete")
	}
}

func TestMatchStoreIsolatesGames(t *testing.T) {
	store, _, _ := newRedisMatchStoreTest(t)
	if err := store.Save(redisStoreSnapshot("caro", "same-id")); err != nil {
		t.Fatal(err)
	}
	if err := store.Save(redisStoreSnapshot("war-god", "same-id")); err != nil {
		t.Fatal(err)
	}
	caroMatches, err := store.List("caro")
	if err != nil {
		t.Fatal(err)
	}
	warGodMatches, err := store.List("war-god")
	if err != nil {
		t.Fatal(err)
	}
	if len(caroMatches) != 1 || caroMatches[0].GameID != "caro" {
		t.Fatalf("unexpected Caro matches: %+v", caroMatches)
	}
	if len(warGodMatches) != 1 || warGodMatches[0].GameID != "war-god" {
		t.Fatalf("unexpected War God matches: %+v", warGodMatches)
	}
}

func TestMatchStoreCleansStaleAndMalformedActiveSetEntries(t *testing.T) {
	store, _, cache := newRedisMatchStoreTest(t)
	ctx := cache.GetContext()
	client := cache.GetClient()
	setKey := "GAME:caro:ACTIVE_MATCHES"
	if err := client.SAdd(ctx, setKey, "missing", "malformed").Err(); err != nil {
		t.Fatal(err)
	}
	if err := client.Set(ctx, "GAME:caro:MATCH:malformed", "{", time.Minute).Err(); err != nil {
		t.Fatal(err)
	}

	matches, err := store.List("caro")
	if err != nil {
		t.Fatal(err)
	}
	if len(matches) != 0 {
		t.Fatalf("stale entries produced matches: %+v", matches)
	}
	for _, id := range []string{"missing", "malformed"} {
		member, memberErr := client.SIsMember(ctx, setKey, id).Result()
		if memberErr != nil || member {
			t.Fatalf("stale active id %s was not cleaned", id)
		}
	}
}

func TestMatchStoreTTLExpiresSnapshotAndIndexes(t *testing.T) {
	store, server, _ := newRedisMatchStoreTest(t)
	snapshot := redisStoreSnapshot("caro", "expiring")
	if err := store.Save(snapshot); err != nil {
		t.Fatal(err)
	}
	server.FastForward(activeMatchTTL + time.Second)

	matches, err := store.List("caro")
	if err != nil {
		t.Fatal(err)
	}
	if len(matches) != 0 {
		t.Fatal("expired snapshot was still listed")
	}
	if server.Exists("GAME:caro:MATCH:expiring") || server.Exists("GAME:caro:USERMATCH:player-a") {
		t.Fatal("expired snapshot or player index still exists")
	}
}

func TestMatchStoreRejectsInvalidJSONState(t *testing.T) {
	store, _, _ := newRedisMatchStoreTest(t)
	snapshot := redisStoreSnapshot("caro", "invalid-json")
	snapshot.State = json.RawMessage(`{"moveCount":`)
	if err := store.Save(snapshot); err == nil {
		t.Fatal("invalid JSON state was accepted")
	}
}

func TestMatchStoreStaleCleanupPreservesNewUserReference(t *testing.T) {
	store, server, cache := newRedisMatchStoreTest(t)
	oldSnapshot := redisStoreSnapshot("caro", "old-match")
	newSnapshot := redisStoreSnapshot("caro", "new-match")
	if err := store.Save(oldSnapshot); err != nil {
		t.Fatal(err)
	}
	if err := store.Save(newSnapshot); err != nil {
		t.Fatal(err)
	}

	if err := store.Delete(oldSnapshot.GameID, oldSnapshot.ID, "player-a", "player-b"); err != nil {
		t.Fatal(err)
	}
	for _, userID := range []string{"player-a", "player-b"} {
		key := "GAME:caro:USERMATCH:" + userID
		value, err := cache.GetClient().Get(cache.GetContext(), key).Result()
		if err != nil || value != newSnapshot.ID {
			t.Fatalf("late old-match cleanup changed %s to %q: %v", key, value, err)
		}
	}
	if server.Exists("GAME:caro:MATCH:old-match") {
		t.Fatal("old match was not deleted")
	}
	if !server.Exists("GAME:caro:MATCH:new-match") {
		t.Fatal("new match was deleted by old cleanup")
	}
	oldMember, _ := server.SIsMember("GAME:caro:ACTIVE_MATCHES", oldSnapshot.ID)
	newMember, _ := server.SIsMember("GAME:caro:ACTIVE_MATCHES", newSnapshot.ID)
	if oldMember || !newMember {
		t.Fatal("active match set was corrupted by old cleanup")
	}
}

func TestMatchStoreSpectatorsKeepViewerInfo(t *testing.T) {
	store, server, _ := newRedisMatchStoreTest(t)
	if _, status, err := store.AddSpectator("thirteen", "match-1", "sock-0", protocol.PlayerInfo{ID: "lan", Name: "lan"}, 3); err != nil || status != SpectatorMatchNotFound {
		t.Fatalf("a missing match must refuse spectators, got %v %v", status, err)
	}
	if err := store.Save(redisStoreSnapshot("thirteen", "match-1")); err != nil {
		t.Fatalf("save snapshot: %v", err)
	}

	vip := "vip-2"
	viewers := []struct {
		socket string
		info   protocol.PlayerInfo
	}{
		{"sock-1", protocol.PlayerInfo{ID: "lan", Name: "lan", VipType: &vip, Level: 4}},
		{"sock-2", protocol.PlayerInfo{ID: "minh", Name: "minh"}},
		{"sock-3", protocol.PlayerInfo{ID: "lan", Name: "lan", VipType: &vip, Level: 4}},
	}
	for i, viewer := range viewers {
		count, status, err := store.AddSpectator("thirteen", "match-1", viewer.socket, viewer.info, 3)
		if err != nil || status != SpectatorAdded || count != i+1 {
			t.Fatalf("add %s: count=%d status=%v err=%v", viewer.socket, count, status, err)
		}
		time.Sleep(2 * time.Millisecond)
	}
	if _, status, _ := store.AddSpectator("thirteen", "match-1", "sock-4", protocol.PlayerInfo{ID: "ha", Name: "ha"}, 3); status != SpectatorFull {
		t.Fatalf("the fourth seat should be refused, got %v", status)
	}
	if ttl := server.TTL("GAME:thirteen:MATCH:match-1:VIEWERS"); ttl != activeMatchTTL {
		t.Fatalf("viewers hash should expire with the match, got %s", ttl)
	}

	list, err := store.Spectators("thirteen", "match-1")
	if err != nil {
		t.Fatalf("list spectators: %v", err)
	}
	if len(list) != 2 || list[0].ID != "lan" || list[1].ID != "minh" || list[0].Level != 4 {
		t.Fatalf("expected each viewer once in join order, got %+v", list)
	}
	requireVipType(t, list[0].VipType, vip)

	if err := store.RemoveSpectator("thirteen", "match-1", "sock-1"); err != nil {
		t.Fatalf("remove spectator: %v", err)
	}
	if count, _ := store.SpectatorCount("thirteen", "match-1"); count != 2 {
		t.Fatalf("a viewer with another open tab is still counted once, got %d", count)
	}
	if list, _ := store.Spectators("thirteen", "match-1"); len(list) != 2 {
		t.Fatalf("a viewer with another open tab stays listed, got %+v", list)
	}
	if count, status, _ := store.AddSpectator("thirteen", "match-1", "sock-4", protocol.PlayerInfo{ID: "ha", Name: "ha"}, 3); status != SpectatorAdded || count != 3 {
		t.Fatalf("one tab leaving frees one seat, got count=%d status=%v", count, status)
	}

	if err := store.Delete("thirteen", "match-1", "player-a", "player-b"); err != nil {
		t.Fatalf("delete snapshot: %v", err)
	}
	if server.Exists("GAME:thirteen:MATCH:match-1:VIEWERS") {
		t.Fatal("viewers hash remains after the match is deleted")
	}
}
