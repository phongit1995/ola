package giftcode

import (
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/notification"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/modules/vip"
	"ola-chat-server/internal/services"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo      *Repository
	cache     *services.CacheService
	userCache *user.CacheService
	notifSvc  *notification.Service
	settings  *setting.Service
	logger    *zap.SugaredLogger
	now       func() time.Time
}

func NewService(repo *Repository, cache *services.CacheService, userCache *user.CacheService, notifSvc *notification.Service, settings *setting.Service, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		cache:     cache,
		userCache: userCache,
		notifSvc:  notifSvc,
		settings:  settings,
		logger:    logger.Named("[gift_code_service]"),
		now:       time.Now,
	}
}

type rejection struct {
	reason     string
	campaignID *uuid.UUID
}

func (r *rejection) Error() string { return r.reason }

type redeemContext struct {
	userID     uuid.UUID
	platform   string
	deviceID   string
	deviceName string
	ip         string
	needsEmail bool
}

func (s *Service) HasRunningCampaign(platform string) (bool, error) {
	key := fmt.Sprintf(CacheKeyGiftCodeStatus, platform)
	var cached runningStatus
	if err := s.cache.Get(key, &cached); err == nil {
		return cached.Running, nil
	}
	running, err := s.repo.HasActiveCampaign(platform, s.now())
	if err != nil {
		return false, err
	}
	if err := s.cache.Set(key, runningStatus{Running: running}, CacheTTLGiftCodeStatus); err != nil {
		s.logger.Warnw("Failed to cache gift code status", "error", err.Error())
	}
	return running, nil
}

func (s *Service) Redeem(in RedeemInput) (*RedeemResponse, error) {
	cfg := s.loadConfig()
	if !cfg.EnabledFor(in.Client) {
		return nil, ErrGiftCodePlatformNotAllowed
	}
	deviceID, deviceName, err := s.repo.SessionDevice(in.SessionID)
	if err != nil {
		return nil, err
	}
	rc := redeemContext{
		userID:     in.UserID,
		platform:   in.Client.ResolvedPlatform(),
		deviceID:   deviceID,
		deviceName: deviceName,
		ip:         in.IP,
		needsEmail: cfg.RequireEmailVerified,
	}
	if s.isBlocked(rc) {
		return nil, ErrGiftCodeTooManyAttempts
	}

	code := NormalizeCode(in.Code)
	if !IsCodeInput(code) {
		return nil, s.reject(rc, code, &rejection{reason: ReasonWrong})
	}

	now := s.now()
	var campaign *models.GiftCodeCampaign
	err = s.repo.Transaction(func(tx *gorm.DB) error {
		var err error
		campaign, err = s.redeemTx(tx, rc, code, now)
		return err
	})
	if err != nil {
		var rej *rejection
		if errors.As(err, &rej) {
			return nil, s.reject(rc, code, rej)
		}
		if apperr.IsUniqueViolation(err) {
			return nil, s.reject(rc, code, &rejection{reason: ReasonRedeemed})
		}
		return nil, err
	}

	if err := s.userCache.InvalidateUser(in.UserID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after gift code", "user_id", in.UserID, "error", err.Error())
	}
	message := SuccessMessage(campaign.SuccessMessage, campaign.Rewards)
	if campaign.SendNotification {
		s.notifSvc.Create(in.UserID, nil, models.AppNotificationGiftCode, &campaign.ID, message)
	}
	return &RedeemResponse{Message: message, Rewards: toRewardItems(campaign.Rewards)}, nil
}

func (s *Service) loadConfig() setting.GiftCodeConfig {
	cfg, err := s.settings.GetGiftCode()
	if err != nil {
		s.logger.Warnw("Failed to load gift code settings, using default", "error", err.Error())
	}
	return cfg
}

func (s *Service) redeemTx(tx *gorm.DB, rc redeemContext, code string, now time.Time) (*models.GiftCodeCampaign, error) {
	ref, err := findCode(tx, code)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, &rejection{reason: ReasonWrong}
	}
	if err != nil {
		return nil, err
	}
	campaign, err := lockCampaign(tx, ref.CampaignID)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, &rejection{reason: ReasonWrong}
	}
	if err != nil {
		return nil, err
	}
	gc, err := lockCode(tx, ref.ID, campaign.ID)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, &rejection{reason: ReasonWrong}
	}
	if err != nil {
		return nil, err
	}

	if reason, err := s.eligibility(tx, campaign, gc, rc, now); err != nil {
		return nil, err
	} else if reason != "" {
		return nil, &rejection{reason: reason, campaignID: &campaign.ID}
	}

	redemption := models.GiftCodeRedemption{
		CampaignID: campaign.ID,
		CodeID:     gc.ID,
		UserID:     rc.userID,
		DeviceID:   rc.deviceID,
		DeviceName: rc.deviceName,
		Platform:   rc.platform,
		IPAddress:  rc.ip,
		Rewards:    campaign.Rewards,
		CreatedAt:  now,
	}
	if campaign.OnePerDevice && rc.deviceID != "" {
		key := rc.deviceID
		redemption.DeviceKey = &key
	}
	if err := tx.Create(&redemption).Error; err != nil {
		return nil, err
	}
	if err := markRedeemed(tx, campaign, gc, rc.userID, now); err != nil {
		return nil, err
	}
	if err := grantRewards(tx, rc.userID, code, campaign.Rewards); err != nil {
		return nil, err
	}
	return campaign, nil
}

