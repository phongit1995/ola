package friendcontent

import (
	"context"
	"time"

	"ola-chat-server/internal/constants"
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

const friendIDsQuery = `
SELECT CASE WHEN requester_id = @author THEN addressee_id ELSE requester_id END AS id
FROM relationships
WHERE deleted_at IS NULL AND status = @accepted
	AND (requester_id = @author OR addressee_id = @author)`

func (r *Repository) FriendIDs(ctx context.Context, authorID uuid.UUID) ([]uuid.UUID, error) {
	var ids []uuid.UUID
	err := r.db.WithContext(ctx).Raw(friendIDsQuery, map[string]interface{}{
		"author":   authorID,
		"accepted": models.RelationshipStatusAccepted,
	}).Scan(&ids).Error
	return ids, err
}

func (r *Repository) ContentLive(ctx context.Context, kind string, authorID, contentID uuid.UUID, now time.Time) (bool, error) {
	var count int64
	db := r.db.WithContext(ctx)
	switch kind {
	case constants.FriendContentPost:
		db = db.Model(&models.Me{}).
			Where("id = ? AND author_id = ? AND enabled AND clan_id IS NULL AND visibility IN ?", contentID, authorID, models.MeFeedVisibilities)
	case constants.FriendContentMoment:
		db = db.Model(&models.Moment{}).
			Where("id = ? AND author_id = ? AND enabled AND status = ? AND expires_at > ?", contentID, authorID, momentStatusReady, now)
	default:
		return false, nil
	}
	err := db.Count(&count).Error
	return count > 0, err
}

func (r *Repository) Author(ctx context.Context, authorID uuid.UUID) (*models.User, error) {
	var user models.User
	if err := r.db.WithContext(ctx).First(&user, "id = ?", authorID).Error; err != nil {
		return nil, err
	}
	return &user, nil
}
