package adminmegaphone

import (
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func formatOptionalTime(at *time.Time) string {
	if at == nil {
		return ""
	}
	return at.UTC().Format(time.RFC3339)
}

func formatOptionalUUID(id *uuid.UUID) string {
	if id == nil {
		return ""
	}
	return id.String()
}

type ticketNames struct {
	admins    map[uuid.UUID]string
	campaigns map[uuid.UUID]string
}

func (n ticketNames) source(t *models.UserMegaphoneTicket) string {
	if t.SourceRef == nil {
		return ""
	}
	switch t.Source {
	case models.MegaphoneTicketSourceAdmin:
		return n.admins[*t.SourceRef]
	case models.MegaphoneTicketSourceGiftCode:
		return n.campaigns[*t.SourceRef]
	}
	return ""
}

func (s *Service) ticketNames(tickets []models.UserMegaphoneTicket) (ticketNames, error) {
	adminIDs := make([]uuid.UUID, 0)
	campaignIDs := make([]uuid.UUID, 0)
	for i := range tickets {
		t := &tickets[i]
		if t.RevokedBy != nil {
			adminIDs = append(adminIDs, *t.RevokedBy)
		}
		if t.SourceRef == nil {
			continue
		}
		switch t.Source {
		case models.MegaphoneTicketSourceAdmin:
			adminIDs = append(adminIDs, *t.SourceRef)
		case models.MegaphoneTicketSourceGiftCode:
			campaignIDs = append(campaignIDs, *t.SourceRef)
		}
	}
	admins, err := s.repo.AdminNames(adminIDs)
	if err != nil {
		return ticketNames{}, err
	}
	campaigns, err := s.repo.CampaignNames(campaignIDs)
	if err != nil {
		return ticketNames{}, err
	}
	return ticketNames{admins: admins, campaigns: campaigns}, nil
}

func toTicketBrief(t *models.UserMegaphoneTicket, names ticketNames) TicketBrief {
	return TicketBrief{
		ID:         t.ID.String(),
		Source:     t.Source,
		SourceRef:  formatOptionalUUID(t.SourceRef),
		SourceName: names.source(t),
		CreatedAt:  t.CreatedAt.UTC().Format(time.RFC3339),
		ExpiresAt:  formatOptionalTime(t.ExpiresAt),
	}
}

func toUserTicketItem(t *models.UserMegaphoneTicket, names ticketNames, now time.Time) UserTicketItem {
	item := UserTicketItem{
		TicketBrief: toTicketBrief(t, names),
		Status:      t.Status(now),
		UsedAt:      formatOptionalTime(t.UsedAt),
		MegaphoneID: formatOptionalUUID(t.MegaphoneID),
		RevokedAt:   formatOptionalTime(t.RevokedAt),
	}
	if t.RevokedBy != nil {
		item.RevokedByName = names.admins[*t.RevokedBy]
	}
	return item
}

func (s *Service) requireUser(userID uuid.UUID) error {
	users, err := s.repo.FindUsersByIDs([]uuid.UUID{userID})
	if err != nil {
		return err
	}
	if _, ok := users[userID]; !ok {
		return apperr.ErrUserNotFound
	}
	return nil
}

func (s *Service) toUserTicketItems(tickets []models.UserMegaphoneTicket, now time.Time) ([]UserTicketItem, error) {
	names, err := s.ticketNames(tickets)
	if err != nil {
		return nil, err
	}
	items := make([]UserTicketItem, 0, len(tickets))
	for i := range tickets {
		items = append(items, toUserTicketItem(&tickets[i], names, now))
	}
	return items, nil
}

func (s *Service) ListUserTickets(userID uuid.UUID) (*UserTicketListResponse, error) {
	if err := s.requireUser(userID); err != nil {
		return nil, err
	}
	tickets, err := s.megaphoneRepo.UserTickets(userID)
	if err != nil {
		return nil, err
	}
	now := time.Now().UTC()
	items, err := s.toUserTicketItems(tickets, now)
	if err != nil {
		return nil, err
	}
	usable := 0
	for i := range items {
		if items[i].Status == models.MegaphoneTicketStatusUsable {
			usable++
		}
	}
	return &UserTicketListResponse{Items: items, UsableCount: usable}, nil
}

func (s *Service) GrantUserTickets(adminID, userID uuid.UUID, req *GrantTicketsRequest) (*UserTicketListResponse, error) {
	if err := s.requireUser(userID); err != nil {
		return nil, err
	}
	now := time.Now().UTC()
	if _, err := s.megaphoneRepo.GrantTickets(userID, req.Count, models.MegaphoneTicketSourceAdmin, &adminID, req.ExpiresInDays, now); err != nil {
		return nil, err
	}
	s.logger.Infow("Admin granted megaphone tickets", "admin_id", adminID, "user_id", userID, "count", req.Count, "expires_in_days", req.ExpiresInDays)
	return s.ListUserTickets(userID)
}

func (s *Service) RevokeUserTicket(adminID, userID, ticketID uuid.UUID) (*UserTicketItem, error) {
	now := time.Now().UTC()
	ticket, err := s.megaphoneRepo.RevokeTicket(userID, ticketID, adminID, now)
	if err != nil {
		return nil, err
	}
	s.logger.Infow("Admin revoked megaphone ticket", "admin_id", adminID, "user_id", userID, "ticket_id", ticketID)
	tickets := []models.UserMegaphoneTicket{*ticket}
	items, err := s.toUserTicketItems(tickets, now)
	if err != nil {
		return nil, err
	}
	return &items[0], nil
}
