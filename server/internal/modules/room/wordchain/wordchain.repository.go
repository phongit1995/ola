package wordchain

import (
	"context"
	"fmt"
	"ola-chat-server/internal/models"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type LeaderboardRow struct {
	UserID uuid.UUID `gorm:"column:user_id"`
	Points int64     `gorm:"column:points"`
	Wins   int64     `gorm:"column:wins"`
	Rank   int64     `gorm:"column:rank"`
	Total  int64     `gorm:"column:total"`
}

type ScoreLog interface {
	Record(ctx context.Context, score *models.WordChainScore) error
	Leaderboard(ctx context.Context, sort string, from, to time.Time, userID uuid.UUID, limit int) ([]LeaderboardRow, error)
	Wins(ctx context.Context, userID, before *uuid.UUID, limit int) ([]models.WordChainScore, error)
}

type leaderboardOrder struct {
	orderBy string
	filter  string
}

var leaderboardOrders = map[string]leaderboardOrder{
	LeaderboardSortPoints: {orderBy: "points DESC, wins DESC, user_id", filter: "points > 0"},
	LeaderboardSortWins:   {orderBy: "wins DESC, points DESC, user_id", filter: "wins > 0"},
}

const leaderboardQuery = `
SELECT user_id, points, wins, rank, total FROM (
	SELECT user_id, points, wins,
		ROW_NUMBER() OVER (ORDER BY %s) AS rank,
		COUNT(*) OVER () AS total
	FROM (
		SELECT user_id, SUM(points) AS points, COUNT(*) FILTER (WHERE is_win) AS wins
		FROM word_chain_scores
		WHERE created_at >= ? AND created_at < ?
		GROUP BY user_id
	) agg
	WHERE %s
) ranked
WHERE rank <= ? OR user_id = ?
ORDER BY rank`

type ScoreRepository struct {
	db *gorm.DB
}

func NewScoreRepository(db *gorm.DB) *ScoreRepository {
	return &ScoreRepository{db: db}
}

func (r *ScoreRepository) Record(ctx context.Context, score *models.WordChainScore) error {
	return r.db.WithContext(ctx).Clauses(clause.OnConflict{DoNothing: true}).Create(score).Error
}

func (r *ScoreRepository) Leaderboard(ctx context.Context, sort string, from, to time.Time, userID uuid.UUID, limit int) ([]LeaderboardRow, error) {
	order, ok := leaderboardOrders[sort]
	if !ok {
		order = leaderboardOrders[LeaderboardSortPoints]
	}
	var rows []LeaderboardRow
	err := r.db.WithContext(ctx).
		Raw(fmt.Sprintf(leaderboardQuery, order.orderBy, order.filter), from.UTC(), to.UTC(), limit, userID).
		Scan(&rows).Error
	return rows, err
}

func (r *ScoreRepository) Wins(ctx context.Context, userID, before *uuid.UUID, limit int) ([]models.WordChainScore, error) {
	query := r.db.WithContext(ctx).Where("is_win")
	if userID != nil {
		query = query.Where("user_id = ?", *userID)
	}
	if before != nil {
		query = query.Where("(created_at, message_id) < (SELECT created_at, message_id FROM word_chain_scores WHERE message_id = ?)", *before)
	}
	var rows []models.WordChainScore
	err := query.Order("created_at DESC, message_id DESC").Limit(limit).Find(&rows).Error
	return rows, err
}
