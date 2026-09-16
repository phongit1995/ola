package auth

import (
	"context"
	"crypto/rand"
	"errors"
	"fmt"
	"math/big"
	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/session"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/modules/vip"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
	"strings"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

const (
	registerThrottleWindow  = time.Second
	registerSuccessCooldown = 12 * time.Hour
	errRateLimited          = "RATE_LIMITED"
	registerUsernameMinLen  = 6
	registerUsernameMaxLen  = 20
)

type Service struct {
	repo           *Repository
	jwtService     *services.JWTService
	userCache      *user.CacheService
	cache          *services.CacheService
	sessionService *session.Service
	mailService    *services.MailService
	vipService     *vip.Service
	cfg            *config.Config
	logger         *zap.SugaredLogger
}

func NewService(repo *Repository, jwtService *services.JWTService, userCache *user.CacheService, cache *services.CacheService, sessionService *session.Service, mailService *services.MailService, vipService *vip.Service, cfg *config.Config, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:           repo,
		jwtService:     jwtService,
		userCache:      userCache,
		cache:          cache,
		sessionService: sessionService,
		mailService:    mailService,
		vipService:     vipService,
		cfg:            cfg,
		logger:         logger.Named("[auth_service]"),
	}
}

func (s *Service) Logout(token string) error {
	claims, err := s.jwtService.VerifyToken(token)
	if err != nil {
		return errors.New("invalid or expired token")
	}
	if claims.ID != "" {
		ttl := time.Until(claims.ExpiresAt.Time)
		if ttl > 0 {
			key := fmt.Sprintf(constants.CacheKeyTokenBlacklist, claims.ID)
			if err := s.cache.Set(key, "1", ttl); err != nil {
				s.logger.Errorw("Failed to blacklist token", "jti", claims.ID, "error", err)
				return err
			}
		}
	}

	if sessionID, err := s.jwtService.GetSessionIDFromToken(token); err == nil && sessionID != uuid.Nil {
		if err := s.sessionService.Revoke(sessionID); err != nil {
			s.logger.Warnw("Failed to revoke session", "session_id", sessionID, "error", err)
		}
	} else if userID, err := s.jwtService.GetUserIDFromToken(token); err == nil {
		if err := s.repo.ClearRefreshToken(userID); err != nil {
			s.logger.Warnw("Failed to clear refresh token", "user_id", userID, "error", err)
		}
	}

	s.logger.Infow("User logged out", "jti", claims.ID)
	return nil
}

func (s *Service) RefreshToken(refreshTokenStr, clientIP, userAgent string) (*RefreshTokenResponse, error) {
	userID, err := s.jwtService.GetUserIDFromToken(refreshTokenStr)
	if err != nil {
		return nil, errors.New("invalid or expired refresh token")
	}

	sessionID, err := s.jwtService.GetSessionIDFromToken(refreshTokenStr)
	if err != nil {
		return nil, errors.New("invalid or expired refresh token")
	}

	if sessionID == uuid.Nil {
		return nil, errors.New("invalid or expired refresh token")
	}

	newAccessToken, err := s.jwtService.GenerateTokenWithSession(userID, sessionID)
	if err != nil {
		return nil, err
	}

	newRefreshToken, err := s.jwtService.GenerateRefreshTokenWithSession(userID, sessionID)
	if err != nil {
		return nil, err
	}

	rotated, err := s.sessionService.Rotate(sessionID, refreshTokenStr, newRefreshToken)
	if err != nil {
		s.logger.Errorw("Failed to rotate session refresh token", "session_id", sessionID, "error", err)
		return nil, err
	}
	if !rotated {
		return nil, errors.New("refresh token has been revoked")
	}

	s.logger.Infow("Token refreshed", "user_id", userID, "session_id", sessionID, "ip", clientIP)
	return &RefreshTokenResponse{
		Token:        newAccessToken,
		RefreshToken: newRefreshToken,
	}, nil
}

func normalizeRegisterUsername(username string) (string, error) {
	name := strings.ToLower(strings.TrimSpace(username))
	if len(name) < registerUsernameMinLen || len(name) > registerUsernameMaxLen {
		return "", fmt.Errorf("username must be between %d and %d characters", registerUsernameMinLen, registerUsernameMaxLen)
	}
	if !user.IsValidUsernameFormat(name) {
		return "", errors.New(user.UsernameFormatMessage)
	}
	return name, nil
}

