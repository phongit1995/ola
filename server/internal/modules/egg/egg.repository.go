package egg

import (
	"time"

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

func (r *Repository) ListPacks(enabledOnly bool) ([]models.EggPack, error) {
	var packs []models.EggPack
	q := r.db.Order("sort_order ASC").Order("created_at ASC")
	if enabledOnly {
		q = q.Where("is_enabled = ?", true)
	}
	if err := q.Find(&packs).Error; err != nil {
		return nil, err
	}
	return packs, nil
}

func (r *Repository) FindPack(id uuid.UUID) (*models.EggPack, error) {
	var pack models.EggPack
	if err := r.db.First(&pack, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &pack, nil
}

func (r *Repository) CreatePack(pack *models.EggPack) error {
	return r.db.Create(pack).Error
}

func createChildren(tx *gorm.DB, packID uuid.UUID, cats []models.EggCategory, rewardsByCat map[int][]models.EggReward) error {
	for i := range cats {
		cats[i].ID = uuid.New()
		cats[i].PackID = packID
		if err := tx.Create(&cats[i]).Error; err != nil {
			return err
		}
		for j := range rewardsByCat[i] {
			rewardsByCat[i][j].ID = uuid.New()
			rewardsByCat[i][j].CategoryID = cats[i].ID
			if err := tx.Create(&rewardsByCat[i][j]).Error; err != nil {
				return err
			}
		}
	}
	return nil
}

func (r *Repository) CreatePackWithConfig(pack *models.EggPack, cats []models.EggCategory, rewardsByCat map[int][]models.EggReward) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(pack).Error; err != nil {
			return err
		}
		return createChildren(tx, pack.ID, cats, rewardsByCat)
	})
}

func (r *Repository) UpdatePack(id uuid.UUID, fields map[string]interface{}) error {
	return r.db.Model(&models.EggPack{}).Where("id = ?", id).Updates(fields).Error
}

func (r *Repository) SoftDeletePack(id uuid.UUID) error {
	return r.db.Delete(&models.EggPack{}, "id = ?", id).Error
}

func (r *Repository) CategoriesByPacks(packIDs []uuid.UUID) ([]models.EggCategory, error) {
	var cats []models.EggCategory
	if len(packIDs) == 0 {
		return cats, nil
	}
	if err := r.db.Where("pack_id IN ?", packIDs).Order("sort_order ASC").Find(&cats).Error; err != nil {
		return nil, err
	}
	return cats, nil
}

func (r *Repository) RewardsByCategories(categoryIDs []uuid.UUID) ([]models.EggReward, error) {
	var rewards []models.EggReward
	if len(categoryIDs) == 0 {
		return rewards, nil
	}
	if err := r.db.Where("category_id IN ?", categoryIDs).Order("sort_order ASC").Find(&rewards).Error; err != nil {
		return nil, err
	}
	return rewards, nil
}

func (r *Repository) ReplaceConfig(packID uuid.UUID, cats []models.EggCategory, rewardsByCat map[int][]models.EggReward) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		var existing []models.EggCategory
		if err := tx.Where("pack_id = ?", packID).Find(&existing).Error; err != nil {
			return err
		}
		if len(existing) > 0 {
			ids := make([]uuid.UUID, len(existing))
			for i, c := range existing {
				ids[i] = c.ID
			}
			if err := tx.Where("category_id IN ?", ids).Delete(&models.EggReward{}).Error; err != nil {
				return err
			}
			if err := tx.Where("pack_id = ?", packID).Delete(&models.EggCategory{}).Error; err != nil {
				return err
			}
		}
		if err := createChildren(tx, packID, cats, rewardsByCat); err != nil {
			return err
		}
		return tx.Model(&models.EggPack{}).Where("id = ?", packID).Update("updated_at", time.Now()).Error
	})
}

