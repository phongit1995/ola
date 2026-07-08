package admin

import (
	adminauth "ola-chat-server/internal/modules/admin/auth"
	adminegg "ola-chat-server/internal/modules/admin/egg"
	adminken "ola-chat-server/internal/modules/admin/ken"
	adminkenchest "ola-chat-server/internal/modules/admin/kenchest"
	adminme "ola-chat-server/internal/modules/admin/me"
	adminpen "ola-chat-server/internal/modules/admin/pen"
	adminroom "ola-chat-server/internal/modules/admin/room"
	adminupload "ola-chat-server/internal/modules/admin/upload"
	adminuser "ola-chat-server/internal/modules/admin/user"
	adminvip "ola-chat-server/internal/modules/admin/vip"
	adminwheel "ola-chat-server/internal/modules/admin/wheel"
	"ola-chat-server/internal/utils"
)

type Router struct {
	authRouter   *adminauth.Router
	userRouter   *adminuser.Router
	meRouter     *adminme.Router
	roomRouter   *adminroom.Router
	uploadRouter *adminupload.Router
	vipRouter    *adminvip.Router
	eggRouter      *adminegg.Router
	wheelRouter    *adminwheel.Router
	kenRouter      *adminken.Router
	kenChestRouter *adminkenchest.Router
	penRouter      *adminpen.Router
}

func NewRouter(authRouter *adminauth.Router, userRouter *adminuser.Router, meRouter *adminme.Router, roomRouter *adminroom.Router, uploadRouter *adminupload.Router, vipRouter *adminvip.Router, eggRouter *adminegg.Router, wheelRouter *adminwheel.Router, kenRouter *adminken.Router, kenChestRouter *adminkenchest.Router, penRouter *adminpen.Router) *Router {
	return &Router{authRouter: authRouter, userRouter: userRouter, meRouter: meRouter, roomRouter: roomRouter, uploadRouter: uploadRouter, vipRouter: vipRouter, eggRouter: eggRouter, wheelRouter: wheelRouter, kenRouter: kenRouter, kenChestRouter: kenChestRouter, penRouter: penRouter}
}

func (r *Router) Setup(api *utils.AppGroup) {
	admin := api.Group("/admin")
	{
		r.authRouter.Setup(admin)
		r.userRouter.Setup(admin)
		r.meRouter.Setup(admin)
		r.roomRouter.Setup(admin)
		r.uploadRouter.Setup(admin)
		r.vipRouter.Setup(admin)
		r.eggRouter.Setup(admin)
		r.wheelRouter.Setup(admin)
		r.kenRouter.Setup(admin)
		r.kenChestRouter.Setup(admin)
		r.penRouter.Setup(admin)
	}
}
