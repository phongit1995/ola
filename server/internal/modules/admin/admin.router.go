package admin

import (
	adminauth "ola-chat-server/internal/modules/admin/auth"
	adminme "ola-chat-server/internal/modules/admin/me"
	adminuser "ola-chat-server/internal/modules/admin/user"
	"ola-chat-server/internal/utils"
)

type Router struct {
	authRouter *adminauth.Router
	userRouter *adminuser.Router
	meRouter   *adminme.Router
}

func NewRouter(authRouter *adminauth.Router, userRouter *adminuser.Router, meRouter *adminme.Router) *Router {
	return &Router{authRouter: authRouter, userRouter: userRouter, meRouter: meRouter}
}

func (r *Router) Setup(api *utils.AppGroup) {
	admin := api.Group("/admin")
	{
		r.authRouter.Setup(admin)
		r.userRouter.Setup(admin)
		r.meRouter.Setup(admin)
	}
}
