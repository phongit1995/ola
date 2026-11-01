package engine

import (
	"encoding/json"
	"fmt"
	"slices"
	"strings"
	"testing"

	thirteen "ola-chat-server/internal/game/games/thirteen"
	"ola-chat-server/internal/game/games/tycoon"
	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
)

type inbox struct {
	messages []protocol.OutEnvelope
}

func (b *inbox) deliver(envelope protocol.OutEnvelope) {
	b.messages = append(b.messages, envelope)
}

func (b *inbox) last(t *testing.T, messageType string) protocol.OutEnvelope {
	t.Helper()
	for i := len(b.messages) - 1; i >= 0; i-- {
		if b.messages[i].Type == messageType {
			return b.messages[i]
		}
	}
	t.Fatalf("inbox has no %s: %+v", messageType, b.messages)
	return protocol.OutEnvelope{}
}

func (b *inbox) lastError(t *testing.T) protocol.ErrorData {
	t.Helper()
	return b.last(t, protocol.S2CError).Data.(protocol.ErrorData)
}

func joinAs(gameEngine *Engine, match *Match, userID, socketID string) (*inbox, bool) {
	box := &inbox{}
	ok := gameEngine.SpectateJoin(match.GameID, protocol.PlayerInfo{ID: userID, Name: userID}, match.ID, socketID, box.deliver)
	return box, ok
}

func TestSpectateJoinReceivesSnapshotAndStateUpdates(t *testing.T) {
	gameEngine, activeStore, emitter, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)

	box, ok := joinAs(gameEngine, match, "watcher", "sock-1")
	if !ok {
		t.Fatalf("spectate join failed: %+v", box.lastError(t))
	}
	joined := box.last(t, protocol.S2CSpectateJoined).Data.(protocol.SpectateJoinedData)
	if joined.MatchID != match.ID || len(joined.Players) != 2 || joined.Spectators != 1 {
		t.Fatalf("unexpected SPECTATE_JOINED payload: %+v", joined)
	}
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 1 {
		t.Fatalf("expected 1 spectator, got %d", count)
	}

	gameEngine.Move(match.GameID, match.players[0].ID, match.ID, caroMoveRaw(t, caroPoint{3, 3}))
	states := emitter.matchMessages(match.ID, protocol.S2CState)
	if len(states) != 1 {
		t.Fatalf("expected 1 STATE to match room, got %d", len(states))
	}
	state := states[0].Data.(protocol.StateData)
	if state.Turn != 1 || state.LastBy != 0 {
		t.Fatalf("unexpected STATE for spectators: %+v", state)
	}

	gameEngine.Move(match.GameID, "watcher", match.ID, caroMoveRaw(t, caroPoint{4, 4}))
	envelope, found := emitter.last("watcher", protocol.S2CError)
	if !found || envelope.Data.(protocol.ErrorData).Code != protocol.ErrorCodeNoMatch {
		t.Fatalf("spectator move should be rejected with NO_MATCH, got %+v", envelope)
	}

	gameEngine.SpectateLeave(match.GameID, match.ID, "sock-1", box.deliver)
	box.last(t, protocol.S2CSpectateLeft)
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 0 {
		t.Fatalf("expected 0 spectators after leave, got %d", count)
	}
}

