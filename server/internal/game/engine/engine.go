package engine

import (
	"encoding/json"
	"math/rand"
	"sync"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Emitter interface {
	ToUser(gameID string, userID string, envelope protocol.OutEnvelope)
}

const finishedResultTTL = 2 * time.Minute

type Engine struct {
	mu           sync.Mutex
	logger       *zap.SugaredLogger
	emitter      Emitter
	store        *RoomStore
	queues       map[string][]protocol.PlayerInfo
	matches      map[string]*Match
	byUser       map[string]*Match
	finished     map[string]protocol.MatchOverData
	turnSeconds  int
	graceSeconds int
}

type Match struct {
	ID            string
	GameID        string
	logic         logic.GameLogic
	players       []protocol.PlayerInfo
	state         any
	turnIdx       int
	deadline      time.Time
	timer         *time.Timer
	over          bool
	bet           int
	graceTimer    *time.Timer
	graceDeadline time.Time
	graceGen      int
	disconnected  map[int]bool
	pausedRemain  time.Duration
}

func NewEngine(logger *zap.SugaredLogger, turnSeconds int, graceSeconds int, store *RoomStore) *Engine {
	return &Engine{
		logger:       logger.Named("[game-engine]"),
		store:        store,
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
	e.emitter = emitter
}

func (e *Engine) OnConnect(gameID, userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
	key := userKey(gameID, userID)
	m, ok := e.byUser[key]
	if !ok || m.over {
		if data, ok := e.finished[key]; ok {
			e.emitter.ToUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
			delete(e.finished, key)
		}
		return
	}
	idx := m.playerIndex(userID)
	if m.disconnected[idx] {
		delete(m.disconnected, idx)
		e.emitter.ToUser(m.GameID, m.players[1-idx].ID, protocol.OutEnvelope{Type: protocol.S2COpponentReconnected})
		if len(m.disconnected) == 0 {
			e.cancelGrace(m)
			if m.pausedRemain > 0 {
				e.armTimerDuration(m, m.pausedRemain)
				m.pausedRemain = 0
			}
		}
	}
	e.sendMatchFoundTo(m, userID, true)
}

func (e *Engine) JoinQueue(gameID string, player protocol.PlayerInfo) {
	e.mu.Lock()
	defer e.mu.Unlock()

	if m, ok := e.byUser[userKey(gameID, player.ID)]; ok && !m.over {
		e.sendMatchFound(m, true)
		return
	}

	gameLogic, err := logic.Get(gameID)
	if err != nil {
		e.sendError(gameID, player.ID, "UNKNOWN_GAME", err.Error())
		return
	}

	queue := e.queues[gameID]
	for _, waiting := range queue {
		if waiting.ID == player.ID {
			e.emitter.ToUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
			return
		}
	}

	if len(queue) == 0 {
		e.queues[gameID] = append(queue, player)
		e.emitter.ToUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
		return
	}

	opponent := queue[0]
	e.queues[gameID] = queue[1:]
	if m, ok := e.byUser[userKey(gameID, opponent.ID)]; ok && !m.over {
		e.queues[gameID] = append(e.queues[gameID], player)
		e.emitter.ToUser(gameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
		return
	}
	e.startMatch(gameID, gameLogic, opponent, player, 0)
}

func (e *Engine) LeaveQueue(gameID string, userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
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
	e.mu.Lock()
	defer e.mu.Unlock()

	if m, ok := e.byUser[userKey(gameID, owner.ID)]; ok && !m.over {
		e.sendMatchFound(m, true)
		return
	}

	if _, err := logic.Get(gameID); err != nil {
		e.sendError(gameID, owner.ID, "UNKNOWN_GAME", err.Error())
		return
	}

	if ref, ok := e.store.RoomByUser(owner.ID); ok {
		if room, ok2 := e.store.Get(ref.GameID, ref.RoomID); ok2 {
			e.emitRoomWaiting(gameID, owner.ID, room)
			return
		}
	}

	room := Room{
		ID:        uuid.NewString(),
		GameID:    gameID,
		OwnerID:   owner.ID,
		OwnerName: owner.Name,
		Bet:       bet,
		Password:  password,
		CreatedAt: time.Now().UnixMilli(),
	}
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, owner.ID, "ROOM_CREATE_FAILED", err.Error())
		return
	}
	e.emitRoomWaiting(gameID, owner.ID, room)
	e.logger.Infow("Room created", "room_id", room.ID, "owner", owner.ID, "bet", bet)
}

func (e *Engine) JoinRoom(gameID string, joiner protocol.PlayerInfo, roomID, password string) {
	e.mu.Lock()
	defer e.mu.Unlock()

	if m, ok := e.byUser[userKey(gameID, joiner.ID)]; ok && !m.over {
		e.sendMatchFound(m, true)
		return
	}

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
	if m, ok := e.byUser[userKey(gameID, room.OwnerID)]; ok && !m.over {
		e.store.Delete(gameID, roomID, room.OwnerID)
		e.sendError(gameID, joiner.ID, "ROOM_NOT_FOUND", "room owner busy")
		return
	}

	gameLogic, err := logic.Get(gameID)
	if err != nil {
		e.sendError(gameID, joiner.ID, "UNKNOWN_GAME", err.Error())
		return
	}

	if !e.store.Claim(roomID) {
		e.sendError(gameID, joiner.ID, "ROOM_NOT_FOUND", "room already taken")
		return
	}
	e.store.Delete(gameID, roomID, room.OwnerID)

	e.startMatch(gameID, gameLogic, protocol.PlayerInfo{ID: room.OwnerID, Name: room.OwnerName}, joiner, room.Bet)
}

func (e *Engine) LeaveRoom(userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
	if ref, ok := e.store.RoomByUser(userID); ok {
		e.store.Delete(ref.GameID, ref.RoomID, userID)
	}
}

func (e *Engine) ListRooms(gameID, userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
	rooms := e.store.List(gameID)
	infos := make([]protocol.RoomInfo, 0, len(rooms))
	for _, r := range rooms {
		infos = append(infos, protocol.RoomInfo{
			ID:      r.ID,
			Owner:   r.OwnerName,
			Bet:     r.Bet,
			Locked:  r.Password != "",
			Players: 1,
		})
	}
	e.emitter.ToUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CRoomList, Data: protocol.RoomListData{Rooms: infos}})
}

