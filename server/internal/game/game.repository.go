package game

import (
	"errors"
	"math"
	"sort"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/game/engine"
	"ola-chat-server/internal/game/games/thirteen"
	"ola-chat-server/internal/game/progression"
	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/user"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db    *gorm.DB
	users *user.CacheService
}

func NewRepository(db *gorm.DB, users *user.CacheService) *Repository {
	return &Repository{db: db, users: users}
}

func (r *Repository) GetUserInfo(gameID, userID string) (*protocol.UserInfoData, error) {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}

	u, err := r.users.GetUserCache(uid, true)
	if err != nil {
		return nil, err
	}

	info := &protocol.UserInfoData{
		ID:       userID,
		Username: u.Username,
		Ken:      u.Ken,
		MaxBet:   engine.MaxBet,
	}
	applyGameLevel(r.db, info, gameID, uid)

	if u.VipUsed != nil && u.VipEndTime != nil {
		left := time.Until(*u.VipEndTime)
		if left > 0 {
			info.VipType = u.VipUsed
			info.VipDays = int(math.Ceil(left.Hours() / 24))
		}
	}

	return info, nil
}

func (r *Repository) CurrentLevel(gameID, userID string) (int, bool) {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return 0, false
	}
	exp, err := gameExpFor(r.db, gameID, uid)
	if err != nil {
		return 0, false
	}
	return progression.LevelFromExp(exp), true
}

func gameExpFor(db *gorm.DB, gameID string, userID uuid.UUID) (int64, error) {
	var row models.UserGameLevel
	err := db.Where("user_id = ? AND game_id = ?", userID, gameID).Take(&row).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return 0, nil
	}
	if err != nil {
		return 0, err
	}
	return row.Exp, nil
}

func applyGameLevel(db *gorm.DB, info *protocol.UserInfoData, gameID string, userID uuid.UUID) {
	exp, err := gameExpFor(db, gameID, userID)
	if err != nil {
		exp = 0
	}
	info.Exp = exp
	info.Level = progression.LevelFromExp(exp)
}

const leaderboardLimit = 100
const matchHistoryLimit = 100

const (
	leaderboardPeriodDay   = "day"
	leaderboardPeriodWeek  = "week"
	leaderboardPeriodMonth = "month"
)

var gameGMT7 = time.FixedZone("GMT+7", 7*60*60)

type leaderboardRow struct {
	UserID     uuid.UUID  `gorm:"column:user_id"`
	Username   string     `gorm:"column:username"`
	VipType    *string    `gorm:"column:vip_type"`
	VipEndTime *time.Time `gorm:"column:vip_end_time"`
	Ken        int64      `gorm:"column:ken"`
	Wins       int64      `gorm:"column:wins"`
	Losses     int64      `gorm:"column:losses"`
	GameExp    int64      `gorm:"column:game_exp"`
}

type matchHistoryRow struct {
	GameMatchID   uuid.UUID  `gorm:"column:game_match_id"`
	MatchID       string     `gorm:"column:match_id"`
	PlayedAt      time.Time  `gorm:"column:played_at"`
	PlayerCount   int        `gorm:"column:player_count"`
	Player0ID     uuid.UUID  `gorm:"column:player0_id"`
	Player1ID     uuid.UUID  `gorm:"column:player1_id"`
	WinnerID      *uuid.UUID `gorm:"column:winner_id"`
	Player0Name   string     `gorm:"column:player0_name"`
	Player1Name   string     `gorm:"column:player1_name"`
	Player0Vip    *string    `gorm:"column:player0_vip"`
	Player1Vip    *string    `gorm:"column:player1_vip"`
	Player0VipEnd *time.Time `gorm:"column:player0_vip_end"`
	Player1VipEnd *time.Time `gorm:"column:player1_vip_end"`
	Bet           int        `gorm:"column:bet"`
	KenDelta      int        `gorm:"column:ken_delta"`
}

