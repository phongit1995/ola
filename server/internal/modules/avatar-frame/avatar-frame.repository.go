package avatarframe

import (
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

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

func (r *Repository) GetUser(userID uuid.UUID) (*models.User, error) {
	var u models.User
	if err := r.db.First(&u, "id = ?", userID).Error; err != nil {
		return nil, err
	}
	return &u, nil
}

func (r *Repository) FindByUsername(username string) (*models.User, error) {
	var u models.User
	if err := r.db.Where("LOWER(username) = LOWER(?)", username).First(&u).Error; err != nil {
		return nil, err
	}
	return &u, nil
}

var shopItemOrder = utils.OrderedList{
	Model:    &models.AvatarFrameShopItem{},
	Table:    "avatar_frame_shop_items",
	Column:   "sort_order",
	OrderSQL: "sort_order ASC, created_at DESC",
}

func (r *Repository) ReorderShopItems(ids []uuid.UUID) error {
	return shopItemOrder.Reorder(r.db, ids)
}

func (r *Repository) PlaceShopItems(ids []uuid.UUID, position int) (int, error) {
	return shopItemOrder.Place(r.db, position, func(*gorm.DB) ([]uuid.UUID, error) {
		return ids, nil
	})
}

func (r *Repository) UpdateShopItemAt(id uuid.UUID, fields map[string]interface{}, position int) error {
	_, err := shopItemOrder.PlaceOne(r.db, position, &id, func(tx *gorm.DB) error {
		return tx.Model(&models.AvatarFrameShopItem{}).Where("id = ?", id).Updates(fields).Error
	})
	return err
}

func (r *Repository) ListShopItems(activeOnly bool) ([]models.AvatarFrameShopItem, error) {
	var items []models.AvatarFrameShopItem
	q := r.db.Order("sort_order ASC, created_at DESC")
	if activeOnly {
		q = q.Where("is_active = ?", true)
	}
	err := q.Find(&items).Error
	return items, err
}

func (r *Repository) FindShopItem(id uuid.UUID) (*models.AvatarFrameShopItem, error) {
	var item models.AvatarFrameShopItem
	if err := r.db.First(&item, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) FindActiveShopItem(id uuid.UUID) (*models.AvatarFrameShopItem, error) {
	var item models.AvatarFrameShopItem
	if err := r.db.Where("is_active = ?", true).First(&item, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) ShopFrameIDs(frameIDs []string) (map[string]bool, error) {
	var existing []string
	if err := r.db.Model(&models.AvatarFrameShopItem{}).
		Where("frame_id IN ?", frameIDs).
		Pluck("frame_id", &existing).Error; err != nil {
		return nil, err
	}
	out := make(map[string]bool, len(existing))
	for _, id := range existing {
		out[id] = true
	}
	return out, nil
}

func (r *Repository) CreateShopItem(item *models.AvatarFrameShopItem) error {
	return r.db.Create(item).Error
}

func (r *Repository) UpdateShopItem(id uuid.UUID, fields map[string]interface{}) error {
	return r.db.Model(&models.AvatarFrameShopItem{}).Where("id = ?", id).Updates(fields).Error
}

func (r *Repository) SoftDeleteShopItem(id uuid.UUID) error {
	return r.db.Delete(&models.AvatarFrameShopItem{}, "id = ?", id).Error
}

func (r *Repository) OwnedFrameIDs(userID uuid.UUID) (map[string]bool, error) {
	var ids []string
	if err := r.db.Model(&models.UserAvatarFrame{}).
		Where("user_id = ?", userID).
		Pluck("frame_id", &ids).Error; err != nil {
		return nil, err
	}
	out := make(map[string]bool, len(ids))
	for _, id := range ids {
		out[id] = true
	}
	return out, nil
}

func (r *Repository) CountOwned(userID uuid.UUID) (int64, error) {
	var count int64
	err := r.db.Model(&models.UserAvatarFrame{}).Where("user_id = ?", userID).Count(&count).Error
	return count, err
}

func (r *Repository) ListOwned(userID uuid.UUID, equippedFrameID string, limit, offset int) ([]models.UserAvatarFrame, error) {
	var items []models.UserAvatarFrame
	err := r.db.
		Where("user_id = ?", userID).
		Order(clause.OrderBy{Expression: clause.Expr{
			SQL:                "(frame_id = ?) DESC, acquired_at DESC, id DESC",
			Vars:               []interface{}{equippedFrameID},
			WithoutParentheses: true,
		}}).
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, err
}

func (r *Repository) ClearEquipped(userID uuid.UUID) error {
	return r.db.Model(&models.User{}).Where("id = ?", userID).Update("avatar_frame_id", nil).Error
}

func (r *Repository) Equip(userID uuid.UUID, frameID string, now time.Time) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		locked, err := lockUsersInOrder(tx, userID)
		if err != nil {
			return err
		}
		owned, err := ownsInTx(tx, userID, frameID)
		if err != nil {
			return err
		}
		if !owned {
			return ErrNotOwned
		}
		if !locked[userID].HasActiveVip(now) {
			return ErrVipRequired
		}
		return tx.Model(&models.User{}).Where("id = ?", userID).Update("avatar_frame_id", frameID).Error
	})
}

