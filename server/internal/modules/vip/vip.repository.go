package vip

import (
	"errors"
	"fmt"
	"time"

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

func (r *Repository) CreatePackage(pkg *models.VipPackage) error {
	return r.db.Create(pkg).Error
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

func (r *Repository) CreateShopItem(item *models.VipShopItem) error {
	return r.db.Create(item).Error
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
		var u models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", userID).Error; err != nil {
			return err
		}
		if u.Ken < item.KenPrice {
			return ErrInsufficientKen
		}
		newKen := u.Ken - item.KenPrice

		if err := tx.Model(&models.User{}).Where("id = ?", userID).Update("ken", newKen).Error; err != nil {
			return err
		}

		icon = models.UserVipIcon{
			UserID:     userID,
			VipIconID:  item.VipTypeID,
			Source:     "purchase",
			AcquiredAt: time.Now(),
		}
		if err := tx.Create(&icon).Error; err != nil {
			return err
		}

		endAfter := time.Now()
		if u.VipEndTime != nil {
			endAfter = *u.VipEndTime
		}
		purchase := models.VipPurchase{
			UserID:          userID,
			PackageName:     fmt.Sprintf("VIP #%d", item.VipTypeID),
			Days:            0,
			KenPrice:        item.KenPrice,
			KenBalanceAfter: newKen,
			VipEndTimeAfter: endAfter,
			Source:          "icon",
		}
		if err := tx.Create(&purchase).Error; err != nil {
			return err
		}

		if item.KenPrice > 0 {
			kenTx := models.KenTransaction{
				UserID:        userID,
				Direction:     models.KenDirectionDebit,
				Type:          models.KenTxTypeVipIcon,
				Amount:        item.KenPrice,
				BalanceBefore: u.Ken,
				BalanceAfter:  newKen,
				Description:   purchase.PackageName,
				RefType:       "vip_purchase",
				RefID:         &purchase.ID,
				ActorType:     models.KenActorUser,
				ActorID:       &userID,
			}
			if err := tx.Create(&kenTx).Error; err != nil {
				return err
			}
		}

		u.Ken = newKen
		updatedUser = u
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
		lockOrder := []uuid.UUID{fromID, receiver.ID}
		if lockOrder[0].String() > lockOrder[1].String() {
			lockOrder[0], lockOrder[1] = lockOrder[1], lockOrder[0]
		}
		locked := make(map[uuid.UUID]*models.User, 2)
		for _, id := range lockOrder {
			var u models.User
			if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", id).Error; err != nil {
				return err
			}
			locked[id] = &u
		}
		from := locked[fromID]
		to := locked[receiver.ID]

		if from.Ken < item.KenPrice {
			return ErrInsufficientKen
		}
		giverAfter := from.Ken - item.KenPrice

		if err := tx.Model(&models.User{}).Where("id = ?", fromID).Update("ken", giverAfter).Error; err != nil {
			return err
		}

		icon = models.UserVipIcon{
			UserID:     to.ID,
			VipIconID:  item.VipTypeID,
			Source:     "gift",
			AcquiredAt: time.Now(),
		}
		if err := tx.Create(&icon).Error; err != nil {
			return err
		}

		endAfter := time.Now()
		if to.VipEndTime != nil {
			endAfter = *to.VipEndTime
		}
		purchase := models.VipPurchase{
			UserID:          to.ID,
			PackageName:     fmt.Sprintf("VIP #%d", item.VipTypeID),
			Days:            0,
			KenPrice:        0,
			KenBalanceAfter: to.Ken,
			VipEndTimeAfter: endAfter,
			Source:          "gift",
		}
		if err := tx.Create(&purchase).Error; err != nil {
			return err
		}

		if item.KenPrice > 0 {
			kenTx := models.KenTransaction{
				UserID:        fromID,
				Direction:     models.KenDirectionDebit,
				Type:          models.KenTxTypeVipIcon,
				Amount:        item.KenPrice,
				BalanceBefore: from.Ken,
				BalanceAfter:  giverAfter,
				Description:   fmt.Sprintf("Tặng %s cho @%s", purchase.PackageName, to.Username),
				RefType:       "vip_purchase",
				RefID:         &purchase.ID,
				ActorType:     models.KenActorUser,
				ActorID:       &fromID,
			}
			if err := tx.Create(&kenTx).Error; err != nil {
				return err
			}
		}

		from.Ken = giverAfter
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
		lockOrder := []uuid.UUID{fromID, receiver.ID}
		if lockOrder[0].String() > lockOrder[1].String() {
			lockOrder[0], lockOrder[1] = lockOrder[1], lockOrder[0]
		}
		locked := make(map[uuid.UUID]*models.User, 2)
		for _, id := range lockOrder {
			var u models.User
			if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", id).Error; err != nil {
				return err
			}
			locked[id] = &u
		}
		from := locked[fromID]
		to := locked[receiver.ID]

		if from.Ken < pkg.KenPrice {
			return ErrInsufficientKen
		}

		base := time.Now()
		if to.VipEndTime != nil && to.VipEndTime.After(base) {
			base = *to.VipEndTime
		}
		newEnd := base.Add(time.Duration(pkg.Days) * 24 * time.Hour)
		giverAfter := from.Ken - pkg.KenPrice

		if err := tx.Model(&models.User{}).Where("id = ?", fromID).Update("ken", giverAfter).Error; err != nil {
			return err
		}
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
			Source:          "gift",
		}
		if err := tx.Create(&purchase).Error; err != nil {
			return err
		}

		if pkg.KenPrice > 0 {
			kenTx := models.KenTransaction{
				UserID:        fromID,
				Direction:     models.KenDirectionDebit,
				Type:          models.KenTxTypeVipPackage,
				Amount:        pkg.KenPrice,
				BalanceBefore: from.Ken,
				BalanceAfter:  giverAfter,
				Description:   fmt.Sprintf("Tặng %s cho @%s", pkg.Name, to.Username),
				RefType:       "vip_purchase",
				RefID:         &purchase.ID,
				ActorType:     models.KenActorUser,
				ActorID:       &fromID,
			}
			if err := tx.Create(&kenTx).Error; err != nil {
				return err
			}
		}

		from.Ken = giverAfter
		giver = *from
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return &purchase, &giver, nil
}

