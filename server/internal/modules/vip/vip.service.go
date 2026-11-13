package vip

import (
	"errors"
	"fmt"
	"math"
	"net/http"
	"strconv"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/notification"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

var (
	ErrVipNotFound        = errors.New("vip icon not found")
	ErrVipNotOwned        = errors.New("vip does not belong to you")
	ErrVipLocked          = errors.New("vip is locked")
	ErrVipNotTransferable = utils.NewHTTPErrorWithCode(http.StatusForbidden, "vip icon from a gift code cannot be transferred", ErrorCodeVipNotTransferable)
	ErrVipInUse           = errors.New("vip is in use")
	ErrWrongPassword      = errors.New("invalid transfer password")
	ErrVipExpired         = errors.New("vip membership expired")
	ErrPrivateStore       = errors.New("vip store is private")
	ErrCannotTransferSelf = errors.New("cannot transfer to yourself")
	ErrUserNotFound       = apperr.ErrUserNotFound
	ErrPackageNotFound    = errors.New("vip package not found")
	ErrReceiverNotFound   = errors.New("receiver not found")
	ErrCannotGiftSelf     = errors.New("cannot gift to yourself")
	ErrShopItemNotFound   = errors.New("vip shop item not found")
	ErrShopTypeExists     = errors.New("vip already in shop")
	ErrBlockedGift        = errors.New("cannot gift to blocked user")
	ErrBlockedTransfer    = errors.New("cannot transfer vip to a blocked user")

	ErrDayTransferDisabled    = utils.NewHTTPErrorWithCode(http.StatusForbidden, "vip day transfer is disabled", ErrorCodeDayTransferOff)
	ErrDayTransferInvalidDays = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "invalid vip day transfer amount", ErrorCodeDayTransferDays)
	ErrDayTransferNotEnough   = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "not enough vip days to transfer", ErrorCodeDayTransferBalance)
	ErrDayTransferRateChanged = utils.NewHTTPErrorWithCode(http.StatusConflict, "vip day transfer rate changed", ErrorCodeDayTransferRate)
)

