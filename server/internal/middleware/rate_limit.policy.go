package middleware

import (
	"time"

	"github.com/go-redis/redis_rate/v10"
)

type RateLimitPolicy struct {
	Name  string
	Limit redis_rate.Limit
}

func perWindow(requests int, window time.Duration) redis_rate.Limit {
	return redis_rate.Limit{Rate: requests, Period: window, Burst: requests}
}

var (
	PolicyKiss        = RateLimitPolicy{Name: "kiss", Limit: perWindow(3, 2*time.Second)}
	PolicyChatMessage = RateLimitPolicy{Name: "chat_message", Limit: perWindow(3, 2*time.Second)}
	PolicyRoomMessage = RateLimitPolicy{Name: "room_message", Limit: perWindow(3, 2*time.Second)}
	PolicyLogin       = RateLimitPolicy{Name: "login", Limit: perWindow(10, time.Minute)}
	PolicyAdminLogin  = RateLimitPolicy{Name: "admin_login", Limit: perWindow(5, time.Minute)}
	PolicyWheelSpin   = RateLimitPolicy{Name: "wheel_spin", Limit: perWindow(1, 3*time.Second)}

	PolicyEmailVerifySend = RateLimitPolicy{Name: "email_verify_send", Limit: perWindow(5, time.Hour)}
)