func TestSpectateJoinRejectsPlayersAndFullMatches(t *testing.T) {
	gameEngine, activeStore, _, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)

	if box, ok := joinAs(gameEngine, match, match.players[0].ID, "sock-p0"); ok || box.lastError(t).Code != protocol.ErrorCodeSpectateOwnMatch {
		t.Fatalf("player should get SPECTATE_OWN_MATCH, got %+v", box.messages)
	}
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 0 {
		t.Fatalf("rejected player must not hold a seat, got %d", count)
	}

	missing := &inbox{}
	if gameEngine.SpectateJoin(match.GameID, protocol.PlayerInfo{ID: "watcher", Name: "watcher"}, "missing-match", "sock-x", missing.deliver) {
		t.Fatal("unknown match should be rejected")
	}
	if err := missing.lastError(t); err.Code != protocol.ErrorCodeMatchNotFound {
		t.Fatalf("expected MATCH_NOT_FOUND, got %+v", err)
	}

	for i := 0; i < MaxSpectators; i++ {
		if box, ok := joinAs(gameEngine, match, "same-user", fmt.Sprintf("tab-%d", i)); !ok {
			t.Fatalf("socket %d of the same user should hold its own seat", i)
		} else if joined := box.last(t, protocol.S2CSpectateJoined).Data.(protocol.SpectateJoinedData); joined.Spectators != 1 {
			t.Fatalf("tabs of one account count as one viewer, got %d", joined.Spectators)
		}
	}
	if box, ok := joinAs(gameEngine, match, "watcher-overflow", "sock-overflow"); ok || box.lastError(t).Code != protocol.ErrorCodeSpectateFull {
		t.Fatalf("expected SPECTATE_FULL, got %+v", box.messages)
	}
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 1 {
		t.Fatalf("one account with many tabs is one viewer, got %d", count)
	}
	gameEngine.SpectateLeave(match.GameID, match.ID, "tab-0", nil)
	if _, ok := joinAs(gameEngine, match, "watcher-after", "sock-after"); !ok {
		t.Fatal("leaving one tab must free a seat")
	}
	if box, ok := joinAs(gameEngine, match, "watcher-late", "sock-late"); ok || box.lastError(t).Code != protocol.ErrorCodeSpectateFull {
		t.Fatalf("leaving one tab must free exactly one seat, got %+v", box.messages)
	}
}

func TestSpectateJoinRejectsFinishedMatch(t *testing.T) {
	gameEngine, activeStore, _, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)

	gameEngine.Forfeit(match.GameID, match.players[1].ID, match.ID)
	if box, ok := joinAs(gameEngine, match, "late", "sock-late"); ok || box.lastError(t).Code != protocol.ErrorCodeMatchNotFound {
		t.Fatalf("finished match must reject spectators, got %+v", box.messages)
	}
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 0 {
		t.Fatalf("finished match must not keep a spectator set, got %d", count)
	}
}

func startLiveThirteenMatch(t *testing.T, playerCount int) (*Engine, *captureEmitter, *Match) {
	t.Helper()
	for attempt := 0; attempt < 20; attempt++ {
		gameEngine, emitter, match := startThirteenMatch(t, playerCount)
		if match != nil {
			return gameEngine, emitter, match
		}
		stopEngineTimers(gameEngine)
	}
	t.Fatal("every deal ended in an instant win")
	return nil, nil, nil
}

func spectatorThirteenView(t *testing.T, label string, state any) thirteen.PlayerView {
	t.Helper()
	view, ok := state.(thirteen.PlayerView)
	if !ok {
		t.Fatalf("%s: spectators must receive a projected view, got %T", label, state)
	}
	if view.You != thirteen.SpectatorSeat || len(view.YourHand) != 0 {
		t.Fatalf("%s: spectator view leaks a seat or a hand: %+v", label, view)
	}
	raw, err := json.Marshal(state)
	if err != nil {
		t.Fatal(err)
	}
	if strings.Contains(string(raw), `"hands"`) || strings.Contains(string(raw), `"rng"`) {
		t.Fatalf("%s: spectator payload leaks private fields: %s", label, raw)
	}
	return view
}

func TestSpectateHiddenInformationNeedsSpectatorView(t *testing.T) {
	if !spectatable(thirteen.Logic{}) {
		t.Fatal("tien len exposes a spectator view and should be watchable")
	}
	if spectatable(tycoon.Logic{}) {
		t.Fatal("a hidden-information game without a spectator view must stay unwatchable")
	}
}

