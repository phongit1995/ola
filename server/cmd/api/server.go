package main

import (
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/modules/admin"
	"ola-chat-server/internal/modules/auth"
	"ola-chat-server/internal/modules/call"
	"ola-chat-server/internal/modules/conversation"
	"ola-chat-server/internal/modules/health"
	"ola-chat-server/internal/modules/message"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/room"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/utils"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"

	_ "ola-chat-server/cmd/api/docs"
)

type Server struct {
	Router *gin.Engine
}

func CreateServer(
	authRouter *auth.Router,
	adminRouter *admin.Router,
	healthRouter *health.Router,
	userRouter *user.Router,
	relationshipsRouter *relationships.Router,
	conversationRouter *conversation.Router,
	messageRouter *message.Router,
	callRouter *call.Router,
	roomRouter *room.Router,
	roomService *room.Service,
	wsServer *websocket.Server,
	cfg *config.Config,
) *Server {
	wsServer.SetRoomHandler(roomService)

	r := gin.Default()

	r.Use(cors.New(cors.Config{
		AllowOrigins:     cfg.CORSAllowedOrigins,
		AllowMethods:     []string{"GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Accept", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * 3600,
	}))

	r.GET("/swagger", func(c *gin.Context) {
		c.Redirect(301, "/swagger/index.html")
	})

	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler,
		ginSwagger.URL("/swagger/doc.json"),
		ginSwagger.DefaultModelsExpandDepth(-1)))

	r.Any("/socket.io/*any", func(c *gin.Context) {
		wsServer.ServeHTTP(c.Writer, c.Request)
	})

	apiGroup := r.Group("/api/v1")
	api := utils.NewAppGroup(apiGroup)
	{
		healthRouter.Setup(api)
		authRouter.Setup(api)
		adminRouter.Setup(api)
		userRouter.Setup(api)
		relationshipsRouter.Setup(api)
		conversationRouter.Setup(api)
		messageRouter.Setup(api)
		callRouter.Setup(api)
		roomRouter.Setup(api)
	}

	r.NoRoute(func(c *gin.Context) {
		utils.RespondError(c, 404, "route not found")
	})

	return &Server{Router: r}
}
