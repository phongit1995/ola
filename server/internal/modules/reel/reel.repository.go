package reel

import (
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
), followees AS (
	SELECT f.followee_id AS id FROM follows f WHERE f.follower_id = @viewer
), blocked AS (
	SELECT CASE WHEN rel.requester_id = @viewer THEN rel.addressee_id ELSE rel.requester_id END AS id
	FROM relationships rel
	WHERE rel.deleted_at IS NULL AND rel.status = @blocked
		AND (rel.requester_id = @viewer OR rel.addressee_id = @viewer)
)`

const othersVisibleFilter = `
	r.deleted_at IS NULL AND r.enabled AND r.expires_at > @now AND r.status = @ready AND r.author_id <> @viewer
	AND (r.author_id IN (SELECT id FROM friends)
		OR (r.visibility = @public AND r.author_id IN (SELECT id FROM followees)))
	AND r.author_id NOT IN (SELECT id FROM blocked)`

const seenableReelsQuery = audienceCTE + `
SELECT r.* FROM reels r
WHERE r.id IN @ids AND` + othersVisibleFilter

const trayPageQuery = audienceCTE + `, unseen AS (
	SELECT r.id, r.author_id, r.created_at, r."position" FROM reels r
	WHERE r.id <> ALL(string_to_array(@seen, ',')::uuid[]) AND` + othersVisibleFilter + `
), page AS (
	SELECT author_id, max(created_at) AS latest FROM unseen
	GROUP BY author_id
	%s
	ORDER BY latest DESC, author_id DESC
	LIMIT @lim
)
SELECT u.id, u.author_id, p.latest FROM unseen u JOIN page p ON p.author_id = u.author_id
ORDER BY p.latest DESC, p.author_id DESC, u.created_at ASC, u."position" ASC`

const trayPageAfterCursor = `HAVING (max(created_at), author_id) < (@cursorAt, @cursorAuthor)`

const lockPurgeCandidatesQuery = `
SELECT r.id, r.status, r.media_object, r.thumb_object, r.source_object FROM reels r
WHERE r.status <> @purged
	AND (r.status = @purging OR r.expires_at <= @now OR r.deleted_at IS NOT NULL)
	AND (r.status = @purging OR NOT EXISTS (
		SELECT 1 FROM reports p
		WHERE p.target_type = @target AND p.target_id = r.id::text
			AND p.status = @pending AND p.deleted_at IS NULL
	))
