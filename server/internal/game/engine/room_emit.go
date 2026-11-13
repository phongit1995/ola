package engine

import (
	"ola-chat-server/internal/game/protocol"
)

func listsPlayingRooms(gameID string) bool {
	return playingRoomGames[gameID]
}

func roomInfo(room Room) protocol.RoomInfo {
	players := room.playerCount()
	return protocol.RoomInfo{
		ID:              room.ID,
		Owner:           room.OwnerName,
		OwnerVipType:    room.OwnerVipType,
		Bet:             room.Bet,
		Locked:          room.Password != "",
		Players:         players,
		MaxPlayers:      room.capacity(),
		Full:            players >= room.capacity(),
		AllowSpectators: cloneBool(room.AllowSpectators),
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
	matchID := e.matchIDForRoom(room.ID)
	if matchID == "" {
		return
	}
	info := roomInfo(room)
	info.Status = protocol.RoomStatusPlaying
	info.MatchID = matchID
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
		Data: protocol.RoomWaitingData{RoomID: room.ID, Bet: room.Bet, Locked: room.Password != "", MaxPlayers: room.capacity(), AllowSpectators: cloneBool(room.AllowSpectators)},
	})
}

func (e *Engine) emitRoomState(room Room) {
	e.emitRoomStateAfterMatch(room, "")
}

func (e *Engine) emitRoomStateAfterMatch(room Room, matchID string) {
	for _, memberID := range room.memberIDs() {
		e.emitRoomStateToAfterMatch(room, memberID, matchID)
	}
	if spectatorsAllowed(&room) {
		state := roomStateData(room, "", matchID)
		state.Watcher = true
		e.toRoomWatchers(room.GameID, room.ID, protocol.OutEnvelope{Type: protocol.S2CRoomState, Data: state})
	}
}

func (e *Engine) emitRoomStateTo(room Room, userID string) {
	e.emitRoomStateToAfterMatch(room, userID, "")
}

func (e *Engine) emitRoomStateToAfterMatch(room Room, userID, matchID string) {
	e.toUser(room.GameID, userID, protocol.OutEnvelope{Type: protocol.S2CRoomState, Data: roomStateData(room, userID, matchID)})
}

func roomStateData(room Room, youID, matchID string) protocol.RoomStateData {
	members := make([]protocol.RoomMember, 0, room.playerCount())
	members = append(members, protocol.RoomMember{
		ID: room.OwnerID, Name: room.OwnerName, VipType: room.OwnerVipType, Level: room.OwnerLevel, Owner: true, Ready: true,
	})
	for _, g := range room.guestList() {
		members = append(members, protocol.RoomMember{
			ID: g.ID, Name: g.Name, VipType: g.VipType, Level: g.Level, Ready: g.Ready,
		})
	}
	return protocol.RoomStateData{
		RoomID: room.ID, OwnerID: room.OwnerID, YouID: youID, Bet: room.Bet,
		Locked: room.Password != "", MaxPlayers: room.capacity(), Members: members, AfterMatchID: matchID,
		AllowSpectators: cloneBool(room.AllowSpectators),
	}
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
	e.toRoomWatchers(room.GameID, room.ID, protocol.OutEnvelope{Type: protocol.S2CRoomClosed, Data: data})
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
	e.toRoomWatchers(room.GameID, room.ID, protocol.OutEnvelope{Type: protocol.S2CRoomClosed, Data: data})
}
