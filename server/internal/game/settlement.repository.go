package game

import (
	"context"
	"errors"
	"fmt"
	"math"
	"sort"
	"strings"
	"time"

	"ola-chat-server/internal/game/engine"
	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/user"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

const (
	matchStatusPlaying  = "playing"
	matchStatusFinished = "finished"
	reasonVoid          = "void"
	staleMatchAge       = time.Hour
)

var (
	errInsufficientKen   = errors.New("insufficient ken for bet")
	errInvalidMatch      = errors.New("invalid game match")
	errMatchConflict     = engine.ErrSettlementConflict
	errMatchNotEscrowed  = errors.New("game match was not escrowed")
	errKenBalanceCap     = errors.New("ken balance would exceed the database limit")
	errUserBalanceUpdate = errors.New("user balance update did not affect exactly one row")
)

type SettlementRepository struct {
	db     *gorm.DB
	users  *user.CacheService
	logger *zap.SugaredLogger
}

type settlementResult struct {
	gameID  string
	userIDs []uuid.UUID
}

func invalidMatchError(format string, args ...any) error {
	return fmt.Errorf("%w: %w: %s", engine.ErrSettlementConflict, errInvalidMatch, fmt.Sprintf(format, args...))
}

func NewSettlementRepository(db *gorm.DB, users *user.CacheService, logger *zap.SugaredLogger) engine.Settlement {
	return &SettlementRepository{db: db, users: users, logger: logger.Named("[game-settle]")}
}

func parsePlayers(a, b string) (uuid.UUID, uuid.UUID, error) {
	p0, err := uuid.Parse(a)
	if err != nil {
		return uuid.Nil, uuid.Nil, invalidMatchError("invalid player0 id")
	}
	p1, err := uuid.Parse(b)
	if err != nil {
		return uuid.Nil, uuid.Nil, invalidMatchError("invalid player1 id")
	}
	if p0 == p1 {
		return uuid.Nil, uuid.Nil, invalidMatchError("players must be different")
	}
	return p0, p1, nil
}

func parseMatchID(matchID string) (uuid.UUID, error) {
	id, err := uuid.Parse(matchID)
	if err != nil {
		return uuid.Nil, invalidMatchError("invalid match id")
	}
	return id, nil
}

func validateBet(bet int) error {
	if bet < 0 || bet > engine.MaxBet {
		return invalidMatchError("bet must be between 0 and %d", engine.MaxBet)
	}
	return nil
}

func validateRecord(rec engine.MatchRecord) (p0, p1 uuid.UUID, guest bool, err error) {
	if err = validateBet(rec.Bet); err != nil {
		return uuid.Nil, uuid.Nil, false, err
	}
	p0, p1, err = parsePlayers(rec.Player0ID, rec.Player1ID)
	if err != nil {
		if rec.Bet == 0 {
			return uuid.Nil, uuid.Nil, true, nil
		}
		return uuid.Nil, uuid.Nil, false, err
	}
	if _, err = parseMatchID(rec.MatchID); err != nil {
		return uuid.Nil, uuid.Nil, false, err
	}
	if rec.GameID == "" || len(rec.GameID) > 50 {
		return uuid.Nil, uuid.Nil, false, invalidMatchError("invalid game id")
	}
	if rec.Mode != "queue" && rec.Mode != "room" {
		return uuid.Nil, uuid.Nil, false, invalidMatchError("invalid match mode")
	}
	if rec.StartedAt.IsZero() {
		return uuid.Nil, uuid.Nil, false, invalidMatchError("missing start time")
	}
	return p0, p1, false, nil
}

func validateOutcome(out engine.MatchOutcome) (p0, p1 uuid.UUID, guest bool, err error) {
	if err = validateBet(out.Bet); err != nil {
		return uuid.Nil, uuid.Nil, false, err
	}
	p0, p1, err = parsePlayers(out.Player0ID, out.Player1ID)
	if err != nil {
		if out.Bet == 0 {
			return uuid.Nil, uuid.Nil, true, nil
		}
		return uuid.Nil, uuid.Nil, false, err
	}
	if _, err = parseMatchID(out.MatchID); err != nil {
		return uuid.Nil, uuid.Nil, false, err
	}
	if out.GameID == "" || len(out.GameID) > 50 {
		return uuid.Nil, uuid.Nil, false, invalidMatchError("invalid game id")
	}
	if strings.TrimSpace(out.Reason) == "" || len(out.Reason) > 20 {
		return uuid.Nil, uuid.Nil, false, invalidMatchError("invalid finish reason")
	}
	if out.MoveCount < 0 {
		return uuid.Nil, uuid.Nil, false, invalidMatchError("move count cannot be negative")
	}
	if out.FinishedAt.IsZero() {
		return uuid.Nil, uuid.Nil, false, invalidMatchError("missing finish time")
	}
	return p0, p1, false, nil
}

func (s *SettlementRepository) Balance(userID string) (int, bool) {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return 0, false
	}
	u, err := s.users.GetUserCache(uid, true)
	if err != nil {
		return 0, false
	}
	return u.Ken, true
}

