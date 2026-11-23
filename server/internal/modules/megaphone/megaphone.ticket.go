package megaphone

import (
	"errors"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func TicketExpiresAt(now time.Time, days int) *time.Time {
	if days <= 0 {
		return nil
	}
	at := now.Add(time.Duration(days) * 24 * time.Hour)
	return &at
}

func GrantTicketsTx(tx *gorm.DB, userID uuid.UUID, count int, source string, sourceRef *uuid.UUID, days int, now time.Time) ([]models.UserMegaphoneTicket, error) {
	if count < 1 || count > TicketMaxPerGrant {
		return nil, ErrMegaphoneTicketCount
	}
	if days < 0 || days > TicketMaxDays {
		return nil, ErrMegaphoneTicketDays
	}
	expiresAt := TicketExpiresAt(now, days)
	tickets := make([]models.UserMegaphoneTicket, count)
	for i := range tickets {
		tickets[i] = models.UserMegaphoneTicket{
			ID:        uuid.New(),
			UserID:    userID,
			Source:    source,
			SourceRef: sourceRef,
			ExpiresAt: expiresAt,
			CreatedAt: now,
		}
	}
	if err := tx.Create(&tickets).Error; err != nil {
		return nil, err
	}
	return tickets, nil
}

func usableTicketsScope(userID uuid.UUID, now time.Time) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		return db.Where("user_id = ? AND used_at IS NULL AND revoked_at IS NULL AND (expires_at IS NULL OR expires_at > ?)", userID, now)
	}
}

func ticketUseOrder(db *gorm.DB) *gorm.DB {
	return db.Order("expires_at ASC NULLS LAST").Order("created_at ASC").Order("id ASC")
}

func nextTicketTx(tx *gorm.DB, userID uuid.UUID, now time.Time) (*models.UserMegaphoneTicket, error) {
	var ticket models.UserMegaphoneTicket
	err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).
		Scopes(usableTicketsScope(userID, now), ticketUseOrder).
		Take(&ticket).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &ticket, nil
}

func useTicketTx(tx *gorm.DB, ticketID, megaphoneID uuid.UUID, now time.Time) error {
	res := tx.Model(&models.UserMegaphoneTicket{}).
		Where("id = ? AND used_at IS NULL AND revoked_at IS NULL", ticketID).
		Updates(map[string]interface{}{"used_at": now, "megaphone_id": megaphoneID})
	if res.Error != nil {
		return res.Error
	}
	if res.RowsAffected != 1 {
		return ErrMegaphoneNoTicket
	}
	return nil
}

func (r *Repository) UsableTickets(userID uuid.UUID, now time.Time) ([]models.UserMegaphoneTicket, error) {
	var tickets []models.UserMegaphoneTicket
	err := r.db.Scopes(usableTicketsScope(userID, now), ticketUseOrder).Find(&tickets).Error
	return tickets, err
}

func (r *Repository) UsableTicketCount(userID uuid.UUID, now time.Time) (int, error) {
	var count int64
	err := r.db.Model(&models.UserMegaphoneTicket{}).
		Scopes(usableTicketsScope(userID, now)).
		Count(&count).Error
	return int(count), err
}

func (r *Repository) TicketsByIDs(ids []uuid.UUID) (map[uuid.UUID]models.UserMegaphoneTicket, error) {
	out := make(map[uuid.UUID]models.UserMegaphoneTicket, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	var tickets []models.UserMegaphoneTicket
	if err := r.db.Where("id IN ?", ids).Find(&tickets).Error; err != nil {
		return out, err
	}
	for i := range tickets {
		out[tickets[i].ID] = tickets[i]
	}
	return out, nil
}

func (r *Repository) UserTickets(userID uuid.UUID) ([]models.UserMegaphoneTicket, error) {
	var tickets []models.UserMegaphoneTicket
	err := r.db.Where("user_id = ?", userID).Order("created_at DESC").Order("id DESC").Find(&tickets).Error
	return tickets, err
}

func (r *Repository) GrantTickets(userID uuid.UUID, count int, source string, sourceRef *uuid.UUID, days int, now time.Time) ([]models.UserMegaphoneTicket, error) {
	var tickets []models.UserMegaphoneTicket
	err := r.db.Transaction(func(tx *gorm.DB) error {
		var err error
		tickets, err = GrantTicketsTx(tx, userID, count, source, sourceRef, days, now)
		return err
	})
	return tickets, err
}

func (r *Repository) RevokeTicket(userID, ticketID, adminID uuid.UUID, now time.Time) (*models.UserMegaphoneTicket, error) {
	res := r.db.Model(&models.UserMegaphoneTicket{}).
		Where("id = ? AND user_id = ?", ticketID, userID).
		Scopes(usableTicketsScope(userID, now)).
		Updates(map[string]interface{}{"revoked_at": now, "revoked_by": adminID})
	if res.Error != nil {
		return nil, res.Error
	}
	if res.RowsAffected != 1 {
		return nil, ErrMegaphoneTicketNotUsable
	}
	var ticket models.UserMegaphoneTicket
	if err := r.db.First(&ticket, "id = ?", ticketID).Error; err != nil {
		return nil, err
	}
	return &ticket, nil
}
