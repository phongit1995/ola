package adminrelationship

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
	rel, err := s.repo.RelationshipStats(f)
	if err != nil {
		return nil, err
	}
	follows, err := s.repo.FollowCount(f)
	if err != nil {
		return nil, err
	}
	return &StatsResponse{
		Relationships: RelationshipStats{
			Total:    rel.Total,
			Pending:  rel.Pending,
			Accepted: rel.Accepted,
			Rejected: rel.Rejected,
			Blocked:  rel.Blocked,
		},
		Follows: FollowStats{Total: follows},
	}, nil
}

func (s *Service) ListRelationships(f ListFilter, limit, offset int) (*RelationshipListResponse, error) {
	rows, total, err := s.repo.ListRelationships(f, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]RelationshipItem, len(rows))
	for i, row := range rows {
		item := RelationshipItem{
			ID:        row.ID.String(),
			Requester: userInfo(row.RequesterID, row.RequesterUsername, row.RequesterFullName, row.RequesterAvatar),
			Addressee: userInfo(row.AddresseeID, row.AddresseeUsername, row.AddresseeFullName, row.AddresseeAvatar),
			Status:    row.Status,
			CreatedAt: row.CreatedAt.UTC().Format(time.RFC3339),
		}
		if row.ActionedAt != nil {
			item.ActionedAt = row.ActionedAt.UTC().Format(time.RFC3339)
		}
		items[i] = item
	}
	return &RelationshipListResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}

func (s *Service) ListFollows(f FollowFilter, limit, offset int) (*FollowListResponse, error) {
	rows, total, err := s.repo.ListFollows(f, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]FollowItem, len(rows))
	for i, row := range rows {
		items[i] = FollowItem{
			ID:        row.ID.String(),
			Follower:  userInfo(row.FollowerID, row.FollowerUsername, row.FollowerFullName, row.FollowerAvatar),
			Followee:  userInfo(row.FolloweeID, row.FolloweeUsername, row.FolloweeFullName, row.FolloweeAvatar),
			CreatedAt: row.CreatedAt.UTC().Format(time.RFC3339),
		}
	}
	return &FollowListResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}

func (s *Service) UserStats(f UserStatsFilter, sortBy string, limit, offset int) (*UserStatsResponse, error) {
	rows, total, err := s.repo.UserStats(f, sortBy, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]UserStatsItem, len(rows))
	for i, row := range rows {
		items[i] = UserStatsItem{
			User:      userInfo(row.UserID, row.Username, row.FullName, row.Avatar),
			Friends:   row.Friends,
			Blocked:   row.Blocked,
			Followers: row.Followers,
			Following: row.Following,
		}
	}
	return &UserStatsResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}
