package adminauth

import (
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"
	"errors"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type Service struct {
	repo       *Repository
	jwtService *services.JWTService
	logger     *zap.SugaredLogger
}

func NewService(repo *Repository, jwtService *services.JWTService, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:       repo,
		jwtService: jwtService,
		logger:     logger.Named("[admin_auth_service]"),
	}
}

func (s *Service) Login(req *LoginRequest, clientIP string) (*LoginResponse, error) {
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

	token, err := s.generateAccessToken(admin)
	if err != nil {
		return nil, err
	}

	refreshToken, err := s.generateRefreshToken(admin)
	if err != nil {
		return nil, err
	}

	if err := s.repo.UpdateLoginInfo(admin.ID, clientIP, refreshToken); err != nil {
		s.logger.Errorw("Failed to update admin login info", "admin_id", admin.ID, "error", err.Error())
	}

	s.logger.Infow("Admin logged in", "admin_id", admin.ID, "username", admin.Username, "ip", clientIP)

	return &LoginResponse{
		Token:        token,
		RefreshToken: refreshToken,
		Admin:        toAdminDTO(admin),
	}, nil
}

func (s *Service) RefreshToken(refreshTokenStr, clientIP string) (*RefreshTokenResponse, error) {
	claims, err := s.jwtService.VerifyToken(refreshTokenStr)
	if err != nil {
		return nil, errors.New("invalid or expired refresh token")
	}

	adminID, err := adminIDFromClaims(claims.Data)
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

	if admin.RefreshToken == "" || admin.RefreshToken != refreshTokenStr {
		return nil, errors.New("refresh token has been revoked")
	}

	if !admin.IsActive {
		return nil, errors.New("admin account is disabled")
	}

	newAccessToken, err := s.generateAccessToken(admin)
	if err != nil {
		return nil, err
	}

	s.logger.Infow("Admin token refreshed", "admin_id", admin.ID, "ip", clientIP)

	return &RefreshTokenResponse{
		Token:        newAccessToken,
		RefreshToken: admin.RefreshToken,
	}, nil
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

	hash, err := bcrypt.GenerateFromPassword([]byte(req.NewPassword), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	if err := s.repo.UpdatePassword(adminID, string(hash)); err != nil {
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

func (s *Service) generateAccessToken(admin *models.AdminUser) (string, error) {
	return s.jwtService.GenerateTokenWithClaims(adminClaims(admin))
}

func (s *Service) generateRefreshToken(admin *models.AdminUser) (string, error) {
	return s.jwtService.GenerateRefreshTokenWithClaims(adminClaims(admin))
}

func adminClaims(admin *models.AdminUser) map[string]interface{} {
	return map[string]interface{}{
		"id":      admin.ID.String(),
		"role":    admin.Role,
		"type":    "admin",
		"isAdmin": true,
	}
}

func adminIDFromClaims(data interface{}) (uuid.UUID, error) {
	dataMap, ok := data.(map[string]interface{})
	if !ok {
		return uuid.Nil, errors.New("invalid token data")
	}
	idStr, ok := dataMap["id"].(string)
	if !ok {
		return uuid.Nil, errors.New("id not found in token")
	}
	return uuid.Parse(idStr)
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