func (s *SettlementRepository) EscrowStart(ctx context.Context, rec engine.MatchRecord) ([]engine.SettledBalance, error) {
	p0, p1, guest, err := validateRecord(rec)
	if err != nil {
		return nil, err
	}
	if guest {
		return nil, nil
	}
	if rec.Bet == 0 {
		registered, err := s.registeredPlayers(ctx, p0, p1)
		if err != nil {
			return nil, err
		}
		if !registered {
			return nil, nil
		}
	}

	result, err := s.escrowStart(ctx, rec, p0, p1)
	if err != nil {
		return nil, err
	}
	return s.freshBalances(result.gameID, result.userIDs), nil
}

func (s *SettlementRepository) escrowStart(
	ctx context.Context,
	rec engine.MatchRecord,
	p0, p1 uuid.UUID,
) (settlementResult, error) {
	var result settlementResult
	err := s.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		escrowedAt := time.Now()
		if rec.StartedAt.After(escrowedAt) {
			escrowedAt = rec.StartedAt
		}
		row := models.GameMatch{
			GameID:     rec.GameID,
			MatchID:    rec.MatchID,
			Player0ID:  p0,
			Player1ID:  p1,
			Status:     matchStatusPlaying,
			Mode:       rec.Mode,
			Bet:        rec.Bet,
			StartedAt:  rec.StartedAt,
			EscrowedAt: escrowedAt,
		}
		res := tx.Clauses(clause.OnConflict{
			Columns:   []clause.Column{{Name: "match_id"}},
			DoNothing: true,
		}).Create(&row)
		if res.Error != nil {
			return res.Error
		}
		if res.RowsAffected == 0 {
			var existing models.GameMatch
			if err := tx.Unscoped().Clauses(clause.Locking{Strength: "UPDATE"}).
				Where("match_id = ?", rec.MatchID).First(&existing).Error; err != nil {
				return err
			}
			if err := verifyMatchRecord(existing, rec, p0, p1); err != nil {
				return err
			}
			result.gameID = existing.GameID
			if existing.Bet > 0 {
				result.userIDs = []uuid.UUID{existing.Player0ID, existing.Player1ID}
			}
			return nil
		}

		result.gameID = row.GameID
		if row.Bet == 0 {
			return nil
		}
		users, err := lockUsers(tx, []uuid.UUID{p0, p1}, false)
		if err != nil {
			return err
		}
		for _, id := range orderedUserIDs(p0, p1) {
			u := users[id]
			if u.Ken < row.Bet {
				return errInsufficientKen
			}
			if u.Ken > math.MaxInt32-row.Bet {
				return errKenBalanceCap
			}
			before := u.Ken
			after := before - row.Bet
			if err := updateUserKen(tx, id, after, false); err != nil {
				return err
			}
		}
		result.userIDs = []uuid.UUID{p0, p1}
		return nil
	})
	return result, err
}

func verifyMatchRecord(row models.GameMatch, rec engine.MatchRecord, p0, p1 uuid.UUID) error {
	if row.GameID != rec.GameID ||
		row.Player0ID != p0 ||
		row.Player1ID != p1 ||
		row.Bet != rec.Bet ||
		row.Mode != rec.Mode {
		return errMatchConflict
	}
	if row.Status == matchStatusFinished || row.DeletedAt.Valid {
		return fmt.Errorf("%w: match %s is already closed", engine.ErrEscrowClosed, row.MatchID)
	}
	if row.Status != matchStatusPlaying || row.EscrowedAt.IsZero() {
		return invalidMatchError("match %s has an invalid escrow record", row.MatchID)
	}
	return nil
}

