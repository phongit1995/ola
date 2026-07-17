package adminclan

import (
	"errors"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

var ErrClanNotFound = errors.New("clan not found")

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) List(query string, limit, offset int) ([]models.Clan, int64, error) {
	db := r.db.Model(&models.Clan{})
	if query != "" {
		db = db.Where("handle ILIKE ?", "%"+query+"%")
	}

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var clans []models.Clan
	if err := db.Preload("Owner").Order("created_at DESC").Limit(limit).Offset(offset).Find(&clans).Error; err != nil {
		return nil, 0, err
	}
	return clans, total, nil
}

func (r *Repository) GetByID(id uuid.UUID) (*models.Clan, error) {
	var clan models.Clan
	if err := r.db.Preload("Owner").First(&clan, "id = ?", id).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrClanNotFound
		}
		return nil, err
	}
	return &clan, nil
}

func (r *Repository) ListMembers(clanID uuid.UUID, limit, offset int) ([]models.ClanMember, int64, error) {
	db := r.db.Model(&models.ClanMember{}).Where("clan_id = ?", clanID)

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var members []models.ClanMember
	err := db.Preload("User").
		Order("CASE role WHEN 'owner' THEN 0 WHEN 'deputy' THEN 1 WHEN 'ambassador' THEN 2 ELSE 3 END").
		Order("created_at ASC").
		Limit(limit).Offset(offset).
		Find(&members).Error
	if err != nil {
		return nil, 0, err
	}
	return members, total, nil
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.Clan{}, "id = ?", id).Error
}
