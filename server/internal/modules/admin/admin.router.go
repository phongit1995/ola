package admin

import (
	adminauth "ola-chat-server/internal/modules/admin/auth"
	adminme "ola-chat-server/internal/modules/admin/me"
	adminroom "ola-chat-server/internal/modules/admin/room"
	adminupload "ola-chat-server/internal/modules/admin/upload"
	adminuser "ola-chat-server/internal/modules/admin/user"
	"ola-chat-server/internal/utils"
)

type Router struct {
	authRouter   *adminauth.Router
	userRouter   *adminuser.Router
	meRouter     *adminme.Router
	roomRouter   *adminroom.Router
	uploadRouter *adminupload.Router
}

func NewRouter(authRouter *adminauth.Router, userRouter *adminuser.Router, meRouter *adminme.Router, roomRouter *adminroom.Router, uploadRouter *adminupload.Router) *Router {
	return &Router{authRouter: authRouter, userRouter: userRouter, meRouter: meRouter, roomRouter: roomRouter, uploadRouter: uploadRouter}
}

func (r *Router) Setup(api *utils.AppGroup) {
	admin := api.Group("/admin")
	{
		r.authRouter.Setup(admin)
		r.userRouter.Setup(admin)
		r.meRouter.Setup(admin)
		r.roomRouter.Setup(admin)
		r.uploadRouter.Setup(admin)
	}
}
