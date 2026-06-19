package vip

import (
	"errors"
	"math"
	"strconv"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrVipNotFound        = errors.New("vip icon not found")
	ErrVipNotOwned        = errors.New("vip does not belong to you")
	ErrVipLocked          = errors.New("vip is locked")
	ErrVipExpired         = errors.New("vip membership expired")
	ErrPrivateStore       = errors.New("vip store is private")
	ErrCannotTransferSelf = errors.New("cannot transfer to yourself")
	ErrUserNotFound       = errors.New("user not found")
	ErrPackageNotFound    = errors.New("vip package not found")
	ErrInsufficientKen    = errors.New("insufficient ken balance")
	ErrIconTypeNotFound   = errors.New("vip type not found")
	ErrIconNotSellable    = errors.New("vip type not sellable")
)

type Service struct {
	repo      *Repository
	userCache *user.CacheService
	cache     *services.CacheService
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, userCache *user.CacheService, cache *services.CacheService, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		userCache: userCache,
		cache:     cache,
		logger:    logger.Named("[vip_service]"),
	}
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

func toVipItem(item *models.UserVipIcon, active *int16) VipItem {
	using := active != nil && *active == item.VipIconID
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
		out = append(out, toVipItem(&items[i], active))
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

	typeStr := strconv.Itoa(int(item.VipIconID))
	if u.VipUsed != nil && *u.VipUsed == typeStr {
		return nil
	}

	newEnd := u.VipEndTime.Add(-24 * time.Hour)
	if err := s.repo.UpdateUserFields(userID, map[string]interface{}{
		"vip_used":     typeStr,
		"vip_end_time": newEnd,
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

func (s *Service) Transfer(userID, instanceID, toUserID uuid.UUID) error {
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

	item, err := s.ownedInstance(userID, instanceID)
	if err != nil {
		return err
	}
	if item.IsLocked {
		return ErrVipLocked
	}
	if err := s.repo.Transfer(instanceID, toUserID); err != nil {
		return err
	}
	return s.clearActiveIfGone(userID, instanceID, item.VipIconID)
}

func (s *Service) clearActiveIfGone(userID, instanceID uuid.UUID, typeID int16) error {
	u, err := s.repo.GetUser(userID)
	if err != nil {
		return err
	}
	active := parseTypeID(u.VipUsed)
	if active == nil || *active != typeID {
		return nil
	}
	count, err := s.repo.CountTypeOwned(userID, typeID, instanceID)
	if err != nil {
		return err
	}
	if count > 0 {
		return nil
	}
	if err := s.repo.UpdateUserFields(userID, map[string]interface{}{"vip_used": nil}); err != nil {
		return err
	}
	s.invalidate(userID)
	return nil
}

func (s *Service) ListIconCatalog() (*IconCatalogResponse, error) {
	types, err := s.repo.ListSellableIconTypes()
	if err != nil {
		return nil, err
	}
	items := make([]IconCatalogItem, 0, len(types))
	for i := range types {
		items = append(items, IconCatalogItem{
			TypeID:   types[i].TypeID,
			Name:     types[i].Name,
			KenPrice: types[i].KenPrice,
		})
	}
	return &IconCatalogResponse{Total: len(items), Items: items}, nil
}

func (s *Service) Buy(userID uuid.UUID, typeID int16) (*BuyIconResponse, error) {
	t, err := s.repo.FindIconType(typeID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrIconTypeNotFound
		}
		return nil, err
	}
	if !t.IsActive {
		return nil, ErrIconNotSellable
	}

	icon, updatedUser, err := s.repo.PurchaseIcon(userID, t)
	if err != nil {
		return nil, err
	}

	s.invalidate(userID)

	active := parseTypeID(updatedUser.VipUsed)
	item := toVipItem(icon, active)
	return &BuyIconResponse{Item: item, KenBalance: updatedUser.Ken}, nil
}

func (s *Service) ListAllIconTypes() (*IconTypeListResponse, error) {
	types, err := s.repo.ListAllIconTypes()
	if err != nil {
		return nil, err
	}
	items := make([]IconTypeItem, 0, len(types))
	for i := range types {
		items = append(items, toIconTypeItem(&types[i]))
	}
	return &IconTypeListResponse{Total: len(items), Items: items}, nil
}

func (s *Service) UpdateIconType(typeID int16, req UpdateIconTypeRequest) (*IconTypeItem, error) {
	if _, err := s.repo.FindIconType(typeID); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrIconTypeNotFound
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
	if len(fields) > 0 {
		if err := s.repo.UpdateIconType(typeID, fields); err != nil {
			return nil, err
		}
	}

	t, err := s.repo.FindIconType(typeID)
	if err != nil {
		return nil, err
	}
	item := toIconTypeItem(t)
	return &item, nil
}

func toIconTypeItem(t *models.VipIconType) IconTypeItem {
	return IconTypeItem{
		TypeID:   t.TypeID,
		Name:     t.Name,
		KenPrice: t.KenPrice,
		IsActive: t.IsActive,
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

	return &BuyPackageResponse{
		PurchaseID:  purchase.ID.String(),
		PackageName: purchase.PackageName,
		Days:        purchase.Days,
		KenSpent:    purchase.KenPrice,
		KenBalance:  updatedUser.Ken,
		VipEndTime:  purchase.VipEndTimeAfter.Format(time.RFC3339),
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
