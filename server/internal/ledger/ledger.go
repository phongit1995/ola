package ledger

import (
	"errors"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

var ErrInsufficientKen = errors.New("insufficient ken balance")

type Entry struct {
	Type        models.KenTxType
	Description string
	RefType     string
	RefID       *uuid.UUID
	ActorType   models.KenActorType
	ActorID     *uuid.UUID
	Metadata    models.JSONB
}

func LockUser(tx *gorm.DB, userID uuid.UUID) (*models.User, error) {
	var u models.User
	if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", userID).Error; err != nil {
		return nil, err
	}
	return &u, nil
}

func LockUserPair(tx *gorm.DB, first, second uuid.UUID) (*models.User, *models.User, error) {
	order := []uuid.UUID{first, second}
	if order[0].String() > order[1].String() {
		order[0], order[1] = order[1], order[0]
	}
	locked := make(map[uuid.UUID]*models.User, 2)
	for _, id := range order {
		u, err := LockUser(tx, id)
		if err != nil {
			return nil, nil, err
		}
		locked[id] = u
	}
	return locked[first], locked[second], nil
}

func EnsureBalance(u *models.User, amount int) error {
	if u.Ken < amount {
		return ErrInsufficientKen
	}
	return nil
}

func Debit(tx *gorm.DB, u *models.User, amount int, entry Entry) (*models.KenTransaction, error) {
	if err := EnsureBalance(u, amount); err != nil {
		return nil, err
	}
	return apply(tx, u, models.KenDirectionDebit, amount, u.Ken-amount, entry)
}

func Credit(tx *gorm.DB, u *models.User, amount int, entry Entry) (*models.KenTransaction, error) {
	return apply(tx, u, models.KenDirectionCredit, amount, u.Ken+amount, entry)
}

func Record(tx *gorm.DB, userID uuid.UUID, direction models.KenDirection, amount, before, after int, entry Entry) (*models.KenTransaction, error) {
	row := models.KenTransaction{
		UserID:        userID,
		Direction:     direction,
		Type:          entry.Type,
		Amount:        amount,
		BalanceBefore: before,
		BalanceAfter:  after,
		Description:   entry.Description,
		RefType:       entry.RefType,
		RefID:         entry.RefID,
		ActorType:     entry.ActorType,
		ActorID:       entry.ActorID,
		Metadata:      entry.Metadata,
	}
	if err := tx.Create(&row).Error; err != nil {
		return nil, err
	}
	return &row, nil
}

func apply(tx *gorm.DB, u *models.User, direction models.KenDirection, amount, after int, entry Entry) (*models.KenTransaction, error) {
	if err := tx.Model(&models.User{}).Where("id = ?", u.ID).Update("ken", after).Error; err != nil {
		return nil, err
	}
	before := u.Ken
	u.Ken = after
	if amount <= 0 {
		return nil, nil
	}
	return Record(tx, u.ID, direction, amount, before, after, entry)
}
