package moment

import (
	"context"
	"fmt"
	"slices"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

const audienceCTE = `
WITH friends AS (
	SELECT CASE WHEN rel.requester_id = @viewer THEN rel.addressee_id ELSE rel.requester_id END AS id
	FROM relationships rel
	WHERE rel.deleted_at IS NULL AND rel.status = @accepted
		AND (rel.requester_id = @viewer OR rel.addressee_id = @viewer)
), blocked AS (
	SELECT CASE WHEN rel.requester_id = @viewer THEN rel.addressee_id ELSE rel.requester_id END AS id
	FROM relationships rel
	WHERE rel.deleted_at IS NULL AND rel.status = @blocked
		AND (rel.requester_id = @viewer OR rel.addressee_id = @viewer)
)`

const othersVisibleFilter = `
	r.deleted_at IS NULL AND r.enabled AND r.expires_at > @now AND r.status = @ready AND r.author_id <> @viewer
	AND (r.visibility = @public OR r.author_id IN (SELECT id FROM friends))
	AND r.author_id NOT IN (SELECT id FROM blocked)`

const seenableMomentsQuery = audienceCTE + `
SELECT r.* FROM moments r
WHERE r.id IN @ids AND` + othersVisibleFilter

const trayPageQuery = audienceCTE + `, visible AS (
	SELECT r.id, r.author_id, r.created_at, r."position",
		r.id = ANY(string_to_array(@seen, ',')::uuid[]) AS seen
	FROM moments r
	WHERE` + othersVisibleFilter + `
), authors AS (
	SELECT author_id, max(created_at) AS latest, bool_and(seen) AS all_seen FROM visible
	GROUP BY author_id
), page AS (
	SELECT author_id, latest, all_seen FROM authors
	%s
	ORDER BY all_seen ASC, latest DESC, author_id DESC
	LIMIT @lim
)
SELECT v.id, v.author_id, v.seen, p.latest, p.all_seen FROM visible v JOIN page p ON p.author_id = v.author_id
ORDER BY p.all_seen ASC, p.latest DESC, p.author_id DESC, v.created_at ASC, v."position" ASC`

const trayPageAfterCursor = `WHERE (all_seen AND NOT @cursorSeen)
	OR (all_seen = @cursorSeen AND (latest, author_id) < (@cursorAt, @cursorAuthor))`

const claimMediaPurgeQuery = `
WITH target AS (
	SELECT id, status FROM moments
	WHERE id = @id AND type <> @text AND status IN @purgeable
	FOR UPDATE
)
UPDATE moments m SET status = @purging
FROM target t
WHERE m.id = t.id
RETURNING m.id, t.status, m.media_object, m.thumb_object, m.source_object`

const claimAgedPurgeQuery = `
WITH target AS (
	SELECT r.id, r.status FROM moments r
	WHERE r.type <> @text
		AND r.status IN @purgeable
		AND r.created_at <= @cutoff
		AND (r.created_at, r.id) > (@afterAt, @afterID)
		AND NOT EXISTS (
			SELECT 1 FROM reports p
			WHERE p.target_type = @target AND p.target_id = r.id::text
				AND p.status = @pending AND p.deleted_at IS NULL
		)
	ORDER BY r.created_at, r.id
	LIMIT @lim
	FOR UPDATE OF r SKIP LOCKED
)
UPDATE moments m SET status = @purging
FROM target t
WHERE m.id = t.id
RETURNING m.id, t.status, m.created_at, m.media_object, m.thumb_object, m.source_object`

const sourceLeftoversQuery = `
SELECT id, source_object FROM moments
WHERE status = @ready AND source_object <> '' AND source_object <> media_object
ORDER BY created_at ASC
LIMIT @lim`

const claimProcessingQuery = `
UPDATE moments SET processing_started_at = @now, processing_attempts = processing_attempts + 1
WHERE id = (
	SELECT id FROM moments
	WHERE status = @processing AND deleted_at IS NULL AND expires_at > @now
		AND processing_attempts < @maxAttempts
		AND (processing_started_at IS NULL OR processing_started_at < @stale)
		AND (processing_retry_at IS NULL OR processing_retry_at <= @now)
	ORDER BY created_at ASC
	LIMIT 1
	FOR UPDATE SKIP LOCKED
)
RETURNING *`

const failExhaustedQuery = `
UPDATE moments SET status = @failed, deleted_at = @now, processing_started_at = NULL
WHERE status = @processing AND deleted_at IS NULL
	AND processing_attempts >= @maxAttempts
	AND processing_started_at < @stale
RETURNING id`

type cleanupCandidate struct {
	ID           uuid.UUID `gorm:"column:id"`
	Status       string    `gorm:"column:status"`
	CreatedAt    time.Time `gorm:"column:created_at"`
	MediaObject  string    `gorm:"column:media_object"`
	ThumbObject  string    `gorm:"column:thumb_object"`
	SourceObject string    `gorm:"column:source_object"`
}

func (c cleanupCandidate) objects() []string {
	names := make([]string, 0, 3)
	for _, name := range []string{c.MediaObject, c.ThumbObject, c.SourceObject} {
		if name != "" && !slices.Contains(names, name) {
			names = append(names, name)
		}
	}
	return names
}

type sourceLeftover struct {
	ID           uuid.UUID `gorm:"column:id"`
	SourceObject string    `gorm:"column:source_object"`
}

type trayCursor struct {
	AllSeen  bool
	Latest   time.Time
	AuthorID uuid.UUID
}

type trayPageRow struct {
	ID       uuid.UUID `gorm:"column:id"`
	AuthorID uuid.UUID `gorm:"column:author_id"`
	Seen     bool      `gorm:"column:seen"`
	Latest   time.Time `gorm:"column:latest"`
	AllSeen  bool      `gorm:"column:all_seen"`
}

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func withAuthor(db *gorm.DB) *gorm.DB {
	return db.Preload("Author", func(db *gorm.DB) *gorm.DB {
		return db.Select("id", "username", "full_name", "avatar")
	})
}

func audienceArgs(viewerID uuid.UUID, now time.Time) map[string]interface{} {
	return map[string]interface{}{
		"viewer":   viewerID,
		"now":      now,
		"accepted": models.RelationshipStatusAccepted,
		"blocked":  models.RelationshipStatusBlocked,
		"public":   MomentVisibilityPublic,
		"ready":    MomentStatusReady,
	}
}

func (r *Repository) CreateBatch(moments []*models.Moment) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		return tx.Create(&moments).Error
	})
}

