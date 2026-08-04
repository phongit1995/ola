package adminauth

import (
	"crypto/aes"
	"crypto/cipher"
	cryptorand "crypto/rand"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type Service struct {
	repo       *Repository
	jwtService *services.JWTService
	cfg        *config.Config
	logger     *zap.SugaredLogger
}

// adminRefreshRetryGrace makes a lost refresh response idempotently retriable.
// Only the immediately previous token is eligible; older generations revoke the family.
const adminRefreshRetryGrace = 30 * time.Second

type refreshRetryPayload struct {
	AccessToken  string `json:"accessToken"`
	RefreshToken string `json:"refreshToken"`
}

func NewService(repo *Repository, jwtService *services.JWTService, cfg *config.Config, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:       repo,
		jwtService: jwtService,
		cfg:        cfg,
		logger:     logger.Named("[admin_auth_service]"),
	}
}

func (s *Service) Login(req *LoginRequest, clientIP, userAgent string) (*LoginResponse, error) {
	admin, err := s.repo.FindByUsername(req.Username)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("invalid username or password")
		}
		return nil, err
	}

	if err := bcrypt.CompareHashAndPassword([]byte(admin.Password), []byte(req.Password)); err != nil {
		s.logger.Warnw("Admin invalid password", "admin_id", admin.ID, "username", req.Username, "ip", clientIP)
		return nil, errors.New("invalid username or password")
	}

	if !admin.IsActive {
		return nil, errors.New("admin account is disabled")
	}

	sessionID := uuid.New()
	token, err := s.generateAccessToken(admin, sessionID)
	if err != nil {
		return nil, err
	}

	refreshToken, err := s.generateRefreshToken(admin, sessionID)
	if err != nil {
		return nil, err
	}
	now := time.Now()
	sessionExpiresAt := now.Add(s.refreshTokenLifetime())

	if err := s.repo.CreateSession(&models.AdminSession{
		BaseModel:        models.BaseModel{ID: sessionID},
		AdminID:          admin.ID,
		RefreshTokenHash: hashRefreshToken(refreshToken),
		UserAgent:        userAgent,
		IPAddress:        clientIP,
		LastActiveAt:     now,
		ExpiresAt:        sessionExpiresAt,
	}, admin.Password); err != nil {
		s.logger.Errorw("Failed to create admin session", "admin_id", admin.ID, "error", err.Error())
		return nil, err
	}

	s.logger.Infow("Admin logged in", "admin_id", admin.ID, "username", admin.Username, "ip", clientIP)

	return &LoginResponse{
		Token:                 token,
		RefreshToken:          refreshToken,
		RefreshTokenExpiresAt: sessionExpiresAt,
		Admin:                 toAdminDTO(admin),
	}, nil
}

func (s *Service) RefreshToken(refreshTokenStr, clientIP, userAgent string) (*RefreshTokenResponse, error) {
	claims, err := s.jwtService.VerifyToken(refreshTokenStr)
	if err != nil {
		return nil, errors.New("invalid or expired refresh token")
	}

	adminID, sessionID, err := adminSessionFromClaims(claims.Data, constants.TokenUseRefresh)
	if err != nil {
		return nil, errors.New("invalid or expired refresh token")
	}

	admin, err := s.repo.FindByID(adminID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("admin not found")
		}
		return nil, err
	}

	if !admin.IsActive {
		return nil, errors.New("admin account is disabled")
	}

	newAccessToken, err := s.generateAccessToken(admin, sessionID)
	if err != nil {
		return nil, err
	}
	newRefreshToken, err := s.generateRefreshToken(admin, sessionID)
	if err != nil {
		return nil, err
	}
	retryResponse, err := s.encryptRefreshRetryResponse(admin.ID, sessionID, refreshRetryPayload{
		AccessToken:  newAccessToken,
		RefreshToken: newRefreshToken,
	})
	if err != nil {
		return nil, err
	}

	rotation, err := s.repo.RotateRefreshToken(
		admin.ID,
		sessionID,
		hashRefreshToken(refreshTokenStr),
		hashRefreshToken(newRefreshToken),
		retryResponse,
		clientIP,
		userAgent,
		adminRefreshRetryGrace,
	)
	if err != nil {
		s.logger.Errorw("Failed to rotate admin refresh token", "admin_id", admin.ID, "session_id", sessionID, "error", err.Error())
		return nil, err
	}

	switch rotation.Status {
	case RefreshRotationRotated:
		s.logger.Infow("Admin token refreshed", "admin_id", admin.ID, "session_id", sessionID, "ip", clientIP)
		return &RefreshTokenResponse{
			Token:                 newAccessToken,
			RefreshToken:          newRefreshToken,
			RefreshTokenExpiresAt: rotation.ExpiresAt,
		}, nil
	case RefreshRotationRetry:
		payload, decryptErr := s.decryptRefreshRetryResponse(admin.ID, sessionID, rotation.RetryResponse)
		if decryptErr != nil {
			s.logger.Errorw("Failed to decrypt admin refresh retry", "admin_id", admin.ID, "session_id", sessionID, "error", decryptErr.Error())
			return nil, decryptErr
		}
		s.logger.Infow("Admin refresh retry served", "admin_id", admin.ID, "session_id", sessionID, "ip", clientIP)
		return &RefreshTokenResponse{
			Token:                 payload.AccessToken,
			RefreshToken:          payload.RefreshToken,
			RefreshTokenExpiresAt: rotation.ExpiresAt,
		}, nil
	case RefreshRotationReused:
		s.logger.Warnw("Admin refresh token reuse detected", "admin_id", admin.ID, "session_id", sessionID, "ip", clientIP)
		return nil, errors.New("refresh token reuse detected")
	case RefreshRotationExpired:
		return nil, errors.New("invalid or expired refresh token")
	case RefreshRotationRevoked, RefreshRotationNotFound:
		return nil, errors.New("refresh token has been revoked")
	default:
		return nil, errors.New("invalid admin refresh rotation status")
	}
}

