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
	store        RoomRepository
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

func NewEngine(logger *zap.SugaredLogger, turnSeconds int, graceSeconds int, store RoomRepository) *Engine {
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
			return
		}
		if ref, ok := e.store.RoomByUser(gameID, userID); ok {
			if room, exists := e.store.Get(gameID, ref.RoomID); exists && room.hasMember(userID) {
				e.emitRoomWaiting(gameID, userID, room)
				e.emitRoomStateTo(room, userID)
			} else {
				_ = e.store.DeleteUserRef(gameID, userID)
			}
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
	if ref, ok := e.store.RoomByUser(gameID, player.ID); ok {
		if room, exists := e.store.Get(gameID, ref.RoomID); exists && room.hasMember(player.ID) {
			e.emitRoomWaiting(gameID, player.ID, room)
			e.emitRoomStateTo(room, player.ID)
			e.sendError(gameID, player.ID, "IN_ROOM", "leave the current room before joining queue")
			return
		}
		_ = e.store.DeleteUserRef(gameID, player.ID)
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
		_ = e.store.DeleteUserRef(gameID, owner.ID)
	}
	e.leaveQueueLocked(gameID, owner.ID)

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
	delete(e.finished, userKey(gameID, owner.ID))
	e.emitRoomWaiting(gameID, owner.ID, room)
	e.emitRoomStateTo(room, owner.ID)
	e.logger.Infow("Room created", "room_id", room.ID, "owner", owner.ID, "bet", bet)
}

func (e *Engine) JoinRoom(gameID string, joiner protocol.PlayerInfo, roomID, password string) {
	e.mu.Lock()
	defer e.mu.Unlock()

	if m, ok := e.byUser[userKey(gameID, joiner.ID)]; ok && !m.over {
		e.sendMatchFound(m, true)
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
		_ = e.store.DeleteUserRef(gameID, joiner.ID)
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
	if m, busy := e.byUser[userKey(gameID, room.OwnerID)]; busy && !m.over {
		_ = e.store.Delete(gameID, room.ID, room.OwnerID, room.GuestID)
		e.emitRoomClosed(room, "owner_busy")
		e.sendError(gameID, joiner.ID, "ROOM_NOT_FOUND", "room owner busy")
		return
	}

	room.GuestID = joiner.ID
	room.GuestName = joiner.Name
	room.GuestReady = false
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, joiner.ID, "ROOM_JOIN_FAILED", err.Error())
		return
	}
	delete(e.finished, userKey(gameID, joiner.ID))
	e.leaveQueueLocked(gameID, joiner.ID)
	e.emitRoomWaiting(gameID, joiner.ID, room)
	e.emitRoomState(room)
}

func (e *Engine) LeaveRoom(gameID, userID, roomID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
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
		_ = e.store.DeleteUserRef(gameID, userID)
		return
	}

	if room.OwnerID == userID {
		_ = e.store.Delete(gameID, room.ID, room.OwnerID, room.GuestID)
		reason := "owner_left"
		if disconnected {
			reason = "owner_disconnected"
		}
		e.emitRoomClosed(room, reason)
		return
	}

	guestID := room.GuestID
	room.GuestID = ""
	room.GuestName = ""
	room.GuestReady = false
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, userID, "ROOM_LEAVE_FAILED", err.Error())
		return
	}
	_ = e.store.DeleteUserRef(gameID, guestID)
	if !disconnected {
		e.emitter.ToUser(gameID, userID, protocol.OutEnvelope{
			Type: protocol.S2CRoomClosed,
			Data: protocol.RoomClosedData{RoomID: room.ID, Reason: "left"},
		})
	}
	e.emitRoomStateTo(room, room.OwnerID)
}

func (e *Engine) SetRoomReady(gameID, userID, roomID string, ready bool) {
	e.mu.Lock()
	defer e.mu.Unlock()

	room, release, ok := e.roomForAction(gameID, userID, roomID)
	if !ok {
		return
	}
	defer release()
	if room.OwnerID == userID {
		room.OwnerReady = ready
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
	e.mu.Lock()
	defer e.mu.Unlock()

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
	room.GuestReady = false
	if err := e.store.Save(room); err != nil {
		e.sendError(gameID, ownerID, "ROOM_UPDATE_FAILED", err.Error())
		return
	}
	_ = e.store.DeleteUserRef(gameID, kickedID)
	e.emitter.ToUser(gameID, kickedID, protocol.OutEnvelope{
		Type: protocol.S2CRoomKicked,
		Data: protocol.RoomKickedData{RoomID: room.ID, ByUserID: ownerID},
	})
	e.emitRoomStateTo(room, ownerID)
}

func (e *Engine) StartRoom(gameID, ownerID, roomID string) {
	e.mu.Lock()
	defer e.mu.Unlock()

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
	if !room.OwnerReady || !room.GuestReady {
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
	e.startMatch(
		gameID,
		gameLogic,
		protocol.PlayerInfo{ID: room.OwnerID, Name: room.OwnerName},
		protocol.PlayerInfo{ID: room.GuestID, Name: room.GuestName},
		room.Bet,
	)
}

func (e *Engine) ListRooms(gameID, userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
	rooms := e.store.List(gameID)
	infos := make([]protocol.RoomInfo, 0, len(rooms))
	for _, r := range rooms {
		players := 1
		if r.GuestID != "" {
			players = 2
		}
		infos = append(infos, protocol.RoomInfo{
			ID:      r.ID,
			Owner:   r.OwnerName,
			Bet:     r.Bet,
			Locked:  r.Password != "",
			Players: players,
			Full:    players == 2,
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

func (e *Engine) emitRoomState(room Room) {
	e.emitRoomStateTo(room, room.OwnerID)
	if room.GuestID != "" {
		e.emitRoomStateTo(room, room.GuestID)
	}
}

func (e *Engine) emitRoomStateTo(room Room, userID string) {
	members := []protocol.RoomMember{{
		ID: room.OwnerID, Name: room.OwnerName, Owner: true, Ready: room.OwnerReady,
	}}
	if room.GuestID != "" {
		members = append(members, protocol.RoomMember{
			ID: room.GuestID, Name: room.GuestName, Ready: room.GuestReady,
		})
	}
	e.emitter.ToUser(room.GameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CRoomState,
		Data: protocol.RoomStateData{
			RoomID: room.ID, OwnerID: room.OwnerID, YouID: userID, Bet: room.Bet,
			Locked: room.Password != "", Members: members,
		},
	})
}

func (e *Engine) emitRoomClosed(room Room, reason string) {
	data := protocol.RoomClosedData{RoomID: room.ID, Reason: reason}
	e.emitter.ToUser(room.GameID, room.OwnerID, protocol.OutEnvelope{Type: protocol.S2CRoomClosed, Data: data})
	if room.GuestID != "" {
		e.emitter.ToUser(room.GameID, room.GuestID, protocol.OutEnvelope{Type: protocol.S2CRoomClosed, Data: data})
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
		_ = e.store.DeleteUserRef(gameID, userID)
		e.sendError(gameID, userID, "ROOM_NOT_FOUND", "room not found")
		return Room{}, nil, false
	}
	return room, release, true
}

func (r Room) hasMember(userID string) bool {
	return r.OwnerID == userID || r.GuestID == userID
}

func (e *Engine) OnDisconnect(gameID, userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()

	e.leaveQueueLocked(gameID, userID)

	if ref, ok := e.store.RoomByUser(gameID, userID); ok {
		e.leaveRoomLocked(gameID, userID, ref.RoomID, true)
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
