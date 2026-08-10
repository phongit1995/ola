package engine

import (
	"context"
	"encoding/json"
	"errors"
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
	reactionCooldown  = 800 * time.Millisecond
)

type Engine struct {
	// mu protects only the match registries. Match state is protected by Match.mu.
	mu sync.RWMutex
	// Queue, room workflows, and completed results do not share the registry lock.
	queueMu          sync.Mutex
	roomMu           sync.Mutex
	finishedMu       sync.Mutex
	emitterMu        sync.RWMutex
	settlementMu     sync.RWMutex
	restoreMu        sync.Mutex
	maintenanceOnce  sync.Once
	settlementJobsMu sync.Mutex
	restoreJobsMu    sync.Mutex
	abortJobsMu      sync.Mutex
	logger           *zap.SugaredLogger
	emitter          Emitter
	settlement       Settlement
	store            RoomRepository
	activeStore      ActiveMatchRepository
	queues           map[string][]protocol.PlayerInfo
	queuePending     map[string]bool
	queueCancelled   map[string]bool
	matches          map[string]*Match
	byUser           map[string]*Match
	terminalMatches  map[string]time.Time
	roomReservations map[string]struct{}
	finished         map[string]protocol.MatchOverData
	settlementJobs   map[string]struct{}
	restoreJobs      map[string]struct{}
	abortJobs        map[string]struct{}
	roomChatLast     map[string]time.Time
	turnSeconds      int
	graceSeconds     int
	restored         bool
}

type Match struct {
	// mu protects mutable gameplay state, persistence, and both timer generations.
	mu             sync.Mutex
	ID             string
	GameID         string
	logic          logic.GameLogic
	players        []protocol.PlayerInfo
	state          any
	turnIdx        int
	timeoutRuns    [2]int
	deadline       time.Time
	timer          *time.Timer
	turnGen        int
	over           bool
	bet            int
	graceTimer     *time.Timer
	graceDeadline  time.Time
	graceGen       int
	disconnected   map[int]bool
	pausedRemain   time.Duration
	startedAt      time.Time
	winnerID       string
	resultReason   string
	finishedAt     time.Time
	lastChatAt     [2]time.Time
	lastReactionAt [2]time.Time
	room           *Room
	escrowVerified bool
}

