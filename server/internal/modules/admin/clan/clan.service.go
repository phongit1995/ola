package adminclan

import (
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Service struct {
	repo   *Repository
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, logger: logger.Named("[admin_clan_service]")}
}

func toClanUserResponse(user *models.User) *ClanUserResponse {
	if user == nil {
		return nil
	}
	return &ClanUserResponse{
		ID:       user.ID.String(),
		Username: user.Username,
		FullName: user.FullName,
		Avatar:   user.Avatar,
	}
}

func toClanResponse(clan *models.Clan) ClanResponse {
	resp := ClanResponse{
		ID:               clan.ID.String(),
		Handle:           clan.Handle,
		Description:      clan.Description,
		Avatar:           clan.Avatar,
		Cover:            clan.Cover,
		Policy:           int16(clan.Policy),
		MemberPublicPost: clan.MemberPublicPost,
		MemberCount:      clan.MemberCount,
		VisitCount:       clan.VisitCount,
		Owner:            toClanUserResponse(clan.Owner),
		CreatedAt:        clan.CreatedAt.UTC().Format(time.RFC3339),
	}
	if clan.RoomID != nil {
		resp.RoomID = clan.RoomID.String()
	}
	return resp
}

func (s *Service) List(query string, limit, offset int) (*ClanListResponse, error) {
	clans, total, err := s.repo.List(query, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]ClanResponse, 0, len(clans))
	for i := range clans {
		items = append(items, toClanResponse(&clans[i]))
	}
	return &ClanListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) Members(clanID uuid.UUID, limit, offset int) (*MemberListResponse, error) {
	if _, err := s.repo.GetByID(clanID); err != nil {
		return nil, err
	}
	members, total, err := s.repo.ListMembers(clanID, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]MemberResponse, 0, len(members))
	for i := range members {
		items = append(items, MemberResponse{
			User:     toClanUserResponse(members[i].User),
			Role:     string(members[i].Role),
			Verified: members[i].Verified,
			JoinedAt: members[i].CreatedAt.UTC().Format(time.RFC3339),
		})
	}
	return &MemberListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) Delete(clanID uuid.UUID) error {
	if _, err := s.repo.GetByID(clanID); err != nil {
		return err
	}
	return s.repo.SoftDelete(clanID)
}
