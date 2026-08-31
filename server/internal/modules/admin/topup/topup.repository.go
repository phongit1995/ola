package admintopup

import (
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func listScope(f ListFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if f.Status != "" {
			db = db.Where("status = ?", f.Status)
		}
		if f.Type != "" {
			db = db.Where("type = ?", f.Type)
		}
		if f.Search != "" {
			like := "%" + f.Search + "%"
			db = db.Where("(provider_tx_id ILIKE ? OR description ILIKE ? OR matched_username ILIKE ?)", like, like, like)
		}
		if f.From != nil {
			db = db.Where("created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("created_at <= ?", *f.To)
		}
		return db
	}
}

func (r *Repository) List(f ListFilter, limit, offset int) ([]models.TopupTransaction, int64, error) {
	var total int64
	if err := r.db.Model(&models.TopupTransaction{}).Scopes(listScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var items []models.TopupTransaction
	err := r.db.Scopes(listScope(f)).
		Order("created_at DESC, id DESC").
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, total, err
}

func (r *Repository) FindByID(id uuid.UUID) (*models.TopupTransaction, error) {
	var row models.TopupTransaction
	err := r.db.First(&row, "id = ?", id).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &row, nil
}

var pendingStatuses = []models.TopupTxStatus{
	models.TopupTxStatusProcessing,
	models.TopupTxStatusNoMatch,
	models.TopupTxStatusBelowMin,
	models.TopupTxStatusSkippedDisabled,
	models.TopupTxStatusFailed,
}

type statsTotalsRow struct {
	Count  int64 `gorm:"column:count"`
	Amount int64 `gorm:"column:amount"`
	Ken    int64 `gorm:"column:ken"`
}

type statsSeriesRow struct {
	Date   string `gorm:"column:date"`
	Amount int64  `gorm:"column:amount"`
	Ken    int64  `gorm:"column:ken"`
	Count  int64  `gorm:"column:count"`
}

func (r *Repository) CreditedTotals(from, to *time.Time) (statsTotalsRow, error) {
	var row statsTotalsRow
	q := r.db.Model(&models.TopupTransaction{}).
		Select("count(*) as count, coalesce(sum(amount),0) as amount, coalesce(sum(ken_amount),0) as ken").
		Where("status = ?", models.TopupTxStatusCredited)
	if from != nil {
		q = q.Where("created_at >= ?", *from)
	}
	if to != nil {
		q = q.Where("created_at <= ?", *to)
	}
	err := q.Scan(&row).Error
	return row, err
}

func (r *Repository) PendingTotals() (statsTotalsRow, error) {
	var row statsTotalsRow
	err := r.db.Model(&models.TopupTransaction{}).
		Select("count(*) as count, coalesce(sum(amount),0) as amount, coalesce(sum(ken_amount),0) as ken").
		Where("type = ?", "IN").
		Where("status IN ?", pendingStatuses).
		Scan(&row).Error
	return row, err
}

func (r *Repository) CreditedSeries(from, to time.Time, bucket string) ([]statsSeriesRow, error) {
	trunc, format := "day", "YYYY-MM-DD"
	if bucket == "month" {
		trunc, format = "month", "YYYY-MM"
	}
	var rows []statsSeriesRow
	err := r.db.Model(&models.TopupTransaction{}).
		Select(fmt.Sprintf("to_char(date_trunc('%s', created_at), '%s') as date, coalesce(sum(amount),0) as amount, coalesce(sum(ken_amount),0) as ken, count(*) as count", trunc, format)).
		Where("status = ?", models.TopupTxStatusCredited).
		Where("created_at >= ? AND created_at <= ?", from, to).
		Group(fmt.Sprintf("date_trunc('%s', created_at)", trunc)).
		Order(fmt.Sprintf("date_trunc('%s', created_at) ASC", trunc)).
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) FindUsersByIDs(ids []uuid.UUID) (map[uuid.UUID]models.User, error) {
	result := make(map[uuid.UUID]models.User, len(ids))
	if len(ids) == 0 {
		return result, nil
	}
	var users []models.User
	if err := r.db.Unscoped().
		Select("id", "username", "full_name", "avatar").
		Where("id IN ?", ids).
		Find(&users).Error; err != nil {
		return nil, err
	}
	for i := range users {
		result[users[i].ID] = users[i]
	}
	return result, nil
}
