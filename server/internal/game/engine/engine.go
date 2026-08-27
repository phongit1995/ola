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
	ToMatch(gameID string, matchID string, envelope protocol.OutEnvelope)
}

const (
	MaxSpectators     = 20
	finishedResultTTL = 2 * time.Minute
	maxTurnStartDelay = 20 * time.Second
	maxChatRunes      = 120
	chatCooldown      = 500 * time.Millisecond
	reactionCooldown  = 800 * time.Millisecond
	playingRoomGameID = "war-god"
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
	timeoutRuns    []int
	deadline       time.Time
	timer          *time.Timer
	turnGen        int
	over           bool
	bet            int
	graceTimer     *time.Timer
	graceDeadline  time.Time
	graceGen       int
	disconnected   map[int]bool
	disconnectedAt map[int]time.Time
	quit           map[int]bool
	pausedRemain   time.Duration
	startedAt      time.Time
	winnerID       string
	resultReason   string
	finishedAt     time.Time
	lastChatAt     []time.Time
	lastReactionAt []time.Time
	room           *Room
	closedRoom     *Room
	listedRoomID   string
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

func (m *Match) ensureSeats() {
	n := len(m.players)
	for len(m.timeoutRuns) < n {
		m.timeoutRuns = append(m.timeoutRuns, 0)
	}
	for len(m.lastChatAt) < n {
		m.lastChatAt = append(m.lastChatAt, time.Time{})
	}
	for len(m.lastReactionAt) < n {
		m.lastReactionAt = append(m.lastReactionAt, time.Time{})
	}
	if m.disconnected == nil {
		m.disconnected = make(map[int]bool)
	}
	if m.disconnectedAt == nil {
		m.disconnectedAt = make(map[int]time.Time)
	}
	if m.quit == nil {
		m.quit = make(map[int]bool)
	}
}

func (m *Match) activeIdxs() []int {
	idxs := make([]int, 0, len(m.players))
	for i := range m.players {
		if !m.quit[i] {
			idxs = append(idxs, i)
		}
	}
	return idxs
}

func (e *Engine) nextTurnIdx(m *Match) int {
	n := len(m.players)
	next := -1
	if order, ok := m.logic.(logic.TurnOrder); ok {
		next = order.NextTurn(m.state, m.turnIdx)
	}
	if next < 0 || next >= n {
		next = (m.turnIdx + 1) % n
	}
	return next
}

func (e *Engine) viewFor(m *Match, playerIdx int) any {
	if viewer, ok := m.logic.(logic.StateViewer); ok {
		if playerIdx >= 0 && playerIdx < len(m.players) {
			return viewer.ViewFor(m.state, playerIdx)
		}
	}
	return m.state
}

func (e *Engine) broadcastState(m *Match, lastMove json.RawMessage, lastBy int) {
	deadline := m.deadline.UnixMilli()
	for idx, p := range m.players {
		e.toUser(m.GameID, p.ID, protocol.OutEnvelope{Type: protocol.S2CState, Data: protocol.StateData{
			MatchID:  m.ID,
			State:    e.viewFor(m, idx),
			Turn:     m.turnIdx,
			Deadline: deadline,
			LastMove: lastMove,
			LastBy:   lastBy,
		}})
	}
	if spectatable(m.logic) {
		e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{Type: protocol.S2CState, Data: protocol.StateData{
			MatchID:  m.ID,
			State:    m.state,
			Turn:     m.turnIdx,
			Deadline: deadline,
			LastMove: lastMove,
			LastBy:   lastBy,
		}})
	}
}

func spectatable(gameLogic logic.GameLogic) bool {
	_, hidden := gameLogic.(logic.StateViewer)
	return !hidden
}