func (s *Service) guardRegister(clientIP string) error {
	doneKey := fmt.Sprintf(constants.CacheKeyRegisterDone, clientIP)
	if done, err := s.cache.Exists(doneKey); err == nil && done {
		return errors.New(errRateLimited)
	}
	throttleKey := fmt.Sprintf(constants.CacheKeyRegisterThrottle, clientIP)
	if ok, err := s.cache.SetNX(throttleKey, "1", registerThrottleWindow); err == nil && !ok {
		return errors.New(errRateLimited)
	}
	return nil
}

func (s *Service) Register(req *RegisterRequest, clientIP string) (*RegisterResponse, error) {
	if err := s.guardRegister(clientIP); err != nil {
		return nil, err
	}

	username, err := normalizeRegisterUsername(req.Username)
	if err != nil {
		return nil, err
	}
	req.Username = username

	s.logger.Debugw("Checking username availability",
		"username", req.Username,
	)

	exists, err := s.repo.UsernameExists(req.Username)
	if err != nil {
		s.logger.Errorw("Failed to check username availability",
			"username", req.Username,
			"error", err.Error(),
		)
		return nil, err
	}
	if exists {
		s.logger.Warnw("Username already exists",
			"username", req.Username,
		)
		return nil, errors.New("username already exists")
	}

	s.logger.Debugw("Hashing password")

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	if err != nil {
		s.logger.Errorw("Failed to hash password",
			"error", err.Error(),
		)
		return nil, err
	}

	user := &models.User{
		Username:    req.Username,
		Password:    string(hashedPassword),
		LastLoginIP: clientIP,
	}

	s.logger.Debugw("Creating user in database",
		"username", req.Username,
	)

	if err := s.repo.Create(user); err != nil {
		if strings.Contains(err.Error(), "users_username_key") {
			return nil, errors.New("username already exists")
		}
		s.logger.Errorw("Failed to create user",
			"error", err.Error(),
		)
		return nil, err
	}

	if err := s.userCache.SetUser(user.ID, user); err != nil {
		s.logger.Warnw("Failed to cache user after registration",
			"user_id", user.ID,
			"error", err.Error(),
		)
	}

	if err := s.cache.Set(fmt.Sprintf(constants.CacheKeyRegisterDone, clientIP), "1", registerSuccessCooldown); err != nil {
		s.logger.Warnw("Failed to set register cooldown", "ip", clientIP, "error", err.Error())
	}

	s.logger.Infow("User registered successfully",
		"user_id", user.ID,
		"email", user.Email,
	)

	return &RegisterResponse{
		User: UserResponse{
			ID:       user.ID.String(),
			Username: user.Username,
			Email:    user.Email,
		},
		Message: "Registration successful. Please login to continue.",
	}, nil
}

func (s *Service) Login(req *LoginRequest, clientIP, userAgent string) (*AuthResponse, error) {
	user, err := s.authenticate(req)
	if err != nil {
		return nil, err
	}

	deviceName, platform, deviceID, appVersion := resolveDeviceInfo(req.Device, userAgent)
	sessionID := s.sessionService.ResolveSessionID(user.ID, deviceID)

	token, refreshToken, err := s.issueTokens(user.ID, sessionID)
	if err != nil {
		return nil, err
	}

	if err := s.repo.UpdateLastLogin(user.ID, clientIP); err != nil {
		s.logger.Errorw("Failed to update login info", "user_id", user.ID, "error", err.Error())
	}

	if err := s.sessionService.Save(session.SaveInput{
		ID:           sessionID,
		UserID:       user.ID,
		DeviceName:   deviceName,
		Platform:     platform,
		DeviceID:     deviceID,
		AppVersion:   appVersion,
		UserAgent:    userAgent,
		IPAddress:    clientIP,
		RefreshToken: refreshToken,
	}); err != nil {
		s.logger.Errorw("Failed to save session", "user_id", user.ID, "session_id", sessionID, "error", err.Error())
	}

	if refreshed, err := s.repo.FindByID(user.ID); err == nil && refreshed != nil {
		user = refreshed
	}

	if err := s.userCache.SetUser(user.ID, user); err != nil {
		s.logger.Warnw("Failed to cache user after login", "user_id", user.ID, "error", err.Error())
	}

	s.logger.Infow("User logged in successfully", "user_id", user.ID, "ip", clientIP)
	return s.buildAuthResponse(user, token, refreshToken), nil
}

