package adminwheel

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
		if f.WheelID != nil {
			db = db.Where("wheel_spins.wheel_id = ?", *f.WheelID)
		}
		if f.UserID != nil {
			db = db.Where("wheel_spins.user_id = ?", *f.UserID)
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

var userStatsSorts = map[string]string{
	"kenSpent": "ken_spent",
	"kenWon":   "ken_won",
	"netKen":   "net_ken",
	"spins":    "spins",
	"vipDays":  "vip_days_won",
}

type userStatsRow struct {
	UserID      uuid.UUID `gorm:"column:user_id"`
	Username    string    `gorm:"column:username"`
	FullName    string    `gorm:"column:full_name"`
	Avatar      string    `gorm:"column:avatar"`
	Spins       int64     `gorm:"column:spins"`
	WinSpins    int64     `gorm:"column:win_spins"`
	FreeSpins   int64     `gorm:"column:free_spins"`
	KenSpent    int64     `gorm:"column:ken_spent"`
	KenWon      int64     `gorm:"column:ken_won"`
	NetKen      int64     `gorm:"column:net_ken"`
	VipDaysWon  int64     `gorm:"column:vip_days_won"`
	VipItemsWon int64     `gorm:"column:vip_items_won"`
	LastSpinAt  time.Time `gorm:"column:last_spin_at"`
}

func (r *Repository) UserStats(f StatsFilter, sortBy string, limit, offset int) ([]userStatsRow, int64, error) {
	var total int64
	err := r.db.Table("wheel_spins").Scopes(statsScope(f)).
		Distinct("wheel_spins.user_id").Count(&total).Error
	if err != nil {
		return nil, 0, err
	}

	order, ok := userStatsSorts[sortBy]
	if !ok {
		order = "ken_spent"
	}

	var rows []userStatsRow
	err = r.db.Table("wheel_spins").
		Select(`wheel_spins.user_id, users.username, users.full_name, users.avatar,
			count(*) as spins,
			count(*) filter (where wheel_spins.segment_kind <> 'miss') as win_spins,
			count(*) filter (where wheel_spins.is_free) as free_spins,
			coalesce(sum(wheel_spins.ken_cost),0) as ken_spent,
			coalesce(sum(wheel_spins.ken_amount),0) as ken_won,
			coalesce(sum(wheel_spins.ken_amount),0) - coalesce(sum(wheel_spins.ken_cost),0) as net_ken,
			coalesce(sum(wheel_spins.vip_days),0) as vip_days_won,
			count(wheel_spins.vip_type_id) as vip_items_won,
			max(wheel_spins.created_at) as last_spin_at`).
		Joins("LEFT JOIN users ON users.id = wheel_spins.user_id").
		Scopes(statsScope(f)).
		Group("wheel_spins.user_id, users.username, users.full_name, users.avatar").
		Order(order + " DESC, wheel_spins.user_id ASC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}

func (r *Repository) VipStats(f StatsFilter) ([]VipStatsRow, error) {
	var rows []VipStatsRow
	err := r.db.Table("wheel_spins").
		Select(`coalesce(wheel_spins.vip_type_id, 0) as vip_type_id,
			count(*) filter (where wheel_spins.vip_type_id is not null) as item_wins,
			count(*) filter (where wheel_spins.vip_days is not null) as day_wins,
			coalesce(sum(wheel_spins.vip_days),0) as vip_days`).
		Scopes(statsScope(f)).
		Where("wheel_spins.vip_type_id IS NOT NULL OR wheel_spins.vip_days IS NOT NULL").
		Group("coalesce(wheel_spins.vip_type_id, 0)").
		Order("item_wins DESC, vip_days DESC, vip_type_id ASC").
		Scan(&rows).Error
	return rows, err
}
