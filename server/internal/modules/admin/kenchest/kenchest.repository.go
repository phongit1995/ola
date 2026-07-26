package adminkenchest

import (
	"fmt"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func chestScope(f StatsFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		db = db.Where("ken_chests.deleted_at IS NULL")
		if f.Source != "" {
			db = db.Where("ken_chests.source = ?", f.Source)
		}
		if f.From != nil {
			db = db.Where("ken_chests.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("ken_chests.created_at <= ?", *f.To)
		}
		return db
	}
}

func claimScope(f StatsFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if f.Source != "" {
			db = db.Where("ken_chests.source = ?", f.Source)
		}
		if f.UserID != nil {
			db = db.Where("ken_chest_claims.user_id = ?", *f.UserID)
		}
		if f.From != nil {
			db = db.Where("ken_chest_claims.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("ken_chest_claims.created_at <= ?", *f.To)
		}
		return db
	}
}

func (r *Repository) claimQuery(f StatsFilter) *gorm.DB {
	return r.db.Table("ken_chest_claims").
		Joins("LEFT JOIN ken_chests ON ken_chests.id = ken_chest_claims.chest_id").
		Scopes(claimScope(f))
}

type chestOverviewRow struct {
	TotalChests   int64 `gorm:"column:total_chests"`
	ManualChests  int64 `gorm:"column:manual_chests"`
	AutoChests    int64 `gorm:"column:auto_chests"`
	ActiveChests  int64 `gorm:"column:active_chests"`
	ExpiredChests int64 `gorm:"column:expired_chests"`
}

type claimOverviewRow struct {
	TotalClaims   int64 `gorm:"column:total_claims"`
	EmptyClaims   int64 `gorm:"column:empty_claims"`
	TotalKenGiven int64 `gorm:"column:total_ken_given"`
	UniqueUsers   int64 `gorm:"column:unique_users"`
}

func (r *Repository) StatsOverview(f StatsFilter) (StatsOverview, error) {
	var chests chestOverviewRow
	err := r.db.Table("ken_chests").Scopes(chestScope(f)).
		Select(`count(*) as total_chests,
			count(*) filter (where source = 'manual') as manual_chests,
			count(*) filter (where source = 'auto') as auto_chests,
			count(*) filter (where status = 'active') as active_chests,
			count(*) filter (where status = 'expired') as expired_chests`).
		Scan(&chests).Error
	if err != nil {
		return StatsOverview{}, err
	}

	var claims claimOverviewRow
	err = r.claimQuery(f).
		Select(`count(*) as total_claims,
			count(*) filter (where ken_chest_claims.is_empty) as empty_claims,
			coalesce(sum(ken_chest_claims.ken_amount), 0) as total_ken_given,
			count(distinct ken_chest_claims.user_id) as unique_users`).
		Scan(&claims).Error
	if err != nil {
		return StatsOverview{}, err
	}

	return StatsOverview{
		TotalChests:   chests.TotalChests,
		ManualChests:  chests.ManualChests,
		AutoChests:    chests.AutoChests,
		ActiveChests:  chests.ActiveChests,
		ExpiredChests: chests.ExpiredChests,
		TotalClaims:   claims.TotalClaims,
		EmptyClaims:   claims.EmptyClaims,
		TotalKenGiven: claims.TotalKenGiven,
		UniqueUsers:   claims.UniqueUsers,
	}, nil
}

func (r *Repository) StatsBySource(f StatsFilter) ([]StatsSourceRow, error) {
	var rows []StatsSourceRow
	err := r.claimQuery(f).
		Select(`coalesce(ken_chests.source, 'manual') as source,
			count(distinct ken_chest_claims.chest_id) as chests,
			count(*) as claims,
			coalesce(sum(ken_chest_claims.ken_amount), 0) as ken_given`).
		Group("coalesce(ken_chests.source, 'manual')").
		Order("ken_given DESC").
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) StatsTimeseries(f StatsFilter, bucket string) ([]StatsTimePoint, error) {
	trunc, format := "day", "YYYY-MM-DD"
	if bucket == "month" {
		trunc, format = "month", "YYYY-MM"
	}
	var rows []StatsTimePoint
	err := r.claimQuery(f).
		Select(fmt.Sprintf(`to_char(date_trunc('%s', ken_chest_claims.created_at), '%s') as date,
			count(*) as claims,
			count(*) filter (where ken_chest_claims.is_empty) as empty,
			coalesce(sum(ken_chest_claims.ken_amount), 0) as ken_given`, trunc, format)).
		Group(fmt.Sprintf("date_trunc('%s', ken_chest_claims.created_at)", trunc)).
		Order(fmt.Sprintf("date_trunc('%s', ken_chest_claims.created_at) ASC", trunc)).
		Scan(&rows).Error
	return rows, err
}

var userStatsSorts = map[string]string{
	"kenTotal": "ken_total",
	"claims":   "claims",
	"empty":    "empty_claims",
}

type userStatsRow struct {
	UserID      uuid.UUID `gorm:"column:user_id"`
	Username    string    `gorm:"column:username"`
	FullName    string    `gorm:"column:full_name"`
	Avatar      string    `gorm:"column:avatar"`
	Claims      int64     `gorm:"column:claims"`
	Chests      int64     `gorm:"column:chests"`
	EmptyClaims int64     `gorm:"column:empty_claims"`
	KenTotal    int64     `gorm:"column:ken_total"`
	LastClaimAt time.Time `gorm:"column:last_claim_at"`
}

func (r *Repository) UserStats(f StatsFilter, sortBy string, limit, offset int) ([]userStatsRow, int64, error) {
	var total int64
	if err := r.claimQuery(f).Distinct("ken_chest_claims.user_id").Count(&total).Error; err != nil {
		return nil, 0, err
	}

	order, ok := userStatsSorts[sortBy]
	if !ok {
		order = "ken_total"
	}

	var rows []userStatsRow
	err := r.claimQuery(f).
		Select(`ken_chest_claims.user_id, users.username, users.full_name, users.avatar,
			count(*) as claims,
			count(distinct ken_chest_claims.chest_id) as chests,
			count(*) filter (where ken_chest_claims.is_empty) as empty_claims,
			coalesce(sum(ken_chest_claims.ken_amount), 0) as ken_total,
			max(ken_chest_claims.created_at) as last_claim_at`).
		Joins("LEFT JOIN users ON users.id = ken_chest_claims.user_id").
		Group("ken_chest_claims.user_id, users.username, users.full_name, users.avatar").
		Order(order + " DESC, ken_chest_claims.user_id ASC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}
