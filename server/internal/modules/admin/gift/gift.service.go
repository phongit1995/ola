package admingift

import (
	"strings"
	"time"

	"ola-chat-server/internal/models"
	admincommon "ola-chat-server/internal/modules/admin/common"
	giftModule "ola-chat-server/internal/modules/gift"

	"github.com/google/uuid"
)

type Service struct {
	repo     *Repository
	giftRepo *giftModule.Repository
	giftSvc  *giftModule.Service
}

func NewService(repo *Repository, giftRepo *giftModule.Repository, giftSvc *giftModule.Service) *Service {
	return &Service{repo: repo, giftRepo: giftRepo, giftSvc: giftSvc}
}

func toGiftItem(g *models.Gift) GiftItem {
	return GiftItem{
		ID:          g.ID.String(),
		Name:        g.Name,
		NameEn:      g.NameEn,
		ImageURL:    g.ImageURL,
		KenPrice:    g.KenPrice,
		CharmPoints: g.CharmPoints,
		IsActive:    g.IsActive,
		SortOrder:   g.SortOrder,
		CreatedAt:   g.CreatedAt.UTC().Format(time.RFC3339),
		UpdatedAt:   g.UpdatedAt.UTC().Format(time.RFC3339),
	}
}

func (s *Service) List() (*GiftListResponse, error) {
	gifts, err := s.giftRepo.ListAll()
	if err != nil {
		return nil, err
	}
	items := make([]GiftItem, 0, len(gifts))
	for i := range gifts {
		items = append(items, toGiftItem(&gifts[i]))
	}
	return &GiftListResponse{Items: items}, nil
}

func (s *Service) Create(req CreateGiftRequest) (*GiftItem, error) {
	active := true
	if req.IsActive != nil {
		active = *req.IsActive
	}
	g := &models.Gift{
		Name:        strings.TrimSpace(req.Name),
		NameEn:      strings.TrimSpace(req.NameEn),
		ImageURL:    strings.TrimSpace(req.ImageURL),
		KenPrice:    req.KenPrice,
		CharmPoints: req.CharmPoints,
		IsActive:    active,
		SortOrder:   req.SortOrder,
	}
	if err := s.giftRepo.Create(g); err != nil {
		return nil, err
	}
	s.giftSvc.InvalidateCatalog()
	item := toGiftItem(g)
	return &item, nil
}

func (s *Service) Update(id uuid.UUID, req UpdateGiftRequest) (*GiftItem, error) {
	g, err := s.giftRepo.FindByID(id)
	if err != nil {
		return nil, err
	}
	if req.Name != nil {
		g.Name = strings.TrimSpace(*req.Name)
	}
	if req.NameEn != nil {
		g.NameEn = strings.TrimSpace(*req.NameEn)
	}
	if req.ImageURL != nil {
		g.ImageURL = strings.TrimSpace(*req.ImageURL)
	}
	if req.KenPrice != nil {
		g.KenPrice = *req.KenPrice
	}
	if req.CharmPoints != nil {
		g.CharmPoints = *req.CharmPoints
	}
	if req.IsActive != nil {
		g.IsActive = *req.IsActive
	}
	if req.SortOrder != nil {
		g.SortOrder = *req.SortOrder
	}
	if g.Name == "" {
		return nil, ErrGiftNameRequired
	}
	if err := s.giftRepo.Save(g); err != nil {
		return nil, err
	}
	s.giftSvc.InvalidateCatalog()
	item := toGiftItem(g)
	return &item, nil
}

func (s *Service) Delete(id uuid.UUID) error {
	if err := s.giftRepo.Delete(id); err != nil {
		return err
	}
	s.giftSvc.InvalidateCatalog()
	return nil
}

func (s *Service) ListTransactions(f TransactionFilter, limit, offset int) (*TransactionListResponse, error) {
	items, totals, err := s.repo.ListTransactions(f, limit, offset)
	if err != nil {
		return nil, err
	}
	ids := make([]uuid.UUID, 0, len(items)*2)
	for i := range items {
		ids = append(ids, items[i].SenderID, items[i].ReceiverID)
	}
	users, err := s.repo.FindUsersByIDs(ids)
	if err != nil {
		return nil, err
	}
	brief := func(id uuid.UUID) admincommon.UserBrief {
		u := users[id]
		return admincommon.UserBriefOf(id, u.Username, u.FullName, u.Avatar)
	}
	out := make([]TransactionItem, 0, len(items))
	for i := range items {
		t := &items[i]
		out = append(out, TransactionItem{
			ID:           t.ID.String(),
			Sender:       brief(t.SenderID),
			Receiver:     brief(t.ReceiverID),
			GiftID:       t.GiftID.String(),
			GiftName:     t.GiftName,
			GiftImageURL: t.GiftImageURL,
			Quantity:     t.Quantity,
			UnitPrice:    t.UnitPrice,
			TotalKen:     t.TotalKen,
			CharmPoints:  t.CharmPoints,
			Source:       t.Source,
			Note:         t.Note,
			CreatedAt:    t.CreatedAt.UTC().Format(time.RFC3339),
		})
	}
	return &TransactionListResponse{
		Total:      totals.Count,
		TotalKen:   totals.Ken,
		TotalCharm: totals.Charm,
		Limit:      limit,
		Offset:     offset,
		Items:      out,
	}, nil
}
