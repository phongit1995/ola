package wordchain

import (
	"context"
	"errors"
	"fmt"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"strconv"
	"time"

	"github.com/google/uuid"
	"github.com/lib/pq"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

var (
	errKenShort      = errors.New("insufficient ken balance for word chain purchase")
	errGuessesBought = errors.New("word chain guesses were already bought for this word")
)

type LeaderboardRow struct {
	UserID uuid.UUID `gorm:"column:user_id"`
	Points int64     `gorm:"column:points"`
	Wins   int64     `gorm:"column:wins"`
	Rank   int64     `gorm:"column:rank"`
	Total  int64     `gorm:"column:total"`
}

type ScoreCounts struct {
	Players int64 `gorm:"column:players"`
	Winners int64 `gorm:"column:winners"`
}

type ScoreLog interface {
	Record(ctx context.Context, score *models.WordChainScore) error
	Leaderboard(ctx context.Context, sort string, window *TimeRange, userID uuid.UUID, limit int) ([]LeaderboardRow, error)
	Points(ctx context.Context, userID uuid.UUID) (int64, error)
	Counts(ctx context.Context) (ScoreCounts, error)
	Wins(ctx context.Context, userID, before *uuid.UUID, limit int) ([]models.WordChainScore, error)
}

type HintCharge struct {
	UserID    uuid.UUID
	SessionID uuid.UUID
	Turn      int64
	Price     int
	Word      string
	Hints     []string
}

type HintChargeResult struct {
	Purchase models.WordChainHintPurchase
	Balance  int
	Charged  bool
}

type GuessCharge struct {
	UserID    uuid.UUID
	SessionID uuid.UUID
	Turn      int64
	Price     int
	Word      string
	Bought    int
	Guesses   int
}

type leaderboardOrder struct {
	orderBy string
	filter  string
}

var leaderboardOrders = map[string]leaderboardOrder{
	constants.WordChainLeaderboardSortPoints: {orderBy: "points DESC, wins DESC, user_id", filter: "points > 0"},
	constants.WordChainLeaderboardSortWins:   {orderBy: "wins DESC, points DESC, user_id", filter: "wins > 0"},
}

const leaderboardQuery = `
SELECT user_id, points, wins, rank, total FROM (
	SELECT user_id, points, wins,
		ROW_NUMBER() OVER (ORDER BY %s) AS rank,
		COUNT(*) OVER () AS total
	FROM (
		SELECT user_id, SUM(points) AS points, COUNT(*) FILTER (WHERE is_win) AS wins
		FROM word_chain_scores
		WHERE %s
		GROUP BY user_id
	) agg
	WHERE %s
) ranked
WHERE rank <= ? OR user_id = ?
ORDER BY rank`

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) Record(ctx context.Context, score *models.WordChainScore) error {
	return r.db.WithContext(ctx).Clauses(clause.OnConflict{DoNothing: true}).Create(score).Error
}

func (r *Repository) Leaderboard(ctx context.Context, sort string, window *TimeRange, userID uuid.UUID, limit int) ([]LeaderboardRow, error) {
	order := leaderboardOrders[normalizeLeaderboardSort(sort)]
	scope, args := "TRUE", []any{}
	if window != nil {
		scope, args = "created_at >= ? AND created_at < ?", []any{window.From.UTC(), window.To.UTC()}
	}
	var rows []LeaderboardRow
	err := r.db.WithContext(ctx).
		Raw(fmt.Sprintf(leaderboardQuery, order.orderBy, scope, order.filter), append(args, limit, userID)...).
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) Points(ctx context.Context, userID uuid.UUID) (int64, error) {
	var points int64
	err := r.db.WithContext(ctx).Model(&models.WordChainScore{}).
		Select("COALESCE(SUM(points), 0)").
		Where("user_id = ?", userID).
		Scan(&points).Error
	return points, err
}

func (r *Repository) Counts(ctx context.Context) (ScoreCounts, error) {
	var counts ScoreCounts
	err := r.db.WithContext(ctx).Model(&models.WordChainScore{}).
		Select("COUNT(DISTINCT user_id) AS players, COUNT(DISTINCT user_id) FILTER (WHERE is_win) AS winners").
		Scan(&counts).Error
	return counts, err
}