func (s *Service) authenticate(req *LoginRequest) (*models.User, error) {
	req.Username = strings.ToLower(strings.TrimSpace(req.Username))

	user, err := s.repo.FindByUsername(req.Username)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			s.logger.Warnw("User not found", "username", req.Username)
			return nil, errors.New("invalid username or password")
		}
		s.logger.Errorw("Database error while finding user", "username", req.Username, "error", err.Error())
		return nil, err
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.Password)); err != nil {
		s.logger.Warnw("Invalid password", "user_id", user.ID, "username", req.Username)
		return nil, errors.New("invalid username or password")
	}

	if !user.IsActive {
		s.logger.Warnw("Login blocked: account disabled", "user_id", user.ID)
		return nil, errors.New("account is disabled")
	}

	return user, nil
}

func (s *Service) issueTokens(userID, sessionID uuid.UUID) (string, string, error) {
	token, err := s.jwtService.GenerateTokenWithSession(userID, sessionID)
	if err != nil {
		s.logger.Errorw("Failed to generate access token", "user_id", userID, "error", err.Error())
		return "", "", err
	}
	refreshToken, err := s.jwtService.GenerateRefreshTokenWithSession(userID, sessionID)
	if err != nil {
		s.logger.Errorw("Failed to generate refresh token", "user_id", userID, "error", err.Error())
		return "", "", err
	}
	return token, refreshToken, nil
}

func (s *Service) ChangePassword(userID uuid.UUID, req *ChangePasswordRequest) error {
	user, err := s.repo.FindByID(userID)
	if err != nil {
		return apperr.ErrUserNotFound
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.CurrentPassword)); err != nil {
		return errors.New("current password is incorrect")
	}

	hashed, err := bcrypt.GenerateFromPassword([]byte(req.NewPassword), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	return s.repo.UpdatePassword(userID, string(hashed))
}

func (s *Service) buildAuthResponse(user *models.User, token, refreshToken string) *AuthResponse {
	userResponse := UserResponse{
		ID:             user.ID.String(),
		Username:       user.Username,
		Email:          user.Email,
		EmailVerified:  user.EmailVerified,
		Avatar:         user.Avatar,
		Phone:          user.Phone,
		FullName:       user.FullName,
		Gender:         user.Gender,
		Bio:            user.Bio,
		BioImage:       user.BioImage,
		CoverPhoto:     user.CoverPhoto,
		CustomInfo:     user.CustomInfo,
		Ken:            user.Ken,
		VipUsed:        user.VipUsed,
		FollowerCount:  user.FollowerCount,
		FollowingCount: user.FollowingCount,
	}

	if user.DateOfBirth != nil {
		userResponse.DateOfBirth = user.DateOfBirth.Format("2006-01-02")
	}

	if user.VipEndTime != nil {
		vipEndTime := user.VipEndTime.Format(time.RFC3339)
		userResponse.VipEndTime = &vipEndTime
	}

	return &AuthResponse{
		Token:        token,
		RefreshToken: refreshToken,
		User:         userResponse,
	}
}

type emailVerifyEntry struct {
	VerifyID string `json:"verifyId"`
	Email    string `json:"email"`
	Code     string `json:"code"`
	Attempts int    `json:"attempts"`
}

type passwordResetEntry struct {
	UserID uuid.UUID `json:"userId"`
	Code   string    `json:"code"`
}

const errPasswordResetFailed = "failed to reset password, please try again"

func (s *Service) SendPasswordReset(username, clientIP string) error {
	username = strings.ToLower(strings.TrimSpace(username))

	cooldownKey := fmt.Sprintf(constants.CacheKeyPasswordResetCooldown, username)
	if ok, err := s.cache.SetNX(cooldownKey, "1", constants.PasswordResetCooldownSeconds*time.Second); err == nil && !ok {
		return errors.New("please wait before requesting a new code")
	}

	dailyKey := fmt.Sprintf(constants.CacheKeyPasswordResetDaily, username)
	if count, err := s.cache.Increment(dailyKey); err == nil {
		if count == 1 {
			_ = s.cache.SetExpire(dailyKey, constants.PasswordResetDailyWindow*time.Second)
		}
		if count > constants.PasswordResetMaxPerDay {
			return errors.New("daily password reset limit reached")
		}
	}

	user, err := s.repo.FindByUsername(username)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			s.logger.Infow("Password reset requested for unknown username", "username", username, "ip", clientIP)
			return nil
		}
		return err
	}
	if !user.IsActive || !user.EmailVerified || user.Email == "" {
		s.logger.Infow("Password reset requested without verified email", "user_id", user.ID, "ip", clientIP)
		return nil
	}

	code, err := generateNumericCode(constants.PasswordResetCodeLength)
	if err != nil {
		return err
	}

	codeKey := fmt.Sprintf(constants.CacheKeyPasswordResetCode, username)
	attemptsKey := fmt.Sprintf(constants.CacheKeyPasswordResetAttempts, username)
	entry := passwordResetEntry{UserID: user.ID, Code: code}
	if err := s.cache.Set(codeKey, entry, constants.CacheTTLOTP*time.Second); err != nil {
		return err
	}
	_ = s.cache.Delete(attemptsKey)

	userID := user.ID
	email := user.Email
	go func() {
		ctx, cancel := context.WithTimeout(context.Background(), 15*time.Second)
		defer cancel()
		if err := s.mailService.SendPasswordResetCode(ctx, email, code); err != nil {
			s.logger.Errorw("Failed to send password reset email", "user_id", userID, "error", err.Error())
			_ = s.cache.Delete(codeKey)
			_, _ = s.cache.Decrement(dailyKey)
			_ = s.cache.Delete(cooldownKey)
			return
		}
		s.logger.Infow("Password reset code sent", "user_id", userID, "ip", clientIP)
	}()

	return nil
}

