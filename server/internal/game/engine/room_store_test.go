package engine

import (
	"testing"
	"time"
)

func redisRoom(gameID, roomID, ownerID string) Room {
	return Room{
		ID:        roomID,
		GameID:    gameID,
		OwnerID:   ownerID,
		OwnerName: ownerID,
		Bet:       50,
		CreatedAt: time.Now().UnixMilli(),
	}
}

func TestRoomStoreSaveGetListAndDelete(t *testing.T) {
	_, server, cache := newRedisMatchStoreTest(t)
	store := NewRoomStore(cache)
	room := redisRoom("caro", "room-1", "owner")
	room.GuestID = "guest"
	room.GuestName = "guest"
	room.Password = "secret"
	if err := store.Save(room); err != nil {
		t.Fatalf("save room: %v", err)
	}

	if ttl := server.TTL("GAME:caro:ROOMS"); ttl != roomTTL {
		t.Fatalf("unexpected rooms TTL: %s", ttl)
	}
	for _, key := range []string{"GAME:caro:USERROOM:owner", "GAME:caro:USERROOM:guest"} {
		if !server.Exists(key) || server.TTL(key) != roomTTL {
			t.Fatalf("room member index missing or has wrong TTL: %s", key)
		}
	}
	loaded, ok := store.Get(room.GameID, room.ID)
	if !ok || loaded.OwnerID != room.OwnerID || loaded.GuestID != room.GuestID || loaded.Password != room.Password {
		t.Fatalf("unexpected loaded room: %+v", loaded)
	}
	listed := store.List(room.GameID)
	if len(listed) != 1 || listed[0].ID != room.ID {
		t.Fatalf("unexpected room list: %+v", listed)
	}
	for _, userID := range []string{room.OwnerID, room.GuestID} {
		ref, exists := store.RoomByUser(room.GameID, userID)
		if !exists || ref.RoomID != room.ID {
			t.Fatalf("unexpected room reference for %s: %+v", userID, ref)
		}
	}

	if err := store.Delete(room.GameID, room.ID, room.OwnerID, room.GuestID); err != nil {
		t.Fatalf("delete room: %v", err)
	}
	if _, ok := store.Get(room.GameID, room.ID); ok || len(store.List(room.GameID)) != 0 {
		t.Fatal("room remains after delete")
	}
	if server.Exists("GAME:caro:USERROOM:owner") || server.Exists("GAME:caro:USERROOM:guest") {
		t.Fatal("member indexes remain after room delete")
	}
}

func TestRoomStoreIsolatesGamesWithSameIdentifiers(t *testing.T) {
	_, _, cache := newRedisMatchStoreTest(t)
	store := NewRoomStore(cache)
	caro := redisRoom("caro", "same-room", "same-owner")
	warGod := redisRoom("war-god", "same-room", "same-owner")
	if err := store.Save(caro); err != nil {
		t.Fatal(err)
	}
	if err := store.Save(warGod); err != nil {
		t.Fatal(err)
	}

	for _, room := range []Room{caro, warGod} {
		loaded, ok := store.Get(room.GameID, room.ID)
		if !ok || loaded.GameID != room.GameID {
			t.Fatalf("game namespace collision for %s: %+v", room.GameID, loaded)
		}
		ref, ok := store.RoomByUser(room.GameID, room.OwnerID)
		if !ok || ref.GameID != room.GameID {
			t.Fatalf("user room namespace collision for %s: %+v", room.GameID, ref)
		}
	}
}

func TestRoomStoreExpiresAndCleansStaleRoom(t *testing.T) {
	_, server, cache := newRedisMatchStoreTest(t)
	store := NewRoomStore(cache)
	room := redisRoom("caro", "old-room", "owner")
	room.GuestID = "guest"
	room.CreatedAt = time.Now().Add(-roomTTL - time.Second).UnixMilli()
	if err := store.Save(room); err != nil {
		t.Fatal(err)
	}
	if _, ok := store.Get(room.GameID, room.ID); ok {
		t.Fatal("expired room was returned")
	}
	if server.Exists("GAME:caro:USERROOM:owner") || server.Exists("GAME:caro:USERROOM:guest") {
		t.Fatal("expired room member indexes were not cleaned")
	}

	fresh := redisRoom("caro", "ttl-room", "fresh-owner")
	if err := store.Save(fresh); err != nil {
		t.Fatal(err)
	}
	server.FastForward(roomTTL + time.Second)
	if len(store.List(fresh.GameID)) != 0 {
		t.Fatal("Redis-expired room was still listed")
	}
}

func TestRoomStoreIgnoresMalformedHashEntries(t *testing.T) {
	_, _, cache := newRedisMatchStoreTest(t)
	store := NewRoomStore(cache)
	ctx := cache.GetContext()
	if err := cache.GetClient().HSet(ctx, "GAME:caro:ROOMS", "bad", "{").Err(); err != nil {
		t.Fatal(err)
	}
	if rooms := store.List("caro"); len(rooms) != 0 {
		t.Fatalf("malformed entry appeared in room list: %+v", rooms)
	}
}

func TestRoomStoreMigratesLegacyUserReference(t *testing.T) {
	_, server, cache := newRedisMatchStoreTest(t)
	store := NewRoomStore(cache)
	ref := userRoomRef{GameID: "caro", RoomID: "legacy-room"}
	if err := cache.Set("GAME:USERROOM:user", ref, roomTTL); err != nil {
		t.Fatal(err)
	}

	loaded, ok := store.RoomByUser("caro", "user")
	if !ok || loaded != ref {
		t.Fatalf("legacy reference was not loaded: %+v", loaded)
	}
	if server.Exists("GAME:USERROOM:user") || !server.Exists("GAME:caro:USERROOM:user") {
		t.Fatal("legacy reference was not migrated to the game namespace")
	}
}

func TestRoomStoreClaimIsExclusiveAndReusable(t *testing.T) {
	_, _, cache := newRedisMatchStoreTest(t)
	store := NewRoomStore(cache)
	release, ok := store.Claim("caro", "room")
	if !ok || release == nil {
		t.Fatal("first room claim failed")
	}
	if _, secondOK := store.Claim("caro", "room"); secondOK {
		t.Fatal("concurrent room claim unexpectedly succeeded")
	}
	release()
	thirdRelease, thirdOK := store.Claim("caro", "room")
	if !thirdOK || thirdRelease == nil {
		t.Fatal("room lock was not reusable after release")
	}
	thirdRelease()
}

func TestRoomStoreDeleteUserRefOnlyAffectsRequestedGame(t *testing.T) {
	_, _, cache := newRedisMatchStoreTest(t)
	store := NewRoomStore(cache)
	if err := store.Save(redisRoom("caro", "caro-room", "user")); err != nil {
		t.Fatal(err)
	}
	if err := store.Save(redisRoom("war-god", "war-room", "user")); err != nil {
		t.Fatal(err)
	}
	if err := store.DeleteUserRef("caro", "user"); err != nil {
		t.Fatal(err)
	}
	if _, ok := store.RoomByUser("caro", "user"); ok {
		t.Fatal("requested game reference remains")
	}
	if ref, ok := store.RoomByUser("war-god", "user"); !ok || ref.RoomID != "war-room" {
		t.Fatalf("other game reference was deleted: %+v", ref)
	}
}