func (r *Repository) GetStorePrivacy(userID uuid.UUID) (int16, error) {
	var setting models.UserSetting
	err := r.db.Select("avatar_frame_store_privacy").First(&setting, "user_id = ?", userID).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return 0, nil
	}
	if err != nil {
		return 0, err
	}
	return setting.AvatarFrameStorePrivacy, nil
}

func (r *Repository) SetStorePrivacy(userID uuid.UUID, privacy int16) error {
	return r.db.Exec(
		`INSERT INTO user_settings (user_id, avatar_frame_store_privacy) VALUES (?, ?)
		 ON CONFLICT (user_id) DO UPDATE SET avatar_frame_store_privacy = EXCLUDED.avatar_frame_store_privacy, updated_at = CURRENT_TIMESTAMP`,
		userID, privacy,
	).Error
}

func (r *Repository) AreFriends(a, b uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Model(&models.Relationship{}).
		Where("status = ? AND ((requester_id = ? AND addressee_id = ?) OR (requester_id = ? AND addressee_id = ?))",
			models.RelationshipStatusAccepted, a, b, b, a).
		Count(&count).Error
	return count > 0, err
}

func lockUsersInOrder(tx *gorm.DB, ids ...uuid.UUID) (map[uuid.UUID]*models.User, error) {
	ordered := append([]uuid.UUID(nil), ids...)
	for i := 1; i < len(ordered); i++ {
		for j := i; j > 0 && ordered[j].String() < ordered[j-1].String(); j-- {
			ordered[j], ordered[j-1] = ordered[j-1], ordered[j]
		}
	}
	locked := make(map[uuid.UUID]*models.User, len(ordered))
	for _, id := range ordered {
		var u models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", id).Error; err != nil {
			return nil, err
		}
		locked[id] = &u
	}
	return locked, nil
}

func ownsInTx(tx *gorm.DB, userID uuid.UUID, frameID string) (bool, error) {
	var count int64
	err := tx.Model(&models.UserAvatarFrame{}).
		Where("user_id = ? AND frame_id = ?", userID, frameID).
		Count(&count).Error
	return count > 0, err
}

type purchaseParams struct {
	payerID       uuid.UUID
	recipientID   uuid.UUID
	item          *models.AvatarFrameShopItem
	expectedPrice int
	source        string
	description   string
}

func lockSellableItem(tx *gorm.DB, id uuid.UUID, expectedPrice int) (*models.AvatarFrameShopItem, error) {
	var item models.AvatarFrameShopItem
	err := tx.Clauses(clause.Locking{Strength: "SHARE"}).
		Where("id = ? AND is_active = ?", id, true).
		First(&item).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, ErrShopItemNotFound
	}
	if err != nil {
		return nil, err
	}
	if item.KenPrice != expectedPrice {
		return nil, ErrPriceChanged
	}
	return &item, nil
}