func (r *Repository) ListMine(authorID uuid.UUID, now time.Time) ([]*models.Moment, error) {
	var moments []*models.Moment
	err := withAuthor(r.db).
		Where("author_id = ? AND expires_at > ? AND status IN ?", authorID, now,
			[]string{MomentStatusReady, MomentStatusProcessing}).
		Order("created_at ASC").Order("position ASC").
		Find(&moments).Error
	return moments, err
}

func (r *Repository) ListHistory(authorID uuid.UUID, limit, offset int) ([]*models.Moment, error) {
	var moments []*models.Moment
	err := withAuthor(r.db).
		Where("author_id = ? AND status <> ?", authorID, MomentStatusFailed).
		Order("created_at DESC").Order("position ASC").Order("id ASC").
		Limit(limit).Offset(offset).
		Find(&moments).Error
	return moments, err
}

func (r *Repository) TrayPage(viewerID uuid.UUID, now time.Time, seen []uuid.UUID, after *trayCursor, limit int) ([]trayPageRow, error) {
	args := audienceArgs(viewerID, now)
	args["seen"] = joinIDs(seen)
	args["lim"] = limit
	afterCursor := ""
	if after != nil {
		afterCursor = trayPageAfterCursor
		args["cursorSeen"] = after.AllSeen
		args["cursorAt"] = after.Latest
		args["cursorAuthor"] = after.AuthorID
	}
	var rows []trayPageRow
	err := r.db.Raw(fmt.Sprintf(trayPageQuery, afterCursor), args).Scan(&rows).Error
	return rows, err
}

func joinIDs(ids []uuid.UUID) string {
	parts := make([]string, 0, len(ids))
	for _, id := range ids {
		parts = append(parts, id.String())
	}
	return strings.Join(parts, ",")
}

func (r *Repository) FindWithAuthors(ids []uuid.UUID) (map[uuid.UUID]*models.Moment, error) {
	byID := make(map[uuid.UUID]*models.Moment, len(ids))
	if len(ids) == 0 {
		return byID, nil
	}
	var moments []*models.Moment
	if err := withAuthor(r.db).Where("id IN ?", ids).Find(&moments).Error; err != nil {
		return nil, err
	}
	for _, moment := range moments {
		byID[moment.ID] = moment
	}
	return byID, nil
}

