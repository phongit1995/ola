package moderation

import (
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/push"

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

func (r *Repository) WithTx(tx *gorm.DB) *Repository {
	return &Repository{db: tx}
}

type recordResult struct {
	counted     bool
	total       int
	locked      bool
	lockedUntil *time.Time
}

func (r *Repository) Record(violation *models.UserViolation, cfg setting.ModerationConfig, now time.Time) (*recordResult, error) {
	result := &recordResult{}
	err := r.db.Transaction(func(tx *gorm.DB) error {
		var user models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).
			Select("id", "is_active", "locked_until", "lock_reason").
			First(&user, "id = ?", violation.UserID).Error; err != nil {
			return err
		}
		created := tx.Clauses(clause.OnConflict{DoNothing: true}).Create(violation)
		if created.Error != nil {
			return created.Error
		}
		result.counted = created.RowsAffected > 0
		total, err := activePoints(tx, violation.UserID, cfg, now)
		if err != nil {
			return err
		}
		result.total = total
		if !result.counted || violation.Points == 0 {
			return nil
		}
		step, reached := cfg.StepReached(total)
		if !reached {
			return nil
		}
		var until *time.Time
		if !step.Permanent() {
			end := now.Add(time.Duration(step.Hours) * time.Hour)
			until = &end
		}
		if !lockExtends(&user, until) {
			return nil
		}
		result.locked = true
		result.lockedUntil = until
		return tx.Model(&models.User{}).Where("id = ?", violation.UserID).Updates(map[string]interface{}{
			"is_active":    false,
			"locked_until": until,
			"lock_reason":  constants.LockReasonViolations,
		}).Error
	})
	if err != nil {
		return nil, err
	}
	return result, nil
}

func lockExtends(user *models.User, until *time.Time) bool {
	if user.IsActive {
		return true
	}
	if user.LockReason != constants.LockReasonViolations || user.LockedUntil == nil {
		return false
	}
	return until == nil || until.After(*user.LockedUntil)
}

func (r *Repository) ActivePoints(userID uuid.UUID, cfg setting.ModerationConfig, now time.Time) (int, error) {
	return activePoints(r.db, userID, cfg, now)
}

func activeScope(db *gorm.DB, userID uuid.UUID, cfg setting.ModerationConfig, now time.Time) *gorm.DB {
	query := db.Model(&models.UserViolation{}).
		Where("user_id = ? AND revoked_at IS NULL", userID)
	if cfg.ExpireHours > 0 {
		query = query.Where("created_at > ?", now.Add(-time.Duration(cfg.ExpireHours)*time.Hour))
	}
	return query
}

func activePoints(db *gorm.DB, userID uuid.UUID, cfg setting.ModerationConfig, now time.Time) (int, error) {
	var total int
	err := activeScope(db, userID, cfg, now).Select("COALESCE(SUM(points), 0)").Scan(&total).Error
	return total, err
}

func (r *Repository) ListByUser(userID uuid.UUID, limit int) ([]*models.UserViolation, error) {
	var items []*models.UserViolation
	err := r.db.Preload("Admin").Preload("Revoker").
		Where("user_id = ?", userID).
		Order("created_at DESC").Order("id DESC").
		Limit(limit).
		Find(&items).Error
	return items, err
}

func (r *Repository) Revoke(userID, violationID, adminID uuid.UUID, now time.Time) (bool, error) {
	result := r.db.Model(&models.UserViolation{}).
		Where("id = ? AND user_id = ? AND revoked_at IS NULL", violationID, userID).
		Updates(map[string]interface{}{"revoked_at": now, "revoked_by": adminID})
	return result.RowsAffected > 0, result.Error
}

func (r *Repository) RevokeActive(userID, adminID uuid.UUID, cfg setting.ModerationConfig, now time.Time) (int64, error) {
	result := activeScope(r.db, userID, cfg, now).
		Where("points > 0").
		Updates(map[string]interface{}{"revoked_at": now, "revoked_by": adminID})
	return result.RowsAffected, result.Error
}

func (r *Repository) ActiveDeviceTokens(userID uuid.UUID) ([]models.DeviceToken, error) {
	return push.ActiveDeviceTokens(r.db, userID.String())
}

func (r *Repository) LatestRemovalForTarget(targetType, targetID string) (*models.UserViolation, error) {
	var items []*models.UserViolation
	err := r.db.Where("target_type = ? AND target_id = ? AND content_removed AND revoked_at IS NULL", targetType, targetID).
		Order("created_at DESC").
		Limit(1).
		Find(&items).Error
	if err != nil || len(items) == 0 {
		return nil, err
	}
	return items[0], nil
}
