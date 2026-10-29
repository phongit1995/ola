package admincommon

import (
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

func FindUsersByIDs(db *gorm.DB, ids []uuid.UUID) (map[uuid.UUID]models.User, error) {
	result := make(map[uuid.UUID]models.User, len(ids))
	if len(ids) == 0 {
		return result, nil
	}
	var users []models.User
	if err := db.Unscoped().
		Select("id", "username", "full_name", "avatar").
		Where("id IN ?", ids).
		Find(&users).Error; err != nil {
		return nil, err
	}
	for i := range users {
		result[users[i].ID] = users[i]
	}
	return result, nil
}
