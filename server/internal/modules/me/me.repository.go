package me

import (
	"encoding/json"
	"errors"

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

func (r *Repository) Create(post *models.Post) error {
	return r.db.Create(post).Error
}

func (r *Repository) Save(post *models.Post) error {
	return r.db.Save(post).Error
}

func (r *Repository) GetByID(id uuid.UUID) (*models.Post, error) {
	var post models.Post
	if err := r.db.Preload("Author").First(&post, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &post, nil
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.Post{}, "id = ?", id).Error
}

func (r *Repository) paginate(db *gorm.DB, limit, offset int) ([]*models.Post, int64, error) {
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

func (r *Repository) feedScope(viewerID uuid.UUID, friendIDs []uuid.UUID) *gorm.DB {
	db := r.db.Model(&models.Post{})
	if len(friendIDs) > 0 {
		return db.Where(
			"visibility = ? OR author_id = ? OR (visibility = ? AND author_id IN ?)",
			models.PostVisibilityPublic, viewerID, models.PostVisibilityFriend, friendIDs,
		)
	}
	return db.Where("visibility = ? OR author_id = ?", models.PostVisibilityPublic, viewerID)
}

func (r *Repository) Feed(viewerID uuid.UUID, friendIDs []uuid.UUID, limit, offset int) ([]*models.Post, int64, error) {
	return r.paginate(r.feedScope(viewerID, friendIDs), limit, offset)
}

func (r *Repository) FeedMedia(viewerID uuid.UUID, friendIDs []uuid.UUID, limit, offset int) ([]*models.Post, int64, error) {
	db := r.feedScope(viewerID, friendIDs).Where("jsonb_array_length(images) > 0")
	return r.paginate(db, limit, offset)
}

func (r *Repository) ListByAuthor(authorID uuid.UUID, visibilities []models.PostVisibility, limit, offset int) ([]*models.Post, int64, error) {
	db := r.db.Model(&models.Post{}).Where("author_id = ? AND visibility IN ?", authorID, visibilities)
	return r.paginate(db, limit, offset)
}

func (r *Repository) FeedMentions(viewerID uuid.UUID, limit, offset int) ([]*models.Post, int64, error) {
	target, err := json.Marshal([]string{viewerID.String()})
	if err != nil {
		return nil, 0, err
	}
	db := r.db.Model(&models.Post{}).Where("mentions @> ?", string(target))
	return r.paginate(db, limit, offset)
}

func (r *Repository) ListLikers(postID uuid.UUID, limit, offset int) ([]*models.User, int64, error) {
	base := r.db.Model(&models.User{}).
		Joins("JOIN me_reactions ON me_reactions.user_id = users.id").
		Where("me_reactions.post_id = ? AND me_reactions.type = ?", postID, models.PostReactionLike)

	var total int64
	if err := base.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var users []*models.User
	if err := base.Order("me_reactions.created_at DESC").Limit(limit).Offset(offset).Find(&users).Error; err != nil {
		return nil, 0, err
	}
	return users, total, nil
}

func (r *Repository) FindUserIDsByUsernames(names []string) (map[string]uuid.UUID, error) {
	result := make(map[string]uuid.UUID)
	if len(names) == 0 {
		return result, nil
	}
	var users []models.User
	if err := r.db.Select("id", "username").Where("username IN ?", names).Find(&users).Error; err != nil {
		return nil, err
	}
	for _, u := range users {
		result[u.Username] = u.ID
	}
	return result, nil
}

func (r *Repository) GetReaction(postID, userID uuid.UUID) (*models.PostReaction, error) {
	var reaction models.PostReaction
	if err := r.db.First(&reaction, "post_id = ? AND user_id = ?", postID, userID).Error; err != nil {
		return nil, err
	}
	return &reaction, nil
}

func (r *Repository) GetUserReactions(userID uuid.UUID, postIDs []uuid.UUID) (map[uuid.UUID]models.PostReactionType, error) {
	result := make(map[uuid.UUID]models.PostReactionType)
	if len(postIDs) == 0 {
		return result, nil
	}
	var reactions []models.PostReaction
	if err := r.db.Where("user_id = ? AND post_id IN ?", userID, postIDs).Find(&reactions).Error; err != nil {
		return nil, err
	}
	for _, reaction := range reactions {
		result[reaction.PostID] = reaction.Type
	}
	return result, nil
}

func (r *Repository) React(postID, userID uuid.UUID, newType models.PostReactionType) (*models.Post, *models.PostReactionType, error) {
	var post *models.Post
	var current *models.PostReactionType

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var existing models.PostReaction
		errFind := tx.First(&existing, "post_id = ? AND user_id = ?", postID, userID).Error

		likeDelta, dislikeDelta := 0, 0
		switch {
		case errors.Is(errFind, gorm.ErrRecordNotFound):
			reaction := models.PostReaction{PostID: postID, UserID: userID, Type: newType}
			if err := tx.Create(&reaction).Error; err != nil {
				return err
			}
			if newType == models.PostReactionLike {
				likeDelta = 1
			} else {
				dislikeDelta = 1
			}
			t := newType
			current = &t
		case errFind != nil:
			return errFind
		case existing.Type == newType:
			if err := tx.Delete(&existing).Error; err != nil {
				return err
			}
			if newType == models.PostReactionLike {
				likeDelta = -1
			} else {
				dislikeDelta = -1
			}
			current = nil
		default:
			existing.Type = newType
			if err := tx.Save(&existing).Error; err != nil {
				return err
			}
			if newType == models.PostReactionLike {
				likeDelta, dislikeDelta = 1, -1
			} else {
				likeDelta, dislikeDelta = -1, 1
			}
			t := newType
			current = &t
		}

		if err := r.applyCounts(tx, postID, likeDelta, dislikeDelta); err != nil {
			return err
		}

		var p models.Post
		if err := tx.Preload("Author").First(&p, "id = ?", postID).Error; err != nil {
			return err
		}
		post = &p
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return post, current, nil
}

func (r *Repository) RemoveReaction(postID, userID uuid.UUID) (*models.Post, error) {
	var post *models.Post

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var existing models.PostReaction
		errFind := tx.First(&existing, "post_id = ? AND user_id = ?", postID, userID).Error

		switch {
		case errors.Is(errFind, gorm.ErrRecordNotFound):
		case errFind != nil:
			return errFind
		default:
			if err := tx.Delete(&existing).Error; err != nil {
				return err
			}
			likeDelta, dislikeDelta := 0, -1
			if existing.Type == models.PostReactionLike {
				likeDelta, dislikeDelta = -1, 0
			}
			if err := r.applyCounts(tx, postID, likeDelta, dislikeDelta); err != nil {
				return err
			}
		}

		var p models.Post
		if err := tx.Preload("Author").First(&p, "id = ?", postID).Error; err != nil {
			return err
		}
		post = &p
		return nil
	})
	if err != nil {
		return nil, err
	}
	return post, nil
}

func (r *Repository) CreateComment(comment *models.PostComment) (*models.PostComment, error) {
	err := r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(comment).Error; err != nil {
			return err
		}
		return tx.Model(&models.Post{}).Where("id = ?", comment.PostID).
			Update("comment_count", gorm.Expr("comment_count + ?", 1)).Error
	})
	if err != nil {
		return nil, err
	}
	return r.GetCommentByID(comment.ID)
}

func (r *Repository) GetCommentByID(id uuid.UUID) (*models.PostComment, error) {
	var comment models.PostComment
	if err := r.db.Preload("Author").First(&comment, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &comment, nil
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

func (r *Repository) applyCounts(tx *gorm.DB, postID uuid.UUID, likeDelta, dislikeDelta int) error {
	updates := map[string]interface{}{}
	if likeDelta != 0 {
		updates["like_count"] = gorm.Expr("like_count + ?", likeDelta)
	}
	if dislikeDelta != 0 {
		updates["dislike_count"] = gorm.Expr("dislike_count + ?", dislikeDelta)
	}
	if len(updates) == 0 {
		return nil
	}
	return tx.Model(&models.Post{}).Where("id = ?", postID).Updates(updates).Error
}