func (s *SettlementRepository) AbortStart(ctx context.Context, matchID string) ([]engine.SettledBalance, error) {
	if _, err := parseMatchID(matchID); err != nil {
		return nil, err
	}
	result, err := s.abortMatch(ctx, matchID)
	if err != nil {
		return nil, err
	}
	return s.freshBalances(result.gameID, result.userIDs), nil
}

func (s *SettlementRepository) SettleFinish(ctx context.Context, out engine.MatchOutcome) ([]engine.SettledBalance, error) {
	p0, p1, guest, err := validateOutcome(out)
	if err != nil {
		return nil, err
	}
	if guest {
		return nil, nil
	}
	if out.Bet == 0 {
		registered, err := s.registeredPlayers(ctx, p0, p1)
		if err != nil {
			return nil, err
		}
		if !registered {
			return nil, nil
		}
	}

	result, err := s.settleFinish(ctx, out, p0, p1)
	if err != nil {
		return nil, err
	}
	return s.freshBalances(result.gameID, result.userIDs), nil
}

func (s *SettlementRepository) settleFinish(
	ctx context.Context,
	out engine.MatchOutcome,
	p0, p1 uuid.UUID,
) (settlementResult, error) {
	var result settlementResult
	err := s.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		var row models.GameMatch
		err := tx.Unscoped().Clauses(clause.Locking{Strength: "UPDATE"}).
			Where("match_id = ?", out.MatchID).First(&row).Error
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errMatchNotEscrowed
		}
		if err != nil {
			return err
		}
		if row.GameID != out.GameID ||
			row.Player0ID != p0 ||
			row.Player1ID != p1 ||
			row.Bet != out.Bet {
			return errMatchConflict
		}
		if row.EscrowedAt.IsZero() {
			return invalidMatchError("match %s has no escrow timestamp", row.MatchID)
		}

		winner, loser, err := outcomePlayers(row, out.WinnerID)
		if err != nil {
			return err
		}
		if err := validateResultReason(out.Reason, winner != nil); err != nil {
			return err
		}
		if row.Status == matchStatusFinished {
			if !sameFinishedOutcome(row, winner, loser, out.Reason, out.MoveCount) {
				return errMatchConflict
			}
			result.gameID = row.GameID
			if row.Bet > 0 {
				result.userIDs = []uuid.UUID{row.Player0ID, row.Player1ID}
			}
			return nil
		}
		if row.Status != matchStatusPlaying {
			return errMatchConflict
		}

		kenDelta := 0
		if row.Bet > 0 {
			users, err := lockUsers(tx, []uuid.UUID{row.Player0ID, row.Player1ID}, true)
			if err != nil {
				return err
			}
			if winner != nil {
				amount := row.Bet * 2
				u := users[*winner]
				after, err := checkedCredit(u.Ken, amount)
				if err != nil {
					return err
				}
				if err := updateUserKen(tx, *winner, after, true); err != nil {
					return err
				}
				kenDelta = row.Bet
			} else {
				for _, id := range orderedUserIDs(row.Player0ID, row.Player1ID) {
					u := users[id]
					after, err := checkedCredit(u.Ken, row.Bet)
					if err != nil {
						return err
					}
					if err := updateUserKen(tx, id, after, true); err != nil {
						return err
					}
				}
			}
			result.userIDs = []uuid.UUID{row.Player0ID, row.Player1ID}
		}

		finishedAt := out.FinishedAt
		if finishedAt.Before(row.EscrowedAt) {
			finishedAt = row.EscrowedAt
		}
		res := tx.Unscoped().Model(&models.GameMatch{}).Where("id = ? AND status = ?", row.ID, matchStatusPlaying).
			Updates(map[string]any{
				"status":      matchStatusFinished,
				"reason":      out.Reason,
				"winner_id":   winner,
				"loser_id":    loser,
				"ken_delta":   kenDelta,
				"move_count":  out.MoveCount,
				"finished_at": &finishedAt,
			})
		if res.Error != nil {
			return res.Error
		}
		if res.RowsAffected != 1 {
			return errMatchConflict
		}
		result.gameID = row.GameID
		return nil
	})
	return result, err
}

