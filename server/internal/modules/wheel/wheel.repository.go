package wheel

import (
	"fmt"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

const dailyResetDateExpr = "(now() AT TIME ZONE 'Asia/Ho_Chi_Minh')::date"

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) ListWheels(enabledOnly bool) ([]models.Wheel, error) {
	var wheels []models.Wheel
	q := r.db.Order("sort_order ASC").Order("created_at ASC")
	if enabledOnly {
		q = q.Where("is_enabled = ?", true)
	}
	if err := q.Find(&wheels).Error; err != nil {
		return nil, err
	}
	return wheels, nil
}

func (r *Repository) FirstEnabledWheel() (*models.Wheel, error) {
	var wheel models.Wheel
	if err := r.db.Where("is_enabled = ?", true).
		Order("sort_order ASC").Order("created_at ASC").
		First(&wheel).Error; err != nil {
		return nil, err
	}
	return &wheel, nil
}

func (r *Repository) FindWheel(id uuid.UUID) (*models.Wheel, error) {
	var wheel models.Wheel
	if err := r.db.First(&wheel, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &wheel, nil
}

func createChildren(tx *gorm.DB, wheelID uuid.UUID, segs []models.WheelSegment, optionsBySeg map[int][]models.WheelSegmentOption) error {
	for i := range segs {
		segs[i].ID = uuid.New()
		segs[i].WheelID = wheelID
		if err := tx.Create(&segs[i]).Error; err != nil {
			return err
		}
		for j := range optionsBySeg[i] {
			optionsBySeg[i][j].ID = uuid.New()
			optionsBySeg[i][j].SegmentID = segs[i].ID
			if err := tx.Create(&optionsBySeg[i][j]).Error; err != nil {
				return err
			}
		}
	}
	return nil
}

func (r *Repository) CreateWheelWithConfig(wheel *models.Wheel, segs []models.WheelSegment, optionsBySeg map[int][]models.WheelSegmentOption) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(wheel).Error; err != nil {
			return err
		}
		return createChildren(tx, wheel.ID, segs, optionsBySeg)
	})
}

func (r *Repository) UpdateWheel(id uuid.UUID, fields map[string]interface{}) error {
	return r.db.Model(&models.Wheel{}).Where("id = ?", id).Updates(fields).Error
}

func (r *Repository) SoftDeleteWheel(id uuid.UUID) error {
	return r.db.Delete(&models.Wheel{}, "id = ?", id).Error
}

func (r *Repository) SegmentsByWheels(wheelIDs []uuid.UUID) ([]models.WheelSegment, error) {
	var segs []models.WheelSegment
	if len(wheelIDs) == 0 {
		return segs, nil
	}
	if err := r.db.Where("wheel_id IN ?", wheelIDs).Order("sort_order ASC").Find(&segs).Error; err != nil {
		return nil, err
	}
	return segs, nil
}

func (r *Repository) OptionsBySegments(segmentIDs []uuid.UUID) ([]models.WheelSegmentOption, error) {
	var options []models.WheelSegmentOption
	if len(segmentIDs) == 0 {
		return options, nil
	}
	if err := r.db.Where("segment_id IN ?", segmentIDs).Order("sort_order ASC").Find(&options).Error; err != nil {
		return nil, err
	}
	return options, nil
}

func (r *Repository) ReplaceConfig(wheelID uuid.UUID, segs []models.WheelSegment, optionsBySeg map[int][]models.WheelSegmentOption) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		var existing []models.WheelSegment
		if err := tx.Where("wheel_id = ?", wheelID).Find(&existing).Error; err != nil {
			return err
		}
		if len(existing) > 0 {
			ids := make([]uuid.UUID, len(existing))
			for i, s := range existing {
				ids[i] = s.ID
			}
			if err := tx.Where("segment_id IN ?", ids).Delete(&models.WheelSegmentOption{}).Error; err != nil {
				return err
			}
			if err := tx.Where("wheel_id = ?", wheelID).Delete(&models.WheelSegment{}).Error; err != nil {
				return err
			}
		}
		if err := createChildren(tx, wheelID, segs, optionsBySeg); err != nil {
			return err
		}
		return tx.Model(&models.Wheel{}).Where("id = ?", wheelID).Update("updated_at", time.Now()).Error
	})
}