type matchSeatRow struct {
	GameMatchID uuid.UUID  `gorm:"column:game_match_id"`
	UserID      uuid.UUID  `gorm:"column:user_id"`
	Place       *int       `gorm:"column:place"`
	Username    string     `gorm:"column:username"`
	VipType     *string    `gorm:"column:vip_type"`
	VipEndTime  *time.Time `gorm:"column:vip_end_time"`
}

func normalizeLeaderboardPeriod(period string) string {
	switch period {
	case leaderboardPeriodWeek, leaderboardPeriodMonth:
		return period
	}
	return leaderboardPeriodDay
}

func leaderboardRangeAt(now time.Time, period string) (time.Time, time.Time) {
	localNow := now.In(gameGMT7)
	day := localNow
	switch normalizeLeaderboardPeriod(period) {
	case leaderboardPeriodWeek:
		daysFromMonday := (int(localNow.Weekday()) + 6) % 7
		day = localNow.AddDate(0, 0, -daysFromMonday)
	case leaderboardPeriodMonth:
		day = time.Date(localNow.Year(), localNow.Month(), 1, 0, 0, 0, 0, gameGMT7)
	}
	start := time.Date(day.Year(), day.Month(), day.Day(), 0, 0, 0, 0, gameGMT7)
	return start.UTC(), localNow.UTC()
}

func (r *Repository) Leaderboard(gameID, period string) (protocol.LeaderboardData, error) {
	period = normalizeLeaderboardPeriod(period)
	from, to := leaderboardRangeAt(time.Now(), period)
	data := protocol.LeaderboardData{
		Period: period,
		From:   from.UnixMilli(),
		To:     to.UnixMilli(),
		Items:  []protocol.LeaderboardEntry{},
	}

	var query *gorm.DB
	if gameID == thirteen.GameID {
		query = r.db.Table("game_matches").
			Select(`seats.user_id, users.username, users.vip_used AS vip_type, users.vip_end_time,
				COALESCE(SUM(CASE WHEN seats.user_id = game_matches.winner_id THEN game_matches.ken_delta ELSE 0 END), 0) AS ken,
				COUNT(*) FILTER (WHERE seats.user_id = game_matches.winner_id) AS wins,
				COUNT(*) FILTER (WHERE seats.user_id <> game_matches.winner_id) AS losses,
				COALESCE(levels.exp, 0) AS game_exp`).
			Joins("CROSS JOIN LATERAL "+constants.GameMatchSeatsSubquery+" AS seats").
			Joins("JOIN users ON users.id = seats.user_id").
			Joins("LEFT JOIN user_game_levels AS levels ON levels.user_id = seats.user_id AND levels.game_id = game_matches.game_id").
			Where(`game_matches.game_id = ? AND game_matches.status = ? AND game_matches.winner_id IS NOT NULL
				AND game_matches.finished_at >= ? AND game_matches.finished_at < ?
				AND game_matches.deleted_at IS NULL AND users.deleted_at IS NULL`,
				gameID, matchStatusFinished, from, to).
			Group("seats.user_id, users.username, users.vip_used, users.vip_end_time, levels.exp").
			Having("COUNT(*) FILTER (WHERE seats.user_id = game_matches.winner_id) > 0").
			Order("wins DESC, losses ASC, ken DESC, users.username ASC, seats.user_id ASC")
	} else if gameID == "caro" || gameID == "war-god" || gameID == "xiangqi" {
		query = r.db.Table("game_matches").
			Select(`results.user_id, users.username, users.vip_used AS vip_type, users.vip_end_time,
				COALESCE(SUM(results.ken), 0) AS ken,
				COALESCE(SUM(results.wins), 0) AS wins,
				COALESCE(SUM(results.losses), 0) AS losses,
				COALESCE(levels.exp, 0) AS game_exp`).
			Joins(`CROSS JOIN LATERAL (VALUES
				(game_matches.winner_id, 1, 0, game_matches.ken_delta),
				(game_matches.loser_id, 0, 1, 0)
			) AS results(user_id, wins, losses, ken)`).
			Joins("JOIN users ON users.id = results.user_id").
			Joins("LEFT JOIN user_game_levels AS levels ON levels.user_id = results.user_id AND levels.game_id = game_matches.game_id").
			Where(`game_matches.game_id = ? AND game_matches.status = ? AND game_matches.winner_id IS NOT NULL
				AND game_matches.finished_at >= ? AND game_matches.finished_at < ?
				AND game_matches.deleted_at IS NULL AND users.deleted_at IS NULL
				AND results.user_id IS NOT NULL`,
				gameID, matchStatusFinished, from, to).
			Group("results.user_id, users.username, users.vip_used, users.vip_end_time, levels.exp").
			Having("COALESCE(SUM(results.wins), 0) > 0").
			Order("wins DESC, losses ASC, ken DESC, users.username ASC, results.user_id ASC")
	} else {
		query = r.db.Table("game_matches").
			Select(`game_matches.winner_id AS user_id, users.username, users.vip_used AS vip_type,
				users.vip_end_time, COALESCE(SUM(game_matches.ken_delta), 0) AS ken,
				COALESCE(levels.exp, 0) AS game_exp`).
			Joins("JOIN users ON users.id = game_matches.winner_id").
			Joins("LEFT JOIN user_game_levels AS levels ON levels.user_id = game_matches.winner_id AND levels.game_id = game_matches.game_id").
			Where(`game_matches.game_id = ? AND game_matches.status = ? AND game_matches.winner_id IS NOT NULL
				AND game_matches.finished_at >= ? AND game_matches.finished_at < ?
				AND game_matches.deleted_at IS NULL AND users.deleted_at IS NULL`,
				gameID, matchStatusFinished, from, to).
			Group("game_matches.winner_id, users.username, users.vip_used, users.vip_end_time, levels.exp").
			Having("COALESCE(SUM(game_matches.ken_delta), 0) > 0").
			Order("ken DESC, COUNT(*) DESC, users.username ASC, game_matches.winner_id ASC")
	}

	var rows []leaderboardRow
	err := query.
		Limit(leaderboardLimit).
		Scan(&rows).Error
	if err != nil {
		return data, err
	}

	data.Items = make([]protocol.LeaderboardEntry, len(rows))
	for i, row := range rows {
		vipType := row.VipType
		if row.VipEndTime == nil || !row.VipEndTime.After(to) {
			vipType = nil
		}
		data.Items[i] = protocol.LeaderboardEntry{
			Rank:     i + 1,
			UserID:   row.UserID.String(),
			Username: row.Username,
			VipType:  vipType,
			Ken:      row.Ken,
			Wins:     row.Wins,
			Losses:   row.Losses,
			Level:    progression.LevelFromExp(row.GameExp),
		}
	}
	return data, nil
}

