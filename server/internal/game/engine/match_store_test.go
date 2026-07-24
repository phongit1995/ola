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
		Players: []protocol.PlayerInfo{{ID: "player-a", Name: "A"}, {ID: "player-b", Name: "B"}},
		State:   json.RawMessage(`{"moveCount":1,"winner":-1}`), StateVersion: 1,
		TurnIndex: 1, TurnDeadline: time.Now().Add(time.Minute).UnixMilli(),
		Bet: 10, StartedAt: time.Now().UnixMilli(), Status: matchStatusPlaying,
		Actions: []MatchAction{{Sequence: 1, PlayerIndex: 0, Move: json.RawMessage(`{"win":false}`), CreatedAt: time.Now().UnixMilli()}},
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
	if len(loaded) != 1 || loaded[0].ID != snapshot.ID || len(loaded[0].Actions) != 1 {
		t.Fatalf("unexpected loaded snapshot: %+v", loaded)
	}

	snapshot.TurnIndex = 0
	snapshot.Actions = append(snapshot.Actions, MatchAction{
		Sequence: 2, PlayerIndex: 1, Move: json.RawMessage(`{"win":false}`), CreatedAt: time.Now().UnixMilli(),
	})
	if err := store.Save(snapshot); err != nil {
		t.Fatalf("update snapshot: %v", err)
	}
	loaded, err = store.List("caro")
	if err != nil || len(loaded) != 1 || loaded[0].TurnIndex != 0 || len(loaded[0].Actions) != 2 {
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
