package vip

import (
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/ledger"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

const (
	PurchaseSourcePackage  = "package"
	PurchaseSourceIcon     = "icon"
	PurchaseSourceGift     = "gift"
	PurchaseSourceGiftCode = "gift_code"

	PurchaseSourceDayTransferOut = "day_transfer_out"
	PurchaseSourceDayTransferIn  = "day_transfer_in"

	IconSourcePurchase = "purchase"
	IconSourceGift     = "gift"
	IconSourceEgg      = "egg"
	IconSourceWheel    = "wheel"
	IconSourceGiftCode = "gift_code"

	kenRefTypePurchase = "vip_purchase"

	iconPurchaseNameFormat = "VIP #%d"

	dayTransferOutNameFormat = "Chuyển cho @%s, nhận %d ngày"
	dayTransferInNameFormat  = "Nhận ngày VIP từ @%s"

	PurchasePaidExpr     = "COALESCE(kt.amount, vp.ken_price)"
	PurchasePayerExpr    = "CASE WHEN vp.source = 'gift' THEN kt.user_id ELSE vp.user_id END"
	PurchaseIsPackageSQL = "vp.package_id IS NOT NULL"

	purchasePaymentJoin = "LEFT JOIN ken_transactions kt ON kt.ref_type = 'vip_purchase' AND kt.ref_id = vp.id AND kt.direction = 'debit' AND kt.deleted_at IS NULL"
)

var PurchaseBuySources = []string{PurchaseSourcePackage, PurchaseSourceIcon, PurchaseSourceGift}

var PurchaseDayTransferSources = []string{PurchaseSourceDayTransferOut, PurchaseSourceDayTransferIn}

func IconPurchaseName(vipTypeID int16) string {
	return fmt.Sprintf(iconPurchaseNameFormat, vipTypeID)
}

func IconIDFromPurchaseName(name string) int {
	var id int
	if _, err := fmt.Sscanf(name, iconPurchaseNameFormat, &id); err != nil {
		return 0
	}
	return id
}

// BoughtPurchases selects vip_purchases rows paid with KEN (own purchase or gift), aliased vp,
// joined with the payer's debit transaction as kt: gift rows store ken_price 0 on the receiver.
func BoughtPurchases(db *gorm.DB) *gorm.DB {
	return db.Table("vip_purchases vp").
		Joins(purchasePaymentJoin).
		Where("vp.deleted_at IS NULL AND vp.source IN ?", PurchaseBuySources)
}

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

func (r *Repository) UserExists(userID uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Model(&models.User{}).Where("id = ?", userID).Count(&count).Error
	return count > 0, err
}

func (r *Repository) CountByUser(userID uuid.UUID) (int64, error) {
	var count int64
	err := r.db.Model(&models.UserVipIcon{}).Where("user_id = ?", userID).Count(&count).Error
	return count, err
}

func (r *Repository) ListByUserPaged(userID uuid.UUID, activeTypeID int16, limit, offset int) ([]models.UserVipIcon, error) {
	var items []models.UserVipIcon
	order := fmt.Sprintf("(vip_icon_id = %d) DESC, acquired_at DESC", activeTypeID)
	err := r.db.
		Where("user_id = ?", userID).
		Order(order).
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, err
}

func (r *Repository) FindInstance(id uuid.UUID) (*models.UserVipIcon, error) {
	var item models.UserVipIcon
	if err := r.db.First(&item, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) FindOneOfTypeExcluding(userID uuid.UUID, typeID int16, excludeID uuid.UUID) (*models.UserVipIcon, error) {
	var items []models.UserVipIcon
	err := r.db.
		Where("user_id = ? AND vip_icon_id = ? AND id <> ?", userID, typeID, excludeID).
		Order("acquired_at DESC").
		Limit(1).
		Find(&items).Error
	if err != nil {
		return nil, err
	}
	if len(items) == 0 {
		return nil, nil
	}
	return &items[0], nil
}

func (r *Repository) Create(item *models.UserVipIcon) error {
	return r.db.Create(item).Error
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.UserVipIcon{}, "id = ?", id).Error
}

func (r *Repository) FindInstances(ids []uuid.UUID) ([]models.UserVipIcon, error) {
	var items []models.UserVipIcon
	err := r.db.Where("id IN ?", ids).Find(&items).Error
	return items, err
}

func (r *Repository) SoftDeleteMany(userID uuid.UUID, ids []uuid.UUID) (int64, error) {
	res := r.db.
		Where("user_id = ? AND is_locked = ?", userID, false).
		Delete(&models.UserVipIcon{}, "id IN ?", ids)
	return res.RowsAffected, res.Error
}

func (r *Repository) SetLocked(id uuid.UUID, locked bool) error {
	return r.db.Model(&models.UserVipIcon{}).
		Where("id = ?", id).
		Update("is_locked", locked).Error
}

type TransferParams struct {
	InstanceID uuid.UUID
	FromUserID uuid.UUID
	ToUserID   uuid.UUID
	VipIconID  int16
}

func (r *Repository) Transfer(p TransferParams) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&models.UserVipIcon{}).
			Where("id = ?", p.InstanceID).
			Updates(map[string]interface{}{
				"user_id": p.ToUserID,
				"source":  "transfer",
			}).Error; err != nil {
			return err
		}
		log := models.VipTransfer{
			FromUserID: p.FromUserID,
			ToUserID:   p.ToUserID,
			VipIconID:  p.VipIconID,
			InstanceID: p.InstanceID,
		}
		return tx.Create(&log).Error
	})
}