func (r *Repository) Wins(ctx context.Context, userID, before *uuid.UUID, limit int) ([]models.WordChainScore, error) {
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

func (r *Repository) KenBalance(ctx context.Context, userID uuid.UUID) (int, error) {
	var user models.User
	if err := r.db.WithContext(ctx).Select("id", "ken").First(&user, "id = ?", userID).Error; err != nil {
		return 0, err
	}
	return user.Ken, nil
}

func findHintPurchase(db *gorm.DB, userID, sessionID uuid.UUID, turn int64) (*models.WordChainHintPurchase, error) {
	var purchase models.WordChainHintPurchase
	res := db.Where("user_id = ? AND session_id = ? AND turn = ?", userID, sessionID, turn).Limit(1).Find(&purchase)
	if res.Error != nil {
		return nil, res.Error
	}
	if res.RowsAffected == 0 {
		return nil, nil
	}
	return &purchase, nil
}

func (r *Repository) HintPurchase(ctx context.Context, userID, sessionID uuid.UUID, turn int64) (*models.WordChainHintPurchase, error) {
	return findHintPurchase(r.db.WithContext(ctx), userID, sessionID, turn)
}

func (r *Repository) ChargeHint(ctx context.Context, charge HintCharge) (HintChargeResult, error) {
	var result HintChargeResult
	err := r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		var user models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).Select("id", "ken").First(&user, "id = ?", charge.UserID).Error; err != nil {
			return err
		}
		existing, err := findHintPurchase(tx, charge.UserID, charge.SessionID, charge.Turn)
		if err != nil {
			return err
		}
		if existing != nil {
			result = HintChargeResult{Purchase: *existing, Balance: user.Ken}
			return nil
		}
		if user.Ken < charge.Price {
			return errKenShort
		}
		balance := user.Ken - charge.Price
		if err := tx.Model(&models.User{}).Where("id = ?", charge.UserID).Update("ken", balance).Error; err != nil {
			return err
		}
		actorID := charge.UserID
		txn := models.KenTransaction{
			UserID:        charge.UserID,
			Direction:     models.KenDirectionDebit,
			Type:          models.KenTxTypeWordChainHint,
			Amount:        charge.Price,
			BalanceBefore: user.Ken,
			BalanceAfter:  balance,
			Description:   "word chain hint for " + charge.Word,
			RefType:       "word_chain",
			ActorType:     models.KenActorUser,
			ActorID:       &actorID,
			Metadata: models.JSONB{
				"sessionId": charge.SessionID.String(),
				"word":      charge.Word,
				"turn":      charge.Turn,
				"hints":     charge.Hints,
			},
		}
		if err := tx.Create(&txn).Error; err != nil {
			return err
		}
		purchase := models.WordChainHintPurchase{
			UserID:           charge.UserID,
			SessionID:        charge.SessionID,
			Turn:             charge.Turn,
			Word:             charge.Word,
			Hints:            pq.StringArray(charge.Hints),
			Price:            charge.Price,
			KenTransactionID: txn.ID,
			CreatedAt:        time.Now().UTC(),
		}
		if err := tx.Create(&purchase).Error; err != nil {
			return err
		}
		result = HintChargeResult{Purchase: purchase, Balance: balance, Charged: true}
		return nil
	})
	if err != nil {
		return HintChargeResult{}, err
	}
	return result, nil
}

func guessesBought(db *gorm.DB, userID, sessionID uuid.UUID, turn int64) (int, error) {
	var bought int
	err := db.Model(&models.KenTransaction{}).
		Select("COALESCE(SUM((metadata->>'guesses')::int), 0)").
		Where("user_id = ? AND type = ? AND ref_id = ? AND metadata->>'turn' = ?", userID, models.KenTxTypeWordChainGuess, sessionID, strconv.FormatInt(turn, 10)).
		Scan(&bought).Error
	return bought, err
}

func (r *Repository) GuessesBought(ctx context.Context, userID, sessionID uuid.UUID, turn int64) (int, error) {
	return guessesBought(r.db.WithContext(ctx), userID, sessionID, turn)
}

func (r *Repository) ChargeGuesses(ctx context.Context, charge GuessCharge) (int, error) {
	var balance int
	err := r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		var user models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).Select("id", "ken").First(&user, "id = ?", charge.UserID).Error; err != nil {
			return err
		}
		bought, err := guessesBought(tx, charge.UserID, charge.SessionID, charge.Turn)
		if err != nil {
			return err
		}
		if bought != charge.Bought {
			return errGuessesBought
		}
		if user.Ken < charge.Price {
			return errKenShort
		}
		balance = user.Ken - charge.Price
		if err := tx.Model(&models.User{}).Where("id = ?", charge.UserID).Update("ken", balance).Error; err != nil {
			return err
		}
		actorID := charge.UserID
		sessionID := charge.SessionID
		return tx.Create(&models.KenTransaction{
			UserID:        charge.UserID,
			Direction:     models.KenDirectionDebit,
			Type:          models.KenTxTypeWordChainGuess,
			Amount:        charge.Price,
			BalanceBefore: user.Ken,
			BalanceAfter:  balance,
			Description:   fmt.Sprintf("word chain +%d guesses for %s", charge.Guesses, charge.Word),
			RefType:       "word_chain",
			RefID:         &sessionID,
			ActorType:     models.KenActorUser,
			ActorID:       &actorID,
			Metadata: models.JSONB{
				"sessionId": charge.SessionID.String(),
				"word":      charge.Word,
				"turn":      charge.Turn,
				"guesses":   charge.Guesses,
			},
		}).Error
	})
	if err != nil {
		return 0, err
	}
	return balance, nil
}
