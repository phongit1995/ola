package adminmegaphone

import (
	"errors"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	admincommon "ola-chat-server/internal/modules/admin/common"
	contentfilter "ola-chat-server/internal/modules/content-filter"
	megaphoneModule "ola-chat-server/internal/modules/megaphone"
	"ola-chat-server/internal/modules/moderation"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo          *Repository
	megaphoneRepo *megaphoneModule.Repository
	megaphoneSvc  *megaphoneModule.Service
	filter        *contentfilter.Service
	moderation    *moderation.Service
	logger        *zap.SugaredLogger
}

func NewService(
	repo *Repository,
	megaphoneRepo *megaphoneModule.Repository,
	megaphoneSvc *megaphoneModule.Service,
	filter *contentfilter.Service,
	moderationService *moderation.Service,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:          repo,
		megaphoneRepo: megaphoneRepo,
		megaphoneSvc:  megaphoneSvc,
		filter:        filter,
		moderation:    moderationService,
		logger:        logger.Named("[admin_megaphone_service]"),
	}
}

func paidWithOf(m *models.Megaphone) string {
	switch {
	case m.TicketID != nil:
		return PaidWithTicket
	case m.KenPrice > 0:
		return PaidWithKen
	default:
		return PaidWithFree
	}
}

func toItem(m *models.Megaphone, sender admincommon.UserBrief) MegaphoneItem {
	item := MegaphoneItem{
		ID:             m.ID.String(),
		Type:           m.Type,
		Sender:         sender,
		Content:        m.Content,
		KenPrice:       m.KenPrice,
		ShowAt:         m.ShowAt.UTC().Format(time.RFC3339),
		DisplaySeconds: m.DisplaySeconds,
		ExpiresAt:      m.ExpiresAt.UTC().Format(time.RFC3339),
		Status:         m.Status,
		RemovedReason:  m.RemovedReason,
		CreatedAt:      m.CreatedAt.UTC().Format(time.RFC3339),
		PaidWith:       paidWithOf(m),
	}
	if m.RemovedAt != nil {
		item.RemovedAt = m.RemovedAt.UTC().Format(time.RFC3339)
	}
	return item
}

func (s *Service) briefs(ids []uuid.UUID) (map[uuid.UUID]admincommon.UserBrief, error) {
	users, err := s.repo.FindUsersByIDs(ids)
	if err != nil {
		return nil, err
	}
	out := make(map[uuid.UUID]admincommon.UserBrief, len(ids))
	for _, id := range ids {
		u := users[id]
		out[id] = admincommon.UserBriefOf(id, u.Username, u.FullName, u.Avatar)
	}
	return out, nil
}

func (s *Service) List(f ListFilter) (*ListResponse, error) {
	items, t, err := s.repo.List(f)
	if err != nil {
		return nil, err
	}
	seen := make(map[uuid.UUID]bool, len(items))
	ids := make([]uuid.UUID, 0, len(items))
	for i := range items {
		if !seen[items[i].SenderID] {
			seen[items[i].SenderID] = true
			ids = append(ids, items[i].SenderID)
		}
	}
	briefs, err := s.briefs(ids)
	if err != nil {
		return nil, err
	}
	ticketBriefs, err := s.ticketBriefs(items)
	if err != nil {
		return nil, err
	}
	out := make([]MegaphoneItem, 0, len(items))
	for i := range items {
		item := toItem(&items[i], briefs[items[i].SenderID])
		if items[i].TicketID != nil {
			if brief, ok := ticketBriefs[*items[i].TicketID]; ok {
				item.Ticket = &brief
			}
		}
		out = append(out, item)
	}
	return &ListResponse{Items: out, Total: t.Count, TotalKen: t.Ken, Limit: f.Limit, Offset: f.Offset}, nil
}

func (s *Service) Remove(adminID, id uuid.UUID, req *RemoveRequest) (*RemoveResponse, error) {
	item, err := s.megaphoneRepo.FindByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, megaphoneModule.ErrMegaphoneNotFound
		}
		return nil, err
	}
	reason := strings.TrimSpace(req.Reason)
	var (
		penalty *moderation.Penalty
		removed bool
	)
	err = s.megaphoneRepo.Transaction(func(tx *gorm.DB) error {
		var err error
		removed, err = s.megaphoneRepo.Remove(tx, id, adminID, reason, time.Now().UTC())
		if err != nil || !removed || req.Penalty == nil {
			return err
		}
		penalty, err = s.moderation.RecordPenalty(tx, moderation.PenaltyInput{
			UserID:         item.SenderID,
			AdminID:        adminID,
			Source:         moderation.SourceMegaphoneRemove,
			TargetType:     constants.ReportTargetMegaphone,
			TargetID:       id.String(),
			Reason:         req.Penalty.Reason,
			Severity:       req.Penalty.Severity,
			Note:           req.Penalty.Note,
			ContentRemoved: true,
		})
		return err
	})
	if err != nil {
		return nil, err
	}
	resp := &RemoveResponse{}
	if removed {
		s.megaphoneSvc.PublishRemoved(id)
		s.logger.Infow("Admin removed megaphone", "megaphone_id", id, "admin_id", adminID)
	}
	if penalty != nil {
		s.moderation.ApplyPenalty(penalty)
		resp.Penalty = penalty.Outcome
	}
	updated, err := s.megaphoneRepo.FindByID(id)
	if err != nil {
		return nil, err
	}
	briefs, err := s.briefs([]uuid.UUID{updated.SenderID})
	if err != nil {
		return nil, err
	}
	resp.Item = toItem(updated, briefs[updated.SenderID])
	return resp, nil
}

func (s *Service) CheckContent(text string) contentfilter.Result {
	return s.filter.Check(contentfilter.NormalizeContent(text))
}

func (s *Service) ticketBriefs(items []models.Megaphone) (map[uuid.UUID]TicketBrief, error) {
	ids := make([]uuid.UUID, 0)
	for i := range items {
		if items[i].TicketID != nil {
			ids = append(ids, *items[i].TicketID)
		}
	}
	out := make(map[uuid.UUID]TicketBrief, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	byID, err := s.megaphoneRepo.TicketsByIDs(ids)
	if err != nil {
		return nil, err
	}
	tickets := make([]models.UserMegaphoneTicket, 0, len(byID))
	for _, t := range byID {
		tickets = append(tickets, t)
	}
	names, err := s.ticketNames(tickets)
	if err != nil {
		return nil, err
	}
	for i := range tickets {
		out[tickets[i].ID] = toTicketBrief(&tickets[i], names)
	}
	return out, nil
}
