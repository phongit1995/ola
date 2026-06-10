package admin

import (
	adminauth "ola-chat-server/internal/modules/admin/auth"
	"ola-chat-server/internal/utils"
)

type Router struct {
	authRouter *adminauth.Router
}

func NewRouter(authRouter *adminauth.Router) *Router {
	return &Router{authRouter: authRouter}
}

func (r *Router) Setup(api *utils.AppGroup) {
	admin := api.Group("/admin")
	{
		r.authRouter.Setup(admin)
	}
}
