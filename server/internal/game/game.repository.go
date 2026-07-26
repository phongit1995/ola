package game

import (
	"math"
	"time"

	"ola-chat-server/internal/game/protocol"
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

func (r *Repository) GetUserInfo(userID string) (*protocol.UserInfoData, error) {
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
	}

	if u.VipUsed != nil && u.VipEndTime != nil {
		left := time.Until(*u.VipEndTime)
		if left > 0 {
			info.VipType = u.VipUsed
			info.VipDays = int(math.Ceil(left.Hours() / 24))
		}
	}

	return info, nil
}

const leaderboardLimit = 100

var gameGMT7 = time.FixedZone("GMT+7", 7*60*60)

type leaderboardRow struct {
	UserID     uuid.UUID  `gorm:"column:user_id"`
	Username   string     `gorm:"column:username"`
	VipType    *string    `gorm:"column:vip_type"`
	VipEndTime *time.Time `gorm:"column:vip_end_time"`
	Ken        int64      `gorm:"column:ken"`
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

	var rows []leaderboardRow
	err := r.db.Table("game_matches").
		Select(`game_matches.winner_id AS user_id, users.username, users.vip_used AS vip_type,
			users.vip_end_time, COALESCE(SUM(game_matches.ken_delta), 0) AS ken`).
		Joins("JOIN users ON users.id = game_matches.winner_id").
		Where(`game_matches.game_id = ? AND game_matches.status = ? AND game_matches.winner_id IS NOT NULL
			AND game_matches.finished_at >= ? AND game_matches.finished_at < ?
			AND game_matches.deleted_at IS NULL AND users.deleted_at IS NULL`,
			gameID, matchStatusFinished, from, to).
		Group("game_matches.winner_id, users.username, users.vip_used, users.vip_end_time").
		Having("COALESCE(SUM(game_matches.ken_delta), 0) > 0").
		Order("ken DESC, COUNT(*) DESC, users.username ASC, game_matches.winner_id ASC").
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
		}
	}
	return data, nil
}