func (r *Repository) Purchase(userID uuid.UUID, pkg *models.VipPackage) (*models.VipPurchase, *models.User, error) {
	var purchase models.VipPurchase
	var updatedUser models.User

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var u models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", userID).Error; err != nil {
			return err
		}
		if u.Ken < pkg.KenPrice {
			return ErrInsufficientKen
		}

		base := time.Now()
		if u.VipEndTime != nil && u.VipEndTime.After(base) {
			base = *u.VipEndTime
		}
		newEnd := base.Add(time.Duration(pkg.Days) * 24 * time.Hour)
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
			Source:          "package",
		}
		if err := tx.Create(&purchase).Error; err != nil {
			return err
		}

		if pkg.KenPrice > 0 {
			kenTx := models.KenTransaction{
				UserID:        userID,
				Direction:     models.KenDirectionDebit,
				Type:          models.KenTxTypeVipPackage,
				Amount:        pkg.KenPrice,
				BalanceBefore: u.Ken,
				BalanceAfter:  newKen,
				Description:   pkg.Name,
				RefType:       "vip_purchase",
				RefID:         &purchase.ID,
				ActorType:     models.KenActorUser,
				ActorID:       &userID,
			}
			if err := tx.Create(&kenTx).Error; err != nil {
				return err
			}
		}

		u.Ken = newKen
		u.VipEndTime = &newEnd
		updatedUser = u
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return &purchase, &updatedUser, nil
}
