package adminreport

import (
	"time"

	"ola-chat-server/internal/constants"
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

func (r *Repository) List(f ListFilter) ([]*models.Report, int64, error) {
	db := r.db.Model(&models.Report{})
	if f.Status != "" {
		db = db.Where("status = ?", f.Status)
	}
	if f.TargetType != "" {
		db = db.Where("target_type = ?", f.TargetType)
	}
	if f.ReportedUserID != nil {
		db = db.Where("reported_user_id = ?", *f.ReportedUserID)
	}
	if f.Query != "" {
		like := "%" + f.Query + "%"
		db = db.Where(
			"(reporter_id IN (SELECT id FROM users WHERE username ILIKE ?) OR reported_user_id IN (SELECT id FROM users WHERE username ILIKE ?))",
			like, like,
		)
	}

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var reports []*models.Report
	err := db.Preload("Reporter").Preload("ReportedUser").Preload("Handler").
		Order("created_at DESC").Limit(f.Limit).Offset(f.Offset).
		Find(&reports).Error
	return reports, total, err
}

func (r *Repository) FindByID(id uuid.UUID) (*models.Report, error) {
	var report models.Report
	err := r.db.Preload("Reporter").Preload("ReportedUser").Preload("Handler").First(&report, "id = ?", id).Error
	if err != nil {
		return nil, err
	}
	return &report, nil
}

type targetKey struct {
	TargetType string
	TargetID   string
}

func (r *Repository) PendingCountsByTarget(targetIDs []string) (map[targetKey]int64, error) {
	counts := make(map[targetKey]int64)
	if len(targetIDs) == 0 {
		return counts, nil
	}
	var rows []struct {
		TargetType string
		TargetID   string
		Count      int64
	}
	err := r.db.Model(&models.Report{}).
		Select("target_type, target_id, COUNT(*) AS count").
		Where("status = ? AND target_id IN ?", constants.ReportStatusPending, targetIDs).
		Group("target_type, target_id").
		Scan(&rows).Error
	if err != nil {
		return nil, err
	}
	for _, row := range rows {
		counts[targetKey{TargetType: row.TargetType, TargetID: row.TargetID}] = row.Count
	}
	return counts, nil
}

func (r *Repository) CountPending() (int64, error) {
	var count int64
	err := r.db.Model(&models.Report{}).Where("status = ?", constants.ReportStatusPending).Count(&count).Error
	return count, err
}

func (r *Repository) HandleTarget(report *models.Report, status, note string, adminID uuid.UUID) (int64, error) {
	result := r.db.Model(&models.Report{}).
		Where("target_type = ? AND target_id = ? AND (status = ? OR id = ?)", report.TargetType, report.TargetID, constants.ReportStatusPending, report.ID).
		Updates(map[string]interface{}{
			"status":       status,
			"handled_by":   adminID,
			"handled_at":   time.Now(),
			"handler_note": note,
		})
	return result.RowsAffected, result.Error
}