func activeVipType(vipType *string, vipEnd *time.Time) *string {
	if vipEnd == nil || !vipEnd.After(time.Now()) {
		return nil
	}
	return vipType
}

func (r *Repository) MatchHistory(gameID, userID string) (protocol.MatchHistoryData, error) {
	data := protocol.MatchHistoryData{Items: []protocol.MatchHistoryEntry{}}
	uid, err := uuid.Parse(userID)
	if err != nil {
		return data, err
	}

	var rows []matchHistoryRow
	err = r.db.Table("game_matches").
		Select(`game_matches.id AS game_match_id, game_matches.match_id, game_matches.finished_at AS played_at,
			game_matches.player_count, game_matches.player0_id, game_matches.player1_id, game_matches.winner_id,
			game_matches.bet, game_matches.ken_delta,
			player0.username AS player0_name, player1.username AS player1_name,
			player0.vip_used AS player0_vip, player0.vip_end_time AS player0_vip_end,
			player1.vip_used AS player1_vip, player1.vip_end_time AS player1_vip_end`).
		Joins("LEFT JOIN users AS player0 ON player0.id = game_matches.player0_id").
		Joins("LEFT JOIN users AS player1 ON player1.id = game_matches.player1_id").
		Where("game_matches.game_id = ? AND game_matches.status = ?", gameID, matchStatusFinished).
		Where(constants.GameMatchHasUserCondition, uid, uid, uid).
		Where("game_matches.finished_at IS NOT NULL AND game_matches.reason <> ? AND game_matches.deleted_at IS NULL", reasonVoid).
		Order("game_matches.finished_at DESC, game_matches.id DESC").
		Limit(matchHistoryLimit).
		Scan(&rows).Error
	if err != nil {
		return data, err
	}

	seats, err := r.matchSeats(rows)
	if err != nil {
		return data, err
	}

	data.Items = make([]protocol.MatchHistoryEntry, len(rows))
	for i, row := range rows {
		players := historyPlayers(row, seats[row.GameMatchID])
		entry := protocol.MatchHistoryEntry{
			ID:          row.MatchID,
			PlayedAt:    row.PlayedAt.UnixMilli(),
			Bet:         row.Bet,
			Outcome:     "draw",
			PlayerCount: max(row.PlayerCount, 2),
			Players:     players,
		}
		for _, p := range players {
			if p.UserID == userID {
				entry.Place = p.Place
				continue
			}
			if entry.OpponentID == "" {
				entry.OpponentID = p.UserID
				entry.OpponentName = p.Username
				entry.OpponentVipType = p.VipType
			}
		}
		if row.WinnerID != nil {
			if *row.WinnerID == uid {
				entry.Outcome = "win"
				entry.KenDelta = row.KenDelta
			} else {
				entry.Outcome = "lose"
				entry.KenDelta = -row.Bet
			}
		}
		data.Items[i] = entry
	}
	return data, nil
}

