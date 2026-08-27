package game

import (
	"context"
	"encoding/json"
	"net/http"
	"sync"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/game/engine"
	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/services"

	redisClient "github.com/zishang520/socket.io/adapters/redis/v3"
	"github.com/zishang520/socket.io/adapters/redis/v3/adapter"
	socket "github.com/zishang520/socket.io/servers/socket/v3"
	"github.com/zishang520/socket.io/v3/pkg/types"
	"go.uber.org/zap"
)

const messageEvent = "message"

type SocketData struct {
	UserID  string
	GameID  string
	Name    string
	VipType *string
	Level   int
}

func (d *SocketData) Key() string {
	return userRoom(d.GameID, d.UserID)
}

type Server struct {
	io     *socket.Server
	engine *engine.Engine
	repo   *Repository
	logger *zap.SugaredLogger
	connMu sync.Mutex
	conns  map[string]int
	// spectating tracks the match each socket is watching so disconnects release the seat.
	spectating map[socket.SocketId]string
}

func userRoom(gameID, userID string) string {
	return "game:" + gameID + ":user:" + userID
}

func lobbyRoom(gameID string) string {
	return "game:" + gameID + ":lobby"
}

func matchRoom(gameID, matchID string) string {
	return "game:" + gameID + ":match:" + matchID
}

func NewServer(
	cfg *config.Config,
	jwtService *services.JWTService,
	gameEngine *engine.Engine,
	repo *Repository,
	cache *services.CacheService,
	logger *zap.SugaredLogger,
) (*Server, error) {
	opts := socket.DefaultServerOptions()
	opts.SetCors(&types.Cors{
		Origin:      cfg.CORSAllowedOrigins,
		Credentials: true,
	})

	adapterOpts := adapter.DefaultRedisAdapterOptions()
	adapterOpts.SetKey(cfg.GameWebSocketRedisPrefix)
	opts.SetAdapter(&adapter.RedisAdapterBuilder{
		Redis: redisClient.NewRedisClient(context.Background(), cache.GetClient()),
		Opts:  adapterOpts,
	})

	io := socket.NewServer(nil, opts)

	server := &Server{
		io:         io,
		engine:     gameEngine,
		repo:       repo,
		logger:     logger.Named("[game-ws]"),
		conns:      make(map[string]int),
		spectating: make(map[socket.SocketId]string),
	}
	gameEngine.SetEmitter(server)

	io.Use(func(s *socket.Socket, next func(*socket.ExtendedError)) {
		auth := s.Handshake().Auth

		token, _ := auth["token"].(string)
		if token == "" {
			next(socket.NewExtendedError("access_token is required", map[string]string{"code": "AUTH_REQUIRED"}))
			return
		}

		gameID, _ := auth["gameId"].(string)
		if _, err := logic.Get(gameID); err != nil {
			next(socket.NewExtendedError("unknown gameId", nil))
			return
		}

		uid, err := jwtService.GetUserIDFromToken(token)
		if err != nil {
			server.logger.Warnw("Invalid game socket token", "error", err)
			next(socket.NewExtendedError("Unauthorized", map[string]string{"code": "AUTH_EXPIRED"}))
			return
		}
		userID := uid.String()
		name, _ := auth["name"].(string)
		if name == "" {
			name = userID[:8]
		}

		s.SetData(&SocketData{UserID: userID, GameID: gameID, Name: name})
		next(nil)
	})

	io.On("connection", func(clients ...any) {
		client := clients[0].(*socket.Socket)
		server.handleConnection(client)
	})

	logger.Infow("✅ Game WebSocket server initialized with Redis Adapter",
		"redis_prefix", cfg.GameWebSocketRedisPrefix,
	)
	return server, nil
}

func (s *Server) handleConnection(client *socket.Socket) {
	data := client.Data().(*SocketData)
	client.Join(socket.Room(userRoom(data.GameID, data.UserID)))
	client.Join(socket.Room(lobbyRoom(data.GameID)))

	s.logger.Infow("Game socket connected",
		"user_id", data.UserID,
		"game_id", data.GameID,
		"socket_id", client.Id())

	key := userRoom(data.GameID, data.UserID)
	s.connMu.Lock()
	s.conns[key]++
	s.connMu.Unlock()

	s.sendUserInfo(client, data)
	s.engine.OnConnect(data.GameID, data.UserID)

	client.On(messageEvent, func(args ...any) {
		if len(args) == 0 {
			return
		}
		s.handleMessage(client, data, args[0])
	})

	client.On("disconnect", func(args ...any) {
		s.connMu.Lock()
		s.conns[key]--
		last := s.conns[key] <= 0
		if last {
			delete(s.conns, key)
		}
		watching := s.spectating[client.Id()]
		delete(s.spectating, client.Id())
		s.connMu.Unlock()
		if watching != "" {
			s.engine.SpectateLeave(data.GameID, watching, string(client.Id()), nil)
		}
		if last {
			s.engine.OnDisconnect(data.GameID, data.UserID)
		}
		s.logger.Infow("Game socket disconnected", "user_id", data.UserID)
	})
}

