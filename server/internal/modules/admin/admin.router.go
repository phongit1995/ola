package admin

import (
	adminaudit "ola-chat-server/internal/modules/admin/audit"
	adminauth "ola-chat-server/internal/modules/admin/auth"
	adminclan "ola-chat-server/internal/modules/admin/clan"
	admindashboard "ola-chat-server/internal/modules/admin/dashboard"
	adminegg "ola-chat-server/internal/modules/admin/egg"
	admingamematch "ola-chat-server/internal/modules/admin/game-match"
	adminken "ola-chat-server/internal/modules/admin/ken"
	adminkenchest "ola-chat-server/internal/modules/admin/kenchest"
	adminmarriage "ola-chat-server/internal/modules/admin/marriage"
	adminme "ola-chat-server/internal/modules/admin/me"
	adminminigame "ola-chat-server/internal/modules/admin/mini-game"
	adminpen "ola-chat-server/internal/modules/admin/pen"
	adminrelationship "ola-chat-server/internal/modules/admin/relationship"
	adminroom "ola-chat-server/internal/modules/admin/room"
	adminsetting "ola-chat-server/internal/modules/admin/setting"
	adminupload "ola-chat-server/internal/modules/admin/upload"
	adminuser "ola-chat-server/internal/modules/admin/user"
	adminvip "ola-chat-server/internal/modules/admin/vip"
	adminwheel "ola-chat-server/internal/modules/admin/wheel"
	"ola-chat-server/internal/utils"
)

type Router struct {
	auditMiddleware    *adminaudit.Middleware
	auditRouter        *adminaudit.Router
	dashboardRouter    *admindashboard.Router
	authRouter         *adminauth.Router
	userRouter         *adminuser.Router
	meRouter           *adminme.Router
	roomRouter         *adminroom.Router
	clanRouter         *adminclan.Router
	uploadRouter       *adminupload.Router
	vipRouter          *adminvip.Router
	eggRouter          *adminegg.Router
	wheelRouter        *adminwheel.Router
	kenRouter          *adminken.Router
	kenChestRouter     *adminkenchest.Router
	penRouter          *adminpen.Router
	gameMatchRouter    *admingamematch.Router
	marriageRouter     *adminmarriage.Router
	relationshipRouter *adminrelationship.Router
	settingRouter      *adminsetting.Router
	miniGameRouter     *adminminigame.Router
}

func NewRouter(auditMiddleware *adminaudit.Middleware, auditRouter *adminaudit.Router, dashboardRouter *admindashboard.Router, authRouter *adminauth.Router, userRouter *adminuser.Router, meRouter *adminme.Router, roomRouter *adminroom.Router, clanRouter *adminclan.Router, uploadRouter *adminupload.Router, vipRouter *adminvip.Router, eggRouter *adminegg.Router, wheelRouter *adminwheel.Router, kenRouter *adminken.Router, kenChestRouter *adminkenchest.Router, penRouter *adminpen.Router, gameMatchRouter *admingamematch.Router, marriageRouter *adminmarriage.Router, relationshipRouter *adminrelationship.Router, settingRouter *adminsetting.Router, miniGameRouter *adminminigame.Router) *Router {
	return &Router{auditMiddleware: auditMiddleware, auditRouter: auditRouter, dashboardRouter: dashboardRouter, authRouter: authRouter, userRouter: userRouter, meRouter: meRouter, roomRouter: roomRouter, clanRouter: clanRouter, uploadRouter: uploadRouter, vipRouter: vipRouter, eggRouter: eggRouter, wheelRouter: wheelRouter, kenRouter: kenRouter, kenChestRouter: kenChestRouter, penRouter: penRouter, gameMatchRouter: gameMatchRouter, marriageRouter: marriageRouter, relationshipRouter: relationshipRouter, settingRouter: settingRouter, miniGameRouter: miniGameRouter}
}

func (r *Router) Setup(api *utils.AppGroup) {
	admin := api.Group("/admin", r.auditMiddleware.Record())
	{
		r.auditRouter.Setup(admin)
		r.dashboardRouter.Setup(admin)
		r.authRouter.Setup(admin)
		r.userRouter.Setup(admin)
		r.meRouter.Setup(admin)
		r.roomRouter.Setup(admin)
		r.clanRouter.Setup(admin)
		r.uploadRouter.Setup(admin)
		r.vipRouter.Setup(admin)
		r.eggRouter.Setup(admin)
		r.wheelRouter.Setup(admin)
		r.kenRouter.Setup(admin)
		r.kenChestRouter.Setup(admin)
		r.penRouter.Setup(admin)
		r.gameMatchRouter.Setup(admin)
		r.marriageRouter.Setup(admin)
		r.relationshipRouter.Setup(admin)
		r.settingRouter.Setup(admin)
		r.miniGameRouter.Setup(admin)
	}
}