type Service struct {
	repo      *Repository
	relRepo   *relationships.Repository
	userCache *user.CacheService
	cache     *services.CacheService
	wsServer  *websocket.Server
	notifSvc  *notification.Service
	settings  *setting.Service
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, relRepo *relationships.Repository, userCache *user.CacheService, cache *services.CacheService, wsServer *websocket.Server, notifSvc *notification.Service, settings *setting.Service, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		relRepo:   relRepo,
		userCache: userCache,
		cache:     cache,
		wsServer:  wsServer,
		notifSvc:  notifSvc,
		settings:  settings,
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

func toVipItem(item *models.UserVipIcon, activeInstance *uuid.UUID) VipItem {
	using := activeInstance != nil && *activeInstance == item.ID
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

	privacy, err := s.repo.GetVipStorePrivacy(targetID)
	if err != nil {
		return nil, err
	}

	if viewerID != targetID {
		switch privacy {
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
		out = append(out, toVipItem(&items[i], target.VipUsedInstanceID))
	}

	resp := &StoreResponse{
		UserID:       targetID.String(),
		ActiveTypeID: active,
		Days:         remainingDays(target.VipEndTime),
		Privacy:      privacy,
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

	if u.VipUsedInstanceID != nil && *u.VipUsedInstanceID == item.ID {
		return nil
	}

	typeStr := strconv.Itoa(int(item.VipIconID))
	if u.VipUsed != nil && *u.VipUsed == typeStr {
		if err := s.repo.UpdateUserFields(userID, map[string]interface{}{
			"vip_used_instance_id": item.ID,
		}); err != nil {
			return err
		}
		s.invalidate(userID)
		return nil
	}

	newEnd := u.VipEndTime.Add(-24 * time.Hour)
	if err := s.repo.UpdateUserFields(userID, map[string]interface{}{
		"vip_used":             typeStr,
		"vip_used_instance_id": item.ID,
		"vip_end_time":         newEnd,
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

func (s *Service) AdminDelete(userID, instanceID uuid.UUID) error {
	if _, err := s.ownedInstance(userID, instanceID); err != nil {
		return err
	}
	if err := s.repo.SoftDelete(instanceID); err != nil {
		return err
	}
	return s.clearActive(userID, instanceID)
}

func (s *Service) clearActive(userID, instanceID uuid.UUID) error {
	u, err := s.repo.GetUser(userID)
	if err != nil {
		return err
	}
	if u.VipUsedInstanceID == nil || *u.VipUsedInstanceID != instanceID {
		return nil
	}
	if err := s.repo.UpdateUserFields(userID, map[string]interface{}{
		"vip_used":             nil,
		"vip_used_instance_id": nil,
	}); err != nil {
		return err
	}
	s.invalidate(userID)
	return nil
}

func (s *Service) BatchDelete(userID uuid.UUID, instanceIDs []uuid.UUID) (int, error) {
	if len(instanceIDs) == 0 {
		return 0, nil
	}
	u, err := s.repo.GetUser(userID)
	if err != nil {
		return 0, err
	}
	items, err := s.repo.FindInstances(instanceIDs)
	if err != nil {
		return 0, err
	}
	if len(items) != len(instanceIDs) {
		return 0, ErrVipNotFound
	}
	for i := range items {
		if items[i].UserID != userID {
			return 0, ErrVipNotOwned
		}
		if items[i].IsLocked {
			return 0, ErrVipLocked
		}
		if u.VipUsedInstanceID != nil && *u.VipUsedInstanceID == items[i].ID {
			return 0, ErrVipInUse
		}
	}
	deleted, err := s.repo.SoftDeleteMany(userID, instanceIDs)
	if err != nil {
		return 0, err
	}
	return int(deleted), nil
}

func (s *Service) Transfer(userID, instanceID, toUserID uuid.UUID, password string) error {
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

	sender, err := s.repo.GetUser(userID)
	if err != nil {
		return err
	}
	if bcrypt.CompareHashAndPassword([]byte(sender.Password), []byte(password)) != nil {
		return ErrWrongPassword
	}
	blocked, err := s.relRepo.IsBlockedEither(userID, toUserID)
	if err != nil {
		return err
	}
	if blocked {
		return ErrBlockedTransfer
	}

	item, err := s.ownedInstance(userID, instanceID)
	if err != nil {
		return err
	}
	if item.Source == IconSourceGiftCode {
		return ErrVipNotTransferable
	}
	if item.IsLocked {
		return ErrVipLocked
	}
	if sender.VipUsedInstanceID != nil && *sender.VipUsedInstanceID == instanceID {
		return ErrVipInUse
	}
	if err := s.repo.Transfer(TransferParams{
		InstanceID: instanceID,
		FromUserID: userID,
		ToUserID:   toUserID,
		VipIconID:  item.VipIconID,
	}); err != nil {
		return err
	}
	s.notifSvc.Create(toUserID, &userID, models.AppNotificationVipReceived, nil, models.AppNotificationTransfer{VipTypeID: item.VipIconID}.Preview())
	return nil
}

func (s *Service) clearActiveIfGone(userID, instanceID uuid.UUID, typeID int16) error {
	u, err := s.repo.GetUser(userID)
	if err != nil {
		return err
	}
	if u.VipUsedInstanceID == nil || *u.VipUsedInstanceID != instanceID {
		return nil
	}
	replacement, err := s.repo.FindOneOfTypeExcluding(userID, typeID, instanceID)
	if err != nil {
		return err
	}
	fields := map[string]interface{}{}
	if replacement != nil {
		fields["vip_used_instance_id"] = replacement.ID
	} else {
		fields["vip_used"] = nil
		fields["vip_used_instance_id"] = nil
	}
	if err := s.repo.UpdateUserFields(userID, fields); err != nil {
		return err
	}
	s.invalidate(userID)
	return nil
}

func (s *Service) SetPrivacy(userID uuid.UUID, privacy int16) error {
	if err := s.repo.SetVipStorePrivacy(userID, privacy); err != nil {
		return err
	}
	key := fmt.Sprintf(constants.CacheKeyUserSettings, userID)
	if err := s.cache.Delete(key); err != nil {
		s.logger.Warnw("failed to invalidate user settings cache", "user_id", userID, "error", err.Error())
	}
	return nil
}
