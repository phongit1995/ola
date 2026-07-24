package engine

import (
	"encoding/json"
	"fmt"
	"time"

	"ola-chat-server/internal/services"

	"github.com/google/uuid"
)

const (
	roomTTL           = 30 * time.Minute
	roomLockTTL       = 10 * time.Second
	roomsHashKey      = "GAME:%s:ROOMS"
	userRoomKey       = "GAME:%s:USERROOM:%s"
	legacyUserRoomKey = "GAME:USERROOM:%s"
	roomLockKey       = "GAME:%s:ROOMLOCK:%s"
)

type Room struct {
	ID         string `json:"id"`
	GameID     string `json:"gameId"`
	OwnerID    string `json:"ownerId"`
	OwnerName  string `json:"ownerName"`
	OwnerReady bool   `json:"ownerReady"`
	GuestID    string `json:"guestId,omitempty"`
	GuestName  string `json:"guestName,omitempty"`
	GuestReady bool   `json:"guestReady"`
	Bet        int    `json:"bet"`
	Password   string `json:"password"`
	CreatedAt  int64  `json:"createdAt"`
	UpdatedAt  int64  `json:"updatedAt"`
}

type userRoomRef struct {
	GameID string `json:"gameId"`
	RoomID string `json:"roomId"`
}

type RoomRepository interface {
	Save(room Room) error
	Get(gameID, roomID string) (Room, bool)
	Delete(gameID, roomID string, userIDs ...string) error
	DeleteUserRef(gameID, userID, roomID string) error
	List(gameID string) ([]Room, error)
	RoomByUser(gameID, userID string) (userRoomRef, bool)
	Claim(gameID, roomID string) (release func(), ok bool)
}

type RoomStore struct {
	cache *services.CacheService
}

func NewRoomStore(cache *services.CacheService) *RoomStore {
	return &RoomStore{cache: cache}
}

func (s *RoomStore) Save(room Room) error {
	now := time.Now().UnixMilli()
	if room.CreatedAt <= 0 {
		room.CreatedAt = now
	}
	room.UpdatedAt = now
	roomData, err := json.Marshal(room)
	if err != nil {
		return fmt.Errorf("marshal room: %w", err)
	}
	refData, err := json.Marshal(userRoomRef{GameID: room.GameID, RoomID: room.ID})
	if err != nil {
		return fmt.Errorf("marshal room reference: %w", err)
	}

	ctx := s.cache.GetContext()
	pipe := s.cache.GetClient().TxPipeline()
	roomsKey := fmt.Sprintf(roomsHashKey, room.GameID)
	pipe.HSet(ctx, roomsKey, room.ID, roomData)
	pipe.Set(ctx, fmt.Sprintf(userRoomKey, room.GameID, room.OwnerID), refData, roomTTL)
	pipe.Del(ctx, fmt.Sprintf(legacyUserRoomKey, room.OwnerID))
	if room.GuestID != "" {
		pipe.Set(ctx, fmt.Sprintf(userRoomKey, room.GameID, room.GuestID), refData, roomTTL)
		pipe.Del(ctx, fmt.Sprintf(legacyUserRoomKey, room.GuestID))
	}
	pipe.Expire(ctx, roomsKey, roomTTL)
	if _, err := pipe.Exec(ctx); err != nil {
		return fmt.Errorf("save room: %w", err)
	}
	return nil
}

func (s *RoomStore) Get(gameID, roomID string) (Room, bool) {
	var room Room
	if err := s.cache.GetHash(fmt.Sprintf(roomsHashKey, gameID), roomID, &room); err != nil {
		return Room{}, false
	}
	if roomLastActivity(room) < time.Now().Add(-roomTTL).UnixMilli() {
		_ = s.Delete(gameID, roomID, room.OwnerID, room.GuestID)
		return Room{}, false
	}
	return room, true
}

