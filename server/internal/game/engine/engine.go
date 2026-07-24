package engine

import (
	"encoding/json"
	"fmt"
	"math/rand"
	"sort"
	"strings"
	"sync"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Emitter interface {
	ToUser(gameID string, userID string, envelope protocol.OutEnvelope)
	ToGame(gameID string, envelope protocol.OutEnvelope)
}

const (
	finishedResultTTL = 2 * time.Minute
	maxChatRunes      = 120
	chatCooldown      = 500 * time.Millisecond
)

type Engine struct {
	// mu protects only the match registries. Match state is protected by Match.mu.
	mu sync.RWMutex
	// Queue, room workflows, and completed results do not share the registry lock.
	queueMu      sync.Mutex
	roomMu       sync.Mutex
	finishedMu   sync.Mutex
	emitterMu    sync.RWMutex
	restoreMu    sync.Mutex
	logger       *zap.SugaredLogger
	emitter      Emitter
	store        RoomRepository
	activeStore  ActiveMatchRepository
	queues       map[string][]protocol.PlayerInfo
	matches      map[string]*Match
	byUser       map[string]*Match
	finished     map[string]protocol.MatchOverData
	turnSeconds  int
	graceSeconds int
	restored     bool
}

type Match struct {
	// mu protects mutable gameplay state, persistence, and both timer generations.
	mu            sync.Mutex
	ID            string
	GameID        string
	logic         logic.GameLogic
	players       []protocol.PlayerInfo
	state         any
	turnIdx       int
	deadline      time.Time
	timer         *time.Timer
	turnGen       int
	over          bool
	bet           int
	graceTimer    *time.Timer
	graceDeadline time.Time
	graceGen      int
	disconnected  map[int]bool
	pausedRemain  time.Duration
	startedAt     time.Time
	winnerID      string
	resultReason  string
	finishedAt    time.Time
	lastChatAt    [2]time.Time
}

func NewEngine(
	logger *zap.SugaredLogger,
	turnSeconds int,
	graceSeconds int,
	store RoomRepository,
	activeStore ActiveMatchRepository,
) *Engine {
	return &Engine{
		logger:       logger.Named("[game-engine]"),
		store:        store,
		activeStore:  activeStore,
		queues:       make(map[string][]protocol.PlayerInfo),
		matches:      make(map[string]*Match),
		byUser:       make(map[string]*Match),
		finished:     make(map[string]protocol.MatchOverData),
		turnSeconds:  turnSeconds,
		graceSeconds: graceSeconds,
	}
}

func userKey(gameID, userID string) string {
	return gameID + ":" + userID
}

func (e *Engine) SetEmitter(emitter Emitter) {
	e.emitterMu.Lock()
	e.emitter = emitter
	e.emitterMu.Unlock()

	e.restoreMu.Lock()
	defer e.restoreMu.Unlock()
	if !e.restored {
		e.restoreActiveMatches()
		e.restored = true
	}
}

func (e *Engine) currentEmitter() Emitter {
	e.emitterMu.RLock()
	defer e.emitterMu.RUnlock()
	return e.emitter
}

func (e *Engine) toUser(gameID, userID string, envelope protocol.OutEnvelope) {
	if emitter := e.currentEmitter(); emitter != nil {
		emitter.ToUser(gameID, userID, envelope)
	}
}

func (e *Engine) toGame(gameID string, envelope protocol.OutEnvelope) {
	if emitter := e.currentEmitter(); emitter != nil {
		emitter.ToGame(gameID, envelope)
	}
}

func (e *Engine) matchForUser(gameID, userID string) *Match {
	e.mu.RLock()
	defer e.mu.RUnlock()
	return e.byUser[userKey(gameID, userID)]
}

func (e *Engine) matchByID(matchID string) *Match {
	e.mu.RLock()
	defer e.mu.RUnlock()
	return e.matches[matchID]
}

func (e *Engine) sendActiveMatch(gameID, userID string) bool {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		return false
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		return false
	}
	e.sendMatchFound(m, true)
	return true
}

func (e *Engine) hasActiveMatch(gameID, userID string) bool {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		return false
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	return !m.over
}

func (e *Engine) installMatch(m *Match) bool {
	e.mu.Lock()
	defer e.mu.Unlock()
	if _, exists := e.matches[m.ID]; exists {
		return false
	}
	for _, player := range m.players {
		if current := e.byUser[userKey(m.GameID, player.ID)]; current != nil {
			return false
		}
	}
	e.matches[m.ID] = m
	for _, player := range m.players {
		e.byUser[userKey(m.GameID, player.ID)] = m
	}
	return true
}

func (e *Engine) removeMatch(m *Match) {
	e.mu.Lock()
	defer e.mu.Unlock()
	if e.matches[m.ID] == m {
		delete(e.matches, m.ID)
	}
	for _, player := range m.players {
		key := userKey(m.GameID, player.ID)
		if e.byUser[key] == m {
			delete(e.byUser, key)
		}
	}
}

func (e *Engine) takeFinished(key string) (protocol.MatchOverData, bool) {
	e.finishedMu.Lock()
	defer e.finishedMu.Unlock()
	data, ok := e.finished[key]
	if ok {
		delete(e.finished, key)
	}
	return data, ok
}

func (e *Engine) clearFinished(keys ...string) {
	e.finishedMu.Lock()
	defer e.finishedMu.Unlock()
	for _, key := range keys {
		delete(e.finished, key)
	}
}

