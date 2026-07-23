package engine

import (
	"encoding/json"
	"fmt"
	"time"

	"ola-chat-server/internal/services"
)

const (
	roomTTL      = 30 * time.Minute
	roomLockTTL  = 10 * time.Second
	roomsHashKey = "GAME:%s:ROOMS"
	userRoomKey  = "GAME:USERROOM:%s"
	roomLockKey  = "GAME:ROOMLOCK:%s"
)

type Room struct {
	ID        string `json:"id"`
	GameID    string `json:"gameId"`
	OwnerID   string `json:"ownerId"`
	OwnerName string `json:"ownerName"`
	Bet       int    `json:"bet"`
	Password  string `json:"password"`
	CreatedAt int64  `json:"createdAt"`
}

type userRoomRef struct {
	GameID string `json:"gameId"`
	RoomID string `json:"roomId"`
}

type RoomStore struct {
	cache *services.CacheService
}

func NewRoomStore(cache *services.CacheService) *RoomStore {
	return &RoomStore{cache: cache}
}

func (s *RoomStore) Save(room Room) error {
	if err := s.cache.SetHash(fmt.Sprintf(roomsHashKey, room.GameID), room.ID, room); err != nil {
		return err
	}
	_ = s.cache.SetExpire(fmt.Sprintf(roomsHashKey, room.GameID), roomTTL)
	return s.cache.Set(fmt.Sprintf(userRoomKey, room.OwnerID), userRoomRef{GameID: room.GameID, RoomID: room.ID}, roomTTL)
}

func (s *RoomStore) Get(gameID, roomID string) (Room, bool) {
	var room Room
	if err := s.cache.GetHash(fmt.Sprintf(roomsHashKey, gameID), roomID, &room); err != nil {
		return Room{}, false
	}
	return room, true
}

func (s *RoomStore) Delete(gameID, roomID, ownerID string) {
	_ = s.cache.DeleteHash(fmt.Sprintf(roomsHashKey, gameID), roomID)
	if ownerID != "" {
		_ = s.cache.Delete(fmt.Sprintf(userRoomKey, ownerID))
	}
}

func (s *RoomStore) List(gameID string) []Room {
	all, err := s.cache.GetAllHash(fmt.Sprintf(roomsHashKey, gameID))
	if err != nil {
		return nil
	}
	cutoff := time.Now().Add(-roomTTL).UnixMilli()
	rooms := make([]Room, 0, len(all))
	for id, raw := range all {
		var room Room
		if json.Unmarshal([]byte(raw), &room) != nil {
			continue
		}
		if room.CreatedAt < cutoff {
			s.Delete(gameID, id, room.OwnerID)
			continue
		}
		rooms = append(rooms, room)
	}
	return rooms
}

func (s *RoomStore) RoomByUser(userID string) (userRoomRef, bool) {
	var ref userRoomRef
	if err := s.cache.Get(fmt.Sprintf(userRoomKey, userID), &ref); err != nil {
		return userRoomRef{}, false
	}
	return ref, true
}

func (s *RoomStore) Claim(roomID string) bool {
	ok, err := s.cache.SetNX(fmt.Sprintf(roomLockKey, roomID), "1", roomLockTTL)
	if err != nil {
		return false
	}
	return ok
}
