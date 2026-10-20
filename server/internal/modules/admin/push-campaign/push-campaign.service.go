package adminpushcampaign

import (
	"context"
	"errors"
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	pushBroadcastEvents "ola-chat-server/internal/domain/push-broadcast"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrPushDisabled     = utils.NewHTTPError(http.StatusBadRequest, "push notifications are disabled in settings")
	ErrEmptyContent     = utils.NewHTTPError(http.StatusBadRequest, "title and body are required")
	ErrUsernameRequired = utils.NewHTTPError(http.StatusBadRequest, "username is required for a single-user push")
	ErrUserNotFound     = utils.NewHTTPError(http.StatusNotFound, "user not found")
	ErrQueueFailed      = utils.NewHTTPError(http.StatusServiceUnavailable, "failed to queue push campaign")
)

type Service struct {
	repo     *Repository
	producer *kafka.Producer
	logger   *zap.SugaredLogger
}

func NewService(repo *Repository, producer *kafka.Producer, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, producer: producer, logger: logger.Named("[admin_push_campaign_service]")}
}

func (s *Service) Audience(audience, username string) (*AudienceResponse, error) {
	targetUserID, err := s.resolveTarget(audience, username)
	if err != nil {
		if errors.Is(err, ErrUsernameRequired) {
			return &AudienceResponse{}, nil
		}
		return nil, err
	}
	users, devices, err := s.repo.CountAudience(audience, targetUserID)
	if err != nil {
		return nil, err
	}
	return &AudienceResponse{Users: users, Devices: devices}, nil
}

func (s *Service) Create(ctx context.Context, adminID uuid.UUID, req *CreateCampaignRequest) (*CampaignItem, error) {
	title := strings.TrimSpace(req.Title)
	body := strings.TrimSpace(req.Body)
	if title == "" || body == "" {
		return nil, ErrEmptyContent
	}
	enabled, err := s.repo.PushEnabled()
	if err != nil {
		return nil, err
	}
	if !enabled {
		return nil, ErrPushDisabled
	}
	targetUserID, err := s.resolveTarget(req.Audience, req.Username)
	if err != nil {
		return nil, err
	}

	campaign := &models.PushCampaign{
		CreatedBy:    &adminID,
		Audience:     req.Audience,
		TargetUserID: targetUserID,
		Title:        title,
		Body:         body,
		Status:       constants.PushCampaignStatusQueued,
	}
	if err := s.repo.Create(campaign); err != nil {
		return nil, err
	}

	if err := s.producer.PublishPushBroadcast(ctx, &pushBroadcastEvents.Event{CampaignID: campaign.ID.String()}); err != nil {
		s.logger.Errorw("Failed to publish push broadcast", "campaign_id", campaign.ID, "error", err)
		if markErr := s.repo.MarkFailed(campaign.ID, "failed to queue: "+err.Error()); markErr != nil {
			s.logger.Warnw("Failed to mark push campaign failed", "campaign_id", campaign.ID, "error", markErr)
		}
		return nil, ErrQueueFailed
	}

	saved, err := s.repo.FindByID(campaign.ID)
	if err != nil {
		return nil, err
	}
	item := toCampaignItem(saved)
	return &item, nil
}

func (s *Service) List(limit, offset int) (*CampaignListResponse, error) {
	campaigns, total, err := s.repo.List(limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]CampaignItem, 0, len(campaigns))
	for _, campaign := range campaigns {
		items = append(items, toCampaignItem(campaign))
	}
	return &CampaignListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) resolveTarget(audience, username string) (*uuid.UUID, error) {
	if audience != constants.PushAudienceUser {
		return nil, nil
	}
	username = strings.TrimSpace(username)
	if username == "" {
		return nil, ErrUsernameRequired
	}
	user, err := s.repo.FindUserByUsername(username)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrUserNotFound
		}
		return nil, err
	}
	return &user.ID, nil
}

func toCampaignItem(campaign *models.PushCampaign) CampaignItem {
	item := CampaignItem{
		ID:           campaign.ID.String(),
		Audience:     campaign.Audience,
		Title:        campaign.Title,
		Body:         campaign.Body,
		Status:       campaign.Status,
		TotalDevices: campaign.TotalDevices,
		SuccessCount: campaign.SuccessCount,
		FailureCount: campaign.FailureCount,
		Error:        campaign.Error,
		CreatedAt:    campaign.CreatedAt.UTC().Format(time.RFC3339),
	}
	if campaign.StartedAt != nil {
		item.StartedAt = campaign.StartedAt.UTC().Format(time.RFC3339)
	}
	if campaign.FinishedAt != nil {
		item.FinishedAt = campaign.FinishedAt.UTC().Format(time.RFC3339)
	}
	if campaign.TargetUser != nil {
		item.TargetUser = &UserBrief{
			ID:       campaign.TargetUser.ID.String(),
			Username: campaign.TargetUser.Username,
			FullName: campaign.TargetUser.FullName,
			Avatar:   campaign.TargetUser.Avatar,
		}
	}
	if campaign.Creator != nil {
		item.CreatedBy = &AdminBrief{
			ID:       campaign.Creator.ID.String(),
			Username: campaign.Creator.Username,
			FullName: campaign.Creator.FullName,
		}
	}
	return item
}