func TestThirteenSpectatorNeverSeesHands(t *testing.T) {
	gameEngine, emitter, match := startLiveThirteenMatch(t, 4)
	defer stopEngineTimers(gameEngine)
	forcedThirteenState(t, gameEngine, match, [][]int{{0, 4, 8}, {1, 5, 9}, {2, 6, 10}, {3, 7, 11}}, 0)

	box, ok := joinAs(gameEngine, match, "watcher", "sock-1")
	if !ok {
		t.Fatalf("spectate join failed: %+v", box.lastError(t))
	}
	joined := box.last(t, protocol.S2CSpectateJoined).Data.(protocol.SpectateJoinedData)
	view := spectatorThirteenView(t, "SPECTATE_JOINED", joined.State)
	if !slices.Equal(view.HandCounts, []int{3, 3, 3, 3}) {
		t.Fatalf("spectators should see every hand size, got %v", view.HandCounts)
	}

	gameEngine.Move(match.GameID, match.players[0].ID, match.ID, tienLenMoveRaw(t, "play", 0))
	states := emitter.matchMessages(match.ID, protocol.S2CState)
	if len(states) == 0 {
		t.Fatal("spectators did not receive the STATE after a play")
	}
	moved := spectatorThirteenView(t, "STATE", states[len(states)-1].Data.(protocol.StateData).State)
	if moved.HandCounts[0] != 2 || moved.Table == nil || moved.Table.By != 0 {
		t.Fatalf("spectator STATE should show the play publicly: %+v", moved)
	}
}

func TestThirteenSpectateFromStoredSnapshotIsProjected(t *testing.T) {
	gameEngine, _, match := startLiveThirteenMatch(t, 2)
	defer stopEngineTimers(gameEngine)
	gameEngine.mu.Lock()
	delete(gameEngine.matches, match.ID)
	gameEngine.mu.Unlock()

	box, ok := joinAs(gameEngine, match, "watcher", "sock-1")
	if !ok {
		t.Fatalf("spectate join from the stored snapshot failed: %+v", box.lastError(t))
	}
	joined := box.last(t, protocol.S2CSpectateJoined).Data.(protocol.SpectateJoinedData)
	view := spectatorThirteenView(t, "snapshot SPECTATE_JOINED", joined.State)
	if len(view.HandCounts) != 2 {
		t.Fatalf("expected two hand counts, got %v", view.HandCounts)
	}
}

func TestSpectateRejectsPrivateRooms(t *testing.T) {
	gameEngine, activeStore, emitter, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)
	match.mu.Lock()
	match.room = &Room{ID: "room-private", GameID: match.GameID, OwnerID: match.players[0].ID, Password: "secret"}
	if err := gameEngine.persistMatch(match); err != nil {
		match.mu.Unlock()
		t.Fatalf("persist private room: %v", err)
	}
	match.mu.Unlock()

	if box, ok := joinAs(gameEngine, match, "watcher", "sock-1"); ok || box.lastError(t).Code != protocol.ErrorCodeSpectateNotAllowed {
		t.Fatalf("expected SPECTATE_NOT_ALLOWED, got %+v", box.messages)
	}
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 0 {
		t.Fatalf("a rejected spectator must not hold a seat, got %d", count)
	}
	gameEngine.SpectateList(match.GameID, "lurker")
	envelope, found := emitter.last("lurker", protocol.S2CSpectateList)
	if !found || len(envelope.Data.(protocol.SpectateListData).Matches) != 0 {
		t.Fatalf("private rooms must not be listed for spectating: %+v", envelope)
	}
}