ORDER BY r.expires_at ASC
LIMIT @lim
FOR UPDATE OF r SKIP LOCKED`

const pendingReportTargetsQuery = `
SELECT DISTINCT target_id FROM reports
WHERE target_type = @target AND target_id IN @ids AND status = @pending AND deleted_at IS NULL`

const sourceLeftoversQuery = `
SELECT id, source_object FROM reels
WHERE status = @ready AND source_object <> '' AND source_object <> media_object
ORDER BY created_at ASC
LIMIT @lim`

const claimProcessingQuery = `
UPDATE reels SET processing_started_at = @now, processing_attempts = processing_attempts + 1
WHERE id = (
	SELECT id FROM reels
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
UPDATE reels SET status = @failed, deleted_at = @now, processing_started_at = NULL
WHERE status = @processing AND deleted_at IS NULL
	AND processing_attempts >= @maxAttempts
	AND processing_started_at < @stale
RETURNING id`

type cleanupCandidate struct {
	ID           uuid.UUID `gorm:"column:id"`
	Status       string    `gorm:"column:status"`
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
	Latest   time.Time
	AuthorID uuid.UUID
}

type trayPageRow struct {
	ID       uuid.UUID `gorm:"column:id"`
	AuthorID uuid.UUID `gorm:"column:author_id"`
	Latest   time.Time `gorm:"column:latest"`
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
		"public":   constants.ReelVisibilityPublic,
		"ready":    constants.ReelStatusReady,
	}
}

func (r *Repository) CreateBatch(reels []*models.Reel) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		return tx.Create(&reels).Error
	})
}

func (r *Repository) ListMine(authorID uuid.UUID, now time.Time) ([]*models.Reel, error) {
	var reels []*models.Reel
	err := withAuthor(r.db).
		Where("author_id = ? AND enabled AND expires_at > ? AND status IN ?", authorID, now,
			[]string{constants.ReelStatusReady, constants.ReelStatusProcessing}).
		Order("created_at ASC").Order("position ASC").
		Find(&reels).Error
	return reels, err
}

func (r *Repository) TrayPage(viewerID uuid.UUID, now time.Time, seen []uuid.UUID, after *trayCursor, limit int) ([]trayPageRow, error) {
	args := audienceArgs(viewerID, now)
	args["seen"] = joinIDs(seen)
	args["lim"] = limit
	having := ""
	if after != nil {
		having = trayPageAfterCursor
		args["cursorAt"] = after.Latest
		args["cursorAuthor"] = after.AuthorID
	}
	var rows []trayPageRow
	err := r.db.Raw(fmt.Sprintf(trayPageQuery, having), args).Scan(&rows).Error
	return rows, err
}

func joinIDs(ids []uuid.UUID) string {
	parts := make([]string, 0, len(ids))
	for _, id := range ids {
		parts = append(parts, id.String())
	}
	return strings.Join(parts, ",")
}

func (r *Repository) FindWithAuthors(ids []uuid.UUID) (map[uuid.UUID]*models.Reel, error) {
	byID := make(map[uuid.UUID]*models.Reel, len(ids))
	if len(ids) == 0 {
		return byID, nil
	}
	var reels []*models.Reel
	if err := withAuthor(r.db).Where("id IN ?", ids).Find(&reels).Error; err != nil {
		return nil, err
	}
	for _, reel := range reels {
		byID[reel.ID] = reel
	}
	return byID, nil
}

func (r *Repository) FindSeenable(viewerID uuid.UUID, now time.Time, ids []uuid.UUID) ([]*models.Reel, error) {
	args := audienceArgs(viewerID, now)
	args["ids"] = ids
	var reels []*models.Reel
	err := r.db.Raw(seenableReelsQuery, args).Scan(&reels).Error
	return reels, err
}

func (r *Repository) ClaimProcessing(now time.Time) (*models.Reel, error) {
	var reels []models.Reel
	err := r.db.Raw(claimProcessingQuery, map[string]interface{}{
		"now":         now,
		"stale":       now.Add(-constants.ReelTranscodeStaleAfter),
		"processing":  constants.ReelStatusProcessing,
		"maxAttempts": constants.ReelTranscodeMaxAttempts,
	}).Scan(&reels).Error
	if err != nil || len(reels) == 0 {
		return nil, err
	}
	return &reels[0], nil
}

func (r *Repository) FailExhausted(now time.Time) ([]uuid.UUID, error) {
	var ids []uuid.UUID
	err := r.db.Raw(failExhaustedQuery, map[string]interface{}{
		"now":         now,
		"stale":       now.Add(-constants.ReelTranscodeStaleAfter),
		"failed":      constants.ReelStatusFailed,
		"processing":  constants.ReelStatusProcessing,
		"maxAttempts": constants.ReelTranscodeMaxAttempts,
	}).Scan(&ids).Error
	return ids, err
}

func (r *Repository) MarkReady(id uuid.UUID, fields map[string]interface{}) (bool, error) {
	fields["status"] = constants.ReelStatusReady
	fields["processing_started_at"] = nil
	fields["processing_retry_at"] = nil
	result := r.db.Model(&models.Reel{}).
		Where("id = ? AND status = ?", id, constants.ReelStatusProcessing).
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
	return r.db.Model(&models.Reel{}).
		Where("id = ? AND status = ?", id, constants.ReelStatusProcessing).
		Updates(fields).Error
}

func (r *Repository) Requeue(id uuid.UUID) error {
	return r.db.Model(&models.Reel{}).
		Where("id = ? AND status = ?", id, constants.ReelStatusProcessing).
		Updates(map[string]interface{}{
			"processing_started_at": nil,
			"processing_attempts":   gorm.Expr("GREATEST(processing_attempts - 1, 0)"),
		}).Error
}

func (r *Repository) MarkFailed(id uuid.UUID, now time.Time) error {
	return r.db.Model(&models.Reel{}).
		Where("id = ? AND status = ?", id, constants.ReelStatusProcessing).
		Updates(map[string]interface{}{
			"status":                constants.ReelStatusFailed,
			"deleted_at":            now,
			"processing_started_at": nil,
		}).Error
}

func (r *Repository) FindActive(id uuid.UUID, now time.Time) (*models.Reel, error) {
	var reel models.Reel
	if err := r.db.Where("id = ? AND expires_at > ?", id, now).First(&reel).Error; err != nil {
		return nil, err
	}
	return &reel, nil
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.Reel{}, "id = ?", id).Error
}

func (r *Repository) FindUsers(ids []uuid.UUID) ([]models.User, error) {
	var users []models.User
	if len(ids) == 0 {
		return users, nil
	}
	err := r.db.Select("id", "username", "full_name", "avatar").Where("id IN ?", ids).Find(&users).Error
	return users, err
}

func (r *Repository) ClaimPurge(now time.Time, limit int) ([]cleanupCandidate, error) {
	var claimed []cleanupCandidate
	err := r.db.Transaction(func(tx *gorm.DB) error {
		var rows []cleanupCandidate
		if err := tx.Raw(lockPurgeCandidatesQuery, map[string]interface{}{
			"now":     now,
			"purging": constants.ReelStatusPurging,
			"purged":  constants.ReelStatusPurged,
			"target":  constants.ReportTargetReel,
			"pending": constants.ReportStatusPending,
			"lim":     limit,
		}).Scan(&rows).Error; err != nil {
			return err
		}
		fresh := make([]string, 0, len(rows))
		for _, row := range rows {
			if row.Status != constants.ReelStatusPurging {
				fresh = append(fresh, row.ID.String())
			}
		}
		if len(fresh) == 0 {
			claimed = rows
			return nil
		}
		var reported []string
		if err := tx.Raw(pendingReportTargetsQuery, map[string]interface{}{
			"target":  constants.ReportTargetReel,
			"pending": constants.ReportStatusPending,
			"ids":     fresh,
		}).Scan(&reported).Error; err != nil {
			return err
		}
		marking := make([]uuid.UUID, 0, len(fresh))
		for _, row := range rows {
			switch {
			case row.Status == constants.ReelStatusPurging:
				claimed = append(claimed, row)
			case !slices.Contains(reported, row.ID.String()):
				marking = append(marking, row.ID)
				claimed = append(claimed, row)
			}
		}
		if len(marking) == 0 {
			return nil
		}
		return tx.Exec("UPDATE reels SET status = ? WHERE id IN ?", constants.ReelStatusPurging, marking).Error
	})
	return claimed, err
}

func (r *Repository) SourceLeftovers(limit int) ([]sourceLeftover, error) {
	var rows []sourceLeftover
	err := r.db.Raw(sourceLeftoversQuery, map[string]interface{}{
		"ready": constants.ReelStatusReady,
		"lim":   limit,
	}).Scan(&rows).Error
	return rows, err
}

func (r *Repository) ClearSource(id uuid.UUID, source string) error {
	return r.db.Exec("UPDATE reels SET source_object = '' WHERE id = ? AND source_object = ?", id, source).Error
}

func (r *Repository) MarkPurged(ids []uuid.UUID, now time.Time) error {
	if len(ids) == 0 {
		return nil
	}
	return r.db.Unscoped().Model(&models.Reel{}).
		Where("id IN ? AND status = ?", ids, constants.ReelStatusPurging).
		Updates(map[string]interface{}{"status": constants.ReelStatusPurged, "purged_at": now}).Error
}
