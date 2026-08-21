package announcement

import (
	"errors"
	"strings"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

var (
	ErrAnnouncementNotFound = errors.New("announcement not found")
	ErrInvalidScheduleTime  = errors.New("invalid schedule time, expected RFC3339")
	ErrInvalidScheduleRange = errors.New("ends at must be after starts at")
	ErrTitleRequired        = errors.New("title must not be empty")
	ErrInvalidLink          = errors.New("link must start with http:// or https://")
)

func validateLink(link string) error {
	if link == "" {
		return nil
	}
	if !strings.HasPrefix(link, "http://") && !strings.HasPrefix(link, "https://") {
		return ErrInvalidLink
	}
	return nil
}

func parseScheduleTime(value *string) (*time.Time, bool, error) {
	if value == nil {
		return nil, false, nil
	}
	trimmed := strings.TrimSpace(*value)
	if trimmed == "" {
		return nil, true, nil
	}
	parsed, err := time.Parse(time.RFC3339, trimmed)
	if err != nil {
		return nil, false, ErrInvalidScheduleTime
	}
	return &parsed, true, nil
}

func validateScheduleRange(startsAt, endsAt *time.Time) error {
	if startsAt != nil && endsAt != nil && !endsAt.After(*startsAt) {
		return ErrInvalidScheduleRange
	}
	return nil
}

type Service struct {
	repo *Repository
}

func NewService(repo *Repository) *Service {
	return &Service{repo: repo}
}

func (s *Service) LatestActive() (*models.Announcement, error) {
	return s.repo.LatestActive()
}

func (s *Service) ListAll() (*AnnouncementListResponse, error) {
	items, err := s.repo.List()
	if err != nil {
		return nil, err
	}
	return &AnnouncementListResponse{Total: int64(len(items)), Items: items}, nil
}

func (s *Service) Create(req CreateAnnouncementRequest) (*models.Announcement, error) {
	startsAt, _, err := parseScheduleTime(req.StartsAt)
	if err != nil {
		return nil, err
	}
	endsAt, _, err := parseScheduleTime(req.EndsAt)
	if err != nil {
		return nil, err
	}
	if err := validateScheduleRange(startsAt, endsAt); err != nil {
		return nil, err
	}

	title := strings.TrimSpace(req.Title)
	if title == "" {
		return nil, ErrTitleRequired
	}
	link := strings.TrimSpace(req.Link)
	if err := validateLink(link); err != nil {
		return nil, err
	}

	item := &models.Announcement{
		Title:    title,
		Content:  strings.TrimSpace(req.Content),
		Link:     link,
		IsActive: true,
		StartsAt: startsAt,
		EndsAt:   endsAt,
	}
	if req.IsActive != nil {
		item.IsActive = *req.IsActive
	}
	if err := s.repo.Create(item); err != nil {
		return nil, err
	}
	return item, nil
}

func (s *Service) Update(id uuid.UUID, req UpdateAnnouncementRequest) (*models.Announcement, error) {
	item, err := s.repo.FindByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrAnnouncementNotFound
		}
		return nil, err
	}

	if req.Title != nil {
		title := strings.TrimSpace(*req.Title)
		if title == "" {
			return nil, ErrTitleRequired
		}
		item.Title = title
	}
	if req.Content != nil {
		item.Content = strings.TrimSpace(*req.Content)
	}
	if req.Link != nil {
		link := strings.TrimSpace(*req.Link)
		if err := validateLink(link); err != nil {
			return nil, err
		}
		item.Link = link
	}
	if req.IsActive != nil {
		item.IsActive = *req.IsActive
	}
	if startsAt, set, err := parseScheduleTime(req.StartsAt); err != nil {
		return nil, err
	} else if set {
		item.StartsAt = startsAt
	}
	if endsAt, set, err := parseScheduleTime(req.EndsAt); err != nil {
		return nil, err
	} else if set {
		item.EndsAt = endsAt
	}
	if err := validateScheduleRange(item.StartsAt, item.EndsAt); err != nil {
		return nil, err
	}

	if err := s.repo.Save(item); err != nil {
		return nil, err
	}
	return item, nil
}

func (s *Service) Delete(id uuid.UUID) error {
	if _, err := s.repo.FindByID(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrAnnouncementNotFound
		}
		return err
	}
	return s.repo.Delete(id)
}
