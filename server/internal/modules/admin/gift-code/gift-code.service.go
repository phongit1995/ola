package admingiftcode

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"regexp"
	"strings"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"
	admincommon "ola-chat-server/internal/modules/admin/common"
	avatarframe "ola-chat-server/internal/modules/avatar-frame"
	giftcode "ola-chat-server/internal/modules/gift-code"
	"ola-chat-server/internal/services"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	sharedCodePattern = regexp.MustCompile(`^[A-Z0-9]+$`)
	prefixPattern     = regexp.MustCompile(`^[A-Z0-9-]*$`)
)

type Service struct {
	repo   *Repository
	cache  *services.CacheService
	logger *zap.SugaredLogger
	now    func() time.Time
}

func NewService(repo *Repository, cache *services.CacheService, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, cache: cache, logger: logger.Named("[admin_gift_code_service]"), now: time.Now}
}

type campaignDraft struct {
	name     string
	kind     string
	code     string
	prefix   string
	length   int
	total    int
	rewards  models.GiftCodeRewards
	startsAt *time.Time
	endsAt   time.Time
}

func (s *Service) List(f CampaignFilter) (*CampaignListResponse, error) {
	now := s.now()
	items, total, err := s.repo.ListCampaigns(f, now)
	if err != nil {
		return nil, err
	}
	stats, err := s.repo.Stats(now, startOfDay(now))
	if err != nil {
		return nil, err
	}
	out, err := s.toItems(items, now)
	if err != nil {
		return nil, err
	}
	return &CampaignListResponse{Items: out, Total: total, Limit: f.Limit, Offset: f.Offset, Stats: stats}, nil
}

func (s *Service) Get(id uuid.UUID) (*CampaignItem, error) {
	c, err := s.findCampaign(id)
	if err != nil {
		return nil, err
	}
	items, err := s.toItems([]models.GiftCodeCampaign{*c}, s.now())
	if err != nil {
		return nil, err
	}
	return &items[0], nil
}

func (s *Service) Create(adminID uuid.UUID, req *CampaignRequest) (*CampaignItem, error) {
	now := s.now()
	draft, err := buildDraft(req)
	if err != nil {
		return nil, err
	}
	if !draft.endsAt.After(now) {
		return nil, invalidInput("Ngày kết thúc phải sau thời điểm hiện tại")
	}
	if draft.kind == models.GiftCodeKindUnique && draft.total > MaxCodesPerBatch {
		return nil, ErrCodeLimit
	}
	if draft.kind == models.GiftCodeKindShared {
		if err := s.ensureCodeFree(draft.code); err != nil {
			return nil, err
		}
	}

	campaign := models.GiftCodeCampaign{
		CreatedBy: &adminID,
		UpdatedBy: &adminID,
	}
	applyDraft(&campaign, draft, req)
	err = s.repo.Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(&campaign).Error; err != nil {
			return err
		}
		return s.createCodes(tx, &campaign, draft)
	})
	if err != nil {
		return nil, mapCodeConflict(err)
	}
	return s.Get(campaign.ID)
}

func (s *Service) Update(adminID, id uuid.UUID, req *CampaignRequest) (*CampaignItem, error) {
	draft, err := buildDraft(req)
	if err != nil {
		return nil, err
	}
	err = s.repo.Transaction(func(tx *gorm.DB) error {
		campaign, err := s.repo.LockCampaign(tx, id)
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrCampaignNotFound
		}
		if err != nil {
			return err
		}
		sharedCodes, err := s.repo.SharedCodes([]uuid.UUID{campaign.ID})
		if err != nil {
			return err
		}
		formatChanged := campaign.Kind != draft.kind ||
			(draft.kind == models.GiftCodeKindShared && sharedCodes[campaign.ID] != draft.code) ||
			(draft.kind == models.GiftCodeKindUnique && (campaign.CodePrefix != draft.prefix || int(campaign.CodeLength) != draft.length))

		if campaign.UsedCount > 0 && (formatChanged || !sameRewards(campaign.Rewards, draft.rewards)) {
			return ErrFieldsLocked
		}
		switch {
		case draft.kind == models.GiftCodeKindShared && draft.total < campaign.UsedCount:
			return invalidInput("Tổng lượt không được nhỏ hơn số lượt đã dùng")
		case draft.kind == models.GiftCodeKindUnique && !formatChanged:
			draft.total = campaign.TotalUses
		case draft.kind == models.GiftCodeKindUnique && draft.total > MaxCodesPerBatch:
			return ErrCodeLimit
		}

		applyDraft(campaign, draft, req)
		campaign.UpdatedBy = &adminID
		if err := tx.Omit("Creator", "Updater", "CreatedBy", "CreatedAt").Save(campaign).Error; err != nil {
			return err
		}
		if !formatChanged {
			return nil
		}
		if err := tx.Where("campaign_id = ?", campaign.ID).Delete(&models.GiftCode{}).Error; err != nil {
			return err
		}
		if draft.kind == models.GiftCodeKindShared {
			taken, err := codeTakenTx(tx, draft.code)
			if err != nil {
				return err
			}
			if taken {
				return ErrCodeTaken
			}
		}
		return s.createCodes(tx, campaign, draft)
	})
	if err != nil {
		return nil, mapCodeConflict(err)
	}
	return s.Get(id)
}

