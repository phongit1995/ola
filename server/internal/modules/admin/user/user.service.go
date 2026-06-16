package adminuser

import (
	"ola-chat-server/internal/models"
	"errors"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo   *Repository
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, logger: logger.Named("[admin_user_service]")}
}

func (s *Service) List(f ListFilter) (*ListUsersResponse, error) {
	users, total, err := s.repo.List(f)
	if err != nil {
		return nil, err
	}

	items := make([]UserListItem, 0, len(users))
	for _, u := range users {
		items = append(items, UserListItem{
			ID:          u.ID.String(),
			Username:    u.Username,
			FullName:    u.FullName,
			Email:       u.Email,
			Avatar:      u.Avatar,
			Gender:      u.Gender,
			Ken:         u.Ken,
			IsVip:       isVip(u),
			IsActive:    u.IsActive,
			CreatedAt:   u.CreatedAt.UTC().Format(time.RFC3339),
			LastLoginAt: formatTime(u.LastLoginAt),
		})
	}

	return &ListUsersResponse{
		Items:  items,
		Total:  total,
		Limit:  f.Limit,
		Offset: f.Offset,
	}, nil
}

func (s *Service) GetByID(id uuid.UUID) (*UserDetail, error) {
	user, err := s.repo.FindByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("user not found")
		}
		return nil, err
	}
	return toDetail(user), nil
}

func (s *Service) SetStatus(id uuid.UUID, active bool) (*UserDetail, error) {
	if _, err := s.repo.FindByID(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("user not found")
		}
		return nil, err
	}

	if err := s.repo.SetActive(id, active); err != nil {
		return nil, err
	}

	s.logger.Infow("Admin updated user status", "user_id", id, "is_active", active)

	user, err := s.repo.FindByID(id)
	if err != nil {
		return nil, err
	}
	return toDetail(user), nil
}

func (s *Service) Delete(id uuid.UUID) error {
	if _, err := s.repo.FindByID(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("user not found")
		}
		return err
	}

	if err := s.repo.SoftDelete(id); err != nil {
		return err
	}

	s.logger.Infow("Admin deleted user", "user_id", id)
	return nil
}

func toDetail(u *models.User) *UserDetail {
	d := &UserDetail{
		ID:             u.ID.String(),
		Username:       u.Username,
		FullName:       u.FullName,
		Email:          u.Email,
		Avatar:         u.Avatar,
		Phone:          u.Phone,
		Bio:            u.Bio,
		Gender:         u.Gender,
		DateOfBirth:    formatDate(u.DateOfBirth),
		Ken:            u.Ken,
		IsVip:          isVip(u),
		VipEndTime:     formatTime(u.VipEndTime),
		FollowerCount:  u.FollowerCount,
		FollowingCount: u.FollowingCount,
		IsActive:       u.IsActive,
		LastLoginIP:    u.LastLoginIP,
		LastLoginAt:    formatTime(u.LastLoginAt),
		CreatedAt:      u.CreatedAt.UTC().Format(time.RFC3339),
		UpdatedAt:      u.UpdatedAt.UTC().Format(time.RFC3339),
	}
	if u.VipUsed != nil {
		d.VipUsed = *u.VipUsed
	}
	return d
}

func isVip(u *models.User) bool {
	return u.VipEndTime != nil && u.VipEndTime.After(time.Now())
}

func formatTime(t *time.Time) string {
	if t == nil {
		return ""
	}
	return t.UTC().Format(time.RFC3339)
}

func formatDate(t *time.Time) string {
	if t == nil {
		return ""
	}
	return t.UTC().Format("2006-01-02")
}