func (s *Server) sendUserInfo(client *socket.Socket, data *SocketData) {
	info, err := s.repo.GetUserInfo(data.GameID, data.UserID)
	if err != nil {
		s.logger.Warnw("Failed to load user info", "user_id", data.UserID, "error", err)
		client.Emit(messageEvent, protocol.OutEnvelope{
			Type: protocol.S2CError,
			Data: protocol.ErrorData{Code: protocol.ErrorCodeUserInfoFailed, Message: "failed to load user info"},
		})
		return
	}

	if info.Username != "" {
		data.Name = info.Username
	}
	data.VipType = info.VipType
	data.Level = info.Level
	client.Emit(messageEvent, protocol.OutEnvelope{Type: protocol.S2CUserInfo, Data: *info})
}

// socketPlayer refreshes the level on every use: exp changes after each
// settlement, so the value cached at connect time goes stale within a session.
func (s *Server) socketPlayer(data *SocketData) protocol.PlayerInfo {
	if level, ok := s.repo.CurrentLevel(data.GameID, data.UserID); ok {
		data.Level = level
	}
	return socketPlayer(data)
}

func socketPlayer(data *SocketData) protocol.PlayerInfo {
	return protocol.PlayerInfo{
		ID:      data.UserID,
		Name:    data.Name,
		VipType: data.VipType,
		Level:   data.Level,
	}
}

func socketDeliver(client *socket.Socket) engine.Deliver {
	return func(envelope protocol.OutEnvelope) {
		client.Emit(messageEvent, envelope)
	}
}

func (s *Server) spectateJoin(client *socket.Socket, data *SocketData, matchID string) {
	s.connMu.Lock()
	previous := s.spectating[client.Id()]
	s.connMu.Unlock()

	client.Join(socket.Room(matchRoom(data.GameID, matchID)))
	if !s.engine.SpectateJoin(data.GameID, data.UserID, matchID, string(client.Id()), socketDeliver(client)) {
		if previous != matchID {
			client.Leave(socket.Room(matchRoom(data.GameID, matchID)))
		}
		return
	}
	s.connMu.Lock()
	s.spectating[client.Id()] = matchID
	s.connMu.Unlock()
	if previous != "" && previous != matchID {
		client.Leave(socket.Room(matchRoom(data.GameID, previous)))
		s.engine.SpectateLeave(data.GameID, previous, string(client.Id()), nil)
	}
}

func (s *Server) spectateLeave(client *socket.Socket, data *SocketData, matchID string, notify bool) {
	s.connMu.Lock()
	watching := s.spectating[client.Id()]
	if watching == "" || (matchID != "" && matchID != watching) {
		s.connMu.Unlock()
		return
	}
	delete(s.spectating, client.Id())
	s.connMu.Unlock()
	client.Leave(socket.Room(matchRoom(data.GameID, watching)))
	var deliver engine.Deliver
	if notify {
		deliver = socketDeliver(client)
	}
	s.engine.SpectateLeave(data.GameID, watching, string(client.Id()), deliver)
}

