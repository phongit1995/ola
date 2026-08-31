package main

import (
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/modules/admin"
	"ola-chat-server/internal/modules/announcement"
	"ola-chat-server/internal/modules/auth"
	"ola-chat-server/internal/modules/call"
	chatbot "ola-chat-server/internal/modules/chat-bot"
	"ola-chat-server/internal/modules/clan"
	"ola-chat-server/internal/modules/conversation"
	"ola-chat-server/internal/modules/egg"
	"ola-chat-server/internal/modules/health"
	"ola-chat-server/internal/modules/ken"
	"ola-chat-server/internal/modules/kenchest"
	"ola-chat-server/internal/modules/marriage"
	marriagediary "ola-chat-server/internal/modules/marriage-diary"
	"ola-chat-server/internal/modules/me"
	"ola-chat-server/internal/modules/message"
	minigame "ola-chat-server/internal/modules/mini-game"
	"ola-chat-server/internal/modules/notification"
	"ola-chat-server/internal/modules/pen"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/room"
	"ola-chat-server/internal/modules/session"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/modules/topup"
	"ola-chat-server/internal/modules/user"
	usersetting "ola-chat-server/internal/modules/user-setting"
	"ola-chat-server/internal/modules/vip"
	"ola-chat-server/internal/modules/wheel"
	"ola-chat-server/internal/transport/websocket"
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
	userSettingRouter *usersetting.Router,
	relationshipsRouter *relationships.Router,
	conversationRouter *conversation.Router,
	messageRouter *message.Router,
	callRouter *call.Router,
	roomRouter *room.Router,
	roomService *room.Service,
	settingRouter *setting.Router,
	meRouter *me.Router,
	clanRouter *clan.Router,
	sessionRouter *session.Router,
	vipRouter *vip.Router,
	kenRouter *ken.Router,
	eggRouter *egg.Router,
	wheelRouter *wheel.Router,
	kenChestRouter *kenchest.Router,
	marriageRouter *marriage.Router,
	marriageDiaryRouter *marriagediary.Router,
	penRouter *pen.Router,
	miniGameRouter *minigame.Router,
	announcementRouter *announcement.Router,
	chatBotRouter *chatbot.Router,
	topupRouter *topup.Router,
	notificationRouter *notification.Router,
	wsServer *websocket.Server,
	apiGuard *middleware.ApiGuardMiddleware,
	cfg *config.Config,
) *Server {
	wsServer.SetRoomHandler(roomService)

	r := gin.Default()

	r.Use(cors.New(cors.Config{
		AllowOrigins:     cfg.CORSAllowedOrigins,
		AllowMethods:     []string{"GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"*", "Authorization"},
		ExposeHeaders:    []string{"*"},
		AllowCredentials: false,
		MaxAge:           12 * 3600,
	}))

	if cfg.Env != gin.ReleaseMode {
		r.GET("/swagger", func(c *gin.Context) {
			c.Redirect(301, "/swagger/index.html")
		})

		r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler,
			ginSwagger.URL("/swagger/doc.json"),
			ginSwagger.DefaultModelsExpandDepth(-1)))
	}

	r.Any("/socket.io/*any", func(c *gin.Context) {
		wsServer.ServeHTTP(c.Writer, c.Request)
	})

	apiGroup := r.Group("/api/v1")
	api := utils.NewAppGroup(apiGroup)
	api.Use(apiGuard.Verify())
	{
		healthRouter.Setup(api)
		authRouter.Setup(api)
		adminRouter.Setup(api)
		userRouter.Setup(api)
		userSettingRouter.Setup(api)
		settingRouter.Setup(api)
		relationshipsRouter.Setup(api)
		conversationRouter.Setup(api)
		messageRouter.Setup(api)
		callRouter.Setup(api)
		roomRouter.Setup(api)
		meRouter.Setup(api)
		clanRouter.Setup(api)
		sessionRouter.Setup(api)
		vipRouter.Setup(api)
		kenRouter.Setup(api)
		eggRouter.Setup(api)
		wheelRouter.Setup(api)
		kenChestRouter.Setup(api)
		marriageRouter.Setup(api)
		marriageDiaryRouter.Setup(api)
		penRouter.Setup(api)
		miniGameRouter.Setup(api)
		announcementRouter.Setup(api)
		chatBotRouter.Setup(api)
		notificationRouter.Setup(api)
		topupRouter.Setup(api)
	}

	r.NoRoute(func(c *gin.Context) {
		utils.RespondError(c, 404, "route not found")
	})

	return &Server{Router: r}
}