func (r *Repository) ListTransfers(userID *uuid.UUID, q string, limit, offset int) ([]models.VipTransfer, int64, error) {
	var items []models.VipTransfer
	var total int64

	countQ := r.db.Model(&models.VipTransfer{})
	listQ := r.db.Model(&models.VipTransfer{}).Order("created_at DESC").Limit(limit).Offset(offset)
	if userID != nil {
		countQ = countQ.Where("from_user_id = ? OR to_user_id = ?", *userID, *userID)
		listQ = listQ.Where("from_user_id = ? OR to_user_id = ?", *userID, *userID)
	}
	if q != "" {
		var ids []uuid.UUID
		like := "%" + q + "%"
		if err := r.db.Model(&models.User{}).
			Where("username ILIKE ? OR full_name ILIKE ?", like, like).
			Pluck("id", &ids).Error; err != nil {
			return nil, 0, err
		}
		if len(ids) == 0 {
			return []models.VipTransfer{}, 0, nil
		}
		countQ = countQ.Where("from_user_id IN ? OR to_user_id IN ?", ids, ids)
		listQ = listQ.Where("from_user_id IN ? OR to_user_id IN ?", ids, ids)
	}
	if err := countQ.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	if err := listQ.Find(&items).Error; err != nil {
		return nil, 0, err
	}
	return items, total, nil
}

type TransferUser struct {
	ID       uuid.UUID
	Username string
	FullName string
}

func (r *Repository) FindUsers(ids []uuid.UUID) (map[uuid.UUID]TransferUser, error) {
	result := make(map[uuid.UUID]TransferUser, len(ids))
	if len(ids) == 0 {
		return result, nil
	}
	var rows []TransferUser
	if err := r.db.Unscoped().Model(&models.User{}).
		Select("id", "username", "full_name").
		Where("id IN ?", ids).
		Find(&rows).Error; err != nil {
		return nil, err
	}
	for _, u := range rows {
		result[u.ID] = u
	}
	return result, nil
}

func (r *Repository) UpdateUserFields(userID uuid.UUID, fields map[string]interface{}) error {
	return r.db.Model(&models.User{}).
		Where("id = ?", userID).
		Updates(fields).Error
}

func (r *Repository) GetVipStorePrivacy(userID uuid.UUID) (int16, error) {
	var setting models.UserSetting
	err := r.db.Select("vip_store_privacy").First(&setting, "user_id = ?", userID).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return 0, nil
	}
	if err != nil {
		return 0, err
	}
	return setting.VipStorePrivacy, nil
}

