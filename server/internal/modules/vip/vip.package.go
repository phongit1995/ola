package vip

import (
	"errors"
	"strings"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

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
	if err := s.cache.Delete(CacheKeyVipPackages); err != nil {
		s.logger.Warnw("Failed to invalidate vip packages cache", "error", err.Error())
	}
}

func (s *Service) ListActivePackages() ([]PackageItem, error) {
	var cached []PackageItem
	if err := s.cache.Get(CacheKeyVipPackages, &cached); err == nil {
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

	if err := s.cache.Set(CacheKeyVipPackages, items, CacheTTLVipPackages*time.Second); err != nil {
		s.logger.Warnw("Failed to cache vip packages", "error", err.Error())
	}
	return items, nil
}

func (s *Service) GrantDays(userID uuid.UUID, days int, source, name string) (*models.VipPurchase, error) {
	purchase, err := s.repo.GrantDays(userID, days, source, name)
	if err != nil {
		return nil, err
	}
	s.invalidate(userID)
	return purchase, nil
}

func (s *Service) DeductDays(userID uuid.UUID, days int, source, name string) (*models.VipPurchase, error) {
	purchase, err := s.repo.DeductDays(userID, days, source, name)
	if err != nil {
		return nil, err
	}
	s.invalidate(userID)
	return purchase, nil
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
	s.wsServer.EmitKenUpdate(userID, updatedUser.Ken)

	return &BuyPackageResponse{
		PurchaseID:  purchase.ID.String(),
		PackageName: purchase.PackageName,
		Days:        purchase.Days,
		KenSpent:    purchase.KenPrice,
		KenBalance:  updatedUser.Ken,
		VipEndTime:  purchase.VipEndTimeAfter.Format(time.RFC3339),
	}, nil
}

func (s *Service) GiftPackage(fromID, packageID uuid.UUID, toUsername, password string) (*GiftPackageResponse, error) {
	pkg, err := s.repo.FindActivePackage(packageID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrPackageNotFound
		}
		return nil, err
	}

	sender, err := s.repo.GetUser(fromID)
	if err != nil {
		return nil, err
	}
	if bcrypt.CompareHashAndPassword([]byte(sender.Password), []byte(password)) != nil {
		return nil, ErrWrongPassword
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
	s.wsServer.EmitKenUpdate(fromID, giver.Ken)
	s.notifSvc.Create(receiver.ID, &fromID, models.AppNotificationVipReceived, nil, models.AppNotificationTransfer{Days: pkg.Days}.Preview())

	return &GiftPackageResponse{
		ReceiverUsername: receiver.Username,
		Days:             pkg.Days,
		KenSpent:         pkg.KenPrice,
		KenBalance:       giver.Ken,
		VipEndTime:       purchase.VipEndTimeAfter.Format(time.RFC3339),
	}, nil
}

func (s *Service) TransferDays(fromID uuid.UUID, req TransferDaysRequest, client setting.Client) (*TransferDaysResponse, error) {
	cfg, err := s.settings.GetVipDayTransfer()
	if err != nil {
		return nil, err
	}
	if !cfg.EnabledFor(client) {
		return nil, ErrDayTransferDisabled
	}
	receiverDays, valid := cfg.ReceiverDaysFor(req.SenderDays)
	if !valid {
		return nil, ErrDayTransferInvalidDays
	}
	if receiverDays != req.ReceiverDays {
		return nil, ErrDayTransferRateChanged
	}

	sender, err := s.repo.GetUser(fromID)
	if err != nil {
		return nil, err
	}
	if bcrypt.CompareHashAndPassword([]byte(sender.Password), []byte(req.Password)) != nil {
		return nil, ErrWrongPassword
	}

	receiver, err := s.repo.FindByUsername(strings.TrimSpace(req.ToUsername))
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

	senderEnd, err := s.repo.TransferDays(DayTransfer{
		SenderID:         fromID,
		SenderUsername:   sender.Username,
		ReceiverID:       receiver.ID,
		ReceiverUsername: receiver.Username,
		SenderDays:       req.SenderDays,
		ReceiverDays:     receiverDays,
	})
	if err != nil {
		return nil, err
	}

	s.invalidate(fromID)
	s.invalidate(receiver.ID)
	s.notifSvc.Create(receiver.ID, &fromID, models.AppNotificationVipReceived, nil, models.AppNotificationTransfer{Days: receiverDays}.Preview())

	return &TransferDaysResponse{
		ReceiverUsername: receiver.Username,
		SenderDays:       req.SenderDays,
		ReceiverDays:     receiverDays,
		VipEndTime:       senderEnd.Format(time.RFC3339),
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

func toTransferHistoryItem(t *models.VipTransfer, users map[uuid.UUID]TransferUser) TransferHistoryItem {
	from := users[t.FromUserID]
	to := users[t.ToUserID]
	return TransferHistoryItem{
		ID:           t.ID.String(),
		FromUserID:   t.FromUserID.String(),
		FromUsername: from.Username,
		FromFullName: from.FullName,
		ToUserID:     t.ToUserID.String(),
		ToUsername:   to.Username,
		ToFullName:   to.FullName,
		VipIconID:    t.VipIconID,
		CreatedAt:    t.CreatedAt.Format(time.RFC3339),
	}
}

func (s *Service) ListTransfers(userID *uuid.UUID, q string, limit, offset int) (*TransferHistoryListResponse, error) {
	items, total, err := s.repo.ListTransfers(userID, q, limit, offset)
	if err != nil {
		return nil, err
	}

	idSet := make(map[uuid.UUID]struct{}, len(items)*2)
	for i := range items {
		idSet[items[i].FromUserID] = struct{}{}
		idSet[items[i].ToUserID] = struct{}{}
	}
	ids := make([]uuid.UUID, 0, len(idSet))
	for id := range idSet {
		ids = append(ids, id)
	}
	users, err := s.repo.FindUsers(ids)
	if err != nil {
		return nil, err
	}

	out := make([]TransferHistoryItem, 0, len(items))
	for i := range items {
		out = append(out, toTransferHistoryItem(&items[i], users))
	}
	return &TransferHistoryListResponse{
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
	if err := s.repo.CreatePackageAt(pkg, req.SortOrder); err != nil {
		return nil, err
	}
	s.invalidatePackages()
	item := toPackageItem(pkg)
	return &item, nil
}

func (s *Service) ReorderPackages(ids []uuid.UUID) error {
	if err := s.repo.ReorderPackages(ids); err != nil {
		return err
	}
	s.invalidatePackages()
	return nil
}

func (s *Service) UpdatePackage(id uuid.UUID, req UpdatePackageRequest) (*PackageItem, error) {
	current, err := s.repo.FindPackage(id)
	if err != nil {
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
	if req.SortOrder != nil && *req.SortOrder != current.SortOrder {
		err = s.repo.UpdatePackageAt(id, fields, *req.SortOrder)
	} else if len(fields) > 0 {
		err = s.repo.UpdatePackage(id, fields)
	}
	if err != nil {
		return nil, err
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
