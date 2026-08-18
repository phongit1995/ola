package adminuser

import (
	"context"
	"errors"
	"fmt"
	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/constants"
	userBanEvents "ola-chat-server/internal/domain/user-ban"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/session"
	"ola-chat-server/internal/modules/vip"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/utils"
	"regexp"
	"strconv"
	"strings"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

const (
	usernameMinLen = 2
	usernameMaxLen = 20
	passwordMinLen = 6
	passwordMaxLen = 20
)

var usernameRegex = regexp.MustCompile(`^[a-z0-9][a-z0-9._-]*[a-z0-9]$`)

type Service struct {
	repo           *Repository
	cache          *services.CacheService
	sessionService *session.Service
	producer       *kafka.Producer
	vipService     *vip.Service
	logger         *zap.SugaredLogger
}

func NewService(repo *Repository, cache *services.CacheService, sessionService *session.Service, producer *kafka.Producer, vipService *vip.Service, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:           repo,
		cache:          cache,
		sessionService: sessionService,
		producer:       producer,
		vipService:     vipService,
		logger:         logger.Named("[admin_user_service]"),
	}
}

func (s *Service) List(f ListFilter) (*ListUsersResponse, error) {
	users, total, err := s.repo.List(f)
	if err != nil {
		return nil, err
	}

	items := make([]UserListItem, 0, len(users))
	for _, u := range users {
		items = append(items, UserListItem{
			ID:            u.ID.String(),
			Username:      u.Username,
			FullName:      u.FullName,
			Email:         u.Email,
			Avatar:        u.Avatar,
			Gender:        u.Gender,
			Ken:           u.Ken,
			IsVip:         isVip(u),
			IsActive:      u.IsActive,
			EmailVerified: u.EmailVerified,
			CreatedAt:     u.CreatedAt.UTC().Format(time.RFC3339),
			LastLoginAt:   formatTime(u.LastLoginAt),
			DeletedAt:     formatDeletedAt(u.DeletedAt),
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
	user, err := s.repo.FindByIDUnscoped(id)
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

	if !active {
		if n, err := s.sessionService.RevokeAllForUser(id); err != nil {
			s.logger.Warnw("Failed to revoke sessions on ban", "user_id", id, "error", err.Error())
		} else {
			s.logger.Infow("Revoked sessions on ban", "user_id", id, "count", n)
		}
		event := &userBanEvents.Event{UserID: id.String()}
		utils.PublishAsync(s.logger, "user banned", func(ctx context.Context) error {
			return s.producer.PublishUserBanned(ctx, event)
		})
	}

	s.logger.Infow("Admin updated user status", "user_id", id, "is_active", active)

	user, err := s.repo.FindByID(id)
	if err != nil {
		return nil, err
	}
	return toDetail(user), nil
}

func (s *Service) UpdateUsername(id uuid.UUID, username string) (*UserDetail, error) {
	username = strings.ToLower(strings.TrimSpace(username))
	if len(username) < usernameMinLen || len(username) > usernameMaxLen {
		return nil, fmt.Errorf("username must be between %d and %d characters", usernameMinLen, usernameMaxLen)
	}
	if !usernameRegex.MatchString(username) {
		return nil, errors.New("username may only contain lowercase letters, numbers, dot (.), hyphen (-) and underscore (_), and must start and end with a letter or number")
	}

	if _, err := s.repo.FindByIDUnscoped(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}

	taken, err := s.repo.UsernameTaken(username, id)
	if err != nil {
		return nil, err
	}
	if taken {
		return nil, errors.New("username already exists")
	}

	if err := s.repo.SetUsername(id, username); err != nil {
		if strings.Contains(err.Error(), "users_username_key") {
			return nil, errors.New("username already exists")
		}
		return nil, err
	}

	if err := s.cache.Delete(fmt.Sprintf(constants.CacheKeyUserProfile, id.String())); err != nil {
		s.logger.Warnw("Failed to invalidate user profile cache", "user_id", id, "error", err.Error())
	}

	s.logger.Infow("Admin updated username", "user_id", id, "username", username)

	user, err := s.repo.FindByIDUnscoped(id)
	if err != nil {
		return nil, err
	}
	return toDetail(user), nil
}

func (s *Service) ResetPassword(id uuid.UUID, password string) error {
	if len(password) < passwordMinLen || len(password) > passwordMaxLen {
		return fmt.Errorf("password must be between %d and %d characters", passwordMinLen, passwordMaxLen)
	}

	if _, err := s.repo.FindByID(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return apperr.ErrUserNotFound
		}
		return err
	}

	hashed, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	if err := s.repo.UpdatePassword(id, string(hashed)); err != nil {
		return err
	}

	s.logger.Infow("Admin reset user password", "user_id", id)
	return nil
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
		out = append(out, toVipIconItem(items[i], using))
	}

	return &VipIconListResponse{
		Items:  out,
		Total:  total,
		Limit:  limit,
		Offset: offset,
	}, nil
}

func (s *Service) GrantVip(id uuid.UUID, typeID int16) (*VipIconItem, error) {
	if _, err := s.repo.FindByID(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}

	icon := &models.UserVipIcon{
		UserID:     id,
		VipIconID:  typeID,
		Source:     "admin",
		AcquiredAt: time.Now(),
	}
	if err := s.repo.CreateVipIcon(icon); err != nil {
		return nil, err
	}

	if err := s.cache.Delete(fmt.Sprintf(constants.CacheKeyUserProfile, id.String())); err != nil {
		s.logger.Warnw("Failed to invalidate user profile cache", "user_id", id, "error", err.Error())
	}

	s.logger.Infow("Admin granted vip icon", "user_id", id, "vip_type_id", typeID)

	item := toVipIconItem(*icon, false)
	return &item, nil
}

func (s *Service) DeleteVip(id, instanceID uuid.UUID) error {
	if _, err := s.repo.FindByID(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return apperr.ErrUserNotFound
		}
		return err
	}

	if err := s.vipService.AdminDelete(id, instanceID); err != nil {
		return err
	}

	if err := s.cache.Delete(fmt.Sprintf(constants.CacheKeyUserProfile, id.String())); err != nil {
		s.logger.Warnw("Failed to invalidate user profile cache", "user_id", id, "error", err.Error())
	}

	s.logger.Infow("Admin deleted vip icon", "user_id", id, "instance_id", instanceID)

	return nil
}