func (s *Service) ConfirmPasswordReset(req *ForgotPasswordConfirmRequest, clientIP string) error {
	username := strings.ToLower(strings.TrimSpace(req.Username))
	codeKey := fmt.Sprintf(constants.CacheKeyPasswordResetCode, username)
	attemptsKey := fmt.Sprintf(constants.CacheKeyPasswordResetAttempts, username)

	var entry passwordResetEntry
	status, err := s.cache.ConsumeCode(codeKey, attemptsKey, req.Code, constants.PasswordResetMaxAttempts, &entry)
	if err != nil {
		s.logger.Errorw("Failed to verify password reset code", "error", err.Error(), "ip", clientIP)
		return errors.New(errPasswordResetFailed)
	}

	switch status {
	case services.ConsumeCodeMissing:
		return errors.New("reset code expired or not found")
	case services.ConsumeCodeTooMany:
		return errors.New("too many invalid attempts, please request a new code")
	case services.ConsumeCodeInvalid:
		return errors.New("invalid reset code")
	}

	if _, err := s.sessionService.RevokeAllForUser(entry.UserID); err != nil {
		s.logger.Errorw("Failed to revoke sessions during password reset", "user_id", entry.UserID, "error", err.Error())
		return errors.New(errPasswordResetFailed)
	}
	if err := s.repo.ClearRefreshToken(entry.UserID); err != nil {
		s.logger.Errorw("Failed to clear refresh token during password reset", "user_id", entry.UserID, "error", err.Error())
		return errors.New(errPasswordResetFailed)
	}

	hashed, err := bcrypt.GenerateFromPassword([]byte(req.NewPassword), bcrypt.DefaultCost)
	if err != nil {
		return err
	}
	if err := s.repo.UpdatePassword(entry.UserID, string(hashed)); err != nil {
		s.logger.Errorw("Failed to update password during password reset", "user_id", entry.UserID, "error", err.Error())
		return errors.New(errPasswordResetFailed)
	}

	if err := s.userCache.InvalidateUser(entry.UserID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after password reset", "user_id", entry.UserID, "error", err.Error())
	}

	s.logger.Infow("Password reset completed", "user_id", entry.UserID, "ip", clientIP)
	return nil
}

func isAllowedEmailDomain(email string) bool {
	at := strings.LastIndex(email, "@")
	if at < 0 {
		return false
	}
	_, ok := constants.EmailVerifyAllowedDomains[email[at+1:]]
	return ok
}

func generateNumericCode(n int) (string, error) {
	const digits = "0123456789"
	buf := make([]byte, n)
	for i := range buf {
		idx, err := rand.Int(rand.Reader, big.NewInt(int64(len(digits))))
		if err != nil {
			return "", err
		}
		buf[i] = digits[idx.Int64()]
	}
	return string(buf), nil
}

