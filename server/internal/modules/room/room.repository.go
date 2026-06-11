package room

import (
	"ola-chat-server/internal/models"
	"time"

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

type MemberRow struct {
	UserID   uuid.UUID
	Username string
	FullName string
	Avatar   string
	JoinedAt time.Time
}

func (r *Repository) Create(room *models.Room) error {
	return r.db.Create(room).Error
}

func (r *Repository) Save(room *models.Room) error {
	return r.db.Save(room).Error
}

func (r *Repository) GetByID(id uuid.UUID) (*models.Room, error) {
	var room models.Room
	if err := r.db.First(&room, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &room, nil
}

func (r *Repository) list(query string, limit, offset int, onlyEnabled bool) ([]*models.Room, int64, error) {
	db := r.db.Model(&models.Room{})
	if onlyEnabled {
		db = db.Where("enabled = ?", true)
	}
	if query != "" {
		db = db.Where("name ILIKE ?", "%"+query+"%")
	}

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rooms []*models.Room
	if err := db.Order("created_at DESC").Limit(limit).Offset(offset).Find(&rooms).Error; err != nil {
		return nil, 0, err
	}
	return rooms, total, nil
}

func (r *Repository) ListPublic(query string, limit, offset int) ([]*models.Room, int64, error) {
	return r.list(query, limit, offset, true)
}

func (r *Repository) ListAll(query string, limit, offset int) ([]*models.Room, int64, error) {
	return r.list(query, limit, offset, false)
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.Room{}, "id = ?", id).Error
}

func (r *Repository) IsMember(roomID, userID uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Model(&models.RoomMember{}).
		Where("room_id = ? AND user_id = ?", roomID, userID).
		Count(&count).Error
	return count > 0, err
}

func (r *Repository) AddMember(roomID, userID uuid.UUID) (bool, error) {
	res := r.db.Clauses(clause.OnConflict{DoNothing: true}).
		Create(&models.RoomMember{RoomID: roomID, UserID: userID, JoinedAt: time.Now()})
	if res.Error != nil {
		return false, res.Error
	}
	if res.RowsAffected > 0 {
		r.db.Model(&models.Room{}).Where("id = ?", roomID).
			UpdateColumn("member_count", gorm.Expr("member_count + 1"))
		return true, nil
	}
	return false, nil
}

func (r *Repository) RemoveMember(roomID, userID uuid.UUID) (bool, error) {
	res := r.db.Where("room_id = ? AND user_id = ?", roomID, userID).Delete(&models.RoomMember{})
	if res.Error != nil {
		return false, res.Error
	}
	if res.RowsAffected > 0 {
		r.db.Model(&models.Room{}).Where("id = ? AND member_count > 0", roomID).
			UpdateColumn("member_count", gorm.Expr("member_count - 1"))
		return true, nil
	}
	return false, nil
}

func (r *Repository) ListMembers(roomID uuid.UUID, limit, offset int) ([]MemberRow, int64, error) {
	base := r.db.Table("room_members rm").
		Joins("JOIN users u ON u.id = rm.user_id").
		Where("rm.room_id = ? AND u.deleted_at IS NULL", roomID)

	var total int64
	if err := base.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []MemberRow
	err := base.
		Select("rm.user_id AS user_id, u.username AS username, u.full_name AS full_name, u.avatar AS avatar, rm.joined_at AS joined_at").
		Order("rm.joined_at ASC").Limit(limit).Offset(offset).Scan(&rows).Error
	if err != nil {
		return nil, 0, err
	}
	return rows, total, nil
}

func (r *Repository) MemberIDs(roomID uuid.UUID) ([]uuid.UUID, error) {
	var ids []uuid.UUID
	err := r.db.Model(&models.RoomMember{}).
		Where("room_id = ?", roomID).
		Pluck("user_id", &ids).Error
	return ids, err
}