func (r *Repository) purchase(p purchaseParams, alreadyOwnedErr error) (*models.User, error) {
	var payerAfter models.User
	err := r.db.Transaction(func(tx *gorm.DB) error {
		locked, err := lockUsersInOrder(tx, uniqueIDs(p.payerID, p.recipientID)...)
		if err != nil {
			return err
		}
		payer := locked[p.payerID]

		item, err := lockSellableItem(tx, p.item.ID, p.expectedPrice)
		if err != nil {
			return err
		}

		owned, err := ownsInTx(tx, p.recipientID, item.FrameID)
		if err != nil {
			return err
		}
		if owned {
			return alreadyOwnedErr
		}
		if payer.Ken < item.KenPrice {
			return ErrInsufficientKen
		}
		newKen := payer.Ken - item.KenPrice
		if err := tx.Model(&models.User{}).Where("id = ?", p.payerID).Update("ken", newKen).Error; err != nil {
			return err
		}

		now := time.Now()
		frame := models.UserAvatarFrame{
			UserID:     p.recipientID,
			FrameID:    item.FrameID,
			Source:     p.source,
			AcquiredAt: now,
		}
		if err := tx.Create(&frame).Error; err != nil {
			if apperr.IsUniqueViolation(err) {
				return alreadyOwnedErr
			}
			return err
		}

		shopItemID := item.ID
		purchase := models.AvatarFramePurchase{
			UserID:          p.payerID,
			ShopItemID:      &shopItemID,
			FrameID:         item.FrameID,
			KenPrice:        item.KenPrice,
			KenBalanceAfter: newKen,
			Source:          p.source,
		}
		if p.recipientID != p.payerID {
			recipient := p.recipientID
			purchase.RecipientUserID = &recipient
		}
		if err := tx.Create(&purchase).Error; err != nil {
			return err
		}

		if item.KenPrice > 0 {
			payerID := p.payerID
			kenTx := models.KenTransaction{
				UserID:        p.payerID,
				Direction:     models.KenDirectionDebit,
				Type:          models.KenTxTypeAvatarFrame,
				Amount:        item.KenPrice,
				BalanceBefore: payer.Ken,
				BalanceAfter:  newKen,
				Description:   p.description,
				RefType:       KenRefTypePurchase,
				RefID:         &purchase.ID,
				ActorType:     models.KenActorUser,
				ActorID:       &payerID,
			}
			if err := tx.Create(&kenTx).Error; err != nil {
				return err
			}
		}

		payer.Ken = newKen
		payerAfter = *payer
		return nil
	})
	if err != nil {
		return nil, err
	}
	return &payerAfter, nil
}

func uniqueIDs(ids ...uuid.UUID) []uuid.UUID {
	seen := make(map[uuid.UUID]bool, len(ids))
	out := make([]uuid.UUID, 0, len(ids))
	for _, id := range ids {
		if !seen[id] {
			seen[id] = true
			out = append(out, id)
		}
	}
	return out
}

func (r *Repository) Purchase(userID uuid.UUID, item *models.AvatarFrameShopItem, expectedPrice int) (*models.User, error) {
	return r.purchase(purchaseParams{
		payerID:       userID,
		recipientID:   userID,
		item:          item,
		expectedPrice: expectedPrice,
		source:        models.AvatarFrameSourcePurchase,
		description:   fmt.Sprintf("Mua khung avatar #%s", item.FrameID),
	}, ErrAlreadyOwned)
}

func (r *Repository) Gift(fromID uuid.UUID, receiver *models.User, item *models.AvatarFrameShopItem, expectedPrice int) (*models.User, error) {
	return r.purchase(purchaseParams{
		payerID:       fromID,
		recipientID:   receiver.ID,
		item:          item,
		expectedPrice: expectedPrice,
		source:        models.AvatarFrameSourceGift,
		description:   fmt.Sprintf("Tặng khung avatar #%s cho @%s", item.FrameID, receiver.Username),
	}, ErrReceiverOwns)
}

func (r *Repository) Transfer(fromID, toID uuid.UUID, frameID string) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		locked, err := lockUsersInOrder(tx, fromID, toID)
		if err != nil {
			return err
		}
		sender := locked[fromID]
		if sender.AvatarFrameID != nil && *sender.AvatarFrameID == frameID {
			return ErrInUse
		}

		var row models.UserAvatarFrame
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).
			Where("user_id = ? AND frame_id = ?", fromID, frameID).
			First(&row).Error; err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				return ErrNotOwned
			}
			return err
		}

		owned, err := ownsInTx(tx, toID, frameID)
		if err != nil {
			return err
		}
		if owned {
			return ErrReceiverOwns
		}

		if err := tx.Model(&models.UserAvatarFrame{}).
			Where("id = ?", row.ID).
			Updates(map[string]interface{}{
				"user_id":     toID,
				"source":      models.AvatarFrameSourceTransfer,
				"acquired_at": time.Now(),
			}).Error; err != nil {
			if apperr.IsUniqueViolation(err) {
				return ErrReceiverOwns
			}
			return err
		}

		return tx.Create(&models.AvatarFrameTransfer{
			FromUserID: fromID,
			ToUserID:   toID,
			FrameID:    frameID,
		}).Error
	})
}

