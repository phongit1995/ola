package adminuser

import (
	"errors"
	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"
	"strconv"
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
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}
	return toDetail(user), nil
}

func (s *Service) SetStatus(id uuid.UUID, active bool) (*UserDetail, error) {
	if _, err := s.repo.FindByID(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
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

func (s *Service) ListVips(id uuid.UUID, limit, offset int) (*VipIconListResponse, error) {
	user, err := s.repo.FindByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}

	total, err := s.repo.CountVipIcons(id)
	if err != nil {
		return nil, err
	}

	activeSort := int16(-1)
	if user.VipUsed != nil {
		if n, convErr := strconv.Atoi(*user.VipUsed); convErr == nil {
			activeSort = int16(n)
		}
	}

	items, err := s.repo.ListVipIcons(id, activeSort, limit, offset)
	if err != nil {
		return nil, err
	}

	out := make([]VipIconItem, 0, len(items))
	for i := range items {
		using := user.VipUsedInstanceID != nil && *user.VipUsedInstanceID == items[i].ID
		out = append(out, VipIconItem{
			InstanceID: items[i].ID.String(),
			TypeID:     items[i].VipIconID,
			IsLocked:   items[i].IsLocked,
			IsUsing:    using,
			Source:     items[i].Source,
			AcquiredAt: items[i].AcquiredAt.UTC().Format(time.RFC3339),
		})
	}

	return &VipIconListResponse{
		Items:  out,
		Total:  total,
		Limit:  limit,
		Offset: offset,
	}, nil
}

func (s *Service) Delete(id uuid.UUID) error {
	if _, err := s.repo.FindByID(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return apperr.ErrUserNotFound
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