func (e *Engine) matchRankings(m *Match) []protocol.RankingEntry {
	ranker, ok := m.logic.(logic.Ranker)
	if !ok {
		return nil
	}
	order := ranker.Rankings(m.state)
	entries := make([]protocol.RankingEntry, 0, len(order))
	for place, idx := range order {
		if idx < 0 || idx >= len(m.players) {
			return nil
		}
		entries = append(entries, protocol.RankingEntry{UserID: m.players[idx].ID, Place: place + 1})
	}
	return entries
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

func (e *Engine) toMatch(gameID, matchID string, envelope protocol.OutEnvelope) {
	if emitter := e.currentEmitter(); emitter != nil {
		emitter.ToMatch(gameID, matchID, envelope)
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
	afterMatchID := ""
	if e.reconnectActiveMatch(gameID, userID) {
		return
	}

	if data, ok := e.takeFinished(key); ok {
		e.toUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
		afterMatchID = data.MatchID
	}

	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	// A room may have started while this connection waited for roomMu.
	if e.reconnectActiveMatch(gameID, userID) {
		return
	}
	if data, ok := e.takeFinished(key); ok {
		e.toUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
		afterMatchID = data.MatchID
	}
	if ref, ok := e.store.RoomByUser(gameID, userID); ok {
		if room, exists := e.store.Get(gameID, ref.RoomID); exists && room.hasMember(userID) {
			e.emitRoomWaiting(gameID, userID, room)
			e.emitRoomStateToAfterMatch(room, userID, afterMatchID)
			e.emitRoomSync(gameID, userID, room.ID)
		} else {
			_ = e.store.DeleteUserRef(gameID, userID, ref.RoomID)
			e.emitRoomSync(gameID, userID, "")
		}
	} else {
		e.emitRoomSync(gameID, userID, "")
	}
}

func (e *Engine) reconnectActiveMatch(gameID, userID string) bool {
	if m := e.matchForUser(gameID, userID); m != nil {
		m.mu.Lock()
		if !m.over {
			m.ensureSeats()
			idx := m.playerIndex(userID)
			if m.disconnected[idx] {
				delete(m.disconnected, idx)
				delete(m.disconnectedAt, idx)
				if len(m.disconnected) == 0 {
					e.cancelGrace(m)
					if m.pausedRemain > 0 {
						e.armTimerDuration(m, m.pausedRemain)
						m.pausedRemain = 0
					}
				}
				reconnected := protocol.OpponentReconnectedData{
					UserID:   userID,
					Turn:     m.turnIdx,
					Deadline: m.deadline.UnixMilli(),
				}
				for otherIdx, other := range m.players {
					if otherIdx == idx || m.disconnected[otherIdx] || m.quit[otherIdx] {
						continue
					}
					e.toUser(m.GameID, other.ID, protocol.OutEnvelope{
						Type: protocol.S2COpponentReconnected,
						Data: reconnected,
					})
				}
				e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{
					Type: protocol.S2COpponentReconnected,
					Data: reconnected,
				})
				if err := e.persistMatch(m); err != nil {
					e.logger.Errorw("Failed to persist reconnected match", "match_id", m.ID, "error", err)
				}
			}
			e.sendMatchFoundTo(m, userID, true)
			for oppIdx := range m.players {
				if oppIdx != idx && m.disconnected[oppIdx] {
					e.toUser(m.GameID, userID, protocol.OutEnvelope{
						Type: protocol.S2COpponentDisconnected,
						Data: e.opponentDisconnectedData(m, oppIdx),
					})
				}
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

	needed := logic.MaxPlayers(gameLogic) - 1
	if len(queue) < needed {
		e.queues[gameID] = append(queue, player)
		e.queueMu.Unlock()
		e.toUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
		return
	}

	opponents := append([]protocol.PlayerInfo(nil), queue[:needed]...)
	e.queues[gameID] = append([]protocol.PlayerInfo(nil), queue[needed:]...)
	available := make([]protocol.PlayerInfo, 0, len(opponents))
	for _, opponent := range opponents {
		if !e.hasActiveMatch(gameID, opponent.ID) {
			available = append(available, opponent)
		}
	}
	if len(available) < needed {
		e.queues[gameID] = append(available, e.queues[gameID]...)
		e.queues[gameID] = append(e.queues[gameID], player)
		e.queueMu.Unlock()
		e.toUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
		return
	}
	opponents = available
	participants := append(append([]protocol.PlayerInfo(nil), opponents...), player)
	participantKeys := make([]string, 0, len(participants))
	for _, p := range participants {
		key := userKey(gameID, p.ID)
		participantKeys = append(participantKeys, key)
		e.queuePending[key] = true
	}
	e.queueMu.Unlock()

	releasePlayers, reserveErr := e.reserveQueuedMatch(gameID, participants...)
	if reserveErr != nil {
		err = reserveErr
	} else {
		err = e.startReservedQueuePlayers(gameID, gameLogic, participants, participantKeys)
		releasePlayers()
	}

	e.queueMu.Lock()
	cancelled := make(map[string]bool, len(participantKeys))
	for _, key := range participantKeys {
		delete(e.queuePending, key)
		cancelled[key] = e.queueCancelled[key]
		delete(e.queueCancelled, key)
	}
	if err != nil {
		for i := len(opponents) - 1; i >= 0; i-- {
			opponent := opponents[i]
			if !cancelled[userKey(gameID, opponent.ID)] && !queueHasPlayer(e.queues[gameID], opponent.ID) {
				e.queues[gameID] = append([]protocol.PlayerInfo{opponent}, e.queues[gameID]...)
			}
		}
		if !cancelled[playerKey] && !queueHasPlayer(e.queues[gameID], player.ID) {
			e.queues[gameID] = append(e.queues[gameID], player)
		}
	}
	e.queueMu.Unlock()
	if err != nil {
		for _, p := range participants {
			e.sendError(gameID, p.ID, protocol.ErrorCodeMatchStartFailed, err.Error())
		}
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

func (e *Engine) CreateRoom(gameID string, owner protocol.PlayerInfo, bet int, password string, maxPlayers int) {
	if e.sendActiveMatch(gameID, owner.ID) {
		return
	}
	gameLogic, err := logic.Get(gameID)
	if err != nil {
		e.sendError(gameID, owner.ID, protocol.ErrorCodeUnknownGame, err.Error())
		return
	}
	if maxPlayers == 0 {
		maxPlayers = logic.MaxPlayers(gameLogic)
	}
	if maxPlayers < logic.MinPlayers(gameLogic) || maxPlayers > logic.MaxPlayers(gameLogic) {
		e.sendError(gameID, owner.ID, protocol.ErrorCodeInvalidBet, "invalid room capacity")
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
		OwnerLevel:   owner.Level,
		MaxPlayers:   maxPlayers,
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
	if room.guestIndex(joiner.ID) >= 0 {
		e.emitRoomWaiting(gameID, joiner.ID, room)
		e.emitRoomStateTo(room, joiner.ID)
		return
	}
	if room.playerCount() >= room.capacity() {
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomFull, "room is full")
		return
	}
	if e.hasActiveMatch(gameID, room.OwnerID) {
		if err := e.store.Delete(gameID, room.ID, room.memberIDs()...); err != nil {
			e.logger.Errorw("Failed to delete room whose owner is busy", "room_id", room.ID, "error", err)
			e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomUpdateFailed, "failed to close unavailable room")
			return
		}
		e.emitRoomRemoved(room.GameID, room.ID)
		e.emitRoomClosed(room, "owner_busy")
		e.sendError(gameID, joiner.ID, protocol.ErrorCodeRoomNotFound, "room owner busy")
		return
	}

	room.addGuest(RoomGuest{ID: joiner.ID, Name: joiner.Name, VipType: joiner.VipType, Level: joiner.Level})
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
		if !disconnected {
			e.sendError(gameID, userID, protocol.ErrorCodeRoomNotFound, "room not found")
		}
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
		if err := e.store.Delete(gameID, room.ID, room.memberIDs()...); err != nil {
			e.logger.Errorw("Failed to close room", "room_id", room.ID, "error", err)
			e.sendError(gameID, userID, protocol.ErrorCodeRoomLeaveFailed, err.Error())
			return
		}
		e.clearRoomChatRate(room.GameID, room.memberIDs()...)
		reason := "owner_left"
		if disconnected {
			reason = "owner_disconnected"
		}
		e.emitRoomRemoved(room.GameID, room.ID)
		e.emitRoomClosed(room, reason)
		return
	}

	guestID := removeRoomGuest(&room, userID)
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomLeaveFailed, err.Error())
		return
	}
	e.clearRoomChatRate(room.GameID, room.OwnerID, guestID)
	_ = e.store.DeleteUserRef(gameID, guestID, room.ID)
	e.emitRoomUpsert(room)
	e.emitRoomState(room)
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
	idx := room.guestIndex(userID)
	if idx < 0 {
		e.sendError(gameID, userID, protocol.ErrorCodeNotRoomMember, "only room members can set readiness")
		return
	}
	room.normalize()
	room.Guests = append([]RoomGuest(nil), room.Guests...)
	room.Guests[idx].Ready = ready
	room.syncLegacyGuest()
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
	if guests := room.guestList(); targetID == "" && len(guests) == 1 {
		targetID = guests[0].ID
	}
	if targetID == "" || room.guestIndex(targetID) < 0 {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomMemberNotFound, "room member not found")
		return
	}

	kickedID := removeRoomGuest(&room, targetID)
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
	e.emitRoomState(room)
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
	gameLogic, err := logic.Get(gameID)
	if err != nil {
		e.sendError(gameID, ownerID, protocol.ErrorCodeUnknownGame, err.Error())
		return
	}
	if room.playerCount() < logic.MinPlayers(gameLogic) {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomNotFull, "another player is required")
		return
	}
	if !room.allGuestsReady() {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomNotReady, "the guest must be ready")
		return
	}
	releasePlayers, reserved := e.reserveRoomUsers(gameID, room.memberIDs()...)
	if !reserved {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomBusy, "a room member state is being updated")
		return
	}
	defer releasePlayers()
	if err := e.store.Delete(gameID, room.ID, room.memberIDs()...); err != nil {
		e.sendError(gameID, ownerID, protocol.ErrorCodeRoomStartFailed, err.Error())
		return
	}
	// The per-room claim remains held while escrow is recorded. Releasing the
	// global room mutex lets unrelated rooms continue during that bounded I/O.
	e.roomMu.Unlock()
	roomPlayers := make([]protocol.PlayerInfo, 0, room.playerCount())
	roomPlayers = append(roomPlayers, protocol.PlayerInfo{ID: room.OwnerID, Name: room.OwnerName, VipType: room.OwnerVipType, Level: room.OwnerLevel})
	for _, g := range room.guestList() {
		roomPlayers = append(roomPlayers, protocol.PlayerInfo{ID: g.ID, Name: g.Name, VipType: g.VipType, Level: g.Level})
	}
	startErr := e.startRoomMatch(gameID, gameLogic, roomPlayers, room.Bet, room)
	e.roomMu.Lock()
	if startErr != nil {
		if !e.restoreRoomAfterFailedStart(room) {
			e.emitRoomRemoved(room.GameID, room.ID)
		} else {
			e.emitRoomUpsert(room)
		}
		for _, memberID := range room.memberIDs() {
			e.sendError(gameID, memberID, protocol.ErrorCodeRoomStartFailed, startErr.Error())
		}
		return
	}
	if listsPlayingRooms(room.GameID) {
		e.emitPlayingRoomUpsert(room)
	} else {
		e.emitRoomRemoved(room.GameID, room.ID)
	}
}