func (s *Service) SendEmailVerification(userID uuid.UUID, email string) (string, error) {
	email = strings.ToLower(strings.TrimSpace(email))
	if !isAllowedEmailDomain(email) {
		return "", errors.New("email domain not allowed")
	}

	user, err := s.repo.FindByID(userID)
	if err != nil {
		return "", apperr.ErrUserNotFound
	}
	if user.EmailVerified && strings.EqualFold(user.Email, email) {
		return "", errors.New("email already verified")
	}

	taken, err := s.repo.EmailVerifiedByOther(email, userID)
	if err != nil {
		return "", err
	}
	if taken {
		return "", errors.New("email already exists")
	}

	cooldownKey := fmt.Sprintf(constants.CacheKeyEmailVerifyCooldown, userID)
	if ok, err := s.cache.SetNX(cooldownKey, "1", constants.EmailVerifyCooldownSeconds*time.Second); err == nil && !ok {
		return "", errors.New("please wait before requesting a new code")
	}

	dailyKey := fmt.Sprintf(constants.CacheKeyEmailVerifyDaily, userID)
	if count, err := s.cache.Increment(dailyKey); err == nil {
		if count == 1 {
			_ = s.cache.SetExpire(dailyKey, constants.EmailVerifyDailyWindow*time.Second)
		}
		if count > constants.EmailVerifyMaxPerDay {
			return "", errors.New("daily email verification limit reached")
		}
	}

	code, err := generateNumericCode(constants.EmailVerifyCodeLength)
	if err != nil {
		return "", err
	}

	verifyID := uuid.NewString()
	entry := emailVerifyEntry{VerifyID: verifyID, Email: email, Code: code}
	if err := s.cache.Set(fmt.Sprintf(constants.CacheKeyEmailVerifyCode, userID), entry, constants.CacheTTLOTP*time.Second); err != nil {
		return "", err
	}

	if err := s.mailService.SendVerificationCode(context.Background(), email, code); err != nil {
		s.logger.Errorw("Failed to send verification email", "user_id", userID, "error", err.Error())
		_, _ = s.cache.Decrement(dailyKey)
		return "", errors.New("failed to send verification email")
	}

	s.logger.Infow("Verification code sent", "user_id", userID, "email", email)
	return verifyID, nil
}

func (s *Service) ConfirmEmailVerification(userID uuid.UUID, verifyID, code string) (int, error) {
	key := fmt.Sprintf(constants.CacheKeyEmailVerifyCode, userID)

	var entry emailVerifyEntry
	if err := s.cache.Get(key, &entry); err != nil {
		return 0, errors.New("verification code expired or not found")
	}

	if entry.VerifyID != verifyID {
		return 0, errors.New("invalid verification request")
	}

	email := entry.Email

	if entry.Code != code {
		entry.Attempts++
		if entry.Attempts >= constants.EmailVerifyMaxAttempts {
			_ = s.cache.Delete(key)
			return 0, errors.New("too many invalid attempts, please request a new code")
		}
		ttl, err := s.cache.GetTTL(key)
		if err != nil || ttl <= 0 {
			ttl = constants.CacheTTLOTP * time.Second
		}
		_ = s.cache.Set(key, entry, ttl)
		return 0, errors.New("invalid verification code")
	}

	taken, err := s.repo.EmailVerifiedByOther(email, userID)
	if err != nil {
		return 0, err
	}
	if taken {
		return 0, errors.New("email already exists")
	}

	firstVerification, err := s.repo.SetEmailVerified(userID, email)
	if err != nil {
		if strings.Contains(err.Error(), "idx_users_email_verified_unique") {
			return 0, errors.New("email already exists")
		}
		s.logger.Errorw("Failed to set email verified", "user_id", userID, "error", err.Error())
		return 0, err
	}

	_ = s.cache.Delete(key)
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after email verify", "user_id", userID, "error", err.Error())
	}

	s.logger.Infow("Email verified", "user_id", userID, "email", email)

	rewardDays := 0
	if firstVerification && s.cfg.EmailVerifyVipRewardDays > 0 {
		if _, err := s.vipService.GrantDays(userID, s.cfg.EmailVerifyVipRewardDays, "email_verify", "Thưởng xác thực email"); err != nil {
			s.logger.Errorw("Failed to grant email verification vip reward", "user_id", userID, "days", s.cfg.EmailVerifyVipRewardDays, "error", err.Error())
		} else {
			rewardDays = s.cfg.EmailVerifyVipRewardDays
			s.logger.Infow("Email verification vip reward granted", "user_id", userID, "days", rewardDays)
		}
	}
	return rewardDays, nil
}

func resolveDeviceInfo(device *DeviceInfo, userAgent string) (name, platform, deviceID, appVersion string) {
	if device != nil {
		name = strings.TrimSpace(device.DeviceName)
		platform = strings.TrimSpace(device.Platform)
		deviceID = strings.TrimSpace(device.DeviceID)
		appVersion = strings.TrimSpace(device.AppVersion)
	}
	if name == "" {
		name = utils.ParseDeviceName(userAgent)
	}
	if platform == "" {
		platform = utils.ParsePlatform(userAgent)
	}
	return
}