func (e *Engine) emitRoomWaiting(gameID, userID string, room Room) {
	e.emitter.ToUser(gameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CRoomWaiting,
		Data: protocol.RoomWaitingData{RoomID: room.ID, Bet: room.Bet, Locked: room.Password != ""},
	})
}

func (e *Engine) OnDisconnect(gameID, userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()

	e.leaveQueueLocked(gameID, userID)

	if ref, ok := e.store.RoomByUser(userID); ok {
		e.store.Delete(ref.GameID, ref.RoomID, userID)
	}

	m, ok := e.byUser[userKey(gameID, userID)]
	if !ok || m.over {
		return
	}
	idx := m.playerIndex(userID)
	if m.disconnected[idx] {
		return
	}
	if m.disconnected == nil {
		m.disconnected = make(map[int]bool)
	}
	first := len(m.disconnected) == 0
	m.disconnected[idx] = true

	if m.turnIdx == idx && m.pausedRemain == 0 {
		if m.timer != nil {
			m.timer.Stop()
		}
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
		e.emitter.ToUser(m.GameID, m.players[oppIdx].ID, protocol.OutEnvelope{
			Type: protocol.S2COpponentDisconnected,
			Data: protocol.OpponentDisconnectedData{GraceDeadline: m.graceDeadline.UnixMilli()},
		})
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
	e.mu.Lock()
	defer e.mu.Unlock()
	m, ok := e.matches[matchID]
	if !ok || m.over || m.graceGen != gen {
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
	e.mu.Lock()
	defer e.mu.Unlock()

	m, ok := e.byUser[userKey(gameID, userID)]
	if !ok || m.over {
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
	e.armTimer(m)

	data := protocol.StateData{
		MatchID:  m.ID,
		State:    m.state,
		Turn:     m.turnIdx,
		Deadline: m.deadline.UnixMilli(),
		LastMove: move,
		LastBy:   playerIdx,
	}
	for _, p := range m.players {
		e.emitter.ToUser(m.GameID, p.ID, protocol.OutEnvelope{Type: protocol.S2CState, Data: data})
	}
}

func (e *Engine) Forfeit(gameID, userID, matchID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
	m, ok := e.byUser[userKey(gameID, userID)]
	if !ok || m.over {
		return
	}
	if matchID != "" && matchID != m.ID {
		return
	}
	winnerIdx := 1 - m.playerIndex(userID)
	e.finishMatch(m, m.players[winnerIdx].ID, "forfeit")
}

func (e *Engine) startMatch(gameID string, gameLogic logic.GameLogic, p0, p1 protocol.PlayerInfo, bet int) {
	for _, p := range []protocol.PlayerInfo{p0, p1} {
		e.leaveQueueLocked(gameID, p.ID)
		if ref, ok := e.store.RoomByUser(p.ID); ok {
			e.store.Delete(ref.GameID, ref.RoomID, p.ID)
		}
		delete(e.finished, userKey(gameID, p.ID))
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
	}
	e.matches[m.ID] = m
	e.byUser[userKey(gameID, p0.ID)] = m
	e.byUser[userKey(gameID, p1.ID)] = m
	e.armTimer(m)
	e.sendMatchFound(m, false)
	e.logger.Infow("Match started", "match_id", m.ID, "game_id", gameID, "p0", p0.ID, "p1", p1.ID)
}

func (e *Engine) sendMatchFound(m *Match, resumed bool) {
	for _, p := range m.players {
		e.sendMatchFoundTo(m, p.ID, resumed)
	}
}

func (e *Engine) sendMatchFoundTo(m *Match, userID string, resumed bool) {
	e.emitter.ToUser(m.GameID, userID, protocol.OutEnvelope{
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

func (e *Engine) armTimer(m *Match) {
	e.armTimerDuration(m, time.Duration(e.turnSeconds)*time.Second)
}

func (e *Engine) armTimerDuration(m *Match, d time.Duration) {
	if m.timer != nil {
		m.timer.Stop()
	}
	m.deadline = time.Now().Add(d)
	matchID := m.ID
	turnAtArm := m.turnIdx
	m.timer = time.AfterFunc(time.Until(m.deadline), func() {
		e.onTimeout(matchID, turnAtArm)
	})
}

func (e *Engine) onTimeout(matchID string, expectedTurn int) {
	e.mu.Lock()
	defer e.mu.Unlock()
	m, ok := e.matches[matchID]
	if !ok || m.over || m.turnIdx != expectedTurn {
		return
	}
	winnerIdx := 1 - m.turnIdx
	e.finishMatch(m, m.players[winnerIdx].ID, "timeout")
}

func (e *Engine) finishMatch(m *Match, winnerID string, reason string) {
	m.over = true
	if m.timer != nil {
		m.timer.Stop()
	}
	if m.graceTimer != nil {
		m.graceTimer.Stop()
	}
	data := protocol.MatchOverData{
		MatchID:  m.ID,
		WinnerID: winnerID,
		Reason:   reason,
		State:    m.state,
		Bet:      m.bet,
	}
	for _, p := range m.players {
		e.emitter.ToUser(m.GameID, p.ID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
		key := userKey(m.GameID, p.ID)
		delete(e.byUser, key)
		e.finished[key] = data
		e.scheduleFinishedCleanup(key)
	}
	delete(e.matches, m.ID)
	e.logger.Infow("Match finished", "match_id", m.ID, "winner", winnerID, "reason", reason)
}

func (e *Engine) scheduleFinishedCleanup(key string) {
	time.AfterFunc(finishedResultTTL, func() {
		e.mu.Lock()
		delete(e.finished, key)
		e.mu.Unlock()
	})
}

func (e *Engine) sendError(gameID, userID string, code string, message string) {
	e.emitter.ToUser(gameID, userID, protocol.OutEnvelope{
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
