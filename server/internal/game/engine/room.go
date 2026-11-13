package engine

import (
	"sort"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"github.com/google/uuid"
)

func (e *Engine) CreateRoom(gameID string, owner protocol.PlayerInfo, bet int, password string, maxPlayers int) {
	e.CreateRoomWithSpectators(gameID, owner, bet, password, maxPlayers, nil)
}

func (e *Engine) CreateRoomWithSpectators(gameID string, owner protocol.PlayerInfo, bet int, password string, maxPlayers int, allowSpectators *bool) {
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
	if bet < 0 || bet > MaxBetFor(maxPlayers) {
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
		ID:              uuid.NewString(),
		GameID:          gameID,
		OwnerID:         owner.ID,
		OwnerName:       owner.Name,
		OwnerVipType:    owner.VipType,
		OwnerLevel:      owner.Level,
		MaxPlayers:      maxPlayers,
		Bet:             bet,
		Password:        password,
		AllowSpectators: cloneBool(allowSpectators),
		CreatedAt:       time.Now().UnixMilli(),
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

func prepareNextRound(room Room, winnerID string) Room {
	room.normalize()
	room.LastWinnerID = ""
	if room.hasMember(winnerID) {
		room.LastWinnerID = winnerID
	}
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
	if room.LastWinnerID == removedID {
		room.LastWinnerID = ""
	}
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
	cloned.SeatOrder = append([]string(nil), cloned.SeatOrder...)
	return &cloned
}
