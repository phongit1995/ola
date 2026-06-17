package auth

import (
	"errors"
	"fmt"
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/session"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
	"regexp"
	"strings"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

var usernameRegex = regexp.MustCompile(`^[a-z0-9_-]+$`)

type Service struct {
	repo           *Repository
	jwtService     *services.JWTService
	userCache      *user.CacheService
	cache          *services.CacheService
	sessionService *session.Service
	cfg            *config.Config
	logger         *zap.SugaredLogger
}

func NewService(repo *Repository, jwtService *services.JWTService, userCache *user.CacheService, cache *services.CacheService, sessionService *session.Service, cfg *config.Config, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:           repo,
		jwtService:     jwtService,
		userCache:      userCache,
		cache:          cache,
		sessionService: sessionService,
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

func (s *Service) Register(req *RegisterRequest) (*RegisterResponse, error) {
	req.Username = strings.ToLower(strings.TrimSpace(req.Username))
	if !usernameRegex.MatchString(req.Username) {
		return nil, errors.New("username may only contain lowercase letters, numbers, underscore (_) and hyphen (-)")
	}

	s.logger.Debugw("Checking username availability",
		"username", req.Username,
	)

	_, err := s.repo.FindByUsername(req.Username)
	if err == nil {
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
		Username: req.Username,
		Password: string(hashedPassword),
	}

	s.logger.Debugw("Creating user in database",
		"username", req.Username,
	)

	if err := s.repo.Create(user); err != nil {
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
	req.Username = strings.ToLower(strings.TrimSpace(req.Username))

	s.logger.Debugw("Finding user by username",
		"username", req.Username,
	)

	user, err := s.repo.FindByUsername(req.Username)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			s.logger.Warnw("User not found",
				"username", req.Username,
			)
			return nil, errors.New("invalid username or password")
		}
		s.logger.Errorw("Database error while finding user",
			"username", req.Username,
			"error", err.Error(),
		)
		return nil, err
	}

	s.logger.Debugw("Verifying password",
		"user_id", user.ID,
	)

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.Password)); err != nil {
		s.logger.Warnw("Invalid password",
			"user_id", user.ID,
			"username", req.Username,
		)
		return nil, errors.New("invalid username or password")
	}

	if !user.IsActive {
		s.logger.Warnw("Login blocked: account disabled", "user_id", user.ID)
		return nil, errors.New("account is disabled")
	}

	s.logger.Debugw("Generating JWT tokens",
		"user_id", user.ID,
	)

	deviceName, platform, deviceID, appVersion := resolveDeviceInfo(req.Device, userAgent)
	sessionID := s.sessionService.ResolveSessionID(user.ID, deviceID)

	token, err := s.jwtService.GenerateTokenWithSession(user.ID, sessionID)
	if err != nil {
		s.logger.Errorw("Failed to generate access token",
			"user_id", user.ID,
			"error", err.Error(),
		)
		return nil, err
	}

	refreshToken, err := s.jwtService.GenerateRefreshTokenWithSession(user.ID, sessionID)
	if err != nil {
		s.logger.Errorw("Failed to generate refresh token",
			"user_id", user.ID,
			"error", err.Error(),
		)
		return nil, err
	}

	s.logger.Debugw("Updating user login info",
		"user_id", user.ID,
		"ip", clientIP,
	)

	if err := s.repo.UpdateLastLogin(user.ID, clientIP); err != nil {
		s.logger.Errorw("Failed to update login info",
			"user_id", user.ID,
			"error", err.Error(),
		)
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
		s.logger.Errorw("Failed to save session",
			"user_id", user.ID,
			"session_id", sessionID,
			"error", err.Error(),
		)
	}

	user, _ = s.repo.FindByID(user.ID)

	if err := s.userCache.SetUser(user.ID, user); err != nil {
		s.logger.Warnw("Failed to cache user after login",
			"user_id", user.ID,
			"error", err.Error(),
		)
	}

	s.logger.Infow("User logged in successfully",
		"user_id", user.ID,
		"email", user.Email,
		"ip", clientIP,
	)

	return s.buildAuthResponse(user, token, refreshToken), nil
}

func (s *Service) ChangePassword(userID uuid.UUID, req *ChangePasswordRequest) error {
	user, err := s.repo.FindByID(userID)
	if err != nil {
		return errors.New("user not found")
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
		Avatar:         user.Avatar,
		Phone:          user.Phone,
		FullName:       user.FullName,
		Gender:         user.Gender,
		Bio:            user.Bio,
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