func (e *Engine) OnConnect(gameID, userID string) {
	key := userKey(gameID, userID)
	if e.reconnectActiveMatch(gameID, userID) {
		return
	}

	if data, ok := e.takeFinished(key); ok {
		e.toUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
		return
	}

	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	// A room may have started while this connection waited for roomMu.
	if e.reconnectActiveMatch(gameID, userID) {
		return
	}
	if data, ok := e.takeFinished(key); ok {
		e.toUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
		return
	}
	if ref, ok := e.store.RoomByUser(gameID, userID); ok {
		if room, exists := e.store.Get(gameID, ref.RoomID); exists && room.hasMember(userID) {
			e.emitRoomWaiting(gameID, userID, room)
			e.emitRoomStateTo(room, userID)
		} else {
			_ = e.store.DeleteUserRef(gameID, userID, ref.RoomID)
		}
	}
}

func (e *Engine) reconnectActiveMatch(gameID, userID string) bool {
	if m := e.matchForUser(gameID, userID); m != nil {
		m.mu.Lock()
		if !m.over {
			idx := m.playerIndex(userID)
			if m.disconnected[idx] {
				delete(m.disconnected, idx)
				e.toUser(m.GameID, m.players[1-idx].ID, protocol.OutEnvelope{Type: protocol.S2COpponentReconnected})
				if len(m.disconnected) == 0 {
					e.cancelGrace(m)
					if m.pausedRemain > 0 {
						e.armTimerDuration(m, m.pausedRemain)
						m.pausedRemain = 0
					}
				}
				if err := e.persistMatch(m); err != nil {
					e.logger.Errorw("Failed to persist reconnected match", "match_id", m.ID, "error", err)
				}
			}
			e.sendMatchFoundTo(m, userID, true)
			oppIdx := 1 - idx
			if m.disconnected[oppIdx] {
				e.toUser(m.GameID, userID, protocol.OutEnvelope{
					Type: protocol.S2COpponentDisconnected,
					Data: protocol.OpponentDisconnectedData{GraceDeadline: m.graceDeadline.UnixMilli()},
				})
			}
			m.mu.Unlock()
			return true
		}
		m.mu.Unlock()
	}
	return false
}

func (e *Engine) JoinQueue(gameID string, player protocol.PlayerInfo) {
	if e.sendActiveMatch(gameID, player.ID) {
		return
	}

	e.roomMu.Lock()
	if ref, ok := e.store.RoomByUser(gameID, player.ID); ok {
		if room, exists := e.store.Get(gameID, ref.RoomID); exists && room.hasMember(player.ID) {
			e.emitRoomWaiting(gameID, player.ID, room)
			e.emitRoomStateTo(room, player.ID)
			e.sendError(gameID, player.ID, "IN_ROOM", "leave the current room before joining queue")
			e.roomMu.Unlock()
			return
		}
		_ = e.store.DeleteUserRef(gameID, player.ID, ref.RoomID)
	}
	e.roomMu.Unlock()
	if e.sendActiveMatch(gameID, player.ID) {
		return
	}

	gameLogic, err := logic.Get(gameID)
	if err != nil {
		e.sendError(gameID, player.ID, "UNKNOWN_GAME", err.Error())
		return
	}

	e.queueMu.Lock()
	defer e.queueMu.Unlock()
	queue := e.queues[gameID]
	for _, waiting := range queue {
		if waiting.ID == player.ID {
			e.toUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
			return
		}
	}

	if len(queue) == 0 {
		e.queues[gameID] = append(queue, player)
		e.toUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
		return
	}

	opponent := queue[0]
	e.queues[gameID] = queue[1:]
	if e.hasActiveMatch(gameID, opponent.ID) {
		e.queues[gameID] = append(e.queues[gameID], player)
		e.toUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
		return
	}
	if err := e.startMatch(gameID, gameLogic, opponent, player, 0); err != nil {
		e.queues[gameID] = append([]protocol.PlayerInfo{opponent}, e.queues[gameID]...)
		e.queues[gameID] = append(e.queues[gameID], player)
		e.sendError(gameID, opponent.ID, "MATCH_START_FAILED", err.Error())
		e.sendError(gameID, player.ID, "MATCH_START_FAILED", err.Error())
	}
}

func (e *Engine) LeaveQueue(gameID string, userID string) {
	e.queueMu.Lock()
	defer e.queueMu.Unlock()
	e.leaveQueueLocked(gameID, userID)
}

func (e *Engine) leaveQueue(gameID, userID string) {
	e.queueMu.Lock()
	defer e.queueMu.Unlock()
	e.leaveQueueLocked(gameID, userID)
}

func (e *Engine) leaveQueueLocked(gameID string, userID string) {
	queue := e.queues[gameID]
	for i, waiting := range queue {
		if waiting.ID == userID {
			e.queues[gameID] = append(queue[:i], queue[i+1:]...)
			return
		}
	}
}

func (e *Engine) CreateRoom(gameID string, owner protocol.PlayerInfo, bet int, password string) {
	if e.sendActiveMatch(gameID, owner.ID) {
		return
	}
	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	if e.sendActiveMatch(gameID, owner.ID) {
		return
	}

	if _, err := logic.Get(gameID); err != nil {
		e.sendError(gameID, owner.ID, "UNKNOWN_GAME", err.Error())
		return
	}
	if bet < 0 {
		e.sendError(gameID, owner.ID, "INVALID_BET", "bet cannot be negative")
		return
	}
	if len(password) > 64 {
		e.sendError(gameID, owner.ID, "INVALID_PASSWORD", "room password is too long")
		return
	}

	if ref, ok := e.store.RoomByUser(gameID, owner.ID); ok {
		if room, ok2 := e.store.Get(gameID, ref.RoomID); ok2 && room.hasMember(owner.ID) {
			e.emitRoomWaiting(gameID, owner.ID, room)
			e.emitRoomStateTo(room, owner.ID)
			return
		}
		_ = e.store.DeleteUserRef(gameID, owner.ID, ref.RoomID)
	}
	e.leaveQueue(gameID, owner.ID)

	room := Room{
		ID:         uuid.NewString(),
		GameID:     gameID,
		OwnerID:    owner.ID,
		OwnerName:  owner.Name,
		OwnerReady: true,
		Bet:        bet,
		Password:   password,
		CreatedAt:  time.Now().UnixMilli(),
	}
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, owner.ID, "ROOM_CREATE_FAILED", err.Error())
		return
	}
	e.clearFinished(userKey(gameID, owner.ID))
	e.emitRoomUpsert(room)
	e.emitRoomWaiting(gameID, owner.ID, room)
	e.emitRoomStateTo(room, owner.ID)
	e.logger.Infow("Room created", "room_id", room.ID, "owner", owner.ID, "bet", bet)
}

