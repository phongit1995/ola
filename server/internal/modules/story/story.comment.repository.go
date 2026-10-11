package story

import (
	"context"
	"errors"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type CommentStore interface {
	CreateComment(ctx context.Context, comment *models.StoryComment, unlock bool) (CommentWrite, error)
	FindComment(ctx context.Context, storyID, commentID uuid.UUID) (*models.StoryComment, error)
	DeleteComment(ctx context.Context, storyID, commentID uuid.UUID) (int, bool, error)
	ListComments(ctx context.Context, storyID uuid.UUID, after *commentCursor, limit int) ([]models.StoryComment, error)
	CommentsByIDs(ctx context.Context, ids []uuid.UUID) ([]models.StoryComment, error)
	LikedComments(ctx context.Context, userID uuid.UUID, ids []uuid.UUID) (map[uuid.UUID]bool, error)
	ToggleCommentLike(ctx context.Context, commentID, userID uuid.UUID) (bool, int, error)
	HasUnlock(ctx context.Context, userID, storyID uuid.UUID) (bool, error)
	AdminComments(ctx context.Context, storyID uuid.UUID, offset, limit int) ([]models.StoryComment, int64, error)
}

type CommentWrite struct {
	CommentCount int
	Unlocked     bool
}

type commentCursor struct {
	CreatedAt time.Time
	ID        uuid.UUID
}

const incrementCommentCountQuery = `UPDATE stories SET comment_count = comment_count + 1 WHERE id = ? RETURNING comment_count`

const decrementCommentCountQuery = `UPDATE stories SET comment_count = GREATEST(comment_count - 1, 0) WHERE id = ? RETURNING comment_count`

const insertUnlockQuery = `
INSERT INTO story_unlocks (user_id, story_id, source, comment_id)
VALUES (?, ?, ?, ?)
ON CONFLICT (user_id, story_id) DO NOTHING`

const hasUnlockQuery = `SELECT EXISTS (SELECT 1 FROM story_unlocks WHERE user_id = ? AND story_id = ?)`

const addCommentLikeQuery = `UPDATE story_comments SET like_count = GREATEST(like_count + ?, 0) WHERE id = ? RETURNING like_count`

func (r *Repository) CreateComment(ctx context.Context, comment *models.StoryComment, unlock bool) (CommentWrite, error) {
	var out CommentWrite
	err := r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(comment).Error; err != nil {
			return err
		}
		if err := tx.Raw(incrementCommentCountQuery, comment.StoryID).Scan(&out.CommentCount).Error; err != nil {
			return err
		}
		if unlock {
			out.Unlocked = true
			return tx.Exec(insertUnlockQuery, comment.AuthorID, comment.StoryID, StoryUnlockSourceComment, comment.ID).Error
		}
		return tx.Raw(hasUnlockQuery, comment.AuthorID, comment.StoryID).Scan(&out.Unlocked).Error
	})
	return out, err
}

func (r *Repository) FindComment(ctx context.Context, storyID, commentID uuid.UUID) (*models.StoryComment, error) {
	var item models.StoryComment
	err := r.db.WithContext(ctx).Where("id = ? AND story_id = ?", commentID, storyID).First(&item).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) DeleteComment(ctx context.Context, storyID, commentID uuid.UUID) (int, bool, error) {
	var count int
	var deleted bool
	err := r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		result := tx.Where("id = ? AND story_id = ?", commentID, storyID).Delete(&models.StoryComment{})
		if result.Error != nil || result.RowsAffected == 0 {
			return result.Error
		}
		deleted = true
		return tx.Raw(decrementCommentCountQuery, storyID).Scan(&count).Error
	})
	return count, deleted, err
}

func (r *Repository) ListComments(ctx context.Context, storyID uuid.UUID, after *commentCursor, limit int) ([]models.StoryComment, error) {
	query := r.db.WithContext(ctx).Where("story_id = ?", storyID)
	if after != nil {
		query = query.Where("(created_at, id) < (?, ?)", after.CreatedAt, after.ID)
	}
	var items []models.StoryComment
	if err := query.Order("created_at DESC, id DESC").Limit(limit).Find(&items).Error; err != nil {
		return nil, err
	}
	return items, nil
}

func (r *Repository) CommentsByIDs(ctx context.Context, ids []uuid.UUID) ([]models.StoryComment, error) {
	if len(ids) == 0 {
		return nil, nil
	}
	var items []models.StoryComment
	if err := r.db.WithContext(ctx).Where("id IN ?", ids).Find(&items).Error; err != nil {
		return nil, err
	}
	return items, nil
}

func (r *Repository) LikedComments(ctx context.Context, userID uuid.UUID, ids []uuid.UUID) (map[uuid.UUID]bool, error) {
	liked := make(map[uuid.UUID]bool, len(ids))
	if len(ids) == 0 {
		return liked, nil
	}
	var rows []uuid.UUID
	err := r.db.WithContext(ctx).Model(&models.StoryCommentLike{}).
		Where("user_id = ? AND comment_id IN ?", userID, ids).
		Pluck("comment_id", &rows).Error
	if err != nil {
		return nil, err
	}
	for _, id := range rows {
		liked[id] = true
	}
	return liked, nil
}

func (r *Repository) ToggleCommentLike(ctx context.Context, commentID, userID uuid.UUID) (bool, int, error) {
	var liked bool
	var count int
	err := r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		removed := tx.Where("comment_id = ? AND user_id = ?", commentID, userID).Delete(&models.StoryCommentLike{})
		if removed.Error != nil {
			return removed.Error
		}
		delta := int64(-1)
		if removed.RowsAffected == 0 {
			liked = true
			added := tx.Clauses(clause.OnConflict{DoNothing: true}).Create(&models.StoryCommentLike{CommentID: commentID, UserID: userID})
			if added.Error != nil {
				return added.Error
			}
			delta = added.RowsAffected
		}
		return tx.Raw(addCommentLikeQuery, delta, commentID).Scan(&count).Error
	})
	return liked, count, err
}

func (r *Repository) HasUnlock(ctx context.Context, userID, storyID uuid.UUID) (bool, error) {
	var unlocked bool
	err := r.db.WithContext(ctx).Raw(hasUnlockQuery, userID, storyID).Scan(&unlocked).Error
	return unlocked, err
}

func (r *Repository) AdminComments(ctx context.Context, storyID uuid.UUID, offset, limit int) ([]models.StoryComment, int64, error) {
	scope := func() *gorm.DB {
		return r.db.WithContext(ctx).Unscoped().Model(&models.StoryComment{}).Where("story_id = ?", storyID)
	}
	var total int64
	if err := scope().Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var items []models.StoryComment
	err := scope().Order("created_at DESC, id DESC").Offset(offset).Limit(limit).Find(&items).Error
	if err != nil {
		return nil, 0, err
	}
	return items, total, nil
}