func (s *Service) SetEnabled(adminID, id uuid.UUID, enabled bool) (*CampaignItem, error) {
	found, err := s.repo.SetEnabled(id, enabled, adminID, s.now())
	if err != nil {
		return nil, err
	}
	if !found {
		return nil, ErrCampaignNotFound
	}
	return s.Get(id)
}

func (s *Service) GenerateCodes(adminID, id uuid.UUID, count int) (*GenerateCodesResponse, error) {
	var resp GenerateCodesResponse
	err := s.repo.Transaction(func(tx *gorm.DB) error {
		campaign, err := s.repo.LockCampaign(tx, id)
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrCampaignNotFound
		}
		if err != nil {
			return err
		}
		if campaign.Kind != models.GiftCodeKindUnique {
			return ErrNotUniqueKind
		}
		if count > MaxCodesPerBatch || campaign.TotalUses+count > MaxCodesPerCampaign {
			return ErrCodeLimit
		}
		inserted, err := s.generate(tx, campaign.ID, campaign.CodePrefix, int(campaign.CodeLength), count)
		if err != nil {
			return err
		}
		campaign.TotalUses += inserted
		if err := tx.Model(&models.GiftCodeCampaign{}).Where("id = ?", campaign.ID).
			Updates(map[string]interface{}{"total_uses": campaign.TotalUses, "updated_by": adminID, "updated_at": s.now()}).Error; err != nil {
			return err
		}
		resp = GenerateCodesResponse{Generated: inserted, TotalUses: campaign.TotalUses}
		return nil
	})
	if err != nil {
		return nil, err
	}
	return &resp, nil
}

func (s *Service) ListCodes(id uuid.UUID, status, search string, limit, offset int) (*CodeListResponse, error) {
	if _, err := s.findCampaign(id); err != nil {
		return nil, err
	}
	items, total, err := s.repo.ListCodes(id, status, search, limit, offset)
	if err != nil {
		return nil, err
	}
	counts, err := s.repo.CodeCounts(id)
	if err != nil {
		return nil, err
	}
	out := make([]CodeItem, 0, len(items))
	for i := range items {
		out = append(out, toCodeItem(&items[i]))
	}
	return &CodeListResponse{Items: out, Total: total, Limit: limit, Offset: offset, Counts: counts}, nil
}

func (s *Service) SetCodeLock(adminID, id, codeID uuid.UUID, req *LockCodeRequest) (*CodeItem, error) {
	reason := strings.TrimSpace(req.Reason)
	if req.Locked && reason == "" {
		return nil, ErrLockReason
	}
	err := s.repo.Transaction(func(tx *gorm.DB) error {
		gc, err := s.repo.LockCode(tx, id, codeID)
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrCodeNotFound
		}
		if err != nil {
			return err
		}
		if gc.UsedAt != nil {
			return ErrCodeAlreadyUsed
		}
		updates := map[string]interface{}{"locked_at": nil, "locked_by": nil, "lock_reason": ""}
		if req.Locked {
			updates = map[string]interface{}{"locked_at": s.now(), "locked_by": adminID, "lock_reason": reason}
		}
		return tx.Model(&models.GiftCode{}).Where("id = ?", gc.ID).Updates(updates).Error
	})
	if err != nil {
		return nil, err
	}
	gc, err := s.repo.FindCode(codeID)
	if err != nil {
		return nil, err
	}
	item := toCodeItem(gc)
	return &item, nil
}