func (e *Engine) JoinRoom(gameID string, joiner protocol.PlayerInfo, roomID, password string) {
	if e.sendActiveMatch(gameID, joiner.ID) {
		return
	}
	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	if e.sendActiveMatch(gameID, joiner.ID) {
		return
	}

	if roomID == "" {
		e.sendError(gameID, joiner.ID, "ROOM_NOT_FOUND", "room id is required")
		return
	}
	if ref, exists := e.store.RoomByUser(gameID, joiner.ID); exists {
		if room, ok := e.store.Get(gameID, ref.RoomID); ok && room.hasMember(joiner.ID) {
			if room.ID == roomID {
				e.emitRoomWaiting(gameID, joiner.ID, room)
				e.emitRoomStateTo(room, joiner.ID)
				return
			}
			e.sendError(gameID, joiner.ID, "ALREADY_IN_ROOM", "leave the current room before joining another")
			return
		}
		_ = e.store.DeleteUserRef(gameID, joiner.ID, ref.RoomID)
	}

	release, claimed := e.store.Claim(gameID, roomID)
	if !claimed {
		e.sendError(gameID, joiner.ID, "ROOM_BUSY", "room is being updated")
		return
	}
	defer release()

	room, ok := e.store.Get(gameID, roomID)
	if !ok {
		e.sendError(gameID, joiner.ID, "ROOM_NOT_FOUND", "room not found")
		return
	}
	if room.OwnerID == joiner.ID {
		e.sendError(gameID, joiner.ID, "OWN_ROOM", "cannot join your own room")
		return
	}
	if room.Password != "" && room.Password != password {
		e.sendError(gameID, joiner.ID, "WRONG_PASSWORD", "wrong password")
		return
	}
	if room.GuestID != "" && room.GuestID != joiner.ID {
		e.sendError(gameID, joiner.ID, "ROOM_FULL", "room is full")
		return
	}
	if e.hasActiveMatch(gameID, room.OwnerID) {
		if err := e.store.Delete(gameID, room.ID, room.OwnerID, room.GuestID); err != nil {
			e.logger.Errorw("Failed to delete room whose owner is busy", "room_id", room.ID, "error", err)
			e.sendError(gameID, joiner.ID, "ROOM_UPDATE_FAILED", "failed to close unavailable room")
			return
		}
		e.emitRoomRemoved(room.GameID, room.ID)
		e.emitRoomClosed(room, "owner_busy")
		e.sendError(gameID, joiner.ID, "ROOM_NOT_FOUND", "room owner busy")
		return
	}

	room.GuestID = joiner.ID
	room.GuestName = joiner.Name
	room.OwnerReady = true
	room.GuestReady = false
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, joiner.ID, "ROOM_JOIN_FAILED", err.Error())
		return
	}
	e.clearFinished(userKey(gameID, joiner.ID))
	e.leaveQueue(gameID, joiner.ID)
	e.emitRoomUpsert(room)
	e.emitRoomWaiting(gameID, joiner.ID, room)
	e.emitRoomState(room)
}

func (e *Engine) LeaveRoom(gameID, userID, roomID string) {
	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	e.leaveRoomLocked(gameID, userID, roomID, false)
}

func (e *Engine) leaveRoomLocked(gameID, userID, roomID string, disconnected bool) {
	ref, ok := e.store.RoomByUser(gameID, userID)
	if !ok {
		return
	}
	if roomID != "" && roomID != ref.RoomID {
		e.sendError(gameID, userID, "ROOM_MISMATCH", "room does not match current membership")
		return
	}

	release, claimed := e.store.Claim(gameID, ref.RoomID)
	if !claimed {
		e.sendError(gameID, userID, "ROOM_BUSY", "room is being updated")
		return
	}
	defer release()

	room, exists := e.store.Get(gameID, ref.RoomID)
	if !exists || !room.hasMember(userID) {
		_ = e.store.DeleteUserRef(gameID, userID, ref.RoomID)
		return
	}

	if room.OwnerID == userID {
		if err := e.store.Delete(gameID, room.ID, room.OwnerID, room.GuestID); err != nil {
			e.logger.Errorw("Failed to close room", "room_id", room.ID, "error", err)
			e.sendError(gameID, userID, "ROOM_LEAVE_FAILED", err.Error())
			return
		}
		reason := "owner_left"
		if disconnected {
			reason = "owner_disconnected"
		}
		e.emitRoomRemoved(room.GameID, room.ID)
		e.emitRoomClosed(room, reason)
		return
	}

	guestID := room.GuestID
	if !disconnected {
		if err := e.store.Delete(gameID, room.ID, room.OwnerID, room.GuestID); err != nil {
			e.logger.Errorw("Failed to cancel room after member left", "room_id", room.ID, "error", err)
			e.sendError(gameID, userID, "ROOM_LEAVE_FAILED", err.Error())
			return
		}
		e.emitRoomRemoved(room.GameID, room.ID)
		e.emitRoomClosed(room, "member_left")
		return
	}
	room.GuestID = ""
	room.GuestName = ""
	room.OwnerReady = true
	room.GuestReady = false
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, userID, "ROOM_LEAVE_FAILED", err.Error())
		return
	}
	_ = e.store.DeleteUserRef(gameID, guestID, room.ID)
	e.emitRoomUpsert(room)
	e.emitRoomStateTo(room, room.OwnerID)
}

