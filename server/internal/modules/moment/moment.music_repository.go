package moment

import (
	"context"
	"time"

	"ola-chat-server/internal/models"

	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

const clearMusicColumns = `music_url = '', music_object = '', music_title = '', music_start_ms = 0, music_duration_ms = 0, duration = 0`

const clearMusicByPageQuery = `
WITH target AS (
	SELECT id, music_object FROM moments
	WHERE author_id = @author AND created_at = @createdAt AND music_object <> ''
	FOR UPDATE
)
UPDATE moments m SET ` + clearMusicColumns + `
FROM target t
WHERE m.id = t.id
RETURNING t.music_object`

const clearMusicByHashQuery = `
WITH target AS (
	SELECT id, music_object FROM moments
	WHERE music_source_hash = @hash AND music_object <> ''
	FOR UPDATE
)
UPDATE moments m SET ` + clearMusicColumns + `
FROM target t
WHERE m.id = t.id
RETURNING t.music_object`

const insertMusicBlockQuery = `
INSERT INTO moment_music_blocks (hash, title) VALUES (@hash, @title)
ON CONFLICT (hash) DO NOTHING`

const musicHashLockKey = `hashtext('moment_music_block'), hashtext(@hash)`

const lockMusicHashSharedQuery = `SELECT pg_advisory_xact_lock_shared(` + musicHashLockKey + `)`

const lockMusicHashQuery = `SELECT pg_advisory_xact_lock(` + musicHashLockKey + `)`

const claimMusicDeletesQuery = `
UPDATE moment_music_delete_queue q SET attempts = q.attempts + 1, next_attempt_at = @retryAt
WHERE q.object_name IN (
	SELECT object_name FROM moment_music_delete_queue
	WHERE next_attempt_at <= @now
	ORDER BY next_attempt_at
	LIMIT @limit
	FOR UPDATE SKIP LOCKED
)
RETURNING q.object_name`

type momentMusicDelete struct {
	ObjectName string `gorm:"column:object_name;primaryKey"`
}

func (momentMusicDelete) TableName() string {
	return "moment_music_delete_queue"
}

func hashArgs(hash string) map[string]interface{} {
	return map[string]interface{}{"hash": hash}
}

func guardMusicBlock(tx *gorm.DB, hash string) error {
	if hash == "" {
		return nil
	}
	if err := tx.Exec(lockMusicHashSharedQuery, hashArgs(hash)).Error; err != nil {
		return err
	}
	var count int64
	if err := tx.Table("moment_music_blocks").Where("hash = ?", hash).Limit(1).Count(&count).Error; err != nil {
		return err
	}
	if count > 0 {
		return errMusicBlocked
	}
	return nil
}

func queueMusicDeletes(tx *gorm.DB, objects []string) error {
	if len(objects) == 0 {
		return nil
	}
	rows := make([]momentMusicDelete, 0, len(objects))
	for _, object := range objects {
		rows = append(rows, momentMusicDelete{ObjectName: object})
	}
	return tx.Clauses(clause.OnConflict{DoNothing: true}).Create(&rows).Error
}

func (r *Repository) MusicBlocked(hash string) (bool, error) {
	var count int64
	err := r.db.Table("moment_music_blocks").Where("hash = ?", hash).Limit(1).Count(&count).Error
	return count > 0, err
}

func (r *Repository) ClearMusic(ctx context.Context, found *models.Moment, block bool) ([]string, error) {
	var objects []string
	err := r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		args := map[string]interface{}{
			"author":    found.AuthorID,
			"createdAt": found.CreatedAt,
			"hash":      found.MusicSourceHash,
			"title":     found.MusicTitle,
		}
		query := clearMusicByPageQuery
		if block && found.MusicSourceHash != "" {
			if err := tx.Exec(lockMusicHashQuery, args).Error; err != nil {
				return err
			}
			if err := tx.Exec(insertMusicBlockQuery, args).Error; err != nil {
				return err
			}
			query = clearMusicByHashQuery
		}
		if err := tx.Raw(query, args).Scan(&objects).Error; err != nil {
			return err
		}
		return queueMusicDeletes(tx, objects)
	})
	return objects, err
}

func (r *Repository) ClaimMusicDeletes(ctx context.Context, now, retryAt time.Time, limit int) ([]string, error) {
	var objects []string
	err := r.db.WithContext(ctx).Raw(claimMusicDeletesQuery, map[string]interface{}{
		"now":     now,
		"retryAt": retryAt,
		"limit":   limit,
	}).Scan(&objects).Error
	return objects, err
}

func (r *Repository) ForgetMusicDeletes(ctx context.Context, objects []string) error {
	return r.db.WithContext(ctx).Where("object_name IN ?", objects).Delete(&momentMusicDelete{}).Error
}
