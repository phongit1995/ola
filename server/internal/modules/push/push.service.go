package push

import (
	"errors"
	"net/http"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo   *Repository
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:   repo,
		logger: logger.Named("[push_service]"),
	}
}

func (s *Service) Register(userID, sessionID uuid.UUID, token string) error {
	sess, err := s.repo.FindActiveSession(userID, sessionID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return utils.NewHTTPError(http.StatusUnauthorized, "session revoked")
		}
		return err
	}
	if sess.DeviceID == "" {
		return utils.NewHTTPError(http.StatusBadRequest, "session has no device id")
	}
	platform := sess.Platform
	if platform == "" {
		platform = "android"
	}
	return s.repo.RegisterToken(&models.DeviceToken{
		ID:        uuid.New(),
		UserID:    userID,
		SessionID: sess.ID,
		DeviceID:  sess.DeviceID,
		Platform:  platform,
		Token:     token,
	})
}
