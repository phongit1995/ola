package vip

import (
	"errors"
	"math"
	"strconv"
	"strings"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

var (
	ErrVipNotFound        = errors.New("vip icon not found")
	ErrVipNotOwned        = errors.New("vip does not belong to you")
	ErrVipLocked          = errors.New("vip is locked")
	ErrVipInUse           = errors.New("vip is in use")
	ErrWrongPassword      = errors.New("invalid transfer password")
	ErrVipExpired         = errors.New("vip membership expired")
	ErrPrivateStore       = errors.New("vip store is private")
	ErrCannotTransferSelf = errors.New("cannot transfer to yourself")
	ErrUserNotFound       = apperr.ErrUserNotFound
	ErrPackageNotFound    = errors.New("vip package not found")
	ErrInsufficientKen    = errors.New("insufficient ken balance")
	ErrReceiverNotFound   = errors.New("receiver not found")
	ErrCannotGiftSelf     = errors.New("cannot gift to yourself")
	ErrShopItemNotFound   = errors.New("vip shop item not found")
	ErrShopTypeExists     = errors.New("vip already in shop")
	ErrBlockedGift        = errors.New("cannot gift to blocked user")
)

type Service struct {
	repo      *Repository
	relRepo   *relationships.Repository
	userCache *user.CacheService
	cache     *services.CacheService
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, relRepo *relationships.Repository, userCache *user.CacheService, cache *services.CacheService, wsServer *websocket.Server, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		relRepo:   relRepo,
		userCache: userCache,
		cache:     cache,
		wsServer:  wsServer,
		logger:    logger.Named("[vip_service]"),
	}
}

func (s *Service) emitKenUpdate(userID uuid.UUID, ken int) {
	if s.wsServer == nil {
		return
	}
	payload := utils.WrapWebSocketMessage(constants.WebSocketEventKenUpdated, map[string]interface{}{
		"ken": ken,
	})
	s.wsServer.EmitToUser(userID.String(), constants.WebSocketMessageEvent, payload)
}

func parseTypeID(vipUsed *string) *int16 {
	if vipUsed == nil || *vipUsed == "" {
		return nil
	}
	n, err := strconv.Atoi(*vipUsed)
	if err != nil {
		return nil
	}
	v := int16(n)
	return &v
}

func remainingDays(end *time.Time) *int {
	if end == nil {
		return nil
	}
	now := time.Now()
	if !end.After(now) {
		return nil
	}
	d := int(math.Ceil(end.Sub(now).Hours() / 24))
	return &d
}

func toVipItem(item *models.UserVipIcon, activeInstance *uuid.UUID) VipItem {
	using := activeInstance != nil && *activeInstance == item.ID
	return VipItem{
		InstanceID: item.ID.String(),
		TypeID:     item.VipIconID,
		IsLocked:   item.IsLocked,
		IsUsing:    using,
		Source:     item.Source,
		AcquiredAt: item.AcquiredAt.Format(time.RFC3339),
	}
}

func (s *Service) invalidate(userID uuid.UUID) {
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after vip change", "user_id", userID, "error", err.Error())
	}
}

func (s *Service) GetStore(viewerID, targetID uuid.UUID, limit, offset int) (*StoreResponse, error) {
	target, err := s.repo.GetUser(targetID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrUserNotFound
		}
		return nil, err
	}

	if viewerID != targetID {
		switch target.VipStorePrivacy {
		case 2:
			return nil, ErrPrivateStore
		case 1:
			ok, err := s.repo.AreFriends(viewerID, targetID)
			if err != nil {
				return nil, err
			}
			if !ok {
				return nil, ErrPrivateStore
			}
		}
	}

	total, err := s.repo.CountByUser(targetID)
	if err != nil {
		return nil, err
	}

	active := parseTypeID(target.VipUsed)
	activeSort := int16(-1)
	if active != nil {
		activeSort = *active
	}

	items, err := s.repo.ListByUserPaged(targetID, activeSort, limit, offset)
	if err != nil {
		return nil, err
	}

	out := make([]VipItem, 0, len(items))
	for i := range items {
		out = append(out, toVipItem(&items[i], target.VipUsedInstanceID))
	}

	resp := &StoreResponse{
		UserID:       targetID.String(),
		ActiveTypeID: active,
		Days:         remainingDays(target.VipEndTime),
		Privacy:      target.VipStorePrivacy,
		Total:        int(total),
		Limit:        limit,
		Offset:       offset,
		Items:        out,
	}
	if target.VipEndTime != nil {
		t := target.VipEndTime.Format(time.RFC3339)
		resp.VipEndTime = &t
	}
	return resp, nil
}

