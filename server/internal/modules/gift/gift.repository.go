package gift

import (
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

type SendParams struct {
	SenderID        uuid.UUID
	ReceiverID      uuid.UUID
	Gift            *models.Gift
	Quantity        int
	Note            string
	Source          string
	ConversationID  *uuid.UUID
	ClientRequestID string
	Description     string
}

type SendResult struct {
	Transaction   models.GiftTransaction
	SenderBalance int
	ReceiverCharm int
	Replayed      bool
}

type WallRow struct {
	GiftID      uuid.UUID
	Name        string
	NameEn      string
	ImageURL    string
	KenPrice    int
	CharmPoints int
	Animation   string
	Quantity    int
}

type LeaderboardRow struct {
	UserID uuid.UUID
	Value  int64
}

func (r *Repository) ListActive() ([]models.Gift, error) {
	var items []models.Gift
	err := r.db.Where("is_active = ?", true).Order("sort_order ASC, ken_price ASC, created_at ASC").Find(&items).Error
	return items, err
}

func (r *Repository) ListAll() ([]models.Gift, error) {
	var items []models.Gift
	err := r.db.Order("sort_order ASC, ken_price ASC, created_at ASC").Find(&items).Error
	return items, err
}

func (r *Repository) FindByID(id uuid.UUID) (*models.Gift, error) {
	var item models.Gift
	if err := r.db.First(&item, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) Create(item *models.Gift) error {
	return r.db.Create(item).Error
}

func (r *Repository) Save(item *models.Gift) error {
	return r.db.Save(item).Error
}

func (r *Repository) Delete(id uuid.UUID) error {
	res := r.db.Delete(&models.Gift{}, "id = ?", id)
	if res.Error != nil {
		return res.Error
	}
	if res.RowsAffected == 0 {
		return gorm.ErrRecordNotFound
	}
	return nil
}

func (r *Repository) FindByClientRequest(senderID uuid.UUID, clientRequestID string) (*models.GiftTransaction, error) {
	var tx models.GiftTransaction
	err := r.db.Where("sender_id = ? AND client_request_id = ?", senderID, clientRequestID).First(&tx).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &tx, nil
}

func (r *Repository) Balances(senderID, receiverID uuid.UUID) (int, int, error) {
	var rows []models.User
	if err := r.db.Select("id", "ken", "charm").Where("id IN ?", []uuid.UUID{senderID, receiverID}).Find(&rows).Error; err != nil {
		return 0, 0, err
	}
	var ken, charm int
	for _, u := range rows {
		if u.ID == senderID {
			ken = u.Ken
		}
		if u.ID == receiverID {
			charm = u.Charm
		}
	}
	return ken, charm, nil
}

func (r *Repository) Send(p SendParams) (*SendResult, error) {
	total := p.Gift.KenPrice * p.Quantity
	charm := p.Gift.CharmPoints * p.Quantity
	result := &SendResult{}

	err := r.db.Transaction(func(tx *gorm.DB) error {
		lockOrder := []uuid.UUID{p.SenderID, p.ReceiverID}
		if lockOrder[0].String() > lockOrder[1].String() {
			lockOrder[0], lockOrder[1] = lockOrder[1], lockOrder[0]
		}
		users := make(map[uuid.UUID]*models.User, 2)
		for _, id := range lockOrder {
			var u models.User
			if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).Select("id", "ken", "charm", "is_active").First(&u, "id = ?", id).Error; err != nil {
				if errors.Is(err, gorm.ErrRecordNotFound) {
					if id == p.ReceiverID {
						return ErrGiftReceiverUnavailable
					}
					return apperr.ErrUserNotFound
				}
				return err
			}
			locked := u
			users[id] = &locked
		}

		sender := users[p.SenderID]
		receiver := users[p.ReceiverID]
		if !receiver.IsActive {
			return ErrGiftReceiverUnavailable
		}
		if sender.Ken < total {
			return ErrGiftInsufficientKen
		}

		now := time.Now().UTC()
		record := models.GiftTransaction{
			ID:              uuid.New(),
			SenderID:        p.SenderID,
			ReceiverID:      p.ReceiverID,
			GiftID:          p.Gift.ID,
			GiftName:        p.Gift.Name,
			GiftImageURL:    p.Gift.ImageURL,
			Quantity:        p.Quantity,
			UnitPrice:       p.Gift.KenPrice,
			TotalKen:        total,
			CharmPoints:     charm,
			Source:          p.Source,
			ConversationID:  p.ConversationID,
			Note:            p.Note,
			ClientRequestID: p.ClientRequestID,
			CreatedAt:       now,
		}
		if err := tx.Create(&record).Error; err != nil {
			return err
		}

		senderAfter := sender.Ken - total
		if err := tx.Model(&models.User{}).Where("id = ?", p.SenderID).Update("ken", senderAfter).Error; err != nil {
			return err
		}
		receiverCharm := receiver.Charm + charm
		if err := tx.Model(&models.User{}).Where("id = ?", p.ReceiverID).Update("charm", receiverCharm).Error; err != nil {
			return err
		}

		receiverID := p.ReceiverID
		actorID := p.SenderID
		kenTx := models.KenTransaction{
			UserID:        p.SenderID,
			Direction:     models.KenDirectionDebit,
			Type:          models.KenTxTypeGiftSent,
			Amount:        total,
			BalanceBefore: sender.Ken,
			BalanceAfter:  senderAfter,
			Description:   p.Description,
			RefType:       KenRefTypeUser,
			RefID:         &receiverID,
			ActorType:     models.KenActorUser,
			ActorID:       &actorID,
			Metadata: models.JSONB{
				"giftTransactionId": record.ID.String(),
				"giftId":            p.Gift.ID.String(),
				"quantity":          p.Quantity,
			},
		}
		if err := tx.Create(&kenTx).Error; err != nil {
			return err
		}

		wall := models.UserGiftWall{ReceiverID: p.ReceiverID, GiftID: p.Gift.ID, Quantity: p.Quantity, LastReceivedAt: now}
		if err := tx.Clauses(clause.OnConflict{
			Columns: []clause.Column{{Name: "receiver_id"}, {Name: "gift_id"}},
			DoUpdates: clause.Assignments(map[string]interface{}{
				"quantity":         gorm.Expr("user_gift_wall.quantity + ?", p.Quantity),
				"last_received_at": now,
			}),
		}).Create(&wall).Error; err != nil {
			return err
		}

		result.Transaction = record
		result.SenderBalance = senderAfter
		result.ReceiverCharm = receiverCharm
		return nil
	})
	if err != nil {
		return nil, err
	}
	return result, nil
}

func (r *Repository) SetMessage(txID uuid.UUID, conversationID uuid.UUID, messageID string) error {
	return r.db.Model(&models.GiftTransaction{}).Where("id = ?", txID).Updates(map[string]interface{}{
		"conversation_id": conversationID,
		"message_id":      messageID,
	}).Error
}

func (r *Repository) Wall(receiverID uuid.UUID) ([]WallRow, error) {
	var rows []WallRow
	err := r.db.Table("user_gift_wall AS w").
		Select("w.gift_id, g.name, g.name_en, g.image_url, g.ken_price, g.charm_points, g.animation, w.quantity").
		Joins("JOIN gifts g ON g.id = w.gift_id").
		Where("w.receiver_id = ? AND w.quantity > 0", receiverID).
		Order("g.ken_price DESC, w.last_received_at DESC").
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) GiftAnimations(ids []uuid.UUID) (map[uuid.UUID]string, error) {
	out := make(map[uuid.UUID]string, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	var gifts []models.Gift
	if err := r.db.Unscoped().Select("id", "animation").Where("id IN ?", ids).Find(&gifts).Error; err != nil {
		return out, err
	}
	for _, g := range gifts {
		out[g.ID] = g.Animation
	}
	return out, nil
}

func (r *Repository) GiftWallPrivacy(userID uuid.UUID) (int16, error) {
	var setting models.UserSetting
	err := r.db.Select("gift_wall_privacy").First(&setting, "user_id = ?", userID).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return models.SettingGiftWallPrivacyAll, nil
	}
	return setting.GiftWallPrivacy, err
}

func (r *Repository) UserCharm(userID uuid.UUID) (int, error) {
	var u models.User
	if err := r.db.Select("charm").First(&u, "id = ?", userID).Error; err != nil {
		return 0, err
	}
	return u.Charm, nil
}

func (r *Repository) History(userID uuid.UUID, direction string, cursorAt *time.Time, cursorID *uuid.UUID, limit int) ([]models.GiftTransaction, error) {
	column := "receiver_id"
	if direction == HistoryDirectionSent {
		column = "sender_id"
	}
	q := r.db.Where(column+" = ?", userID)
	if cursorAt != nil && cursorID != nil {
		q = q.Where("(created_at, id) < (?, ?)", *cursorAt, *cursorID)
	}
	var items []models.GiftTransaction
	err := q.Order("created_at DESC, id DESC").Limit(limit).Find(&items).Error
	return items, err
}

func leaderboardColumns(boardType string) (string, string) {
	if boardType == LeaderboardTypeSender {
		return "sender_id", "total_ken"
	}
	return "receiver_id", "charm_points"
}

func (r *Repository) aggregateQuery(boardType string, from *time.Time) *gorm.DB {
	userCol, valueCol := leaderboardColumns(boardType)
	q := r.db.Table("gift_transactions AS t").
		Select(fmt.Sprintf("t.%s AS user_id, SUM(t.%s) AS value", userCol, valueCol)).
		Joins(fmt.Sprintf("JOIN users u ON u.id = t.%s AND u.is_active = true AND u.deleted_at IS NULL", userCol)).
		Group("t." + userCol)
	if from != nil {
		q = q.Where("t.created_at >= ?", *from)
	}
	return q
}

func (r *Repository) Leaderboard(boardType string, from *time.Time, limit int) ([]LeaderboardRow, error) {
	var rows []LeaderboardRow
	if boardType == LeaderboardTypeReceiver && from == nil {
		err := r.db.Model(&models.User{}).
			Select("id AS user_id, charm AS value").
			Where("charm > 0 AND is_active = true").
			Order("charm DESC, id ASC").
			Limit(limit).
			Scan(&rows).Error
		return rows, err
	}
	err := r.aggregateQuery(boardType, from).Order("value DESC, user_id ASC").Limit(limit).Scan(&rows).Error
	return rows, err
}

func (r *Repository) Rank(boardType string, from *time.Time, userID uuid.UUID) (int, int64, error) {
	if boardType == LeaderboardTypeReceiver && from == nil {
		var u models.User
		if err := r.db.Select("charm", "is_active").First(&u, "id = ?", userID).Error; err != nil {
			return 0, 0, err
		}
		if u.Charm <= 0 || !u.IsActive {
			return 0, int64(u.Charm), nil
		}
		var ahead int64
		if err := r.db.Model(&models.User{}).
			Where("is_active = true AND (charm > ? OR (charm = ? AND id < ?))", u.Charm, u.Charm, userID).
			Count(&ahead).Error; err != nil {
			return 0, 0, err
		}
		return int(ahead) + 1, int64(u.Charm), nil
	}

	userCol, valueCol := leaderboardColumns(boardType)
	var mine struct{ Value int64 }
	q := r.db.Table("gift_transactions").Select(fmt.Sprintf("COALESCE(SUM(%s), 0) AS value", valueCol)).Where(userCol+" = ?", userID)
	if from != nil {
		q = q.Where("created_at >= ?", *from)
	}
	if err := q.Scan(&mine).Error; err != nil {
		return 0, 0, err
	}
	if mine.Value <= 0 {
		return 0, 0, nil
	}
	var ahead int64
	sub := r.aggregateQuery(boardType, from)
	if err := r.db.Table("(?) AS agg", sub).
		Where("agg.value > ? OR (agg.value = ? AND agg.user_id < ?)", mine.Value, mine.Value, userID).
		Count(&ahead).Error; err != nil {
		return 0, 0, err
	}
	return int(ahead) + 1, mine.Value, nil
}
