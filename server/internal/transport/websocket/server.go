package websocket

import (
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
	"context"
	"fmt"
	"net/http"

	"github.com/redis/go-redis/v9"
	redisClient "github.com/zishang520/socket.io/adapters/redis/v3"
	"github.com/zishang520/socket.io/adapters/redis/v3/adapter"
	socket "github.com/zishang520/socket.io/servers/socket/v3"
	"github.com/zishang520/socket.io/v3/pkg/types"
	"go.uber.org/zap"
)

type RoomSocketService interface {
	RoomEnabled(roomID string) (bool, error)
}

type Server struct {
	io              *socket.Server
	jwtService      *services.JWTService
	redisAdapter    *RedisAdapter
	presenceService *PresenceService
	roomPresence    *RoomPresenceService
	roomSvc         RoomSocketService
	logger          *zap.SugaredLogger
	redisClient     *redis.Client
}

type SocketData struct {
	UserID      string
	JoinedRooms map[string]bool
}

func NewServer(
	cfg *config.Config,
	jwtService *services.JWTService,
	redisAdapter *RedisAdapter,
	presenceService *PresenceService,
	roomPresence *RoomPresenceService,
	convMembers ConversationMembersGetter,
	logger *zap.SugaredLogger,
) (*Server, error) {
	rdb := redisAdapter.GetClient()

	wrappedRedisClient := redisClient.NewRedisClient(context.Background(), rdb)

	opts := socket.DefaultServerOptions()
	opts.SetCors(&types.Cors{
		Origin:      cfg.CORSAllowedOrigins,
		Credentials: true,
	})
	opts.SetAdapter(&adapter.RedisAdapterBuilder{
		Redis: wrappedRedisClient,
		Opts:  adapter.DefaultRedisAdapterOptions(),
	})

	io := socket.NewServer(nil, opts)

	server := &Server{
		io:              io,
		jwtService:      jwtService,
		redisAdapter:    redisAdapter,
		presenceService: presenceService,
		roomPresence:    roomPresence,
		logger:          logger.Named("[websocket]"),
		redisClient:     rdb,
	}

	io.Use(func(s *socket.Socket, next func(*socket.ExtendedError)) {
		auth := s.Handshake().Auth
		tokenValue, exists := auth["token"]
		if !exists {
			req := s.Request()
			if tokenQuery, ok := req.Query().Get("token"); ok {
				tokenValue = tokenQuery
			}
		}

		if tokenValue == nil || tokenValue == "" {
			server.logger.Warn("WebSocket connection without token")
			next(socket.NewExtendedError("access_token is required", nil))
			return
		}

		token := ""
		switch v := tokenValue.(type) {
		case string:
			token = v
		default:
			server.logger.Warnw("Invalid token type", "type", fmt.Sprintf("%T", tokenValue))
			next(socket.NewExtendedError("invalid token format", nil))
			return
		}

		userID, err := jwtService.GetUserIDFromToken(token)
		if err != nil {
			server.logger.Warnw("Invalid WebSocket token", "error", err)
			next(socket.NewExtendedError("Unauthorized", nil))
			return
		}

		data := &SocketData{UserID: userID.String(), JoinedRooms: make(map[string]bool)}
		s.SetData(data)

		server.logger.Infow("WebSocket authenticated", "user_id", userID)
		next(nil)
	})

	eventHandler := NewEventHandler(server, presenceService, convMembers)
	eventHandler.RegisterEvents()

	logger.Info("✅ WebSocket server initialized with Socket.IO v3 + Redis Adapter + Presence Tracking")
	return server, nil
}

func (s *Server) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	s.io.ServeHandler(nil).ServeHTTP(w, r)
}

func (s *Server) Close() {
	s.io.Close(nil)
	s.redisAdapter.Close()
}

func (s *Server) EmitToUser(userID string, event string, data any) {
	room := "user:" + userID
	s.io.To(socket.Room(room)).Emit(event, data)
	s.logger.Debugw("📤 Emitted WebSocket event to user",
		"user_id", userID,
		"event", event,
		"room", room,
	)
}

func (s *Server) EmitToUsers(userIDs []string, event string, data any) {
	s.logger.Infow("📤 Emitting WebSocket event to multiple users",
		"event", event,
		"user_count", len(userIDs),
		"user_ids", userIDs,
	)

	for _, userID := range userIDs {
		s.EmitToUser(userID, event, data)
	}

	s.logger.Infow("✅ WebSocket emit completed",
		"event", event,
		"total_users", len(userIDs),
	)
}

func (s *Server) GetPresenceService() *PresenceService {
	return s.presenceService
}

func (s *Server) GetRoomPresence() *RoomPresenceService {
	return s.roomPresence
}

func (s *Server) SetRoomHandler(svc RoomSocketService) {
	s.roomSvc = svc
}

const broadcastRoom = socket.Room("broadcast:online")

func roomChannel(roomID string) socket.Room {
	return socket.Room("room:" + roomID)
}

func (s *Server) BroadcastToAll(eventType string, data any) {
	wrapped := utils.WrapWebSocketMessage(eventType, data)
	s.io.To(broadcastRoom).Emit(constants.WebSocketMessageEvent, wrapped)
	s.logger.Infow("📡 Broadcast to all online", "event", eventType)
}

func (s *Server) EmitToRoom(roomID string, eventType string, data any) {
	wrapped := utils.WrapWebSocketMessage(eventType, data)
	s.io.To(roomChannel(roomID)).Emit(constants.WebSocketMessageEvent, wrapped)
	s.logger.Debugw("📤 Emitted to room", "room_id", roomID, "event", eventType)
}