func (s *Service) ownedInstance(userID, instanceID uuid.UUID) (*models.UserVipIcon, error) {
	item, err := s.repo.FindInstance(instanceID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrVipNotFound
		}
		return nil, err
	}
	if item.UserID != userID {
		return nil, ErrVipNotOwned
	}
	return item, nil
}

func (s *Service) Use(userID, instanceID uuid.UUID) error {
	item, err := s.ownedInstance(userID, instanceID)
	if err != nil {
		return err
	}

	u, err := s.repo.GetUser(userID)
	if err != nil {
		return err
	}
	if u.VipEndTime == nil || !u.VipEndTime.After(time.Now()) {
		return ErrVipExpired
	}

	if u.VipUsedInstanceID != nil && *u.VipUsedInstanceID == item.ID {
		return nil
	}

	typeStr := strconv.Itoa(int(item.VipIconID))
	if u.VipUsed != nil && *u.VipUsed == typeStr {
		if err := s.repo.UpdateUserFields(userID, map[string]interface{}{
			"vip_used_instance_id": item.ID,
		}); err != nil {
			return err
		}
		s.invalidate(userID)
		return nil
	}

	newEnd := u.VipEndTime.Add(-24 * time.Hour)
	if err := s.repo.UpdateUserFields(userID, map[string]interface{}{
		"vip_used":             typeStr,
		"vip_used_instance_id": item.ID,
		"vip_end_time":         newEnd,
	}); err != nil {
		return err
	}
	s.invalidate(userID)
	return nil
}

func (s *Service) SetLock(userID, instanceID uuid.UUID, locked bool) error {
	if _, err := s.ownedInstance(userID, instanceID); err != nil {
		return err
	}
	return s.repo.SetLocked(instanceID, locked)
}

func (s *Service) Delete(userID, instanceID uuid.UUID) error {
	item, err := s.ownedInstance(userID, instanceID)
	if err != nil {
		return err
	}
	if item.IsLocked {
		return ErrVipLocked
	}
	if err := s.repo.SoftDelete(instanceID); err != nil {
		return err
	}
	return s.clearActiveIfGone(userID, instanceID, item.VipIconID)
}

func (s *Service) Transfer(userID, instanceID, toUserID uuid.UUID, password string) error {
	if toUserID == userID {
		return ErrCannotTransferSelf
	}
	exists, err := s.repo.UserExists(toUserID)
	if err != nil {
		return err
	}
	if !exists {
		return ErrUserNotFound
	}

	sender, err := s.repo.GetUser(userID)
	if err != nil {
		return err
	}
	if bcrypt.CompareHashAndPassword([]byte(sender.Password), []byte(password)) != nil {
		return ErrWrongPassword
	}

	item, err := s.ownedInstance(userID, instanceID)
	if err != nil {
		return err
	}
	if item.IsLocked {
		return ErrVipLocked
	}
	if sender.VipUsedInstanceID != nil && *sender.VipUsedInstanceID == instanceID {
		return ErrVipInUse
	}
	return s.repo.Transfer(instanceID, toUserID)
}