func (r *Repository) HasFreeClaimToday(userID, wheelID uuid.UUID) (bool, error) {
	var count int64
	if err := r.db.Model(&models.WheelFreeClaim{}).
		Where("user_id = ? AND wheel_id = ? AND claim_date = "+dailyResetDateExpr, userID, wheelID).
		Count(&count).Error; err != nil {
		return false, err
	}
	return count > 0, nil
}

func (r *Repository) ApplySpin(userID uuid.UUID, wheel *models.Wheel, outcome SpinOutcome, idempotencyKey string) (*models.WheelSpin, *models.User, error) {
	var spin models.WheelSpin
	var updatedUser models.User

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var u models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", userID).Error; err != nil {
			return err
		}

		if idempotencyKey != "" {
			var prev models.WheelSpin
			err := tx.Where("user_id = ? AND metadata->>'idempotencyKey' = ?", userID, idempotencyKey).First(&prev).Error
			if err == nil {
				spin = prev
				updatedUser = u
				return nil
			}
			if err != gorm.ErrRecordNotFound {
				return err
			}
		}

		isFree := false
		if wheel.FreeDailyEnabled {
			res := tx.Exec(
				"INSERT INTO wheel_free_claims (user_id, wheel_id, claim_date) VALUES (?, ?, "+dailyResetDateExpr+") ON CONFLICT DO NOTHING",
				userID, wheel.ID,
			)
			if res.Error != nil {
				return res.Error
			}
			isFree = res.RowsAffected > 0
		}

		cost := 0
		if !isFree {
			if u.Ken < wheel.KenCost {
				return ErrInsufficientKen
			}
			cost = wheel.KenCost
		}

		finalKen := u.Ken - cost
		newEnd := u.VipEndTime

		switch outcome.Kind {
		case models.WheelSegmentKenFixed, models.WheelSegmentKenRandom:
			if outcome.KenAmount != nil && *outcome.KenAmount > 0 {
				finalKen += *outcome.KenAmount
			}
		case models.WheelSegmentVipItem:
			if outcome.VipTypeID != nil {
				icon := models.UserVipIcon{
					UserID:     userID,
					VipIconID:  *outcome.VipTypeID,
					Source:     "wheel",
					AcquiredAt: time.Now(),
				}
				if err := tx.Create(&icon).Error; err != nil {
					return err
				}
			}
		case models.WheelSegmentVipDays:
			if outcome.VipDays != nil && *outcome.VipDays > 0 {
				base := time.Now()
				if u.VipEndTime != nil && u.VipEndTime.After(base) {
					base = *u.VipEndTime
				}
				end := base.Add(time.Duration(*outcome.VipDays) * 24 * time.Hour)
				newEnd = &end
			}
		case models.WheelSegmentVipRandom:
			if outcome.VipTypeID != nil {
				icon := models.UserVipIcon{
					UserID:     userID,
					VipIconID:  *outcome.VipTypeID,
					Source:     "wheel",
					AcquiredAt: time.Now(),
				}
				if err := tx.Create(&icon).Error; err != nil {
					return err
				}
			}
			if outcome.VipDays != nil && *outcome.VipDays > 0 {
				base := time.Now()
				if u.VipEndTime != nil && u.VipEndTime.After(base) {
					base = *u.VipEndTime
				}
				end := base.Add(time.Duration(*outcome.VipDays) * 24 * time.Hour)
				newEnd = &end
			}
			if outcome.KenAmount != nil && *outcome.KenAmount > 0 {
				finalKen += *outcome.KenAmount
			}
		}

		userFields := map[string]interface{}{"ken": finalKen}
		if newEnd != u.VipEndTime && newEnd != nil {
			userFields["vip_end_time"] = *newEnd
		}
		if err := tx.Model(&models.User{}).Where("id = ?", userID).Updates(userFields).Error; err != nil {
			return err
		}

		metadata := models.JSONB{"segmentWeight": outcome.SegmentWeight, "optionWeight": outcome.OptionWeight}
		if idempotencyKey != "" {
			metadata["idempotencyKey"] = idempotencyKey
		}

		segmentID := outcome.SegmentID
		spin = models.WheelSpin{
			UserID:       userID,
			WheelID:      wheel.ID,
			WheelName:    wheel.Name,
			KenCost:      cost,
			IsFree:       isFree,
			SegmentID:    &segmentID,
			SegmentKind:  outcome.Kind,
			RewardLabel:  nilIfEmpty(outcome.RewardLabel),
			KenAmount:    outcome.KenAmount,
			VipDays:      outcome.VipDays,
			VipTypeID:    outcome.VipTypeID,
			IsSuperLucky: outcome.IsSuperLucky,
			Metadata:     metadata,
		}
		if err := tx.Create(&spin).Error; err != nil {
			return err
		}

		u.Ken = finalKen
		u.VipEndTime = newEnd
		updatedUser = u
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return &spin, &updatedUser, nil
}

