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

type RoomGuest struct {
	ID      string  `json:"id"`
	Name    string  `json:"name"`
	VipType *string `json:"vipType,omitempty"`
	Ready   bool    `json:"ready"`
}

type Room struct {
	ID           string      `json:"id"`
	GameID       string      `json:"gameId"`
	OwnerID      string      `json:"ownerId"`
	OwnerName    string      `json:"ownerName"`
	OwnerVipType *string     `json:"ownerVipType,omitempty"`
	GuestID      string      `json:"guestId,omitempty"`
	GuestName    string      `json:"guestName,omitempty"`
	GuestVipType *string     `json:"guestVipType,omitempty"`
	GuestReady   bool        `json:"guestReady"`
	MaxPlayers   int         `json:"maxPlayers,omitempty"`
	Guests       []RoomGuest `json:"guests,omitempty"`
	Bet          int         `json:"bet"`
	Password     string      `json:"password"`
	CreatedAt    int64       `json:"createdAt"`
	UpdatedAt    int64       `json:"updatedAt"`
}

// normalize migrates legacy single-guest rooms into the Guests slice and keeps
// the legacy fields mirroring the first guest for older snapshots.
func (r *Room) normalize() {
	if len(r.Guests) == 0 && r.GuestID != "" {
		r.Guests = []RoomGuest{{ID: r.GuestID, Name: r.GuestName, VipType: r.GuestVipType, Ready: r.GuestReady}}
	}
	r.syncLegacyGuest()
}

func (r *Room) syncLegacyGuest() {
	if len(r.Guests) > 0 {
		g := r.Guests[0]
		r.GuestID, r.GuestName, r.GuestVipType, r.GuestReady = g.ID, g.Name, g.VipType, g.Ready
		return
	}
	r.GuestID, r.GuestName, r.GuestVipType, r.GuestReady = "", "", nil, false
}

func (r Room) capacity() int {
	if r.MaxPlayers >= 2 {
		return r.MaxPlayers
	}
	return 2
}

// guestList reads guests with legacy single-guest fallback so rooms saved by
// older code (or built directly in tests) behave identically.
func (r Room) guestList() []RoomGuest {
	if len(r.Guests) == 0 && r.GuestID != "" {
		return []RoomGuest{{ID: r.GuestID, Name: r.GuestName, VipType: r.GuestVipType, Ready: r.GuestReady}}
	}
	return r.Guests
}

func (r Room) playerCount() int {
	return 1 + len(r.guestList())
}

func (r Room) memberIDs() []string {
	guests := r.guestList()
	ids := make([]string, 0, 1+len(guests))
	ids = append(ids, r.OwnerID)
	for _, g := range guests {
		ids = append(ids, g.ID)
	}
	return ids
}

func (r Room) guestIndex(userID string) int {
	for i, g := range r.guestList() {
		if g.ID == userID {
			return i
		}
	}
	return -1
}

func (r *Room) addGuest(g RoomGuest) {
	r.normalize()
	r.Guests = append(append([]RoomGuest(nil), r.Guests...), g)
	r.syncLegacyGuest()
}

func (r Room) allGuestsReady() bool {
	for _, g := range r.guestList() {
		if !g.Ready {
			return false
		}
	}
	return true
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
	room.normalize()
	roomData, err := json.Marshal(room)
	if err != nil {
		return fmt.Errorf("marshal room: %w", err)
	}
	refData, err := json.Marshal(userRoomRef{GameID: room.GameID, RoomID: room.ID})
	if err != nil {
		return fmt.Errorf("marshal room reference: %w", err)
	}

	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
	pipe := s.cache.GetClient().TxPipeline()
	roomsKey := fmt.Sprintf(roomsHashKey, room.GameID)
	pipe.HSet(ctx, roomsKey, room.ID, roomData)
	for _, memberID := range room.memberIDs() {
		if memberID == "" {
			continue
		}
		pipe.Set(ctx, fmt.Sprintf(userRoomKey, room.GameID, memberID), refData, roomTTL)
		pipe.Del(ctx, fmt.Sprintf(legacyUserRoomKey, memberID))
	}
	pipe.Expire(ctx, roomsKey, roomTTL)
	if _, err := pipe.Exec(ctx); err != nil {
		return fmt.Errorf("save room: %w", err)
	}
	return nil
}

func (s *RoomStore) Get(gameID, roomID string) (Room, bool) {
	var room Room
	ctx, cancel := gameRedisContext(s.cache)
	data, err := s.cache.GetClient().HGet(ctx, fmt.Sprintf(roomsHashKey, gameID), roomID).Bytes()
	cancel()
	if err != nil || json.Unmarshal(data, &room) != nil {
		return Room{}, false
	}
	room.normalize()
	if roomLastActivity(room) < time.Now().Add(-roomTTL).UnixMilli() {
		_ = s.Delete(gameID, roomID, room.memberIDs()...)
		return Room{}, false
	}
	return room, true
}

func (s *RoomStore) Delete(gameID, roomID string, userIDs ...string) error {
	refData, err := json.Marshal(userRoomRef{GameID: gameID, RoomID: roomID})
	if err != nil {
		return fmt.Errorf("marshal room reference: %w", err)
	}
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
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
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
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
	ctx, cancel := gameRedisContext(s.cache)
	all, err := s.cache.GetClient().HGetAll(ctx, fmt.Sprintf(roomsHashKey, gameID)).Result()
	cancel()
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
		room.normalize()
		if roomLastActivity(room) < cutoff {
			_ = s.Delete(gameID, id, room.memberIDs()...)
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
	client := s.cache.GetClient()
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()

	var ref userRoomRef
	if data, err := client.Get(ctx, fmt.Sprintf(userRoomKey, gameID, userID)).Bytes(); err != nil || json.Unmarshal(data, &ref) != nil {
		data, err = client.Get(ctx, fmt.Sprintf(legacyUserRoomKey, userID)).Bytes()
		if err != nil || json.Unmarshal(data, &ref) != nil || ref.GameID != gameID {
			return userRoomRef{}, false
		}
		refData, err := json.Marshal(ref)
		if err == nil {
			pipe := client.TxPipeline()
			pipe.Set(ctx, fmt.Sprintf(userRoomKey, gameID, userID), refData, roomTTL)
			pipe.Del(ctx, fmt.Sprintf(legacyUserRoomKey, userID))
			_, _ = pipe.Exec(ctx)
		}
	}
	return ref, true
}

func (s *RoomStore) Claim(gameID, roomID string) (func(), bool) {
	key := fmt.Sprintf(roomLockKey, gameID, roomID)
	token := uuid.NewString()
	client := s.cache.GetClient()
	ctx, cancel := gameRedisContext(s.cache)
	ok, err := client.SetNX(ctx, key, token, roomLockTTL).Result()
	cancel()
	if err != nil || !ok {
		return nil, false
	}

	release := func() {
		const unlockScript = `
if redis.call("GET", KEYS[1]) == ARGV[1] then
  return redis.call("DEL", KEYS[1])
end
return 0`
		releaseCtx, releaseCancel := gameRedisContext(s.cache)
		defer releaseCancel()
		_, _ = client.Eval(releaseCtx, unlockScript, []string{key}, token).Result()
	}
	return release, true
}