func (e *Engine) SetRoomReady(gameID, userID, roomID string, ready bool) {
	e.roomMu.Lock()
	defer e.roomMu.Unlock()

	room, release, ok := e.roomForAction(gameID, userID, roomID)
	if !ok {
		return
	}
	defer release()
	if room.OwnerID == userID {
		// The room owner is ready from creation until the room is closed.
		room.OwnerReady = true
	} else {
		room.GuestReady = ready
	}
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, userID, "ROOM_UPDATE_FAILED", err.Error())
		return
	}
	e.emitRoomState(room)
}

func (e *Engine) KickRoomMember(gameID, ownerID, roomID, targetID string) {
	e.roomMu.Lock()
	defer e.roomMu.Unlock()

	room, release, ok := e.roomForAction(gameID, ownerID, roomID)
	if !ok {
		return
	}
	defer release()
	if room.OwnerID != ownerID {
		e.sendError(gameID, ownerID, "NOT_ROOM_OWNER", "only the room owner can kick members")
		return
	}
	if room.GuestID == "" || (targetID != "" && targetID != room.GuestID) {
		e.sendError(gameID, ownerID, "ROOM_MEMBER_NOT_FOUND", "room member not found")
		return
	}

	kickedID := room.GuestID
	room.GuestID = ""
	room.GuestName = ""
	room.OwnerReady = true
	room.GuestReady = false
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, ownerID, "ROOM_UPDATE_FAILED", err.Error())
		return
	}
	_ = e.store.DeleteUserRef(gameID, kickedID, room.ID)
	e.emitRoomUpsert(room)
	e.toUser(gameID, kickedID, protocol.OutEnvelope{
		Type: protocol.S2CRoomKicked,
		Data: protocol.RoomKickedData{RoomID: room.ID, ByUserID: ownerID},
	})
	e.emitRoomStateTo(room, ownerID)
}

func (e *Engine) StartRoom(gameID, ownerID, roomID string) {
	e.roomMu.Lock()
	defer e.roomMu.Unlock()

	room, release, ok := e.roomForAction(gameID, ownerID, roomID)
	if !ok {
		return
	}
	defer release()
	if room.OwnerID != ownerID {
		e.sendError(gameID, ownerID, "NOT_ROOM_OWNER", "only the room owner can start the match")
		return
	}
	if room.GuestID == "" {
		e.sendError(gameID, ownerID, "ROOM_NOT_FULL", "another player is required")
		return
	}
	room.OwnerReady = true
	if !room.GuestReady {
		e.sendError(gameID, ownerID, "ROOM_NOT_READY", "all players must be ready")
		return
	}
	gameLogic, err := logic.Get(gameID)
	if err != nil {
		e.sendError(gameID, ownerID, "UNKNOWN_GAME", err.Error())
		return
	}
	if err := e.store.Delete(gameID, room.ID, room.OwnerID, room.GuestID); err != nil {
		e.sendError(gameID, ownerID, "ROOM_START_FAILED", err.Error())
		return
	}
	if err := e.startMatch(
		gameID,
		gameLogic,
		protocol.PlayerInfo{ID: room.OwnerID, Name: room.OwnerName},
		protocol.PlayerInfo{ID: room.GuestID, Name: room.GuestName},
		room.Bet,
	); err != nil {
		if restoreErr := e.store.Save(room); restoreErr != nil {
			e.logger.Errorw("Failed to restore room after match start failure", "room_id", room.ID, "error", restoreErr)
			e.emitRoomRemoved(room.GameID, room.ID)
		} else {
			e.emitRoomUpsert(room)
		}
		e.sendError(gameID, ownerID, "ROOM_START_FAILED", err.Error())
		e.sendError(gameID, room.GuestID, "ROOM_START_FAILED", err.Error())
		return
	}
	e.emitRoomRemoved(room.GameID, room.ID)
}

func (e *Engine) ListRooms(gameID, userID string) {
	rooms, err := e.store.List(gameID)
	if err != nil {
		e.logger.Errorw("Failed to list rooms", "game_id", gameID, "error", err)
		e.sendError(gameID, userID, "ROOM_LIST_FAILED", "failed to load rooms")
		return
	}
	sort.Slice(rooms, func(i, j int) bool {
		if rooms[i].CreatedAt == rooms[j].CreatedAt {
			return rooms[i].ID < rooms[j].ID
		}
		return rooms[i].CreatedAt > rooms[j].CreatedAt
	})
	infos := make([]protocol.RoomInfo, 0, len(rooms))
	for _, r := range rooms {
		infos = append(infos, roomInfo(r))
	}
	e.toUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CRoomList, Data: protocol.RoomListData{Rooms: infos}})
}

func roomInfo(room Room) protocol.RoomInfo {
	players := 1
	if room.GuestID != "" {
		players = 2
	}
	return protocol.RoomInfo{
		ID:      room.ID,
		Owner:   room.OwnerName,
		Bet:     room.Bet,
		Locked:  room.Password != "",
		Players: players,
		Full:    players == 2,
	}
}

func (e *Engine) emitRoomUpsert(room Room) {
	e.toGame(room.GameID, protocol.OutEnvelope{
		Type: protocol.S2CRoomUpsert,
		Data: protocol.RoomUpsertData{Room: roomInfo(room)},
	})
}

