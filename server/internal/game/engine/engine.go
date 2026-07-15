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
	mu          sync.Mutex
	logger      *zap.SugaredLogger
	emitter     Emitter
	queues      map[string][]protocol.PlayerInfo
	matches     map[string]*Match
	byUser      map[string]*Match
	turnSeconds int
}

type Match struct {
	ID       string
	GameID   string
	logic    logic.GameLogic
	players  []protocol.PlayerInfo
	state    any
	turnIdx  int
	deadline time.Time
	timer    *time.Timer
	over     bool
}

func NewEngine(logger *zap.SugaredLogger, turnSeconds int) *Engine {
	return &Engine{
		logger:      logger.Named("[game-engine]"),
		queues:      make(map[string][]protocol.PlayerInfo),
		matches:     make(map[string]*Match),
		byUser:      make(map[string]*Match),
		turnSeconds: turnSeconds,
	}
}

func (e *Engine) SetEmitter(emitter Emitter) {
	e.emitter = emitter
}

func (e *Engine) OnConnect(userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
	if m, ok := e.byUser[userID]; ok && !m.over {
		e.sendMatchFound(m, true)
	}
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
	e.startMatch(gameID, gameLogic, opponent, player)
}

func (e *Engine) LeaveQueue(gameID string, userID string) {
	e.mu.Lock()
	defer e.mu.Unlock()
	queue := e.queues[gameID]
	for i, waiting := range queue {
		if waiting.ID == userID {
			e.queues[gameID] = append(queue[:i], queue[i+1:]...)
			return
		}
	}
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

func (e *Engine) startMatch(gameID string, gameLogic logic.GameLogic, p0, p1 protocol.PlayerInfo) {
	m := &Match{
		ID:      uuid.NewString(),
		GameID:  gameID,
		logic:   gameLogic,
		players: []protocol.PlayerInfo{p0, p1},
		state:   gameLogic.Init(time.Now().UnixNano()),
		turnIdx: 0,
	}
	e.matches[m.ID] = m
	e.byUser[p0.ID] = m
	e.byUser[p1.ID] = m
	e.armTimer(m)
	e.sendMatchFound(m, false)
	e.logger.Infow("Match started", "match_id", m.ID, "game_id", gameID, "p0", p0.ID, "p1", p1.ID)
}

func (e *Engine) sendMatchFound(m *Match, resumed bool) {
	for idx, p := range m.players {
		e.emitter.ToUser(p.ID, protocol.OutEnvelope{
			Type: protocol.S2CMatchFound,
			Data: protocol.MatchFoundData{
				MatchID:  m.ID,
				GameID:   m.GameID,
				Players:  m.players,
				You:      idx,
				State:    m.state,
				Turn:     m.turnIdx,
				Deadline: m.deadline.UnixMilli(),
				Resumed:  resumed,
			},
		})
	}
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
	data := protocol.MatchOverData{
		MatchID:  m.ID,
		WinnerID: winnerID,
		Reason:   reason,
		State:    m.state,
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