func (s *Service) Logout(adminID, sessionID uuid.UUID) error {
	revoked, err := s.repo.RevokeSession(adminID, sessionID)
	if err != nil {
		return err
	}
	if !revoked {
		return errors.New("admin session has been revoked")
	}
	s.logger.Infow("Admin logged out", "admin_id", adminID, "session_id", sessionID)
	return nil
}

func (s *Service) ChangePassword(adminID uuid.UUID, req *ChangePasswordRequest) error {
	admin, err := s.repo.FindByID(adminID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("admin not found")
		}
		return err
	}

	if err := bcrypt.CompareHashAndPassword([]byte(admin.Password), []byte(req.CurrentPassword)); err != nil {
		s.logger.Warnw("Admin change password: wrong current password", "admin_id", adminID)
		return errors.New("current password is incorrect")
	}

	if req.CurrentPassword == req.NewPassword {
		return errors.New("new password must be different from current password")
	}
	if len([]byte(req.NewPassword)) > 72 {
		return errors.New("new password must not exceed 72 bytes")
	}

	hash, err := bcrypt.GenerateFromPassword([]byte(req.NewPassword), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	if err := s.repo.UpdatePasswordAndRevokeSessions(adminID, admin.Password, string(hash)); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("admin password has changed")
		}
		return err
	}

	s.logger.Infow("Admin changed password", "admin_id", adminID)
	return nil
}

func (s *Service) GetByID(adminID uuid.UUID) (*AdminDTO, error) {
	admin, err := s.repo.FindByID(adminID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("admin not found")
		}
		return nil, err
	}
	dto := toAdminDTO(admin)
	return &dto, nil
}

func (s *Service) generateAccessToken(admin *models.AdminUser, sessionID uuid.UUID) (string, error) {
	return s.jwtService.GenerateTokenWithClaims(adminClaims(admin, sessionID, constants.TokenUseAccess))
}

func (s *Service) generateRefreshToken(admin *models.AdminUser, sessionID uuid.UUID) (string, error) {
	return s.jwtService.GenerateRefreshTokenWithClaims(adminClaims(admin, sessionID, constants.TokenUseRefresh))
}

func (s *Service) refreshTokenLifetime() time.Duration {
	const fallback = 30 * 24 * time.Hour
	if s.cfg == nil {
		return fallback
	}
	duration, err := time.ParseDuration(s.cfg.RefreshTokenExpiry)
	if err != nil || duration <= 0 {
		return fallback
	}
	return duration
}

func (s *Service) encryptRefreshRetryResponse(adminID, sessionID uuid.UUID, payload refreshRetryPayload) ([]byte, error) {
	gcm, err := s.refreshRetryAEAD()
	if err != nil {
		return nil, err
	}
	plaintext, err := json.Marshal(payload)
	if err != nil {
		return nil, fmt.Errorf("marshal admin refresh retry response: %w", err)
	}
	nonce := make([]byte, gcm.NonceSize())
	if _, err := io.ReadFull(cryptorand.Reader, nonce); err != nil {
		return nil, fmt.Errorf("generate admin refresh retry nonce: %w", err)
	}
	return gcm.Seal(nonce, nonce, plaintext, refreshRetryAAD(adminID, sessionID)), nil
}