func (s *Service) ListRedemptions(id uuid.UUID, search, platform string, limit, offset int) (*RedemptionListResponse, error) {
	if _, err := s.findCampaign(id); err != nil {
		return nil, err
	}
	items, total, err := s.repo.ListRedemptions(id, search, platform, limit, offset)
	if err != nil {
		return nil, err
	}
	out := make([]RedemptionItem, 0, len(items))
	for i := range items {
		r := &items[i]
		item := RedemptionItem{
			ID:         r.ID.String(),
			User:       userBrief(r.UserID, r.User),
			Platform:   r.Platform,
			DeviceName: r.DeviceName,
			IPAddress:  r.IPAddress,
			Rewards:    toRewardItems(r.Rewards),
			CreatedAt:  r.CreatedAt.Format(time.RFC3339),
		}
		if r.Code != nil {
			item.Code = r.Code.Code
		}
		out = append(out, item)
	}
	return &RedemptionListResponse{Items: out, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) AttemptSummary(since time.Time) (*AttemptSummary, error) {
	summary, err := s.repo.AttemptSummary(since)
	if err != nil {
		return nil, err
	}
	summary.BlockedUsers = s.countKeys(fmt.Sprintf(giftcode.CacheKeyGiftCodeBlockUser, "*"))
	return &summary, nil
}

func (s *Service) AttemptUsers(f AttemptFilter) (*AttemptUserListResponse, error) {
	rows, total, err := s.repo.AttemptUsers(f)
	if err != nil {
		return nil, err
	}
	ids := make([]uuid.UUID, 0, len(rows))
	for _, row := range rows {
		ids = append(ids, row.UserID)
	}
	users, err := s.repo.FindUsersByIDs(ids)
	if err != nil {
		return nil, err
	}
	now := s.now()
	out := make([]AttemptUserItem, 0, len(rows))
	for _, row := range rows {
		u := users[row.UserID]
		item := AttemptUserItem{
			User:        admincommon.UserBriefOf(row.UserID, u.Username, u.FullName, u.Avatar),
			DeviceName:  row.DeviceName,
			Platform:    row.Platform,
			Failures:    row.Failures,
			TopReason:   row.TopReason,
			RecentCodes: recentCodes(row.RecentCodes),
			LastAt:      row.LastAt.Format(time.RFC3339),
		}
		if ttl, err := s.cache.GetTTL(fmt.Sprintf(giftcode.CacheKeyGiftCodeBlockUser, row.UserID.String())); err == nil && ttl > 0 {
			until := now.Add(ttl).Format(time.RFC3339)
			item.BlockedUntil = &until
		}
		out = append(out, item)
	}
	return &AttemptUserListResponse{Items: out, Total: total, Limit: f.Limit, Offset: f.Offset}, nil
}

func (s *Service) AttemptDevices(f AttemptFilter) (*AttemptDeviceListResponse, error) {
	rows, total, err := s.repo.AttemptDevices(f)
	if err != nil {
		return nil, err
	}
	var ids []uuid.UUID
	for _, row := range rows {
		for _, raw := range strings.Split(row.UserIDs, ",") {
			if id, err := uuid.Parse(raw); err == nil {
				ids = append(ids, id)
			}
		}
	}
	users, err := s.repo.FindUsersByIDs(ids)
	if err != nil {
		return nil, err
	}
	out := make([]AttemptDeviceItem, 0, len(rows))
	for _, row := range rows {
		accounts := make([]admincommon.UserBrief, 0)
		for _, raw := range strings.Split(row.UserIDs, ",") {
			id, err := uuid.Parse(raw)
			if err != nil {
				continue
			}
			u := users[id]
			accounts = append(accounts, admincommon.UserBriefOf(id, u.Username, u.FullName, u.Avatar))
		}
		out = append(out, AttemptDeviceItem{
			DeviceID:   row.DeviceID,
			DeviceName: row.DeviceName,
			Platform:   row.Platform,
			Accounts:   accounts,
			Failures:   row.Failures,
			Successes:  row.Successes,
			LastAt:     row.LastAt.Format(time.RFC3339),
		})
	}
	return &AttemptDeviceListResponse{Items: out, Total: total, Limit: f.Limit, Offset: f.Offset}, nil
}

func (s *Service) ListAttempts(f AttemptFilter) (*AttemptListResponse, error) {
	rows, total, err := s.repo.ListAttempts(f)
	if err != nil {
		return nil, err
	}
	ids := make([]uuid.UUID, 0, len(rows))
	for _, row := range rows {
		ids = append(ids, row.UserID)
	}
	users, err := s.repo.FindUsersByIDs(ids)
	if err != nil {
		return nil, err
	}
	out := make([]AttemptItem, 0, len(rows))
	for _, row := range rows {
		u := users[row.UserID]
		out = append(out, AttemptItem{
			ID:         row.ID.String(),
			User:       admincommon.UserBriefOf(row.UserID, u.Username, u.FullName, u.Avatar),
			CodeInput:  row.CodeInput,
			Reason:     row.Reason,
			Platform:   row.Platform,
			DeviceName: row.DeviceName,
			IPAddress:  row.IPAddress,
			CreatedAt:  row.CreatedAt.Format(time.RFC3339),
		})
	}
	return &AttemptListResponse{Items: out, Total: total, Limit: f.Limit, Offset: f.Offset}, nil
}

func (s *Service) findCampaign(id uuid.UUID) (*models.GiftCodeCampaign, error) {
	c, err := s.repo.FindCampaign(id)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, ErrCampaignNotFound
	}
	return c, err
}

