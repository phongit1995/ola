package pen

import (
	"bytes"
	"fmt"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

const penRefType = "pen_shot"

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func briefSelect(tx *gorm.DB) *gorm.DB {
	return tx.Select("id", "username", "full_name", "avatar", "vip_used", "vip_end_time")
}

func orderIDs(a, b uuid.UUID) (uuid.UUID, uuid.UUID) {
	if bytes.Compare(a[:], b[:]) <= 0 {
		return a, b
	}
	return b, a
}

type OpenFilter struct {
	Bet    *int
	MinBet *int
	MaxBet *int
	Sort   string
}

func (r *Repository) ListOpenShots(excludeUserID uuid.UUID, f OpenFilter, limit, offset int) ([]models.PenShot, int64, error) {
	q := r.db.Model(&models.PenShot{}).
		Where("status = ? AND shooter_id <> ?", models.PenStatusOpen, excludeUserID)
	if f.Bet != nil {
		q = q.Where("bet_amount = ?", *f.Bet)
	}
	if f.MinBet != nil {
		q = q.Where("bet_amount >= ?", *f.MinBet)
	}
	if f.MaxBet != nil {
		q = q.Where("bet_amount <= ?", *f.MaxBet)
	}

	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	order := "created_at DESC"
	switch f.Sort {
	case "bet_desc":
		order = "bet_amount DESC, created_at DESC"
	case "bet_asc":
		order = "bet_amount ASC, created_at DESC"
	}

	var items []models.PenShot
	err := q.Preload("Shooter", briefSelect).
		Order(order).
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, total, err
}

func (r *Repository) ListMyOpenShots(shooterID uuid.UUID, limit, offset int) ([]models.PenShot, int64, error) {
	q := r.db.Model(&models.PenShot{}).
		Where("shooter_id = ? AND status = ?", shooterID, models.PenStatusOpen)

	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var items []models.PenShot
	err := q.Order("created_at DESC").Limit(limit).Offset(offset).Find(&items).Error
	return items, total, err
}

func (r *Repository) ListHistory(userID uuid.UUID, role, result string, limit, offset int) ([]models.PenShot, int64, error) {
	q := r.db.Model(&models.PenShot{})
	switch role {
	case "shoot":
		q = q.Where("shooter_id = ?", userID)
	case "catch":
		q = q.Where("keeper_id = ?", userID)
	default:
		q = q.Where("shooter_id = ? OR keeper_id = ?", userID, userID)
	}
	switch result {
	case "win":
		q = q.Where("winner_id = ?", userID)
	case "lose":
		q = q.Where("status = ? AND winner_id IS NOT NULL AND winner_id <> ?", models.PenStatusSettled, userID)
	}

	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var items []models.PenShot
	err := q.
		Preload("Shooter", briefSelect).
		Preload("Keeper", briefSelect).
		Order("created_at DESC").
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, total, err
}

func (r *Repository) ListAllSettled(limit, offset int) ([]models.PenShot, int64, error) {
	q := r.db.Model(&models.PenShot{}).Where("status = ?", models.PenStatusSettled)

	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var items []models.PenShot
	err := q.
		Preload("Shooter", briefSelect).
		Preload("Keeper", briefSelect).
		Order("created_at DESC").
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, total, err
}

func (r *Repository) CreateShot(shooterID uuid.UUID, side models.PenSide, bet int) (*models.PenShot, int, error) {
	var shot models.PenShot
	var newKen int

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var u models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", shooterID).Error; err != nil {
			return err
		}
		if u.Ken < bet {
			return ErrInsufficientKen
		}

		shot = models.PenShot{
			ShooterID:   shooterID,
			ShooterSide: side,
			BetAmount:   bet,
			Status:      models.PenStatusOpen,
		}
		if err := tx.Create(&shot).Error; err != nil {
			return err
		}

		before := u.Ken
		after := before - bet
		// TODO(ken): tạm tắt ghi ken_transactions cho game PEN — mở lại sau.
		// shootTx := models.KenTransaction{
		// 	UserID:        shooterID,
		// 	Direction:     models.KenDirectionDebit,
		// 	Type:          models.KenTxTypePenShoot,
		// 	Amount:        bet,
		// 	BalanceBefore: before,
		// 	BalanceAfter:  after,
		// 	Description:   "PEN đặt cược",
		// 	RefType:       penRefType,
		// 	RefID:         &shot.ID,
		// 	ActorType:     models.KenActorUser,
		// 	ActorID:       &shooterID,
		// }
		// if err := tx.Create(&shootTx).Error; err != nil {
		// 	return err
		// }
		// if err := tx.Model(&models.PenShot{}).Where("id = ?", shot.ID).Update("shoot_tx_id", shootTx.ID).Error; err != nil {
		// 	return err
		// }
		if err := tx.Model(&models.User{}).Where("id = ?", shooterID).Update("ken", after).Error; err != nil {
			return err
		}

		// shot.ShootTxID = &shootTx.ID
		newKen = after
		return nil
	})
	if err != nil {
		return nil, 0, err
	}
	return &shot, newKen, nil
}