func (e *Engine) restoreRoomAfterFailedStart(room Room) bool {
	for _, userID := range room.memberIDs() {
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
	for _, userID := range room.memberIDs() {
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
	type roomListEntry struct {
		room    Room
		playing bool
		matchID string
	}
	entries := make([]roomListEntry, 0, len(rooms))
	seen := make(map[string]struct{}, len(rooms))
	for _, room := range rooms {
		entries = append(entries, roomListEntry{room: room})
		seen[room.ID] = struct{}{}
	}
	if listsPlayingRooms(gameID) {
		snapshots, listErr := e.activeStore.List(gameID)
		if listErr != nil {
			e.logger.Errorw("Failed to list active matches for room list", "game_id", gameID, "error", listErr)
			e.sendError(gameID, userID, protocol.ErrorCodeRoomListFailed, "failed to load playing rooms")
			return
		}
		for _, snapshot := range snapshots {
			if snapshot.Status != matchStatusPlaying || snapshot.Room == nil ||
				snapshot.Room.ID == "" || snapshot.Room.GameID != gameID {
				continue
			}
			if _, exists := seen[snapshot.Room.ID]; exists {
				continue
			}
			entries = append(entries, roomListEntry{room: *snapshot.Room, playing: true, matchID: snapshot.ID})
			seen[snapshot.Room.ID] = struct{}{}
		}
	}
	sort.Slice(entries, func(i, j int) bool {
		if entries[i].room.CreatedAt == entries[j].room.CreatedAt {
			return entries[i].room.ID < entries[j].room.ID
		}
		return entries[i].room.CreatedAt > entries[j].room.CreatedAt
	})
	infos := make([]protocol.RoomInfo, 0, len(entries))
	for _, entry := range entries {
		info := roomInfo(entry.room)
		if entry.playing {
			info.Status = protocol.RoomStatusPlaying
			info.MatchID = entry.matchID
		}
		infos = append(infos, info)
	}
	e.toUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CRoomList, Data: protocol.RoomListData{Rooms: infos}})
}

