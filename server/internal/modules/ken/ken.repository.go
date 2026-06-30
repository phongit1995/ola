package ken

import (
	"errors"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

var (
	ErrCannotTransfer  = errors.New("cannot transfer ken to this user")
	ErrInsufficientKen = errors.New("insufficient ken balance")
	ErrSelfTransfer    = errors.New("cannot transfer ken to yourself")
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

type TransferParams struct {
	FromID      uuid.UUID
	ToID        uuid.UUID
	Amount      int
	Description string
}

type TransferResult struct {
	SenderBalance   int
	ReceiverBalance int
}

func (r *Repository) Transfer(p TransferParams) (*TransferResult, error) {
	var result TransferResult

	err := r.db.Transaction(func(tx *gorm.DB) error {
		lockOrder := []uuid.UUID{p.FromID, p.ToID}
		if lockOrder[0].String() > lockOrder[1].String() {
			lockOrder[0], lockOrder[1] = lockOrder[1], lockOrder[0]
		}

		users := make(map[uuid.UUID]*models.User, 2)
		for _, id := range lockOrder {
			var u models.User
			if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", id).Error; err != nil {
				if errors.Is(err, gorm.ErrRecordNotFound) {
					if id == p.ToID {
						return ErrCannotTransfer
					}
					return apperr.ErrUserNotFound
				}
				return err
			}
			locked := u
			users[id] = &locked
		}

		sender := users[p.FromID]
		receiver := users[p.ToID]
		if !receiver.IsActive {
			return ErrCannotTransfer
		}
		if sender.Ken < p.Amount {
			return ErrInsufficientKen
		}

		senderBefore := sender.Ken
		senderAfter := senderBefore - p.Amount
		receiverBefore := receiver.Ken
		receiverAfter := receiverBefore + p.Amount

		if err := tx.Model(&models.User{}).Where("id = ?", p.FromID).Update("ken", senderAfter).Error; err != nil {
			return err
		}
		if err := tx.Model(&models.User{}).Where("id = ?", p.ToID).Update("ken", receiverAfter).Error; err != nil {
			return err
		}

		actorID := p.FromID
		toID := p.ToID
		fromID := p.FromID
		outTx := models.KenTransaction{
			UserID:        p.FromID,
			Direction:     models.KenDirectionDebit,
			Type:          models.KenTxTypeTransferOut,
			Amount:        p.Amount,
			BalanceBefore: senderBefore,
			BalanceAfter:  senderAfter,
			Description:   p.Description,
			RefType:       "user",
			RefID:         &toID,
			ActorType:     models.KenActorUser,
			ActorID:       &actorID,
		}
		inTx := models.KenTransaction{
			UserID:        p.ToID,
			Direction:     models.KenDirectionCredit,
			Type:          models.KenTxTypeTransferIn,
			Amount:        p.Amount,
			BalanceBefore: receiverBefore,
			BalanceAfter:  receiverAfter,
			Description:   p.Description,
			RefType:       "user",
			RefID:         &fromID,
			ActorType:     models.KenActorUser,
			ActorID:       &actorID,
		}
		if err := tx.Create(&outTx).Error; err != nil {
			return err
		}
		if err := tx.Create(&inTx).Error; err != nil {
			return err
		}

		result.SenderBalance = senderAfter
		result.ReceiverBalance = receiverAfter
		return nil
	})
	if err != nil {
		return nil, err
	}
	return &result, nil
}