func NewEngine(
	logger *zap.SugaredLogger,
	turnSeconds int,
	graceSeconds int,
	store RoomRepository,
	activeStore ActiveMatchRepository,
) *Engine {
	return &Engine{
		logger:           logger.Named("[game-engine]"),
		store:            store,
		activeStore:      activeStore,
		queues:           make(map[string][]protocol.PlayerInfo),
		queuePending:     make(map[string]bool),
		queueCancelled:   make(map[string]bool),
		matches:          make(map[string]*Match),
		byUser:           make(map[string]*Match),
		terminalMatches:  make(map[string]time.Time),
		roomReservations: make(map[string]struct{}),
		finished:         make(map[string]protocol.MatchOverData),
		settlementJobs:   make(map[string]struct{}),
		restoreJobs:      make(map[string]struct{}),
		abortJobs:        make(map[string]struct{}),
		roomChatLast:     make(map[string]time.Time),
		turnSeconds:      turnSeconds,
		graceSeconds:     graceSeconds,
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
	if !e.restored {
		e.restoreActiveMatches()
		e.restored = true
	}
	e.restoreMu.Unlock()
	e.maybeStartSettlementMaintenance()
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

type matchInstallResult uint8

const (
	matchInstalled matchInstallResult = iota
	matchAlreadyInstalled
	matchPlayerConflict
	matchRoomTransition
	matchTerminal
)

func (e *Engine) installMatch(m *Match) bool {
	return e.installMatchDetailed(m, false, false) == matchInstalled
}

func (e *Engine) installRestoredMatch(m *Match) matchInstallResult {
	return e.installMatchDetailed(m, true, false)
}

func (e *Engine) installReservedRoomMatch(m *Match) bool {
	return e.installMatchDetailed(m, false, true) == matchInstalled
}

func (e *Engine) installMatchDetailed(m *Match, restored, allowRoomReservation bool) matchInstallResult {
	e.mu.Lock()
	defer e.mu.Unlock()
	if restored {
		if expiresAt, terminal := e.terminalMatches[m.ID]; terminal {
			if time.Now().Before(expiresAt) {
				return matchTerminal
			}
			delete(e.terminalMatches, m.ID)
		}
	}
	if _, exists := e.matches[m.ID]; exists {
		return matchAlreadyInstalled
	}
	for _, player := range m.players {
		key := userKey(m.GameID, player.ID)
		if _, reserved := e.roomReservations[key]; reserved && !allowRoomReservation {
			return matchRoomTransition
		}
		if current := e.byUser[key]; current != nil {
			return matchPlayerConflict
		}
	}
	e.matches[m.ID] = m
	for _, player := range m.players {
		e.byUser[userKey(m.GameID, player.ID)] = m
	}
	return matchInstalled
}

func (e *Engine) markMatchTerminal(matchID string) {
	now := time.Now()
	e.mu.Lock()
	for id, expiresAt := range e.terminalMatches {
		if !now.Before(expiresAt) {
			delete(e.terminalMatches, id)
		}
	}
	e.terminalMatches[matchID] = now.Add(activeMatchTTL)
	e.mu.Unlock()
}

func (e *Engine) reserveRoomUsers(gameID string, userIDs ...string) (func(), bool) {
	keys := make([]string, 0, len(userIDs))
	e.mu.Lock()
	for _, userID := range userIDs {
		key := userKey(gameID, userID)
		if e.byUser[key] != nil {
			e.mu.Unlock()
			return nil, false
		}
		if _, reserved := e.roomReservations[key]; reserved {
			e.mu.Unlock()
			return nil, false
		}
		keys = append(keys, key)
	}
	for _, key := range keys {
		e.roomReservations[key] = struct{}{}
	}
	e.mu.Unlock()

	return func() {
		e.mu.Lock()
		for _, key := range keys {
			delete(e.roomReservations, key)
		}
		e.mu.Unlock()
	}, true
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
	}

	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	// A room may have started while this connection waited for roomMu.
	if e.reconnectActiveMatch(gameID, userID) {
		return
	}
	if data, ok := e.takeFinished(key); ok {
		e.toUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
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
					Data: opponentDisconnectedData(m),
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
			e.sendError(gameID, player.ID, protocol.ErrorCodeInRoom, "leave the current room before joining queue")
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
		e.sendError(gameID, player.ID, protocol.ErrorCodeUnknownGame, err.Error())
		return
	}

	e.queueMu.Lock()
	playerKey := userKey(gameID, player.ID)
	if e.queuePending[playerKey] {
		e.queueMu.Unlock()
		e.toUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
		return
	}
	queue := e.queues[gameID]
	for _, waiting := range queue {
		if waiting.ID == player.ID {
			e.queueMu.Unlock()
			e.toUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
			return
		}
	}

	if len(queue) == 0 {
		e.queues[gameID] = append(queue, player)
		e.queueMu.Unlock()
		e.toUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
		return
	}

	opponent := queue[0]
	e.queues[gameID] = queue[1:]
	if e.hasActiveMatch(gameID, opponent.ID) {
		e.queues[gameID] = append(e.queues[gameID], player)
		e.queueMu.Unlock()
		e.toUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
		return
	}
	opponentKey := userKey(gameID, opponent.ID)
	e.queuePending[opponentKey] = true
	e.queuePending[playerKey] = true
	e.queueMu.Unlock()

	releasePlayers, reserveErr := e.reserveQueuedMatch(gameID, opponent, player)
	if reserveErr != nil {
		err = reserveErr
	} else {
		err = e.startReservedQueueMatch(
			gameID,
			gameLogic,
			opponent,
			player,
			opponentKey,
			playerKey,
		)
		releasePlayers()
	}

	e.queueMu.Lock()
	delete(e.queuePending, opponentKey)
	delete(e.queuePending, playerKey)
	opponentCancelled := e.queueCancelled[opponentKey]
	playerCancelled := e.queueCancelled[playerKey]
	delete(e.queueCancelled, opponentKey)
	delete(e.queueCancelled, playerKey)
	if err != nil {
		if !opponentCancelled && !queueHasPlayer(e.queues[gameID], opponent.ID) {
			e.queues[gameID] = append([]protocol.PlayerInfo{opponent}, e.queues[gameID]...)
		}
		if !playerCancelled && !queueHasPlayer(e.queues[gameID], player.ID) {
			e.queues[gameID] = append(e.queues[gameID], player)
		}
	}
	e.queueMu.Unlock()
	if err != nil {
		e.sendError(gameID, opponent.ID, protocol.ErrorCodeMatchStartFailed, err.Error())
		e.sendError(gameID, player.ID, protocol.ErrorCodeMatchStartFailed, err.Error())
	}
}

func (e *Engine) reserveQueuedMatch(gameID string, players ...protocol.PlayerInfo) (func(), error) {
	e.roomMu.Lock()
	defer e.roomMu.Unlock()

	e.queueMu.Lock()
	for _, player := range players {
		if e.queueCancelled[userKey(gameID, player.ID)] {
			e.queueMu.Unlock()
			return nil, fmt.Errorf("queue entry was cancelled")
		}
	}
	e.queueMu.Unlock()

	for _, player := range players {
		if ref, exists := e.store.RoomByUser(gameID, player.ID); exists {
			if room, ok := e.store.Get(gameID, ref.RoomID); ok && room.hasMember(player.ID) {
				e.queueMu.Lock()
				e.queueCancelled[userKey(gameID, player.ID)] = true
				e.queueMu.Unlock()
				return nil, fmt.Errorf("player entered a room before matchmaking completed")
			}
			_ = e.store.DeleteUserRef(gameID, player.ID, ref.RoomID)
		}
	}
	release, reserved := e.reserveRoomUsers(gameID, playerIDs(players)...)
	if !reserved {
		return nil, fmt.Errorf("player state changed before matchmaking completed")
	}
	return release, nil
}

func playerIDs(players []protocol.PlayerInfo) []string {
	ids := make([]string, 0, len(players))
	for _, player := range players {
		ids = append(ids, player.ID)
	}
	return ids
}

func queueHasPlayer(queue []protocol.PlayerInfo, userID string) bool {
	for _, player := range queue {
		if player.ID == userID {
			return true
		}
	}
	return false
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
	key := userKey(gameID, userID)
	if e.queuePending[key] {
		e.queueCancelled[key] = true
	}
}

func (e *Engine) CreateRoom(gameID string, owner protocol.PlayerInfo, bet int, password string) {
	if e.sendActiveMatch(gameID, owner.ID) {
		return
	}
	if _, err := logic.Get(gameID); err != nil {
		e.sendError(gameID, owner.ID, protocol.ErrorCodeUnknownGame, err.Error())
		return
	}
	if bet < 0 || bet > MaxBet {
		e.sendError(gameID, owner.ID, protocol.ErrorCodeInvalidBet, "bet is outside the allowed range")
		return
	}
	if len(password) > 64 {
		e.sendError(gameID, owner.ID, protocol.ErrorCodeInvalidPassword, "room password is too long")
		return
	}
	if !e.ensureCanBet(gameID, owner.ID, bet) {
		return
	}

	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	if e.sendActiveMatch(gameID, owner.ID) {
		return
	}
	releaseOwner, reserved := e.reserveRoomUsers(gameID, owner.ID)
	if !reserved {
		if !e.sendActiveMatch(gameID, owner.ID) {
			e.sendError(gameID, owner.ID, protocol.ErrorCodeRoomBusy, "player state is being updated")
		}
		return
	}
	defer releaseOwner()

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
		ID:           uuid.NewString(),
		GameID:       gameID,
		OwnerID:      owner.ID,
		OwnerName:    owner.Name,
		OwnerVipType: owner.VipType,
		Bet:          bet,
		Password:     password,
		CreatedAt:    time.Now().UnixMilli(),
	}
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, owner.ID, protocol.ErrorCodeRoomCreateFailed, err.Error())
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
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomNotFound, "room id is required")
		return
	}
	if ref, exists := e.store.RoomByUser(gameID, joiner.ID); exists {
		if room, ok := e.store.Get(gameID, ref.RoomID); ok && room.hasMember(joiner.ID) {
			if room.ID == roomID {
				e.emitRoomWaiting(gameID, joiner.ID, room)
				e.emitRoomStateTo(room, joiner.ID)
				return
			}
			e.sendError(gameID, joiner.ID, protocol.ErrorCodeAlreadyInRoom, "leave the current room before joining another")
			return
		}
		_ = e.store.DeleteUserRef(gameID, joiner.ID, ref.RoomID)
	}

	release, claimed := e.store.Claim(gameID, roomID)
	if !claimed {
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomBusy, "room is being updated")
		return
	}
	defer release()

	room, ok := e.store.Get(gameID, roomID)
	if !ok {
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomNotFound, "room not found")
		return
	}
	if room.OwnerID == joiner.ID {
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeOwnRoom, "cannot join your own room")
		return
	}
	if room.Password != "" && room.Password != password {
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeWrongPassword, "wrong password")
		return
	}
	// The room claim keeps this room stable while the potentially remote
	// balance lookup runs, so unrelated room workflows need not wait.
	e.roomMu.Unlock()
	canBet := e.ensureCanBet(gameID, joiner.ID, room.Bet)
	e.roomMu.Lock()
	if !canBet {
		return
	}
	releaseUser, reserved := e.reserveRoomUsers(gameID, joiner.ID)
	if !reserved {
		if !e.sendActiveMatch(gameID, joiner.ID) {
			e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomBusy, "player state is being updated")
		}
		return
	}
	defer releaseUser()

	// The caller could have entered another room while the balance lookup was
	// in flight. Never overwrite that newer membership.
	if ref, exists := e.store.RoomByUser(gameID, joiner.ID); exists {
		if joined, ok := e.store.Get(gameID, ref.RoomID); ok && joined.hasMember(joiner.ID) {
			e.sendError(gameID, joiner.ID, protocol.ErrorCodeAlreadyInRoom, "leave the current room before joining another")
			return
		}
		_ = e.store.DeleteUserRef(gameID, joiner.ID, ref.RoomID)
	}
	freshRoom, exists := e.store.Get(gameID, room.ID)
	if !exists {
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomNotFound, "room not found")
		return
	}
	room = freshRoom
	if room.GuestID != "" && room.GuestID != joiner.ID {
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomFull, "room is full")
		return
	}
	if e.hasActiveMatch(gameID, room.OwnerID) {
		if err := e.store.Delete(gameID, room.ID, room.OwnerID, room.GuestID); err != nil {
			e.logger.Errorw("Failed to delete room whose owner is busy", "room_id", room.ID, "error", err)
			e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomUpdateFailed, "failed to close unavailable room")
			return
		}
		e.emitRoomRemoved(room.GameID, room.ID)
		e.emitRoomClosed(room, "owner_busy")
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomNotFound, "room owner busy")
		return
	}

	room.GuestID = joiner.ID
	room.GuestName = joiner.Name
	room.GuestVipType = joiner.VipType
	room.GuestReady = false
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomJoinFailed, err.Error())
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
		e.sendError(gameID, userID, protocol.ErrorCodeRoomMismatch, "room does not match current membership")
		return
	}

	release, claimed := e.store.Claim(gameID, ref.RoomID)
	if !claimed {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomBusy, "room is being updated")
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
			e.sendError(gameID, userID, protocol.ErrorCodeRoomLeaveFailed, err.Error())
			return
		}
		e.clearRoomChatRate(room.GameID, room.OwnerID, room.GuestID)
		reason := "owner_left"
		if disconnected {
			reason = "owner_disconnected"
		}
		e.emitRoomRemoved(room.GameID, room.ID)
		e.emitRoomClosed(room, reason)
		return
	}

	guestID := clearRoomGuest(&room)
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomLeaveFailed, err.Error())
		return
	}
	e.clearRoomChatRate(room.GameID, room.OwnerID, guestID)
	_ = e.store.DeleteUserRef(gameID, guestID, room.ID)
	e.emitRoomUpsert(room)
	e.emitRoomStateTo(room, room.OwnerID)
	if !disconnected {
		e.toUser(gameID, guestID, protocol.OutEnvelope{
			Type: protocol.S2CRoomClosed,
			Data: protocol.RoomClosedData{RoomID: room.ID, Reason: "guest_left"},
		})
	}
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
		// Owner readiness is implicit and is not stored as mutable room state.
		return
	}
	room.GuestReady = ready
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomUpdateFailed, err.Error())
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
		e.sendError(gameID, ownerID, protocol.ErrorCodeNotRoomOwner, "only the room owner can kick members")
		return
	}
	if room.GuestID == "" || (targetID != "" && targetID != room.GuestID) {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomMemberNotFound, "room member not found")
		return
	}

	kickedID := clearRoomGuest(&room)
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomUpdateFailed, err.Error())
		return
	}
	e.clearRoomChatRate(room.GameID, room.OwnerID, kickedID)
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
		e.sendError(gameID, ownerID, protocol.ErrorCodeNotRoomOwner, "only the room owner can start the match")
		return
	}
	if room.GuestID == "" {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomNotFull, "another player is required")
		return
	}
	if !room.GuestReady {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomNotReady, "the guest must be ready")
		return
	}
	gameLogic, err := logic.Get(gameID)
	if err != nil {
		e.sendError(gameID, ownerID, protocol.ErrorCodeUnknownGame, err.Error())
		return
	}
	releasePlayers, reserved := e.reserveRoomUsers(gameID, room.OwnerID, room.GuestID)
	if !reserved {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomBusy, "a room member state is being updated")
		return
	}
	defer releasePlayers()
	if err := e.store.Delete(gameID, room.ID, room.OwnerID, room.GuestID); err != nil {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomStartFailed, err.Error())
		return
	}
	// The per-room claim remains held while escrow is recorded. Releasing the
	// global room mutex lets unrelated rooms continue during that bounded I/O.
	e.roomMu.Unlock()
	startErr := e.startRoomMatch(
		gameID,
		gameLogic,
		protocol.PlayerInfo{ID: room.OwnerID, Name: room.OwnerName, VipType: room.OwnerVipType},
		protocol.PlayerInfo{ID: room.GuestID, Name: room.GuestName, VipType: room.GuestVipType},
		room.Bet,
		room,
	)
	e.roomMu.Lock()
	if startErr != nil {
		if !e.restoreRoomAfterFailedStart(room) {
			e.emitRoomRemoved(room.GameID, room.ID)
		} else {
			e.emitRoomUpsert(room)
		}
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomStartFailed, startErr.Error())
		e.sendError(gameID, room.GuestID, protocol.ErrorCodeRoomStartFailed, startErr.Error())
		return
	}
	e.emitRoomRemoved(room.GameID, room.ID)
}