func listsPlayingRooms(gameID string) bool {
	return gameID == playingRoomGameID
}

func roomInfo(room Room) protocol.RoomInfo {
	players := room.playerCount()
	return protocol.RoomInfo{
		ID:           room.ID,
		Owner:        room.OwnerName,
		OwnerVipType: room.OwnerVipType,
		Bet:          room.Bet,
		Locked:       room.Password != "",
		Players:      players,
		MaxPlayers:   room.capacity(),
		Full:         players >= room.capacity(),
	}
}

func (e *Engine) emitRoomUpsert(room Room) {
	e.toGame(room.GameID, protocol.OutEnvelope{
		Type: protocol.S2CRoomUpsert,
		Data: protocol.RoomUpsertData{Room: roomInfo(room)},
	})
}

func (e *Engine) matchIDForRoom(roomID string) string {
	e.mu.RLock()
	defer e.mu.RUnlock()
	for _, m := range e.matches {
		if m.listedRoomID == roomID {
			return m.ID
		}
	}
	return ""
}

func (e *Engine) emitPlayingRoomUpsert(room Room) {
	info := roomInfo(room)
	info.Status = protocol.RoomStatusPlaying
	info.MatchID = e.matchIDForRoom(room.ID)
	e.toGame(room.GameID, protocol.OutEnvelope{
		Type: protocol.S2CRoomUpsert,
		Data: protocol.RoomUpsertData{Room: info},
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
		Data: protocol.RoomWaitingData{RoomID: room.ID, Bet: room.Bet, Locked: room.Password != "", MaxPlayers: room.capacity()},
	})
}

func (e *Engine) emitRoomState(room Room) {
	e.emitRoomStateAfterMatch(room, "")
}

func (e *Engine) emitRoomStateAfterMatch(room Room, matchID string) {
	for _, memberID := range room.memberIDs() {
		e.emitRoomStateToAfterMatch(room, memberID, matchID)
	}
}

func (e *Engine) emitRoomStateTo(room Room, userID string) {
	e.emitRoomStateToAfterMatch(room, userID, "")
}

func (e *Engine) emitRoomStateToAfterMatch(room Room, userID, matchID string) {
	members := make([]protocol.RoomMember, 0, room.playerCount())
	members = append(members, protocol.RoomMember{
		ID: room.OwnerID, Name: room.OwnerName, VipType: room.OwnerVipType, Level: room.OwnerLevel, Owner: true, Ready: true,
	})
	for _, g := range room.guestList() {
		members = append(members, protocol.RoomMember{
			ID: g.ID, Name: g.Name, VipType: g.VipType, Level: g.Level, Ready: g.Ready,
		})
	}
	e.toUser(room.GameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CRoomState,
		Data: protocol.RoomStateData{
			RoomID: room.ID, OwnerID: room.OwnerID, YouID: userID, Bet: room.Bet,
			Locked: room.Password != "", MaxPlayers: room.capacity(), Members: members, AfterMatchID: matchID,
		},
	})
}

func (e *Engine) emitRoomSync(gameID, userID, roomID string) {
	e.toUser(gameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CRoomSync,
		Data: protocol.RoomSyncData{RoomID: roomID},
	})
}

func (e *Engine) emitRoomClosed(room Room, reason string) {
	data := protocol.RoomClosedData{RoomID: room.ID, Reason: reason}
	for _, memberID := range room.memberIDs() {
		e.toUser(room.GameID, memberID, protocol.OutEnvelope{Type: protocol.S2CRoomClosed, Data: data})
	}
}

func (e *Engine) emitRoomClosedExcept(room Room, excludedID, reason string) {
	data := protocol.RoomClosedData{RoomID: room.ID, Reason: reason}
	for _, memberID := range room.memberIDs() {
		if memberID == excludedID {
			continue
		}
		e.toUser(room.GameID, memberID, protocol.OutEnvelope{Type: protocol.S2CRoomClosed, Data: data})
		e.emitRoomSync(room.GameID, memberID, "")
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
	if userID == "" {
		return false
	}
	if r.OwnerID == userID || r.GuestID == userID {
		return true
	}
	return r.guestIndex(userID) >= 0
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
	m.ensureSeats()
	idx := m.playerIndex(userID)
	if idx < 0 || m.quit[idx] {
		return true
	}
	if m.disconnected[idx] {
		return true
	}
	m.disconnected[idx] = true
	m.disconnectedAt[idx] = time.Now()

	if m.turnIdx == idx && m.pausedRemain == 0 {
		e.invalidateTurnTimer(m)
		remain := time.Until(m.deadline)
		if remain < time.Second {
			remain = time.Second
		}
		m.pausedRemain = remain
	}

	if m.graceTimer == nil {
		e.armGraceTimer(m, time.Duration(e.graceSeconds)*time.Second)
	}

	for oppIdx, opp := range m.players {
		if oppIdx == idx || m.disconnected[oppIdx] || m.quit[oppIdx] {
			continue
		}
		e.toUser(m.GameID, opp.ID, protocol.OutEnvelope{
			Type: protocol.S2COpponentDisconnected,
			Data: e.opponentDisconnectedData(m, idx),
		})
	}
	e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{
		Type: protocol.S2COpponentDisconnected,
		Data: e.opponentDisconnectedData(m, idx),
	})
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist disconnected match", "match_id", m.ID, "error", err)
	}
	return true
}

