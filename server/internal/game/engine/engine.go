package engine

import (
	"encoding/json"
	"sync"
	"time"

	"ola-chat-server/internal/game/games/thirteen"
	"ola-chat-server/internal/game/games/tycoon"
	wargod "ola-chat-server/internal/game/games/war-god"
	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"go.uber.org/zap"
)

type Emitter interface {
	ToUser(gameID string, userID string, envelope protocol.OutEnvelope)
	ToGame(gameID string, envelope protocol.OutEnvelope)
	ToMatch(gameID string, matchID string, envelope protocol.OutEnvelope)
	ToRoomWatchers(gameID string, roomID string, envelope protocol.OutEnvelope)
}

const (
	MaxSpectators     = 20
	finishedResultTTL = 2 * time.Minute
	maxTurnStartDelay = 20 * time.Second

	// MaxConsecutiveTimeouts forfeits a player who keeps letting the clock run
	// out, whether the game skips their turn or plays a fallback move for them.
	MaxConsecutiveTimeouts = 3
	// timeoutMoveRetryDelay backs off before retrying a fallback move whose
	// snapshot could not be saved; the delay doubles per attempt up to
	// maxTimeoutMoveRetryDelay, then the match is aborted and the bets refunded.
	timeoutMoveRetryDelay    = 2 * time.Second
	maxTimeoutMoveRetryDelay = 30 * time.Second
	maxTimeoutMoveRetries    = 5

	matchReasonAborted = "aborted"
	maxChatRunes       = 120
	chatCooldown       = 500 * time.Millisecond
	reactionCooldown   = 800 * time.Millisecond
)

var playingRoomGames = map[string]bool{wargod.GameID: true, thirteen.GameID: true, tycoon.GameID: true}

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
	mu          sync.Mutex
	ID          string
	GameID      string
	logic       logic.GameLogic
	players     []protocol.PlayerInfo
	state       any
	turnIdx     int
	timeoutRuns []int
	// timeoutMove caches the fallback move for the expired turn so a retry
	// after a save failure never recomputes it, and timeoutMoveFails counts
	// those failures. Both are cleared as soon as the state advances.
	timeoutMove      json.RawMessage
	timeoutMoveFails int
	deadline         time.Time
	timer            *time.Timer
	turnGen          int
	over             bool
	bet              int
	graceTimer       *time.Timer
	graceDeadline    time.Time
	graceGen         int
	disconnected     map[int]bool
	disconnectedAt   map[int]time.Time
	quit             map[int]bool
	pausedRemain     time.Duration
	startedAt        time.Time
	winnerID         string
	resultReason     string
	finishedAt       time.Time
	lastChatAt       []time.Time
	lastReactionAt   []time.Time
	room             *Room
	closedRoom       *Room
	listedRoomID     string
	escrowVerified   bool
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

func (e *Engine) toRoomWatchers(gameID, roomID string, envelope protocol.OutEnvelope) {
	if emitter := e.currentEmitter(); emitter != nil {
		emitter.ToRoomWatchers(gameID, roomID, envelope)
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
	m.ensureSeats()
	e.markSeatReconnected(m, m.playerIndex(userID))
	e.sendMatchFoundTo(m, userID, true)
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
	for idx, player := range m.players {
		if m.quit[idx] {
			continue
		}
		key := userKey(m.GameID, player.ID)
		if _, reserved := e.roomReservations[key]; reserved && !allowRoomReservation {
			return matchRoomTransition
		}
		if current := e.byUser[key]; current != nil {
			return matchPlayerConflict
		}
	}
	e.matches[m.ID] = m
	for idx, player := range m.players {
		if !m.quit[idx] {
			e.byUser[userKey(m.GameID, player.ID)] = m
		}
	}
	return matchInstalled
}

func (e *Engine) releaseSeat(m *Match, idx int) {
	key := userKey(m.GameID, m.players[idx].ID)
	e.mu.Lock()
	if e.byUser[key] == m {
		delete(e.byUser, key)
	}
	e.mu.Unlock()
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

func (e *Engine) sendError(gameID, userID string, code string, message string) {
	e.toUser(gameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CError,
		Data: protocol.ErrorData{Code: code, Message: message},
	})
}

func (m *Match) playerIndex(userID string) int {
	return seatOf(m.players, userID)
}

func seatOf(players []protocol.PlayerInfo, userID string) int {
	for i, p := range players {
		if p.ID == userID {
			return i
		}
	}
	return -1
}
