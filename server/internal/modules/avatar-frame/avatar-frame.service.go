package avatarframe

import (
	"errors"
	"fmt"
	"strings"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/notification"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type Service struct {
	repo      *Repository
	relRepo   *relationships.Repository
	userCache *user.CacheService
	cache     *services.CacheService
	wsServer  *websocket.Server
	notifSvc  *notification.Service
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, relRepo *relationships.Repository, userCache *user.CacheService, cache *services.CacheService, wsServer *websocket.Server, notifSvc *notification.Service, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		relRepo:   relRepo,
		userCache: userCache,
		cache:     cache,
		wsServer:  wsServer,
		notifSvc:  notifSvc,
		logger:    logger.Named("[avatar_frame_service]"),
	}
}

func IsValidFrameID(id string) bool {
	if len(id) != FrameIDLength {
		return false
	}
	for _, c := range id {
		if c < '0' || c > '9' {
			return false
		}
	}
	return true
}

func (s *Service) invalidate(userID uuid.UUID) {
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after avatar frame change", "user_id", userID, "error", err.Error())
	}
}

func toShopItem(it *models.AvatarFrameShopItem, owned bool) ShopItem {
	return ShopItem{
		ID:        it.ID.String(),
		FrameID:   it.FrameID,
		KenPrice:  it.KenPrice,
		IsActive:  it.IsActive,
		SortOrder: it.SortOrder,
		Owned:     owned,
	}
}

func (s *Service) ListShop(userID uuid.UUID) (*ShopResponse, error) {
	items, err := s.repo.ListShopItems(true)
	if err != nil {
		return nil, err
	}
	owned, err := s.repo.OwnedFrameIDs(userID)
	if err != nil {
		return nil, err
	}
	out := make([]ShopItem, 0, len(items))
	for i := range items {
		out = append(out, toShopItem(&items[i], owned[items[i].FrameID]))
	}
	return &ShopResponse{Total: len(out), Items: out}, nil
}

func (s *Service) activeShopItem(id uuid.UUID) (*models.AvatarFrameShopItem, error) {
	item, err := s.repo.FindActiveShopItem(id)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, ErrShopItemNotFound
	}
	return item, err
}

func (s *Service) Buy(userID, shopItemID uuid.UUID, expectedKenPrice int) (*BuyResponse, error) {
	item, err := s.activeShopItem(shopItemID)
	if err != nil {
		return nil, err
	}
	payer, err := s.repo.Purchase(userID, item, expectedKenPrice)
	if err != nil {
		return nil, err
	}
	s.invalidate(userID)
	s.wsServer.EmitKenUpdate(userID, payer.Ken)
	return &BuyResponse{FrameID: item.FrameID, KenSpent: item.KenPrice, KenBalance: payer.Ken}, nil
}

func (s *Service) checkPassword(u *models.User, password string) error {
	if bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(password)) != nil {
		return ErrWrongPassword
	}
	return nil
}

func (s *Service) checkNotBlocked(a, b uuid.UUID) error {
	blocked, err := s.relRepo.IsBlockedEither(a, b)
	if err != nil {
		return err
	}
	if blocked {
		return ErrBlocked
	}
	return nil
}

func (s *Service) notifyReceived(toID, fromID uuid.UUID, frameID string) {
	s.notifSvc.Create(toID, &fromID, models.AppNotificationAvatarFrame, nil, models.AppNotificationTransfer{FrameID: frameID}.Preview())
}

func (s *Service) Gift(fromID, shopItemID uuid.UUID, expectedKenPrice int, toUsername, password string) (*GiftResponse, error) {
	item, err := s.activeShopItem(shopItemID)
	if err != nil {
		return nil, err
	}
	sender, err := s.repo.GetUser(fromID)
	if err != nil {
		return nil, err
	}
	if err := s.checkPassword(sender, password); err != nil {
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
		return nil, ErrSelfTarget
	}
	if err := s.checkNotBlocked(fromID, receiver.ID); err != nil {
		return nil, err
	}

	payer, err := s.repo.Gift(fromID, receiver, item, expectedKenPrice)
	if err != nil {
		return nil, err
	}
	s.invalidate(fromID)
	s.invalidate(receiver.ID)
	s.wsServer.EmitKenUpdate(fromID, payer.Ken)
	s.notifyReceived(receiver.ID, fromID, item.FrameID)

	return &GiftResponse{
		ReceiverUsername: receiver.Username,
		FrameID:          item.FrameID,
		KenSpent:         item.KenPrice,
		KenBalance:       payer.Ken,
	}, nil
}

