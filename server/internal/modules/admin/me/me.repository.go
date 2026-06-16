package adminme

import (
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

func (r *Repository) List(query string, authorID *uuid.UUID, limit, offset int) ([]*models.Post, int64, error) {
	db := r.db.Model(&models.Post{})
	if authorID != nil {
		db = db.Where("author_id = ?", *authorID)
	}
	if query != "" {
		db = db.Where("content ILIKE ?", "%"+query+"%")
	}

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var posts []*models.Post
	if err := db.Preload("Author").Order("created_at DESC").Limit(limit).Offset(offset).Find(&posts).Error; err != nil {
		return nil, 0, err
	}
	return posts, total, nil
}

func (r *Repository) GetByID(id uuid.UUID) (*models.Post, error) {
	var post models.Post
	if err := r.db.Preload("Author").First(&post, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &post, nil
}

func (r *Repository) SetEnabled(id uuid.UUID, enabled bool) error {
	return r.db.Model(&models.Post{}).Where("id = ?", id).Update("enabled", enabled).Error
}

func (r *Repository) ListComments(postID uuid.UUID, limit, offset int) ([]*models.PostComment, int64, error) {
	db := r.db.Model(&models.PostComment{}).Where("post_id = ?", postID)

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var comments []*models.PostComment
	if err := db.Preload("Author").Order("created_at ASC").Limit(limit).Offset(offset).Find(&comments).Error; err != nil {
		return nil, 0, err
	}
	return comments, total, nil
}

func (r *Repository) GetCommentByID(id uuid.UUID) (*models.PostComment, error) {
	var comment models.PostComment
	if err := r.db.First(&comment, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &comment, nil
}

func (r *Repository) DeleteComment(postID, commentID uuid.UUID) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		res := tx.Delete(&models.PostComment{}, "id = ?", commentID)
		if res.Error != nil {
			return res.Error
		}
		if res.RowsAffected == 0 {
			return nil
		}
		return tx.Model(&models.Post{}).Where("id = ?", postID).
			Update("comment_count", gorm.Expr("comment_count - ?", 1)).Error
	})
}