func (r *Repository) FindSeenable(viewerID uuid.UUID, now time.Time, ids []uuid.UUID) ([]*models.Moment, error) {
	args := audienceArgs(viewerID, now)
	args["ids"] = ids
	var moments []*models.Moment
	err := r.db.Raw(seenableMomentsQuery, args).Scan(&moments).Error
	return moments, err
}

func (r *Repository) ClaimProcessing(now time.Time) (*models.Moment, error) {
	var moments []models.Moment
	err := r.db.Raw(claimProcessingQuery, map[string]interface{}{
		"now":         now,
		"stale":       now.Add(-MomentTranscodeStaleAfter),
		"processing":  MomentStatusProcessing,
		"maxAttempts": MomentTranscodeMaxAttempts,
	}).Scan(&moments).Error
	if err != nil || len(moments) == 0 {
		return nil, err
	}
	return &moments[0], nil
}

func (r *Repository) FailExhausted(now time.Time) ([]uuid.UUID, error) {
	var ids []uuid.UUID
	err := r.db.Raw(failExhaustedQuery, map[string]interface{}{
		"now":         now,
		"stale":       now.Add(-MomentTranscodeStaleAfter),
		"failed":      MomentStatusFailed,
		"processing":  MomentStatusProcessing,
		"maxAttempts": MomentTranscodeMaxAttempts,
	}).Scan(&ids).Error
	return ids, err
}

func (r *Repository) MarkReady(id uuid.UUID, fields map[string]interface{}) (bool, error) {
	fields["status"] = MomentStatusReady
	fields["processing_started_at"] = nil
	fields["processing_retry_at"] = nil
	result := r.db.Model(&models.Moment{}).
		Where("id = ? AND status = ?", id, MomentStatusProcessing).
		Updates(fields)
	return result.RowsAffected > 0, result.Error
}

func (r *Repository) RetryLater(id uuid.UUID, retryAt time.Time, refundAttempt bool) error {
	fields := map[string]interface{}{
		"processing_started_at": nil,
		"processing_retry_at":   retryAt,
		"processing_failures":   gorm.Expr("processing_failures + 1"),
	}
	if refundAttempt {
		fields["processing_attempts"] = gorm.Expr("GREATEST(processing_attempts - 1, 0)")
	}
	return r.db.Model(&models.Moment{}).
		Where("id = ? AND status = ?", id, MomentStatusProcessing).
		Updates(fields).Error
}

func (r *Repository) Requeue(id uuid.UUID) error {
	return r.db.Model(&models.Moment{}).
		Where("id = ? AND status = ?", id, MomentStatusProcessing).
		Updates(map[string]interface{}{
			"processing_started_at": nil,
			"processing_attempts":   gorm.Expr("GREATEST(processing_attempts - 1, 0)"),
		}).Error
}

func (r *Repository) MarkFailed(id uuid.UUID, now time.Time) error {
	return r.db.Model(&models.Moment{}).
		Where("id = ? AND status = ?", id, MomentStatusProcessing).
		Updates(map[string]interface{}{
			"status":                MomentStatusFailed,
			"deleted_at":            now,
			"processing_started_at": nil,
		}).Error
}

func (r *Repository) FindByID(id uuid.UUID) (*models.Moment, error) {
	var moment models.Moment
	if err := r.db.Where("id = ?", id).First(&moment).Error; err != nil {
		return nil, err
	}
	return &moment, nil
}

func (r *Repository) SetHiddenByOwner(id, authorID uuid.UUID, hidden bool, at time.Time) (bool, error) {
	result := r.db.Model(&models.Moment{}).
		Where("id = ? AND author_id = ? AND (enabled OR hidden_by IS DISTINCT FROM ?)", id, authorID, MomentHiddenByAdmin).
		Updates(HiddenFields(hidden, MomentHiddenByOwner, at))
	return result.RowsAffected > 0, result.Error
}

func HiddenFields(hidden bool, by string, at time.Time) map[string]interface{} {
	if !hidden {
		return map[string]interface{}{"enabled": true, "hidden_by": nil, "hidden_at": nil}
	}
	return map[string]interface{}{"enabled": false, "hidden_by": by, "hidden_at": at}
}

