package adminauth

import (
	"crypto/subtle"
	"errors"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type RefreshRotationStatus string

const (
	RefreshRotationRotated  RefreshRotationStatus = "rotated"
	RefreshRotationRetry    RefreshRotationStatus = "retry"
	RefreshRotationReused   RefreshRotationStatus = "reused"
	RefreshRotationRevoked  RefreshRotationStatus = "revoked"
	RefreshRotationExpired  RefreshRotationStatus = "expired"
	RefreshRotationNotFound RefreshRotationStatus = "not_found"
)

type RefreshRotationResult struct {
	Status        RefreshRotationStatus
	ExpiresAt     time.Time
	RetryResponse []byte
}

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) FindByUsername(username string) (*models.AdminUser, error) {
	var admin models.AdminUser
	err := r.db.Where("LOWER(username) = LOWER(?)", username).First(&admin).Error
	if err != nil {
		return nil, err
	}
	return &admin, nil
}

func (r *Repository) FindByID(id uuid.UUID) (*models.AdminUser, error) {
	var admin models.AdminUser
	err := r.db.First(&admin, "id = ?", id).Error
	if err != nil {
		return nil, err
	}
	return &admin, nil
}

func (r *Repository) CreateSession(session *models.AdminSession, expectedPasswordHash string) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		result := tx.Model(&models.AdminUser{}).
			Where("id = ? AND is_active = ? AND password = ?", session.AdminID, true, expectedPasswordHash).
			Updates(map[string]interface{}{
				"last_login_ip": session.IPAddress,
				"last_login_at": gorm.Expr("NOW()"),
			})
		if result.Error != nil {
			return result.Error
		}
		if result.RowsAffected != 1 {
			return errors.New("invalid username or password")
		}
		return tx.Create(session).Error
	})
}

func (r *Repository) RotateRefreshToken(
	adminID, sessionID uuid.UUID,
	presentedHash, newHash string,
	retryResponse []byte,
	ip, userAgent string,
	retryGrace time.Duration,
) (*RefreshRotationResult, error) {
	rotation := &RefreshRotationResult{}
	err := r.db.Transaction(func(tx *gorm.DB) error {
		var session models.AdminSession
		err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).
			Where("id = ? AND admin_id = ?", sessionID, adminID).
			First(&session).Error
		if errors.Is(err, gorm.ErrRecordNotFound) {
			rotation.Status = RefreshRotationNotFound
			return nil
		}
		if err != nil {
			return err
		}

		rotation.ExpiresAt = session.ExpiresAt
		if session.RevokedAt != nil {
			rotation.Status = RefreshRotationRevoked
			return nil
		}

		now := time.Now()
		if !session.ExpiresAt.After(now) {
			rotation.Status = RefreshRotationExpired
			return nil
		}

		if refreshHashesEqual(session.RefreshTokenHash, presentedHash) {
			result := tx.Model(&models.AdminSession{}).
				Where("id = ? AND admin_id = ? AND revoked_at IS NULL", sessionID, adminID).
				Updates(map[string]interface{}{
					"previous_refresh_token_hash": session.RefreshTokenHash,
					"refresh_token_hash":          newHash,
					"last_rotated_at":             now,
					"refresh_retry_response":      retryResponse,
					"ip_address":                  ip,
					"user_agent":                  userAgent,
					"last_active_at":              now,
				})
			if result.Error != nil {
				return result.Error
			}
			if result.RowsAffected != 1 {
				return errors.New("admin refresh rotation lost row lock")
			}
			rotation.Status = RefreshRotationRotated
			return nil
		}

		if session.PreviousRefreshTokenHash != nil &&
			session.LastRotatedAt != nil &&
			len(session.RefreshRetryResponse) > 0 &&
			refreshHashesEqual(*session.PreviousRefreshTokenHash, presentedHash) &&
			now.Before(session.LastRotatedAt.Add(retryGrace)) {
			rotation.Status = RefreshRotationRetry
			rotation.RetryResponse = append([]byte(nil), session.RefreshRetryResponse...)
			return nil
		}

		result := tx.Model(&models.AdminSession{}).
			Where("id = ? AND admin_id = ? AND revoked_at IS NULL", sessionID, adminID).
			Updates(map[string]interface{}{
				"revoked_at":     now,
				"last_active_at": now,
			})
		if result.Error != nil {
			return result.Error
		}
		if result.RowsAffected != 1 {
			return errors.New("admin refresh replay revoke lost row lock")
		}
		rotation.Status = RefreshRotationReused
		return nil
	})
	if err != nil {
		return nil, err
	}
	return rotation, nil
}

func refreshHashesEqual(left, right string) bool {
	if len(left) != sha256HexLength || len(right) != sha256HexLength {
		return false
	}
	return subtle.ConstantTimeCompare([]byte(left), []byte(right)) == 1
}

const sha256HexLength = 64

func (r *Repository) RevokeSession(adminID, sessionID uuid.UUID) (bool, error) {
	result := r.db.Model(&models.AdminSession{}).
		Where("id = ? AND admin_id = ? AND revoked_at IS NULL", sessionID, adminID).
		Update("revoked_at", gorm.Expr("NOW()"))
	if result.Error != nil {
		return false, result.Error
	}
	return result.RowsAffected == 1, nil
}

func (r *Repository) UpdatePasswordAndRevokeSessions(id uuid.UUID, expectedPasswordHash, passwordHash string) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		result := tx.Model(&models.AdminUser{}).
			Where("id = ? AND password = ?", id, expectedPasswordHash).
			Updates(map[string]interface{}{
				"password": passwordHash,
			})
		if result.Error != nil {
			return result.Error
		}
		if result.RowsAffected != 1 {
			return gorm.ErrRecordNotFound
		}

		return tx.Model(&models.AdminSession{}).
			Where("admin_id = ? AND revoked_at IS NULL", id).
			Updates(map[string]interface{}{
				"revoked_at":     time.Now(),
				"last_active_at": time.Now(),
			}).Error
	})
}