func (r *Repository) CatchShot(keeperID, shotID uuid.UUID, keeperSide models.PenSide, commissionPercent int) (shot *models.PenShot, shooterKen, keeperKen int, err error) {
	var out models.PenShot

	err = r.db.Transaction(func(tx *gorm.DB) error {
		var s models.PenShot
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&s, "id = ?", shotID).Error; err != nil {
			return err
		}
		if s.Status != models.PenStatusOpen {
			return ErrShotNotOpen
		}
		if s.ShooterID == keeperID {
			return ErrCannotCatchOwn
		}

		first, second := orderIDs(s.ShooterID, keeperID)
		var u1, u2 models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u1, "id = ?", first).Error; err != nil {
			return err
		}
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u2, "id = ?", second).Error; err != nil {
			return err
		}
		shooter, keeper := &u1, &u2
		if s.ShooterID == second {
			shooter, keeper = &u2, &u1
		}

		bet := s.BetAmount
		if keeper.Ken < bet {
			return ErrInsufficientKen
		}

		// TODO(ken): tạm tắt ghi ken_transactions cho game PEN — mở lại sau.
		// applyDelta chỉ cập nhật số dư, không còn tạo bản ghi ken_transactions.
		applyDelta := func(u *models.User, dir models.KenDirection, txType models.KenTxType, amount int, desc string, actor models.KenActorType) error {
			after := u.Ken + amount
			if dir == models.KenDirectionDebit {
				after = u.Ken - amount
			}
			// ktx := models.KenTransaction{
			// 	UserID:        u.ID,
			// 	Direction:     dir,
			// 	Type:          txType,
			// 	Amount:        amount,
			// 	BalanceBefore: u.Ken,
			// 	BalanceAfter:  after,
			// 	Description:   desc,
			// 	RefType:       penRefType,
			// 	RefID:         &s.ID,
			// 	ActorType:     actor,
			// }
			// if actor == models.KenActorUser {
			// 	ktx.ActorID = &u.ID
			// }
			// if err := tx.Create(&ktx).Error; err != nil {
			// 	return err
			// }
			u.Ken = after
			return nil
		}

		if err := applyDelta(keeper, models.KenDirectionDebit, models.KenTxTypePenCatch, bet, "PEN bắt cược", models.KenActorUser); err != nil {
			return err
		}

		result := models.PenResultGoal
		winner := shooter
		if keeperSide == s.ShooterSide {
			result = models.PenResultSaved
			winner = keeper
		}

		pot := bet * 2
		commission := pot * commissionPercent / 100
		payout := pot - commission

		if err := applyDelta(winner, models.KenDirectionCredit, models.KenTxTypePenWin, payout, "PEN thắng cược", models.KenActorSystem); err != nil {
			return err
		}

		if err := tx.Model(&models.User{}).Where("id = ?", keeper.ID).Update("ken", keeper.Ken).Error; err != nil {
			return err
		}
		if err := tx.Model(&models.User{}).Where("id = ?", shooter.ID).Update("ken", shooter.Ken).Error; err != nil {
			return err
		}

		now := time.Now()
		ks := keeperSide
		updates := map[string]interface{}{
			"status":       models.PenStatusSettled,
			"keeper_id":    keeper.ID,
			"keeper_side":  ks,
			"result":       result,
			"winner_id":    winner.ID,
			"pot":          pot,
			"commission":   commission,
			"payout":       payout,
			// "catch_tx_id":  catchTx.ID,   // TODO(ken): mở lại khi bật ghi ken_transactions cho PEN
			// "payout_tx_id": payoutTx.ID,
			"settled_at": now,
		}
		if err := tx.Model(&models.PenShot{}).Where("id = ?", s.ID).Updates(updates).Error; err != nil {
			return err
		}

		s.Status = models.PenStatusSettled
		s.KeeperID = &keeper.ID
		s.KeeperSide = &ks
		s.Result = &result
		s.WinnerID = &winner.ID
		s.Pot = &pot
		s.Commission = &commission
		s.Payout = &payout
		// s.CatchTxID = &catchTx.ID   // TODO(ken): mở lại khi bật ghi ken_transactions cho PEN
		// s.PayoutTxID = &payoutTx.ID
		s.SettledAt = &now

		out = s
		shooterKen = shooter.Ken
		keeperKen = keeper.Ken
		return nil
	})
	if err != nil {
		return nil, 0, 0, err
	}
	return &out, shooterKen, keeperKen, nil
}