func (e *Engine) restoreRoomAfterFailedStart(room Room) bool {
	for _, userID := range []string{room.OwnerID, room.GuestID} {
		if e.hasActiveMatch(room.GameID, userID) {
			return false
		}
		if ref, exists := e.store.RoomByUser(room.GameID, userID); exists {
			if current, ok := e.store.Get(room.GameID, ref.RoomID); ok && current.hasMember(userID) {
				return false
			}
			_ = e.store.DeleteUserRef(room.GameID, userID, ref.RoomID)
		}
	}

	e.queueMu.Lock()
	defer e.queueMu.Unlock()
	for _, userID := range []string{room.OwnerID, room.GuestID} {
		key := userKey(room.GameID, userID)
		if e.queuePending[key] || queueHasPlayer(e.queues[room.GameID], userID) {
			return false
		}
	}
	if err := e.store.Save(room); err != nil {
		e.logger.Errorw("Failed to restore room after match start failure", "room_id", room.ID, "error", err)
		return false
	}
	return true
}

func (e *Engine) ListRooms(gameID, userID string) {
	rooms, err := e.store.List(gameID)
	if err != nil {
		e.logger.Errorw("Failed to list rooms", "game_id", gameID, "error", err)
		e.sendError(gameID, userID, protocol.ErrorCodeRoomListFailed, "failed to load rooms")
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
		ID:           room.ID,
		Owner:        room.OwnerName,
		OwnerVipType: room.OwnerVipType,
		Bet:          room.Bet,
		Locked:       room.Password != "",
		Players:      players,
		Full:         players == 2,
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
		ID: room.OwnerID, Name: room.OwnerName, VipType: room.OwnerVipType, Owner: true, Ready: true,
	}}
	if room.GuestID != "" {
		members = append(members, protocol.RoomMember{
			ID: room.GuestID, Name: room.GuestName, VipType: room.GuestVipType, Ready: room.GuestReady,
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
		e.sendError(gameID, userID, protocol.ErrorCodeRoomNotFound, "room id is required")
		return Room{}, nil, false
	}
	ref, ok := e.store.RoomByUser(gameID, userID)
	if !ok || ref.RoomID != roomID {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomNotFound, "room not found")
		return Room{}, nil, false
	}
	release, claimed := e.store.Claim(gameID, roomID)
	if !claimed {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomBusy, "room is being updated")
		return Room{}, nil, false
	}
	room, exists := e.store.Get(gameID, roomID)
	if !exists || !room.hasMember(userID) {
		release()
		_ = e.store.DeleteUserRef(gameID, userID, ref.RoomID)
		e.sendError(gameID, userID, protocol.ErrorCodeRoomNotFound, "room not found")
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
			Data: opponentDisconnectedData(m),
		})
	}
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist disconnected match", "match_id", m.ID, "error", err)
	}
	return true
}

