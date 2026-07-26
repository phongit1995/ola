package adminpen

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
		db = db.Where("pen_shots.deleted_at IS NULL")
		if f.From != nil {
			db = db.Where("pen_shots.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("pen_shots.created_at <= ?", *f.To)
		}
		return db
	}
}

var userStatsSorts = map[string]string{
	"staked":  "staked",
	"netKen":  "net_ken",
	"shots":   "shots",
	"catches": "catches",
}

type userStatsRow struct {
	UserID         uuid.UUID `gorm:"column:user_id"`
	Username       string    `gorm:"column:username"`
	FullName       string    `gorm:"column:full_name"`
	Avatar         string    `gorm:"column:avatar"`
	Shots          int64     `gorm:"column:shots"`
	ShooterSettled int64     `gorm:"column:shooter_settled"`
	ShooterWins    int64     `gorm:"column:shooter_wins"`
	Catches        int64     `gorm:"column:catches"`
	KeeperWins     int64     `gorm:"column:keeper_wins"`
	Cancelled      int64     `gorm:"column:cancelled"`
	Staked         int64     `gorm:"column:staked"`
	NetKen         int64     `gorm:"column:net_ken"`
	LastPlayAt     time.Time `gorm:"column:last_play_at"`
}

func (r *Repository) shooterSideQuery(f StatsFilter) *gorm.DB {
	return r.db.Table("pen_shots").
		Select(`pen_shots.shooter_id AS uid,
			1 AS shot,
			CASE WHEN pen_shots.status = 'settled' THEN 1 ELSE 0 END AS shooter_settled,
			CASE WHEN pen_shots.status = 'settled' AND pen_shots.winner_id = pen_shots.shooter_id THEN 1 ELSE 0 END AS shooter_win,
			0 AS caught,
			0 AS keeper_win,
			CASE WHEN pen_shots.status = 'cancelled' THEN 1 ELSE 0 END AS cancelled,
			CASE WHEN pen_shots.status = 'settled' THEN pen_shots.bet_amount ELSE 0 END AS staked,
			CASE WHEN pen_shots.status = 'settled' AND pen_shots.winner_id = pen_shots.shooter_id THEN coalesce(pen_shots.payout, 0) - pen_shots.bet_amount
				WHEN pen_shots.status = 'settled' THEN -pen_shots.bet_amount
				ELSE 0 END AS net,
			pen_shots.created_at AS played_at`).
		Scopes(statsScope(f))
}

func (r *Repository) keeperSideQuery(f StatsFilter) *gorm.DB {
	return r.db.Table("pen_shots").
		Select(`pen_shots.keeper_id AS uid,
			0 AS shot,
			0 AS shooter_settled,
			0 AS shooter_win,
			1 AS caught,
			CASE WHEN pen_shots.winner_id = pen_shots.keeper_id THEN 1 ELSE 0 END AS keeper_win,
			0 AS cancelled,
			pen_shots.bet_amount AS staked,
			CASE WHEN pen_shots.winner_id = pen_shots.keeper_id THEN coalesce(pen_shots.payout, 0) - pen_shots.bet_amount
				ELSE -pen_shots.bet_amount END AS net,
			pen_shots.created_at AS played_at`).
		Scopes(statsScope(f)).
		Where("pen_shots.keeper_id IS NOT NULL AND pen_shots.status = 'settled'")
}

func (r *Repository) UserStats(f StatsFilter, sortBy string, limit, offset int) ([]userStatsRow, int64, error) {
	sub0 := r.shooterSideQuery(f)
	sub1 := r.keeperSideQuery(f)

	base := func() *gorm.DB {
		q := r.db.Table("(? UNION ALL ?) AS t", r.shooterSideQuery(f), r.keeperSideQuery(f))
		if f.UserID != nil {
			q = q.Where("t.uid = ?", *f.UserID)
		}
		return q
	}

	var total int64
	if err := base().Distinct("t.uid").Count(&total).Error; err != nil {
		return nil, 0, err
	}

	order, ok := userStatsSorts[sortBy]
	if !ok {
		order = "staked"
	}

	query := r.db.Table("(? UNION ALL ?) AS t", sub0, sub1).
		Select(`t.uid AS user_id, users.username, users.full_name, users.avatar,
			sum(t.shot) as shots,
			sum(t.shooter_settled) as shooter_settled,
			sum(t.shooter_win) as shooter_wins,
			sum(t.caught) as catches,
			sum(t.keeper_win) as keeper_wins,
			sum(t.cancelled) as cancelled,
			coalesce(sum(t.staked), 0) as staked,
			coalesce(sum(t.net), 0) as net_ken,
			max(t.played_at) as last_play_at`).
		Joins("LEFT JOIN users ON users.id = t.uid")
	if f.UserID != nil {
		query = query.Where("t.uid = ?", *f.UserID)
	}

	var rows []userStatsRow
	err := query.
		Group("t.uid, users.username, users.full_name, users.avatar").
		Order(order + " DESC, t.uid ASC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}

func (r *Repository) SideStats(f StatsFilter) (SideStatsResponse, error) {
	var out SideStatsResponse
	q := r.db.Table("pen_shots").
		Select(`count(*) filter (where shooter_side = 'left') as shooter_left,
			count(*) filter (where shooter_side = 'right') as shooter_right,
			count(*) filter (where keeper_side = 'left') as keeper_left,
			count(*) filter (where keeper_side = 'right') as keeper_right`).
		Scopes(statsScope(f)).
		Where("pen_shots.status = 'settled'")
	if f.UserID != nil {
		q = q.Where("(pen_shots.shooter_id = ? OR pen_shots.keeper_id = ?)", *f.UserID, *f.UserID)
	}
	err := q.Scan(&out).Error
	return out, err
}
