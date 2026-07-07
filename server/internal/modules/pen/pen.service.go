package pen

import (
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrInsufficientKen = errors.New("insufficient ken balance")
	ErrShotNotFound    = errors.New("pen shot not found")
	ErrShotNotOpen     = errors.New("pen shot is no longer open")
	ErrCannotCatchOwn  = errors.New("you cannot catch your own pen")
	ErrNotYourShot     = errors.New("this pen is not yours")
)

type Service struct {
	repo      *Repository
	userCache *user.CacheService
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, userCache *user.CacheService, wsServer *websocket.Server, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		userCache: userCache,
		wsServer:  wsServer,
		logger:    logger.Named("[pen_service]"),
	}
}

func (s *Service) invalidateUser(userID uuid.UUID) {
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after pen change", "user_id", userID, "error", err.Error())
	}
}

func (s *Service) emitKenUpdate(userID uuid.UUID, ken int) {
	if s.wsServer == nil {
		return
	}
	payload := utils.WrapWebSocketMessage(constants.WebSocketEventKenUpdated, map[string]interface{}{
		"ken": ken,
	})
	s.wsServer.EmitToUser(userID.String(), constants.WebSocketMessageEvent, payload)
}

func (s *Service) emitPenSettled(userID uuid.UUID, data map[string]interface{}) {
	if s.wsServer == nil {
		return
	}
	payload := utils.WrapWebSocketMessage(constants.WebSocketEventPenSettled, data)
	s.wsServer.EmitToUser(userID.String(), constants.WebSocketMessageEvent, payload)
}

func (s *Service) CreateShot(userID uuid.UUID, req CreateShotRequest) (*CreateShotResponse, error) {
	if req.BetAmount < penMinBet || req.BetAmount > penMaxBet {
		return nil, fmt.Errorf("bet must be between %d and %d", penMinBet, penMaxBet)
	}

	shot, newKen, err := s.repo.CreateShot(userID, models.PenSide(req.Side), req.BetAmount)
	if err != nil {
		return nil, err
	}

	s.invalidateUser(userID)
	s.emitKenUpdate(userID, newKen)

	return &CreateShotResponse{
		Shot:       toShotView(shot, true),
		KenBalance: newKen,
	}, nil
}

func (s *Service) ListOpenShots(userID uuid.UUID, filter OpenFilter, limit, offset int) (*ShotListResponse, error) {
	items, total, err := s.repo.ListOpenShots(userID, filter, limit, offset)
	if err != nil {
		return nil, err
	}
	return buildList(items, total, limit, offset, false), nil
}

func (s *Service) ListMyOpenShots(userID uuid.UUID, limit, offset int) (*ShotListResponse, error) {
	items, total, err := s.repo.ListMyOpenShots(userID, limit, offset)
	if err != nil {
		return nil, err
	}
	return buildList(items, total, limit, offset, true), nil
}

func (s *Service) ListHistory(userID uuid.UUID, role, result string, limit, offset int) (*ShotListResponse, error) {
	items, total, err := s.repo.ListHistory(userID, role, result, limit, offset)
	if err != nil {
		return nil, err
	}
	return buildList(items, total, limit, offset, true), nil
}

func (s *Service) ListAllHistory(limit, offset int) (*ShotListResponse, error) {
	items, total, err := s.repo.ListAllSettled(limit, offset)
	if err != nil {
		return nil, err
	}
	return buildList(items, total, limit, offset, true), nil
}

func (s *Service) CatchShot(userID, shotID uuid.UUID, req CatchRequest) (*CatchResult, error) {
	shot, shooterKen, keeperKen, err := s.repo.CatchShot(userID, shotID, models.PenSide(req.Side), penCommissionPercent)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrShotNotFound
		}
		return nil, err
	}

	s.invalidateUser(shot.ShooterID)
	s.invalidateUser(userID)
	s.emitKenUpdate(shot.ShooterID, shooterKen)
	s.emitKenUpdate(userID, keeperKen)

	settled := map[string]interface{}{
		"shotId":      shot.ID.String(),
		"result":      string(*shot.Result),
		"winnerId":    shot.WinnerID.String(),
		"betAmount":   shot.BetAmount,
		"pot":         *shot.Pot,
		"commission":  *shot.Commission,
		"payout":      *shot.Payout,
		"shooterSide": string(shot.ShooterSide),
		"keeperSide":  string(*shot.KeeperSide),
	}
	s.emitPenSettled(shot.ShooterID, settled)
	s.emitPenSettled(userID, settled)

	return &CatchResult{
		ShotID:      shot.ID.String(),
		Result:      string(*shot.Result),
		Win:         *shot.WinnerID == userID,
		WinnerID:    shot.WinnerID.String(),
		BetAmount:   shot.BetAmount,
		Pot:         *shot.Pot,
		Commission:  *shot.Commission,
		Payout:      *shot.Payout,
		ShooterSide: string(shot.ShooterSide),
		KeeperSide:  string(*shot.KeeperSide),
		KenBalance:  keeperKen,
	}, nil
}

func (s *Service) CancelShot(userID, shotID uuid.UUID) (*CancelResponse, error) {
	shot, newKen, err := s.repo.CancelShot(userID, shotID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrShotNotFound
		}
		return nil, err
	}

	s.invalidateUser(userID)
	s.emitKenUpdate(userID, newKen)

	return &CancelResponse{
		ShotID:     shot.ID.String(),
		Status:     string(shot.Status),
		Refunded:   shot.BetAmount,
		KenBalance: newKen,
	}, nil
}

