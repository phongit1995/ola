package usersetting

import (
	"fmt"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Service struct {
	repo   *Repository
	cache  *services.CacheService
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, cache *services.CacheService, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:   repo,
		cache:  cache,
		logger: logger.Named("[usersetting_service]"),
	}
}

func (s *Service) cacheSettings(userID uuid.UUID, resp *UserSettingsResponse) {
	key := fmt.Sprintf(constants.CacheKeyUserSettings, userID)
	if err := s.cache.Set(key, resp, constants.CacheTTLUserSettings*time.Second); err != nil {
		s.logger.Warnw("Failed to cache user settings", "user_id", userID, "error", err.Error())
	}
}

func defaultUserSettings(userID uuid.UUID) *models.UserSetting {
	return &models.UserSetting{
		UserID:         userID,
		MessagePrivacy: models.SettingMessagePrivacyAll,
		MeVisibility:   models.SettingMeVisibilityAll,
		CommentPrivacy: models.SettingCommentPrivacyAll,
		ShowBirthday:   true,
		ShowInterested: true,
		NotifMessage:   true,
		NotifSound:     true,
		SoundGame:      true,
		SoundKen:       true,
		FontSize:       models.SettingFontSizeMedium,
		WallpaperURL:   "",
	}
}

func toUserSettingsResponse(setting *models.UserSetting) *UserSettingsResponse {
	return &UserSettingsResponse{
		MessagePrivacy:  setting.MessagePrivacy,
		MeVisibility:    setting.MeVisibility,
		CommentPrivacy:  setting.CommentPrivacy,
		ShowBirthday:    setting.ShowBirthday,
		ShowInterested:  setting.ShowInterested,
		NotifMessage:    setting.NotifMessage,
		NotifSound:      setting.NotifSound,
		SoundGame:       setting.SoundGame,
		SoundKen:        setting.SoundKen,
		FontSize:        setting.FontSize,
		WallpaperURL:    setting.WallpaperURL,
		VipStorePrivacy: setting.VipStorePrivacy,
	}
}

func (s *Service) GetSettings(userID uuid.UUID) (*UserSettingsResponse, error) {
	key := fmt.Sprintf(constants.CacheKeyUserSettings, userID)
	var cached UserSettingsResponse
	if err := s.cache.Get(key, &cached); err == nil {
		return &cached, nil
	}

	setting, err := s.repo.GetSettings(userID)
	if err != nil {
		return nil, err
	}
	if setting == nil {
		setting = defaultUserSettings(userID)
		created, err := s.repo.CreateIfAbsent(setting)
		if err != nil {
			return nil, err
		}
		if !created {
			if existing, err := s.repo.GetSettings(userID); err != nil {
				return nil, err
			} else if existing != nil {
				setting = existing
			}
		}
	}

	resp := toUserSettingsResponse(setting)
	s.cacheSettings(userID, resp)
	return resp, nil
}

func (s *Service) UpdateSettings(userID uuid.UUID, req *UpdateSettingsRequest) (*UserSettingsResponse, error) {
	setting, err := s.repo.GetSettings(userID)
	if err != nil {
		return nil, err
	}
	if setting == nil {
		setting = defaultUserSettings(userID)
	}

	if req.MessagePrivacy != nil {
		setting.MessagePrivacy = *req.MessagePrivacy
	}
	if req.MeVisibility != nil {
		setting.MeVisibility = *req.MeVisibility
	}
	if req.CommentPrivacy != nil {
		setting.CommentPrivacy = *req.CommentPrivacy
	}
	if req.ShowBirthday != nil {
		setting.ShowBirthday = *req.ShowBirthday
	}
	if req.ShowInterested != nil {
		setting.ShowInterested = *req.ShowInterested
	}
	if req.NotifMessage != nil {
		setting.NotifMessage = *req.NotifMessage
	}
	if req.NotifSound != nil {
		setting.NotifSound = *req.NotifSound
	}
	if req.SoundGame != nil {
		setting.SoundGame = *req.SoundGame
	}
	if req.SoundKen != nil {
		setting.SoundKen = *req.SoundKen
	}
	if req.FontSize != nil {
		setting.FontSize = *req.FontSize
	}
	if req.WallpaperURL != nil {
		setting.WallpaperURL = *req.WallpaperURL
	}

	if err := s.repo.UpsertSettings(setting); err != nil {
		return nil, err
	}

	resp := toUserSettingsResponse(setting)
	s.cacheSettings(userID, resp)
	return resp, nil
}
