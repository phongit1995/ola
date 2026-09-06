package room

import (
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type BlockRepository struct {
	db *gorm.DB
}

func NewBlockRepository(db *gorm.DB) *BlockRepository {
	return &BlockRepository{db: db}
}

func (r *BlockRepository) ListBlockedUserIDs(userID uuid.UUID) ([]uuid.UUID, error) {
	ids := make([]uuid.UUID, 0)
	err := r.db.Model(&models.RoomUserBlock{}).
		Where("user_id = ?", userID).
		Order("created_at ASC").
		Pluck("blocked_user_id", &ids).Error
	return ids, err
}

func (r *BlockRepository) CountBlocked(userID uuid.UUID) (int64, error) {
	var count int64
	err := r.db.Model(&models.RoomUserBlock{}).Where("user_id = ?", userID).Count(&count).Error
	return count, err
}

func (r *BlockRepository) Exists(userID, blockedUserID uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Model(&models.RoomUserBlock{}).
		Where("user_id = ? AND blocked_user_id = ?", userID, blockedUserID).
		Count(&count).Error
	return count > 0, err
}

func (r *BlockRepository) Create(userID, blockedUserID uuid.UUID) error {
	return r.db.Clauses(clause.OnConflict{DoNothing: true}).
		Create(&models.RoomUserBlock{UserID: userID, BlockedUserID: blockedUserID}).Error
}

func (r *BlockRepository) Delete(userID, blockedUserID uuid.UUID) error {
	return r.db.Where("user_id = ? AND blocked_user_id = ?", userID, blockedUserID).
		Delete(&models.RoomUserBlock{}).Error
}