func TestSpectateListAndMatchOverCleanup(t *testing.T) {
	gameEngine, activeStore, emitter, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)

	joinAs(gameEngine, match, "watcher", "sock-1")
	gameEngine.SpectateList(match.GameID, "lurker")
	envelope, ok := emitter.last("lurker", protocol.S2CSpectateList)
	if !ok {
		t.Fatal("lurker did not receive SPECTATE_LIST")
	}
	list := envelope.Data.(protocol.SpectateListData)
	if len(list.Matches) != 1 || list.Matches[0].MatchID != match.ID || list.Matches[0].Spectators != 1 {
		t.Fatalf("unexpected SPECTATE_LIST: %+v", list)
	}

	gameEngine.Forfeit(match.GameID, match.players[1].ID, match.ID)
	if !match.over {
		t.Fatal("forfeit did not finish the match")
	}
	overs := emitter.matchMessages(match.ID, protocol.S2CMatchOver)
	if len(overs) != 1 {
		t.Fatalf("expected 1 MATCH_OVER to match room, got %d", len(overs))
	}
	over := overs[0].Data.(protocol.MatchOverData)
	if over.WinnerID != match.players[0].ID || over.Payout != 0 || over.KenDelta != 0 {
		t.Fatalf("spectator MATCH_OVER should carry no money fields: %+v", over)
	}
	lefts := emitter.matchMessages(match.ID, protocol.S2CSpectateLeft)
	if len(lefts) != 1 || lefts[0].Data.(protocol.SpectateLeftData).Reason != protocol.SpectateLeftReasonMatchOver {
		t.Fatalf("expected SPECTATE_LEFT match_over, got %+v", lefts)
	}
	if count, _ := activeStore.SpectatorCount(match.GameID, match.ID); count != 0 {
		t.Fatalf("spectators were not cleared, got %d", count)
	}
}

func spectatorNames(envelope protocol.OutEnvelope, found bool) []string {
	if !found {
		return nil
	}
	data := envelope.Data.(protocol.SpectatorsData)
	names := make([]string, 0, len(data.Spectators))
	for _, viewer := range data.Spectators {
		names = append(names, viewer.Name)
	}
	return names
}

func TestSpectatorListReachesPlayersAndViewers(t *testing.T) {
	gameEngine, emitter, match := startLiveThirteenMatch(t, 4)
	defer stopEngineTimers(gameEngine)
	player := match.players[0].ID

	joinAs(gameEngine, match, "lan", "sock-lan")
	joinAs(gameEngine, match, "minh", "sock-minh-1")
	joinAs(gameEngine, match, "minh", "sock-minh-2")

	if names := spectatorNames(emitter.last(player, protocol.S2CSpectators)); !slices.Equal(names, []string{"lan", "minh"}) {
		t.Fatalf("players should see each viewer once in join order, got %v", names)
	}
	views := emitter.matchMessages(match.ID, protocol.S2CSpectators)
	if len(views) != 3 {
		t.Fatalf("every join should refresh the viewers' list, got %d", len(views))
	}
	if names := spectatorNames(views[len(views)-1], true); !slices.Equal(names, []string{"lan", "minh"}) {
		t.Fatalf("viewers should see the same list, got %v", names)
	}

	gameEngine.SpectateLeave(match.GameID, match.ID, "sock-lan", nil)
	if names := spectatorNames(emitter.last(player, protocol.S2CSpectators)); !slices.Equal(names, []string{"minh"}) {
		t.Fatalf("a leaving viewer should drop off the list, got %v", names)
	}

	gameEngine.OnConnect(match.GameID, match.players[1].ID)
	if names := spectatorNames(emitter.last(match.players[1].ID, protocol.S2CSpectators)); !slices.Equal(names, []string{"minh"}) {
		t.Fatalf("a reconnecting player should get the current viewers, got %v", names)
	}
}

func TestSpectatorListStopsAfterMatchOver(t *testing.T) {
	gameEngine, _, emitter, match := startCaroIntegrationMatch(t)
	defer stopEngineTimers(gameEngine)

	joinAs(gameEngine, match, "watcher", "sock-1")
	gameEngine.Forfeit(match.GameID, match.players[1].ID, match.ID)
	before := len(emitter.matchMessages(match.ID, protocol.S2CSpectators))
	gameEngine.SpectateLeave(match.GameID, match.ID, "sock-1", nil)
	if after := len(emitter.matchMessages(match.ID, protocol.S2CSpectators)); after != before {
		t.Fatalf("leaving a finished match must not broadcast a viewers list, got %d new", after-before)
	}
}