func (s *RoomStore) Delete(gameID, roomID string, userIDs ...string) error {
	refData, err := json.Marshal(userRoomRef{GameID: gameID, RoomID: roomID})
	if err != nil {
		return fmt.Errorf("marshal room reference: %w", err)
	}
	ctx := s.cache.GetContext()
	keys := []string{fmt.Sprintf(roomsHashKey, gameID)}
	for _, userID := range userIDs {
		if userID != "" {
			keys = append(keys,
				fmt.Sprintf(userRoomKey, gameID, userID),
				fmt.Sprintf(legacyUserRoomKey, userID),
			)
		}
	}
	const deleteRoomScript = `
redis.call("HDEL", KEYS[1], ARGV[1])
for i = 2, #KEYS do
  if redis.call("GET", KEYS[i]) == ARGV[2] then
    redis.call("DEL", KEYS[i])
  end
end
return 1`
	if _, err := s.cache.GetClient().Eval(ctx, deleteRoomScript, keys, roomID, string(refData)).Result(); err != nil {
		return fmt.Errorf("delete room: %w", err)
	}
	return nil
}

func (s *RoomStore) DeleteUserRef(gameID, userID, roomID string) error {
	if userID == "" || roomID == "" {
		return nil
	}
	refData, err := json.Marshal(userRoomRef{GameID: gameID, RoomID: roomID})
	if err != nil {
		return fmt.Errorf("marshal room reference: %w", err)
	}
	ctx := s.cache.GetContext()
	keys := []string{
		fmt.Sprintf(userRoomKey, gameID, userID),
		fmt.Sprintf(legacyUserRoomKey, userID),
	}
	const deleteRoomRefScript = `
for i = 1, #KEYS do
  if redis.call("GET", KEYS[i]) == ARGV[1] then
    redis.call("DEL", KEYS[i])
  end
end
return 1`
	if _, err := s.cache.GetClient().Eval(ctx, deleteRoomRefScript, keys, string(refData)).Result(); err != nil {
		return fmt.Errorf("delete room reference: %w", err)
	}
	return nil
}

func (s *RoomStore) List(gameID string) ([]Room, error) {
	all, err := s.cache.GetAllHash(fmt.Sprintf(roomsHashKey, gameID))
	if err != nil {
		return nil, fmt.Errorf("list rooms: %w", err)
	}
	cutoff := time.Now().Add(-roomTTL).UnixMilli()
	rooms := make([]Room, 0, len(all))
	for id, raw := range all {
		var room Room
		if json.Unmarshal([]byte(raw), &room) != nil {
			continue
		}
		if roomLastActivity(room) < cutoff {
			_ = s.Delete(gameID, id, room.OwnerID, room.GuestID)
			continue
		}
		rooms = append(rooms, room)
	}
	return rooms, nil
}

func roomLastActivity(room Room) int64 {
	if room.UpdatedAt > 0 {
		return room.UpdatedAt
	}
	return room.CreatedAt
}

func (s *RoomStore) RoomByUser(gameID, userID string) (userRoomRef, bool) {
	var ref userRoomRef
	if err := s.cache.Get(fmt.Sprintf(userRoomKey, gameID, userID), &ref); err != nil {
		if err := s.cache.Get(fmt.Sprintf(legacyUserRoomKey, userID), &ref); err != nil || ref.GameID != gameID {
			return userRoomRef{}, false
		}
		_ = s.cache.Set(fmt.Sprintf(userRoomKey, gameID, userID), ref, roomTTL)
		_ = s.cache.Delete(fmt.Sprintf(legacyUserRoomKey, userID))
	}
	return ref, true
}

func (s *RoomStore) Claim(gameID, roomID string) (func(), bool) {
	key := fmt.Sprintf(roomLockKey, gameID, roomID)
	token := uuid.NewString()
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	ok, err := client.SetNX(ctx, key, token, roomLockTTL).Result()
	if err != nil || !ok {
		return nil, false
	}

	release := func() {
		const unlockScript = `
if redis.call("GET", KEYS[1]) == ARGV[1] then
  return redis.call("DEL", KEYS[1])
end
return 0`
		_, _ = client.Eval(ctx, unlockScript, []string{key}, token).Result()
	}
	return release, true
}
