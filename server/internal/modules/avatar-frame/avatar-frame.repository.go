package avatarframe

import (
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/ledger"
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

func (r *Repository) ownedFrames(userID uuid.UUID, includeExpired bool, now time.Time) *gorm.DB {
	q := r.db.Model(&models.UserAvatarFrame{}).Where("user_id = ?", userID)
	if !includeExpired {
		q = q.Where(models.ItemNotExpiredSQL, now)
	}
	return q
}

func (r *Repository) OwnedFrameIDs(userID uuid.UUID) (map[string]bool, error) {
	var ids []string
	if err := r.db.Model(&models.UserAvatarFrame{}).
		Where("user_id = ? AND expires_at IS NULL", userID).
		Pluck("frame_id", &ids).Error; err != nil {
		return nil, err
	}
	out := make(map[string]bool, len(ids))
	for _, id := range ids {
		out[id] = true
	}
	return out, nil
}

func (r *Repository) CountOwned(userID uuid.UUID, includeExpired bool, now time.Time) (int64, error) {
	var count int64
	err := r.ownedFrames(userID, includeExpired, now).Count(&count).Error
	return count, err
}

func (r *Repository) ListOwned(userID uuid.UUID, equippedFrameID string, includeExpired bool, now time.Time, limit, offset int) ([]models.UserAvatarFrame, error) {
	var items []models.UserAvatarFrame
	err := r.ownedFrames(userID, includeExpired, now).
		Order(clause.OrderBy{Expression: clause.Expr{
			SQL:                "(frame_id = ?) DESC, (expires_at IS NOT NULL AND expires_at <= ?) ASC, (expires_at IS NULL) ASC, expires_at ASC, acquired_at DESC, id DESC",
			Vars:               []interface{}{equippedFrameID, now},
			WithoutParentheses: true,
		}}).
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, err
}

func clearEquippedFields() map[string]interface{} {
	return map[string]interface{}{"avatar_frame_id": nil, "avatar_frame_expires_at": nil}
}

func (r *Repository) ClearEquipped(userID uuid.UUID) error {
	return r.db.Model(&models.User{}).Where("id = ?", userID).Updates(clearEquippedFields()).Error
}

func clearExpiredEquippedTx(tx *gorm.DB, userID uuid.UUID, now time.Time) error {
	return tx.Model(&models.User{}).
		Where("id = ? AND avatar_frame_expires_at IS NOT NULL AND avatar_frame_expires_at <= ?", userID, now).
		Updates(clearEquippedFields()).Error
}

func (r *Repository) ClearExpiredEquipped(userID uuid.UUID, now time.Time) error {
	return clearExpiredEquippedTx(r.db, userID, now)
}

func (r *Repository) Equip(userID uuid.UUID, frameID string, now time.Time) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		locked, err := lockUsersInOrder(tx, userID)
		if err != nil {
			return err
		}
		row, err := findWearableFrameTx(tx, userID, frameID, now)
		if err != nil {
			return err
		}
		if !locked[userID].HasActiveVip(now) {
			return ErrVipRequired
		}
		return tx.Model(&models.User{}).Where("id = ?", userID).Updates(map[string]interface{}{
			"avatar_frame_id":         frameID,
			"avatar_frame_expires_at": row.ExpiresAt,
		}).Error
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
		u, err := ledger.LockUser(tx, id)
		if err != nil {
			return nil, err
		}
		locked[id] = u
	}
	return locked, nil
}

func OwnsPermanentFrameTx(tx *gorm.DB, userID uuid.UUID, frameID string) (bool, error) {
	var count int64
	err := tx.Model(&models.UserAvatarFrame{}).
		Where("user_id = ? AND frame_id = ? AND expires_at IS NULL", userID, frameID).
		Count(&count).Error
	return count > 0, err
}

func findFrameRowTx(tx *gorm.DB, userID uuid.UUID, frameID string, timed bool) (*models.UserAvatarFrame, error) {
	q := tx.Clauses(clause.Locking{Strength: "UPDATE"}).Where("user_id = ? AND frame_id = ?", userID, frameID)
	if timed {
		q = q.Where("expires_at IS NOT NULL")
	} else {
		q = q.Where("expires_at IS NULL")
	}
	var rows []models.UserAvatarFrame
	if err := q.Limit(1).Find(&rows).Error; err != nil {
		return nil, err
	}
	if len(rows) == 0 {
		return nil, nil
	}
	return &rows[0], nil
}

