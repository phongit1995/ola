package marriage

import (
	"bytes"
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

func briefSelect(tx *gorm.DB) *gorm.DB {
	return tx.Select("id", "username", "full_name", "avatar")
}

func orderIDs(a, b uuid.UUID) (uuid.UUID, uuid.UUID) {
	if bytes.Compare(a[:], b[:]) <= 0 {
		return a, b
	}
	return b, a
}

func (r *Repository) FindUserByUsername(username string) (*models.User, error) {
	var u models.User
	if err := r.db.First(&u, "username = ?", username).Error; err != nil {
		return nil, err
	}
	return &u, nil
}

func (r *Repository) FindUserByID(id uuid.UUID) (*models.User, error) {
	var u models.User
	if err := r.db.First(&u, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &u, nil
}

func (r *Repository) FindUserWithSpouse(id uuid.UUID) (*models.User, error) {
	var u models.User
	if err := r.db.Preload("Spouse", briefSelect).First(&u, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &u, nil
}

func (r *Repository) ExistsPending(proposerID, addresseeID uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Model(&models.MarriageProposal{}).
		Where("proposer_id = ? AND addressee_id = ? AND status = ?", proposerID, addresseeID, models.MarriageProposalPending).
		Count(&count).Error
	return count > 0, err
}

func (r *Repository) CreateProposal(p *models.MarriageProposal) error {
	return r.db.Create(p).Error
}

func (r *Repository) FindProposal(id uuid.UUID) (*models.MarriageProposal, error) {
	var p models.MarriageProposal
	if err := r.db.
		Preload("Proposer", briefSelect).
		Preload("Addressee", briefSelect).
		First(&p, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &p, nil
}

func (r *Repository) ListProposals(userID uuid.UUID, outgoing bool, limit, offset int) ([]models.MarriageProposal, int64, error) {
	q := r.db.Model(&models.MarriageProposal{})
	if outgoing {
		q = q.Where("proposer_id = ?", userID)
	} else {
		q = q.Where("addressee_id = ?", userID)
	}

	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var items []models.MarriageProposal
	err := q.
		Preload("Proposer", briefSelect).
		Preload("Addressee", briefSelect).
		Order("created_at DESC").
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, total, err
}

func (r *Repository) SetProposalStatus(id uuid.UUID, status string, now time.Time) error {
	return r.db.Model(&models.MarriageProposal{}).
		Where("id = ?", id).
		Updates(map[string]interface{}{"status": status, "responded_at": now}).Error
}

func (r *Repository) GetActiveMarriage(userID uuid.UUID) (*models.Marriage, error) {
	var m models.Marriage
	err := r.db.
		Where("(user_low_id = ? OR user_high_id = ?) AND status = ?", userID, userID, models.MarriageStatusActive).
		First(&m).Error
	if err != nil {
		return nil, err
	}
	return &m, nil
}

func (r *Repository) Accept(proposalID, accepterID uuid.UUID, now time.Time) (*models.User, *models.User, time.Time, error) {
	var proposer, addressee models.User

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var p models.MarriageProposal
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&p, "id = ?", proposalID).Error; err != nil {
			return err
		}
		if p.AddresseeID != accepterID {
			return ErrNotYourProposal
		}
		if p.Status != models.MarriageProposalPending {
			return ErrProposalNotPending
		}

		first, second := orderIDs(p.ProposerID, p.AddresseeID)
		var u1, u2 models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u1, "id = ?", first).Error; err != nil {
			return err
		}
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u2, "id = ?", second).Error; err != nil {
			return err
		}
		if u1.SpouseID != nil || u2.SpouseID != nil {
			return ErrAlreadyMarried
		}

		pid := p.ID
		marriage := models.Marriage{
			UserLowID:  first,
			UserHighID: second,
			Status:     models.MarriageStatusActive,
			ProposalID: &pid,
			MarriedAt:  now,
		}
		if err := tx.Create(&marriage).Error; err != nil {
			return err
		}

		if err := tx.Model(&models.User{}).Where("id = ?", p.ProposerID).
			Update("spouse_id", p.AddresseeID).Error; err != nil {
			return err
		}
		if err := tx.Model(&models.User{}).Where("id = ?", p.AddresseeID).
			Update("spouse_id", p.ProposerID).Error; err != nil {
			return err
		}

		if err := tx.Model(&models.MarriageProposal{}).Where("id = ?", p.ID).
			Updates(map[string]interface{}{"status": models.MarriageProposalAccepted, "responded_at": now}).Error; err != nil {
			return err
		}

		pair := []uuid.UUID{p.ProposerID, p.AddresseeID}
		if err := tx.Model(&models.MarriageProposal{}).
			Where("status = ? AND id <> ?", models.MarriageProposalPending, p.ID).
			Where("proposer_id IN ? OR addressee_id IN ?", pair, pair).
			Updates(map[string]interface{}{"status": models.MarriageProposalCancelled, "responded_at": now}).Error; err != nil {
			return err
		}

		if err := tx.Preload("Spouse", briefSelect).First(&proposer, "id = ?", p.ProposerID).Error; err != nil {
			return err
		}
		if err := tx.Preload("Spouse", briefSelect).First(&addressee, "id = ?", p.AddresseeID).Error; err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		return nil, nil, time.Time{}, err
	}
	return &proposer, &addressee, now, nil
}

func (r *Repository) Divorce(userID uuid.UUID, now time.Time) (uuid.UUID, error) {
	var spouseID uuid.UUID

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var u models.User
		if err := tx.First(&u, "id = ?", userID).Error; err != nil {
			return err
		}
		if u.SpouseID == nil {
			return ErrNotMarried
		}
		sid := *u.SpouseID

		low, high := orderIDs(userID, sid)
		var ul, uh models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&ul, "id = ?", low).Error; err != nil {
			return err
		}
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&uh, "id = ?", high).Error; err != nil {
			return err
		}

		me := ul
		if userID == high {
			me = uh
		}
		if me.SpouseID == nil || *me.SpouseID != sid {
			return ErrNotMarried
		}
		spouseID = sid

		if err := tx.Model(&models.Marriage{}).
			Where("user_low_id = ? AND user_high_id = ? AND status = ?", low, high, models.MarriageStatusActive).
			Updates(map[string]interface{}{"status": models.MarriageStatusDivorced, "divorced_at": now, "divorced_by": userID}).Error; err != nil {
			return err
		}

		if err := tx.Model(&models.User{}).Where("id IN ?", []uuid.UUID{userID, sid}).
			Update("spouse_id", nil).Error; err != nil {
			return err
		}
		return nil
	})
	return spouseID, err
}
