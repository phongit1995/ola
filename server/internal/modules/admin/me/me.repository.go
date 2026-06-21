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

func (r *Repository) List(f ListFilter) ([]*models.Me, int64, error) {
	db := r.db.Model(&models.Me{})
	if f.AuthorID != nil {
		db = db.Where("author_id = ?", *f.AuthorID)
	}
	if f.Query != "" {
		db = db.Where("content ILIKE ?", "%"+f.Query+"%")
	}
	if f.Enabled != nil {
		db = db.Where("enabled = ?", *f.Enabled)
	}
	if f.Visibility != "" {
		db = db.Where("visibility = ?", f.Visibility)
	}
	if f.HasImages != nil {
		if *f.HasImages {
			db = db.Where("COALESCE(jsonb_array_length(images), 0) > 0")
		} else {
			db = db.Where("COALESCE(jsonb_array_length(images), 0) = 0")
		}
	}
	if f.HasCheckin != nil {
		if *f.HasCheckin {
			db = db.Where("check_in IS NOT NULL")
		} else {
			db = db.Where("check_in IS NULL")
		}
	}

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var posts []*models.Me
	if err := db.Preload("Author").Order(orderClause(f.SortBy, f.SortDir)).Limit(f.Limit).Offset(f.Offset).Find(&posts).Error; err != nil {
		return nil, 0, err
	}
	return posts, total, nil
}

var sortColumns = map[string]string{
	"createdAt":    "created_at",
	"likeCount":    "like_count",
	"commentCount": "comment_count",
	"dislikeCount": "dislike_count",
}

func orderClause(sortBy, sortDir string) string {
	col, ok := sortColumns[sortBy]
	if !ok {
		col = "created_at"
	}
	dir := "DESC"
	if sortDir == "asc" {
		dir = "ASC"
	}
	return col + " " + dir + ", id DESC"
}

func (r *Repository) GetByID(id uuid.UUID) (*models.Me, error) {
	var post models.Me
	if err := r.db.Preload("Author").First(&post, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &post, nil
}

func (r *Repository) SetEnabled(id uuid.UUID, enabled bool) error {
	return r.db.Model(&models.Me{}).Where("id = ?", id).Update("enabled", enabled).Error
}

func (r *Repository) ListComments(postID uuid.UUID, limit, offset int) ([]*models.MeComment, int64, error) {
	db := r.db.Model(&models.MeComment{}).Where("post_id = ?", postID)

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var comments []*models.MeComment
	if err := db.Preload("Author").Order("created_at ASC").Limit(limit).Offset(offset).Find(&comments).Error; err != nil {
		return nil, 0, err
	}
	return comments, total, nil
}

func (r *Repository) GetCommentByID(id uuid.UUID) (*models.MeComment, error) {
	var comment models.MeComment
	if err := r.db.First(&comment, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &comment, nil
}

func (r *Repository) DeleteComment(postID, commentID uuid.UUID) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		res := tx.Delete(&models.MeComment{}, "id = ?", commentID)
		if res.Error != nil {
			return res.Error
		}
		if res.RowsAffected == 0 {
			return nil
		}
		return tx.Model(&models.Me{}).Where("id = ?", postID).
			Update("comment_count", gorm.Expr("comment_count - ?", 1)).Error
	})
}
