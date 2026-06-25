package user

import (
	"time"

	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"

	"github.com/go-redis/redis_rate/v10"
)

type Router struct {
	controller     *Controller
	authMiddleware *middleware.AuthMiddleware
	rateLimit      *middleware.RateLimitMiddleware
}

func NewRouter(controller *Controller, authMiddleware *middleware.AuthMiddleware, rateLimit *middleware.RateLimitMiddleware) *Router {
	return &Router{
		controller:     controller,
		authMiddleware: authMiddleware,
		rateLimit:      rateLimit,
	}
}

func (r *Router) Setup(api *utils.AppGroup) {
	user := api.Group("/user", r.authMiddleware.RequireAuth())
	{
		user.GET("/me", r.controller.GetProfile)
		user.PUT("/me", r.controller.UpdateProfile)
		user.GET("/me/visitors", r.controller.GetMyVisitors)
		user.POST("/upload", r.controller.Upload)
		user.POST("/presence", r.controller.GetPresenceBatch)
		user.GET("/search", r.controller.SearchUsers)
		user.GET("/:id", r.controller.GetUserInfo)
		user.POST("/:id/kiss", r.rateLimit.Limit("kiss", redis_rate.Limit{Rate: 3, Period: 2 * time.Second, Burst: 3}), r.controller.Kiss)
		user.POST("/:id/follow", r.controller.Follow)
		user.DELETE("/:id/follow", r.controller.Unfollow)
		user.GET("/:id/followers", r.controller.GetFollowers)
		user.GET("/:id/following", r.controller.GetFollowing)
	}
}
