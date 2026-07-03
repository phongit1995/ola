package usersetting

import (
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Service struct {
	repo   *Repository
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:   repo,
		logger: logger.Named("[usersetting_service]"),
	}
}

func defaultUserSettings(userID uuid.UUID) *models.UserSetting {
	return &models.UserSetting{
		UserID:         userID,
		MessagePrivacy: models.SettingMessagePrivacyAll,
		MeVisibility:   models.SettingMeVisibilityAll,
		CommentPrivacy: models.SettingCommentPrivacyAll,
		ShowOnline:     true,
		ShowBirthday:   true,
		NotifMessage:   true,
		NotifSound:     true,
		NotifVibrate:   true,
		FontSize:       models.SettingFontSizeMedium,
		WallpaperURL:   "",
	}
}

func toUserSettingsResponse(setting *models.UserSetting) *UserSettingsResponse {
	return &UserSettingsResponse{
		MessagePrivacy: setting.MessagePrivacy,
		MeVisibility:   setting.MeVisibility,
		CommentPrivacy: setting.CommentPrivacy,
		ShowOnline:     setting.ShowOnline,
		ShowBirthday:   setting.ShowBirthday,
		NotifMessage:   setting.NotifMessage,
		NotifSound:     setting.NotifSound,
		NotifVibrate:   setting.NotifVibrate,
		FontSize:       setting.FontSize,
		WallpaperURL:   setting.WallpaperURL,
	}
}

func (s *Service) GetSettings(userID uuid.UUID) (*UserSettingsResponse, error) {
	setting, err := s.repo.GetSettings(userID)
	if err != nil {
		return nil, err
	}
	if setting == nil {
		setting = defaultUserSettings(userID)
	}
	return toUserSettingsResponse(setting), nil
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
	if req.ShowOnline != nil {
		setting.ShowOnline = *req.ShowOnline
	}
	if req.ShowBirthday != nil {
		setting.ShowBirthday = *req.ShowBirthday
	}
	if req.NotifMessage != nil {
		setting.NotifMessage = *req.NotifMessage
	}
	if req.NotifSound != nil {
		setting.NotifSound = *req.NotifSound
	}
	if req.NotifVibrate != nil {
		setting.NotifVibrate = *req.NotifVibrate
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
	return toUserSettingsResponse(setting), nil
}