func findWearableFrameTx(tx *gorm.DB, userID uuid.UUID, frameID string, now time.Time) (*models.UserAvatarFrame, error) {
	permanent, err := findFrameRowTx(tx, userID, frameID, false)
	if err != nil || permanent != nil {
		return permanent, err
	}
	timed, err := findFrameRowTx(tx, userID, frameID, true)
	if err != nil {
		return nil, err
	}
	if timed == nil {
		return nil, ErrNotOwned
	}
	if timed.Expired(now) {
		return nil, ErrFrameExpired
	}
	return timed, nil
}

func findOwnedFrameRefTx(tx *gorm.DB, userID uuid.UUID, ref string) (*models.UserAvatarFrame, error) {
	q := tx.Clauses(clause.Locking{Strength: "UPDATE"}).Where("user_id = ?", userID)
	if rowID, err := uuid.Parse(ref); err == nil {
		q = q.Where("id = ?", rowID)
	} else {
		q = q.Where("frame_id = ?", ref).Order("(expires_at IS NULL) DESC")
	}
	var rows []models.UserAvatarFrame
	if err := q.Limit(1).Find(&rows).Error; err != nil {
		return nil, err
	}
	if len(rows) == 0 {
		return nil, ErrNotOwned
	}
	return &rows[0], nil
}

func wearsFrameRow(u *models.User, row *models.UserAvatarFrame) bool {
	return u.AvatarFrameID != nil && *u.AvatarFrameID == row.FrameID &&
		(u.AvatarFrameExpiresAt == nil) == (row.ExpiresAt == nil)
}

func syncTimedEquippedTx(tx *gorm.DB, userID uuid.UUID, frameID string, expiresAt *time.Time, now time.Time) error {
	if err := clearExpiredEquippedTx(tx, userID, now); err != nil {
		return err
	}
	return tx.Model(&models.User{}).
		Where("id = ? AND avatar_frame_id = ? AND avatar_frame_expires_at IS NOT NULL", userID, frameID).
		Update("avatar_frame_expires_at", expiresAt).Error
}

func wearPermanentCopyTx(tx *gorm.DB, userID uuid.UUID, frameID string, now time.Time) error {
	if err := clearExpiredEquippedTx(tx, userID, now); err != nil {
		return err
	}
	return tx.Model(&models.User{}).
		Where("id = ? AND avatar_frame_id = ? AND avatar_frame_expires_at IS NOT NULL", userID, frameID).
		Update("avatar_frame_expires_at", nil).Error
}

func timedFrameGrantFields(existing *models.UserAvatarFrame, source string, now time.Time, duration time.Duration) map[string]interface{} {
	if existing.Expired(now) {
		return map[string]interface{}{
			"source":      source,
			"acquired_at": now,
			"locked":      true,
			"expires_at":  now.Add(duration),
		}
	}
	return map[string]interface{}{"expires_at": existing.ExpiresAt.Add(duration), "locked": true}
}

func GrantFrameTx(tx *gorm.DB, userID uuid.UUID, frameID, source string, now time.Time, grant models.ItemGrant) (bool, error) {
	grant = grant.Normalized()
	timed := grant.Duration > 0
	existing, err := findFrameRowTx(tx, userID, frameID, timed)
	if err != nil {
		return false, err
	}
	if existing == nil {
		result := tx.Clauses(clause.OnConflict{DoNothing: true}).Create(&models.UserAvatarFrame{
			UserID:     userID,
			FrameID:    frameID,
			Source:     source,
			AcquiredAt: now,
			Locked:     grant.Locked,
			ExpiresAt:  grant.ExpiresAt(now),
		})
		if result.Error != nil || result.RowsAffected == 0 {
			return false, result.Error
		}
		if !timed {
			if err := wearPermanentCopyTx(tx, userID, frameID, now); err != nil {
				return false, err
			}
		}
		return true, nil
	}
	if !timed {
		return false, nil
	}
	fields := timedFrameGrantFields(existing, source, now, grant.Duration)
	if err := tx.Model(&models.UserAvatarFrame{}).Where("id = ?", existing.ID).Updates(fields).Error; err != nil {
		return false, err
	}
	expiresAt := fields["expires_at"].(time.Time)
	if err := syncTimedEquippedTx(tx, userID, frameID, &expiresAt, now); err != nil {
		return false, err
	}
	return true, nil
}

