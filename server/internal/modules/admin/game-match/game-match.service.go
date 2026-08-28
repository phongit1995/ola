package admingamematch

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

func formatTime(t time.Time) string {
	return t.UTC().Format(time.RFC3339)
}

func briefFromRow(id uuid.UUID, username, fullName, avatar string) *UserBrief {
	if username == "" {
		return &UserBrief{ID: id.String(), Username: id.String()[:8]}
	}
	return &UserBrief{ID: id.String(), Username: username, FullName: fullName, Avatar: avatar}
}

func matchView(row matchRow) MatchView {
	view := MatchView{
		ID:        row.ID.String(),
		MatchID:   row.MatchID,
		GameID:    row.GameID,
		Player0:   briefFromRow(row.Player0ID, row.Player0Username, row.Player0FullName, row.Player0Avatar),
		Player1:   briefFromRow(row.Player1ID, row.Player1Username, row.Player1FullName, row.Player1Avatar),
		Status:    row.Status,
		Reason:    row.Reason,
		Mode:      row.Mode,
		Bet:       row.Bet,
		KenDelta:  row.KenDelta,
		MoveCount: row.MoveCount,
		StartedAt: formatTime(row.StartedAt),
	}
	if row.WinnerID != nil {
		view.WinnerID = row.WinnerID.String()
		if row.Status == "finished" {
			view.HouseTake = row.Bet - row.KenDelta
		}
	}
	if row.FinishedAt != nil {
		view.FinishedAt = formatTime(*row.FinishedAt)
	}
	return view
}

func (s *Service) ListMatches(f AdminMatchFilter, limit, offset int) (*MatchListResponse, error) {
	rows, total, err := s.repo.ListMatches(f, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]MatchView, len(rows))
	for i, row := range rows {
		items[i] = matchView(row)
	}
	return &MatchListResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}

func statsPlayers(rows []playerAggRow) []StatsPlayer {
	players := make([]StatsPlayer, len(rows))
	for i, row := range rows {
		p := StatsPlayer{
			User:    *briefFromRow(row.UserID, row.Username, row.FullName, row.Avatar),
			Matches: row.Matches,
			Wins:    row.Wins,
			Losses:  row.Losses,
			Staked:  row.Staked,
			NetKen:  row.NetKen,
		}
		if row.Matches > 0 {
			p.WinRate = float64(row.Wins) / float64(row.Matches) * 100
		}
		players[i] = p
	}
	return players
}

func (s *Service) Stats(f AdminMatchFilter) (*MatchStatsResponse, error) {
	overview, err := s.repo.StatsOverview(f)
	if err != nil {
		return nil, err
	}
	overview.TotalPayout = overview.TotalVolume - overview.HouseTake

	overview.UniquePlayers, err = s.repo.UniquePlayers(f)
	if err != nil {
		return nil, err
	}

	byGame, err := s.repo.StatsByGame(f)
	if err != nil {
		return nil, err
	}

	byReason, err := s.repo.StatsByReason(f)
	if err != nil {
		return nil, err
	}
	for i := range byReason {
		if overview.FinishedMatches > 0 {
			byReason[i].Percent = float64(byReason[i].Count) / float64(overview.FinishedMatches) * 100
		}
	}

	bucket := "day"
	if f.From != nil && f.To != nil && f.To.Sub(*f.From) > 90*24*time.Hour {
		bucket = "month"
	}
	timeseries, err := s.repo.StatsTimeseries(f, bucket)
	if err != nil {
		return nil, err
	}

	playerRows, err := s.repo.PlayerAggregates(f, 1, 10)
	if err != nil {
		return nil, err
	}

	return &MatchStatsResponse{
		Overview:   overview,
		ByGame:     byGame,
		ByReason:   byReason,
		Timeseries: timeseries,
		TopPlayers: statsPlayers(playerRows),
		Bucket:     bucket,
	}, nil
}

const suspectLimit = 20

func (s *Service) Suspects(f AdminMatchFilter, minMatches, minPairMatches int) (*SuspectsResponse, error) {
	playerRows, err := s.repo.PlayerAggregates(f, minMatches, suspectLimit)
	if err != nil {
		return nil, err
	}

	pairRows, err := s.repo.PairAggregates(f, minPairMatches, suspectLimit)
	if err != nil {
		return nil, err
	}

	ids := make([]uuid.UUID, 0, len(pairRows)*2)
	for _, row := range pairRows {
		ids = append(ids, row.AID, row.BID)
	}
	briefs, err := s.repo.UserBriefs(ids)
	if err != nil {
		return nil, err
	}

	pairs := make([]SuspectPair, len(pairRows))
	for i, row := range pairRows {
		a := briefs[row.AID]
		b := briefs[row.BID]
		pair := SuspectPair{
			UserA:    *briefFromRow(row.AID, a.Username, a.FullName, a.Avatar),
			UserB:    *briefFromRow(row.BID, b.Username, b.FullName, b.Avatar),
			Matches:  row.Matches,
			Decided:  row.Decided,
			AWins:    row.AWins,
			BWins:    row.BWins,
			TotalBet: row.TotalBet,
			NetA:     row.ANet,
		}
		if row.Decided > 0 {
			top := row.AWins
			if row.BWins > top {
				top = row.BWins
			}
			pair.OneSidedRate = float64(top) / float64(row.Decided) * 100
		}
		pairs[i] = pair
	}

	return &SuspectsResponse{
		MinMatches:     minMatches,
		MinPairMatches: minPairMatches,
		Players:        statsPlayers(playerRows),
		Pairs:          pairs,
	}, nil
}

func (s *Service) ListLevels(f AdminLevelFilter, limit, offset int) (*LevelListResponse, error) {
	rows, total, err := s.repo.ListLevels(f, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]LevelView, len(rows))
	for i, row := range rows {
		items[i] = LevelView{
			User:      *briefFromRow(row.UserID, row.Username, row.FullName, row.Avatar),
			GameID:    row.GameID,
			Level:     row.Level,
			Exp:       row.Exp,
			UpdatedAt: formatTime(row.UpdatedAt),
		}
	}
	return &LevelListResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}