type PurchaseFilter struct {
	UserID *uuid.UUID
	Mode   string
	Search string
	From   *time.Time
	To     *time.Time
}

func (r *Repository) usersMatching(q string) *gorm.DB {
	like := "%" + q + "%"
	return r.db.Model(&models.User{}).
		Select("id").
		Where("username ILIKE ? OR full_name ILIKE ?", like, like)
}

func (r *Repository) ListPurchases(f PurchaseFilter, limit, offset int) ([]models.AvatarFramePurchase, int64, error) {
	q := r.db.Model(&models.AvatarFramePurchase{})
	if f.UserID != nil {
		q = q.Where("user_id = ? OR recipient_user_id = ?", *f.UserID, *f.UserID)
	}
	switch f.Mode {
	case models.AvatarFrameSourcePurchase, models.AvatarFrameSourceGift:
		q = q.Where("source = ?", f.Mode)
	}
	if f.From != nil {
		q = q.Where("created_at >= ?", *f.From)
	}
	if f.To != nil {
		q = q.Where("created_at < ?", *f.To)
	}
	if f.Search != "" {
		q = q.Where("user_id IN (?) OR recipient_user_id IN (?) OR frame_id = ?",
			r.usersMatching(f.Search), r.usersMatching(f.Search), f.Search)
	}
	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var items []models.AvatarFramePurchase
	err := q.Order("created_at DESC").Limit(limit).Offset(offset).Find(&items).Error
	return items, total, err
}

func (r *Repository) ListTransfers(userID *uuid.UUID, search string, limit, offset int) ([]models.AvatarFrameTransfer, int64, error) {
	q := r.db.Model(&models.AvatarFrameTransfer{})
	if userID != nil {
		q = q.Where("from_user_id = ? OR to_user_id = ?", *userID, *userID)
	}
	if search != "" {
		q = q.Where("from_user_id IN (?) OR to_user_id IN (?) OR frame_id = ?",
			r.usersMatching(search), r.usersMatching(search), search)
	}
	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var items []models.AvatarFrameTransfer
	err := q.Order("created_at DESC").Limit(limit).Offset(offset).Find(&items).Error
	return items, total, err
}

func (r *Repository) FindUsers(ids []uuid.UUID) (map[uuid.UUID]models.User, error) {
	out := make(map[uuid.UUID]models.User, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	var rows []models.User
	if err := r.db.Unscoped().Select("id", "username", "full_name").Where("id IN ?", ids).Find(&rows).Error; err != nil {
		return nil, err
	}
	for _, u := range rows {
		out[u.ID] = u
	}
	return out, nil
}

type PurchaseTotals struct {
	Count     int64 `json:"count"`
	Ken       int64 `json:"ken"`
	GiftCount int64 `json:"giftCount"`
	Buyers    int64 `json:"buyers"`
}

func (r *Repository) PurchaseTotals(from, to *time.Time) (PurchaseTotals, error) {
	var t PurchaseTotals
	q := r.db.Model(&models.AvatarFramePurchase{}).
		Select("COUNT(*) AS count, COALESCE(SUM(ken_price), 0) AS ken, COUNT(*) FILTER (WHERE source = ?) AS gift_count, COUNT(DISTINCT user_id) AS buyers", models.AvatarFrameSourceGift)
	if from != nil {
		q = q.Where("created_at >= ?", *from)
	}
	if to != nil {
		q = q.Where("created_at < ?", *to)
	}
	err := q.Scan(&t).Error
	return t, err
}

type FrameSalesRow struct {
	FrameID   string `json:"frameId"`
	Count     int64  `json:"count"`
	GiftCount int64  `json:"giftCount"`
	Ken       int64  `json:"ken"`
}

func (r *Repository) TopFrames(from, to time.Time, limit int) ([]FrameSalesRow, error) {
	var rows []FrameSalesRow
	err := r.db.Model(&models.AvatarFramePurchase{}).
		Select("frame_id, COUNT(*) AS count, COUNT(*) FILTER (WHERE source = ?) AS gift_count, COALESCE(SUM(ken_price), 0) AS ken", models.AvatarFrameSourceGift).
		Where("created_at >= ? AND created_at < ?", from, to).
		Group("frame_id").
		Order("ken DESC, count DESC").
		Limit(limit).
		Scan(&rows).Error
	return rows, err
}
