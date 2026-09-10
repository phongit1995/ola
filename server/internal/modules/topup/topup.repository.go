package topup

import (
	"errors"
	"math"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

var (
	ErrAlreadyCredited = errors.New("topup transaction already credited")
	ErrBalanceOverflow = errors.New("ken balance overflow")
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) InsertIgnoreDuplicate(row *models.TopupTransaction) (bool, error) {
	result := r.db.Clauses(clause.OnConflict{
		Columns:   []clause.Column{{Name: "provider_tx_id"}},
		DoNothing: true,
	}).Create(row)
	if result.Error != nil {
		return false, result.Error
	}
	return result.RowsAffected > 0, nil
}

func (r *Repository) UpdateStatus(rowID uuid.UUID, status models.TopupTxStatus, note *string) error {
	updates := map[string]interface{}{"status": status, "updated_at": gorm.Expr("CURRENT_TIMESTAMP")}
	if note != nil {
		updates["note"] = *note
	}
	return r.db.Model(&models.TopupTransaction{}).Where("id = ?", rowID).Updates(updates).Error
}

func (r *Repository) FindByProviderTxID(providerTxID string) (*models.TopupTransaction, error) {
	var row models.TopupTransaction
	err := r.db.First(&row, "provider_tx_id = ?", providerTxID).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &row, nil
}

func (r *Repository) FindUserByUsernameCI(username string) (*models.User, error) {
	var u models.User
	err := r.db.Where("LOWER(username) = LOWER(?)", username).First(&u).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &u, nil
}

type CreditParams struct {
	RowID        uuid.UUID
	UserID       uuid.UUID
	KenAmount    int
	BonusKen     int64
	BonusPercent int
	ProviderTxID string
	AmountVnd    int64
	ActorType    models.KenActorType
	ActorID      *uuid.UUID
	Description  string
}

func (r *Repository) Credit(p CreditParams) (*models.User, *models.KenTransaction, error) {
	var updatedUser models.User
	var kenTx models.KenTransaction

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var row models.TopupTransaction
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&row, "id = ?", p.RowID).Error; err != nil {
			return err
		}
		if row.Status == models.TopupTxStatusCredited {
			return ErrAlreadyCredited
		}

		var u models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", p.UserID).Error; err != nil {
			return err
		}

		before := u.Ken
		if p.KenAmount <= 0 || before > math.MaxInt32-p.KenAmount {
			return ErrBalanceOverflow
		}
		after := before + p.KenAmount
		if err := tx.Model(&models.User{}).Where("id = ?", p.UserID).Update("ken", after).Error; err != nil {
			return err
		}

		kenTx = models.KenTransaction{
			UserID:        p.UserID,
			Direction:     models.KenDirectionCredit,
			Type:          models.KenTxTypeTopup,
			Amount:        p.KenAmount,
			BalanceBefore: before,
			BalanceAfter:  after,
			Description:   p.Description,
			RefType:       "topup_transaction",
			RefID:         &p.RowID,
			ActorType:     p.ActorType,
			ActorID:       p.ActorID,
			Metadata: models.JSONB{
				"providerTxId": p.ProviderTxID,
				"amountVnd":    p.AmountVnd,
				"bonusKen":     p.BonusKen,
				"bonusPercent": p.BonusPercent,
			},
		}
		if err := tx.Create(&kenTx).Error; err != nil {
			return err
		}

		if err := tx.Model(&models.TopupTransaction{}).Where("id = ?", p.RowID).Updates(map[string]interface{}{
			"status":        models.TopupTxStatusCredited,
			"user_id":       p.UserID,
			"ken_amount":    int64(p.KenAmount),
			"bonus_ken":     p.BonusKen,
			"bonus_percent": p.BonusPercent,
			"ken_tx_id":     kenTx.ID,
			"note":          nil,
			"updated_at":    gorm.Expr("CURRENT_TIMESTAMP"),
		}).Error; err != nil {
			return err
		}

		u.Ken = after
		updatedUser = u
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return &updatedUser, &kenTx, nil
}