func (s *Service) clearActiveIfGone(userID, instanceID uuid.UUID, typeID int16) error {
	u, err := s.repo.GetUser(userID)
	if err != nil {
		return err
	}
	if u.VipUsedInstanceID == nil || *u.VipUsedInstanceID != instanceID {
		return nil
	}
	replacement, err := s.repo.FindOneOfTypeExcluding(userID, typeID, instanceID)
	if err != nil {
		return err
	}
	fields := map[string]interface{}{}
	if replacement != nil {
		fields["vip_used_instance_id"] = replacement.ID
	} else {
		fields["vip_used"] = nil
		fields["vip_used_instance_id"] = nil
	}
	if err := s.repo.UpdateUserFields(userID, fields); err != nil {
		return err
	}
	s.invalidate(userID)
	return nil
}

func (s *Service) ListShopCatalog() (*ShopCatalogResponse, error) {
	items, err := s.repo.ListActiveShopItems()
	if err != nil {
		return nil, err
	}
	out := make([]ShopCatalogItem, 0, len(items))
	for i := range items {
		out = append(out, ShopCatalogItem{
			ID:        items[i].ID.String(),
			VipTypeID: items[i].VipTypeID,
			KenPrice:  items[i].KenPrice,
		})
	}
	return &ShopCatalogResponse{Total: len(out), Items: out}, nil
}

func (s *Service) Buy(userID, shopItemID uuid.UUID) (*BuyIconResponse, error) {
	item, err := s.repo.FindActiveShopItem(shopItemID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrShopItemNotFound
		}
		return nil, err
	}

	icon, updatedUser, err := s.repo.PurchaseShopItem(userID, item)
	if err != nil {
		return nil, err
	}

	s.invalidate(userID)
	s.emitKenUpdate(userID, updatedUser.Ken)

	out := toVipItem(icon, updatedUser.VipUsedInstanceID)
	return &BuyIconResponse{Item: out, KenBalance: updatedUser.Ken}, nil
}

func (s *Service) ListAllShopItems() (*ShopListResponse, error) {
	items, err := s.repo.ListAllShopItems()
	if err != nil {
		return nil, err
	}
	out := make([]ShopItem, 0, len(items))
	for i := range items {
		out = append(out, toShopItem(&items[i]))
	}
	return &ShopListResponse{Total: len(out), Items: out}, nil
}

func (s *Service) CreateShopItem(req CreateShopItemRequest) (*ShopItem, error) {
	exists, err := s.repo.ShopTypeExists(req.VipTypeID)
	if err != nil {
		return nil, err
	}
	if exists {
		return nil, ErrShopTypeExists
	}

	item := &models.VipShopItem{
		VipTypeID: req.VipTypeID,
		KenPrice:  req.KenPrice,
		SortOrder: req.SortOrder,
		IsActive:  true,
	}
	if req.IsActive != nil {
		item.IsActive = *req.IsActive
	}
	if err := s.repo.CreateShopItem(item); err != nil {
		return nil, err
	}
	out := toShopItem(item)
	return &out, nil
}

func (s *Service) UpdateShopItem(id uuid.UUID, req UpdateShopItemRequest) (*ShopItem, error) {
	if _, err := s.repo.FindShopItem(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrShopItemNotFound
		}
		return nil, err
	}

	fields := map[string]interface{}{}
	if req.KenPrice != nil {
		fields["ken_price"] = *req.KenPrice
	}
	if req.IsActive != nil {
		fields["is_active"] = *req.IsActive
	}
	if req.SortOrder != nil {
		fields["sort_order"] = *req.SortOrder
	}
	if len(fields) > 0 {
		if err := s.repo.UpdateShopItem(id, fields); err != nil {
			return nil, err
		}
	}

	item, err := s.repo.FindShopItem(id)
	if err != nil {
		return nil, err
	}
	out := toShopItem(item)
	return &out, nil
}

func (s *Service) DeleteShopItem(id uuid.UUID) error {
	if _, err := s.repo.FindShopItem(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrShopItemNotFound
		}
		return err
	}
	return s.repo.SoftDeleteShopItem(id)
}

func toShopItem(it *models.VipShopItem) ShopItem {
	return ShopItem{
		ID:        it.ID.String(),
		VipTypeID: it.VipTypeID,
		KenPrice:  it.KenPrice,
		IsActive:  it.IsActive,
		SortOrder: it.SortOrder,
	}
}

