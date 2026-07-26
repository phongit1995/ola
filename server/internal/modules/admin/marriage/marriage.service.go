package adminmarriage

import (
	"time"

	"github.com/google/uuid"
)

type Service struct {
	repo *Repository
}

func NewService(repo *Repository) *Service {
	return &Service{repo: repo}
}

func userInfo(id uuid.UUID, username, fullName, avatar string) UserInfo {
	if username == "" {
		return UserInfo{ID: id.String(), Username: id.String()[:8]}
	}
	return UserInfo{ID: id.String(), Username: username, FullName: fullName, Avatar: avatar}
}

func (s *Service) GetStats(f StatsFilter) (*StatsResponse, error) {
	proposals, err := s.repo.ProposalStats(f)
	if err != nil {
		return nil, err
	}
	marriages, err := s.repo.MarriageStats(f)
	if err != nil {
		return nil, err
	}
	return &StatsResponse{
		Proposals: ProposalStats{
			Total:     proposals.Total,
			Pending:   proposals.Pending,
			Accepted:  proposals.Accepted,
			Rejected:  proposals.Rejected,
			Cancelled: proposals.Cancelled,
		},
		Marriages: MarriageStats{
			Total:    marriages.Total,
			Active:   marriages.Active,
			Divorced: marriages.Divorced,
		},
	}, nil
}

func (s *Service) ListMarriages(f ListFilter, limit, offset int) (*MarriageListResponse, error) {
	rows, total, err := s.repo.ListMarriages(f, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]MarriageItem, len(rows))
	for i, row := range rows {
		item := MarriageItem{
			ID:        row.ID.String(),
			UserA:     userInfo(row.UserLowID, row.LowUsername, row.LowFullName, row.LowAvatar),
			UserB:     userInfo(row.UserHighID, row.HighUsername, row.HighFullName, row.HighAvatar),
			Status:    row.Status,
			MarriedAt: row.MarriedAt.UTC().Format(time.RFC3339),
		}
		if row.DivorcedAt != nil {
			item.DivorcedAt = row.DivorcedAt.UTC().Format(time.RFC3339)
		}
		if row.DivorcedBy != nil {
			item.DivorcedBy = row.DivorcedBy.String()
		}
		items[i] = item
	}
	return &MarriageListResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}

func (s *Service) ListProposals(f ListFilter, limit, offset int) (*ProposalListResponse, error) {
	rows, total, err := s.repo.ListProposals(f, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]ProposalItem, len(rows))
	for i, row := range rows {
		item := ProposalItem{
			ID:        row.ID.String(),
			Proposer:  userInfo(row.ProposerID, row.ProposerUsername, row.ProposerFullName, row.ProposerAvatar),
			Addressee: userInfo(row.AddresseeID, row.AddresseeUsername, row.AddresseeFullName, row.AddresseeAvatar),
			Message:   row.Message,
			Status:    row.Status,
			CreatedAt: row.CreatedAt.UTC().Format(time.RFC3339),
		}
		if row.RespondedAt != nil {
			item.RespondedAt = row.RespondedAt.UTC().Format(time.RFC3339)
		}
		items[i] = item
	}
	return &ProposalListResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}