func (r *Repository) CancelShot(shooterID, shotID uuid.UUID) (*models.PenShot, int, error) {
	var out models.PenShot
	var newKen int

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var s models.PenShot
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&s, "id = ?", shotID).Error; err != nil {
			return err
		}
		if s.ShooterID != shooterID {
			return ErrNotYourShot
		}
		if s.Status != models.PenStatusOpen {
			return ErrShotNotOpen
		}

		var u models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", shooterID).Error; err != nil {
			return err
		}

		before := u.Ken
		after := before + s.BetAmount
		// TODO(ken): tạm tắt ghi ken_transactions cho game PEN — mở lại sau.
		// refundTx := models.KenTransaction{
		// 	UserID:        shooterID,
		// 	Direction:     models.KenDirectionCredit,
		// 	Type:          models.KenTxTypePenRefund,
		// 	Amount:        s.BetAmount,
		// 	BalanceBefore: before,
		// 	BalanceAfter:  after,
		// 	Description:   "PEN hoàn cược",
		// 	RefType:       penRefType,
		// 	RefID:         &s.ID,
		// 	ActorType:     models.KenActorUser,
		// 	ActorID:       &shooterID,
		// }
		// if err := tx.Create(&refundTx).Error; err != nil {
		// 	return err
		// }
		if err := tx.Model(&models.User{}).Where("id = ?", shooterID).Update("ken", after).Error; err != nil {
			return err
		}

		now := time.Now()
		updates := map[string]interface{}{
			"status": models.PenStatusCancelled,
			// "refund_tx_id": refundTx.ID,   // TODO(ken): mở lại khi bật ghi ken_transactions cho PEN
			"cancelled_at": now,
		}
		if err := tx.Model(&models.PenShot{}).Where("id = ?", s.ID).Updates(updates).Error; err != nil {
			return err
		}

		s.Status = models.PenStatusCancelled
		// s.RefundTxID = &refundTx.ID   // TODO(ken): mở lại khi bật ghi ken_transactions cho PEN
		s.CancelledAt = &now
		out = s
		newKen = after
		return nil
	})
	if err != nil {
		return nil, 0, err
	}
	return &out, newKen, nil
}

type AdminShotFilter struct {
	ShooterID *uuid.UUID
	KeeperID  *uuid.UUID
	Status    string
	Result    string
	MinBet    *int
	MaxBet    *int
	From      *time.Time
	To        *time.Time
}

func adminShotScope(f AdminShotFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if f.ShooterID != nil {
			db = db.Where("pen_shots.shooter_id = ?", *f.ShooterID)
		}
		if f.KeeperID != nil {
			db = db.Where("pen_shots.keeper_id = ?", *f.KeeperID)
		}
		if f.Status != "" {
			db = db.Where("pen_shots.status = ?", f.Status)
		}
		if f.Result != "" {
			db = db.Where("pen_shots.result = ?", f.Result)
		}
		if f.MinBet != nil {
			db = db.Where("pen_shots.bet_amount >= ?", *f.MinBet)
		}
		if f.MaxBet != nil {
			db = db.Where("pen_shots.bet_amount <= ?", *f.MaxBet)
		}
		if f.From != nil {
			db = db.Where("pen_shots.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("pen_shots.created_at <= ?", *f.To)
		}
		return db
	}
}

func (r *Repository) ListAllShots(f AdminShotFilter, limit, offset int) ([]models.PenShot, int64, error) {
	q := r.db.Model(&models.PenShot{}).Scopes(adminShotScope(f))

	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var items []models.PenShot
	err := q.
		Preload("Shooter", briefSelect).
		Preload("Keeper", briefSelect).
		Order("created_at DESC").
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, total, err
}

func (r *Repository) StatsOverview(f AdminShotFilter) (StatsOverview, error) {
	var o StatsOverview
	err := r.db.Model(&models.PenShot{}).Scopes(adminShotScope(f)).
		Select(`count(*) as total_shots,
			count(*) filter (where status = 'settled') as settled_shots,
			count(*) filter (where status = 'open') as open_shots,
			count(*) filter (where status = 'cancelled') as cancelled_shots,
			count(distinct shooter_id) as unique_shooters,
			count(distinct keeper_id) as unique_keepers,
			coalesce(sum(pot) filter (where status = 'settled'),0) as total_volume,
			coalesce(sum(commission) filter (where status = 'settled'),0) as house_take,
			coalesce(sum(payout) filter (where status = 'settled'),0) as total_payout,
			count(*) filter (where result = 'saved') as saved_count,
			count(*) filter (where result = 'goal') as goal_count`).
		Scan(&o).Error
	return o, err
}

