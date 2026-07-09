package kenchest

import (
	"errors"
	"time"

	"ola-chat-server/internal/models"

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

type ClaimOutcome struct {
	KenAmount  int
	IsEmpty    bool
	KenBalance int
}

type ClaimRow struct {
	models.KenChestClaim
	Username string `gorm:"column:username"`
	FullName string `gorm:"column:full_name"`
	Avatar   string `gorm:"column:avatar"`
}

func (r *Repository) CreateChest(chest *models.KenChest) error {
	return r.db.Create(chest).Error
}

func (r *Repository) FindByID(id uuid.UUID) (*models.KenChest, error) {
	var chest models.KenChest
	if err := r.db.First(&chest, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &chest, nil
}

func (r *Repository) HasActiveChest(now time.Time) (bool, error) {
	var count int64
	err := r.db.Model(&models.KenChest{}).
		Where("status = ? AND expires_at > ?", models.KenChestStatusActive, now).
		Count(&count).Error
	return count > 0, err
}

func (r *Repository) ListChests(limit, offset int) ([]models.KenChest, int64, error) {
	var chests []models.KenChest
	var total int64
	if err := r.db.Model(&models.KenChest{}).Count(&total).Error; err != nil {
		return nil, 0, err
	}
	if err := r.db.Order("created_at DESC").Limit(limit).Offset(offset).Find(&chests).Error; err != nil {
		return nil, 0, err
	}
	return chests, total, nil
}

func (r *Repository) ListClaims(chestID uuid.UUID, limit, offset int) ([]ClaimRow, int64, error) {
	var total int64
	if err := r.db.Model(&models.KenChestClaim{}).Where("chest_id = ?", chestID).Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var rows []ClaimRow
	err := r.db.Table("ken_chest_claims").
		Select("ken_chest_claims.*, users.username, users.full_name, users.avatar").
		Joins("LEFT JOIN users ON users.id = ken_chest_claims.user_id").
		Where("ken_chest_claims.chest_id = ?", chestID).
		Order("ken_chest_claims.created_at DESC").
		Limit(limit).Offset(offset).
		Scan(&rows).Error
	if err != nil {
		return nil, 0, err
	}
	return rows, total, nil
}

func (r *Repository) FindClaim(chestID, userID uuid.UUID) (*models.KenChestClaim, error) {
	var claim models.KenChestClaim
	if err := r.db.Where("chest_id = ? AND user_id = ?", chestID, userID).First(&claim).Error; err != nil {
		return nil, err
	}
	return &claim, nil
}

func (r *Repository) GetUserKen(userID uuid.UUID) (int, error) {
	var u models.User
	if err := r.db.Select("ken").First(&u, "id = ?", userID).Error; err != nil {
		return 0, err
	}
	return u.Ken, nil
}

func (r *Repository) SoftDeleteChest(id uuid.UUID) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&models.KenChest{}).Where("id = ?", id).
			Update("status", models.KenChestStatusDeleted).Error; err != nil {
			return err
		}
		return tx.Delete(&models.KenChest{}, "id = ?", id).Error
	})
}

func (r *Repository) ListAutoJobs() ([]models.KenChestAutoJob, error) {
	var jobs []models.KenChestAutoJob
	if err := r.db.Order("created_at DESC").Find(&jobs).Error; err != nil {
		return nil, err
	}
	return jobs, nil
}

func (r *Repository) FindAutoJobByID(id uuid.UUID) (*models.KenChestAutoJob, error) {
	var job models.KenChestAutoJob
	if err := r.db.First(&job, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &job, nil
}

func (r *Repository) CreateAutoJob(job *models.KenChestAutoJob) error {
	return r.db.Create(job).Error
}

func (r *Repository) UpdateAutoJob(job *models.KenChestAutoJob) error {
	return r.db.Save(job).Error
}

func (r *Repository) DeleteAutoJob(id uuid.UUID) error {
	return r.db.Delete(&models.KenChestAutoJob{}, "id = ?", id).Error
}

func (r *Repository) ListEnabledDueJobs(now time.Time) ([]models.KenChestAutoJob, error) {
	var jobs []models.KenChestAutoJob
	err := r.db.
		Where("enabled = ? AND (remaining_runs IS NULL OR remaining_runs > 0) AND (next_run_at IS NULL OR next_run_at <= ?)", true, now).
		Find(&jobs).Error
	if err != nil {
		return nil, err
	}
	return jobs, nil
}

func (r *Repository) EarliestEnabledNextRun() (bool, *time.Time, error) {
	var job models.KenChestAutoJob
	err := r.db.
		Where("enabled = ? AND (remaining_runs IS NULL OR remaining_runs > 0)", true).
		Order("next_run_at IS NULL DESC, next_run_at ASC").
		First(&job).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return false, nil, nil
		}
		return false, nil, err
	}
	return true, job.NextRunAt, nil
}