func wheelOutcomeScope(outcome string) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		switch outcome {
		case "win":
			return db.Where("segment_kind <> ?", models.WheelSegmentMiss)
		case "miss":
			return db.Where("segment_kind = ?", models.WheelSegmentMiss)
		default:
			return db
		}
	}
}

func (r *Repository) ListSpins(userID uuid.UUID, outcome string, limit, offset int) ([]models.WheelSpin, int64, error) {
	var spins []models.WheelSpin
	var total int64
	if err := r.db.Model(&models.WheelSpin{}).Where("user_id = ?", userID).
		Scopes(wheelOutcomeScope(outcome)).Count(&total).Error; err != nil {
		return nil, 0, err
	}
	if err := r.db.Where("user_id = ?", userID).
		Scopes(wheelOutcomeScope(outcome)).
		Order("created_at DESC").
		Limit(limit).Offset(offset).
		Find(&spins).Error; err != nil {
		return nil, 0, err
	}
	return spins, total, nil
}

type AdminSpinRow struct {
	models.WheelSpin
	Username string `gorm:"column:username"`
	FullName string `gorm:"column:full_name"`
	Avatar   string `gorm:"column:avatar"`
}

type AdminSpinFilter struct {
	UserID      *uuid.UUID
	WheelID     *uuid.UUID
	SegmentKind string
	Outcome     string
	From        *time.Time
	To          *time.Time
}

func adminSpinScope(f AdminSpinFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if f.UserID != nil {
			db = db.Where("wheel_spins.user_id = ?", *f.UserID)
		}
		if f.WheelID != nil {
			db = db.Where("wheel_spins.wheel_id = ?", *f.WheelID)
		}
		if f.SegmentKind != "" {
			db = db.Where("wheel_spins.segment_kind = ?", f.SegmentKind)
		}
		switch f.Outcome {
		case "win":
			db = db.Where("wheel_spins.segment_kind <> ?", models.WheelSegmentMiss)
		case "miss":
			db = db.Where("wheel_spins.segment_kind = ?", models.WheelSegmentMiss)
		}
		if f.From != nil {
			db = db.Where("wheel_spins.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("wheel_spins.created_at <= ?", *f.To)
		}
		return db
	}
}