func (s *Service) Transfer(fromID uuid.UUID, frameID string, toID uuid.UUID, password string) error {
	if !IsValidFrameID(frameID) {
		return ErrInvalidFrameID
	}
	if toID == fromID {
		return ErrSelfTarget
	}
	sender, err := s.repo.GetUser(fromID)
	if err != nil {
		return err
	}
	if err := s.checkPassword(sender, password); err != nil {
		return err
	}
	if _, err := s.repo.GetUser(toID); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrReceiverNotFound
		}
		return err
	}
	if err := s.checkNotBlocked(fromID, toID); err != nil {
		return err
	}
	if err := s.repo.Transfer(fromID, toID, frameID); err != nil {
		return err
	}
	s.notifyReceived(toID, fromID, frameID)
	return nil
}

func (s *Service) Equip(userID uuid.UUID, frameID string) (*EquipResponse, error) {
	if frameID == "" {
		if err := s.repo.ClearEquipped(userID); err != nil {
			return nil, err
		}
		s.invalidate(userID)
		return &EquipResponse{}, nil
	}
	if !IsValidFrameID(frameID) {
		return nil, ErrInvalidFrameID
	}
	if err := s.repo.Equip(userID, frameID, time.Now()); err != nil {
		return nil, err
	}
	s.invalidate(userID)
	return &EquipResponse{EquippedFrameID: &frameID}, nil
}

func (s *Service) AdminStore(userID uuid.UUID, limit, offset int) (*StoreResponse, error) {
	return s.GetStore(userID, userID, limit, offset)
}

func (s *Service) AdminGrant(userID uuid.UUID, frameID string) error {
	if !IsValidFrameID(frameID) {
		return ErrInvalidFrameID
	}
	if _, err := s.repo.GetUser(userID); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return apperr.ErrUserNotFound
		}
		return err
	}
	granted, err := s.repo.AdminGrant(userID, frameID, time.Now())
	if err != nil {
		return err
	}
	if !granted {
		return ErrReceiverOwns
	}
	s.invalidate(userID)
	s.logger.Infow("Admin granted avatar frame", "user_id", userID, "frame_id", frameID)
	return nil
}

func (s *Service) GetStore(viewerID, targetID uuid.UUID, limit, offset int) (*StoreResponse, error) {
	target, err := s.repo.GetUser(targetID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrReceiverNotFound
		}
		return nil, err
	}
	privacy, err := s.repo.GetStorePrivacy(targetID)
	if err != nil {
		return nil, err
	}
	isSelf := viewerID == targetID
	if !isSelf {
		switch privacy {
		case models.SettingGiftWallPrivacyOnlyMe:
			return nil, ErrPrivateStore
		case models.SettingGiftWallPrivacyFriends:
			ok, err := s.repo.AreFriends(viewerID, targetID)
			if err != nil {
				return nil, err
			}
			if !ok {
				return nil, ErrPrivateStore
			}
		}
	}

	now := time.Now()
	equipped := target.ActiveAvatarFrameID(now)
	if isSelf && target.AvatarFrameID != nil && *target.AvatarFrameID != "" {
		equipped = target.AvatarFrameID
	}
	sortKey := ""
	if equipped != nil {
		sortKey = *equipped
	}

	total, err := s.repo.CountOwned(targetID)
	if err != nil {
		return nil, err
	}
	rows, err := s.repo.ListOwned(targetID, sortKey, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]OwnedFrame, 0, len(rows))
	for i := range rows {
		items = append(items, OwnedFrame{
			FrameID:    rows[i].FrameID,
			Source:     rows[i].Source,
			AcquiredAt: rows[i].AcquiredAt.Format(time.RFC3339),
			IsEquipped: equipped != nil && *equipped == rows[i].FrameID,
		})
	}
	return &StoreResponse{
		UserID:          targetID.String(),
		EquippedFrameID: equipped,
		VipActive:       target.HasActiveVip(now),
		Privacy:         privacy,
		Total:           int(total),
		Limit:           limit,
		Offset:          offset,
		Items:           items,
	}, nil
}

func (s *Service) SetPrivacy(userID uuid.UUID, privacy int16) error {
	if err := s.repo.SetStorePrivacy(userID, privacy); err != nil {
		return err
	}
	key := fmt.Sprintf(constants.CacheKeyUserSettings, userID)
	if err := s.cache.Delete(key); err != nil {
		s.logger.Warnw("failed to invalidate user settings cache", "user_id", userID, "error", err.Error())
	}
	return nil
}

func toBrief(id uuid.UUID, users map[uuid.UUID]models.User) UserBrief {
	u := users[id]
	return UserBrief{ID: id.String(), Username: u.Username, FullName: u.FullName}
}

