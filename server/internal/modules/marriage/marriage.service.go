package marriage

import (
	"errors"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/notification"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/user"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrUserNotFound       = apperr.ErrUserNotFound
	ErrCannotProposeSelf  = errors.New("cannot propose to yourself")
	ErrTargetInactive     = errors.New("target user is not available")
	ErrAlreadyMarried     = errors.New("you are already married")
	ErrTargetMarried      = errors.New("target user is already married")
	ErrBlocked            = errors.New("cannot propose to a blocked user")
	ErrProposalExists     = errors.New("a pending proposal already exists")
	ErrProposalNotFound   = errors.New("marriage proposal not found")
	ErrProposalNotPending = errors.New("marriage proposal is no longer pending")
	ErrNotYourProposal    = errors.New("marriage proposal does not belong to you")
	ErrNotMarried         = errors.New("you are not married")
)

type Service struct {
	repo      *Repository
	relRepo   *relationships.Repository
	userCache *user.CacheService
	notifSvc  *notification.Service
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, relRepo *relationships.Repository, userCache *user.CacheService, notifSvc *notification.Service, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		relRepo:   relRepo,
		userCache: userCache,
		notifSvc:  notifSvc,
		logger:    logger.Named("[marriage_service]"),
	}
}

func (s *Service) invalidate(userID uuid.UUID) {
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after marriage change", "user_id", userID, "error", err.Error())
	}
}

func (s *Service) Propose(proposerID uuid.UUID, req ProposeRequest) (*ProposeResponse, error) {
	proposer, err := s.repo.FindUserByID(proposerID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrUserNotFound
		}
		return nil, err
	}
	if proposer.SpouseID != nil {
		return nil, ErrAlreadyMarried
	}

	addresseeID, err := uuid.Parse(req.AddresseeID)
	if err != nil {
		return nil, ErrUserNotFound
	}
	if addresseeID == proposerID {
		return nil, ErrCannotProposeSelf
	}

	addressee, err := s.repo.FindUserByID(addresseeID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrUserNotFound
		}
		return nil, err
	}
	if !addressee.IsActive {
		return nil, ErrTargetInactive
	}
	if addressee.SpouseID != nil {
		return nil, ErrTargetMarried
	}

	blockedByMe, err := s.relRepo.IsBlocked(proposerID, addresseeID)
	if err != nil {
		return nil, err
	}
	blockedByThem, err := s.relRepo.IsBlocked(addresseeID, proposerID)
	if err != nil {
		return nil, err
	}
	if blockedByMe || blockedByThem {
		return nil, ErrBlocked
	}

	exists, err := s.repo.ExistsPending(proposerID, addressee.ID)
	if err != nil {
		return nil, err
	}
	if exists {
		return nil, ErrProposalExists
	}

	p := &models.MarriageProposal{
		ProposerID:  proposerID,
		AddresseeID: addressee.ID,
		Message:     req.Message,
		Status:      models.MarriageProposalPending,
	}
	if err := s.repo.CreateProposal(p); err != nil {
		return nil, err
	}

	s.notifSvc.Create(addressee.ID, &proposerID, models.AppNotificationMarriageProposal, &p.ID, notification.Excerpt(req.Message))

	return &ProposeResponse{
		ProposalID:        p.ID.String(),
		AddresseeUsername: addressee.Username,
		Status:            p.Status,
	}, nil
}

func (s *Service) ListProposals(userID uuid.UUID, direction string, limit, offset int) (*ProposalListResponse, error) {
	outgoing := direction == "outgoing"
	items, total, err := s.repo.ListProposals(userID, outgoing, limit, offset)
	if err != nil {
		return nil, err
	}
	out := make([]ProposalItem, 0, len(items))
	for i := range items {
		out = append(out, toProposalItem(&items[i]))
	}
	return &ProposalListResponse{Total: int(total), Limit: limit, Offset: offset, Items: out}, nil
}