func (s *Service) ListAllShots(f AdminShotFilter, limit, offset int) (*ShotListResponse, error) {
	items, total, err := s.repo.ListAllShots(f, limit, offset)
	if err != nil {
		return nil, err
	}
	return buildList(items, total, limit, offset, true), nil
}

func (s *Service) Stats(f AdminShotFilter) (*PenStatsResponse, error) {
	overview, err := s.repo.StatsOverview(f)
	if err != nil {
		return nil, err
	}
	if overview.SettledShots > 0 {
		overview.KeeperWinRate = float64(overview.SavedCount) / float64(overview.SettledShots) * 100
	}

	byResult, err := s.repo.StatsByResult(f)
	if err != nil {
		return nil, err
	}
	for i := range byResult {
		if overview.SettledShots > 0 {
			byResult[i].Percent = float64(byResult[i].Count) / float64(overview.SettledShots) * 100
		}
	}

	byStatus, err := s.repo.StatsByStatus(f)
	if err != nil {
		return nil, err
	}
	for i := range byStatus {
		if overview.TotalShots > 0 {
			byStatus[i].Percent = float64(byStatus[i].Count) / float64(overview.TotalShots) * 100
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

	playerRows, err := s.repo.StatsTopPlayers(f, 10)
	if err != nil {
		return nil, err
	}
	players := make([]StatsPlayer, len(playerRows))
	for i, p := range playerRows {
		players[i] = StatsPlayer{
			User: UserBrief{
				ID:       p.UserID.String(),
				Username: p.Username,
				FullName: p.FullName,
				Avatar:   p.Avatar,
			},
			Shots:  p.Shots,
			Staked: p.Staked,
			Won:    p.Won,
		}
	}

	return &PenStatsResponse{
		Overview:   overview,
		ByResult:   byResult,
		ByStatus:   byStatus,
		Timeseries: timeseries,
		TopPlayers: players,
		Bucket:     bucket,
	}, nil
}

const leaderboardLimit = 20

var gmt7 = time.FixedZone("GMT+7", 7*60*60)

func leaderboardRange(period string) (time.Time, time.Time) {
	now := time.Now().In(gmt7)
	var start time.Time
	if period == "week" {
		daysFromMonday := (int(now.Weekday()) + 6) % 7
		day := now.AddDate(0, 0, -daysFromMonday)
		start = time.Date(day.Year(), day.Month(), day.Day(), 0, 0, 0, 0, gmt7)
	} else {
		start = time.Date(now.Year(), now.Month(), now.Day(), 0, 0, 0, 0, gmt7)
	}
	return start.UTC(), now.UTC()
}

func (s *Service) Leaderboard(period string) (*LeaderboardResponse, error) {
	from, to := leaderboardRange(period)
	rows, err := s.repo.Leaderboard(from, to, leaderboardLimit)
	if err != nil {
		return nil, err
	}
	items := make([]LeaderboardEntry, len(rows))
	for i, row := range rows {
		items[i] = LeaderboardEntry{
			Rank: i + 1,
			User: UserBrief{
				ID:         row.UserID.String(),
				Username:   row.Username,
				FullName:   row.FullName,
				Avatar:     row.Avatar,
				VipUsed:    row.VipUsed,
				VipEndTime: formatOptionalTime(row.VipEndTime),
			},
			Profit: row.Profit,
			Plays:  row.Plays,
			Wins:   row.Wins,
		}
	}
	return &LeaderboardResponse{
		Period: period,
		From:   from.Format(time.RFC3339),
		To:     to.Format(time.RFC3339),
		Items:  items,
	}, nil
}

func buildList(items []models.PenShot, total int64, limit, offset int, reveal bool) *ShotListResponse {
	views := make([]ShotView, len(items))
	for i := range items {
		views[i] = toShotView(&items[i], reveal)
	}
	return &ShotListResponse{Total: total, Limit: limit, Offset: offset, Items: views}
}

func toBrief(u *models.User) *UserBrief {
	return &UserBrief{
		ID:         u.ID.String(),
		Username:   u.Username,
		FullName:   u.FullName,
		Avatar:     u.Avatar,
		VipUsed:    u.VipUsed,
		VipEndTime: formatOptionalTime(u.VipEndTime),
	}
}

func formatOptionalTime(t *time.Time) *string {
	if t == nil {
		return nil
	}
	formatted := t.Format(time.RFC3339)
	return &formatted
}

func toShotView(s *models.PenShot, reveal bool) ShotView {
	v := ShotView{
		ID:        s.ID.String(),
		BetAmount: s.BetAmount,
		Status:    string(s.Status),
		CreatedAt: s.CreatedAt.Format(time.RFC3339),
	}
	if s.Shooter != nil {
		v.Shooter = toBrief(s.Shooter)
	}
	if s.Keeper != nil {
		v.Keeper = toBrief(s.Keeper)
	}
	if reveal {
		v.ShooterSide = string(s.ShooterSide)
	}
	if s.KeeperSide != nil {
		v.KeeperSide = string(*s.KeeperSide)
	}
	if s.Result != nil {
		v.Result = string(*s.Result)
	}
	if s.WinnerID != nil {
		v.WinnerID = s.WinnerID.String()
	}
	v.Pot = s.Pot
	v.Commission = s.Commission
	v.Payout = s.Payout
	if s.SettledAt != nil {
		v.SettledAt = s.SettledAt.Format(time.RFC3339)
	}
	if s.CancelledAt != nil {
		v.CancelledAt = s.CancelledAt.Format(time.RFC3339)
	}
	return v
}