func startThirteenRoomMatch(t *testing.T) (*Engine, *memoryRoomStore, *captureEmitter, Room, *Match) {
	t.Helper()
	for attempt := 0; attempt < 20; attempt++ {
		gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
		room := thirteenRoom("tl-room", "tl-b")
		if err := rooms.Save(room); err != nil {
			t.Fatal(err)
		}
		gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)
		if match := onlyMatch(t, gameEngine); match != nil {
			return gameEngine, rooms, emitter, room, match
		}
		stopEngineTimers(gameEngine)
	}
	t.Fatal("every deal ended in an instant win")
	return nil, nil, nil, Room{}, nil
}

func roomClosedFor(box *inbox) (protocol.RoomClosedData, bool) {
	for i := len(box.messages) - 1; i >= 0; i-- {
		if box.messages[i].Type == protocol.S2CRoomClosed {
			return box.messages[i].Data.(protocol.RoomClosedData), true
		}
	}
	return protocol.RoomClosedData{}, false
}

func TestThirteenPlayingRoomIsListedForWatching(t *testing.T) {
	gameEngine, _, emitter, room, match := startThirteenRoomMatch(t)
	defer stopEngineTimers(gameEngine)

	envelope, found := emitter.last("", protocol.S2CRoomUpsert)
	if !found {
		t.Fatal("starting a Tien Len room must keep it in the lobby list")
	}
	info := envelope.Data.(protocol.RoomUpsertData).Room
	if info.ID != room.ID || info.Status != protocol.RoomStatusPlaying || info.MatchID != match.ID {
		t.Fatalf("lobby should see the room as playing with its match id, got %+v", info)
	}
}

func TestRoomWatcherFollowsTheTableBetweenMatches(t *testing.T) {
	gameEngine, _, emitter, room, match := startThirteenRoomMatch(t)
	defer stopEngineTimers(gameEngine)

	watcher := &inbox{}
	if !gameEngine.WatchRoom(room.GameID, "watcher", room.ID, watcher.deliver) {
		t.Fatalf("a public room in play should be watchable, got %+v", watcher.messages)
	}
	player := &inbox{}
	if gameEngine.WatchRoom(room.GameID, "tl-b", room.ID, player.deliver) {
		t.Fatal("a player cannot watch their own room")
	}
	if closed, ok := roomClosedFor(player); !ok || closed.Reason != roomUnavailableReason {
		t.Fatalf("a refused watch should read as an unavailable room, got %+v", player.messages)
	}

	winner := match.playerIndex("tl-b")
	hands := make([][]int, 2)
	hands[winner] = []int{4}
	hands[1-winner] = []int{5, 9}
	forcedThirteenState(t, gameEngine, match, hands, winner)
	gameEngine.Move(match.GameID, "tl-b", match.ID, tienLenMoveRaw(t, "play", 4))

	states := emitter.roomWatcherMessages(room.ID, protocol.S2CRoomState)
	if len(states) == 0 {
		t.Fatal("watchers did not get the waiting room after the match")
	}
	state := states[len(states)-1].Data.(protocol.RoomStateData)
	if !state.Watcher || state.YouID != "" || len(state.Members) != 2 || state.AfterMatchID != match.ID {
		t.Fatalf("unexpected waiting room for watchers: %+v", state)
	}

	gameEngine.RoomChat(room.GameID, room.OwnerID, room.ID, "ván nữa nhé")
	if chats := emitter.roomWatcherMessages(room.ID, protocol.S2CChatMessage); len(chats) != 1 {
		t.Fatalf("watchers should read the room chat, got %d messages", len(chats))
	}

	late := &inbox{}
	if !gameEngine.WatchRoom(room.GameID, "late", room.ID, late.deliver) {
		t.Fatalf("a waiting public room should be watchable, got %+v", late.messages)
	}
	if waiting := late.last(t, protocol.S2CRoomState).Data.(protocol.RoomStateData); !waiting.Watcher || len(waiting.Members) != 2 {
		t.Fatalf("a late watcher should get the room at once, got %+v", waiting)
	}

	gameEngine.LeaveRoom(room.GameID, room.OwnerID, room.ID)
	if closes := emitter.roomWatcherMessages(room.ID, protocol.S2CRoomClosed); len(closes) == 0 {
		t.Fatal("watchers were not told that the room closed")
	}
}