func (s *Service) decryptRefreshRetryResponse(adminID, sessionID uuid.UUID, encrypted []byte) (*refreshRetryPayload, error) {
	gcm, err := s.refreshRetryAEAD()
	if err != nil {
		return nil, err
	}
	if len(encrypted) < gcm.NonceSize() {
		return nil, errors.New("invalid admin refresh retry response")
	}
	nonce, ciphertext := encrypted[:gcm.NonceSize()], encrypted[gcm.NonceSize():]
	plaintext, err := gcm.Open(nil, nonce, ciphertext, refreshRetryAAD(adminID, sessionID))
	if err != nil {
		return nil, fmt.Errorf("decrypt admin refresh retry response: %w", err)
	}
	var payload refreshRetryPayload
	if err := json.Unmarshal(plaintext, &payload); err != nil {
		return nil, fmt.Errorf("unmarshal admin refresh retry response: %w", err)
	}
	if payload.AccessToken == "" || payload.RefreshToken == "" {
		return nil, errors.New("invalid admin refresh retry payload")
	}
	return &payload, nil
}

func (s *Service) refreshRetryAEAD() (cipher.AEAD, error) {
	if s.cfg == nil || s.cfg.JWTSecret == "" {
		return nil, errors.New("admin refresh retry encryption is not configured")
	}
	key := sha256.Sum256([]byte("ola/admin/refresh-retry/v1\x00" + s.cfg.JWTSecret))
	block, err := aes.NewCipher(key[:])
	if err != nil {
		return nil, fmt.Errorf("create admin refresh retry cipher: %w", err)
	}
	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return nil, fmt.Errorf("create admin refresh retry AEAD: %w", err)
	}
	return gcm, nil
}

func refreshRetryAAD(adminID, sessionID uuid.UUID) []byte {
	return []byte(adminID.String() + ":" + sessionID.String())
}

func adminClaims(admin *models.AdminUser, sessionID uuid.UUID, tokenUse string) map[string]interface{} {
	return map[string]interface{}{
		"id":        admin.ID.String(),
		"sid":       sessionID.String(),
		"role":      admin.Role,
		"type":      constants.TokenTypeAdmin,
		"token_use": tokenUse,
		"isAdmin":   true,
	}
}

func adminSessionFromClaims(data interface{}, expectedTokenUse string) (uuid.UUID, uuid.UUID, error) {
	dataMap, ok := data.(map[string]interface{})
	if !ok {
		return uuid.Nil, uuid.Nil, errors.New("invalid token data")
	}
	if isAdmin, _ := dataMap["isAdmin"].(bool); !isAdmin {
		return uuid.Nil, uuid.Nil, errors.New("invalid admin token")
	}
	if tokenType, _ := dataMap["type"].(string); tokenType != constants.TokenTypeAdmin {
		return uuid.Nil, uuid.Nil, errors.New("invalid admin token")
	}
	if tokenUse, _ := dataMap["token_use"].(string); tokenUse != expectedTokenUse {
		return uuid.Nil, uuid.Nil, errors.New("invalid token use")
	}
	idStr, ok := dataMap["id"].(string)
	if !ok {
		return uuid.Nil, uuid.Nil, errors.New("id not found in token")
	}
	adminID, err := uuid.Parse(idStr)
	if err != nil {
		return uuid.Nil, uuid.Nil, err
	}
	sessionIDStr, ok := dataMap["sid"].(string)
	if !ok || sessionIDStr == "" {
		return uuid.Nil, uuid.Nil, errors.New("session id not found in token")
	}
	sessionID, err := uuid.Parse(sessionIDStr)
	if err != nil {
		return uuid.Nil, uuid.Nil, err
	}
	return adminID, sessionID, nil
}

func hashRefreshToken(token string) string {
	sum := sha256.Sum256([]byte(token))
	return hex.EncodeToString(sum[:])
}

func toAdminDTO(admin *models.AdminUser) AdminDTO {
	return AdminDTO{
		ID:       admin.ID.String(),
		Username: admin.Username,
		FullName: admin.FullName,
		Email:    admin.Email,
		Avatar:   admin.Avatar,
		Role:     admin.Role,
	}
}