func (r *Repository) StatsByResult(f AdminShotFilter) ([]StatsResult, error) {
	var rows []StatsResult
	err := r.db.Model(&models.PenShot{}).Scopes(adminShotScope(f)).
		Where("result IS NOT NULL").
		Select("result, count(*) as count").
		Group("result").
		Order("count DESC").
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) StatsByStatus(f AdminShotFilter) ([]StatsStatus, error) {
	var rows []StatsStatus
	err := r.db.Model(&models.PenShot{}).Scopes(adminShotScope(f)).
		Select("status, count(*) as count").
		Group("status").
		Order("count DESC").
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) StatsTimeseries(f AdminShotFilter, bucket string) ([]StatsTimePoint, error) {
	trunc, format := "day", "YYYY-MM-DD"
	if bucket == "month" {
		trunc, format = "month", "YYYY-MM"
	}
	var rows []StatsTimePoint
	err := r.db.Model(&models.PenShot{}).Scopes(adminShotScope(f)).
		Select(fmt.Sprintf(`to_char(date_trunc('%s', created_at), '%s') as date,
			count(*) as shots,
			count(*) filter (where status = 'settled') as settled,
			coalesce(sum(pot) filter (where status = 'settled'),0) as volume,
			coalesce(sum(commission) filter (where status = 'settled'),0) as house_take`, trunc, format)).
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
	Shots    int64     `gorm:"column:shots"`
	Staked   int64     `gorm:"column:staked"`
	Won      int64     `gorm:"column:won"`
}

type LeaderboardRow struct {
	UserID     uuid.UUID  `gorm:"column:user_id"`
	Username   string     `gorm:"column:username"`
	FullName   string     `gorm:"column:full_name"`
	Avatar     string     `gorm:"column:avatar"`
	VipUsed    *string    `gorm:"column:vip_used"`
	VipEndTime *time.Time `gorm:"column:vip_end_time"`
	Profit     int64      `gorm:"column:profit"`
	Plays      int64      `gorm:"column:plays"`
	Wins       int64      `gorm:"column:wins"`
}

func (r *Repository) Leaderboard(from, to time.Time, limit int) ([]LeaderboardRow, error) {
	fromStr := from.UTC().Format("2006-01-02 15:04:05")
	toStr := to.UTC().Format("2006-01-02 15:04:05")
	sub := `
		SELECT shooter_id AS uid,
			(CASE WHEN winner_id = shooter_id THEN payout ELSE 0 END) - bet_amount AS net,
			(CASE WHEN winner_id = shooter_id THEN 1 ELSE 0 END) AS win
		FROM pen_shots
		WHERE status = 'settled' AND deleted_at IS NULL
			AND settled_at >= ?::timestamp AND settled_at < ?::timestamp
		UNION ALL
		SELECT keeper_id AS uid,
			(CASE WHEN winner_id = keeper_id THEN payout ELSE 0 END) - bet_amount AS net,
			(CASE WHEN winner_id = keeper_id THEN 1 ELSE 0 END) AS win
		FROM pen_shots
		WHERE status = 'settled' AND keeper_id IS NOT NULL AND deleted_at IS NULL
			AND settled_at >= ?::timestamp AND settled_at < ?::timestamp`

	var rows []LeaderboardRow
	err := r.db.Table("(?) as t", gorm.Expr(sub, fromStr, toStr, fromStr, toStr)).
		Select(`t.uid as user_id, users.username, users.full_name, users.avatar, users.vip_used, users.vip_end_time,
			coalesce(sum(t.net),0) as profit,
			count(*) as plays,
			coalesce(sum(t.win),0) as wins`).
		Joins("JOIN users ON users.id = t.uid").
		Group("t.uid, users.username, users.full_name, users.avatar, users.vip_used, users.vip_end_time").
		Having("coalesce(sum(t.net),0) > 0").
		Order("profit DESC").
		Limit(limit).
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) StatsTopPlayers(f AdminShotFilter, limit int) ([]StatsPlayerRow, error) {
	var rows []StatsPlayerRow
	err := r.db.Table("pen_shots").
		Select(`pen_shots.shooter_id as user_id, users.username, users.full_name, users.avatar,
			count(*) as shots,
			coalesce(sum(pen_shots.bet_amount),0) as staked,
			coalesce(sum(case when pen_shots.winner_id = pen_shots.shooter_id then pen_shots.payout else 0 end),0) as won`).
		Joins("LEFT JOIN users ON users.id = pen_shots.shooter_id").
		Scopes(adminShotScope(f)).
		Group("pen_shots.shooter_id, users.username, users.full_name, users.avatar").
		Order("staked DESC").
		Limit(limit).
		Scan(&rows).Error
	return rows, err
}