func (s *Service) SetPrivacy(userID uuid.UUID, privacy int16) error {
	return s.repo.UpdateUserFields(userID, map[string]interface{}{"vip_store_privacy": privacy})
}

func toPackageItem(p *models.VipPackage) PackageItem {
	return PackageItem{
		ID:        p.ID.String(),
		Name:      p.Name,
		Days:      p.Days,
		KenPrice:  p.KenPrice,
		IsActive:  p.IsActive,
		SortOrder: p.SortOrder,
	}
}

func toHistoryItem(p *models.VipPurchase) PurchaseHistoryItem {
	return PurchaseHistoryItem{
		ID:              p.ID.String(),
		PackageName:     p.PackageName,
		Days:            p.Days,
		KenPrice:        p.KenPrice,
		KenBalanceAfter: p.KenBalanceAfter,
		VipEndTime:      p.VipEndTimeAfter.Format(time.RFC3339),
		Source:          p.Source,
		CreatedAt:       p.CreatedAt.Format(time.RFC3339),
	}
}

func (s *Service) invalidatePackages() {
	if err := s.cache.Delete(constants.CacheKeyVipPackages); err != nil {
		s.logger.Warnw("Failed to invalidate vip packages cache", "error", err.Error())
	}
}

func (s *Service) ListActivePackages() ([]PackageItem, error) {
	var cached []PackageItem
	if err := s.cache.Get(constants.CacheKeyVipPackages, &cached); err == nil {
		return cached, nil
	}

	pkgs, err := s.repo.ListActivePackages()
	if err != nil {
		return nil, err
	}
	items := make([]PackageItem, 0, len(pkgs))
	for i := range pkgs {
		items = append(items, toPackageItem(&pkgs[i]))
	}

	if err := s.cache.Set(constants.CacheKeyVipPackages, items, constants.CacheTTLVipPackages*time.Second); err != nil {
		s.logger.Warnw("Failed to cache vip packages", "error", err.Error())
	}
	return items, nil
}

func (s *Service) BuyPackage(userID, packageID uuid.UUID) (*BuyPackageResponse, error) {
	pkg, err := s.repo.FindActivePackage(packageID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrPackageNotFound
		}
		return nil, err
	}

	purchase, updatedUser, err := s.repo.Purchase(userID, pkg)
	if err != nil {
		return nil, err
	}

	s.invalidate(userID)
	s.emitKenUpdate(userID, updatedUser.Ken)

	return &BuyPackageResponse{
		PurchaseID:  purchase.ID.String(),
		PackageName: purchase.PackageName,
		Days:        purchase.Days,
		KenSpent:    purchase.KenPrice,
		KenBalance:  updatedUser.Ken,
		VipEndTime:  purchase.VipEndTimeAfter.Format(time.RFC3339),
	}, nil
}

func (s *Service) GiftPackage(fromID, packageID uuid.UUID, toUsername string) (*GiftPackageResponse, error) {
	pkg, err := s.repo.FindActivePackage(packageID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrPackageNotFound
		}
		return nil, err
	}

	receiver, err := s.repo.FindByUsername(strings.TrimSpace(toUsername))
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrReceiverNotFound
		}
		return nil, err
	}
	if receiver.ID == fromID {
		return nil, ErrCannotGiftSelf
	}
	blocked, err := s.relRepo.IsBlockedEither(fromID, receiver.ID)
	if err != nil {
		return nil, err
	}
	if blocked {
		return nil, ErrBlockedGift
	}

	purchase, giver, err := s.repo.GiftPackage(fromID, receiver, pkg)
	if err != nil {
		return nil, err
	}

	s.invalidate(fromID)
	s.invalidate(receiver.ID)
	s.emitKenUpdate(fromID, giver.Ken)

	return &GiftPackageResponse{
		ReceiverUsername: receiver.Username,
		Days:             pkg.Days,
		KenSpent:         pkg.KenPrice,
		KenBalance:       giver.Ken,
		VipEndTime:       purchase.VipEndTimeAfter.Format(time.RFC3339),
	}, nil
}