func (r *Repository) ApplyDraw(userID uuid.UUID, pack *models.EggPack, outcome DrawOutcome, idempotencyKey string) (*models.EggDraw, *models.User, error) {
	var draw models.EggDraw
	var updatedUser models.User

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var u models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", userID).Error; err != nil {
			return err
		}

		if idempotencyKey != "" {
			var prev models.EggDraw
			err := tx.Where("user_id = ? AND metadata->>'idempotencyKey' = ?", userID, idempotencyKey).First(&prev).Error
			if err == nil {
				draw = prev
				updatedUser = u
				return nil
			}
			if err != gorm.ErrRecordNotFound {
				return err
			}
		}

		if u.Ken < pack.KenCost {
			return ErrInsufficientKen
		}

		before := u.Ken
		afterCost := before - pack.KenCost
		finalKen := afterCost

		var costTxID *uuid.UUID
		if pack.KenCost > 0 {
			costTx := models.KenTransaction{
				UserID:        userID,
				Direction:     models.KenDirectionDebit,
				Type:          models.KenTxTypeEggOpen,
				Amount:        pack.KenCost,
				BalanceBefore: before,
				BalanceAfter:  afterCost,
				Description:   pack.Name,
				RefType:       "egg_draw",
				ActorType:     models.KenActorUser,
				ActorID:       &userID,
			}
			if err := tx.Create(&costTx).Error; err != nil {
				return err
			}
			costTxID = &costTx.ID
		}

		newEnd := u.VipEndTime
		switch outcome.CategoryType {
		case models.EggCategoryKen:
			if outcome.KenAmount != nil && *outcome.KenAmount > 0 {
				rewardTx := models.KenTransaction{
					UserID:        userID,
					Direction:     models.KenDirectionCredit,
					Type:          models.KenTxTypeReward,
					Amount:        *outcome.KenAmount,
					BalanceBefore: finalKen,
					BalanceAfter:  finalKen + *outcome.KenAmount,
					Description:   outcome.RewardLabel,
					RefType:       "egg_draw",
					ActorType:     models.KenActorSystem,
				}
				if err := tx.Create(&rewardTx).Error; err != nil {
					return err
				}
				finalKen += *outcome.KenAmount
			}
		case models.EggCategoryVipIcon:
			if outcome.VipTypeID != nil {
				icon := models.UserVipIcon{
					UserID:     userID,
					VipIconID:  *outcome.VipTypeID,
					Source:     "egg",
					AcquiredAt: time.Now(),
				}
				if err := tx.Create(&icon).Error; err != nil {
					return err
				}
			}
		case models.EggCategoryVipDays:
			if outcome.VipDays != nil && *outcome.VipDays > 0 {
				base := time.Now()
				if u.VipEndTime != nil && u.VipEndTime.After(base) {
					base = *u.VipEndTime
				}
				end := base.Add(time.Duration(*outcome.VipDays) * 24 * time.Hour)
				newEnd = &end
			}
		}

		userFields := map[string]interface{}{"ken": finalKen}
		if newEnd != u.VipEndTime && newEnd != nil {
			userFields["vip_end_time"] = *newEnd
		}
		if err := tx.Model(&models.User{}).Where("id = ?", userID).Updates(userFields).Error; err != nil {
			return err
		}

		metadata := models.JSONB{"categoryWeight": outcome.CategoryWeight, "rewardWeight": outcome.RewardWeight}
		if idempotencyKey != "" {
			metadata["idempotencyKey"] = idempotencyKey
		}

		draw = models.EggDraw{
			UserID:       userID,
			PackID:       pack.ID,
			PackName:     pack.Name,
			KenCost:      pack.KenCost,
			CategoryType: outcome.CategoryType,
			RewardType:   outcome.RewardType,
			RewardLabel:  nilIfEmpty(outcome.RewardLabel),
			VipTypeID:    outcome.VipTypeID,
			KenAmount:    outcome.KenAmount,
			VipDays:      outcome.VipDays,
			IsSuperLucky: outcome.IsSuperLucky,
			KenTxID:      costTxID,
			Metadata:     metadata,
		}
		if err := tx.Create(&draw).Error; err != nil {
			return err
		}

		u.Ken = finalKen
		u.VipEndTime = newEnd
		updatedUser = u
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return &draw, &updatedUser, nil
}

func (r *Repository) ListDraws(userID uuid.UUID, limit, offset int) ([]models.EggDraw, int64, error) {
	var draws []models.EggDraw
	var total int64
	if err := r.db.Model(&models.EggDraw{}).Where("user_id = ?", userID).Count(&total).Error; err != nil {
		return nil, 0, err
	}
	if err := r.db.Where("user_id = ?", userID).
		Order("created_at DESC").
		Limit(limit).Offset(offset).
		Find(&draws).Error; err != nil {
		return nil, 0, err
	}
	return draws, total, nil
}

type AdminDrawRow struct {
	models.EggDraw
	Username string `gorm:"column:username"`
	FullName string `gorm:"column:full_name"`
	Avatar   string `gorm:"column:avatar"`
}

func (r *Repository) ListAllDraws(userID *uuid.UUID, limit, offset int) ([]AdminDrawRow, int64, error) {
	count := r.db.Model(&models.EggDraw{})
	if userID != nil {
		count = count.Where("user_id = ?", *userID)
	}
	var total int64
	if err := count.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	query := r.db.Table("egg_draws").
		Select("egg_draws.*, users.username, users.full_name, users.avatar").
		Joins("LEFT JOIN users ON users.id = egg_draws.user_id").
		Order("egg_draws.created_at DESC").
		Limit(limit).Offset(offset)
	if userID != nil {
		query = query.Where("egg_draws.user_id = ?", *userID)
	}

	var rows []AdminDrawRow
	if err := query.Scan(&rows).Error; err != nil {
		return nil, 0, err
	}
	return rows, total, nil
}

func nilIfEmpty(s string) *string {
	if s == "" {
		return nil
	}
	return &s
}