func (s *Service) eligibility(tx *gorm.DB, campaign *models.GiftCodeCampaign, gc *models.GiftCode, rc redeemContext, now time.Time) (string, error) {
	switch {
	case !campaign.Enabled:
		return ReasonDisabled, nil
	case gc.LockedAt != nil:
		return ReasonLocked, nil
	case !PlatformAllowed(campaign, rc.platform):
		return ReasonPlatform, nil
	case campaign.StartsAt != nil && now.Before(*campaign.StartsAt):
		return ReasonNotStarted, nil
	case !now.Before(campaign.EndsAt):
		return ReasonExpired, nil
	}

	account, err := loadAccount(tx, rc.userID)
	if err != nil {
		return "", err
	}
	if rc.needsEmail && !account.EmailVerified {
		return ReasonUnverified, nil
	}

	redeemed, err := hasRedeemed(tx, campaign.ID, rc.userID)
	if err != nil {
		return "", err
	}
	if redeemed {
		return ReasonRedeemed, nil
	}

	if campaign.MinAccountAgeDays > 0 && now.Before(account.CreatedAt.Add(time.Duration(campaign.MinAccountAgeDays)*24*time.Hour)) {
		return ReasonYoung, nil
	}

	if campaign.OnePerDevice {
		if rc.deviceID == "" {
			return ReasonNoDevice, nil
		}
		used, err := deviceRedeemed(tx, campaign.ID, rc.deviceID)
		if err != nil {
			return "", err
		}
		if used {
			return ReasonDevice, nil
		}
	}

	if campaign.Kind == models.GiftCodeKindUnique && gc.UsedBy != nil {
		return ReasonUsed, nil
	}
	if campaign.UsedCount >= campaign.TotalUses {
		return ReasonSoldOut, nil
	}
	return "", nil
}

func grantRewards(tx *gorm.DB, userID uuid.UUID, code string, rewards models.GiftCodeRewards) error {
	for _, r := range rewards {
		switch r.Type {
		case models.GiftCodeRewardVipDays:
			if r.Days <= 0 {
				continue
			}
			if _, err := vip.GrantDaysTx(tx, userID, r.Days, vip.PurchaseSourceGiftCode, fmt.Sprintf(PurchaseNameVipDays, code, r.Days)); err != nil {
				return err
			}
		case models.GiftCodeRewardVipIcon:
			if r.VipIconID <= 0 {
				continue
			}
			if _, err := vip.GrantIconTx(tx, userID, r.VipIconID, vip.IconSourceGiftCode, vip.PurchaseSourceGiftCode); err != nil {
				return err
			}
		}
	}
	return nil
}

func (s *Service) reject(rc redeemContext, code string, rej *rejection) error {
	input := code
	if len(input) > CodeInputMaxLength {
		input = input[:CodeInputMaxLength]
	}
	attempt := models.GiftCodeAttempt{
		UserID:     rc.userID,
		CampaignID: rej.campaignID,
		CodeInput:  input,
		Reason:     rej.reason,
		DeviceID:   rc.deviceID,
		DeviceName: rc.deviceName,
		Platform:   rc.platform,
		IPAddress:  rc.ip,
	}
	if err := s.repo.RecordAttempt(&attempt); err != nil {
		s.logger.Warnw("Failed to record gift code attempt", "user_id", rc.userID, "error", err.Error())
	}
	if guessReasons[rej.reason] {
		s.countFailure(CacheKeyGiftCodeFailUser, CacheKeyGiftCodeBlockUser, rc.userID.String())
		if rc.deviceID != "" {
			s.countFailure(CacheKeyGiftCodeFailDevice, CacheKeyGiftCodeBlockDevice, rc.deviceID)
		}
	}
	return reasonErrors[rej.reason]
}

func (s *Service) countFailure(failFormat, blockFormat, id string) {
	failKey := fmt.Sprintf(failFormat, id)
	count, err := s.cache.Increment(failKey)
	if err != nil {
		s.logger.Warnw("Failed to count gift code failure", "key", failKey, "error", err.Error())
		return
	}
	if count == 1 {
		if err := s.cache.SetExpire(failKey, FailWindow); err != nil {
			s.logger.Warnw("Failed to expire gift code failure counter", "key", failKey, "error", err.Error())
		}
	}
	if count < FailLimit {
		return
	}
	if err := s.cache.Set(fmt.Sprintf(blockFormat, id), true, BlockDuration); err != nil {
		s.logger.Warnw("Failed to block gift code input", "key", blockFormat, "error", err.Error())
	}
	if err := s.cache.Delete(failKey); err != nil {
		s.logger.Warnw("Failed to reset gift code failure counter", "key", failKey, "error", err.Error())
	}
}

func (s *Service) isBlocked(rc redeemContext) bool {
	keys := []string{fmt.Sprintf(CacheKeyGiftCodeBlockUser, rc.userID.String())}
	if rc.deviceID != "" {
		keys = append(keys, fmt.Sprintf(CacheKeyGiftCodeBlockDevice, rc.deviceID))
	}
	for _, key := range keys {
		blocked, err := s.cache.Exists(key)
		if err != nil {
			s.logger.Warnw("Failed to check gift code block", "key", key, "error", err.Error())
			continue
		}
		if blocked {
			return true
		}
	}
	return false
}

func (s *Service) PurgeAttempts() (int64, error) {
	cutoff := s.now().Add(-AttemptRetention)
	var total int64
	for i := 0; i < CleanupDeleteBatches; i++ {
		n, err := s.repo.DeleteAttemptsBefore(cutoff, CleanupDeleteBatch)
		total += n
		if err != nil {
			return total, err
		}
		if n < CleanupDeleteBatch {
			break
		}
	}
	return total, nil
}

func toRewardItems(rewards models.GiftCodeRewards) []RewardItem {
	items := make([]RewardItem, 0, len(rewards))
	for _, r := range rewards {
		items = append(items, RewardItem{Type: r.Type, Days: r.Days, VipIconID: r.VipIconID})
	}
	return items
}
