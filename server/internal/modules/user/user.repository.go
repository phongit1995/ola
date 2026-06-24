package user

import (
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) FindByID(id uuid.UUID) (*models.User, error) {
	var user models.User
	err := r.db.First(&user, "id = ?", id).Error
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *Repository) FindByUsername(username string) (*models.User, error) {
	var user models.User
	err := r.db.First(&user, "username = ?", username).Error
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *Repository) Update(user *models.User) error {
	return r.db.Save(user).Error
}

func (r *Repository) IncrementKisses(id uuid.UUID) (int, error) {
	result := r.db.Model(&models.User{}).
		Where("id = ?", id).
		UpdateColumn("kisses", gorm.Expr("kisses + 1"))
	if result.Error != nil {
		return 0, result.Error
	}
	if result.RowsAffected == 0 {
		return 0, gorm.ErrRecordNotFound
	}

	var user models.User
	if err := r.db.Select("kisses").First(&user, "id = ?", id).Error; err != nil {
		return 0, err
	}
	return user.Kisses, nil
}

func (r *Repository) FollowTx(followerID, followeeID uuid.UUID) (bool, error) {
	inserted := false
	err := r.db.Transaction(func(tx *gorm.DB) error {
		follow := models.Follow{FollowerID: followerID, FolloweeID: followeeID}
		res := tx.Clauses(clause.OnConflict{DoNothing: true}).Create(&follow)
		if res.Error != nil {
			return res.Error
		}
		if res.RowsAffected == 0 {
			return nil
		}
		inserted = true
		if err := tx.Model(&models.User{}).Where("id = ?", followeeID).
			UpdateColumn("follower_count", gorm.Expr("follower_count + 1")).Error; err != nil {
			return err
		}
		return tx.Model(&models.User{}).Where("id = ?", followerID).
			UpdateColumn("following_count", gorm.Expr("following_count + 1")).Error
	})
	return inserted, err
}

func (r *Repository) UnfollowTx(followerID, followeeID uuid.UUID) (bool, error) {
	deleted := false
	err := r.db.Transaction(func(tx *gorm.DB) error {
		res := tx.Where("follower_id = ? AND followee_id = ?", followerID, followeeID).
			Delete(&models.Follow{})
		if res.Error != nil {
			return res.Error
		}
		if res.RowsAffected == 0 {
			return nil
		}
		deleted = true
		if err := tx.Model(&models.User{}).Where("id = ? AND follower_count > 0", followeeID).
			UpdateColumn("follower_count", gorm.Expr("follower_count - 1")).Error; err != nil {
			return err
		}
		return tx.Model(&models.User{}).Where("id = ? AND following_count > 0", followerID).
			UpdateColumn("following_count", gorm.Expr("following_count - 1")).Error
	})
	return deleted, err
}

func (r *Repository) IsFollowing(followerID, followeeID uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Model(&models.Follow{}).
		Where("follower_id = ? AND followee_id = ?", followerID, followeeID).
		Count(&count).Error
	return count > 0, err
}

func (r *Repository) ListFollowers(userID uuid.UUID, limit, offset int) ([]*models.User, int64, error) {
	var total int64
	if err := r.db.Model(&models.Follow{}).Where("followee_id = ?", userID).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var users []*models.User
	err := r.db.
		Joins("JOIN follows ON follows.follower_id = users.id").
		Where("follows.followee_id = ?", userID).
		Order("follows.created_at DESC").
		Limit(limit).Offset(offset).
		Find(&users).Error
	return users, total, err
}

func (r *Repository) ListFollowing(userID uuid.UUID, limit, offset int) ([]*models.User, int64, error) {
	var total int64
	if err := r.db.Model(&models.Follow{}).Where("follower_id = ?", userID).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var users []*models.User
	err := r.db.
		Joins("JOIN follows ON follows.followee_id = users.id").
		Where("follows.follower_id = ?", userID).
		Order("follows.created_at DESC").
		Limit(limit).Offset(offset).
		Find(&users).Error
	return users, total, err
}

func (r *Repository) Search(query string, limit int, excludeUserID *uuid.UUID) ([]*models.User, error) {
	var users []*models.User

	db := r.db.Where("username ILIKE ? OR full_name ILIKE ? OR email ILIKE ?",
		"%"+query+"%", "%"+query+"%", "%"+query+"%")

	if excludeUserID != nil {
		db = db.Where("id != ?", *excludeUserID)
	}

	err := db.Limit(limit).Order("username ASC").Find(&users).Error
	if err != nil {
		return nil, err
	}

	return users, nil
}

func (r *Repository) RelationshipsBetween(meID uuid.UUID, otherIDs []uuid.UUID) ([]models.Relationship, error) {
	if len(otherIDs) == 0 {
		return nil, nil
	}
	var rels []models.Relationship
	err := r.db.
		Where("(requester_id = ? AND addressee_id IN ?) OR (addressee_id = ? AND requester_id IN ?)",
			meID, otherIDs, meID, otherIDs).
		Find(&rels).Error
	if err != nil {
		return nil, err
	}
	return rels, nil
}