func TestRoomWatchRefusesPrivateAndMissingRooms(t *testing.T) {
	gameEngine, rooms, _ := newPersistenceTestEngine(newMemoryActiveMatchStore())
	defer stopEngineTimers(gameEngine)
	private := thirteenRoom("tl-private", "tl-b")
	private.Password = "secret"
	if err := rooms.Save(private); err != nil {
		t.Fatal(err)
	}

	for _, roomID := range []string{private.ID, "tl-missing"} {
		box := &inbox{}
		if gameEngine.WatchRoom(thirteen.GameID, "watcher", roomID, box.deliver) {
			t.Fatalf("room %s must not be watchable", roomID)
		}
		if closed, ok := roomClosedFor(box); !ok || closed.RoomID != roomID {
			t.Fatalf("room %s should read as closed, got %+v", roomID, box.messages)
		}
	}
}

func TestThirteenSpectatorMatchOverKeepsHandsHidden(t *testing.T) {
	gameEngine, emitter, match := startLiveThirteenMatch(t, 2)
	defer stopEngineTimers(gameEngine)
	joinAs(gameEngine, match, "watcher", "sock-1")

	winner := 0
	forcedThirteenState(t, gameEngine, match, [][]int{{4}, {5, 9, 13}}, winner)
	gameEngine.Move(match.GameID, match.players[winner].ID, match.ID, tienLenMoveRaw(t, "play", 4))

	overs := emitter.matchMessages(match.ID, protocol.S2CMatchOver)
	if len(overs) != 1 {
		t.Fatalf("expected one MATCH_OVER for spectators, got %d", len(overs))
	}
	view := spectatorThirteenView(t, "MATCH_OVER", overs[0].Data.(protocol.MatchOverData).State)
	if !slices.Equal(view.HandCounts, []int{0, 3}) {
		t.Fatalf("spectators should only see how many cards are left, got %v", view.HandCounts)
	}
}

const dealtWinTestGameID = "dealt-win-test"

type dealtWinTestLogic struct{ persistenceTestLogic }

func (dealtWinTestLogic) ID() string          { return dealtWinTestGameID }
func (dealtWinTestLogic) Init(seed int64) any { return &persistenceTestState{Winner: 0} }

func init() {
	logic.Register(dealtWinTestLogic{})
}

func TestRoomFinishedAtDealStaysWaitingInLobby(t *testing.T) {
	playingRoomGames[dealtWinTestGameID] = true
	defer delete(playingRoomGames, dealtWinTestGameID)
	gameEngine, rooms, emitter := newPersistenceTestEngine(newMemoryActiveMatchStore())
	defer stopEngineTimers(gameEngine)
	room := Room{ID: "dealt-room", GameID: dealtWinTestGameID, OwnerID: "owner", OwnerName: "owner", MaxPlayers: 2}
	room.Guests = []RoomGuest{{ID: "guest", Name: "guest", Ready: true}}
	room.syncLegacyGuest()
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}

	gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)

	if over, found := emitter.last(room.OwnerID, protocol.S2CMatchOver); !found || over.Data.(protocol.MatchOverData).WinnerID == "" {
		t.Fatalf("the deal itself should have finished the match, got %+v", over)
	}
	if _, waiting := rooms.Get(room.GameID, room.ID); !waiting {
		t.Fatal("the room should be waiting again after a match decided at the deal")
	}
	envelope, found := emitter.last("", protocol.S2CRoomUpsert)
	if !found {
		t.Fatal("the lobby never heard about the room")
	}
	if info := envelope.Data.(protocol.RoomUpsertData).Room; info.Status == protocol.RoomStatusPlaying {
		t.Fatalf("the lobby was left with a playing room that has no match: %+v", info)
	}
}
