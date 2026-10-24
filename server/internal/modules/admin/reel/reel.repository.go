package adminreel

import (
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

const overlayTextMatch = `EXISTS (SELECT 1 FROM jsonb_array_elements(reels.overlays) o WHERE o->>'text' ILIKE ?)`

const pendingReportExists = `EXISTS (SELECT 1 FROM reports p
	WHERE p.target_type = ? AND p.target_id = reels.id::text AND p.status = ? AND p.deleted_at IS NULL)`

const reportCountJoin = `LEFT JOIN (
	SELECT target_id, count(*) AS report_count FROM reports
	WHERE target_type = ? AND deleted_at IS NULL
	GROUP BY target_id
) reel_reports ON reel_reports.target_id = reels.id::text`

const reportCountsQuery = `
SELECT target_id, count(*) AS total, count(*) FILTER (WHERE status = @pending) AS pending
FROM reports
WHERE target_type = @target AND target_id IN @ids AND deleted_at IS NULL
GROUP BY target_id`

type reportCounts struct {
	TargetID string `gorm:"column:target_id"`
	Total    int64  `gorm:"column:total"`
	Pending  int64  `gorm:"column:pending"`
}

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) List(f ListFilter, now time.Time) ([]*models.Reel, int64, error) {
	db := r.db.Unscoped().Model(&models.Reel{})
	if f.AuthorID != nil {
		db = db.Where("reels.author_id = ?", *f.AuthorID)
	}
	if f.Query != "" {
		db = db.Where(overlayTextMatch, "%"+f.Query+"%")
	}
	if f.Type != "" {
		db = db.Where("reels.type = ?", f.Type)
	}
	if f.Visibility != "" {
		db = db.Where("reels.visibility = ?", f.Visibility)
	}
	if f.Enabled != nil {
		db = db.Where("reels.enabled = ?", *f.Enabled)
	}
	if f.HasPendingReports != nil {
		cond := pendingReportExists
		if !*f.HasPendingReports {
			cond = "NOT " + cond
		}
		db = db.Where(cond, constants.ReportTargetReel, constants.ReportStatusPending)
	}
	db = withState(db, f.State, now)

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var reels []*models.Reel
	if err := withOrder(db.Preload("Author"), f.SortBy, f.SortDir).
		Limit(f.Limit).Offset(f.Offset).Find(&reels).Error; err != nil {
		return nil, 0, err
	}
	return reels, total, nil
}

func withState(db *gorm.DB, state string, now time.Time) *gorm.DB {
	switch state {
	case constants.AdminReelStateFailed:
		return db.Where("reels.status = ?", constants.ReelStatusFailed)
	case constants.AdminReelStateDeleted:
		return db.Where("reels.deleted_at IS NOT NULL AND reels.status <> ?", constants.ReelStatusFailed)
	case constants.AdminReelStateExpired:
		return db.Where("reels.deleted_at IS NULL AND reels.status <> ? AND reels.expires_at <= ?", constants.ReelStatusFailed, now)
	case constants.AdminReelStateProcessing:
		return db.Where("reels.deleted_at IS NULL AND reels.status = ? AND reels.expires_at > ?", constants.ReelStatusProcessing, now)
	case constants.AdminReelStateLive:
		return db.Where("reels.deleted_at IS NULL AND reels.status = ? AND reels.expires_at > ?", constants.ReelStatusReady, now)
	default:
		return db
	}
}

func withOrder(db *gorm.DB, sortBy, sortDir string) *gorm.DB {
	dir := "DESC"
	if sortDir == "asc" {
		dir = "ASC"
	}
	if sortBy == constants.AdminReelSortReportCount {
		return db.Select("reels.*").
			Joins(reportCountJoin, constants.ReportTargetReel).
			Order("COALESCE(reel_reports.report_count, 0) " + dir).
			Order("reels.created_at DESC").Order("reels.id DESC")
	}
	return db.Order("reels.created_at " + dir).Order("reels.id " + dir)
}

func (r *Repository) GetByID(id uuid.UUID) (*models.Reel, error) {
	var reel models.Reel
	if err := r.db.Unscoped().Preload("Author").First(&reel, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &reel, nil
}

func (r *Repository) Exists(id uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Unscoped().Model(&models.Reel{}).Where("id = ?", id).Limit(1).Count(&count).Error
	return count > 0, err
}

func (r *Repository) SetEnabled(id uuid.UUID, enabled bool) (bool, error) {
	result := r.db.Unscoped().Model(&models.Reel{}).Where("id = ?", id).Update("enabled", enabled)
	return result.RowsAffected > 0, result.Error
}

func (r *Repository) ReportCounts(ids []uuid.UUID) (map[string]reportCounts, error) {
	byID := make(map[string]reportCounts, len(ids))
	if len(ids) == 0 {
		return byID, nil
	}
	keys := make([]string, 0, len(ids))
	for _, id := range ids {
		keys = append(keys, id.String())
	}
	var rows []reportCounts
	if err := r.db.Raw(reportCountsQuery, map[string]interface{}{
		"pending": constants.ReportStatusPending,
		"target":  constants.ReportTargetReel,
		"ids":     keys,
	}).Scan(&rows).Error; err != nil {
		return nil, err
	}
	for _, row := range rows {
		byID[row.TargetID] = row
	}
	return byID, nil
}