func (e *Engine) emitRoomRemoved(gameID, roomID string) {
	e.toGame(gameID, protocol.OutEnvelope{
		Type: protocol.S2CRoomRemoved,
		Data: protocol.RoomRemovedData{RoomID: roomID},
	})
}

func (e *Engine) emitRoomWaiting(gameID, userID string, room Room) {
	e.toUser(gameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CRoomWaiting,
		Data: protocol.RoomWaitingData{RoomID: room.ID, Bet: room.Bet, Locked: room.Password != ""},
	})
}

func (e *Engine) emitRoomState(room Room) {
	e.emitRoomStateTo(room, room.OwnerID)
	if room.GuestID != "" {
		e.emitRoomStateTo(room, room.GuestID)
	}
}

func (e *Engine) emitRoomStateTo(room Room, userID string) {
	members := []protocol.RoomMember{{
		ID: room.OwnerID, Name: room.OwnerName, Owner: true, Ready: true,
	}}
	if room.GuestID != "" {
		members = append(members, protocol.RoomMember{
			ID: room.GuestID, Name: room.GuestName, Ready: room.GuestReady,
		})
	}
	e.toUser(room.GameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CRoomState,
		Data: protocol.RoomStateData{
			RoomID: room.ID, OwnerID: room.OwnerID, YouID: userID, Bet: room.Bet,
			Locked: room.Password != "", Members: members,
		},
	})
}

func (e *Engine) emitRoomClosed(room Room, reason string) {
	data := protocol.RoomClosedData{RoomID: room.ID, Reason: reason}
	e.toUser(room.GameID, room.OwnerID, protocol.OutEnvelope{Type: protocol.S2CRoomClosed, Data: data})
	if room.GuestID != "" {
		e.toUser(room.GameID, room.GuestID, protocol.OutEnvelope{Type: protocol.S2CRoomClosed, Data: data})
	}
}

func (e *Engine) roomForAction(gameID, userID, roomID string) (Room, func(), bool) {
	if roomID == "" {
		e.sendError(gameID, userID, "ROOM_NOT_FOUND", "room id is required")
		return Room{}, nil, false
	}
	ref, ok := e.store.RoomByUser(gameID, userID)
	if !ok || ref.RoomID != roomID {
		e.sendError(gameID, userID, "ROOM_NOT_FOUND", "room not found")
		return Room{}, nil, false
	}
	release, claimed := e.store.Claim(gameID, roomID)
	if !claimed {
		e.sendError(gameID, userID, "ROOM_BUSY", "room is being updated")
		return Room{}, nil, false
	}
	room, exists := e.store.Get(gameID, roomID)
	if !exists || !room.hasMember(userID) {
		release()
		_ = e.store.DeleteUserRef(gameID, userID, ref.RoomID)
		e.sendError(gameID, userID, "ROOM_NOT_FOUND", "room not found")
		return Room{}, nil, false
	}
	return room, release, true
}

func (r Room) hasMember(userID string) bool {
	return r.OwnerID == userID || r.GuestID == userID
}

func (e *Engine) OnDisconnect(gameID, userID string) {
	if e.disconnectActiveMatch(gameID, userID) {
		return
	}
	e.leaveQueue(gameID, userID)

	// A queue match may have been installed while the user was being removed
	// from the queue. Check the in-memory registry again before touching rooms.
	if e.disconnectActiveMatch(gameID, userID) {
		return
	}

	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	if e.disconnectActiveMatch(gameID, userID) {
		return
	}
	if ref, ok := e.store.RoomByUser(gameID, userID); ok {
		e.leaveRoomLocked(gameID, userID, ref.RoomID, true)
	}
}

func (e *Engine) disconnectActiveMatch(gameID, userID string) bool {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		return false
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		return false
	}
	idx := m.playerIndex(userID)
	if m.disconnected[idx] {
		return true
	}
	if m.disconnected == nil {
		m.disconnected = make(map[int]bool)
	}
	first := len(m.disconnected) == 0
	m.disconnected[idx] = true

	if m.turnIdx == idx && m.pausedRemain == 0 {
		e.invalidateTurnTimer(m)
		remain := time.Until(m.deadline)
		if remain < time.Second {
			remain = time.Second
		}
		m.pausedRemain = remain
	}

	if first {
		m.graceGen++
		gen := m.graceGen
		m.graceDeadline = time.Now().Add(time.Duration(e.graceSeconds) * time.Second)
		matchID := m.ID
		m.graceTimer = time.AfterFunc(time.Until(m.graceDeadline), func() {
			e.onGraceExpire(matchID, gen)
		})
	}

	oppIdx := 1 - idx
	if !m.disconnected[oppIdx] {
		e.toUser(m.GameID, m.players[oppIdx].ID, protocol.OutEnvelope{
			Type: protocol.S2COpponentDisconnected,
			Data: protocol.OpponentDisconnectedData{GraceDeadline: m.graceDeadline.UnixMilli()},
		})
	}
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist disconnected match", "match_id", m.ID, "error", err)
	}
	return true
}

func (e *Engine) cancelGrace(m *Match) {
	if m.graceTimer != nil {
		m.graceTimer.Stop()
		m.graceTimer = nil
	}
	m.graceGen++
	m.graceDeadline = time.Time{}
}

