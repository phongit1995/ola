package admingamematch

import (
	"fmt"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func matchScope(f AdminMatchFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		db = db.Where("game_matches.deleted_at IS NULL")
		if f.GameID != "" {
			db = db.Where("game_matches.game_id = ?", f.GameID)
		}
		if f.UserID != nil {
			db = db.Where("(game_matches.player0_id = ? OR game_matches.player1_id = ?)", *f.UserID, *f.UserID)
		}
		if f.WinnerID != nil {
			db = db.Where("game_matches.winner_id = ?", *f.WinnerID)
		}
		if f.Status != "" {
			db = db.Where("game_matches.status = ?", f.Status)
		}
		if f.Reason != "" {
			db = db.Where("game_matches.reason = ?", f.Reason)
		}
		if f.Mode != "" {
			db = db.Where("game_matches.mode = ?", f.Mode)
		}
		if f.MinBet != nil {
			db = db.Where("game_matches.bet >= ?", *f.MinBet)
		}
		if f.MaxBet != nil {
			db = db.Where("game_matches.bet <= ?", *f.MaxBet)
		}
		if f.From != nil {
			db = db.Where("game_matches.started_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("game_matches.started_at <= ?", *f.To)
		}
		return db
	}
}

type matchRow struct {
	ID              uuid.UUID  `gorm:"column:id"`
	MatchID         string     `gorm:"column:match_id"`
	GameID          string     `gorm:"column:game_id"`
	Player0ID       uuid.UUID  `gorm:"column:player0_id"`
	Player1ID       uuid.UUID  `gorm:"column:player1_id"`
	WinnerID        *uuid.UUID `gorm:"column:winner_id"`
	Status          string     `gorm:"column:status"`
	Reason          string     `gorm:"column:reason"`
	Mode            string     `gorm:"column:mode"`
	Bet             int        `gorm:"column:bet"`
	KenDelta        int        `gorm:"column:ken_delta"`
	MoveCount       int        `gorm:"column:move_count"`
	StartedAt       time.Time  `gorm:"column:started_at"`
	FinishedAt      *time.Time `gorm:"column:finished_at"`
	Player0Username string     `gorm:"column:player0_username"`
	Player0FullName string     `gorm:"column:player0_full_name"`
	Player0Avatar   string     `gorm:"column:player0_avatar"`
	Player1Username string     `gorm:"column:player1_username"`
	Player1FullName string     `gorm:"column:player1_full_name"`
	Player1Avatar   string     `gorm:"column:player1_avatar"`
}

func (r *Repository) ListMatches(f AdminMatchFilter, limit, offset int) ([]matchRow, int64, error) {
	var total int64
	if err := r.db.Table("game_matches").Scopes(matchScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []matchRow
	err := r.db.Table("game_matches").
		Select(`game_matches.id, game_matches.match_id, game_matches.game_id,
			game_matches.player0_id, game_matches.player1_id, game_matches.winner_id,
			game_matches.status, game_matches.reason, game_matches.mode, game_matches.bet,
			game_matches.ken_delta, game_matches.move_count, game_matches.started_at, game_matches.finished_at,
			player0.username AS player0_username, player0.full_name AS player0_full_name, player0.avatar AS player0_avatar,
			player1.username AS player1_username, player1.full_name AS player1_full_name, player1.avatar AS player1_avatar`).
		Joins("LEFT JOIN users AS player0 ON player0.id = game_matches.player0_id").
		Joins("LEFT JOIN users AS player1 ON player1.id = game_matches.player1_id").
		Scopes(matchScope(f)).
		Order("game_matches.started_at DESC, game_matches.id DESC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}

func (r *Repository) StatsOverview(f AdminMatchFilter) (StatsOverview, error) {
	var o StatsOverview
	err := r.db.Table("game_matches").Scopes(matchScope(f)).
		Select(`count(*) as total_matches,
			count(*) filter (where status = 'playing') as playing_matches,
			count(*) filter (where status = 'finished') as finished_matches,
			count(*) filter (where winner_id is not null) as decided_matches,
			count(*) filter (where status = 'finished' and winner_id is null and reason <> 'void') as draw_matches,
			count(*) filter (where reason = 'void') as void_matches,
			coalesce(sum(bet * 2) filter (where status = 'finished'), 0) as total_volume,
			coalesce(sum(bet - ken_delta) filter (where status = 'finished' and winner_id is not null), 0) as house_take`).
		Scan(&o).Error
	return o, err
}

func (r *Repository) UniquePlayers(f AdminMatchFilter) (int64, error) {
	sub0 := r.db.Table("game_matches").Select("game_matches.player0_id AS uid").Scopes(matchScope(f))
	sub1 := r.db.Table("game_matches").Select("game_matches.player1_id AS uid").Scopes(matchScope(f))

	var count int64
	err := r.db.Table("(? UNION ?) AS t", sub0, sub1).Count(&count).Error
	return count, err
}

func (r *Repository) StatsByGame(f AdminMatchFilter) ([]StatsGameRow, error) {
	var rows []StatsGameRow
	err := r.db.Table("game_matches").Scopes(matchScope(f)).
		Select(`game_id, count(*) as matches,
			count(*) filter (where status = 'finished') as finished,
			coalesce(sum(bet * 2) filter (where status = 'finished'), 0) as volume,
			coalesce(sum(bet - ken_delta) filter (where status = 'finished' and winner_id is not null), 0) as house_take`).
		Group("game_id").
		Order("matches DESC").
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) StatsByReason(f AdminMatchFilter) ([]StatsReasonRow, error) {
	var rows []StatsReasonRow
	err := r.db.Table("game_matches").Scopes(matchScope(f)).
		Where("game_matches.status = 'finished'").
		Select("reason, count(*) as count").
		Group("reason").
		Order("count DESC").
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) StatsTimeseries(f AdminMatchFilter, bucket string) ([]StatsTimePoint, error) {
	trunc, format := "day", "YYYY-MM-DD"
	if bucket == "month" {
		trunc, format = "month", "YYYY-MM"
	}
	var rows []StatsTimePoint
	err := r.db.Table("game_matches").Scopes(matchScope(f)).
		Select(fmt.Sprintf(`to_char(date_trunc('%s', started_at), '%s') as date,
			count(*) as matches,
			count(*) filter (where status = 'finished') as finished,
			coalesce(sum(bet * 2) filter (where status = 'finished'), 0) as volume,
			coalesce(sum(bet - ken_delta) filter (where status = 'finished' and winner_id is not null), 0) as house_take`, trunc, format)).
		Group(fmt.Sprintf("date_trunc('%s', started_at)", trunc)).
		Order(fmt.Sprintf("date_trunc('%s', started_at) ASC", trunc)).
		Scan(&rows).Error
	return rows, err
}

type playerAggRow struct {
	UserID   uuid.UUID `gorm:"column:user_id"`
	Username string    `gorm:"column:username"`
	FullName string    `gorm:"column:full_name"`
	Avatar   string    `gorm:"column:avatar"`
	Matches  int64     `gorm:"column:matches"`
	Wins     int64     `gorm:"column:wins"`
	Losses   int64     `gorm:"column:losses"`
	Staked   int64     `gorm:"column:staked"`
	NetKen   int64     `gorm:"column:net_ken"`
}

func (r *Repository) playerSideQuery(f AdminMatchFilter, side string) *gorm.DB {
	return r.db.Table("game_matches").
		Select(fmt.Sprintf(`game_matches.%[1]s AS uid,
			CASE WHEN game_matches.winner_id = game_matches.%[1]s THEN 1 ELSE 0 END AS won,
			CASE WHEN game_matches.loser_id = game_matches.%[1]s THEN 1 ELSE 0 END AS lost,
			CASE WHEN game_matches.winner_id = game_matches.%[1]s THEN game_matches.ken_delta
				WHEN game_matches.loser_id = game_matches.%[1]s THEN -game_matches.bet
				ELSE 0 END AS net,
			game_matches.bet AS staked`, side)).
		Scopes(matchScope(f)).
		Where("game_matches.status = 'finished' AND game_matches.bet > 0")
}

func (r *Repository) PlayerAggregates(f AdminMatchFilter, minMatches, limit int) ([]playerAggRow, error) {
	sub0 := r.playerSideQuery(f, "player0_id")
	sub1 := r.playerSideQuery(f, "player1_id")

	var rows []playerAggRow
	err := r.db.Table("(? UNION ALL ?) AS t", sub0, sub1).
		Select(`t.uid AS user_id, users.username, users.full_name, users.avatar,
			count(*) as matches, sum(t.won) as wins, sum(t.lost) as losses,
			coalesce(sum(t.staked), 0) as staked, coalesce(sum(t.net), 0) as net_ken`).
		Joins("JOIN users ON users.id = t.uid").
		Group("t.uid, users.username, users.full_name, users.avatar").
		Having("count(*) >= ?", minMatches).
		Order("net_ken DESC").
		Limit(limit).
		Scan(&rows).Error
	return rows, err
}

type pairAggRow struct {
	AID      uuid.UUID `gorm:"column:a_id"`
	BID      uuid.UUID `gorm:"column:b_id"`
	Matches  int64     `gorm:"column:matches"`
	Decided  int64     `gorm:"column:decided"`
	AWins    int64     `gorm:"column:a_wins"`
	BWins    int64     `gorm:"column:b_wins"`
	TotalBet int64     `gorm:"column:total_bet"`
	ANet     int64     `gorm:"column:a_net"`
}

func (r *Repository) PairAggregates(f AdminMatchFilter, minPairMatches, limit int) ([]pairAggRow, error) {
	pairA := "least(game_matches.player0_id, game_matches.player1_id)"
	pairB := "greatest(game_matches.player0_id, game_matches.player1_id)"

	var rows []pairAggRow
	err := r.db.Table("game_matches").
		Select(fmt.Sprintf(`%[1]s AS a_id, %[2]s AS b_id,
			count(*) AS matches,
			count(*) filter (where game_matches.winner_id is not null) AS decided,
			count(*) filter (where game_matches.winner_id = %[1]s) AS a_wins,
			count(*) filter (where game_matches.winner_id = %[2]s) AS b_wins,
			coalesce(sum(game_matches.bet), 0) AS total_bet,
			coalesce(sum(CASE WHEN game_matches.winner_id = %[1]s THEN game_matches.ken_delta
				WHEN game_matches.loser_id = %[1]s THEN -game_matches.bet
				ELSE 0 END), 0) AS a_net`, pairA, pairB)).
		Scopes(matchScope(f)).
		Where("game_matches.status = 'finished' AND game_matches.bet > 0").
		Group(fmt.Sprintf("%s, %s", pairA, pairB)).
		Having("count(*) >= ?", minPairMatches).
		Order("matches DESC").
		Limit(limit).
		Scan(&rows).Error
	return rows, err
}

type userBriefRow struct {
	ID       uuid.UUID `gorm:"column:id"`
	Username string    `gorm:"column:username"`
	FullName string    `gorm:"column:full_name"`
	Avatar   string    `gorm:"column:avatar"`
}

func (r *Repository) UserBriefs(ids []uuid.UUID) (map[uuid.UUID]userBriefRow, error) {
	out := make(map[uuid.UUID]userBriefRow, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	var rows []userBriefRow
	err := r.db.Table("users").
		Select("id, username, full_name, avatar").
		Where("id IN ?", ids).
		Scan(&rows).Error
	if err != nil {
		return nil, err
	}
	for _, row := range rows {
		out[row.ID] = row
	}
	return out, nil
}
