package game

import (
	"errors"
	"math"
	"time"

	"ola-chat-server/internal/game/engine"
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
	MatchID       string     `gorm:"column:match_id"`
	PlayedAt      time.Time  `gorm:"column:played_at"`
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

func normalizeLeaderboardPeriod(period string) string {
	if period == "week" {
		return "week"
	}
	return "day"
}

func leaderboardRangeAt(now time.Time, period string) (time.Time, time.Time) {
	localNow := now.In(gameGMT7)
	day := localNow
	if normalizeLeaderboardPeriod(period) == "week" {
		daysFromMonday := (int(localNow.Weekday()) + 6) % 7
		day = localNow.AddDate(0, 0, -daysFromMonday)
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
	if gameID == "caro" || gameID == "war-god" || gameID == "thirteen" || gameID == "xiangqi" {
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
		Select(`game_matches.match_id, game_matches.finished_at AS played_at,
			game_matches.player0_id, game_matches.player1_id, game_matches.winner_id,
			game_matches.bet, game_matches.ken_delta,
			player0.username AS player0_name, player1.username AS player1_name,
			player0.vip_used AS player0_vip, player0.vip_end_time AS player0_vip_end,
			player1.vip_used AS player1_vip, player1.vip_end_time AS player1_vip_end`).
		Joins("LEFT JOIN users AS player0 ON player0.id = game_matches.player0_id").
		Joins("LEFT JOIN users AS player1 ON player1.id = game_matches.player1_id").
		Where(`game_matches.game_id = ? AND game_matches.status = ?
			AND (game_matches.player0_id = ? OR game_matches.player1_id = ?)
			AND game_matches.finished_at IS NOT NULL AND game_matches.reason <> ?
			AND game_matches.deleted_at IS NULL`,
			gameID, matchStatusFinished, uid, uid, reasonVoid).
		Order("game_matches.finished_at DESC, game_matches.id DESC").
		Limit(matchHistoryLimit).
		Scan(&rows).Error
	if err != nil {
		return data, err
	}

	data.Items = make([]protocol.MatchHistoryEntry, len(rows))
	for i, row := range rows {
		opponentID := row.Player1ID
		opponentName := row.Player1Name
		opponentVip := activeVipType(row.Player1Vip, row.Player1VipEnd)
		if row.Player1ID == uid {
			opponentID = row.Player0ID
			opponentName = row.Player0Name
			opponentVip = activeVipType(row.Player0Vip, row.Player0VipEnd)
		}
		if opponentName == "" {
			opponentName = opponentID.String()[:8]
		}

		outcome := "draw"
		kenDelta := 0
		if row.WinnerID != nil {
			if *row.WinnerID == uid {
				outcome = "win"
				kenDelta = row.KenDelta
			} else {
				outcome = "lose"
				kenDelta = -row.Bet
			}
		}
		data.Items[i] = protocol.MatchHistoryEntry{
			ID:              row.MatchID,
			PlayedAt:        row.PlayedAt.UnixMilli(),
			OpponentID:      opponentID.String(),
			OpponentName:    opponentName,
			OpponentVipType: opponentVip,
			Bet:             row.Bet,
			Outcome:         outcome,
			KenDelta:        kenDelta,
		}
	}
	return data, nil
}