func (e *Engine) armGraceTimer(m *Match, wait time.Duration) {
	if wait < time.Second {
		wait = time.Second
	}
	m.graceGen++
	gen := m.graceGen
	m.graceDeadline = time.Now().Add(wait)
	matchID := m.ID
	m.graceTimer = time.AfterFunc(time.Until(m.graceDeadline), func() {
		e.onGraceExpire(matchID, gen)
	})
}

func (e *Engine) opponentDisconnectedData(m *Match, idx int) protocol.OpponentDisconnectedData {
	turnRemainingMs := int64(0)
	if m.pausedRemain > 0 && m.turnIdx == idx {
		turnRemainingMs = m.pausedRemain.Milliseconds()
	}
	deadline := m.graceDeadline
	if at, ok := m.disconnectedAt[idx]; ok && !at.IsZero() {
		deadline = at.Add(time.Duration(e.graceSeconds) * time.Second)
	}
	return protocol.OpponentDisconnectedData{
		GraceDeadline:   deadline.UnixMilli(),
		TurnRemainingMs: turnRemainingMs,
		UserID:          m.players[idx].ID,
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
	m.ensureSeats()
	m.graceTimer = nil

	connected := 0
	for _, i := range m.activeIdxs() {
		if !m.disconnected[i] {
			connected++
		}
	}
	if connected == 0 {
		e.finishMatch(m, "", "disconnect")
		return
	}

	const expiryEpsilon = 100 * time.Millisecond
	grace := time.Duration(e.graceSeconds) * time.Second
	now := time.Now()
	firedAt := m.graceDeadline
	if firedAt.IsZero() || now.After(firedAt) {
		firedAt = now
	}
	expired := make([]int, 0, len(m.disconnected))
	var nextWait time.Duration
	for _, i := range m.activeIdxs() {
		if !m.disconnected[i] {
			continue
		}
		personal := m.disconnectedAt[i]
		if personal.IsZero() {
			expired = append(expired, i)
			continue
		}
		if !personal.Add(grace).After(firedAt.Add(expiryEpsilon)) {
			expired = append(expired, i)
			continue
		}
		wait := personal.Add(grace).Sub(now)
		if wait < time.Second {
			wait = time.Second
		}
		if nextWait == 0 || wait < nextWait {
			nextWait = wait
		}
	}

	handler, hasQuitHandler := m.logic.(logic.QuitHandler)
	for _, i := range expired {
		if m.over {
			return
		}
		if hasQuitHandler && len(m.activeIdxs())-1 >= 2 {
			e.eliminatePlayer(m, i, handler, "disconnect")
			continue
		}
		winnerID := ""
		for _, j := range m.activeIdxs() {
			if j != i && !m.disconnected[j] {
				winnerID = m.players[j].ID
				break
			}
		}
		e.finishMatch(m, winnerID, "disconnect")
		return
	}
	if m.over {
		return
	}

	stillDisconnected := false
	for _, i := range m.activeIdxs() {
		if m.disconnected[i] {
			stillDisconnected = true
			break
		}
	}
	if stillDisconnected {
		e.armGraceTimer(m, nextWait)
		return
	}
	e.cancelGrace(m)
	if m.pausedRemain > 0 && !m.disconnected[m.turnIdx] {
		e.armTimerDuration(m, m.pausedRemain)
		m.pausedRemain = 0
		if err := e.persistMatch(m); err != nil {
			e.logger.Errorw("Failed to persist match after grace eliminations", "match_id", m.ID, "error", err)
		}
	}
}

// eliminatePlayer marks one seat as quit and lets the match continue. It must
// be called with m.mu held and only when the game implements QuitHandler and
// at least two active players remain afterwards.
func (e *Engine) eliminatePlayer(m *Match, idx int, handler logic.QuitHandler, cause string) {
	m.quit[idx] = true
	delete(m.disconnected, idx)
	delete(m.disconnectedAt, idx)
	handler.OnPlayerQuit(m.state, idx)

	if over, winnerIdx := m.logic.Result(m.state); over {
		winnerID := ""
		reason := "win"
		if winnerIdx >= 0 && winnerIdx < len(m.players) {
			winnerID = m.players[winnerIdx].ID
		} else {
			reason = "draw"
		}
		e.finishMatch(m, winnerID, reason)
		return
	}
	if active := m.activeIdxs(); len(active) < 2 {
		winnerID := ""
		if len(active) == 1 {
			winnerID = m.players[active[0]].ID
		}
		e.finishMatch(m, winnerID, cause)
		return
	}

	if m.turnIdx == idx {
		m.pausedRemain = 0
		m.turnIdx = e.nextTurnIdx(m)
		m.deadline = time.Now().Add(time.Duration(e.logicTurnSeconds(m.logic)) * time.Second)
		if m.disconnected[m.turnIdx] {
			e.invalidateTurnTimer(m)
			m.pausedRemain = time.Until(m.deadline)
			if m.pausedRemain < time.Second {
				m.pausedRemain = time.Second
			}
		} else {
			e.scheduleTurnTimer(m)
		}
	} else if m.pausedRemain > 0 && !m.disconnected[m.turnIdx] {
		e.armTimerDuration(m, m.pausedRemain)
		m.pausedRemain = 0
	}
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist match after player quit", "match_id", m.ID, "player_idx", idx, "error", err)
	}
	e.broadcastState(m, nil, idx)
	e.logger.Infow("Player eliminated from match", "match_id", m.ID, "player_idx", idx, "cause", cause)
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

	m.ensureSeats()
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
	previousTimeoutRuns := append([]int(nil), m.timeoutRuns...)
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
		m.turnIdx = e.nextTurnIdx(m)
	}
	m.timeoutRuns[playerIdx] = 0
	m.deadline = time.Now().Add(e.turnDuration(m, playerIdx))
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

	e.broadcastState(m, move, playerIdx)
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

	m.ensureSeats()
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
	e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{Type: protocol.S2CChatMessage, Data: data})
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
	if len(room.guestList()) == 0 {
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
	if idx := room.guestIndex(userID); idx >= 0 {
		senderName = room.guestList()[idx].Name
	}
	data := protocol.ChatMessageData{
		RoomID: room.ID,
		UserID: userID,
		Name:   senderName,
		Text:   text,
		SentAt: now.UnixMilli(),
	}
	for _, recipientID := range room.memberIDs() {
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

	m.ensureSeats()
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
	e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{Type: protocol.S2CReaction, Data: data})
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
	m.ensureSeats()
	idx := m.playerIndex(userID)
	if idx < 0 || m.quit[idx] {
		return
	}
	if leaveAfter {
		if m.room != nil && m.room.guestIndex(userID) >= 0 {
			room := *m.room
			removeRoomGuest(&room, userID)
			m.room = &room
		} else if m.room != nil && m.room.OwnerID == userID {
			m.closedRoom = cloneRoom(m.room)
			m.room = nil
		} else if m.closedRoom != nil && m.closedRoom.guestIndex(userID) >= 0 {
			room := *m.closedRoom
			removeRoomGuest(&room, userID)
			m.closedRoom = &room
		}
	}
	if handler, ok := m.logic.(logic.QuitHandler); ok && len(m.activeIdxs())-1 >= 2 {
		e.eliminatePlayer(m, idx, handler, "forfeit")
		return
	}
	winnerID := ""
	for _, j := range m.activeIdxs() {
		if j != idx {
			winnerID = m.players[j].ID
			break
		}
	}
	e.finishMatch(m, winnerID, "forfeit")
}