func (r *Repository) AdminUpdateFrame(userID uuid.UUID, ref string, locked bool, expiresAt *time.Time, now time.Time) (*models.UserAvatarFrame, error) {
	var row *models.UserAvatarFrame
	err := r.db.Transaction(func(tx *gorm.DB) error {
		if err := LockOwnerTx(tx, userID); err != nil {
			return err
		}
		found, err := findOwnedFrameRefTx(tx, userID, ref)
		if err != nil {
			return err
		}
		if (found.ExpiresAt == nil) != (expiresAt == nil) {
			return ErrExpiryKindFixed
		}
		if expiresAt != nil {
			locked = true
		}
		if err := tx.Model(&models.UserAvatarFrame{}).Where("id = ?", found.ID).
			Updates(map[string]interface{}{"locked": locked, "expires_at": expiresAt}).Error; err != nil {
			return err
		}
		if expiresAt != nil {
			if err := syncTimedEquippedTx(tx, userID, found.FrameID, expiresAt, now); err != nil {
				return err
			}
		}
		found.Locked = locked
		found.ExpiresAt = expiresAt
		row = found
		return nil
	})
	return row, err
}

func LockOwnerTx(tx *gorm.DB, userID uuid.UUID) error {
	_, err := lockUsersInOrder(tx, userID)
	return err
}

func (r *Repository) AdminGrant(userID uuid.UUID, frameID string, now time.Time, grant models.ItemGrant) (bool, error) {
	granted := false
	err := r.db.Transaction(func(tx *gorm.DB) error {
		if err := LockOwnerTx(tx, userID); err != nil {
			return err
		}
		ok, err := GrantFrameTx(tx, userID, frameID, models.AvatarFrameSourceAdmin, now, grant)
		granted = ok
		return err
	})
	return granted, err
}

func (r *Repository) AdminRevoke(userID uuid.UUID, ref string) (*models.UserAvatarFrame, bool, error) {
	var row *models.UserAvatarFrame
	unequipped := false
	err := r.db.Transaction(func(tx *gorm.DB) error {
		locked, err := lockUsersInOrder(tx, userID)
		if err != nil {
			return err
		}
		found, err := findOwnedFrameRefTx(tx, userID, ref)
		if err != nil {
			return err
		}
		row = found
		if wearsFrameRow(locked[userID], found) {
			if err := tx.Model(&models.User{}).Where("id = ?", userID).Updates(clearEquippedFields()).Error; err != nil {
				return err
			}
			unequipped = true
		}
		return tx.Delete(found).Error
	})
	return row, unequipped, err
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

		owned, err := OwnsPermanentFrameTx(tx, p.recipientID, item.FrameID)
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

		granted, err := GrantFrameTx(tx, p.recipientID, item.FrameID, p.source, time.Now(), models.PermanentGrant)
		if err != nil {
			if apperr.IsUniqueViolation(err) {
				return alreadyOwnedErr
			}
			return err
		}
		if !granted {
			return alreadyOwnedErr
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

		payerID := p.payerID
		if _, err := ledger.Debit(tx, payer, item.KenPrice, ledger.Entry{
			Type:        models.KenTxTypeAvatarFrame,
			Description: p.description,
			RefType:     KenRefTypePurchase,
			RefID:       &purchase.ID,
			ActorType:   models.KenActorUser,
			ActorID:     &payerID,
		}); err != nil {
			return err
		}

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
		now := time.Now()
		row, err := findFrameRowTx(tx, fromID, frameID, false)
		if err != nil {
			return err
		}
		if row == nil {
			return transferBlockReasonTx(tx, fromID, frameID, now)
		}
		if row.Locked {
			return ErrNotTransferable
		}
		if wearsFrameRow(locked[fromID], row) {
			return ErrInUse
		}
		owned, err := OwnsPermanentFrameTx(tx, toID, frameID)
		if err != nil {
			return err
		}
		if owned {
			return ErrReceiverOwns
		}
		res := tx.Model(&models.UserAvatarFrame{}).
			Where("id = ? AND user_id = ?", row.ID, fromID).
			Updates(map[string]interface{}{
				"user_id":     toID,
				"source":      models.AvatarFrameSourceTransfer,
				"acquired_at": now,
			})
		if res.Error != nil {
			if apperr.IsUniqueViolation(res.Error) {
				return ErrReceiverOwns
			}
			return res.Error
		}
		if res.RowsAffected != 1 {
			return ErrNotOwned
		}
		if err := wearPermanentCopyTx(tx, toID, frameID, now); err != nil {
			return err
		}
		return tx.Create(&models.AvatarFrameTransfer{
			FromUserID: fromID,
			ToUserID:   toID,
			FrameID:    frameID,
		}).Error
	})
}

func transferBlockReasonTx(tx *gorm.DB, userID uuid.UUID, frameID string, now time.Time) error {
	timed, err := findFrameRowTx(tx, userID, frameID, true)
	if err != nil {
		return err
	}
	if timed == nil {
		return ErrNotOwned
	}
	if timed.Expired(now) {
		return ErrFrameExpired
	}
	return ErrNotTransferable
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