func (s *Service) Accept(userID, proposalID uuid.UUID) (*MarriageStatusResponse, error) {
	proposer, addressee, marriedAt, err := s.repo.Accept(proposalID, userID, time.Now())
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrProposalNotFound
		}
		return nil, err
	}

	s.invalidate(proposer.ID)
	s.invalidate(addressee.ID)
	s.notifSvc.Remove(userID, models.AppNotificationMarriageProposal, proposalID)

	return statusFromUser(addressee, &marriedAt), nil
}

func (s *Service) Reject(userID, proposalID uuid.UUID) error {
	p, err := s.repo.FindProposal(proposalID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrProposalNotFound
		}
		return err
	}
	if p.AddresseeID != userID {
		return ErrNotYourProposal
	}
	if p.Status != models.MarriageProposalPending {
		return ErrProposalNotPending
	}
	if err := s.repo.SetProposalStatus(proposalID, models.MarriageProposalRejected, time.Now()); err != nil {
		return err
	}
	s.notifSvc.Remove(userID, models.AppNotificationMarriageProposal, proposalID)
	return nil
}

func (s *Service) Cancel(userID, proposalID uuid.UUID) error {
	p, err := s.repo.FindProposal(proposalID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrProposalNotFound
		}
		return err
	}
	if p.ProposerID != userID {
		return ErrNotYourProposal
	}
	if p.Status != models.MarriageProposalPending {
		return ErrProposalNotPending
	}
	if err := s.repo.SetProposalStatus(proposalID, models.MarriageProposalCancelled, time.Now()); err != nil {
		return err
	}
	s.notifSvc.Remove(p.AddresseeID, models.AppNotificationMarriageProposal, proposalID)
	return nil
}

func (s *Service) GetStatus(userID uuid.UUID) (*MarriageStatusResponse, error) {
	u, err := s.repo.FindUserWithSpouse(userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrUserNotFound
		}
		return nil, err
	}

	var marriedAt *time.Time
	if u.SpouseID != nil {
		if m, mErr := s.repo.GetActiveMarriage(userID); mErr == nil && m != nil {
			marriedAt = &m.MarriedAt
		}
	}
	return statusFromUser(u, marriedAt), nil
}

func (s *Service) Divorce(userID uuid.UUID) error {
	spouseID, err := s.repo.Divorce(userID, time.Now())
	if err != nil {
		return err
	}
	s.invalidate(userID)
	s.invalidate(spouseID)
	return nil
}

func statusFromUser(u *models.User, marriedAt *time.Time) *MarriageStatusResponse {
	resp := &MarriageStatusResponse{}
	if u.SpouseID != nil && u.Spouse != nil {
		resp.Spouse = toSpouseInfo(u.Spouse)
	}
	if marriedAt != nil {
		resp.MarriedAt = marriedAt.Format(time.RFC3339)
	}
	return resp
}

func toSpouseInfo(u *models.User) *SpouseInfo {
	return &SpouseInfo{
		ID:       u.ID.String(),
		Username: u.Username,
		FullName: u.FullName,
		Avatar:   u.Avatar,
	}
}

func toBrief(u *models.User) *UserBrief {
	return &UserBrief{
		ID:       u.ID.String(),
		Username: u.Username,
		FullName: u.FullName,
		Avatar:   u.Avatar,
	}
}

func toProposalItem(p *models.MarriageProposal) ProposalItem {
	item := ProposalItem{
		ID:        p.ID.String(),
		Status:    p.Status,
		Message:   p.Message,
		CreatedAt: p.CreatedAt.Format(time.RFC3339),
	}
	if p.Proposer != nil {
		item.Proposer = toBrief(p.Proposer)
	}
	if p.Addressee != nil {
		item.Addressee = toBrief(p.Addressee)
	}
	if p.RespondedAt != nil {
		item.RespondedAt = p.RespondedAt.Format(time.RFC3339)
	}
	return item
}
