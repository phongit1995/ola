package adminegg

import (
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

func statsScope(f StatsFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if f.PackID != nil {
			db = db.Where("egg_draws.pack_id = ?", *f.PackID)
		}
		if f.UserID != nil {
			db = db.Where("egg_draws.user_id = ?", *f.UserID)
		}
		if f.From != nil {
			db = db.Where("egg_draws.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("egg_draws.created_at <= ?", *f.To)
		}
		return db
	}
}

var userStatsSorts = map[string]string{
	"kenSpent": "ken_spent",
	"kenWon":   "ken_won",
	"netKen":   "net_ken",
	"draws":    "draws",
	"vipDays":  "vip_days_won",
}

type userStatsRow struct {
	UserID      uuid.UUID `gorm:"column:user_id"`
	Username    string    `gorm:"column:username"`
	FullName    string    `gorm:"column:full_name"`
	Avatar      string    `gorm:"column:avatar"`
	Draws       int64     `gorm:"column:draws"`
	WinDraws    int64     `gorm:"column:win_draws"`
	KenSpent    int64     `gorm:"column:ken_spent"`
	KenWon      int64     `gorm:"column:ken_won"`
	NetKen      int64     `gorm:"column:net_ken"`
	VipDaysWon  int64     `gorm:"column:vip_days_won"`
	VipIconsWon int64     `gorm:"column:vip_icons_won"`
	LastDrawAt  time.Time `gorm:"column:last_draw_at"`
}

func (r *Repository) UserStats(f StatsFilter, sortBy string, limit, offset int) ([]userStatsRow, int64, error) {
	var total int64
	err := r.db.Table("egg_draws").Scopes(statsScope(f)).
		Distinct("egg_draws.user_id").Count(&total).Error
	if err != nil {
		return nil, 0, err
	}

	order, ok := userStatsSorts[sortBy]
	if !ok {
		order = "ken_spent"
	}

	var rows []userStatsRow
	err = r.db.Table("egg_draws").
		Select(`egg_draws.user_id, users.username, users.full_name, users.avatar,
			count(*) as draws,
			count(*) filter (where egg_draws.category_type <> 'nothing') as win_draws,
			coalesce(sum(egg_draws.ken_cost),0) as ken_spent,
			coalesce(sum(egg_draws.ken_amount),0) as ken_won,
			coalesce(sum(egg_draws.ken_amount),0) - coalesce(sum(egg_draws.ken_cost),0) as net_ken,
			coalesce(sum(egg_draws.vip_days),0) as vip_days_won,
			count(*) filter (where egg_draws.category_type = 'vip_icon') as vip_icons_won,
			max(egg_draws.created_at) as last_draw_at`).
		Joins("LEFT JOIN users ON users.id = egg_draws.user_id").
		Scopes(statsScope(f)).
		Group("egg_draws.user_id, users.username, users.full_name, users.avatar").
		Order(order + " DESC, egg_draws.user_id ASC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}

func (r *Repository) VipStats(f StatsFilter) ([]VipStatsRow, error) {
	var rows []VipStatsRow
	err := r.db.Table("egg_draws").
		Select(`coalesce(egg_draws.vip_type_id, 0) as vip_type_id,
			count(*) filter (where egg_draws.category_type = 'vip_icon') as icon_wins,
			count(*) filter (where egg_draws.category_type = 'vip_days') as day_wins,
			coalesce(sum(egg_draws.vip_days) filter (where egg_draws.category_type = 'vip_days'),0) as vip_days`).
		Scopes(statsScope(f)).
		Where("egg_draws.category_type IN ('vip_icon','vip_days')").
		Group("coalesce(egg_draws.vip_type_id, 0)").
		Order("icon_wins DESC, vip_days DESC, vip_type_id ASC").
		Scan(&rows).Error
	return rows, err
}
