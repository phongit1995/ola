package vip

import (
	"errors"
	"strings"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

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
	s.wsServer.EmitKenUpdate(userID, updatedUser.Ken)

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
	if err := s.repo.CreateShopItemAt(item, req.SortOrder); err != nil {
		return nil, err
	}
	out := toShopItem(item)
	return &out, nil
}

func (s *Service) ReorderShopItems(ids []uuid.UUID) error {
	return s.repo.ReorderShopItems(ids)
}

func (s *Service) UpdateShopItem(id uuid.UUID, req UpdateShopItemRequest) (*ShopItem, error) {
	current, err := s.repo.FindShopItem(id)
	if err != nil {
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
	if req.SortOrder != nil && *req.SortOrder != current.SortOrder {
		err = s.repo.UpdateShopItemAt(id, fields, *req.SortOrder)
	} else if len(fields) > 0 {
		err = s.repo.UpdateShopItem(id, fields)
	}
	if err != nil {
		return nil, err
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

func (s *Service) GiftIcon(fromID, shopItemID uuid.UUID, toUsername, password string) (*GiftIconResponse, error) {
	item, err := s.repo.FindActiveShopItem(shopItemID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrShopItemNotFound
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

	_, giver, err := s.repo.GiftShopItem(fromID, receiver, item)
	if err != nil {
		return nil, err
	}

	s.invalidate(fromID)
	s.invalidate(receiver.ID)
	s.wsServer.EmitKenUpdate(fromID, giver.Ken)
	s.notifSvc.Create(receiver.ID, &fromID, models.AppNotificationVipReceived, nil, models.AppNotificationTransfer{VipTypeID: item.VipTypeID}.Preview())

	return &GiftIconResponse{
		ReceiverUsername: receiver.Username,
		KenSpent:         item.KenPrice,
		KenBalance:       giver.Ken,
	}, nil
}