func (r *Repository) matchSeats(rows []matchHistoryRow) (map[uuid.UUID][]matchSeatRow, error) {
	ids := make([]uuid.UUID, 0, len(rows))
	for _, row := range rows {
		if row.PlayerCount > 2 {
			ids = append(ids, row.GameMatchID)
		}
	}
	if len(ids) == 0 {
		return nil, nil
	}
	var seats []matchSeatRow
	err := r.db.Table("game_match_players AS seats").
		Select(`seats.game_match_id, seats.user_id, seats.place,
			users.username, users.vip_used AS vip_type, users.vip_end_time`).
		Joins("LEFT JOIN users ON users.id = seats.user_id").
		Where("seats.game_match_id IN ?", ids).
		Order("seats.game_match_id ASC, seats.seat ASC").
		Scan(&seats).Error
	if err != nil {
		return nil, err
	}
	byMatch := make(map[uuid.UUID][]matchSeatRow, len(ids))
	for _, seat := range seats {
		byMatch[seat.GameMatchID] = append(byMatch[seat.GameMatchID], seat)
	}
	return byMatch, nil
}

func historyPlayers(row matchHistoryRow, seats []matchSeatRow) []protocol.MatchHistoryPlayer {
	if row.PlayerCount <= 2 || len(seats) == 0 {
		seats = []matchSeatRow{
			{UserID: row.Player0ID, Username: row.Player0Name, VipType: row.Player0Vip, VipEndTime: row.Player0VipEnd},
			{UserID: row.Player1ID, Username: row.Player1Name, VipType: row.Player1Vip, VipEndTime: row.Player1VipEnd},
		}
		if row.WinnerID != nil {
			for i := range seats {
				place := 2
				if seats[i].UserID == *row.WinnerID {
					place = 1
				}
				seats[i].Place = &place
			}
		}
	}
	players := make([]protocol.MatchHistoryPlayer, len(seats))
	for i, seat := range seats {
		place := 0
		if seat.Place != nil {
			place = *seat.Place
		} else if row.WinnerID != nil && *row.WinnerID == seat.UserID {
			place = 1
		}
		name := seat.Username
		if name == "" {
			name = seat.UserID.String()[:8]
		}
		players[i] = protocol.MatchHistoryPlayer{
			UserID:   seat.UserID.String(),
			Username: name,
			VipType:  activeVipType(seat.VipType, seat.VipEndTime),
			Place:    place,
		}
	}
	sort.SliceStable(players, func(i, j int) bool {
		return placeOrder(players[i].Place) < placeOrder(players[j].Place)
	})
	return players
}

func placeOrder(place int) int {
	if place <= 0 {
		return math.MaxInt
	}
	return place
}
