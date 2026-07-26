package adminmarriage

import (
	"time"

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

type proposalStatsRow struct {
	Total     int64 `gorm:"column:total"`
	Pending   int64 `gorm:"column:pending"`
	Accepted  int64 `gorm:"column:accepted"`
	Rejected  int64 `gorm:"column:rejected"`
	Cancelled int64 `gorm:"column:cancelled"`
}

func (r *Repository) ProposalStats(f StatsFilter) (proposalStatsRow, error) {
	q := r.db.Table("marriage_proposals").Where("deleted_at IS NULL")
	if f.From != nil {
		q = q.Where("created_at >= ?", *f.From)
	}
	if f.To != nil {
		q = q.Where("created_at <= ?", *f.To)
	}
	var row proposalStatsRow
	err := q.Select(`count(*) as total,
		count(*) filter (where status = ?) as pending,
		count(*) filter (where status = ?) as accepted,
		count(*) filter (where status = ?) as rejected,
		count(*) filter (where status = ?) as cancelled`,
		models.MarriageProposalPending,
		models.MarriageProposalAccepted,
		models.MarriageProposalRejected,
		models.MarriageProposalCancelled,
	).Scan(&row).Error
	return row, err
}

type marriageStatsRow struct {
	Total    int64 `gorm:"column:total"`
	Active   int64 `gorm:"column:active"`
	Divorced int64 `gorm:"column:divorced"`
}

func (r *Repository) MarriageStats(f StatsFilter) (marriageStatsRow, error) {
	q := r.db.Table("marriages").Where("deleted_at IS NULL")
	if f.From != nil {
		q = q.Where("married_at >= ?", *f.From)
	}
	if f.To != nil {
		q = q.Where("married_at <= ?", *f.To)
	}
	var row marriageStatsRow
	err := q.Select(`count(*) as total,
		count(*) filter (where status = ?) as active,
		count(*) filter (where status = ?) as divorced`,
		models.MarriageStatusActive,
		models.MarriageStatusDivorced,
	).Scan(&row).Error
	return row, err
}

func marriageScope(f ListFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		db = db.Where("marriages.deleted_at IS NULL")
		if f.Status != "" {
			db = db.Where("marriages.status = ?", f.Status)
		}
		if f.UserID != nil {
			db = db.Where("(marriages.user_low_id = ? OR marriages.user_high_id = ?)", *f.UserID, *f.UserID)
		}
		if f.From != nil {
			db = db.Where("marriages.married_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("marriages.married_at <= ?", *f.To)
		}
		return db
	}
}

type marriageRow struct {
	ID           uuid.UUID  `gorm:"column:id"`
	UserLowID    uuid.UUID  `gorm:"column:user_low_id"`
	UserHighID   uuid.UUID  `gorm:"column:user_high_id"`
	Status       string     `gorm:"column:status"`
	MarriedAt    time.Time  `gorm:"column:married_at"`
	DivorcedAt   *time.Time `gorm:"column:divorced_at"`
	DivorcedBy   *uuid.UUID `gorm:"column:divorced_by"`
	LowUsername  string     `gorm:"column:low_username"`
	LowFullName  string     `gorm:"column:low_full_name"`
	LowAvatar    string     `gorm:"column:low_avatar"`
	HighUsername string     `gorm:"column:high_username"`
	HighFullName string     `gorm:"column:high_full_name"`
	HighAvatar   string     `gorm:"column:high_avatar"`
}

func (r *Repository) ListMarriages(f ListFilter, limit, offset int) ([]marriageRow, int64, error) {
	var total int64
	if err := r.db.Table("marriages").Scopes(marriageScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []marriageRow
	err := r.db.Table("marriages").
		Select(`marriages.id, marriages.user_low_id, marriages.user_high_id, marriages.status,
			marriages.married_at, marriages.divorced_at, marriages.divorced_by,
			low_user.username AS low_username, low_user.full_name AS low_full_name, low_user.avatar AS low_avatar,
			high_user.username AS high_username, high_user.full_name AS high_full_name, high_user.avatar AS high_avatar`).
		Joins("LEFT JOIN users AS low_user ON low_user.id = marriages.user_low_id").
		Joins("LEFT JOIN users AS high_user ON high_user.id = marriages.user_high_id").
		Scopes(marriageScope(f)).
		Order("marriages.married_at DESC, marriages.id DESC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}

func proposalScope(f ListFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		db = db.Where("marriage_proposals.deleted_at IS NULL")
		if f.Status != "" {
			db = db.Where("marriage_proposals.status = ?", f.Status)
		}
		if f.UserID != nil {
			db = db.Where("(marriage_proposals.proposer_id = ? OR marriage_proposals.addressee_id = ?)", *f.UserID, *f.UserID)
		}
		if f.From != nil {
			db = db.Where("marriage_proposals.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("marriage_proposals.created_at <= ?", *f.To)
		}
		return db
	}
}

type proposalRow struct {
	ID                uuid.UUID  `gorm:"column:id"`
	ProposerID        uuid.UUID  `gorm:"column:proposer_id"`
	AddresseeID       uuid.UUID  `gorm:"column:addressee_id"`
	Message           string     `gorm:"column:message"`
	Status            string     `gorm:"column:status"`
	CreatedAt         time.Time  `gorm:"column:created_at"`
	RespondedAt       *time.Time `gorm:"column:responded_at"`
	ProposerUsername  string     `gorm:"column:proposer_username"`
	ProposerFullName  string     `gorm:"column:proposer_full_name"`
	ProposerAvatar    string     `gorm:"column:proposer_avatar"`
	AddresseeUsername string     `gorm:"column:addressee_username"`
	AddresseeFullName string     `gorm:"column:addressee_full_name"`
	AddresseeAvatar   string     `gorm:"column:addressee_avatar"`
}

func (r *Repository) ListProposals(f ListFilter, limit, offset int) ([]proposalRow, int64, error) {
	var total int64
	if err := r.db.Table("marriage_proposals").Scopes(proposalScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []proposalRow
	err := r.db.Table("marriage_proposals").
		Select(`marriage_proposals.id, marriage_proposals.proposer_id, marriage_proposals.addressee_id,
			marriage_proposals.message, marriage_proposals.status, marriage_proposals.created_at, marriage_proposals.responded_at,
			proposer.username AS proposer_username, proposer.full_name AS proposer_full_name, proposer.avatar AS proposer_avatar,
			addressee.username AS addressee_username, addressee.full_name AS addressee_full_name, addressee.avatar AS addressee_avatar`).
		Joins("LEFT JOIN users AS proposer ON proposer.id = marriage_proposals.proposer_id").
		Joins("LEFT JOIN users AS addressee ON addressee.id = marriage_proposals.addressee_id").
		Scopes(proposalScope(f)).
		Order("marriage_proposals.created_at DESC, marriage_proposals.id DESC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}