func (s *Server) handleMessage(client *socket.Socket, data *SocketData, raw any) {
	payload, err := json.Marshal(raw)
	if err != nil {
		return
	}
	var env protocol.Envelope
	if err := json.Unmarshal(payload, &env); err != nil {
		return
	}

	switch env.Type {
	case protocol.C2SQueueJoin:
		s.engine.JoinQueue(data.GameID, s.socketPlayer(data))
	case protocol.C2SQueueLeave:
		s.engine.LeaveQueue(data.GameID, data.UserID)
	case protocol.C2SMove:
		var d protocol.MoveCommand
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.Move(data.GameID, data.UserID, d.MatchID, d.Move)
	case protocol.C2SChatSend:
		var d protocol.ChatSendData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		if d.RoomID != "" {
			s.engine.RoomChat(data.GameID, data.UserID, d.RoomID, d.Text)
		} else {
			s.engine.Chat(data.GameID, data.UserID, d.MatchID, d.Text)
		}
	case protocol.C2SReactionSend:
		var d protocol.ReactionSendData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.MatchReaction(data.GameID, data.UserID, d.MatchID, d.Type)
	case protocol.C2SForfeit:
		var d protocol.ForfeitData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		if d.LeaveAfter {
			s.engine.ForfeitAndLeave(data.GameID, data.UserID, d.MatchID)
		} else {
			s.engine.Forfeit(data.GameID, data.UserID, d.MatchID)
		}
	case protocol.C2SRoomCreate:
		var d protocol.RoomCreateData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.CreateRoom(data.GameID, s.socketPlayer(data), d.Bet, d.Password, d.MaxPlayers)
	case protocol.C2SRoomJoin:
		var d protocol.RoomJoinData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.JoinRoom(data.GameID, s.socketPlayer(data), d.RoomID, d.Password)
	case protocol.C2SRoomLeave:
		var d protocol.RoomActionData
		if len(env.Data) > 0 {
			if err := json.Unmarshal(env.Data, &d); err != nil {
				return
			}
		}
		s.engine.LeaveRoom(data.GameID, data.UserID, d.RoomID)
	case protocol.C2SRoomKick:
		var d protocol.RoomKickData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.KickRoomMember(data.GameID, data.UserID, d.RoomID, d.UserID)
	case protocol.C2SRoomReady:
		var d protocol.RoomReadyData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.SetRoomReady(data.GameID, data.UserID, d.RoomID, d.Ready)
	case protocol.C2SRoomStart:
		var d protocol.RoomActionData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.StartRoom(data.GameID, data.UserID, d.RoomID)
	case protocol.C2SRoomList:
		s.engine.ListRooms(data.GameID, data.UserID)
	case protocol.C2SLeaderboard:
		var d protocol.LeaderboardRequestData
		if len(env.Data) > 0 {
			if err := json.Unmarshal(env.Data, &d); err != nil {
				return
			}
		}
		s.sendLeaderboard(data.GameID, data.UserID, d.Period)
	case protocol.C2SHistory:
		s.sendMatchHistory(data.GameID, data.UserID)
	case protocol.C2SSpectateList:
		s.engine.SpectateList(data.GameID, data.UserID)
	case protocol.C2SSpectateJoin:
		var d protocol.SpectateJoinData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.spectateJoin(client, data, d.MatchID)
	case protocol.C2SSpectateLeave:
		var d protocol.SpectateLeaveData
		if len(env.Data) > 0 {
			if err := json.Unmarshal(env.Data, &d); err != nil {
				return
			}
		}
		s.spectateLeave(client, data, d.MatchID, true)
	default:
		s.logger.Debugw("Unknown game message type", "type", env.Type, "user_id", data.UserID)
	}
}

func (s *Server) sendMatchHistory(gameID, userID string) {
	data, err := s.repo.MatchHistory(gameID, userID)
	if err != nil {
		s.logger.Errorw("Failed to load game history", "game_id", gameID, "user_id", userID, "error", err)
		data.Error = "Không thể tải lịch sử đấu"
	}
	s.ToUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CHistory, Data: data})
}

func (s *Server) sendLeaderboard(gameID, userID, period string) {
	data, err := s.repo.Leaderboard(gameID, period)
	if err != nil {
		s.logger.Errorw("Failed to load game leaderboard", "game_id", gameID, "period", period, "error", err)
		data.Error = "Không thể tải bảng xếp hạng"
	}
	s.ToUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CLeaderboard, Data: data})
}

func (s *Server) ToUser(gameID string, userID string, envelope protocol.OutEnvelope) {
	s.io.To(socket.Room(userRoom(gameID, userID))).Emit(messageEvent, envelope)
}

func (s *Server) ToGame(gameID string, envelope protocol.OutEnvelope) {
	s.io.To(socket.Room(lobbyRoom(gameID))).Emit(messageEvent, envelope)
}

func (s *Server) ToMatch(gameID string, matchID string, envelope protocol.OutEnvelope) {
	s.io.To(socket.Room(matchRoom(gameID, matchID))).Emit(messageEvent, envelope)
}

func (s *Server) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	s.io.ServeHandler(nil).ServeHTTP(w, r)
}

func (s *Server) Close() {
	s.io.Close(nil)
}
