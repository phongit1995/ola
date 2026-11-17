package game

import (
	"net"
	"strconv"
	"testing"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/game/engine"
	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/services"

	miniredis "github.com/alicebob/miniredis/v2"
	"github.com/livekit/protocol/auth"
	socket "github.com/zishang520/socket.io/servers/socket/v3"
	"go.uber.org/zap"
)

func TestSocketPlayerCarriesVipType(t *testing.T) {
	vipType := "vip-42"
	data := &SocketData{
		UserID:  "user-id",
		GameID:  "caro",
		Name:    "player",
		VipType: &vipType,
		Level:   7,
	}

	player := socketPlayer(data)
	if player.ID != data.UserID || player.Name != data.Name {
		t.Fatalf("unexpected socket player: %+v", player)
	}
	if player.VipType == nil || *player.VipType != vipType {
		t.Fatalf("socket player lost VIP type: %+v", player)
	}
	if player.Level != data.Level {
		t.Fatalf("socket player lost level: %+v", player)
	}
}

func newVoiceTestServer(t *testing.T, cfg *config.Config) (*Server, *engine.RoomStore) {
	t.Helper()
	redisServer := miniredis.RunT(t)
	host, portValue, err := net.SplitHostPort(redisServer.Addr())
	if err != nil {
		t.Fatal(err)
	}
	port, err := strconv.Atoi(portValue)
	if err != nil {
		t.Fatal(err)
	}
	cache, err := services.NewCacheService(&config.Config{RedisHost: host, RedisPort: port}, zap.NewNop().Sugar())
	if err != nil {
		t.Fatalf("create cache service: %v", err)
	}
	t.Cleanup(func() { _ = cache.Close() })
	rooms := engine.NewRoomStore(cache)
	gameEngine := engine.NewEngine(zap.NewNop().Sugar(), 30, 30, rooms, engine.NewMatchStore(cache))
	return &Server{
		cfg:          cfg,
		engine:       gameEngine,
		logger:       zap.NewNop().Sugar(),
		roomWatching: make(map[socket.SocketId]string),
	}, rooms
}

func voiceGrant(t *testing.T, cfg *config.Config, token string) *auth.VideoGrant {
	t.Helper()
	verifier, err := auth.ParseAPIToken(token)
	if err != nil {
		t.Fatal(err)
	}
	_, grants, err := verifier.Verify(cfg.LiveKitAPISecret)
	if err != nil || grants.Video == nil {
		t.Fatalf("voice token does not verify: %v", err)
	}
	return grants.Video
}

func TestVoiceTokenGrantsMatchTheSeat(t *testing.T) {
	cfg := &config.Config{
		LiveKitURL:       "wss://voice.example",
		LiveKitAPIKey:    "voice-key",
		LiveKitAPISecret: "voice-secret-that-is-long-enough-for-hmac",
	}
	server, rooms := newVoiceTestServer(t, cfg)
	room := engine.Room{
		ID:           "voice-room",
		GameID:       "thirteen",
		OwnerID:      "owner",
		OwnerName:    "owner",
		MaxPlayers:   4,
		Guests:       []engine.RoomGuest{{ID: "guest", Name: "guest"}},
		VoiceEnabled: true,
	}
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}
	server.roomWatching["watcher-socket"] = room.ID
	request := protocol.VoiceTokenRequest{RoomID: room.ID}
	socketData := func(userID string) *SocketData {
		return &SocketData{UserID: userID, GameID: room.GameID, Name: userID}
	}

	owner := server.voiceTokenFor("owner-socket", socketData("owner"), request)
	if owner.Error != "" || !owner.CanSpeak || owner.URL != cfg.LiveKitURL {
		t.Fatalf("owner should get a speaking token, got %+v", owner)
	}
	grant := voiceGrant(t, cfg, owner.Token)
	if grant.Room != "game:thirteen:voice-room" || !grant.GetCanPublish() || !grant.GetCanSubscribe() {
		t.Fatalf("unexpected owner grant %+v", grant)
	}
	if len(grant.CanPublishSources) != 1 || grant.CanPublishSources[0] != "microphone" || grant.GetCanPublishData() {
		t.Fatalf("players may only publish their microphone, got %+v", grant)
	}

	watcher := server.voiceTokenFor("watcher-socket", socketData("watcher"), request)
	if watcher.Error != "" || watcher.CanSpeak {
		t.Fatalf("watcher should get a listen-only token, got %+v", watcher)
	}
	if grant := voiceGrant(t, cfg, watcher.Token); grant.GetCanPublish() || !grant.GetCanSubscribe() {
		t.Fatalf("watcher must not publish, got %+v", grant)
	}

	if outsider := server.voiceTokenFor("other-socket", socketData("outsider"), request); outsider.Error != protocol.ErrorCodeVoiceNotMember || outsider.Token != "" {
		t.Fatalf("outsider must be refused, got %+v", outsider)
	}

	room.VoiceEnabled = false
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}
	if silent := server.voiceTokenFor("owner-socket", socketData("owner"), request); silent.Error != protocol.ErrorCodeVoiceDisabled || silent.Token != "" {
		t.Fatalf("a room without voice must be refused, got %+v", silent)
	}

	server.cfg = &config.Config{}
	if unavailable := server.voiceTokenFor("owner-socket", socketData("owner"), request); unavailable.Error != protocol.ErrorCodeVoiceUnavailable {
		t.Fatalf("missing LiveKit config must read as unavailable, got %+v", unavailable)
	}
}