func (e *Engine) onGraceExpire(matchID string, gen int) {
	m := e.matchByID(matchID)
	if m == nil {
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over || m.graceGen != gen {
		return
	}
	if m.disconnected[0] && m.disconnected[1] {
		e.finishMatch(m, "", "disconnect")
		return
	}
	winnerIdx := 0
	if m.disconnected[0] {
		winnerIdx = 1
	}
	e.finishMatch(m, m.players[winnerIdx].ID, "disconnect")
}

func (e *Engine) Move(gameID, userID, matchID string, move json.RawMessage) {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		e.sendError(gameID, userID, "NO_MATCH", "no active match")
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		e.sendError(gameID, userID, "NO_MATCH", "no active match")
		return
	}
	if matchID != "" && matchID != m.ID {
		return
	}

	playerIdx := m.playerIndex(userID)
	if playerIdx != m.turnIdx {
		e.sendError(gameID, userID, "NOT_YOUR_TURN", "not your turn")
		return
	}
	if time.Now().After(m.deadline) {
		return
	}

	if err := m.logic.ValidateMove(m.state, playerIdx, move); err != nil {
		e.sendError(gameID, userID, "INVALID_MOVE", err.Error())
		return
	}

	state, err := m.logic.Apply(m.state, playerIdx, move)
	if err != nil {
		e.sendError(gameID, userID, "INVALID_MOVE", err.Error())
		return
	}
	previousState := m.state
	previousTurn := m.turnIdx
	previousDeadline := m.deadline
	previousPausedRemain := m.pausedRemain
	m.state = state

	if over, winnerIdx := m.logic.Result(m.state); over {
		winnerID := ""
		reason := "win"
		if winnerIdx >= 0 {
			winnerID = m.players[winnerIdx].ID
		} else {
			reason = "draw"
		}
		e.finishMatch(m, winnerID, reason)
		return
	}

	m.turnIdx = 1 - m.turnIdx
	m.deadline = time.Now().Add(time.Duration(e.turnSeconds) * time.Second)
	if m.disconnected[m.turnIdx] {
		e.invalidateTurnTimer(m)
		m.pausedRemain = time.Until(m.deadline)
		if m.pausedRemain < time.Second {
			m.pausedRemain = time.Second
		}
	}
	if err := e.persistMatch(m); err != nil {
		m.state = previousState
		m.turnIdx = previousTurn
		m.deadline = previousDeadline
		m.pausedRemain = previousPausedRemain
		if m.pausedRemain == 0 {
			e.scheduleTurnTimer(m)
		}
		e.logger.Errorw("Failed to persist match move", "match_id", m.ID, "user_id", userID, "error", err)
		e.sendError(gameID, userID, "STATE_SAVE_FAILED", "failed to save the move, please retry")
		return
	}
	if m.pausedRemain == 0 {
		e.scheduleTurnTimer(m)
	}

	data := protocol.StateData{
		MatchID:  m.ID,
		State:    m.state,
		Turn:     m.turnIdx,
		Deadline: m.deadline.UnixMilli(),
		LastMove: move,
		LastBy:   playerIdx,
	}
	for _, p := range m.players {
		e.toUser(m.GameID, p.ID, protocol.OutEnvelope{Type: protocol.S2CState, Data: data})
	}
}

func (e *Engine) Chat(gameID, userID, matchID, text string) {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		e.sendError(gameID, userID, "NO_MATCH", "no active match")
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		e.sendError(gameID, userID, "NO_MATCH", "no active match")
		return
	}
	if matchID == "" || matchID != m.ID {
		e.sendError(gameID, userID, "MATCH_MISMATCH", "chat does not belong to the active match")
		return
	}
	text = strings.TrimSpace(text)
	if text == "" {
		e.sendError(gameID, userID, "INVALID_CHAT", "chat message cannot be empty")
		return
	}
	if utf8.RuneCountInString(text) > maxChatRunes {
		e.sendError(gameID, userID, "CHAT_TOO_LONG", "chat message is too long")
		return
	}

	senderIdx := m.playerIndex(userID)
	now := time.Now()
	if last := m.lastChatAt[senderIdx]; !last.IsZero() && now.Sub(last) < chatCooldown {
		e.sendError(gameID, userID, "CHAT_RATE_LIMITED", "chat messages are being sent too quickly")
		return
	}
	m.lastChatAt[senderIdx] = now
	data := protocol.ChatMessageData{
		MatchID: m.ID,
		UserID:  userID,
		Name:    m.players[senderIdx].Name,
		Text:    text,
		SentAt:  now.UnixMilli(),
	}
	for _, player := range m.players {
		e.toUser(m.GameID, player.ID, protocol.OutEnvelope{
			Type: protocol.S2CChatMessage,
			Data: data,
		})
	}
}

func (e *Engine) Forfeit(gameID, userID, matchID string) {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		return
	}
	if matchID != "" && matchID != m.ID {
		return
	}
	winnerIdx := 1 - m.playerIndex(userID)
	e.finishMatch(m, m.players[winnerIdx].ID, "forfeit")
}

func (e *Engine) startMatch(gameID string, gameLogic logic.GameLogic, p0, p1 protocol.PlayerInfo, bet int) error {
	if rand.Intn(2) == 1 {
		p0, p1 = p1, p0
	}

	m := &Match{
		ID:           uuid.NewString(),
		GameID:       gameID,
		logic:        gameLogic,
		players:      []protocol.PlayerInfo{p0, p1},
		state:        gameLogic.Init(time.Now().UnixNano()),
		turnIdx:      0,
		bet:          bet,
		disconnected: make(map[int]bool),
		startedAt:    time.Now(),
	}
	m.deadline = time.Now().Add(time.Duration(e.turnSeconds) * time.Second)
	m.mu.Lock()
	defer m.mu.Unlock()
	if !e.installMatch(m) {
		return fmt.Errorf("one or more players already have an active match")
	}
	if err := e.persistMatch(m); err != nil {
		m.over = true
		e.removeMatch(m)
		return fmt.Errorf("persist active match: %w", err)
	}
	e.clearFinished(userKey(gameID, p0.ID), userKey(gameID, p1.ID))
	e.scheduleTurnTimer(m)
	e.sendMatchFound(m, false)
	e.logger.Infow("Match started", "match_id", m.ID, "game_id", gameID, "p0", p0.ID, "p1", p1.ID)
	return nil
}