func (s *Service) ListPurchases(f PurchaseFilter, limit, offset int) (*PurchaseHistoryResponse, error) {
	rows, total, err := s.repo.ListPurchases(f, limit, offset)
	if err != nil {
		return nil, err
	}
	ids := make([]uuid.UUID, 0, len(rows)*2)
	for i := range rows {
		ids = append(ids, rows[i].UserID)
		if rows[i].RecipientUserID != nil {
			ids = append(ids, *rows[i].RecipientUserID)
		}
	}
	users, err := s.repo.FindUsers(uniqueIDs(ids...))
	if err != nil {
		return nil, err
	}
	items := make([]PurchaseHistoryItem, 0, len(rows))
	for i := range rows {
		item := PurchaseHistoryItem{
			ID:        rows[i].ID.String(),
			FrameID:   rows[i].FrameID,
			KenPrice:  rows[i].KenPrice,
			Source:    rows[i].Source,
			Buyer:     toBrief(rows[i].UserID, users),
			CreatedAt: rows[i].CreatedAt.Format(time.RFC3339),
		}
		if rows[i].RecipientUserID != nil {
			recipient := toBrief(*rows[i].RecipientUserID, users)
			item.Recipient = &recipient
		}
		items = append(items, item)
	}
	return &PurchaseHistoryResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}

func (s *Service) ListTransfers(userID *uuid.UUID, search string, limit, offset int) (*TransferHistoryResponse, error) {
	rows, total, err := s.repo.ListTransfers(userID, search, limit, offset)
	if err != nil {
		return nil, err
	}
	ids := make([]uuid.UUID, 0, len(rows)*2)
	for i := range rows {
		ids = append(ids, rows[i].FromUserID, rows[i].ToUserID)
	}
	users, err := s.repo.FindUsers(uniqueIDs(ids...))
	if err != nil {
		return nil, err
	}
	items := make([]TransferHistoryItem, 0, len(rows))
	for i := range rows {
		items = append(items, TransferHistoryItem{
			ID:        rows[i].ID.String(),
			FrameID:   rows[i].FrameID,
			From:      toBrief(rows[i].FromUserID, users),
			To:        toBrief(rows[i].ToUserID, users),
			CreatedAt: rows[i].CreatedAt.Format(time.RFC3339),
		})
	}
	return &TransferHistoryResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}

func (s *Service) ListAllShopItems() (*ShopResponse, error) {
	items, err := s.repo.ListShopItems(false)
	if err != nil {
		return nil, err
	}
	out := make([]ShopItem, 0, len(items))
	for i := range items {
		out = append(out, toShopItem(&items[i], false))
	}
	return &ShopResponse{Total: len(out), Items: out}, nil
}

func (s *Service) CreateShopItems(req *CreateShopItemsRequest) (*CreateShopItemsResponse, error) {
	ids := make([]string, 0, len(req.FrameIDs))
	seen := make(map[string]bool, len(req.FrameIDs))
	for _, id := range req.FrameIDs {
		if !IsValidFrameID(id) {
			return nil, ErrInvalidFrameID
		}
		if !seen[id] {
			seen[id] = true
			ids = append(ids, id)
		}
	}
	existing, err := s.repo.ShopFrameIDs(ids)
	if err != nil {
		return nil, err
	}
	active := true
	if req.IsActive != nil {
		active = *req.IsActive
	}
	resp := &CreateShopItemsResponse{Created: []ShopItem{}, Skipped: []string{}}
	createdIDs := make([]uuid.UUID, 0, len(ids))
	for _, id := range ids {
		if existing[id] {
			resp.Skipped = append(resp.Skipped, id)
			continue
		}
		item := models.AvatarFrameShopItem{
			FrameID:   id,
			KenPrice:  req.KenPrice,
			IsActive:  active,
			SortOrder: req.SortOrder,
		}
		if err := s.repo.CreateShopItem(&item); err != nil {
			if apperr.IsUniqueViolation(err) {
				resp.Skipped = append(resp.Skipped, id)
				continue
			}
			return nil, err
		}
		createdIDs = append(createdIDs, item.ID)
		resp.Created = append(resp.Created, toShopItem(&item, false))
	}
	if len(createdIDs) == 0 {
		return resp, nil
	}
	first, err := s.repo.PlaceShopItems(createdIDs, req.SortOrder)
	if err != nil {
		return nil, err
	}
	for index := range resp.Created {
		resp.Created[index].SortOrder = first + index
	}
	return resp, nil
}

func (s *Service) ReorderShopItems(ids []uuid.UUID) error {
	return s.repo.ReorderShopItems(ids)
}

func (s *Service) UpdateShopItem(id uuid.UUID, req *UpdateShopItemRequest) (*ShopItem, error) {
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
	out := toShopItem(item, false)
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

func (s *Service) PurchaseTotals(from, to *time.Time) (PurchaseTotals, error) {
	return s.repo.PurchaseTotals(from, to)
}

func (s *Service) TopFrames(from, to time.Time, limit int) ([]FrameSalesRow, error) {
	return s.repo.TopFrames(from, to, limit)
}
