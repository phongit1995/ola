package engine

import (
	"fmt"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
)

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