func (e *Engine) sendMatchFound(m *Match, resumed bool) {
	for _, p := range m.players {
		e.sendMatchFoundTo(m, p.ID, resumed)
	}
}

func (e *Engine) sendMatchFoundTo(m *Match, userID string, resumed bool) {
	e.toUser(m.GameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CMatchFound,
		Data: protocol.MatchFoundData{
			MatchID:  m.ID,
			GameID:   m.GameID,
			Players:  m.players,
			You:      m.playerIndex(userID),
			State:    m.state,
			Turn:     m.turnIdx,
			Deadline: m.deadline.UnixMilli(),
			Resumed:  resumed,
			Bet:      m.bet,
		},
	})
}

func (e *Engine) armTimerDuration(m *Match, d time.Duration) {
	m.deadline = time.Now().Add(d)
	e.scheduleTurnTimer(m)
}

func (e *Engine) scheduleTurnTimer(m *Match) {
	if m.timer != nil {
		m.timer.Stop()
	}
	m.turnGen++
	matchID := m.ID
	turnAtArm := m.turnIdx
	genAtArm := m.turnGen
	m.timer = time.AfterFunc(time.Until(m.deadline), func() {
		e.onTimeout(matchID, turnAtArm, genAtArm)
	})
}

func (e *Engine) invalidateTurnTimer(m *Match) {
	if m.timer != nil {
		m.timer.Stop()
		m.timer = nil
	}
	m.turnGen++
}