func opponentDisconnectedData(m *Match) protocol.OpponentDisconnectedData {
	turnRemainingMs := int64(0)
	if m.pausedRemain > 0 {
		turnRemainingMs = m.pausedRemain.Milliseconds()
	}
	return protocol.OpponentDisconnectedData{
		GraceDeadline:   m.graceDeadline.UnixMilli(),
		TurnRemainingMs: turnRemainingMs,
	}
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
		e.sendError(gameID, userID, protocol.ErrorCodeNoMatch, "no active match")
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		e.sendError(gameID, userID, protocol.ErrorCodeNoMatch, "no active match")
		return
	}
	if matchID != "" && matchID != m.ID {
		return
	}

	playerIdx := m.playerIndex(userID)
	if playerIdx != m.turnIdx {
		e.sendError(gameID, userID, protocol.ErrorCodeNotYourTurn, "not your turn")
		return
	}
	if time.Now().After(m.deadline) {
		return
	}

	if err := m.logic.ValidateMove(m.state, playerIdx, move); err != nil {
		e.sendError(gameID, userID, protocol.ErrorCodeInvalidMove, err.Error())
		return
	}

	state, err := m.logic.Apply(m.state, playerIdx, move)
	if err != nil {
		e.sendError(gameID, userID, protocol.ErrorCodeInvalidMove, err.Error())
		return
	}
	previousState := m.state
	previousTurn := m.turnIdx
	previousDeadline := m.deadline
	previousPausedRemain := m.pausedRemain
	previousTimeoutRuns := m.timeoutRuns
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

	if keeper, ok := m.logic.(logic.TurnKeeper); !ok || !keeper.KeepTurn(m.state) {
		m.turnIdx = 1 - m.turnIdx
	}
	m.timeoutRuns[playerIdx] = 0
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
		m.timeoutRuns = previousTimeoutRuns
		if m.pausedRemain == 0 {
			e.scheduleTurnTimer(m)
		}
		e.logger.Errorw("Failed to persist match move", "match_id", m.ID, "user_id", userID, "error", err)
		e.sendError(gameID, userID, protocol.ErrorCodeStateSaveFailed, "failed to save the move, please retry")
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
		e.sendError(gameID, userID, protocol.ErrorCodeNoMatch, "no active match")
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		e.sendError(gameID, userID, protocol.ErrorCodeNoMatch, "no active match")
		return
	}
	if matchID == "" || matchID != m.ID {
		e.sendError(gameID, userID, protocol.ErrorCodeMatchMismatch, "chat does not belong to the active match")
		return
	}
	text, code, message := validateChatText(text)
	if code != "" {
		e.sendError(gameID, userID, code, message)
		return
	}

	senderIdx := m.playerIndex(userID)
	now := time.Now()
	if last := m.lastChatAt[senderIdx]; !last.IsZero() && now.Sub(last) < chatCooldown {
		e.sendError(gameID, userID, protocol.ErrorCodeChatRateLimited, "chat messages are being sent too quickly")
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

func (e *Engine) RoomChat(gameID, userID, roomID, text string) {
	e.roomMu.Lock()
	defer e.roomMu.Unlock()

	if roomID == "" {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomNotFound, "room id is required")
		return
	}
	room, exists := e.store.Get(gameID, roomID)
	if !exists {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomNotFound, "room not found")
		return
	}
	if !room.hasMember(userID) {
		e.sendError(gameID, userID, protocol.ErrorCodeNotRoomMember, "only room members can chat")
		return
	}
	if room.GuestID == "" {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomNotFull, "another player is required to chat")
		return
	}
	text, code, message := validateChatText(text)
	if code != "" {
		e.sendError(gameID, userID, code, message)
		return
	}

	now := time.Now()
	rateKey := userKey(gameID, userID)
	if last := e.roomChatLast[rateKey]; !last.IsZero() && now.Sub(last) < chatCooldown {
		e.sendError(gameID, userID, protocol.ErrorCodeChatRateLimited, "chat messages are being sent too quickly")
		return
	}
	e.roomChatLast[rateKey] = now

	senderName := room.OwnerName
	if userID == room.GuestID {
		senderName = room.GuestName
	}
	data := protocol.ChatMessageData{
		RoomID: room.ID,
		UserID: userID,
		Name:   senderName,
		Text:   text,
		SentAt: now.UnixMilli(),
	}
	for _, recipientID := range []string{room.OwnerID, room.GuestID} {
		e.toUser(room.GameID, recipientID, protocol.OutEnvelope{
			Type: protocol.S2CChatMessage,
			Data: data,
		})
	}
}

func (e *Engine) MatchReaction(gameID, userID, matchID, reactionType string) {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		e.sendError(gameID, userID, protocol.ErrorCodeNoMatch, "no active match")
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		e.sendError(gameID, userID, protocol.ErrorCodeNoMatch, "no active match")
		return
	}
	if matchID == "" || matchID != m.ID {
		e.sendError(gameID, userID, protocol.ErrorCodeMatchMismatch, "reaction does not belong to the active match")
		return
	}
	if !validReactionType(reactionType) {
		e.sendError(gameID, userID, protocol.ErrorCodeInvalidReaction, "invalid reaction")
		return
	}

	senderIdx := m.playerIndex(userID)
	now := time.Now()
	if last := m.lastReactionAt[senderIdx]; !last.IsZero() && now.Sub(last) < reactionCooldown {
		e.sendError(gameID, userID, protocol.ErrorCodeReactionRateLimited, "reactions are being sent too quickly")
		return
	}
	m.lastReactionAt[senderIdx] = now
	data := protocol.ReactionData{
		MatchID: m.ID,
		UserID:  userID,
		Type:    reactionType,
		SentAt:  now.UnixMilli(),
	}
	for _, player := range m.players {
		e.toUser(m.GameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CReaction, Data: data})
	}
}