func (s *Service) ensureCodeFree(code string) error {
	taken, err := s.repo.CodeExists(code)
	if err != nil {
		return err
	}
	if taken {
		return ErrCodeTaken
	}
	return nil
}

func (s *Service) createCodes(tx *gorm.DB, campaign *models.GiftCodeCampaign, draft campaignDraft) error {
	if draft.kind == models.GiftCodeKindShared {
		return tx.Create(&models.GiftCode{CampaignID: campaign.ID, Code: draft.code}).Error
	}
	inserted, err := s.generate(tx, campaign.ID, draft.prefix, draft.length, draft.total)
	if err != nil {
		return err
	}
	if inserted != draft.total {
		return tx.Model(&models.GiftCodeCampaign{}).Where("id = ?", campaign.ID).Update("total_uses", inserted).Error
	}
	return nil
}

func (s *Service) generate(tx *gorm.DB, campaignID uuid.UUID, prefix string, length, count int) (int, error) {
	inserted := 0
	for round := 0; round < GenerateMaxRounds && inserted < count; round++ {
		need := count - inserted
		seen := make(map[string]struct{}, need)
		codes := make([]string, 0, need)
		for len(codes) < need {
			code, err := giftcode.GenerateCode(prefix, length)
			if err != nil {
				return inserted, err
			}
			if _, dup := seen[code]; dup {
				continue
			}
			seen[code] = struct{}{}
			codes = append(codes, code)
		}
		n, err := s.repo.InsertCodes(tx, campaignID, codes)
		if err != nil {
			return inserted, err
		}
		inserted += n
	}
	if inserted < count {
		return inserted, invalidInput("Không sinh đủ mã, hãy tăng độ dài mã")
	}
	return inserted, nil
}

func (s *Service) toItems(campaigns []models.GiftCodeCampaign, now time.Time) ([]CampaignItem, error) {
	ids := make([]uuid.UUID, 0, len(campaigns))
	sharedIDs := make([]uuid.UUID, 0)
	for _, c := range campaigns {
		ids = append(ids, c.ID)
		if c.Kind == models.GiftCodeKindShared {
			sharedIDs = append(sharedIDs, c.ID)
		}
	}
	codes, err := s.repo.SharedCodes(sharedIDs)
	if err != nil {
		return nil, err
	}
	locked, err := s.repo.LockedCounts(ids)
	if err != nil {
		return nil, err
	}
	out := make([]CampaignItem, 0, len(campaigns))
	for i := range campaigns {
		c := &campaigns[i]
		item := CampaignItem{
			ID:                c.ID.String(),
			Name:              c.Name,
			Kind:              c.Kind,
			Code:              codes[c.ID],
			CodePrefix:        c.CodePrefix,
			CodeLength:        int(c.CodeLength),
			TotalUses:         c.TotalUses,
			UsedCount:         c.UsedCount,
			LockedCodes:       locked[c.ID],
			Rewards:           toRewardItems(c.Rewards),
			SuccessMessage:    c.SuccessMessage,
			SendNotification:  c.SendNotification,
			MinAccountAgeDays: int(c.MinAccountAgeDays),
			AllowWeb:          c.AllowWeb,
			AllowAndroid:      c.AllowAndroid,
			AllowIOS:          c.AllowIOS,
			OnePerDevice:      c.OnePerDevice,
			EndsAt:            c.EndsAt.Format(time.RFC3339),
			Enabled:           c.Enabled,
			Status:            giftcode.CampaignStatus(c, now),
			CreatedBy:         adminBrief(c.Creator),
			UpdatedBy:         adminBrief(c.Updater),
			CreatedAt:         c.CreatedAt.Format(time.RFC3339),
			UpdatedAt:         c.UpdatedAt.Format(time.RFC3339),
		}
		if c.StartsAt != nil {
			v := c.StartsAt.Format(time.RFC3339)
			item.StartsAt = &v
		}
		out = append(out, item)
	}
	return out, nil
}

