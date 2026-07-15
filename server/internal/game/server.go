package game

import (
	"encoding/json"
	"net/http"
	"strings"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/game/engine"
	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/services"

	socket "github.com/zishang520/socket.io/servers/socket/v3"
	"github.com/zishang520/socket.io/v3/pkg/types"
	"go.uber.org/zap"
)

const messageEvent = "message"

type SocketData struct {
	UserID string
	GameID string
	Name   string
}

type Server struct {
	io     *socket.Server
	engine *engine.Engine
	logger *zap.SugaredLogger
}

func NewServer(
	cfg *config.Config,
	jwtService *services.JWTService,
	gameEngine *engine.Engine,
	logger *zap.SugaredLogger,
) (*Server, error) {
	opts := socket.DefaultServerOptions()
	opts.SetCors(&types.Cors{
		Origin:      cfg.CORSAllowedOrigins,
		Credentials: true,
	})

	io := socket.NewServer(nil, opts)

	server := &Server{
		io:     io,
		engine: gameEngine,
		logger: logger.Named("[game-ws]"),
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

		if cfg.GameAllowGuest && strings.HasPrefix(token, "guest:") {
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

		s.SetData(&SocketData{UserID: userID, GameID: gameID, Name: name})
		next(nil)
	})

	io.On("connection", func(clients ...any) {
		client := clients[0].(*socket.Socket)
		server.handleConnection(client)
	})

	logger.Info("✅ Game WebSocket server initialized")
	return server, nil
}

func (s *Server) handleConnection(client *socket.Socket) {
	data := client.Data().(*SocketData)
	client.Join(socket.Room("user:" + data.UserID))

	s.logger.Infow("Game socket connected",
		"user_id", data.UserID,
		"game_id", data.GameID,
		"socket_id", client.Id())

	s.engine.OnConnect(data.UserID)

	client.On(messageEvent, func(args ...any) {
		if len(args) == 0 {
			return
		}
		s.handleMessage(data, args[0])
	})

	client.On("disconnect", func(args ...any) {
		s.engine.LeaveQueue(data.GameID, data.UserID)
		s.logger.Infow("Game socket disconnected", "user_id", data.UserID)
	})
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
		s.engine.Move(data.UserID, env.Data)
	case protocol.C2SForfeit:
		s.engine.Forfeit(data.UserID)
	default:
		s.logger.Debugw("Unknown game message type", "type", env.Type, "user_id", data.UserID)
	}
}

func (s *Server) ToUser(userID string, envelope protocol.OutEnvelope) {
	s.io.To(socket.Room("user:" + userID)).Emit(messageEvent, envelope)
}

func (s *Server) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	s.io.ServeHandler(nil).ServeHTTP(w, r)
}

func (s *Server) Close() {
	s.io.Close(nil)
}
