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
	ErrBlockedTransfer = errors.New("cannot transfer ken to a blocked user")
	ErrInsufficientKen = errors.New("insufficient ken balance")
	ErrSelfTransfer    = errors.New("cannot transfer ken to yourself")
	ErrWrongPassword   = errors.New("invalid transfer password")
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

var visibleKenTxTypes = []models.KenTxType{
	models.KenTxTypeTransferIn,
	models.KenTxTypeTransferOut,
	models.KenTxTypeAdminGrant,
	models.KenTxTypeAdminDeduct,
	models.KenTxTypeVipPackage,
	models.KenTxTypeVipIcon,
	models.KenTxTypeClanCreate,
}

func (r *Repository) ListTransactions(userID uuid.UUID, direction string, limit, offset int) ([]models.KenTransaction, int64, error) {
	var items []models.KenTransaction
	var total int64

	countQ := r.db.Model(&models.KenTransaction{}).Where("user_id = ?", userID).Where("type IN ?", visibleKenTxTypes)
	listQ := r.db.Where("user_id = ?", userID).Where("type IN ?", visibleKenTxTypes)
	if direction != "" {
		countQ = countQ.Where("direction = ?", direction)
		listQ = listQ.Where("direction = ?", direction)
	}

	if err := countQ.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	err := listQ.Order("created_at DESC").Limit(limit).Offset(offset).Find(&items).Error
	return items, total, err
}

func (r *Repository) FindUsernames(ids []uuid.UUID) (map[uuid.UUID]string, error) {
	names := make(map[uuid.UUID]string, len(ids))
	if len(ids) == 0 {
		return names, nil
	}
	var rows []struct {
		ID       uuid.UUID
		Username string
	}
	if err := r.db.Unscoped().Model(&models.User{}).Select("id", "username").Where("id IN ?", ids).Find(&rows).Error; err != nil {
		return nil, err
	}
	for _, row := range rows {
		names[row.ID] = row.Username
	}
	return names, nil
}

func (r *Repository) GetPasswordHash(userID uuid.UUID) (string, error) {
	var user models.User
	if err := r.db.Select("password").First(&user, "id = ?", userID).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return "", apperr.ErrUserNotFound
		}
		return "", err
	}
	return user.Password, nil
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