func (s *Service) countKeys(pattern string) int64 {
	client := s.cache.GetClient()
	ctx := context.Background()
	var cursor uint64
	var total int64
	for {
		keys, next, err := client.Scan(ctx, cursor, pattern, 500).Result()
		if err != nil {
			s.logger.Warnw("Failed to count gift code blocks", "error", err.Error())
			return total
		}
		total += int64(len(keys))
		cursor = next
		if cursor == 0 {
			return total
		}
	}
}

func buildDraft(req *CampaignRequest) (campaignDraft, error) {
	d := campaignDraft{
		name:     strings.TrimSpace(req.Name),
		kind:     req.Kind,
		total:    req.TotalUses,
		startsAt: req.StartsAt,
		endsAt:   req.EndsAt,
	}
	if d.name == "" {
		return d, invalidInput("Nhập tên đợt")
	}
	switch d.kind {
	case models.GiftCodeKindShared:
		d.code = giftcode.NormalizeCode(req.Code)
		if len(d.code) < giftcode.SharedCodeMinLength || len(d.code) > giftcode.SharedCodeMaxLength || !sharedCodePattern.MatchString(d.code) {
			return d, invalidInput("Mã gồm 4–20 ký tự chữ và số")
		}
		if d.total > MaxSharedUses {
			return d, invalidInput("Tổng lượt tối đa 1.000.000")
		}
	case models.GiftCodeKindUnique:
		d.prefix = giftcode.NormalizeCode(req.CodePrefix)
		d.length = req.CodeLength
		if len(d.prefix) > giftcode.CodePrefixMaxLength || !prefixPattern.MatchString(d.prefix) {
			return d, invalidInput("Tiền tố tối đa 8 ký tự chữ, số hoặc dấu gạch ngang")
		}
		if d.length < giftcode.UniqueCodeMinLength || d.length > giftcode.UniqueCodeMaxLength {
			return d, invalidInput("Độ dài phần ngẫu nhiên từ 6 đến 16 ký tự")
		}
	}
	if !req.AllowWeb && !req.AllowAndroid && !req.AllowIOS {
		return d, invalidInput("Chọn ít nhất một nền tảng")
	}
	if d.startsAt != nil && !d.endsAt.After(*d.startsAt) {
		return d, invalidInput("Ngày kết thúc phải sau ngày bắt đầu")
	}
	frames := make(map[string]struct{}, len(req.Rewards))
	for _, r := range req.Rewards {
		switch r.Type {
		case models.GiftCodeRewardVipDays:
			if r.Days <= 0 {
				return d, invalidInput("Nhập số ngày VIP")
			}
			d.rewards = append(d.rewards, models.GiftCodeReward{Type: r.Type, Days: r.Days})
		case models.GiftCodeRewardVipIcon:
			if r.VipIconID <= 0 {
				return d, invalidInput("Chọn icon VIP")
			}
			d.rewards = append(d.rewards, models.GiftCodeReward{Type: r.Type, VipIconID: r.VipIconID})
		case models.GiftCodeRewardAvatarFrame:
			if !avatarframe.IsValidFrameID(r.FrameID) {
				return d, invalidInput("Chọn khung avatar")
			}
			if _, dup := frames[r.FrameID]; dup {
				return d, invalidInput("Khung avatar bị trùng")
			}
			frames[r.FrameID] = struct{}{}
			d.rewards = append(d.rewards, models.GiftCodeReward{Type: r.Type, FrameID: r.FrameID})
		}
	}
	if len(d.rewards) == 0 {
		return d, invalidInput("Thêm ít nhất một món quà")
	}
	return d, nil
}