func (r *Repository) ListAllSpins(filter AdminSpinFilter, limit, offset int) ([]AdminSpinRow, int64, error) {
	var total int64
	if err := r.db.Model(&models.WheelSpin{}).Scopes(adminSpinScope(filter)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	query := r.db.Table("wheel_spins").
		Select("wheel_spins.*, users.username, users.full_name, users.avatar").
		Joins("LEFT JOIN users ON users.id = wheel_spins.user_id").
		Scopes(adminSpinScope(filter)).
		Order("wheel_spins.created_at DESC").
		Limit(limit).Offset(offset)

	var rows []AdminSpinRow
	if err := query.Scan(&rows).Error; err != nil {
		return nil, 0, err
	}
	return rows, total, nil
}

func (r *Repository) StatsOverview(f AdminSpinFilter) (StatsOverview, error) {
	var o StatsOverview
	err := r.db.Model(&models.WheelSpin{}).Scopes(adminSpinScope(f)).
		Select(`count(*) as total_spins,
			count(distinct user_id) as unique_players,
			coalesce(sum(ken_cost),0) as ken_in,
			coalesce(sum(ken_amount),0) as ken_out,
			coalesce(sum(vip_days),0) as vip_days_out,
			count(vip_type_id) as vip_items_out,
			count(*) filter (where is_free) as free_spins,
			count(*) filter (where segment_kind <> 'miss') as win_spins`).
		Scan(&o).Error
	return o, err
}

func (r *Repository) StatsByKind(f AdminSpinFilter) ([]StatsKind, error) {
	var rows []StatsKind
	err := r.db.Model(&models.WheelSpin{}).Scopes(adminSpinScope(f)).
		Select("segment_kind, count(*) as spins").
		Group("segment_kind").
		Order("spins DESC").
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) StatsTopRewards(f AdminSpinFilter, limit int) ([]StatsReward, error) {
	var rows []StatsReward
	err := r.db.Model(&models.WheelSpin{}).Scopes(adminSpinScope(f)).
		Where("reward_label IS NOT NULL").
		Select("segment_kind, reward_label, count(*) as count").
		Group("segment_kind, reward_label").
		Order("count DESC").
		Limit(limit).
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) StatsByWheel(f AdminSpinFilter) ([]StatsWheel, error) {
	var rows []StatsWheel
	err := r.db.Model(&models.WheelSpin{}).Scopes(adminSpinScope(f)).
		Select(`wheel_id, wheel_name, count(*) as spins,
			coalesce(sum(ken_cost),0) as ken_in,
			coalesce(sum(ken_amount),0) as ken_out`).
		Group("wheel_id, wheel_name").
		Order("ken_in DESC").
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) StatsTimeseries(f AdminSpinFilter, bucket string) ([]StatsTimePoint, error) {
	trunc, format := "day", "YYYY-MM-DD"
	if bucket == "month" {
		trunc, format = "month", "YYYY-MM"
	}
	var rows []StatsTimePoint
	err := r.db.Model(&models.WheelSpin{}).Scopes(adminSpinScope(f)).
		Select(fmt.Sprintf("to_char(date_trunc('%s', created_at), '%s') as date, count(*) as spins, coalesce(sum(ken_cost),0) as ken_in, coalesce(sum(ken_amount),0) as ken_out", trunc, format)).
		Group(fmt.Sprintf("date_trunc('%s', created_at)", trunc)).
		Order(fmt.Sprintf("date_trunc('%s', created_at) ASC", trunc)).
		Scan(&rows).Error
	return rows, err
}

type StatsPlayerRow struct {
	UserID   uuid.UUID `gorm:"column:user_id"`
	Username string    `gorm:"column:username"`
	FullName string    `gorm:"column:full_name"`
	Avatar   string    `gorm:"column:avatar"`
	Spins    int64     `gorm:"column:spins"`
	KenSpent int64     `gorm:"column:ken_spent"`
}

func (r *Repository) StatsTopPlayers(f AdminSpinFilter, limit int) ([]StatsPlayerRow, error) {
	var rows []StatsPlayerRow
	err := r.db.Table("wheel_spins").
		Select("wheel_spins.user_id, users.username, users.full_name, users.avatar, count(*) as spins, coalesce(sum(wheel_spins.ken_cost),0) as ken_spent").
		Joins("LEFT JOIN users ON users.id = wheel_spins.user_id").
		Scopes(adminSpinScope(f)).
		Group("wheel_spins.user_id, users.username, users.full_name, users.avatar").
		Order("ken_spent DESC").
		Limit(limit).
		Scan(&rows).Error
	return rows, err
}

func nilIfEmpty(s string) *string {
	if s == "" {
		return nil
	}
	return &s
}