func outcomePlayers(row models.GameMatch, winnerID string) (winner, loser *uuid.UUID, err error) {
	if winnerID == "" {
		return nil, nil, nil
	}
	w, parseErr := uuid.Parse(winnerID)
	if parseErr != nil || (w != row.Player0ID && w != row.Player1ID) {
		return nil, nil, invalidMatchError("winner is not a player")
	}
	l := row.Player1ID
	if w == row.Player1ID {
		l = row.Player0ID
	}
	return &w, &l, nil
}

func validateResultReason(reason string, hasWinner bool) error {
	switch reason {
	case "win", "forfeit", "timeout":
		if !hasWinner {
			return invalidMatchError("reason %q requires a winner", reason)
		}
	case "draw", reasonVoid:
		if hasWinner {
			return invalidMatchError("reason %q cannot have a winner", reason)
		}
	case "disconnect":
		// A disconnect may be a draw when both players leave, or a win when one remains.
	default:
		return invalidMatchError("unsupported finish reason")
	}
	return nil
}

func sameFinishedOutcome(row models.GameMatch, winner, loser *uuid.UUID, reason string, moveCount int) bool {
	if row.Reason != reason || row.MoveCount != moveCount || row.FinishedAt == nil {
		return false
	}
	if (row.WinnerID == nil) != (winner == nil) || (row.LoserID == nil) != (loser == nil) {
		return false
	}
	if winner != nil && (*row.WinnerID != *winner || *row.LoserID != *loser) {
		return false
	}
	return true
}

func (s *SettlementRepository) ReconcileStale(
	ctx context.Context,
	activeMatchIDs []string,
) ([]engine.SettledBalance, error) {
	cutoff := time.Now().Add(-staleMatchAge)
	query := s.db.WithContext(ctx).
		Where("status = ? AND started_at < ?", matchStatusPlaying, cutoff).
		Order("started_at ASC").
		Limit(200)
	if active := compactStrings(activeMatchIDs); len(active) > 0 {
		query = query.Where("match_id NOT IN ?", active)
	}

	var stale []models.GameMatch
	if err := query.Find(&stale).Error; err != nil {
		return nil, err
	}

	var (
		balances []engine.SettledBalance
		errs     []error
	)
	for _, match := range stale {
		if err := ctx.Err(); err != nil {
			errs = append(errs, err)
			break
		}
		refunded, err := s.AbortStart(ctx, match.MatchID)
		if err != nil {
			errs = append(errs, fmt.Errorf("abort stale match %s: %w", match.MatchID, err))
			continue
		}
		balances = append(balances, refunded...)
	}
	return balances, errors.Join(errs...)
}

func (s *SettlementRepository) abortMatch(ctx context.Context, matchID string) (settlementResult, error) {
	var result settlementResult
	err := s.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		var row models.GameMatch
		err := tx.Unscoped().Clauses(clause.Locking{Strength: "UPDATE"}).
			Where("match_id = ?", matchID).First(&row).Error
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil
		}
		if err != nil {
			return err
		}
		if row.Status == matchStatusFinished {
			result.gameID = row.GameID
			if row.Bet > 0 {
				result.userIDs = []uuid.UUID{row.Player0ID, row.Player1ID}
			}
			return nil
		}
		if row.Status != matchStatusPlaying || row.EscrowedAt.IsZero() {
			return invalidMatchError("match %s has an invalid escrow record", row.MatchID)
		}

		if row.Bet > 0 {
			users, err := lockUsers(tx, []uuid.UUID{row.Player0ID, row.Player1ID}, true)
			if err != nil {
				return err
			}
			for _, id := range orderedUserIDs(row.Player0ID, row.Player1ID) {
				u := users[id]
				after, err := checkedCredit(u.Ken, row.Bet)
				if err != nil {
					return err
				}
				if err := updateUserKen(tx, id, after, true); err != nil {
					return err
				}
			}
			result.userIDs = []uuid.UUID{row.Player0ID, row.Player1ID}
		}

		finishedAt := time.Now()
		if finishedAt.Before(row.EscrowedAt) {
			finishedAt = row.EscrowedAt
		}
		res := tx.Unscoped().Model(&models.GameMatch{}).Where("id = ? AND status = ?", row.ID, matchStatusPlaying).
			Updates(map[string]any{
				"status":      matchStatusFinished,
				"reason":      reasonVoid,
				"ken_delta":   0,
				"finished_at": &finishedAt,
			})
		if res.Error != nil {
			return res.Error
		}
		if res.RowsAffected != 1 {
			return errMatchConflict
		}
		result.gameID = row.GameID
		return nil
	})
	return result, err
}

