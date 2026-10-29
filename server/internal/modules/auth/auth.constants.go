package auth

const (
	CacheKeyRegisterDone          = "REGISTER_DONE:%s"
	CacheKeyRegisterThrottle      = "REGISTER_THROTTLE:%s"
	CacheKeyEmailVerifyCode       = "EMAIL_VERIFY:%s:CODE"
	CacheKeyEmailVerifyCooldown   = "EMAIL_VERIFY:%s:COOLDOWN"
	CacheKeyEmailVerifyDaily      = "EMAIL_VERIFY:%s:DAILY"
	CacheKeyPasswordResetCode     = "PASSWORD_RESET:%s:CODE"
	CacheKeyPasswordResetAttempts = "PASSWORD_RESET:%s:ATTEMPTS"
	CacheKeyPasswordResetCooldown = "PASSWORD_RESET:%s:COOLDOWN"
	CacheKeyPasswordResetDaily    = "PASSWORD_RESET:%s:DAILY"

	EmailVerifyCooldownSeconds = 60
	EmailVerifyMaxAttempts     = 5
	EmailVerifyCodeLength      = 6
	EmailVerifyMaxPerDay       = 3
	EmailVerifyDailyWindow     = 24 * 60 * 60

	PasswordResetCooldownSeconds = 60
	PasswordResetMaxAttempts     = 5
	PasswordResetCodeLength      = 6
	PasswordResetMaxPerDay       = 5
	PasswordResetDailyWindow     = 24 * 60 * 60
)

var EmailVerifyAllowedDomains = map[string]struct{}{
	"gmail.com":    {},
	"yahoo.com":    {},
	"yahoo.com.vn": {},
	"icloud.com":   {},
}

const CacheTTLOTP = 300
