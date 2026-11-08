package admingiftcode

import (
	"strings"
	"time"

	"ola-chat-server/internal/models"
	admincommon "ola-chat-server/internal/modules/admin/common"
	giftcode "ola-chat-server/internal/modules/gift-code"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) Transaction(fn func(tx *gorm.DB) error) error {
	return r.db.Transaction(fn)
}

func likePattern(s string) string {
	escaped := strings.NewReplacer(`\`, `\\`, `%`, `\%`, `_`, `\_`).Replace(s)
	return "%" + escaped + "%"
}

func campaignStatusScope(status string, now time.Time) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		live := "enabled = TRUE AND (starts_at IS NULL OR starts_at <= ?) AND ends_at > ?"
		switch status {
		case giftcode.StatusOff:
			return db.Where("enabled = FALSE")
		case giftcode.StatusScheduled:
			return db.Where("enabled = TRUE AND starts_at > ?", now)
		case giftcode.StatusExpired:
			return db.Where("enabled = TRUE AND (starts_at IS NULL OR starts_at <= ?) AND ends_at <= ?", now, now)
		case giftcode.StatusSoldOut:
			return db.Where(live+" AND used_count >= total_uses", now, now)
		case giftcode.StatusRunning:
			return db.Where(live+" AND used_count < total_uses", now, now)
		}
		return db
	}
}

func (r *Repository) ListCampaigns(f CampaignFilter, now time.Time) ([]models.GiftCodeCampaign, int64, error) {
	q := r.db.Model(&models.GiftCodeCampaign{}).Scopes(campaignStatusScope(f.Status, now))
	if f.Kind != "" {
		q = q.Where("kind = ?", f.Kind)
	}
	if f.Search != "" {
		q = q.Where("(name ILIKE ? OR id IN (SELECT campaign_id FROM gift_codes WHERE code = ?))", likePattern(f.Search), giftcode.NormalizeCode(f.Search))
	}
	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var items []models.GiftCodeCampaign
	err := q.Preload("Creator").Preload("Updater").
		Order("created_at DESC, id DESC").
		Limit(f.Limit).Offset(f.Offset).
		Find(&items).Error
	return items, total, err
}

func (r *Repository) FindCampaign(id uuid.UUID) (*models.GiftCodeCampaign, error) {
	var c models.GiftCodeCampaign
	if err := r.db.Preload("Creator").Preload("Updater").First(&c, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &c, nil
}

func (r *Repository) LockCampaign(tx *gorm.DB, id uuid.UUID) (*models.GiftCodeCampaign, error) {
	var c models.GiftCodeCampaign
	if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&c, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &c, nil
}

func (r *Repository) SharedCodes(ids []uuid.UUID) (map[uuid.UUID]string, error) {
	out := make(map[uuid.UUID]string, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	var rows []models.GiftCode
	if err := r.db.Select("campaign_id", "code").Where("campaign_id IN ?", ids).Find(&rows).Error; err != nil {
		return nil, err
	}
	for _, row := range rows {
		out[row.CampaignID] = row.Code
	}
	return out, nil
}

func (r *Repository) LockedCounts(ids []uuid.UUID) (map[uuid.UUID]int64, error) {
	out := make(map[uuid.UUID]int64, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	var rows []struct {
		CampaignID uuid.UUID
		Count      int64
	}
	if err := r.db.Model(&models.GiftCode{}).
		Select("campaign_id, COUNT(*) AS count").
		Where("campaign_id IN ? AND locked_at IS NOT NULL", ids).
		Group("campaign_id").
		Scan(&rows).Error; err != nil {
		return nil, err
	}
	for _, row := range rows {
		out[row.CampaignID] = row.Count
	}
	return out, nil
}

func (r *Repository) Stats(now, dayStart time.Time) (CampaignStats, error) {
	var s CampaignStats
	if err := r.db.Model(&models.GiftCodeCampaign{}).Scopes(campaignStatusScope(giftcode.StatusRunning, now)).Count(&s.Running).Error; err != nil {
		return s, err
	}
	if err := r.db.Model(&models.GiftCodeRedemption{}).Count(&s.RedeemedTotal).Error; err != nil {
		return s, err
	}
	if err := r.db.Model(&models.GiftCodeRedemption{}).Where("created_at >= ?", dayStart).Count(&s.RedeemedToday).Error; err != nil {
		return s, err
	}
	err := r.db.Raw(`SELECT COALESCE(SUM((reward->>'days')::int), 0)
		FROM gift_code_redemptions, jsonb_array_elements(rewards) AS reward
		WHERE reward->>'type' = ?`, models.GiftCodeRewardVipDays).Scan(&s.VipDaysGiven).Error
	return s, err
}

func (r *Repository) CodeExists(code string) (bool, error) {
	var count int64
	err := r.db.Model(&models.GiftCode{}).Where("code = ?", code).Limit(1).Count(&count).Error
	return count > 0, err
}

func (r *Repository) InsertCodes(tx *gorm.DB, campaignID uuid.UUID, codes []string) (int, error) {
	if len(codes) == 0 {
		return 0, nil
	}
	rows := make([]models.GiftCode, 0, len(codes))
	for _, code := range codes {
		rows = append(rows, models.GiftCode{CampaignID: campaignID, Code: code})
	}
	res := tx.Clauses(clause.OnConflict{DoNothing: true}).CreateInBatches(&rows, GenerateInsertBatch)
	return int(res.RowsAffected), res.Error
}

func codeStatusScope(status string) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		switch status {
		case CodeStatusUsed:
			return db.Where("used_at IS NOT NULL")
		case CodeStatusLocked:
			return db.Where("locked_at IS NOT NULL AND used_at IS NULL")
		case CodeStatusUnused:
			return db.Where("used_at IS NULL AND locked_at IS NULL")
		}
		return db
	}
}

func (r *Repository) ListCodes(campaignID uuid.UUID, status, search string, limit, offset int) ([]models.GiftCode, int64, error) {
	q := r.db.Model(&models.GiftCode{}).Where("campaign_id = ?", campaignID).Scopes(codeStatusScope(status))
	if search != "" {
		q = q.Where("code ILIKE ?", likePattern(giftcode.NormalizeCode(search)))
	}
	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var items []models.GiftCode
	err := q.Preload("User").Preload("Locker").
		Order("used_at DESC NULLS LAST, created_at ASC, id ASC").
		Limit(limit).Offset(offset).
		Find(&items).Error
	return items, total, err
}

func (r *Repository) CodeCounts(campaignID uuid.UUID) (CodeCounts, error) {
	var c CodeCounts
	err := r.db.Model(&models.GiftCode{}).
		Select(`COUNT(*) FILTER (WHERE used_at IS NULL AND locked_at IS NULL) AS unused,
			COUNT(*) FILTER (WHERE used_at IS NOT NULL) AS used,
			COUNT(*) FILTER (WHERE locked_at IS NOT NULL AND used_at IS NULL) AS locked`).
		Where("campaign_id = ?", campaignID).
		Scan(&c).Error
	return c, err
}

func (r *Repository) LockCode(tx *gorm.DB, campaignID, codeID uuid.UUID) (*models.GiftCode, error) {
	var gc models.GiftCode
	if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&gc, "id = ? AND campaign_id = ?", codeID, campaignID).Error; err != nil {
		return nil, err
	}
	return &gc, nil
}

func (r *Repository) FindCode(codeID uuid.UUID) (*models.GiftCode, error) {
	var gc models.GiftCode
	if err := r.db.Preload("User").Preload("Locker").First(&gc, "id = ?", codeID).Error; err != nil {
		return nil, err
	}
	return &gc, nil
}

func (r *Repository) SetEnabled(id uuid.UUID, enabled bool, adminID uuid.UUID, now time.Time) (bool, error) {
	res := r.db.Model(&models.GiftCodeCampaign{}).Where("id = ?", id).
		Updates(map[string]interface{}{"enabled": enabled, "updated_by": adminID, "updated_at": now})
	return res.RowsAffected > 0, res.Error
}

func (r *Repository) ListRedemptions(campaignID uuid.UUID, search, platform string, limit, offset int) ([]models.GiftCodeRedemption, int64, error) {
	q := r.db.Model(&models.GiftCodeRedemption{}).Where("gift_code_redemptions.campaign_id = ?", campaignID)
	if platform != "" {
		q = q.Where("gift_code_redemptions.platform = ?", platform)
	}
	if search != "" {
		pattern := likePattern(search)
		q = q.Where(`(gift_code_redemptions.user_id IN (SELECT id FROM users WHERE username ILIKE ? OR full_name ILIKE ?)
			OR gift_code_redemptions.code_id IN (SELECT id FROM gift_codes WHERE campaign_id = ? AND code ILIKE ?))`,
			pattern, pattern, campaignID, likePattern(giftcode.NormalizeCode(search)))
	}
	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var items []models.GiftCodeRedemption
	err := q.Preload("User").Preload("Code").
		Order("gift_code_redemptions.created_at DESC, gift_code_redemptions.id DESC").
		Limit(limit).Offset(offset).
		Find(&items).Error
	return items, total, err
}

func attemptScope(f AttemptFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		db = db.Where("a.created_at >= ?", f.Since)
		if f.Reason != "" {
			db = db.Where("a.reason = ?", f.Reason)
		}
		if f.Search != "" {
			pattern := likePattern(f.Search)
			db = db.Where(`(a.user_id IN (SELECT id FROM users WHERE username ILIKE ? OR full_name ILIKE ?) OR a.code_input ILIKE ? OR a.ip_address ILIKE ?)`,
				pattern, pattern, likePattern(giftcode.NormalizeCode(f.Search)), pattern)
		}
		return db
	}
}

func (r *Repository) AttemptSummary(since time.Time) (AttemptSummary, error) {
	var s AttemptSummary
	err := r.db.Table("gift_code_attempts AS a").
		Select("COUNT(*) AS failures, COUNT(*) FILTER (WHERE a.reason = ?) AS wrong_codes", giftcode.ReasonWrong).
		Where("a.created_at >= ?", since).
		Scan(&s).Error
	if err != nil {
		return s, err
	}
	err = r.db.Raw(`SELECT COUNT(*) FROM (
		SELECT device_id FROM (
			SELECT device_id, user_id FROM gift_code_attempts WHERE device_id <> '' AND created_at >= ?
			UNION
			SELECT device_id, user_id FROM gift_code_redemptions WHERE device_id <> '' AND created_at >= ?
		) AS events GROUP BY device_id HAVING COUNT(DISTINCT user_id) >= ?
	) AS devices`, since, since, MultiAccountDevice).Scan(&s.MultiAccountDevices).Error
	return s, err
}

type attemptUserRow struct {
	UserID      uuid.UUID
	Failures    int64
	LastAt      time.Time
	DeviceName  string
	Platform    string
	TopReason   string
	RecentCodes string
}

func (r *Repository) AttemptUsers(f AttemptFilter) ([]attemptUserRow, int64, error) {
	base := r.db.Table("gift_code_attempts AS a").Scopes(attemptScope(f))
	var total int64
	if err := base.Distinct("a.user_id").Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var rows []attemptUserRow
	err := r.db.Table("gift_code_attempts AS a").Scopes(attemptScope(f)).
		Select(`a.user_id,
			COUNT(*) AS failures,
			MAX(a.created_at) AS last_at,
			(array_agg(a.device_name ORDER BY a.created_at DESC))[1] AS device_name,
			(array_agg(a.platform ORDER BY a.created_at DESC))[1] AS platform,
			mode() WITHIN GROUP (ORDER BY a.reason) AS top_reason,
			array_to_string((array_agg(a.code_input ORDER BY a.created_at DESC))[1:10], ',') AS recent_codes`).
		Group("a.user_id").
		Order("failures DESC, last_at DESC").
		Limit(f.Limit).Offset(f.Offset).
		Scan(&rows).Error
	return rows, total, err
}

type attemptDeviceRow struct {
	DeviceID   string
	DeviceName string
	Platform   string
	Failures   int64
	Successes  int64
	Accounts   int64
	UserIDs    string
	LastAt     time.Time
}

const deviceEventsSQL = `SELECT device_id, device_name, platform, user_id, created_at, 1 AS failed, 0 AS succeeded
		FROM gift_code_attempts WHERE device_id <> '' AND created_at >= @since
	UNION ALL
	SELECT device_id, device_name, platform, user_id, created_at, 0, 1
		FROM gift_code_redemptions WHERE device_id <> '' AND created_at >= @since`

func (r *Repository) AttemptDevices(f AttemptFilter) ([]attemptDeviceRow, int64, error) {
	searchSQL := ""
	args := map[string]interface{}{"since": f.Since, "limit": f.Limit, "offset": f.Offset}
	if f.Search != "" {
		searchSQL = `AND (device_name ILIKE @pattern OR device_id ILIKE @pattern OR user_id IN (SELECT id FROM users WHERE username ILIKE @pattern))`
		args["pattern"] = likePattern(f.Search)
	}
	grouped := `SELECT device_id,
			(array_agg(device_name ORDER BY created_at DESC))[1] AS device_name,
			(array_agg(platform ORDER BY created_at DESC))[1] AS platform,
			SUM(failed) AS failures,
			SUM(succeeded) AS successes,
			COUNT(DISTINCT user_id) AS accounts,
			string_agg(DISTINCT user_id::text, ',') AS user_ids,
			MAX(created_at) AS last_at
		FROM (` + deviceEventsSQL + `) AS events
		WHERE TRUE ` + searchSQL + `
		GROUP BY device_id
		HAVING SUM(failed) > 0 OR COUNT(DISTINCT user_id) > 1`

	var total int64
	if err := r.db.Raw(`SELECT COUNT(*) FROM (`+grouped+`) AS devices`, args).Scan(&total).Error; err != nil {
		return nil, 0, err
	}
	var rows []attemptDeviceRow
	err := r.db.Raw(grouped+` ORDER BY accounts DESC, failures DESC, last_at DESC LIMIT @limit OFFSET @offset`, args).Scan(&rows).Error
	return rows, total, err
}

type attemptRow struct {
	ID         uuid.UUID
	UserID     uuid.UUID
	CodeInput  string
	Reason     string
	Platform   string
	DeviceName string
	IPAddress  string
	CreatedAt  time.Time
}

func (r *Repository) ListAttempts(f AttemptFilter) ([]attemptRow, int64, error) {
	var total int64
	if err := r.db.Table("gift_code_attempts AS a").Scopes(attemptScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var rows []attemptRow
	err := r.db.Table("gift_code_attempts AS a").Scopes(attemptScope(f)).
		Select("a.id, a.user_id, a.code_input, a.reason, a.platform, a.device_name, a.ip_address, a.created_at").
		Order("a.created_at DESC, a.id DESC").
		Limit(f.Limit).Offset(f.Offset).
		Scan(&rows).Error
	return rows, total, err
}

func (r *Repository) FindUsersByIDs(ids []uuid.UUID) (map[uuid.UUID]models.User, error) {
	return admincommon.FindUsersByIDs(r.db, ids)
}