func (e *Engine) onTimeout(matchID string, expectedTurn, expectedGen int) {
	m := e.matchByID(matchID)
	if m == nil {
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over || m.turnIdx != expectedTurn || m.turnGen != expectedGen ||
		m.pausedRemain > 0 || m.disconnected[m.turnIdx] {
		return
	}
	winnerIdx := 1 - m.turnIdx
	e.finishMatch(m, m.players[winnerIdx].ID, "timeout")
}

func (e *Engine) finishMatch(m *Match, winnerID string, reason string) {
	m.over = true
	m.winnerID = winnerID
	m.resultReason = reason
	m.finishedAt = time.Now()
	if m.timer != nil {
		m.timer.Stop()
	}
	if m.graceTimer != nil {
		m.graceTimer.Stop()
	}
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist final match snapshot", "match_id", m.ID, "error", err)
	}
	if err := e.activeStore.Delete(m.GameID, m.ID, m.players[0].ID, m.players[1].ID); err != nil {
		e.logger.Errorw("Failed to delete finished active match", "match_id", m.ID, "error", err)
	}
	data := protocol.MatchOverData{
		MatchID:  m.ID,
		WinnerID: winnerID,
		Reason:   reason,
		State:    m.state,
		Bet:      m.bet,
	}
	keys := make([]string, 0, len(m.players))
	for _, p := range m.players {
		keys = append(keys, userKey(m.GameID, p.ID))
	}
	e.finishedMu.Lock()
	for _, key := range keys {
		e.finished[key] = data
	}
	e.finishedMu.Unlock()
	e.removeMatch(m)
	for _, p := range m.players {
		e.toUser(m.GameID, p.ID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
	}
	for _, key := range keys {
		e.scheduleFinishedCleanup(key, m.ID)
	}
	e.logger.Infow("Match finished", "match_id", m.ID, "winner", winnerID, "reason", reason)
}

func (e *Engine) scheduleFinishedCleanup(key, matchID string) {
	time.AfterFunc(finishedResultTTL, func() {
		e.finishedMu.Lock()
		if current, ok := e.finished[key]; ok && current.MatchID == matchID {
			delete(e.finished, key)
		}
		e.finishedMu.Unlock()
	})
}

func (e *Engine) persistMatch(m *Match) error {
	state, err := json.Marshal(m.state)
	if err != nil {
		return fmt.Errorf("marshal match state: %w", err)
	}
	status := matchStatusPlaying
	if m.over {
		status = matchStatusFinished
	}
	snapshot := ActiveMatchSnapshot{
		ID:                 m.ID,
		GameID:             m.GameID,
		Players:            m.players,
		State:              state,
		StateVersion:       m.logic.StateVersion(),
		TurnIndex:          m.turnIdx,
		TurnDeadline:       m.deadline.UnixMilli(),
		Bet:                m.bet,
		StartedAt:          m.startedAt.UnixMilli(),
		Status:             status,
		WinnerID:           m.winnerID,
		ResultReason:       m.resultReason,
		Disconnected:       m.disconnected,
		PausedRemainMillis: m.pausedRemain.Milliseconds(),
	}
	if !m.graceDeadline.IsZero() {
		snapshot.GraceDeadline = m.graceDeadline.UnixMilli()
	}
	if !m.finishedAt.IsZero() {
		snapshot.FinishedAt = m.finishedAt.UnixMilli()
	}
	return e.activeStore.Save(snapshot)
}

func (e *Engine) restoreActiveMatches() {
	restored := 0
	for _, gameID := range logic.IDs() {
		snapshots, err := e.activeStore.List(gameID)
		if err != nil {
			e.logger.Errorw("Failed to load active matches", "game_id", gameID, "error", err)
			continue
		}
		for _, snapshot := range snapshots {
			if snapshot.Status == matchStatusFinished {
				e.restoreFinishedSnapshot(snapshot)
				continue
			}
			if snapshot.Status != matchStatusPlaying {
				e.logger.Warnw("Skipped active match with unknown status", "match_id", snapshot.ID, "status", snapshot.Status)
				continue
			}
			if snapshot.ID == "" || snapshot.GameID != gameID || len(snapshot.Players) != 2 || snapshot.TurnIndex < 0 || snapshot.TurnIndex > 1 {
				e.logger.Warnw("Skipped invalid active match snapshot", "game_id", gameID, "match_id", snapshot.ID)
				continue
			}
			gameLogic, err := logic.Get(snapshot.GameID)
			if err != nil {
				e.logger.Errorw("Skipped active match with unknown game", "match_id", snapshot.ID, "error", err)
				continue
			}
			if snapshot.StateVersion != gameLogic.StateVersion() {
				e.logger.Errorw("Skipped active match with unsupported state version",
					"match_id", snapshot.ID,
					"saved_version", snapshot.StateVersion,
					"current_version", gameLogic.StateVersion(),
				)
				continue
			}
			state, err := gameLogic.DecodeState(snapshot.State)
			if err != nil {
				e.logger.Errorw("Failed to decode active match state", "match_id", snapshot.ID, "error", err)
				continue
			}
			startedAt := time.UnixMilli(snapshot.StartedAt)
			if snapshot.StartedAt <= 0 {
				startedAt = time.Now()
			}
			deadline := time.UnixMilli(snapshot.TurnDeadline)
			if snapshot.TurnDeadline <= 0 {
				deadline = time.Now().Add(time.Duration(e.turnSeconds) * time.Second)
			}
			pausedRemain := time.Duration(snapshot.PausedRemainMillis) * time.Millisecond
			if pausedRemain <= 0 {
				pausedRemain = time.Until(deadline)
				if pausedRemain < time.Second {
					pausedRemain = time.Second
				}
			}
			m := &Match{
				ID:           snapshot.ID,
				GameID:       snapshot.GameID,
				logic:        gameLogic,
				players:      snapshot.Players,
				state:        state,
				turnIdx:      snapshot.TurnIndex,
				deadline:     deadline,
				bet:          snapshot.Bet,
				disconnected: map[int]bool{0: true, 1: true},
				pausedRemain: pausedRemain,
				startedAt:    startedAt,
				graceGen:     1,
			}
			m.graceDeadline = time.Now().Add(time.Duration(e.graceSeconds) * time.Second)
			m.mu.Lock()
			if !e.installMatch(m) {
				m.mu.Unlock()
				e.logger.Warnw("Skipped active match because its id or a player is already restored", "match_id", snapshot.ID)
				continue
			}
			e.restoreTimersLocked(m)
			m.mu.Unlock()
			restored++
		}
	}
	if restored > 0 {
		e.logger.Infow("Restored active matches from Redis", "count", restored)
	}
}

func (e *Engine) restoreTimersLocked(m *Match) {
	if m.pausedRemain <= 0 {
		e.scheduleTurnTimer(m)
	} else if len(m.disconnected) == 0 {
		remain := m.pausedRemain
		m.pausedRemain = 0
		e.armTimerDuration(m, remain)
		if err := e.persistMatch(m); err != nil {
			e.logger.Errorw("Failed to normalize restored match timer", "match_id", m.ID, "error", err)
		}
	}
	if len(m.disconnected) == 0 {
		return
	}
	if m.graceDeadline.IsZero() {
		m.graceDeadline = time.Now().Add(time.Duration(e.graceSeconds) * time.Second)
	}
	gen := m.graceGen
	m.graceTimer = time.AfterFunc(time.Until(m.graceDeadline), func() {
		e.onGraceExpire(m.ID, gen)
	})
}

func (e *Engine) deleteSnapshot(snapshot ActiveMatchSnapshot) {
	userIDs := make([]string, 0, len(snapshot.Players))
	for _, player := range snapshot.Players {
		userIDs = append(userIDs, player.ID)
	}
	if err := e.activeStore.Delete(snapshot.GameID, snapshot.ID, userIDs...); err != nil {
		e.logger.Errorw("Failed to delete stale match snapshot", "match_id", snapshot.ID, "error", err)
	}
}

func (e *Engine) restoreFinishedSnapshot(snapshot ActiveMatchSnapshot) {
	gameLogic, err := logic.Get(snapshot.GameID)
	if err != nil || snapshot.StateVersion != gameLogic.StateVersion() {
		e.deleteSnapshot(snapshot)
		return
	}
	state, err := gameLogic.DecodeState(snapshot.State)
	if err != nil {
		e.logger.Errorw("Failed to decode finished match state", "match_id", snapshot.ID, "error", err)
		e.deleteSnapshot(snapshot)
		return
	}
	data := protocol.MatchOverData{
		MatchID:  snapshot.ID,
		WinnerID: snapshot.WinnerID,
		Reason:   snapshot.ResultReason,
		State:    state,
		Bet:      snapshot.Bet,
	}
	keys := make([]string, 0, len(snapshot.Players))
	e.finishedMu.Lock()
	for _, player := range snapshot.Players {
		key := userKey(snapshot.GameID, player.ID)
		e.finished[key] = data
		keys = append(keys, key)
	}
	e.finishedMu.Unlock()
	for _, key := range keys {
		e.scheduleFinishedCleanup(key, snapshot.ID)
	}
	e.deleteSnapshot(snapshot)
}

func (e *Engine) sendError(gameID, userID string, code string, message string) {
	e.toUser(gameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CError,
		Data: protocol.ErrorData{Code: code, Message: message},
	})
}

func (m *Match) playerIndex(userID string) int {
	if m.players[0].ID == userID {
		return 0
	}
	return 1
}