func (r *Repository) ClaimDueJob(id uuid.UUID, expected *time.Time, next time.Time, now time.Time) (bool, error) {
	q := r.db.Model(&models.KenChestAutoJob{}).
		Where("id = ? AND (remaining_runs IS NULL OR remaining_runs > 0)", id)
	if expected == nil {
		q = q.Where("next_run_at IS NULL")
	} else {
		q = q.Where("next_run_at = ?", *expected)
	}
	res := q.Updates(map[string]interface{}{
		"last_run_at":    now,
		"run_count":      gorm.Expr("run_count + 1"),
		"remaining_runs": gorm.Expr("CASE WHEN remaining_runs IS NOT NULL THEN remaining_runs - 1 ELSE NULL END"),
		"next_run_at":    gorm.Expr("CASE WHEN remaining_runs IS NOT NULL AND remaining_runs <= 1 THEN NULL ELSE ? END", next),
		"enabled":        gorm.Expr("CASE WHEN remaining_runs IS NOT NULL AND remaining_runs <= 1 THEN false ELSE enabled END"),
	})
	if res.Error != nil {
		return false, res.Error
	}
	return res.RowsAffected == 1, nil
}

func (r *Repository) GetAutoSettings() (*models.KenChestAutoSettings, error) {
	var settings models.KenChestAutoSettings
	if err := r.db.First(&settings).Error; err != nil {
		return nil, err
	}
	return &settings, nil
}

func (r *Repository) UpdateAutoSettings(enabled bool, updatedBy *uuid.UUID) error {
	return r.db.Model(&models.KenChestAutoSettings{}).
		Where("1 = 1").
		Updates(map[string]interface{}{"enabled": enabled, "updated_by": updatedBy, "updated_at": time.Now().UTC()}).Error
}

func (r *Repository) ApplyClaim(userID uuid.UUID, chest *models.KenChest, rolledAmount int) (*ClaimOutcome, error) {
	var out ClaimOutcome

	err := r.db.Transaction(func(tx *gorm.DB) error {
		res := tx.Model(&models.KenChest{}).
			Where("id = ? AND status = ? AND claimed_recipients < max_recipients", chest.ID, models.KenChestStatusActive).
			UpdateColumn("claimed_recipients", gorm.Expr("claimed_recipients + 1"))
		if res.Error != nil {
			return res.Error
		}
		gotSlot := res.RowsAffected == 1

		amount := 0
		isEmpty := true
		var kenTxID *uuid.UUID
		var finalKen int

		if gotSlot {
			var u models.User
			if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", userID).Error; err != nil {
				return err
			}
			before := u.Ken
			amount = rolledAmount
			isEmpty = false
			finalKen = before + amount

			// TODO(ken): tạm tắt ghi ken_transactions cho game Rương Ken — mở lại sau.
			// chestID := chest.ID
			// ktx := models.KenTransaction{
			// 	UserID:        userID,
			// 	Direction:     models.KenDirectionCredit,
			// 	Type:          models.KenTxTypeKenChest,
			// 	Amount:        amount,
			// 	BalanceBefore: before,
			// 	BalanceAfter:  finalKen,
			// 	Description:   "Rương Ken",
			// 	RefType:       "ken_chest",
			// 	RefID:         &chestID,
			// 	ActorType:     models.KenActorSystem,
			// }
			// if err := tx.Create(&ktx).Error; err != nil {
			// 	return err
			// }
			// kenTxID = &ktx.ID
			if err := tx.Model(&models.User{}).Where("id = ?", userID).Update("ken", finalKen).Error; err != nil {
				return err
			}
		} else {
			var u models.User
			if err := tx.Select("ken").First(&u, "id = ?", userID).Error; err != nil {
				return err
			}
			finalKen = u.Ken
		}

		claim := models.KenChestClaim{
			ChestID:   chest.ID,
			UserID:    userID,
			KenAmount: amount,
			IsEmpty:   isEmpty,
			KenTxID:   kenTxID,
		}
		if err := tx.Create(&claim).Error; err != nil {
			return err
		}

		upd := map[string]interface{}{"claims_count": gorm.Expr("claims_count + 1")}
		if !isEmpty {
			upd["total_ken_given"] = gorm.Expr("total_ken_given + ?", amount)
		}
		if err := tx.Model(&models.KenChest{}).Where("id = ?", chest.ID).Updates(upd).Error; err != nil {
			return err
		}

		out = ClaimOutcome{KenAmount: amount, IsEmpty: isEmpty, KenBalance: finalKen}
		return nil
	})
	if err != nil {
		return nil, err
	}
	return &out, nil
}