func (r *Repository) SetVipStorePrivacy(userID uuid.UUID, privacy int16) error {
	return r.db.Exec(
		`INSERT INTO user_settings (user_id, vip_store_privacy) VALUES (?, ?)
		 ON CONFLICT (user_id) DO UPDATE SET vip_store_privacy = EXCLUDED.vip_store_privacy, updated_at = CURRENT_TIMESTAMP`,
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

var (
	packageOrder = utils.OrderedList{
		Model:    &models.VipPackage{},
		Table:    "vip_packages",
		Column:   "sort_order",
		OrderSQL: "sort_order ASC, created_at ASC",
	}
	shopItemOrder = utils.OrderedList{
		Model:    &models.VipShopItem{},
		Table:    "vip_shop_items",
		Column:   "sort_order",
		OrderSQL: "sort_order ASC, created_at ASC",
	}
)

func (r *Repository) ReorderPackages(ids []uuid.UUID) error {
	return packageOrder.Reorder(r.db, ids)
}

func (r *Repository) CreatePackageAt(pkg *models.VipPackage, position int) error {
	placed, err := packageOrder.PlaceOne(r.db, position, &pkg.ID, func(tx *gorm.DB) error {
		return tx.Create(pkg).Error
	})
	if err != nil {
		return err
	}
	pkg.SortOrder = placed
	return nil
}

func (r *Repository) UpdatePackageAt(id uuid.UUID, fields map[string]interface{}, position int) error {
	_, err := packageOrder.PlaceOne(r.db, position, &id, func(tx *gorm.DB) error {
		return tx.Model(&models.VipPackage{}).Where("id = ?", id).Updates(fields).Error
	})
	return err
}

func (r *Repository) ReorderShopItems(ids []uuid.UUID) error {
	return shopItemOrder.Reorder(r.db, ids)
}

func (r *Repository) CreateShopItemAt(item *models.VipShopItem, position int) error {
	placed, err := shopItemOrder.PlaceOne(r.db, position, &item.ID, func(tx *gorm.DB) error {
		return tx.Create(item).Error
	})
	if err != nil {
		return err
	}
	item.SortOrder = placed
	return nil
}

func (r *Repository) UpdateShopItemAt(id uuid.UUID, fields map[string]interface{}, position int) error {
	_, err := shopItemOrder.PlaceOne(r.db, position, &id, func(tx *gorm.DB) error {
		return tx.Model(&models.VipShopItem{}).Where("id = ?", id).Updates(fields).Error
	})
	return err
}

func (r *Repository) ListActivePackages() ([]models.VipPackage, error) {
	var pkgs []models.VipPackage
	err := r.db.
		Where("is_active = ?", true).
		Order("sort_order ASC, created_at ASC").
		Find(&pkgs).Error
	return pkgs, err
}

func (r *Repository) ListAllPackages(limit, offset int) ([]models.VipPackage, int64, error) {
	var pkgs []models.VipPackage
	var total int64
	if err := r.db.Model(&models.VipPackage{}).Count(&total).Error; err != nil {
		return nil, 0, err
	}
	err := r.db.
		Order("sort_order ASC, created_at ASC").
		Limit(limit).
		Offset(offset).
		Find(&pkgs).Error
	return pkgs, total, err
}

func (r *Repository) FindPackage(id uuid.UUID) (*models.VipPackage, error) {
	var pkg models.VipPackage
	if err := r.db.First(&pkg, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &pkg, nil
}

func (r *Repository) FindActivePackage(id uuid.UUID) (*models.VipPackage, error) {
	var pkg models.VipPackage
	if err := r.db.First(&pkg, "id = ? AND is_active = ?", id, true).Error; err != nil {
		return nil, err
	}
	return &pkg, nil
}

func (r *Repository) UpdatePackage(id uuid.UUID, fields map[string]interface{}) error {
	return r.db.Model(&models.VipPackage{}).Where("id = ?", id).Updates(fields).Error
}

func (r *Repository) SoftDeletePackage(id uuid.UUID) error {
	return r.db.Delete(&models.VipPackage{}, "id = ?", id).Error
}

func (r *Repository) ListHistory(userID *uuid.UUID, limit, offset int) ([]models.VipPurchase, int64, error) {
	var items []models.VipPurchase
	var total int64

	countQ := r.db.Model(&models.VipPurchase{})
	listQ := r.db.Model(&models.VipPurchase{}).Order("created_at DESC").Limit(limit).Offset(offset)
	if userID != nil {
		countQ = countQ.Where("user_id = ?", *userID)
		listQ = listQ.Where("user_id = ?", *userID)
	}
	if err := countQ.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	if err := listQ.Find(&items).Error; err != nil {
		return nil, 0, err
	}
	return items, total, nil
}

func (r *Repository) ListActiveShopItems() ([]models.VipShopItem, error) {
	var items []models.VipShopItem
	err := r.db.Where("is_active = ?", true).Order("sort_order ASC, created_at ASC").Find(&items).Error
	return items, err
}

func (r *Repository) ListAllShopItems() ([]models.VipShopItem, error) {
	var items []models.VipShopItem
	err := r.db.Order("sort_order ASC, created_at ASC").Find(&items).Error
	return items, err
}

func (r *Repository) FindShopItem(id uuid.UUID) (*models.VipShopItem, error) {
	var item models.VipShopItem
	if err := r.db.First(&item, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) FindActiveShopItem(id uuid.UUID) (*models.VipShopItem, error) {
	var item models.VipShopItem
	if err := r.db.First(&item, "id = ? AND is_active = ?", id, true).Error; err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) ShopTypeExists(vipTypeID int16) (bool, error) {
	var count int64
	err := r.db.Model(&models.VipShopItem{}).Where("vip_type_id = ?", vipTypeID).Count(&count).Error
	return count > 0, err
}

func (r *Repository) UpdateShopItem(id uuid.UUID, fields map[string]interface{}) error {
	return r.db.Model(&models.VipShopItem{}).Where("id = ?", id).Updates(fields).Error
}

func (r *Repository) SoftDeleteShopItem(id uuid.UUID) error {
	return r.db.Delete(&models.VipShopItem{}, "id = ?", id).Error
}

func (r *Repository) PurchaseShopItem(userID uuid.UUID, item *models.VipShopItem) (*models.UserVipIcon, *models.User, error) {
	var icon models.UserVipIcon
	var updatedUser models.User

	err := r.db.Transaction(func(tx *gorm.DB) error {
		u, err := ledger.LockUser(tx, userID)
		if err != nil {
			return err
		}
		if err := ledger.EnsureBalance(u, item.KenPrice); err != nil {
			return err
		}
		newKen := u.Ken - item.KenPrice

		created, err := CreateIconTx(tx, userID, item.VipTypeID, IconSourcePurchase)
		if err != nil {
			return err
		}
		icon = *created

		endAfter := time.Now()
		if u.VipEndTime != nil {
			endAfter = *u.VipEndTime
		}
		purchase := models.VipPurchase{
			UserID:          userID,
			PackageName:     IconPurchaseName(item.VipTypeID),
			Days:            0,
			KenPrice:        item.KenPrice,
			KenBalanceAfter: newKen,
			VipEndTimeAfter: endAfter,
			Source:          PurchaseSourceIcon,
		}
		if err := tx.Create(&purchase).Error; err != nil {
			return err
		}

		if _, err := ledger.Debit(tx, u, item.KenPrice, ledger.Entry{
			Type:        models.KenTxTypeVipIcon,
			Description: purchase.PackageName,
			RefType:     kenRefTypePurchase,
			RefID:       &purchase.ID,
			ActorType:   models.KenActorUser,
			ActorID:     &userID,
		}); err != nil {
			return err
		}

		updatedUser = *u
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return &icon, &updatedUser, nil
}

func (r *Repository) GiftShopItem(fromID uuid.UUID, receiver *models.User, item *models.VipShopItem) (*models.UserVipIcon, *models.User, error) {
	var icon models.UserVipIcon
	var giver models.User

	err := r.db.Transaction(func(tx *gorm.DB) error {
		from, to, err := ledger.LockUserPair(tx, fromID, receiver.ID)
		if err != nil {
			return err
		}

		if err := ledger.EnsureBalance(from, item.KenPrice); err != nil {
			return err
		}

		created, err := CreateIconTx(tx, to.ID, item.VipTypeID, IconSourceGift)
		if err != nil {
			return err
		}
		icon = *created

		endAfter := time.Now()
		if to.VipEndTime != nil {
			endAfter = *to.VipEndTime
		}
		purchase := models.VipPurchase{
			UserID:          to.ID,
			PackageName:     IconPurchaseName(item.VipTypeID),
			Days:            0,
			KenPrice:        0,
			KenBalanceAfter: to.Ken,
			VipEndTimeAfter: endAfter,
			Source:          PurchaseSourceGift,
		}
		if err := tx.Create(&purchase).Error; err != nil {
			return err
		}

		if _, err := ledger.Debit(tx, from, item.KenPrice, ledger.Entry{
			Type:        models.KenTxTypeVipIcon,
			Description: fmt.Sprintf("Tặng %s cho @%s", purchase.PackageName, to.Username),
			RefType:     kenRefTypePurchase,
			RefID:       &purchase.ID,
			ActorType:   models.KenActorUser,
			ActorID:     &fromID,
		}); err != nil {
			return err
		}

		giver = *from
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return &icon, &giver, nil
}

func (r *Repository) FindByUsername(username string) (*models.User, error) {
	var u models.User
	if err := r.db.Where("LOWER(username) = LOWER(?)", username).First(&u).Error; err != nil {
		return nil, err
	}
	return &u, nil
}

func (r *Repository) GiftPackage(fromID uuid.UUID, receiver *models.User, pkg *models.VipPackage) (*models.VipPurchase, *models.User, error) {
	var purchase models.VipPurchase
	var giver models.User

	err := r.db.Transaction(func(tx *gorm.DB) error {
		from, to, err := ledger.LockUserPair(tx, fromID, receiver.ID)
		if err != nil {
			return err
		}

		if err := ledger.EnsureBalance(from, pkg.KenPrice); err != nil {
			return err
		}

		newEnd := ExtendEnd(time.Now(), to.VipEndTime, pkg.Days)

		if err := tx.Model(&models.User{}).Where("id = ?", to.ID).Update("vip_end_time", newEnd).Error; err != nil {
			return err
		}

		pkgID := pkg.ID
		purchase = models.VipPurchase{
			UserID:          to.ID,
			PackageID:       &pkgID,
			PackageName:     pkg.Name,
			Days:            pkg.Days,
			KenPrice:        0,
			KenBalanceAfter: to.Ken,
			VipEndTimeAfter: newEnd,
			Source:          PurchaseSourceGift,
		}
		if err := tx.Create(&purchase).Error; err != nil {
			return err
		}

		if _, err := ledger.Debit(tx, from, pkg.KenPrice, ledger.Entry{
			Type:        models.KenTxTypeVipPackage,
			Description: fmt.Sprintf("Tặng %s cho @%s", pkg.Name, to.Username),
			RefType:     kenRefTypePurchase,
			RefID:       &purchase.ID,
			ActorType:   models.KenActorUser,
			ActorID:     &fromID,
		}); err != nil {
			return err
		}

		giver = *from
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return &purchase, &giver, nil
}

type DayTransfer struct {
	SenderID         uuid.UUID
	SenderUsername   string
	ReceiverID       uuid.UUID
	ReceiverUsername string
	SenderDays       int
	ReceiverDays     int
}

func (r *Repository) TransferDays(transfer DayTransfer) (time.Time, error) {
	var senderEnd time.Time

	err := r.db.Transaction(func(tx *gorm.DB) error {
		sender, receiver, err := ledger.LockUserPair(tx, transfer.SenderID, transfer.ReceiverID)
		if err != nil {
			return err
		}

		now := time.Now()
		if sender.VipEndTime == nil || !sender.VipEndTime.After(now) {
			return ErrDayTransferNotEnough
		}
		wholeDays := int(sender.VipEndTime.Sub(now) / (24 * time.Hour))
		if transfer.SenderDays > wholeDays {
			return ErrDayTransferNotEnough
		}

		senderEnd = sender.VipEndTime.Add(-time.Duration(transfer.SenderDays) * 24 * time.Hour)
		receiverEnd := ExtendEnd(now, receiver.VipEndTime, transfer.ReceiverDays)

		if err := tx.Model(&models.User{}).Where("id = ?", transfer.SenderID).Update("vip_end_time", senderEnd).Error; err != nil {
			return err
		}
		if err := tx.Model(&models.User{}).Where("id = ?", transfer.ReceiverID).Update("vip_end_time", receiverEnd).Error; err != nil {
			return err
		}

		rows := []models.VipPurchase{
			{
				UserID:          transfer.SenderID,
				PackageName:     fmt.Sprintf(dayTransferOutNameFormat, transfer.ReceiverUsername, transfer.ReceiverDays),
				Days:            -transfer.SenderDays,
				KenBalanceAfter: sender.Ken,
				VipEndTimeAfter: senderEnd,
				Source:          PurchaseSourceDayTransferOut,
			},
			{
				UserID:          transfer.ReceiverID,
				PackageName:     fmt.Sprintf(dayTransferInNameFormat, transfer.SenderUsername),
				Days:            transfer.ReceiverDays,
				KenBalanceAfter: receiver.Ken,
				VipEndTimeAfter: receiverEnd,
				Source:          PurchaseSourceDayTransferIn,
			},
		}
		return tx.Create(&rows).Error
	})
	if err != nil {
		return time.Time{}, err
	}
	return senderEnd, nil
}

func (r *Repository) Purchase(userID uuid.UUID, pkg *models.VipPackage) (*models.VipPurchase, *models.User, error) {
	var purchase models.VipPurchase
	var updatedUser models.User

	err := r.db.Transaction(func(tx *gorm.DB) error {
		u, err := ledger.LockUser(tx, userID)
		if err != nil {
			return err
		}
		if err := ledger.EnsureBalance(u, pkg.KenPrice); err != nil {
			return err
		}

		newEnd := ExtendEnd(time.Now(), u.VipEndTime, pkg.Days)
		newKen := u.Ken - pkg.KenPrice

		if err := tx.Model(&models.User{}).Where("id = ?", userID).Updates(map[string]interface{}{
			"ken":          newKen,
			"vip_end_time": newEnd,
		}).Error; err != nil {
			return err
		}

		pkgID := pkg.ID
		purchase = models.VipPurchase{
			UserID:          userID,
			PackageID:       &pkgID,
			PackageName:     pkg.Name,
			Days:            pkg.Days,
			KenPrice:        pkg.KenPrice,
			KenBalanceAfter: newKen,
			VipEndTimeAfter: newEnd,
			Source:          PurchaseSourcePackage,
		}
		if err := tx.Create(&purchase).Error; err != nil {
			return err
		}

		if pkg.KenPrice > 0 {
			if _, err := ledger.Record(tx, userID, models.KenDirectionDebit, pkg.KenPrice, u.Ken, newKen, ledger.Entry{
				Type:        models.KenTxTypeVipPackage,
				Description: pkg.Name,
				RefType:     kenRefTypePurchase,
				RefID:       &purchase.ID,
				ActorType:   models.KenActorUser,
				ActorID:     &userID,
			}); err != nil {
				return err
			}
		}

		u.Ken = newKen
		u.VipEndTime = &newEnd
		updatedUser = *u
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return &purchase, &updatedUser, nil
}

func (r *Repository) GrantDays(userID uuid.UUID, days int, source, name string) (*models.VipPurchase, error) {
	var purchase *models.VipPurchase
	err := r.db.Transaction(func(tx *gorm.DB) error {
		var err error
		purchase, err = GrantDaysTx(tx, userID, days, source, name)
		return err
	})
	if err != nil {
		return nil, err
	}
	return purchase, nil
}

func ExtendEnd(now time.Time, current *time.Time, days int) time.Time {
	base := now
	if current != nil && current.After(now) {
		base = *current
	}
	return base.Add(time.Duration(days) * 24 * time.Hour)
}

func CreateIconTx(tx *gorm.DB, userID uuid.UUID, vipTypeID int16, source string) (*models.UserVipIcon, error) {
	icon := models.UserVipIcon{
		UserID:     userID,
		VipIconID:  vipTypeID,
		Source:     source,
		AcquiredAt: time.Now(),
	}
	if err := tx.Create(&icon).Error; err != nil {
		return nil, err
	}
	return &icon, nil
}

func GrantDaysTx(tx *gorm.DB, userID uuid.UUID, days int, source, name string) (*models.VipPurchase, error) {
	u, err := ledger.LockUser(tx, userID)
	if err != nil {
		return nil, err
	}

	newEnd := ExtendEnd(time.Now(), u.VipEndTime, days)

	if err := tx.Model(&models.User{}).Where("id = ?", userID).Update("vip_end_time", newEnd).Error; err != nil {
		return nil, err
	}

	purchase := models.VipPurchase{
		UserID:          userID,
		PackageName:     name,
		Days:            days,
		KenPrice:        0,
		KenBalanceAfter: u.Ken,
		VipEndTimeAfter: newEnd,
		Source:          source,
	}
	if err := tx.Create(&purchase).Error; err != nil {
		return nil, err
	}
	return &purchase, nil
}

func GrantIconTx(tx *gorm.DB, userID uuid.UUID, vipTypeID int16, iconSource, purchaseSource string) (*models.UserVipIcon, error) {
	u, err := ledger.LockUser(tx, userID)
	if err != nil {
		return nil, err
	}

	icon, err := CreateIconTx(tx, userID, vipTypeID, iconSource)
	if err != nil {
		return nil, err
	}

	endAfter := time.Now()
	if u.VipEndTime != nil {
		endAfter = *u.VipEndTime
	}
	purchase := models.VipPurchase{
		UserID:          userID,
		PackageName:     IconPurchaseName(vipTypeID),
		Days:            0,
		KenPrice:        0,
		KenBalanceAfter: u.Ken,
		VipEndTimeAfter: endAfter,
		Source:          purchaseSource,
	}
	if err := tx.Create(&purchase).Error; err != nil {
		return nil, err
	}
	return icon, nil
}

func (r *Repository) DeductDays(userID uuid.UUID, days int, source, name string) (*models.VipPurchase, error) {
	var purchase models.VipPurchase

	err := r.db.Transaction(func(tx *gorm.DB) error {
		u, err := ledger.LockUser(tx, userID)
		if err != nil {
			return err
		}

		now := time.Now()
		base := now
		if u.VipEndTime != nil && u.VipEndTime.After(now) {
			base = *u.VipEndTime
		}
		newEnd := base.Add(-time.Duration(days) * 24 * time.Hour)
		if newEnd.Before(now) {
			newEnd = now
		}

		if err := tx.Model(&models.User{}).Where("id = ?", userID).Update("vip_end_time", newEnd).Error; err != nil {
			return err
		}

		purchase = models.VipPurchase{
			UserID:          userID,
			PackageName:     name,
			Days:            -days,
			KenPrice:        0,
			KenBalanceAfter: u.Ken,
			VipEndTimeAfter: newEnd,
			Source:          source,
		}
		return tx.Create(&purchase).Error
	})
	if err != nil {
		return nil, err
	}
	return &purchase, nil
}