func validReactionType(reactionType string) bool {
	switch reactionType {
	case protocol.ReactionTypeLike,
		protocol.ReactionTypeLove,
		protocol.ReactionTypeHaha,
		protocol.ReactionTypeWow,
		protocol.ReactionTypeSad,
		protocol.ReactionTypeAngry:
		return true
	default:
		return false
	}
}

func validateChatText(text string) (string, string, string) {
	text = strings.TrimSpace(text)
	if text == "" {
		return "", protocol.ErrorCodeInvalidChat, "chat message cannot be empty"
	}
	if utf8.RuneCountInString(text) > maxChatRunes {
		return "", protocol.ErrorCodeChatTooLong, "chat message is too long"
	}
	return text, "", ""
}

// clearRoomChatRate must be called while roomMu is held.
func (e *Engine) clearRoomChatRate(gameID string, userIDs ...string) {
	for _, userID := range userIDs {
		if userID != "" {
			delete(e.roomChatLast, userKey(gameID, userID))
		}
	}
}

func (e *Engine) Forfeit(gameID, userID, matchID string) {
	e.forfeit(gameID, userID, matchID, false)
}

func (e *Engine) ForfeitAndLeave(gameID, userID, matchID string) {
	e.forfeit(gameID, userID, matchID, true)
}

func (e *Engine) forfeit(gameID, userID, matchID string, leaveAfter bool) {
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
	if leaveAfter {
		if m.room != nil && m.room.GuestID == userID {
			room := *m.room
			clearRoomGuest(&room)
			m.room = &room
		} else {
			m.room = nil
		}
	}
	winnerIdx := 1 - m.playerIndex(userID)
	e.finishMatch(m, m.players[winnerIdx].ID, "forfeit")
}

func (e *Engine) startMatch(gameID string, gameLogic logic.GameLogic, p0, p1 protocol.PlayerInfo, bet int) error {
	return e.startMatchWithRoom(gameID, gameLogic, p0, p1, bet, nil, false, nil)
}

func (e *Engine) startReservedQueueMatch(
	gameID string,
	gameLogic logic.GameLogic,
	p0, p1 protocol.PlayerInfo,
	queueKeys ...string,
) error {
	return e.startMatchWithRoom(gameID, gameLogic, p0, p1, 0, nil, true, queueKeys)
}

func (e *Engine) startRoomMatch(gameID string, gameLogic logic.GameLogic, p0, p1 protocol.PlayerInfo, bet int, room Room) error {
	return e.startMatchWithRoom(gameID, gameLogic, p0, p1, bet, &room, true, nil)
}

func (e *Engine) startMatchWithRoom(
	gameID string,
	gameLogic logic.GameLogic,
	p0, p1 protocol.PlayerInfo,
	bet int,
	room *Room,
	allowRoomReservation bool,
	queueKeys []string,
) error {
	if bet < 0 || bet > MaxBet {
		return fmt.Errorf("bet is outside the allowed range")
	}
	settlement := e.currentSettlement()
	if bet > 0 && settlement == nil {
		return fmt.Errorf("betting is temporarily unavailable")
	}
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
		room:         room,
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	var installed bool
	queueCancelled := false
	if len(queueKeys) > 0 {
		e.queueMu.Lock()
		for _, key := range queueKeys {
			if e.queueCancelled[key] {
				queueCancelled = true
				break
			}
		}
		if !queueCancelled {
			installed = e.installReservedRoomMatch(m)
		}
		e.queueMu.Unlock()
	} else if allowRoomReservation {
		installed = e.installReservedRoomMatch(m)
	} else {
		installed = e.installMatch(m)
	}
	if queueCancelled {
		return fmt.Errorf("queue entry was cancelled")
	}
	if !installed {
		return fmt.Errorf("one or more players already have an active match")
	}
	var startBalances []SettledBalance
	if settlement != nil {
		mode := "queue"
		if room != nil {
			mode = "room"
		}
		record := MatchRecord{
			GameID:    gameID,
			MatchID:   m.ID,
			Player0ID: m.players[0].ID,
			Player1ID: m.players[1].ID,
			Bet:       bet,
			Mode:      mode,
			StartedAt: m.startedAt,
		}
		ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
		balances, err := settlement.EscrowStart(ctx, record)
		cancel()
		if err != nil {
			m.over = true
			e.removeMatch(m)
			abortCtx, abortCancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
			abortBalances, abortErr := settlement.AbortStart(abortCtx, m.ID)
			abortCancel()
			if abortErr != nil {
				e.logger.Errorw("Failed to abort match after start record error", "match_id", m.ID, "error", abortErr)
				e.preserveAbortRecovery(m)
			} else {
				e.emitSettledBalances(abortBalances, gameID)
			}
			return fmt.Errorf("record match start: %w", err)
		}
		startBalances = balances
		m.escrowVerified = true
	}

	// The first turn begins only after the start record/escrow is durable.
	m.deadline = time.Now().Add(time.Duration(e.turnSeconds) * time.Second)
	if err := e.persistMatch(m); err != nil {
		m.over = true
		e.removeMatch(m)
		persistErr := fmt.Errorf("persist active match: %w", err)
		abortSucceeded := settlement == nil
		if settlement != nil {
			ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
			balances, abortErr := settlement.AbortStart(ctx, m.ID)
			cancel()
			if abortErr != nil {
				e.logger.Errorw("Failed to abort escrow after active match persistence failure", "match_id", m.ID, "error", abortErr)
				persistErr = fmt.Errorf("%w; abort match start: %v", persistErr, abortErr)
				e.preserveAbortRecovery(m)
			} else {
				e.emitSettledBalances(balances, gameID)
				abortSucceeded = true
			}
		}
		if abortSucceeded {
			if delErr := e.activeStore.Delete(gameID, m.ID, m.players[0].ID, m.players[1].ID); delErr != nil {
				e.logger.Errorw("Failed to clean up match after persistence failure", "match_id", m.ID, "error", delErr)
			}
		}
		return persistErr
	}
	e.clearFinished(userKey(gameID, p0.ID), userKey(gameID, p1.ID))
	e.scheduleTurnTimer(m)
	e.sendMatchFound(m, false)
	e.emitSettledBalances(startBalances, gameID)
	e.logger.Infow("Match started", "match_id", m.ID, "game_id", gameID, "p0", p0.ID, "p1", p1.ID)
	return nil
}

