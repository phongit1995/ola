package session

import (
	"fmt"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type SaveInput struct {
	ID           uuid.UUID
	UserID       uuid.UUID
	DeviceName   string
	Platform     string
	DeviceID     string
	AppVersion   string
	UserAgent    string
	IPAddress    string
	RefreshToken string
}

type Service struct {
	repo   *Repository
	cache  *services.CacheService
	cfg    *config.Config
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, cache *services.CacheService, cfg *config.Config, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:   repo,
		cache:  cache,
		cfg:    cfg,
		logger: logger.Named("[session_service]"),
	}
}

func (s *Service) ResolveSessionID(userID uuid.UUID, deviceID string) uuid.UUID {
	if deviceID != "" {
		if existing, err := s.repo.FindActiveByDevice(userID, deviceID); err == nil && existing != nil {
			return existing.ID
		}
	}
	return uuid.New()
}

func (s *Service) Save(in SaveInput) error {
	return s.repo.Upsert(&models.UserSession{
		BaseModel:    models.BaseModel{ID: in.ID},
		UserID:       in.UserID,
		RefreshToken: in.RefreshToken,
		DeviceName:   in.DeviceName,
		Platform:     in.Platform,
		DeviceID:     in.DeviceID,
		AppVersion:   in.AppVersion,
		UserAgent:    in.UserAgent,
		IPAddress:    in.IPAddress,
		LastActiveAt: time.Now(),
	})
}

func (s *Service) Rotate(sessionID uuid.UUID, oldRefreshToken, newRefreshToken string) (bool, error) {
	return s.repo.RotateRefreshToken(sessionID, oldRefreshToken, newRefreshToken)
}

func (s *Service) Revoke(sessionID uuid.UUID) error {
	if err := s.repo.Revoke(sessionID); err != nil {
		return err
	}
	s.markRevoked(sessionID)
	return nil
}

func (s *Service) List(userID uuid.UUID) ([]models.UserSession, error) {
	return s.repo.ListActiveByUser(userID)
}

func (s *Service) RevokeForUser(userID, sessionID uuid.UUID) (bool, error) {
	found, err := s.repo.RevokeForUser(userID, sessionID)
	if err != nil {
		return false, err
	}
	if found {
		s.markRevoked(sessionID)
	}
	return found, nil
}

func (s *Service) RevokeAllForUser(userID uuid.UUID) (int, error) {
	ids, err := s.repo.ListActiveIDsForUser(userID)
	if err != nil {
		return 0, err
	}
	for _, id := range ids {
		s.markRevoked(id)
	}
	revoked, err := s.repo.RevokeAllForUser(userID)
	if err != nil {
		return 0, err
	}
	return int(revoked), nil
}

func (s *Service) RevokeOthers(userID, keepID uuid.UUID) (int, error) {
	ids, err := s.repo.ListActiveIDsExcept(userID, keepID)
	if err != nil {
		return 0, err
	}
	for _, id := range ids {
		s.markRevoked(id)
	}
	revoked, err := s.repo.RevokeAllExcept(userID, keepID)
	if err != nil {
		return 0, err
	}
	return int(revoked), nil
}

func (s *Service) markRevoked(sessionID uuid.UUID) {
	key := fmt.Sprintf(constants.CacheKeySessionRevoked, sessionID.String())
	if err := s.cache.Set(key, "1", s.accessTokenTTL()); err != nil {
		s.logger.Warnw("Failed to mark session revoked in cache", "session_id", sessionID, "error", err.Error())
	}
}

func (s *Service) accessTokenTTL() time.Duration {
	ttl, err := time.ParseDuration(s.cfg.JWTExpiry)
	if err != nil {
		return 24 * time.Hour
	}
	return ttl
}
