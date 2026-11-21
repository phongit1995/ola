package checkin

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

func (r *Repository) DB() *gorm.DB {
	return r.db
}

func (r *Repository) Transaction(fn func(tx *gorm.DB) error) error {
	return r.db.Transaction(fn)
}

func FindMonthTx(tx *gorm.DB, month time.Time) (*models.CheckinMonth, error) {
	var row models.CheckinMonth
	err := tx.Where("month = ?", month).First(&row).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &row, nil
}

func LockMonthTx(tx *gorm.DB, month time.Time) (*models.CheckinMonth, error) {
	return FindMonthTx(tx.Clauses(clause.Locking{Strength: "UPDATE"}), month)
}

func SlotsTx(tx *gorm.DB, month time.Time) ([]models.CheckinSlot, error) {
	var rows []models.CheckinSlot
	if err := tx.Where("month = ?", month).Order("slot").Find(&rows).Error; err != nil {
		return nil, err
	}
	return rows, nil
}

func findSlotTx(tx *gorm.DB, month time.Time, slot int) (models.CheckinSlot, error) {
	var row models.CheckinSlot
	err := tx.Where("month = ? AND slot = ?", month, slot).First(&row).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return models.CheckinSlot{Month: month, Slot: int16(slot), Gifts: models.CheckinGifts{}}, nil
	}
	return row, err
}

func (r *Repository) FindMonth(month time.Time) (*models.CheckinMonth, error) {
	return FindMonthTx(r.db, month)
}

func (r *Repository) Slots(month time.Time) ([]models.CheckinSlot, error) {
	return SlotsTx(r.db, month)
}

func (r *Repository) UserRows(userID uuid.UUID, month time.Time) ([]models.UserCheckin, error) {
	var rows []models.UserCheckin
	if err := r.db.Where("user_id = ? AND month = ?", userID, month).Order("slot").Find(&rows).Error; err != nil {
		return nil, err
	}
	return rows, nil
}

func (r *Repository) EmailVerified(userID uuid.UUID) (bool, error) {
	var u models.User
	if err := r.db.Select("id", "email_verified").First(&u, "id = ?", userID).Error; err != nil {
		return false, err
	}
	return u.EmailVerified, nil
}

func (r *Repository) SetTaskDone(id uuid.UUID, doneAt time.Time) error {
	return r.db.Model(&models.UserCheckin{}).Where("id = ? AND task_done_at IS NULL", id).Update("task_done_at", doneAt).Error
}

func findDayRowTx(tx *gorm.DB, userID uuid.UUID, day time.Time) (*models.UserCheckin, error) {
	var row models.UserCheckin
	err := tx.Where("user_id = ? AND day = ?", userID, day).First(&row).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &row, nil
}

func findByClientRequestTx(tx *gorm.DB, userID uuid.UUID, clientRequestID string) (*models.UserCheckin, error) {
	var row models.UserCheckin
	err := tx.Where("user_id = ? AND client_request_id = ?", userID, clientRequestID).First(&row).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &row, nil
}

func maxSlotTx(tx *gorm.DB, userID uuid.UUID, month time.Time) (int, error) {
	var maxSlot int
	err := tx.Model(&models.UserCheckin{}).Where("user_id = ? AND month = ?", userID, month).Select("COALESCE(MAX(slot), 0)").Scan(&maxSlot).Error
	return maxSlot, err
}