func (s *Service) AddVipDays(id uuid.UUID, action string, days int) (*AddVipDaysResponse, error) {
	if _, err := s.repo.FindByID(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}

	var purchase *models.VipPurchase
	var err error
	if action == "subtract" {
		purchase, err = s.vipService.DeductDays(id, days, "admin", fmt.Sprintf("Admin trừ %d ngày VIP", days))
	} else {
		purchase, err = s.vipService.GrantDays(id, days, "admin", fmt.Sprintf("Admin tặng %d ngày VIP", days))
	}
	if err != nil {
		return nil, err
	}

	if err := s.cache.Delete(fmt.Sprintf(constants.CacheKeyUserProfile, id.String())); err != nil {
		s.logger.Warnw("Failed to invalidate user profile cache", "user_id", id, "error", err.Error())
	}

	s.logger.Infow("Admin adjusted vip days", "user_id", id, "action", action, "days", days)

	return &AddVipDaysResponse{
		Days:       purchase.Days,
		VipEndTime: purchase.VipEndTimeAfter.UTC().Format(time.RFC3339),
	}, nil
}

func (s *Service) ListSessions(id uuid.UUID, limit, offset int) (*SessionListResponse, error) {
	if _, err := s.repo.FindByIDUnscoped(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}

	total, err := s.repo.CountSessions(id)
	if err != nil {
		return nil, err
	}

	sessions, err := s.repo.ListSessions(id, limit, offset)
	if err != nil {
		return nil, err
	}

	items := make([]SessionItem, 0, len(sessions))
	for i := range sessions {
		items = append(items, toSessionItem(sessions[i]))
	}

	return &SessionListResponse{
		Items:  items,
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
		ID:              u.ID.String(),
		Username:        u.Username,
		FullName:        u.FullName,
		Email:           u.Email,
		Avatar:          u.Avatar,
		Phone:           u.Phone,
		Bio:             u.Bio,
		Gender:          u.Gender,
		DateOfBirth:     formatDate(u.DateOfBirth),
		Ken:             u.Ken,
		IsVip:           isVip(u),
		VipEndTime:      formatTime(u.VipEndTime),
		FollowerCount:   u.FollowerCount,
		FollowingCount:  u.FollowingCount,
		IsActive:        u.IsActive,
		EmailVerified:   u.EmailVerified,
		EmailVerifiedAt: formatTime(u.EmailVerifiedAt),
		LastLoginIP:     u.LastLoginIP,
		LastLoginAt:     formatTime(u.LastLoginAt),
		CreatedAt:       u.CreatedAt.UTC().Format(time.RFC3339),
		UpdatedAt:       u.UpdatedAt.UTC().Format(time.RFC3339),
		DeletedAt:       formatDeletedAt(u.DeletedAt),
	}
	if u.VipUsed != nil {
		d.VipUsed = *u.VipUsed
	}
	return d
}

func toVipIconItem(icon models.UserVipIcon, isUsing bool) VipIconItem {
	return VipIconItem{
		InstanceID: icon.ID.String(),
		TypeID:     icon.VipIconID,
		IsLocked:   icon.IsLocked,
		IsUsing:    isUsing,
		Source:     icon.Source,
		AcquiredAt: icon.AcquiredAt.UTC().Format(time.RFC3339),
	}
}

func toSessionItem(sess models.UserSession) SessionItem {
	return SessionItem{
		ID:           sess.ID.String(),
		DeviceName:   sess.DeviceName,
		Platform:     sess.Platform,
		AppVersion:   sess.AppVersion,
		IPAddress:    sess.IPAddress,
		UserAgent:    sess.UserAgent,
		IsActive:     sess.RevokedAt == nil,
		LastActiveAt: sess.LastActiveAt.UTC().Format(time.RFC3339),
		CreatedAt:    sess.CreatedAt.UTC().Format(time.RFC3339),
		RevokedAt:    formatTime(sess.RevokedAt),
	}
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

func formatDeletedAt(d gorm.DeletedAt) string {
	if !d.Valid {
		return ""
	}
	return d.Time.UTC().Format(time.RFC3339)
}

func formatDate(t *time.Time) string {
	if t == nil {
		return ""
	}
	return t.UTC().Format("2006-01-02")
}
