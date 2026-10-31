package admingamematch

import (
	"fmt"
	"time"

	"ola-chat-server/internal/constants"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

const (
	seatsJoin         = "CROSS JOIN LATERAL " + constants.GameMatchSeatsSubquery + " AS seats"
	sqlMatchVolume    = "bet::bigint * GREATEST(player_count, 2)"
	sqlMatchHouseTake = "bet::bigint * (GREATEST(player_count, 2) - 1) - ken_delta"
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
			db = db.Where(constants.GameMatchHasUserCondition, *f.UserID, *f.UserID, *f.UserID)
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
	PlayerCount     int        `gorm:"column:player_count"`
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
			game_matches.ken_delta, game_matches.player_count, game_matches.move_count,
			game_matches.started_at, game_matches.finished_at,
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

type matchSeatRow struct {
	GameMatchID uuid.UUID `gorm:"column:game_match_id"`
	UserID      uuid.UUID `gorm:"column:user_id"`
	Seat        int       `gorm:"column:seat"`
	Place       *int      `gorm:"column:place"`
	Username    string    `gorm:"column:username"`
	FullName    string    `gorm:"column:full_name"`
	Avatar      string    `gorm:"column:avatar"`
}

func (r *Repository) MatchSeats(matchIDs []uuid.UUID) (map[uuid.UUID][]matchSeatRow, error) {
	byMatch := make(map[uuid.UUID][]matchSeatRow, len(matchIDs))
	if len(matchIDs) == 0 {
		return byMatch, nil
	}
	var rows []matchSeatRow
	err := r.db.Table("game_match_players AS seats").
		Select(`seats.game_match_id, seats.user_id, seats.seat, seats.place,
			users.username, users.full_name, users.avatar`).
		Joins("LEFT JOIN users ON users.id = seats.user_id").
		Where("seats.game_match_id IN ?", matchIDs).
		Order("seats.game_match_id ASC, seats.seat ASC").
		Scan(&rows).Error
	if err != nil {
		return nil, err
	}
	for _, row := range rows {
		byMatch[row.GameMatchID] = append(byMatch[row.GameMatchID], row)
	}
	return byMatch, nil
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
			coalesce(sum(` + sqlMatchVolume + `) filter (where status = 'finished'), 0) as total_volume,
			coalesce(sum(` + sqlMatchHouseTake + `) filter (where status = 'finished' and winner_id is not null), 0) as house_take`).
		Scan(&o).Error
	return o, err
}

func (r *Repository) UniquePlayers(f AdminMatchFilter) (int64, error) {
	var count int64
	err := r.db.Table("game_matches").
		Select("count(DISTINCT seats.user_id)").
		Joins(seatsJoin).
		Scopes(matchScope(f)).
		Scan(&count).Error
	return count, err
}

func (r *Repository) StatsByGame(f AdminMatchFilter) ([]StatsGameRow, error) {
	var rows []StatsGameRow
	err := r.db.Table("game_matches").Scopes(matchScope(f)).
		Select(`game_id, count(*) as matches,
			count(*) filter (where status = 'finished') as finished,
			coalesce(sum(` + sqlMatchVolume + `) filter (where status = 'finished'), 0) as volume,
			coalesce(sum(` + sqlMatchHouseTake + `) filter (where status = 'finished' and winner_id is not null), 0) as house_take`).
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
			coalesce(sum(%s) filter (where status = 'finished'), 0) as volume,
			coalesce(sum(%s) filter (where status = 'finished' and winner_id is not null), 0) as house_take`,
			trunc, format, sqlMatchVolume, sqlMatchHouseTake)).
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

func (r *Repository) PlayerAggregates(f AdminMatchFilter, minMatches, limit int) ([]playerAggRow, error) {
	var rows []playerAggRow
	err := r.db.Table("game_matches").
		Select(`seats.user_id AS user_id, users.username, users.full_name, users.avatar,
			count(*) AS matches,
			count(*) filter (where game_matches.winner_id = seats.user_id) AS wins,
			count(*) filter (where game_matches.winner_id <> seats.user_id) AS losses,
			coalesce(sum(game_matches.bet), 0) AS staked,
			coalesce(sum(CASE WHEN game_matches.winner_id = seats.user_id THEN game_matches.ken_delta
				WHEN game_matches.winner_id IS NOT NULL THEN -game_matches.bet
				ELSE 0 END), 0) AS net_ken`).
		Joins(seatsJoin).
		Joins("JOIN users ON users.id = seats.user_id").
		Scopes(matchScope(f)).
		Where("game_matches.status = 'finished' AND game_matches.bet > 0").
		Group("seats.user_id, users.username, users.full_name, users.avatar").
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
	var rows []pairAggRow
	err := r.db.Table("game_matches").
		Select(`seat_a.user_id AS a_id, seat_b.user_id AS b_id,
			count(*) AS matches,
			count(*) filter (where game_matches.winner_id IN (seat_a.user_id, seat_b.user_id)) AS decided,
			count(*) filter (where game_matches.winner_id = seat_a.user_id) AS a_wins,
			count(*) filter (where game_matches.winner_id = seat_b.user_id) AS b_wins,
			coalesce(sum(game_matches.bet), 0) AS total_bet,
			coalesce(sum(CASE WHEN game_matches.winner_id = seat_a.user_id THEN game_matches.ken_delta
				WHEN game_matches.winner_id IS NOT NULL THEN -game_matches.bet
				ELSE 0 END), 0) AS a_net`).
		Joins("CROSS JOIN LATERAL "+constants.GameMatchSeatsSubquery+" AS seat_a").
		Joins("CROSS JOIN LATERAL "+constants.GameMatchSeatsSubquery+" AS seat_b").
		Scopes(matchScope(f)).
		Where("seat_a.user_id < seat_b.user_id AND game_matches.status = 'finished' AND game_matches.bet > 0").
		Group("seat_a.user_id, seat_b.user_id").
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

type levelRow struct {
	UserID    uuid.UUID `gorm:"column:user_id"`
	GameID    string    `gorm:"column:game_id"`
	Exp       int64     `gorm:"column:exp"`
	Level     int       `gorm:"column:level"`
	UpdatedAt time.Time `gorm:"column:updated_at"`
	Username  string    `gorm:"column:username"`
	FullName  string    `gorm:"column:full_name"`
	Avatar    string    `gorm:"column:avatar"`
}

func levelScope(f AdminLevelFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		db = db.Joins("JOIN users ON users.id = user_game_levels.user_id AND users.deleted_at IS NULL")
		if f.GameID != "" {
			db = db.Where("user_game_levels.game_id = ?", f.GameID)
		}
		if f.UserID != nil {
			db = db.Where("user_game_levels.user_id = ?", *f.UserID)
		}
		if f.Search != "" {
			like := "%" + f.Search + "%"
			db = db.Where("(users.username ILIKE ? OR users.full_name ILIKE ?)", like, like)
		}
		return db
	}
}

func (r *Repository) ListLevels(f AdminLevelFilter, limit, offset int) ([]levelRow, int64, error) {
	var total int64
	if err := r.db.Table("user_game_levels").Scopes(levelScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []levelRow
	err := r.db.Table("user_game_levels").
		Select(`user_game_levels.user_id, user_game_levels.game_id, user_game_levels.exp,
			user_game_levels.level, user_game_levels.updated_at,
			users.username, users.full_name, users.avatar`).
		Scopes(levelScope(f)).
		Order("user_game_levels.exp DESC, user_game_levels.updated_at DESC, user_game_levels.game_id ASC, user_game_levels.user_id ASC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}