func applyDraft(c *models.GiftCodeCampaign, d campaignDraft, req *CampaignRequest) {
	c.Name = d.name
	c.Kind = d.kind
	c.CodePrefix = d.prefix
	c.CodeLength = int16(d.length)
	c.TotalUses = d.total
	c.Rewards = d.rewards
	c.SuccessMessage = strings.TrimSpace(req.SuccessMessage)
	c.SendNotification = req.SendNotification
	c.MinAccountAgeDays = int16(req.MinAccountAgeDays)
	c.AllowWeb = req.AllowWeb
	c.AllowAndroid = req.AllowAndroid
	c.AllowIOS = req.AllowIOS
	c.OnePerDevice = req.OnePerDevice
	c.StartsAt = d.startsAt
	c.EndsAt = d.endsAt
	c.Enabled = req.Enabled
}

func codeTakenTx(tx *gorm.DB, code string) (bool, error) {
	var count int64
	err := tx.Model(&models.GiftCode{}).Where("code = ?", code).Limit(1).Count(&count).Error
	return count > 0, err
}

func sameRewards(a, b models.GiftCodeRewards) bool {
	ra, errA := json.Marshal(a)
	rb, errB := json.Marshal(b)
	return errA == nil && errB == nil && string(ra) == string(rb)
}

func mapCodeConflict(err error) error {
	if apperr.IsUniqueViolation(err) {
		return ErrCodeTaken
	}
	return err
}

func toRewardItems(rewards models.GiftCodeRewards) []RewardItem {
	items := make([]RewardItem, 0, len(rewards))
	for _, r := range rewards {
		items = append(items, RewardItem{Type: r.Type, Days: r.Days, VipIconID: r.VipIconID, FrameID: r.FrameID})
	}
	return items
}

func toCodeItem(gc *models.GiftCode) CodeItem {
	item := CodeItem{ID: gc.ID.String(), Code: gc.Code, Status: CodeStatusUnused, LockReason: gc.LockReason}
	switch {
	case gc.UsedAt != nil:
		item.Status = CodeStatusUsed
	case gc.LockedAt != nil:
		item.Status = CodeStatusLocked
	}
	if gc.UsedBy != nil {
		u := userBrief(*gc.UsedBy, gc.User)
		item.User = &u
	}
	if gc.UsedAt != nil {
		v := gc.UsedAt.Format(time.RFC3339)
		item.UsedAt = &v
	}
	if gc.LockedAt != nil {
		v := gc.LockedAt.Format(time.RFC3339)
		item.LockedAt = &v
		item.LockedBy = adminBrief(gc.Locker)
	}
	return item
}

func userBrief(id uuid.UUID, u *models.User) admincommon.UserBrief {
	if u == nil {
		return admincommon.UserBriefOf(id, "", "", "")
	}
	return admincommon.UserBriefOf(id, u.Username, u.FullName, u.Avatar)
}

func adminBrief(a *models.AdminUser) *AdminBrief {
	if a == nil {
		return nil
	}
	return &AdminBrief{ID: a.ID.String(), Username: a.Username, FullName: a.FullName}
}

func recentCodes(joined string) []string {
	out := make([]string, 0, RecentCodesShown)
	seen := make(map[string]struct{}, RecentCodesShown)
	for _, code := range strings.Split(joined, ",") {
		if code == "" {
			continue
		}
		if _, dup := seen[code]; dup {
			continue
		}
		seen[code] = struct{}{}
		out = append(out, code)
		if len(out) == RecentCodesShown {
			break
		}
	}
	return out
}

func startOfDay(now time.Time) time.Time {
	loc, err := time.LoadLocation(VietnamTimezone)
	if err != nil {
		loc = time.FixedZone(VietnamTimezone, 7*60*60)
	}
	local := now.In(loc)
	return time.Date(local.Year(), local.Month(), local.Day(), 0, 0, 0, 0, loc)
}

func ParseAttemptRange(raw string) time.Duration {
	if d, ok := attemptRanges[raw]; ok {
		return d
	}
	return DefaultAttemptRange
}