func (e *Engine) preserveAbortRecovery(m *Match) {
	snapshot, err := e.snapshotForMatch(m)
	if err != nil {
		e.logger.Errorw("Failed to prepare abort recovery snapshot", "match_id", m.ID, "error", err)
		snapshot = ActiveMatchSnapshot{
			ID:      m.ID,
			GameID:  m.GameID,
			Players: append([]protocol.PlayerInfo(nil), m.players...),
			Status:  matchStatusFinished,
		}
	}
	snapshot.Status = matchStatusAborting
	if err := e.activeStore.Save(snapshot); err != nil {
		e.logger.Errorw("Failed to persist abort recovery snapshot", "match_id", m.ID, "error", err)
	}
	e.queueAbortSettlement(snapshot)
}

func (e *Engine) sendMatchFound(m *Match, resumed bool) {
	for _, p := range m.players {
		e.sendMatchFoundTo(m, p.ID, resumed)
	}
}

func (e *Engine) sendMatchFoundTo(m *Match, userID string, resumed bool) {
	roomOwnerID := ""
	if m.room != nil {
		roomOwnerID = m.room.OwnerID
	}
	e.toUser(m.GameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CMatchFound,
		Data: protocol.MatchFoundData{
			MatchID:     m.ID,
			GameID:      m.GameID,
			Players:     m.players,
			You:         m.playerIndex(userID),
			State:       m.state,
			Turn:        m.turnIdx,
			Deadline:    m.deadline.UnixMilli(),
			Resumed:     resumed,
			Bet:         m.bet,
			RoomOwnerID: roomOwnerID,
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
	if skipper, ok := m.logic.(logic.TimeoutSkipper); !ok || !skipper.TimeoutSkipsTurn() {
		winnerIdx := 1 - m.turnIdx
		e.finishMatch(m, m.players[winnerIdx].ID, "timeout")
		return
	}
	m.timeoutRuns[m.turnIdx]++
	if m.timeoutRuns[m.turnIdx] >= 3 {
		winnerIdx := 1 - m.turnIdx
		e.finishMatch(m, m.players[winnerIdx].ID, "timeout")
		return
	}
	timedOut := m.turnIdx
	if handler, ok := m.logic.(logic.TurnSkipHandler); ok {
		handler.OnTurnSkipped(m.state, timedOut)
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
		e.logger.Errorw("Failed to persist skipped turn after timeout", "match_id", m.ID, "error", err)
	}
	if m.pausedRemain == 0 {
		e.scheduleTurnTimer(m)
	}
	data := protocol.StateData{
		MatchID:  m.ID,
		State:    m.state,
		Turn:     m.turnIdx,
		Deadline: m.deadline.UnixMilli(),
		LastBy:   timedOut,
	}
	for _, p := range m.players {
		e.toUser(m.GameID, p.ID, protocol.OutEnvelope{Type: protocol.S2CState, Data: data})
	}
}

func (e *Engine) winnerAmounts(gameID string, bet int) (payout, net int) {
	if bet <= 0 {
		return 0, 0
	}
	if settlement := e.currentSettlement(); settlement != nil {
		return settlement.WinnerAmounts(gameID, bet)
	}
	return bet * 2, bet
}

func (e *Engine) finishMatch(m *Match, winnerID string, reason string) {
	if len(m.disconnected) > 0 {
		if m.room == nil || m.disconnected[m.playerIndex(m.room.OwnerID)] {
			m.room = nil
		} else if m.disconnected[m.playerIndex(m.room.GuestID)] {
			room := *m.room
			clearRoomGuest(&room)
			m.room = &room
		}
	}
	m.over = true
	m.winnerID = winnerID
	m.resultReason = reason
	m.finishedAt = time.Now()
	// Block maintenance from reinstalling an older playing snapshot while this
	// terminal state is being persisted and removed from the live registry.
	e.markMatchTerminal(m.ID)
	if m.timer != nil {
		m.timer.Stop()
	}
	if m.graceTimer != nil {
		m.graceTimer.Stop()
	}
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist final match snapshot", "match_id", m.ID, "error", err)
	}
	outcome := MatchOutcome{
		GameID:     m.GameID,
		MatchID:    m.ID,
		Player0ID:  m.players[0].ID,
		Player1ID:  m.players[1].ID,
		WinnerID:   winnerID,
		Reason:     reason,
		Bet:        m.bet,
		MoveCount:  matchMoveCount(m),
		FinishedAt: m.finishedAt,
	}
	snapshot, snapshotErr := e.snapshotForMatch(m)
	if snapshotErr != nil {
		e.logger.Errorw("Failed to prepare final match snapshot for settlement retry", "match_id", m.ID, "error", snapshotErr)
		snapshot = ActiveMatchSnapshot{
			ID:      m.ID,
			GameID:  m.GameID,
			Players: append([]protocol.PlayerInfo(nil), m.players...),
		}
	}
	var waitingRoom *Room
	if m.room != nil {
		room := prepareNextRound(*m.room)
		if err := e.store.Save(room); err != nil {
			e.logger.Errorw("Failed to restore waiting room after match", "match_id", m.ID, "room_id", room.ID, "error", err)
		} else {
			waitingRoom = &room
		}
	}
	payout, kenDelta := 0, 0
	if winnerID != "" {
		payout, kenDelta = e.winnerAmounts(m.GameID, m.bet)
	}
	data := protocol.MatchOverData{
		MatchID:  m.ID,
		WinnerID: winnerID,
		Reason:   reason,
		State:    m.state,
		Bet:      m.bet,
		Payout:   payout,
		KenDelta: kenDelta,
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
	if e.currentSettlement() != nil || m.bet > 0 {
		e.queueFinishedSettlement(snapshot, outcome)
	} else if _, err := e.activeStore.DeleteIfStatus(
		m.GameID,
		m.ID,
		matchStatusFinished,
		m.players[0].ID,
		m.players[1].ID,
	); err != nil {
		e.logger.Errorw("Failed to delete finished active match", "match_id", m.ID, "error", err)
	}
	if waitingRoom != nil {
		e.emitRoomUpsert(*waitingRoom)
		e.emitRoomWaiting(waitingRoom.GameID, waitingRoom.OwnerID, *waitingRoom)
		if waitingRoom.GuestID != "" {
			e.emitRoomWaiting(waitingRoom.GameID, waitingRoom.GuestID, *waitingRoom)
		}
		e.emitRoomState(*waitingRoom)
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
	snapshot, err := e.snapshotForMatch(m)
	if err != nil {
		return err
	}
	return e.activeStore.Save(snapshot)
}

func (e *Engine) snapshotForMatch(m *Match) (ActiveMatchSnapshot, error) {
	state, err := json.Marshal(m.state)
	if err != nil {
		return ActiveMatchSnapshot{}, fmt.Errorf("marshal match state: %w", err)
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
		TimeoutRuns:        m.timeoutRuns,
		TurnDeadline:       m.deadline.UnixMilli(),
		Bet:                m.bet,
		StartedAt:          m.startedAt.UnixMilli(),
		Status:             status,
		WinnerID:           m.winnerID,
		ResultReason:       m.resultReason,
		Disconnected:       m.disconnected,
		PausedRemainMillis: m.pausedRemain.Milliseconds(),
		Room:               m.room,
	}
	if !m.graceDeadline.IsZero() {
		snapshot.GraceDeadline = m.graceDeadline.UnixMilli()
	}
	if !m.finishedAt.IsZero() {
		snapshot.FinishedAt = m.finishedAt.UnixMilli()
	}
	return snapshot, nil
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
			if snapshot.Status == matchStatusAborting {
				e.queueAbortSettlement(snapshot)
				continue
			}
			didRestore, retry := e.restorePlayingSnapshot(snapshot, gameID)
			if retry {
				e.queuePlayingRestore(snapshot)
			}
			if didRestore {
				restored++
			}
		}
	}
	if restored > 0 {
		e.logger.Infow("Restored active matches from Redis", "count", restored)
	}
}

func (e *Engine) restorePlayingSnapshot(snapshot ActiveMatchSnapshot, expectedGameID string) (bool, bool) {
	if snapshot.Status != matchStatusPlaying {
		e.logger.Warnw("Skipped active match with unknown status", "match_id", snapshot.ID, "status", snapshot.Status)
		return false, false
	}
	if snapshot.ID == "" || snapshot.GameID != expectedGameID || len(snapshot.Players) != 2 ||
		snapshot.TurnIndex < 0 || snapshot.TurnIndex > 1 {
		e.logger.Warnw("Skipped invalid active match snapshot", "game_id", expectedGameID, "match_id", snapshot.ID)
		return false, false
	}
	if e.matchByID(snapshot.ID) != nil {
		return false, false
	}
	current, exists, err := e.activeStore.Get(expectedGameID, snapshot.ID)
	if err != nil {
		e.logger.Errorw("Failed to revalidate active match before restore", "game_id", expectedGameID, "match_id", snapshot.ID, "error", err)
		return false, true
	}
	if !exists {
		return false, false
	}
	if current.Status == matchStatusFinished {
		e.handleFinishedRestore(current)
		return false, false
	}
	if current.Status != matchStatusPlaying {
		e.logger.Warnw("Skipped active match with unknown current status", "match_id", current.ID, "status", current.Status)
		return false, false
	}
	if current.ID != snapshot.ID || current.GameID != expectedGameID || len(current.Players) != 2 ||
		current.TurnIndex < 0 || current.TurnIndex > 1 {
		e.logger.Warnw("Skipped invalid current active match snapshot", "game_id", expectedGameID, "match_id", current.ID)
		return false, false
	}
	snapshot = current
	settlement := e.currentSettlement()
	if snapshot.Bet > 0 && settlement == nil {
		// A paid match must never become playable before its escrow can be
		// verified. SetSettlement triggers reconciliation once it is available.
		return false, false
	}
	gameLogic, err := logic.Get(snapshot.GameID)
	if err != nil {
		e.logger.Errorw("Skipped active match with unknown game", "match_id", snapshot.ID, "error", err)
		e.abortUnrecoverableRestore(snapshot, settlement)
		return false, false
	}
	if snapshot.StateVersion != gameLogic.StateVersion() {
		e.logger.Errorw("Skipped active match with unsupported state version",
			"match_id", snapshot.ID,
			"saved_version", snapshot.StateVersion,
			"current_version", gameLogic.StateVersion(),
		)
		e.abortUnrecoverableRestore(snapshot, settlement)
		return false, false
	}
	state, err := gameLogic.DecodeState(snapshot.State)
	if err != nil {
		e.logger.Errorw("Failed to decode active match state", "match_id", snapshot.ID, "error", err)
		e.abortUnrecoverableRestore(snapshot, settlement)
		return false, false
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
		timeoutRuns:  snapshot.TimeoutRuns,
		deadline:     deadline,
		bet:          snapshot.Bet,
		disconnected: map[int]bool{0: true, 1: true},
		pausedRemain: pausedRemain,
		startedAt:    startedAt,
		graceGen:     1,
		room:         cloneRoom(snapshot.Room),
	}
	m.graceDeadline = time.Now().Add(time.Duration(e.graceSeconds) * time.Second)

	// Install a locked provisional match before touching escrow. That makes
	// room, queue, and concurrent restore transitions observe one owner for
	// these users while the database call is in flight.
	e.roomMu.Lock()
	roomConflict := e.snapshotHasRoomMemberLocked(snapshot)
	m.mu.Lock()
	installResult := matchPlayerConflict
	if !roomConflict {
		installResult = e.installRestoredMatch(m)
	}
	e.roomMu.Unlock()
	switch installResult {
	case matchAlreadyInstalled, matchTerminal:
		m.mu.Unlock()
		return false, false
	case matchRoomTransition:
		m.mu.Unlock()
		return false, true
	case matchPlayerConflict:
		m.mu.Unlock()
		e.logger.Warnw("Skipped active match because its id or a player is already restored", "match_id", snapshot.ID)
		return false, e.abortConflictingRestore(snapshot, settlement)
	}

	if settlement != nil {
		record, ok := recordFromSnapshot(snapshot)
		if !ok {
			m.over = true
			e.removeMatch(m)
			m.mu.Unlock()
			e.abortUnrecoverableRestore(snapshot, settlement)
			return false, false
		}
		ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
		balances, escrowErr := settlement.EscrowStart(ctx, record)
		cancel()
		if escrowErr != nil {
			m.over = true
			e.removeMatch(m)
			m.mu.Unlock()
			e.logger.Errorw("Skipped restored match because its escrow could not be verified", "match_id", snapshot.ID, "error", escrowErr)
			if errors.Is(escrowErr, ErrEscrowClosed) {
				return false, !e.discardRestoredSnapshot(snapshot, nil)
			}
			if errors.Is(escrowErr, ErrSettlementConflict) {
				return false, false
			}
			return false, true
		}
		e.emitSettledBalances(balances, snapshot.GameID)
		m.escrowVerified = true
	}

	e.restoreTimersLocked(m)
	m.mu.Unlock()
	return true, false
}

func (e *Engine) snapshotHasRoomMemberLocked(snapshot ActiveMatchSnapshot) bool {
	for _, player := range snapshot.Players {
		ref, exists := e.store.RoomByUser(snapshot.GameID, player.ID)
		if !exists {
			continue
		}
		if room, ok := e.store.Get(snapshot.GameID, ref.RoomID); ok && room.hasMember(player.ID) {
			return true
		}
		_ = e.store.DeleteUserRef(snapshot.GameID, player.ID, ref.RoomID)
	}
	return false
}

func (e *Engine) abortConflictingRestore(snapshot ActiveMatchSnapshot, settlement Settlement) bool {
	if settlement == nil {
		// Keep zero-bet recovery state until settlement is available rather
		// than deleting a possible durable match record blindly.
		return false
	}
	ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
	balances, abortErr := settlement.AbortStart(ctx, snapshot.ID)
	cancel()
	if abortErr != nil {
		e.logger.Errorw("Failed to abort conflicting restored match", "match_id", snapshot.ID, "error", abortErr)
		return !errors.Is(abortErr, ErrSettlementConflict)
	}
	e.emitSettledBalances(balances, snapshot.GameID)
	if !e.restoreSnapshotRoom(snapshot) {
		return true
	}
	return !e.deleteSnapshot(snapshot)
}

func (e *Engine) abortUnrecoverableRestore(snapshot ActiveMatchSnapshot, settlement Settlement) {
	if settlement == nil {
		return
	}
	if e.abortConflictingRestore(snapshot, settlement) {
		snapshot.Status = matchStatusAborting
		if err := e.activeStore.Save(snapshot); err != nil {
			e.logger.Errorw("Failed to persist unrecoverable match cleanup", "match_id", snapshot.ID, "error", err)
		}
		e.queueAbortSettlement(snapshot)
	}
}

func (e *Engine) handleFinishedRestore(snapshot ActiveMatchSnapshot) {
	e.markMatchTerminal(snapshot.ID)
	e.restoreFinishedSnapshot(snapshot)
	if outcome, ok := outcomeFromSnapshot(snapshot); ok && e.currentSettlement() != nil {
		e.queueFinishedSettlement(snapshot, outcome)
	}
}

func (e *Engine) discardRestoredSnapshot(snapshot ActiveMatchSnapshot, match *Match) bool {
	current, exists, err := e.activeStore.Get(snapshot.GameID, snapshot.ID)
	if err != nil {
		e.logger.Errorw("Failed to revalidate discarded match snapshot", "match_id", snapshot.ID, "error", err)
		return false
	}
	if exists && current.Status != snapshot.Status {
		// A newer lifecycle state owns both the snapshot and any room rollback.
		return true
	}
	if match != nil {
		match.mu.Lock()
		if match.over {
			match.mu.Unlock()
			// The live match completed while escrow verification was in flight.
			// Its finished snapshot/room now owns cleanup; never apply the
			// older playing snapshot over that terminal state.
			return true
		}
		match.over = true
		e.invalidateTurnTimer(match)
		if match.graceTimer != nil {
			match.graceTimer.Stop()
			match.graceTimer = nil
		}
		match.mu.Unlock()
		e.removeMatch(match)
	}
	if !e.restoreSnapshotRoom(snapshot) {
		return false
	}
	return e.deleteSnapshot(snapshot)
}

func (e *Engine) restoreSnapshotRoom(snapshot ActiveMatchSnapshot) bool {
	if snapshot.Room == nil {
		return true
	}
	room := prepareNextRound(*snapshot.Room)
	memberIDs := []string{room.OwnerID}
	if room.GuestID != "" {
		memberIDs = append(memberIDs, room.GuestID)
	}

	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	release, reserved := e.reserveRoomUsers(room.GameID, memberIDs...)
	if !reserved {
		for _, userID := range memberIDs {
			if e.matchForUser(room.GameID, userID) != nil {
				return true
			}
			if ref, exists := e.store.RoomByUser(room.GameID, userID); exists {
				if current, ok := e.store.Get(room.GameID, ref.RoomID); ok && current.hasMember(userID) {
					return true
				}
			}
		}
		// An in-flight room transition owns a reservation but has not committed
		// canonical state yet. Retain the snapshot and retry after it resolves.
		return false
	}
	defer release()

	for _, userID := range memberIDs {
		if e.hasActiveMatch(room.GameID, userID) {
			return true
		}
		if ref, exists := e.store.RoomByUser(room.GameID, userID); exists {
			if current, ok := e.store.Get(room.GameID, ref.RoomID); ok && current.hasMember(userID) {
				return true
			}
			_ = e.store.DeleteUserRef(room.GameID, userID, ref.RoomID)
		}
	}

	e.queueMu.Lock()
	defer e.queueMu.Unlock()
	for _, userID := range memberIDs {
		key := userKey(room.GameID, userID)
		if e.queuePending[key] || queueHasPlayer(e.queues[room.GameID], userID) {
			return true
		}
	}
	if err := e.store.Save(room); err != nil {
		e.logger.Errorw("Failed to restore waiting room from match snapshot", "match_id", snapshot.ID, "room_id", room.ID, "error", err)
		return false
	}
	return true
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

func (e *Engine) deleteSnapshot(snapshot ActiveMatchSnapshot) bool {
	userIDs := make([]string, 0, len(snapshot.Players))
	for _, player := range snapshot.Players {
		userIDs = append(userIDs, player.ID)
	}
	deleted, err := e.activeStore.DeleteIfStatus(snapshot.GameID, snapshot.ID, snapshot.Status, userIDs...)
	if err != nil {
		e.logger.Errorw("Failed to delete stale match snapshot", "match_id", snapshot.ID, "error", err)
		return false
	} else if !deleted {
		e.logger.Infow("Kept match snapshot because its lifecycle status changed", "match_id", snapshot.ID, "expected_status", snapshot.Status)
	}
	return true
}

func (e *Engine) restoreFinishedSnapshot(snapshot ActiveMatchSnapshot) {
	gameLogic, err := logic.Get(snapshot.GameID)
	if err != nil || snapshot.StateVersion != gameLogic.StateVersion() {
		e.logger.Errorw("Could not restore finished match result because its game state is unsupported", "game_id", snapshot.GameID, "match_id", snapshot.ID)
		return
	}
	state, err := gameLogic.DecodeState(snapshot.State)
	if err != nil {
		e.logger.Errorw("Failed to decode finished match state", "match_id", snapshot.ID, "error", err)
		return
	}
	payout, kenDelta := 0, 0
	if snapshot.WinnerID != "" {
		payout, kenDelta = e.winnerAmounts(snapshot.GameID, snapshot.Bet)
	}
	data := protocol.MatchOverData{
		MatchID:  snapshot.ID,
		WinnerID: snapshot.WinnerID,
		Reason:   snapshot.ResultReason,
		State:    state,
		Bet:      snapshot.Bet,
		Payout:   payout,
		KenDelta: kenDelta,
	}
	if !e.restoreSnapshotRoom(snapshot) {
		e.logger.Errorw("Deferred waiting-room restore from finished match", "match_id", snapshot.ID)
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
}

func prepareNextRound(room Room) Room {
	room.GuestReady = false
	return room
}

func clearRoomGuest(room *Room) string {
	guestID := room.GuestID
	room.GuestID = ""
	room.GuestName = ""
	room.GuestVipType = nil
	room.GuestReady = false
	return guestID
}

func cloneRoom(room *Room) *Room {
	if room == nil {
		return nil
	}
	cloned := *room
	return &cloned
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
