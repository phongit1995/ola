package admin

import (
	adminauth "ola-chat-server/internal/modules/admin/auth"
	adminuser "ola-chat-server/internal/modules/admin/user"
	"ola-chat-server/internal/utils"
)

type Router struct {
	authRouter *adminauth.Router
	userRouter *adminuser.Router
}

func NewRouter(authRouter *adminauth.Router, userRouter *adminuser.Router) *Router {
	return &Router{authRouter: authRouter, userRouter: userRouter}
}

func (r *Router) Setup(api *utils.AppGroup) {
	admin := api.Group("/admin")
	{
		r.authRouter.Setup(admin)
		r.userRouter.Setup(admin)
	}
}