func (r *Repository) RaiseViewerCounts(counts map[uuid.UUID]int64) error {
	for id, count := range counts {
		err := r.db.Unscoped().Model(&models.Moment{}).
			Where("id = ? AND viewer_count < ?", id, count).
			UpdateColumn("viewer_count", count).Error
		if err != nil {
			return err
		}
	}
	return nil
}

func (r *Repository) ViewerSyncCandidates(since time.Time, limit int) ([]*models.Moment, error) {
	var moments []*models.Moment
	err := r.db.Select("id", "viewer_count", "reaction_counts").
		Where("expires_at > ? AND status <> ?", since, MomentStatusFailed).
		Order("expires_at ASC").Limit(limit).
		Find(&moments).Error
	return moments, err
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.Moment{}, "id = ?", id).Error
}

func (r *Repository) FindUsers(ids []uuid.UUID) ([]models.User, error) {
	var users []models.User
	if len(ids) == 0 {
		return users, nil
	}
	err := r.db.Select("id", "username", "full_name", "avatar").Where("id IN ?", ids).Find(&users).Error
	return users, err
}

func (r *Repository) ClaimMediaPurge(ctx context.Context, id uuid.UUID) (*cleanupCandidate, error) {
	var rows []cleanupCandidate
	err := r.db.WithContext(ctx).Raw(claimMediaPurgeQuery, map[string]interface{}{
		"id":        id,
		"text":      MomentTypeText,
		"purging":   MomentStatusPurging,
		"purgeable": MomentPurgeableStatuses,
	}).Scan(&rows).Error
	if err != nil || len(rows) == 0 {
		return nil, err
	}
	return &rows[0], nil
}

type purgeCursor struct {
	CreatedAt time.Time
	ID        uuid.UUID
}

func (c purgeCursor) after(row cleanupCandidate) bool {
	if row.CreatedAt.Equal(c.CreatedAt) {
		return row.ID.String() > c.ID.String()
	}
	return row.CreatedAt.After(c.CreatedAt)
}

func (r *Repository) ClaimAgedPurge(ctx context.Context, cutoff time.Time, after purgeCursor, limit int) ([]cleanupCandidate, error) {
	var rows []cleanupCandidate
	err := r.db.WithContext(ctx).Raw(claimAgedPurgeQuery, map[string]interface{}{
		"text":      MomentTypeText,
		"purgeable": MomentPurgeableStatuses,
		"cutoff":    cutoff,
		"afterAt":   after.CreatedAt,
		"afterID":   after.ID,
		"target":    constants.ReportTargetMoment,
		"pending":   constants.ReportStatusPending,
		"lim":       limit,
		"purging":   MomentStatusPurging,
	}).Scan(&rows).Error
	return rows, err
}

func (r *Repository) RestoreStatus(ctx context.Context, id uuid.UUID, previous string) error {
	return r.db.WithContext(ctx).Exec("UPDATE moments SET status = ? WHERE id = ? AND status = ?",
		previous, id, MomentStatusPurging).Error
}

func (r *Repository) SourceLeftovers(limit int) ([]sourceLeftover, error) {
	var rows []sourceLeftover
	err := r.db.Raw(sourceLeftoversQuery, map[string]interface{}{
		"ready": MomentStatusReady,
		"lim":   limit,
	}).Scan(&rows).Error
	return rows, err
}

func (r *Repository) ClearSource(id uuid.UUID, source string) error {
	return r.db.Exec("UPDATE moments SET source_object = '' WHERE id = ? AND source_object = ?", id, source).Error
}

func (r *Repository) MarkPurged(ctx context.Context, ids []uuid.UUID, now time.Time) error {
	if len(ids) == 0 {
		return nil
	}
	return r.db.WithContext(ctx).Unscoped().Model(&models.Moment{}).
		Where("id IN ? AND status = ?", ids, MomentStatusPurging).
		Updates(map[string]interface{}{"status": MomentStatusPurged, "purged_at": now}).Error
}

func (r *Repository) RaiseReactionCounts(counts map[uuid.UUID]models.MomentReactionCounts) error {
	for id, reactionCounts := range counts {
		err := r.db.Unscoped().Model(&models.Moment{}).
			Where("id = ?", id).
			UpdateColumn("reaction_counts", reactionCounts).Error
		if err != nil {
			return err
		}
	}
	return nil
}
