package game

import (
	"context"
	"encoding/json"
	"net/http"
	"strings"
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
	UserID string
	GameID string
	Name   string
	Guest  bool
}

type Server struct {
	io     *socket.Server
	engine *engine.Engine
	repo   *Repository
	logger *zap.SugaredLogger
	connMu sync.Mutex
	conns  map[string]int
}

func userRoom(gameID, userID string) string {
	return "game:" + gameID + ":user:" + userID
}

func lobbyRoom(gameID string) string {
	return "game:" + gameID + ":lobby"
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
		io:     io,
		engine: gameEngine,
		repo:   repo,
		logger: logger.Named("[game-ws]"),
		conns:  make(map[string]int),
	}
	gameEngine.SetEmitter(server)

	io.Use(func(s *socket.Socket, next func(*socket.ExtendedError)) {
		auth := s.Handshake().Auth

		token, _ := auth["token"].(string)
		if token == "" {
			next(socket.NewExtendedError("access_token is required", nil))
			return
		}

		gameID, _ := auth["gameId"].(string)
		if _, err := logic.Get(gameID); err != nil {
			next(socket.NewExtendedError("unknown gameId", nil))
			return
		}

		var userID string
		var name string
		var guest bool

		if cfg.GameAllowGuest && strings.HasPrefix(token, "guest:") {
			guest = true
			userID = strings.TrimPrefix(token, "guest:")
			if userID == "" {
				next(socket.NewExtendedError("invalid guest token", nil))
				return
			}
			name, _ = auth["name"].(string)
			if name == "" {
				name = "Guest-" + userID
			}
		} else {
			uid, err := jwtService.GetUserIDFromToken(token)
			if err != nil {
				server.logger.Warnw("Invalid game socket token", "error", err)
				next(socket.NewExtendedError("Unauthorized", nil))
				return
			}
			userID = uid.String()
			name, _ = auth["name"].(string)
			if name == "" {
				name = userID[:8]
			}
		}

		s.SetData(&SocketData{UserID: userID, GameID: gameID, Name: name, Guest: guest})
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
		s.handleMessage(data, args[0])
	})

	client.On("disconnect", func(args ...any) {
		s.connMu.Lock()
		s.conns[key]--
		last := s.conns[key] <= 0
		if last {
			delete(s.conns, key)
		}
		s.connMu.Unlock()
		if last {
			s.engine.OnDisconnect(data.GameID, data.UserID)
		}
		s.logger.Infow("Game socket disconnected", "user_id", data.UserID)
	})
}

func (s *Server) sendUserInfo(client *socket.Socket, data *SocketData) {
	if data.Guest {
		client.Emit(messageEvent, protocol.OutEnvelope{
			Type: protocol.S2CUserInfo,
			Data: protocol.UserInfoData{Username: data.Name, Guest: true},
		})
		return
	}

	info, err := s.repo.GetUserInfo(data.UserID)
	if err != nil {
		s.logger.Warnw("Failed to load user info", "user_id", data.UserID, "error", err)
		client.Emit(messageEvent, protocol.OutEnvelope{
			Type: protocol.S2CError,
			Data: protocol.ErrorData{Code: "USER_INFO_FAILED", Message: "failed to load user info"},
		})
		return
	}

	if info.Username != "" {
		data.Name = info.Username
	}
	client.Emit(messageEvent, protocol.OutEnvelope{Type: protocol.S2CUserInfo, Data: *info})
}

func (s *Server) handleMessage(data *SocketData, raw any) {
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
		s.engine.JoinQueue(data.GameID, protocol.PlayerInfo{ID: data.UserID, Name: data.Name})
	case protocol.C2SQueueLeave:
		s.engine.LeaveQueue(data.GameID, data.UserID)
	case protocol.C2SMove:
		var d protocol.MoveCommand
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.Move(data.GameID, data.UserID, d.MatchID, d.Move)
	case protocol.C2SForfeit:
		var d protocol.ForfeitData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.Forfeit(data.GameID, data.UserID, d.MatchID)
	case protocol.C2SRoomCreate:
		var d protocol.RoomCreateData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.CreateRoom(data.GameID, protocol.PlayerInfo{ID: data.UserID, Name: data.Name}, d.Bet, d.Password)
	case protocol.C2SRoomJoin:
		var d protocol.RoomJoinData
		if err := json.Unmarshal(env.Data, &d); err != nil {
			return
		}
		s.engine.JoinRoom(data.GameID, protocol.PlayerInfo{ID: data.UserID, Name: data.Name}, d.RoomID, d.Password)
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
	default:
		s.logger.Debugw("Unknown game message type", "type", env.Type, "user_id", data.UserID)
	}
}

func (s *Server) ToUser(gameID string, userID string, envelope protocol.OutEnvelope) {
	s.io.To(socket.Room(userRoom(gameID, userID))).Emit(messageEvent, envelope)
}

func (s *Server) ToGame(gameID string, envelope protocol.OutEnvelope) {
	s.io.To(socket.Room(lobbyRoom(gameID))).Emit(messageEvent, envelope)
}

func (s *Server) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	s.io.ServeHandler(nil).ServeHTTP(w, r)
}

func (s *Server) Close() {
	s.io.Close(nil)
}
