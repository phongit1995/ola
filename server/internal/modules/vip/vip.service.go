package vip

import (
	"errors"
	"math"
	"strconv"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/user"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrVipNotFound        = errors.New("vip icon not found")
	ErrVipNotOwned        = errors.New("vip does not belong to you")
	ErrVipLocked          = errors.New("vip is locked")
	ErrVipExpired         = errors.New("vip membership expired")
	ErrPrivateStore       = errors.New("vip store is private")
	ErrCannotTransferSelf = errors.New("cannot transfer to yourself")
	ErrUserNotFound       = errors.New("user not found")
)

type Service struct {
	repo      *Repository
	userCache *user.CacheService
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, userCache *user.CacheService, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		userCache: userCache,
		logger:    logger.Named("[vip_service]"),
	}
}

func parseTypeID(vipUsed *string) *int16 {
	if vipUsed == nil || *vipUsed == "" {
		return nil
	}
	n, err := strconv.Atoi(*vipUsed)
	if err != nil {
		return nil
	}
	v := int16(n)
	return &v
}

func remainingDays(end *time.Time) *int {
	if end == nil {
		return nil
	}
	now := time.Now()
	if !end.After(now) {
		return nil
	}
	d := int(math.Ceil(end.Sub(now).Hours() / 24))
	return &d
}

func toVipItem(item *models.UserVipIcon, active *int16) VipItem {
	using := active != nil && *active == item.VipIconID
	return VipItem{
		InstanceID: item.ID.String(),
		TypeID:     item.VipIconID,
		IsLocked:   item.IsLocked,
		IsUsing:    using,
		Source:     item.Source,
		AcquiredAt: item.AcquiredAt.Format(time.RFC3339),
	}
}

func (s *Service) invalidate(userID uuid.UUID) {
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after vip change", "user_id", userID, "error", err.Error())
	}
}

func (s *Service) GetStore(viewerID, targetID uuid.UUID, limit, offset int) (*StoreResponse, error) {
	target, err := s.repo.GetUser(targetID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrUserNotFound
		}
		return nil, err
	}

	if viewerID != targetID {
		switch target.VipStorePrivacy {
		case 2:
			return nil, ErrPrivateStore
		case 1:
			ok, err := s.repo.AreFriends(viewerID, targetID)
			if err != nil {
				return nil, err
			}
			if !ok {
				return nil, ErrPrivateStore
			}
		}
	}

	total, err := s.repo.CountByUser(targetID)
	if err != nil {
		return nil, err
	}

	active := parseTypeID(target.VipUsed)
	activeSort := int16(-1)
	if active != nil {
		activeSort = *active
	}

	items, err := s.repo.ListByUserPaged(targetID, activeSort, limit, offset)
	if err != nil {
		return nil, err
	}

	out := make([]VipItem, 0, len(items))
	for i := range items {
		out = append(out, toVipItem(&items[i], active))
	}

	resp := &StoreResponse{
		UserID:       targetID.String(),
		ActiveTypeID: active,
		Days:         remainingDays(target.VipEndTime),
		Privacy:      target.VipStorePrivacy,
		Total:        int(total),
		Limit:        limit,
		Offset:       offset,
		Items:        out,
	}
	if target.VipEndTime != nil {
		t := target.VipEndTime.Format(time.RFC3339)
		resp.VipEndTime = &t
	}
	return resp, nil
}

func (s *Service) ownedInstance(userID, instanceID uuid.UUID) (*models.UserVipIcon, error) {
	item, err := s.repo.FindInstance(instanceID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrVipNotFound
		}
		return nil, err
	}
	if item.UserID != userID {
		return nil, ErrVipNotOwned
	}
	return item, nil
}

