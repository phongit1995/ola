package adminmoment

import (
	"strconv"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/moment"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

const overlayTextMatch = `EXISTS (SELECT 1 FROM jsonb_array_elements(moments.overlays) o WHERE o->>'text' ILIKE ?)`

const pendingReportExists = `EXISTS (SELECT 1 FROM reports p
	WHERE p.target_type = ? AND p.target_id = moments.id::text AND p.status = ? AND p.deleted_at IS NULL)`

const reportCountJoin = `LEFT JOIN (
	SELECT target_id, count(*) AS report_count FROM reports
	WHERE target_type = ? AND deleted_at IS NULL
	GROUP BY target_id
) moment_reports ON moment_reports.target_id = moments.id::text`

const reportCountsQuery = `
SELECT target_id, count(*) AS total, count(*) FILTER (WHERE status = @pending) AS pending
FROM reports
WHERE target_type = @target AND target_id IN @ids AND deleted_at IS NULL
GROUP BY target_id`

type pageGroup struct {
	AuthorID  uuid.UUID `gorm:"column:author_id"`
	CreatedAt time.Time `gorm:"column:created_at"`
	Pages     int       `gorm:"column:pages"`
}

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

func (r *Repository) List(f ListFilter, now time.Time) ([]*models.Moment, int64, error) {
	db := r.db.Unscoped().Model(&models.Moment{})
	if f.AuthorID != nil {
		db = db.Where("moments.author_id = ?", *f.AuthorID)
	}
	if f.Query != "" {
		db = db.Where(overlayTextMatch, "%"+f.Query+"%")
	}
	if f.Type != "" {
		db = db.Where("moments.type = ?", f.Type)
	}
	if f.Visibility != "" {
		db = db.Where("moments.visibility = ?", f.Visibility)
	}
	if f.Enabled != nil {
		db = db.Where("moments.enabled = ?", *f.Enabled)
	}
	if f.HasPendingReports != nil {
		cond := pendingReportExists
		if !*f.HasPendingReports {
			cond = "NOT " + cond
		}
		db = db.Where(cond, constants.ReportTargetMoment, constants.ReportStatusPending)
	}
	db = withState(db, f.State, now)

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var moments []*models.Moment
	if err := withOrder(db.Preload("Author"), f.SortBy, f.SortDir).
		Limit(f.Limit).Offset(f.Offset).Find(&moments).Error; err != nil {
		return nil, 0, err
	}
	return moments, total, nil
}

func withState(db *gorm.DB, state string, now time.Time) *gorm.DB {
	switch state {
	case moment.AdminMomentStateFailed:
		return db.Where("moments.status = ?", moment.MomentStatusFailed)
	case moment.AdminMomentStateDeleted:
		return db.Where("moments.deleted_at IS NOT NULL AND moments.status <> ?", moment.MomentStatusFailed)
	case moment.AdminMomentStateExpired:
		return db.Where("moments.deleted_at IS NULL AND moments.status <> ? AND moments.expires_at <= ?", moment.MomentStatusFailed, now)
	case moment.AdminMomentStateProcessing:
		return db.Where("moments.deleted_at IS NULL AND moments.status = ? AND moments.expires_at > ?", moment.MomentStatusProcessing, now)
	case moment.AdminMomentStateLive:
		return db.Where("moments.deleted_at IS NULL AND moments.status = ? AND moments.expires_at > ?", moment.MomentStatusReady, now)
	default:
		return db
	}
}

func withOrder(db *gorm.DB, sortBy, sortDir string) *gorm.DB {
	dir := "DESC"
	if sortDir == "asc" {
		dir = "ASC"
	}
	if sortBy == moment.AdminMomentSortReportCount {
		return db.Select("moments.*").
			Joins(reportCountJoin, constants.ReportTargetMoment).
			Order("COALESCE(moment_reports.report_count, 0) " + dir).
			Order("moments.created_at DESC").Order("moments.id DESC")
	}
	return db.Order("moments.created_at " + dir).Order("moments.id " + dir)
}

func (r *Repository) GetByID(id uuid.UUID) (*models.Moment, error) {
	var moment models.Moment
	if err := r.db.Unscoped().Preload("Author").First(&moment, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &moment, nil
}

func (r *Repository) Exists(id uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Unscoped().Model(&models.Moment{}).Where("id = ?", id).Limit(1).Count(&count).Error
	return count > 0, err
}

func (r *Repository) SetEnabled(id uuid.UUID, enabled bool, at time.Time) (bool, error) {
	result := r.db.Unscoped().Model(&models.Moment{}).Where("id = ?", id).
		Updates(moment.HiddenFields(!enabled, moment.MomentHiddenByAdmin, at))
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
		"target":  constants.ReportTargetMoment,
		"ids":     keys,
	}).Scan(&rows).Error; err != nil {
		return nil, err
	}
	for _, row := range rows {
		byID[row.TargetID] = row
	}
	return byID, nil
}

func (r *Repository) PageCounts(moments []*models.Moment) (map[string]int, error) {
	counts := make(map[string]int, len(moments))
	if len(moments) == 0 {
		return counts, nil
	}
	keys := make([][]interface{}, 0, len(moments))
	for _, m := range moments {
		keys = append(keys, []interface{}{m.AuthorID, m.CreatedAt})
	}
	var rows []pageGroup
	if err := r.db.Unscoped().Model(&models.Moment{}).
		Select("author_id, created_at, count(*) AS pages").
		Where("(author_id, created_at) IN ?", keys).
		Group("author_id, created_at").
		Scan(&rows).Error; err != nil {
		return nil, err
	}
	for _, row := range rows {
		counts[pageKey(row.AuthorID, row.CreatedAt)] = row.Pages
	}
	return counts, nil
}

func (r *Repository) Pages(found *models.Moment) ([]*models.Moment, error) {
	var pages []*models.Moment
	err := r.db.Unscoped().Preload("Author").
		Where("author_id = ? AND created_at = ?", found.AuthorID, found.CreatedAt).
		Order("position ASC").Order("id ASC").
		Find(&pages).Error
	return pages, err
}

func pageKey(authorID uuid.UUID, createdAt time.Time) string {
	return authorID.String() + "|" + strconv.FormatInt(createdAt.UnixMicro(), 10)
}
