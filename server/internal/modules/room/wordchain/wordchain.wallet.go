package wordchain

import (
	"errors"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

var errKenShort = errors.New("insufficient ken balance for word chain hint")

type HintCharge struct {
	UserID uuid.UUID
	Price  int
	Word   string
	Turn   int64
	Hints  []string
}

type HintWallet interface {
	ChargeHint(charge HintCharge) (int, error)
}

type Wallet struct {
	db        *gorm.DB
	userCache *userModule.CacheService
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
}

func NewWallet(db *gorm.DB, userCache *userModule.CacheService, wsServer *websocket.Server, logger *zap.SugaredLogger) *Wallet {
	return &Wallet{db: db, userCache: userCache, wsServer: wsServer, logger: logger.Named("[word_chain_wallet]")}
}

func (w *Wallet) ChargeHint(charge HintCharge) (int, error) {
	var balance int
	err := w.db.Transaction(func(tx *gorm.DB) error {
		var user models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).Select("id", "ken").First(&user, "id = ?", charge.UserID).Error; err != nil {
			return err
		}
		if user.Ken < charge.Price {
			return errKenShort
		}
		balance = user.Ken - charge.Price
		if err := tx.Model(&models.User{}).Where("id = ?", charge.UserID).Update("ken", balance).Error; err != nil {
			return err
		}
		actorID := charge.UserID
		return tx.Create(&models.KenTransaction{
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
				"word":  charge.Word,
				"turn":  charge.Turn,
				"hints": charge.Hints,
			},
		}).Error
	})
	if err != nil {
		return 0, err
	}
	if err := w.userCache.InvalidateUser(charge.UserID); err != nil {
		w.logger.Warnw("Failed to invalidate user cache after word chain hint", "user_id", charge.UserID, "error", err)
	}
	w.emitKenUpdate(charge.UserID, balance)
	return balance, nil
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