func (s *Service) Use(userID, instanceID uuid.UUID) error {
	item, err := s.ownedInstance(userID, instanceID)
	if err != nil {
		return err
	}

	u, err := s.repo.GetUser(userID)
	if err != nil {
		return err
	}
	if u.VipEndTime == nil || !u.VipEndTime.After(time.Now()) {
		return ErrVipExpired
	}

	typeStr := strconv.Itoa(int(item.VipIconID))
	if u.VipUsed != nil && *u.VipUsed == typeStr {
		return nil
	}

	newEnd := u.VipEndTime.Add(-24 * time.Hour)
	if err := s.repo.UpdateUserFields(userID, map[string]interface{}{
		"vip_used":     typeStr,
		"vip_end_time": newEnd,
	}); err != nil {
		return err
	}
	s.invalidate(userID)
	return nil
}

func (s *Service) SetLock(userID, instanceID uuid.UUID, locked bool) error {
	if _, err := s.ownedInstance(userID, instanceID); err != nil {
		return err
	}
	return s.repo.SetLocked(instanceID, locked)
}

func (s *Service) Delete(userID, instanceID uuid.UUID) error {
	item, err := s.ownedInstance(userID, instanceID)
	if err != nil {
		return err
	}
	if item.IsLocked {
		return ErrVipLocked
	}
	if err := s.repo.SoftDelete(instanceID); err != nil {
		return err
	}
	return s.clearActiveIfGone(userID, instanceID, item.VipIconID)
}

func (s *Service) Transfer(userID, instanceID, toUserID uuid.UUID) error {
	if toUserID == userID {
		return ErrCannotTransferSelf
	}
	exists, err := s.repo.UserExists(toUserID)
	if err != nil {
		return err
	}
	if !exists {
		return ErrUserNotFound
	}

	item, err := s.ownedInstance(userID, instanceID)
	if err != nil {
		return err
	}
	if item.IsLocked {
		return ErrVipLocked
	}
	if err := s.repo.Transfer(instanceID, toUserID); err != nil {
		return err
	}
	return s.clearActiveIfGone(userID, instanceID, item.VipIconID)
}

func (s *Service) clearActiveIfGone(userID, instanceID uuid.UUID, typeID int16) error {
	u, err := s.repo.GetUser(userID)
	if err != nil {
		return err
	}
	active := parseTypeID(u.VipUsed)
	if active == nil || *active != typeID {
		return nil
	}
	count, err := s.repo.CountTypeOwned(userID, typeID, instanceID)
	if err != nil {
		return err
	}
	if count > 0 {
		return nil
	}
	if err := s.repo.UpdateUserFields(userID, map[string]interface{}{"vip_used": nil}); err != nil {
		return err
	}
	s.invalidate(userID)
	return nil
}

func (s *Service) Buy(userID uuid.UUID, typeID int16) (*VipItem, error) {
	item := &models.UserVipIcon{
		UserID:     userID,
		VipIconID:  typeID,
		Source:     "purchase",
		AcquiredAt: time.Now(),
	}
	if err := s.repo.Create(item); err != nil {
		return nil, err
	}
	u, _ := s.repo.GetUser(userID)
	var active *int16
	if u != nil {
		active = parseTypeID(u.VipUsed)
	}
	out := toVipItem(item, active)
	return &out, nil
}

func (s *Service) Extend(userID uuid.UUID, days int) error {
	u, err := s.repo.GetUser(userID)
	if err != nil {
		return err
	}
	base := time.Now()
	if u.VipEndTime != nil && u.VipEndTime.After(base) {
		base = *u.VipEndTime
	}
	newEnd := base.Add(time.Duration(days) * 24 * time.Hour)
	if err := s.repo.UpdateUserFields(userID, map[string]interface{}{"vip_end_time": newEnd}); err != nil {
		return err
	}
	s.invalidate(userID)
	return nil
}

func (s *Service) SetPrivacy(userID uuid.UUID, privacy int16) error {
	return s.repo.UpdateUserFields(userID, map[string]interface{}{"vip_store_privacy": privacy})
}
