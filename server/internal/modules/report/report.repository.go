package report

import (
	"errors"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	momentModule "ola-chat-server/internal/modules/moment"
	"ola-chat-server/internal/modules/room"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

var errDuplicateReport = errors.New("duplicate pending report")

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) HasPending(reporterID uuid.UUID, targetType, targetID string) (bool, error) {
	var count int64
	err := r.db.Model(&models.Report{}).
		Where("reporter_id = ? AND target_type = ? AND target_id = ? AND status = ?", reporterID, targetType, targetID, constants.ReportStatusPending).
		Count(&count).Error
	return count > 0, err
}

func (r *Repository) Create(report *models.Report) error {
	err := r.db.Create(report).Error
	if apperr.IsUniqueViolation(err) {
		return errDuplicateReport
	}
	return err
}

func (r *Repository) FindUser(id uuid.UUID) (*models.User, error) {
	var user models.User
	if err := r.db.Select("id", "username", "full_name", "avatar").First(&user, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *Repository) FindPost(id uuid.UUID) (*models.Me, error) {
	var post models.Me
	if err := r.db.First(&post, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &post, nil
}

func (r *Repository) FindMeComment(id uuid.UUID) (*models.MeComment, error) {
	var comment models.MeComment
	if err := r.db.First(&comment, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &comment, nil
}

func (r *Repository) FindMoment(id uuid.UUID) (*models.Moment, error) {
	var moment models.Moment
	if err := r.db.First(&moment, "id = ? AND enabled AND status NOT IN ?", id, momentModule.MomentMediaGoneStatuses).Error; err != nil {
		return nil, err
	}
	return &moment, nil
}

func (r *Repository) CreateWhileMomentKept(report *models.Report, momentID uuid.UUID) error {
	err := r.db.Transaction(func(tx *gorm.DB) error {
		var kept []uuid.UUID
		if err := tx.Raw(
			"SELECT id FROM moments WHERE id = ? AND deleted_at IS NULL AND enabled AND status NOT IN ? FOR SHARE",
			momentID, momentModule.MomentMediaGoneStatuses,
		).Scan(&kept).Error; err != nil {
			return err
		}
		if len(kept) == 0 {
			return gorm.ErrRecordNotFound
		}
		return tx.Create(report).Error
	})
	if apperr.IsUniqueViolation(err) {
		return errDuplicateReport
	}
	return err
}

func (r *Repository) CreateWhileRoomImagesKept(report *models.Report) error {
	err := r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Exec(
			"SELECT pg_advisory_xact_lock_shared(hashtextextended(?::text, 0))",
			room.AdvisoryLockRoomImagePurge,
		).Error; err != nil {
			return err
		}
		return tx.Create(report).Error
	})
	if apperr.IsUniqueViolation(err) {
		return errDuplicateReport
	}
	return err
}

func (r *Repository) FindStoryComment(id uuid.UUID) (*models.StoryComment, error) {
	var comment models.StoryComment
	if err := r.db.First(&comment, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &comment, nil
}