func (e *Engine) startMatch(gameID string, gameLogic logic.GameLogic, p0, p1 protocol.PlayerInfo, bet int) error {
	return e.startMatchWithRoom(gameID, gameLogic, []protocol.PlayerInfo{p0, p1}, bet, nil, false, nil)
}

func (e *Engine) startReservedQueueMatch(
	gameID string,
	gameLogic logic.GameLogic,
	p0, p1 protocol.PlayerInfo,
	queueKeys ...string,
) error {
	return e.startMatchWithRoom(gameID, gameLogic, []protocol.PlayerInfo{p0, p1}, 0, nil, true, queueKeys)
}

func (e *Engine) startReservedQueuePlayers(
	gameID string,
	gameLogic logic.GameLogic,
	players []protocol.PlayerInfo,
	queueKeys []string,
) error {
	return e.startMatchWithRoom(gameID, gameLogic, players, 0, nil, true, queueKeys)
}

func (e *Engine) startRoomMatch(gameID string, gameLogic logic.GameLogic, players []protocol.PlayerInfo, bet int, room Room) error {
	return e.startMatchWithRoom(gameID, gameLogic, players, bet, &room, true, nil)
}

func (e *Engine) startMatchWithRoom(
	gameID string,
	gameLogic logic.GameLogic,
	players []protocol.PlayerInfo,
	bet int,
	room *Room,
	allowRoomReservation bool,
	queueKeys []string,
) error {
	if bet < 0 || bet > MaxBet {
		return fmt.Errorf("bet is outside the allowed range")
	}
	if len(players) < logic.MinPlayers(gameLogic) || len(players) > logic.MaxPlayers(gameLogic) {
		return fmt.Errorf("invalid player count for this game")
	}
	settlement := e.currentSettlement()
	if bet > 0 && settlement == nil {
		return fmt.Errorf("betting is temporarily unavailable")
	}
	players = append([]protocol.PlayerInfo(nil), players...)
	rand.Shuffle(len(players), func(i, j int) {
		players[i], players[j] = players[j], players[i]
	})

	seed := time.Now().UnixNano()
	initialState := gameLogic.Init(seed)
	if pi, ok := gameLogic.(logic.PlayerInit); ok {
		initialState = pi.InitPlayers(seed, len(players))
	}
	m := &Match{
		ID:           uuid.NewString(),
		GameID:       gameID,
		logic:        gameLogic,
		players:      players,
		state:        initialState,
		turnIdx:      0,
		bet:          bet,
		disconnected: make(map[int]bool),
		startedAt:    time.Now(),
		room:         room,
	}
	m.ensureSeats()
	if starter, ok := m.state.(interface{ StartingTurn() int }); ok {
		if idx := starter.StartingTurn(); idx >= 0 && idx < len(players) {
			m.turnIdx = idx
		}
	}
	if room != nil && listsPlayingRooms(gameID) {
		m.listedRoomID = room.ID
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
			PlayerIDs: matchPlayerIDs(m),
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
	m.deadline = time.Now().Add(e.turnDuration(m, -1))
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
			if delErr := e.activeStore.Delete(gameID, m.ID, matchPlayerIDs(m)...); delErr != nil {
				e.logger.Errorw("Failed to clean up match after persistence failure", "match_id", m.ID, "error", delErr)
			}
		}
		return persistErr
	}
	finishedKeys := make([]string, 0, len(m.players))
	for _, p := range m.players {
		finishedKeys = append(finishedKeys, userKey(gameID, p.ID))
	}
	e.clearFinished(finishedKeys...)
	e.scheduleTurnTimer(m)
	e.sendMatchFound(m, false)
	e.emitSettledBalances(startBalances, gameID)
	e.logger.Infow("Match started", "match_id", m.ID, "game_id", gameID, "players", matchPlayerIDs(m))
	if over, winnerIdx := gameLogic.Result(m.state); over {
		winnerID := ""
		reason := "win"
		if winnerIdx >= 0 && winnerIdx < len(m.players) {
			winnerID = m.players[winnerIdx].ID
		} else {
			reason = "draw"
		}
		e.finishMatch(m, winnerID, reason)
	}
	return nil
}

