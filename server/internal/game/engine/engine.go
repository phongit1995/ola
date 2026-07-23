package engine

import (
	"encoding/json"
	"sync"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Emitter interface {
	ToUser(userID string, envelope protocol.OutEnvelope)
}

type Engine struct {
	mu           sync.Mutex
	logger       *zap.SugaredLogger
	emitter      Emitter
	store        *RoomStore
	queues       map[string][]protocol.PlayerInfo
	matches      map[string]*Match
	byUser       map[string]*Match
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
	graceUser     string
	graceDeadline time.Time
	graceGen      int
}

func NewEngine(logger *zap.SugaredLogger, turnSeconds int, graceSeconds int, store *RoomStore) *Engine {
	return &Engine{
		logger:       logger.Named("[game-engine]"),
		store:        store,
		queues:       make(map[string][]protocol.PlayerInfo),
		matches:      make(map[string]*Match),
		byUser:       make(map[string]*Match),
		turnSeconds:  turnSeconds,
		graceSeconds: graceSeconds,
	}
}

func (e *Engine) SetEmitter(emitter Emitter) {
	e.emitter = emitter
}

func (e *Engine) OnConnect(userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
	m, ok := e.byUser[userID]
	if !ok || m.over {
		return
	}
	if m.graceUser == userID {
		if m.graceTimer != nil {
			m.graceTimer.Stop()
		}
		m.graceGen++
		m.graceUser = ""
		e.armTimer(m)
		oppID := m.players[1-m.playerIndex(userID)].ID
		e.emitter.ToUser(oppID, protocol.OutEnvelope{Type: protocol.S2COpponentReconnected})
	}
	e.sendMatchFoundTo(m, userID, true)
}

func (e *Engine) JoinQueue(gameID string, player protocol.PlayerInfo) {
	e.mu.Lock()
	defer e.mu.Unlock()

	if m, ok := e.byUser[player.ID]; ok && !m.over {
		e.sendMatchFound(m, true)
		return
	}

	gameLogic, err := logic.Get(gameID)
	if err != nil {
		e.sendError(player.ID, "UNKNOWN_GAME", err.Error())
		return
	}

	queue := e.queues[gameID]
	for _, waiting := range queue {
		if waiting.ID == player.ID {
			e.emitter.ToUser(player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
			return
		}
	}

	if len(queue) == 0 {
		e.queues[gameID] = append(queue, player)
		e.emitter.ToUser(player.ID, protocol.OutEnvelope{Type: protocol.S2CQueueWaiting})
		return
	}

	opponent := queue[0]
	e.queues[gameID] = queue[1:]
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

	if m, ok := e.byUser[owner.ID]; ok && !m.over {
		e.sendMatchFound(m, true)
		return
	}

	if _, err := logic.Get(gameID); err != nil {
		e.sendError(owner.ID, "UNKNOWN_GAME", err.Error())
		return
	}

	if ref, ok := e.store.RoomByUser(owner.ID); ok {
		if room, ok2 := e.store.Get(ref.GameID, ref.RoomID); ok2 {
			e.emitRoomWaiting(owner.ID, room)
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
		e.sendError(owner.ID, "ROOM_CREATE_FAILED", err.Error())
		return
	}
	e.emitRoomWaiting(owner.ID, room)
	e.logger.Infow("Room created", "room_id", room.ID, "owner", owner.ID, "bet", bet)
}

func (e *Engine) JoinRoom(gameID string, joiner protocol.PlayerInfo, roomID, password string) {
	e.mu.Lock()
	defer e.mu.Unlock()

	if m, ok := e.byUser[joiner.ID]; ok && !m.over {
		e.sendMatchFound(m, true)
		return
	}

	room, ok := e.store.Get(gameID, roomID)
	if !ok {
		e.sendError(joiner.ID, "ROOM_NOT_FOUND", "room not found")
		return
	}
	if room.OwnerID == joiner.ID {
		e.sendError(joiner.ID, "OWN_ROOM", "cannot join your own room")
		return
	}
	if room.Password != "" && room.Password != password {
		e.sendError(joiner.ID, "WRONG_PASSWORD", "wrong password")
		return
	}

	gameLogic, err := logic.Get(gameID)
	if err != nil {
		e.sendError(joiner.ID, "UNKNOWN_GAME", err.Error())
		return
	}

	if !e.store.Claim(roomID) {
		e.sendError(joiner.ID, "ROOM_NOT_FOUND", "room already taken")
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
	e.emitter.ToUser(userID, protocol.OutEnvelope{Type: protocol.S2CRoomList, Data: protocol.RoomListData{Rooms: infos}})
}

func (e *Engine) emitRoomWaiting(userID string, room Room) {
	e.emitter.ToUser(userID, protocol.OutEnvelope{
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

	m, ok := e.byUser[userID]
	if !ok || m.over || m.graceUser != "" {
		return
	}
	if m.timer != nil {
		m.timer.Stop()
	}
	m.graceUser = userID
	m.graceGen++
	m.graceDeadline = time.Now().Add(time.Duration(e.graceSeconds) * time.Second)
	matchID := m.ID
	gen := m.graceGen
	m.graceTimer = time.AfterFunc(time.Until(m.graceDeadline), func() {
		e.onGraceExpire(matchID, gen)
	})
	oppID := m.players[1-m.playerIndex(userID)].ID
	e.emitter.ToUser(oppID, protocol.OutEnvelope{
		Type: protocol.S2COpponentDisconnected,
		Data: protocol.OpponentDisconnectedData{GraceDeadline: m.graceDeadline.UnixMilli()},
	})
}

func (e *Engine) onGraceExpire(matchID string, gen int) {
	e.mu.Lock()
	defer e.mu.Unlock()
	m, ok := e.matches[matchID]
	if !ok || m.over || m.graceGen != gen {
		return
	}
	winnerIdx := 1 - m.playerIndex(m.graceUser)
	e.finishMatch(m, m.players[winnerIdx].ID, "disconnect")
}

func (e *Engine) Move(userID string, move json.RawMessage) {
	e.mu.Lock()
	defer e.mu.Unlock()

	m, ok := e.byUser[userID]
	if !ok || m.over {
		e.sendError(userID, "NO_MATCH", "no active match")
		return
	}

	playerIdx := m.playerIndex(userID)
	if playerIdx != m.turnIdx {
		e.sendError(userID, "NOT_YOUR_TURN", "not your turn")
		return
	}

	if err := m.logic.ValidateMove(m.state, playerIdx, move); err != nil {
		e.sendError(userID, "INVALID_MOVE", err.Error())
		return
	}

	state, err := m.logic.Apply(m.state, playerIdx, move)
	if err != nil {
		e.sendError(userID, "INVALID_MOVE", err.Error())
		return
	}
	m.state = state

	if over, winnerIdx := m.logic.Result(m.state); over {
		winnerID := ""
		if winnerIdx >= 0 {
			winnerID = m.players[winnerIdx].ID
		}
		e.finishMatch(m, winnerID, "win")
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
		e.emitter.ToUser(p.ID, protocol.OutEnvelope{Type: protocol.S2CState, Data: data})
	}
}

func (e *Engine) Forfeit(userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
	m, ok := e.byUser[userID]
	if !ok || m.over {
		return
	}
	winnerIdx := 1 - m.playerIndex(userID)
	e.finishMatch(m, m.players[winnerIdx].ID, "forfeit")
}

func (e *Engine) startMatch(gameID string, gameLogic logic.GameLogic, p0, p1 protocol.PlayerInfo, bet int) {
	m := &Match{
		ID:      uuid.NewString(),
		GameID:  gameID,
		logic:   gameLogic,
		players: []protocol.PlayerInfo{p0, p1},
		state:   gameLogic.Init(time.Now().UnixNano()),
		turnIdx: 0,
		bet:     bet,
	}
	e.matches[m.ID] = m
	e.byUser[p0.ID] = m
	e.byUser[p1.ID] = m
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
	e.emitter.ToUser(userID, protocol.OutEnvelope{
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
	if m.timer != nil {
		m.timer.Stop()
	}
	m.deadline = time.Now().Add(time.Duration(e.turnSeconds) * time.Second)
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
		e.emitter.ToUser(p.ID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
		delete(e.byUser, p.ID)
	}
	delete(e.matches, m.ID)
	e.logger.Infow("Match finished", "match_id", m.ID, "winner", winnerID, "reason", reason)
}

func (e *Engine) sendError(userID string, code string, message string) {
	e.emitter.ToUser(userID, protocol.OutEnvelope{
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