func (s *SettlementRepository) registeredPlayers(ctx context.Context, p0, p1 uuid.UUID) (bool, error) {
	var count int64
	err := s.db.WithContext(ctx).Unscoped().Model(&models.User{}).
		Where("id IN ?", []uuid.UUID{p0, p1}).
		Count(&count).Error
	return count == 2, err
}

func orderedUserIDs(ids ...uuid.UUID) []uuid.UUID {
	ordered := append([]uuid.UUID(nil), ids...)
	sort.Slice(ordered, func(i, j int) bool {
		return ordered[i].String() < ordered[j].String()
	})
	return ordered
}

func lockUsers(tx *gorm.DB, ids []uuid.UUID, unscoped bool) (map[uuid.UUID]*models.User, error) {
	ordered := orderedUserIDs(ids...)
	users := make(map[uuid.UUID]*models.User, len(ordered))
	for _, id := range ordered {
		if _, exists := users[id]; exists {
			return nil, invalidMatchError("duplicate user")
		}
		query := tx
		if unscoped {
			query = query.Unscoped()
		}
		var u models.User
		if err := query.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", id).Error; err != nil {
			return nil, err
		}
		locked := u
		users[id] = &locked
	}
	return users, nil
}

func checkedCredit(balance, amount int) (int, error) {
	if amount <= 0 {
		return 0, invalidMatchError("credit must be positive")
	}
	if balance < 0 || balance > math.MaxInt32-amount {
		return 0, errKenBalanceCap
	}
	return balance + amount, nil
}

func updateUserKen(tx *gorm.DB, userID uuid.UUID, balance int, unscoped bool) error {
	query := tx.Model(&models.User{})
	if unscoped {
		query = tx.Unscoped().Model(&models.User{})
	}
	res := query.Where("id = ?", userID).Update("ken", balance)
	if res.Error != nil {
		return res.Error
	}
	if res.RowsAffected != 1 {
		return errUserBalanceUpdate
	}
	return nil
}

func compactStrings(values []string) []string {
	seen := make(map[string]struct{}, len(values))
	out := make([]string, 0, len(values))
	for _, value := range values {
		if value == "" {
			continue
		}
		if _, exists := seen[value]; exists {
			continue
		}
		seen[value] = struct{}{}
		out = append(out, value)
	}
	return out
}

func (s *SettlementRepository) freshBalances(gameID string, ids []uuid.UUID) []engine.SettledBalance {
	if gameID == "" || len(ids) == 0 {
		return nil
	}
	out := make([]engine.SettledBalance, 0, len(ids))
	seen := make(map[uuid.UUID]struct{}, len(ids))
	for _, id := range ids {
		if _, exists := seen[id]; exists {
			continue
		}
		seen[id] = struct{}{}
		info, err := s.freshUserInfo(id)
		if err != nil {
			s.logger.Warnw("Failed to load user info after settle", "user_id", id, "error", err)
			continue
		}
		out = append(out, engine.SettledBalance{GameID: gameID, UserID: id.String(), Info: *info})
	}
	return out
}

func (s *SettlementRepository) freshUserInfo(userID uuid.UUID) (*protocol.UserInfoData, error) {
	deleteErr := s.users.DeleteUser(userID)
	if deleteErr != nil {
		s.logger.Warnw("Failed to invalidate user cache after settle; loading balance directly",
			"user_id", userID,
			"error", deleteErr,
		)
	}

	var u models.User
	if err := s.db.Unscoped().First(&u, "id = ?", userID).Error; err != nil {
		return nil, err
	}
	if deleteErr != nil && !u.DeletedAt.Valid {
		if err := s.users.SetUser(userID, &u); err != nil {
			s.logger.Warnw("Failed to replace stale user cache after settle",
				"user_id", userID,
				"error", err,
			)
		}
	}
	info := &protocol.UserInfoData{
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