func matchPlayerIDs(m *Match) []string {
	ids := make([]string, 0, len(m.players))
	for _, p := range m.players {
		ids = append(ids, p.ID)
	}
	return ids
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
	idx := m.playerIndex(userID)
	e.toUser(m.GameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CMatchFound,
		Data: protocol.MatchFoundData{
			MatchID:     m.ID,
			GameID:      m.GameID,
			Players:     m.players,
			You:         idx,
			State:       e.viewFor(m, idx),
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

func (e *Engine) logicTurnSeconds(gameLogic logic.GameLogic) int {
	if timer, ok := gameLogic.(logic.TurnTimer); ok {
		if s := timer.TurnSeconds(); s > 0 {
			return s
		}
	}
	return e.turnSeconds
}

func (e *Engine) turnDuration(m *Match, previousPlayerIdx int) time.Duration {
	duration := time.Duration(e.logicTurnSeconds(m.logic)) * time.Second
	delayer, ok := m.logic.(logic.TurnStartDelayer)
	if !ok {
		return duration
	}
	delay := delayer.TurnStartDelay(m.state, previousPlayerIdx, m.turnIdx)
	if delay < 0 {
		delay = 0
	}
	if delay > maxTurnStartDelay {
		delay = maxTurnStartDelay
	}
	return duration + delay
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
	m.ensureSeats()
	timeoutWinner := func() string {
		for _, j := range m.activeIdxs() {
			if j != m.turnIdx {
				return m.players[j].ID
			}
		}
		return ""
	}
	if skipper, ok := m.logic.(logic.TimeoutSkipper); !ok || !skipper.TimeoutSkipsTurn() {
		e.finishMatch(m, timeoutWinner(), "timeout")
		return
	}
	m.timeoutRuns[m.turnIdx]++
	if m.timeoutRuns[m.turnIdx] >= 3 {
		if handler, ok := m.logic.(logic.QuitHandler); ok && len(m.activeIdxs())-1 >= 2 {
			e.eliminatePlayer(m, m.turnIdx, handler, "timeout")
			return
		}
		e.finishMatch(m, timeoutWinner(), "timeout")
		return
	}
	timedOut := m.turnIdx
	if handler, ok := m.logic.(logic.TurnSkipHandler); ok {
		handler.OnTurnSkipped(m.state, timedOut)
	}
	if over, winnerIdx := m.logic.Result(m.state); over {
		winnerID := ""
		reason := "win"
		if winnerIdx >= 0 && winnerIdx < len(m.players) {
			winnerID = m.players[winnerIdx].ID
		} else {
			reason = "draw"
		}
		e.finishMatch(m, winnerID, reason)
		return
	}
	m.turnIdx = e.nextTurnIdx(m)
	m.deadline = time.Now().Add(time.Duration(e.logicTurnSeconds(m.logic)) * time.Second)
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
	e.broadcastState(m, nil, timedOut)
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
	gone := func(userID string) bool {
		idx := m.playerIndex(userID)
		if idx < 0 {
			return false
		}
		return m.disconnected[idx] || m.quit[idx]
	}
	if m.room != nil && (len(m.disconnected) > 0 || len(m.quit) > 0) {
		if gone(m.room.OwnerID) {
			if m.closedRoom == nil {
				m.closedRoom = cloneRoom(m.room)
			}
			m.room = nil
		} else {
			room := *m.room
			room.normalize()
			for _, g := range append([]RoomGuest(nil), room.Guests...) {
				if gone(g.ID) {
					removeRoomGuest(&room, g.ID)
				}
			}
			m.room = &room
		}
	} else if len(m.disconnected) > 0 && m.room == nil {
		m.room = nil
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
	rankings := e.matchRankings(m)
	rankedIDs := make([]string, 0, len(rankings))
	for _, entry := range rankings {
		rankedIDs = append(rankedIDs, entry.UserID)
	}
	outcome := MatchOutcome{
		GameID:     m.GameID,
		MatchID:    m.ID,
		Player0ID:  m.players[0].ID,
		Player1ID:  m.players[1].ID,
		PlayerIDs:  matchPlayerIDs(m),
		Rankings:   rankedIDs,
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
	// Exp only reaches the database through settlement, so a match that will
	// never be settled must not announce gains the players would lose on
	// reconnect.
	willSettle := e.currentSettlement() != nil || m.bet > 0
	var expGains []protocol.ExpGainEntry
	if willSettle {
		expGains = matchExpGains(matchPlayerIDs(m), winnerID, reason, outcome.MoveCount)
	}
	data := protocol.MatchOverData{
		MatchID:  m.ID,
		WinnerID: winnerID,
		Reason:   reason,
		State:    m.state,
		Bet:      m.bet,
		Payout:   payout,
		KenDelta: kenDelta,
		Rankings: rankings,
		ExpGains: expGains,
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
	e.notifySpectatorsMatchOver(m, data)
	if willSettle {
		e.queueFinishedSettlement(snapshot, outcome)
	} else if _, err := e.activeStore.DeleteIfStatus(
		m.GameID,
		m.ID,
		matchStatusFinished,
		matchPlayerIDs(m)...,
	); err != nil {
		e.logger.Errorw("Failed to delete finished active match", "match_id", m.ID, "error", err)
	}
	if waitingRoom != nil {
		e.emitRoomUpsert(*waitingRoom)
		for _, memberID := range waitingRoom.memberIDs() {
			e.emitRoomWaiting(waitingRoom.GameID, memberID, *waitingRoom)
		}
		e.emitRoomStateAfterMatch(*waitingRoom, m.ID)
	} else if m.listedRoomID != "" {
		e.emitRoomRemoved(m.GameID, m.listedRoomID)
	}
	if m.closedRoom != nil {
		reason := "owner_left"
		if ownerIdx := m.playerIndex(m.closedRoom.OwnerID); ownerIdx >= 0 && m.disconnected[ownerIdx] {
			reason = "owner_disconnected"
		}
		e.emitRoomClosedExcept(*m.closedRoom, m.closedRoom.OwnerID, reason)
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
		ClosedRoom:         m.closedRoom,
	}
	for idx := range m.quit {
		if m.quit[idx] {
			snapshot.Quit = append(snapshot.Quit, idx)
		}
	}
	sort.Ints(snapshot.Quit)
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

const maxEnginePlayers = 8

func validPlayingSnapshotShape(snapshot ActiveMatchSnapshot, expectedGameID string) bool {
	return snapshot.ID != "" && snapshot.GameID == expectedGameID &&
		len(snapshot.Players) >= 2 && len(snapshot.Players) <= maxEnginePlayers &&
		snapshot.TurnIndex >= 0 && snapshot.TurnIndex < len(snapshot.Players)
}

func (e *Engine) restorePlayingSnapshot(snapshot ActiveMatchSnapshot, expectedGameID string) (bool, bool) {
	if snapshot.Status != matchStatusPlaying {
		e.logger.Warnw("Skipped active match with unknown status", "match_id", snapshot.ID, "status", snapshot.Status)
		return false, false
	}
	if !validPlayingSnapshotShape(snapshot, expectedGameID) {
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
	if current.ID != snapshot.ID || !validPlayingSnapshotShape(current, expectedGameID) {
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
	if len(snapshot.Players) > logic.MaxPlayers(gameLogic) {
		e.logger.Errorw("Skipped active match with unsupported player count", "match_id", snapshot.ID, "players", len(snapshot.Players))
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
		deadline = time.Now().Add(time.Duration(e.logicTurnSeconds(gameLogic)) * time.Second)
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
		timeoutRuns:  append([]int(nil), snapshot.TimeoutRuns...),
		deadline:     deadline,
		bet:          snapshot.Bet,
		disconnected: make(map[int]bool, len(snapshot.Players)),
		pausedRemain: pausedRemain,
		startedAt:    startedAt,
		graceGen:     1,
		room:         cloneRoom(snapshot.Room),
		closedRoom:   cloneRoom(snapshot.ClosedRoom),
	}
	m.ensureSeats()
	for _, idx := range snapshot.Quit {
		if idx >= 0 && idx < len(m.players) {
			m.quit[idx] = true
		}
	}
	now := time.Now()
	for idx := range m.players {
		if !m.quit[idx] {
			m.disconnected[idx] = true
			m.disconnectedAt[idx] = now
		}
	}
	if snapshot.Room != nil && listsPlayingRooms(snapshot.GameID) {
		m.listedRoomID = snapshot.Room.ID
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
	memberIDs := room.memberIDs()

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
	var expGains []protocol.ExpGainEntry
	if e.currentSettlement() != nil || snapshot.Bet > 0 {
		expGains = matchExpGains(snapshotPlayerIDs(snapshot), snapshot.WinnerID, snapshot.ResultReason, stateMoveCount(gameLogic, state))
	}
	data := protocol.MatchOverData{
		MatchID:  snapshot.ID,
		WinnerID: snapshot.WinnerID,
		Reason:   snapshot.ResultReason,
		State:    state,
		Bet:      snapshot.Bet,
		Payout:   payout,
		KenDelta: kenDelta,
		ExpGains: expGains,
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
	room.normalize()
	room.Guests = append([]RoomGuest(nil), room.Guests...)
	for i := range room.Guests {
		room.Guests[i].Ready = false
	}
	room.syncLegacyGuest()
	return room
}

func removeRoomGuest(room *Room, userID string) string {
	room.normalize()
	idx := room.guestIndex(userID)
	if idx < 0 {
		return ""
	}
	removedID := room.Guests[idx].ID
	room.Guests = append(append([]RoomGuest(nil), room.Guests[:idx]...), room.Guests[idx+1:]...)
	room.syncLegacyGuest()
	return removedID
}

func cloneRoom(room *Room) *Room {
	if room == nil {
		return nil
	}
	cloned := *room
	cloned.normalize()
	cloned.Guests = append([]RoomGuest(nil), cloned.Guests...)
	return &cloned
}

func (e *Engine) sendError(gameID, userID string, code string, message string) {
	e.toUser(gameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CError,
		Data: protocol.ErrorData{Code: code, Message: message},
	})
}

func (m *Match) playerIndex(userID string) int {
	for i, p := range m.players {
		if p.ID == userID {
			return i
		}
	}
	return -1
}