func (s *Service) GiftIcon(fromID, shopItemID uuid.UUID, toUsername string) (*GiftIconResponse, error) {
	item, err := s.repo.FindActiveShopItem(shopItemID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrShopItemNotFound
		}
		return nil, err
	}

	receiver, err := s.repo.FindByUsername(strings.TrimSpace(toUsername))
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrReceiverNotFound
		}
		return nil, err
	}
	if receiver.ID == fromID {
		return nil, ErrCannotGiftSelf
	}
	blocked, err := s.relRepo.IsBlockedEither(fromID, receiver.ID)
	if err != nil {
		return nil, err
	}
	if blocked {
		return nil, ErrBlockedGift
	}

	_, giver, err := s.repo.GiftShopItem(fromID, receiver, item)
	if err != nil {
		return nil, err
	}

	s.invalidate(fromID)
	s.invalidate(receiver.ID)
	s.emitKenUpdate(fromID, giver.Ken)

	return &GiftIconResponse{
		ReceiverUsername: receiver.Username,
		KenSpent:         item.KenPrice,
		KenBalance:       giver.Ken,
	}, nil
}

func (s *Service) ListHistory(userID *uuid.UUID, limit, offset int) (*HistoryListResponse, error) {
	items, total, err := s.repo.ListHistory(userID, limit, offset)
	if err != nil {
		return nil, err
	}
	out := make([]PurchaseHistoryItem, 0, len(items))
	for i := range items {
		out = append(out, toHistoryItem(&items[i]))
	}
	return &HistoryListResponse{
		Total:  int(total),
		Limit:  limit,
		Offset: offset,
		Items:  out,
	}, nil
}

func (s *Service) ListAllPackages(limit, offset int) (*PackageListResponse, error) {
	pkgs, total, err := s.repo.ListAllPackages(limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]PackageItem, 0, len(pkgs))
	for i := range pkgs {
		items = append(items, toPackageItem(&pkgs[i]))
	}
	return &PackageListResponse{
		Total:  int(total),
		Limit:  limit,
		Offset: offset,
		Items:  items,
	}, nil
}

func (s *Service) CreatePackage(req CreatePackageRequest) (*PackageItem, error) {
	pkg := &models.VipPackage{
		Name:      req.Name,
		Days:      req.Days,
		KenPrice:  req.KenPrice,
		IsActive:  true,
		SortOrder: req.SortOrder,
	}
	if req.IsActive != nil {
		pkg.IsActive = *req.IsActive
	}
	if err := s.repo.CreatePackage(pkg); err != nil {
		return nil, err
	}
	s.invalidatePackages()
	item := toPackageItem(pkg)
	return &item, nil
}

func (s *Service) UpdatePackage(id uuid.UUID, req UpdatePackageRequest) (*PackageItem, error) {
	if _, err := s.repo.FindPackage(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrPackageNotFound
		}
		return nil, err
	}

	fields := map[string]interface{}{}
	if req.Name != nil {
		fields["name"] = *req.Name
	}
	if req.Days != nil {
		fields["days"] = *req.Days
	}
	if req.KenPrice != nil {
		fields["ken_price"] = *req.KenPrice
	}
	if req.IsActive != nil {
		fields["is_active"] = *req.IsActive
	}
	if req.SortOrder != nil {
		fields["sort_order"] = *req.SortOrder
	}
	if len(fields) > 0 {
		if err := s.repo.UpdatePackage(id, fields); err != nil {
			return nil, err
		}
	}
	s.invalidatePackages()

	pkg, err := s.repo.FindPackage(id)
	if err != nil {
		return nil, err
	}
	item := toPackageItem(pkg)
	return &item, nil
}

func (s *Service) DeletePackage(id uuid.UUID) error {
	if _, err := s.repo.FindPackage(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrPackageNotFound
		}
		return err
	}
	if err := s.repo.SoftDeletePackage(id); err != nil {
		return err
	}
	s.invalidatePackages()
	return nil
}
