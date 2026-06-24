package pen

import (
	"bytes"
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
	return tx.Select("id", "username", "full_name", "avatar")
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
	q := r.db.Model(&models.PenShot{}).Where("status <> ?", models.PenStatusOpen)
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
		shootTx := models.KenTransaction{
			UserID:        shooterID,
			Direction:     models.KenDirectionDebit,
			Type:          models.KenTxTypePenShoot,
			Amount:        bet,
			BalanceBefore: before,
			BalanceAfter:  after,
			Description:   "PEN đặt cược",
			RefType:       penRefType,
			RefID:         &shot.ID,
			ActorType:     models.KenActorUser,
			ActorID:       &shooterID,
		}
		if err := tx.Create(&shootTx).Error; err != nil {
			return err
		}

		if err := tx.Model(&models.PenShot{}).Where("id = ?", shot.ID).Update("shoot_tx_id", shootTx.ID).Error; err != nil {
			return err
		}
		if err := tx.Model(&models.User{}).Where("id = ?", shooterID).Update("ken", after).Error; err != nil {
			return err
		}

		shot.ShootTxID = &shootTx.ID
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

		applyDelta := func(u *models.User, dir models.KenDirection, txType models.KenTxType, amount int, desc string, actor models.KenActorType) (*models.KenTransaction, error) {
			before := u.Ken
			after := before + amount
			if dir == models.KenDirectionDebit {
				after = before - amount
			}
			ktx := models.KenTransaction{
				UserID:        u.ID,
				Direction:     dir,
				Type:          txType,
				Amount:        amount,
				BalanceBefore: before,
				BalanceAfter:  after,
				Description:   desc,
				RefType:       penRefType,
				RefID:         &s.ID,
				ActorType:     actor,
			}
			if actor == models.KenActorUser {
				ktx.ActorID = &u.ID
			}
			if err := tx.Create(&ktx).Error; err != nil {
				return nil, err
			}
			u.Ken = after
			return &ktx, nil
		}

		catchTx, err := applyDelta(keeper, models.KenDirectionDebit, models.KenTxTypePenCatch, bet, "PEN bắt cược", models.KenActorUser)
		if err != nil {
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

		payoutTx, err := applyDelta(winner, models.KenDirectionCredit, models.KenTxTypePenWin, payout, "PEN thắng cược", models.KenActorSystem)
		if err != nil {
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
			"catch_tx_id":  catchTx.ID,
			"payout_tx_id": payoutTx.ID,
			"settled_at":   now,
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
		s.CatchTxID = &catchTx.ID
		s.PayoutTxID = &payoutTx.ID
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
		refundTx := models.KenTransaction{
			UserID:        shooterID,
			Direction:     models.KenDirectionCredit,
			Type:          models.KenTxTypePenRefund,
			Amount:        s.BetAmount,
			BalanceBefore: before,
			BalanceAfter:  after,
			Description:   "PEN hoàn cược",
			RefType:       penRefType,
			RefID:         &s.ID,
			ActorType:     models.KenActorUser,
			ActorID:       &shooterID,
		}
		if err := tx.Create(&refundTx).Error; err != nil {
			return err
		}
		if err := tx.Model(&models.User{}).Where("id = ?", shooterID).Update("ken", after).Error; err != nil {
			return err
		}

		now := time.Now()
		updates := map[string]interface{}{
			"status":       models.PenStatusCancelled,
			"refund_tx_id": refundTx.ID,
			"cancelled_at": now,
		}
		if err := tx.Model(&models.PenShot{}).Where("id = ?", s.ID).Updates(updates).Error; err != nil {
			return err
		}

		s.Status = models.PenStatusCancelled
		s.RefundTxID = &refundTx.ID
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
