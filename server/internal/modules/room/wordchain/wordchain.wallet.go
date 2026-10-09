package wordchain

import (
	"context"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type KenWallet interface {
	ChargeHint(ctx context.Context, charge HintCharge) (HintChargeResult, error)
	ChargeGuesses(ctx context.Context, charge GuessCharge) (int, error)
	GuessesBought(ctx context.Context, userID, sessionID uuid.UUID, turn int64) (int, error)
	Purchase(ctx context.Context, userID, sessionID uuid.UUID, turn int64) (*models.WordChainHintPurchase, error)
	Balance(ctx context.Context, userID uuid.UUID) (int, error)
}

type Wallet struct {
	repo      *Repository
	userCache *userModule.CacheService
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
}

func NewWallet(repo *Repository, userCache *userModule.CacheService, wsServer *websocket.Server, logger *zap.SugaredLogger) *Wallet {
	return &Wallet{repo: repo, userCache: userCache, wsServer: wsServer, logger: logger.Named("[word_chain_wallet]")}
}

func (w *Wallet) Balance(ctx context.Context, userID uuid.UUID) (int, error) {
	return w.repo.KenBalance(ctx, userID)
}

func (w *Wallet) Purchase(ctx context.Context, userID, sessionID uuid.UUID, turn int64) (*models.WordChainHintPurchase, error) {
	return w.repo.HintPurchase(ctx, userID, sessionID, turn)
}

func (w *Wallet) ChargeHint(ctx context.Context, charge HintCharge) (HintChargeResult, error) {
	result, err := w.repo.ChargeHint(ctx, charge)
	if err != nil || !result.Charged {
		return result, err
	}
	w.afterCharge(charge.UserID, result.Balance)
	return result, nil
}

func (w *Wallet) GuessesBought(ctx context.Context, userID, sessionID uuid.UUID, turn int64) (int, error) {
	return w.repo.GuessesBought(ctx, userID, sessionID, turn)
}

func (w *Wallet) ChargeGuesses(ctx context.Context, charge GuessCharge) (int, error) {
	balance, err := w.repo.ChargeGuesses(ctx, charge)
	if err != nil {
		return 0, err
	}
	w.afterCharge(charge.UserID, balance)
	return balance, nil
}

func (w *Wallet) afterCharge(userID uuid.UUID, balance int) {
	if err := w.userCache.InvalidateUser(userID); err != nil {
		w.logger.Warnw("Failed to invalidate user cache after word chain purchase", "user_id", userID, "error", err)
	}
	w.emitKenUpdate(userID, balance)
}

func (w *Wallet) emitKenUpdate(userID uuid.UUID, ken int) {
	if w.wsServer == nil {
		return
	}
	payload := utils.WrapWebSocketMessage(constants.WebSocketEventKenUpdated, map[string]interface{}{
		"ken": ken,
	})
	w.wsServer.EmitToUser(userID.String(), constants.WebSocketMessageEvent, payload)
}
