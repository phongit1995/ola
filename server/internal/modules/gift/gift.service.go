package gift

import (
	"encoding/json"
	"errors"
	"fmt"
	"strings"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/message"
	"ola-chat-server/internal/modules/notification"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo       *Repository
	settings   *setting.Service
	relRepo    *relationships.Repository
	userCache  *user.CacheService
	cache      *services.CacheService
	msgService *message.Service
	notifSvc   *notification.Service
	wsServer   *websocket.Server
	logger     *zap.SugaredLogger
}

func NewService(
	repo *Repository,
	settings *setting.Service,
	relRepo *relationships.Repository,
	userCache *user.CacheService,
	cache *services.CacheService,
	msgService *message.Service,
	notifSvc *notification.Service,
	wsServer *websocket.Server,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:       repo,
		settings:   settings,
		relRepo:    relRepo,
		userCache:  userCache,
		cache:      cache,
		msgService: msgService,
		notifSvc:   notifSvc,
		wsServer:   wsServer,
		logger:     logger.Named("[gift_service]"),
	}
}

func (s *Service) giftConfig() setting.GiftConfig {
	cfg, err := s.settings.GetGift()
	if err != nil {
		s.logger.Warnw("Failed to read gift config, using default", "error", err.Error())
	}
	return cfg
}

func ToGiftItem(g *models.Gift) GiftItem {
	return GiftItem{
		ID:          g.ID.String(),
		Name:        g.Name,
		NameEn:      g.NameEn,
		ImageURL:    g.ImageURL,
		KenPrice:    g.KenPrice,
		CharmPoints: g.CharmPoints,
		Animation:   g.Animation,
	}
}

func toSettingsView(cfg setting.GiftConfig) GiftSettingsView {
	return GiftSettingsView{
		Enabled:         cfg.Enabled,
		QuantityOptions: cfg.QuantityOptions,
		QuantityMax:     cfg.QuantityMax,
		NoteMaxLength:   cfg.NoteMaxLength,
		ConfirmOverKen:  cfg.ConfirmOverKen,
	}
}

func (s *Service) activeGifts() ([]GiftItem, error) {
	var cached []GiftItem
	if err := s.cache.Get(CacheKeyGiftCatalog, &cached); err == nil && cached != nil {
		return cached, nil
	}
	gifts, err := s.repo.ListActive()
	if err != nil {
		return nil, err
	}
	items := make([]GiftItem, 0, len(gifts))
	for i := range gifts {
		items = append(items, ToGiftItem(&gifts[i]))
	}
	if err := s.cache.Set(CacheKeyGiftCatalog, items, CacheTTLGiftCatalog); err != nil {
		s.logger.Warnw("Failed to cache gift catalog", "error", err.Error())
	}
	return items, nil
}

func (s *Service) InvalidateCatalog() {
	if err := s.cache.Delete(CacheKeyGiftCatalog); err != nil {
		s.logger.Warnw("Failed to invalidate gift catalog cache", "error", err.Error())
	}
}

func (s *Service) Catalog() (*GiftCatalogResponse, error) {
	items, err := s.activeGifts()
	if err != nil {
		return nil, err
	}
	return &GiftCatalogResponse{Items: items, Settings: toSettingsView(s.giftConfig())}, nil
}

func giftPreview(giftName string, quantity int) string {
	return fmt.Sprintf("🎁 %s ×%d", giftName, quantity)
}

func sameRequest(existing *models.GiftTransaction, giftID, receiverID uuid.UUID, quantity int) bool {
	return existing.GiftID == giftID && existing.ReceiverID == receiverID && existing.Quantity == quantity
}

func (s *Service) Send(senderID uuid.UUID, req SendGiftRequest) (*SendGiftResponse, error) {
	cfg := s.giftConfig()
	if !cfg.Enabled {
		return nil, ErrGiftDisabled
	}
	giftID, err := uuid.Parse(req.GiftID)
	if err != nil {
		return nil, ErrGiftNotFound
	}
	receiverID, err := uuid.Parse(req.ReceiverID)
	if err != nil {
		return nil, ErrGiftReceiverUnavailable
	}
	if receiverID == senderID {
		return nil, ErrGiftSelf
	}
	if req.Quantity < 1 || req.Quantity > cfg.QuantityMax {
		return nil, ErrGiftInvalidQuantity
	}
	note := strings.TrimSpace(req.Note)
	if utf8.RuneCountInString(note) > cfg.NoteMaxLength {
		return nil, ErrGiftNoteTooLong
	}
	clientRequestID := strings.TrimSpace(req.ClientRequestID)

	if existing, err := s.repo.FindByClientRequest(senderID, clientRequestID); err != nil {
		return nil, err
	} else if existing != nil {
		return s.replay(existing, giftID, receiverID, req.Quantity)
	}

	gift, err := s.repo.FindByID(giftID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrGiftNotFound
		}
		return nil, err
	}
	if !gift.IsActive {
		return nil, ErrGiftNotFound
	}

	blocked, err := s.relRepo.IsBlockedEither(senderID, receiverID)
	if err != nil {
		return nil, err
	}
	if blocked {
		return nil, ErrGiftBlocked
	}

	result, err := s.repo.Send(SendParams{
		SenderID:        senderID,
		ReceiverID:      receiverID,
		Gift:            gift,
		Quantity:        req.Quantity,
		Note:            note,
		Source:          req.Source,
		ClientRequestID: clientRequestID,
		Description:     fmt.Sprintf("Tặng %s ×%d", gift.Name, req.Quantity),
	})
	if err != nil {
		if apperr.IsUniqueViolation(err) {
			existing, findErr := s.repo.FindByClientRequest(senderID, clientRequestID)
			if findErr == nil && existing != nil {
				return s.replay(existing, giftID, receiverID, req.Quantity)
			}
		}
		return nil, err
	}

	s.afterSend(gift, result)
	return s.buildSendResponse(gift, &result.Transaction, result.SenderBalance, result.ReceiverCharm), nil
}

func (s *Service) replay(existing *models.GiftTransaction, giftID, receiverID uuid.UUID, quantity int) (*SendGiftResponse, error) {
	if !sameRequest(existing, giftID, receiverID, quantity) {
		return nil, ErrGiftRequestConflict
	}
	gift, err := s.repo.FindByID(existing.GiftID)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, err
	}
	if gift == nil {
		gift = &models.Gift{BaseModel: models.BaseModel{ID: existing.GiftID}, Name: existing.GiftName, ImageURL: existing.GiftImageURL, KenPrice: existing.UnitPrice, Animation: models.GiftAnimationRandom}
	}
	ken, charm, err := s.repo.Balances(existing.SenderID, existing.ReceiverID)
	if err != nil {
		return nil, err
	}
	return s.buildSendResponse(gift, existing, ken, charm), nil
}

func (s *Service) buildSendResponse(gift *models.Gift, tx *models.GiftTransaction, kenBalance, receiverCharm int) *SendGiftResponse {
	item := ToGiftItem(gift)
	item.Name = tx.GiftName
	item.ImageURL = tx.GiftImageURL
	item.KenPrice = tx.UnitPrice
	resp := &SendGiftResponse{
		TransactionID: tx.ID.String(),
		Gift:          item,
		ReceiverID:    tx.ReceiverID.String(),
		Quantity:      tx.Quantity,
		TotalKen:      tx.TotalKen,
		CharmPoints:   tx.CharmPoints,
		Note:          tx.Note,
		KenBalance:    kenBalance,
		ReceiverCharm: receiverCharm,
		MessageID:     tx.MessageID,
		CreatedAt:     tx.CreatedAt.UTC().Format(time.RFC3339),
	}
	if tx.ConversationID != nil {
		resp.ConversationID = tx.ConversationID.String()
	}
	return resp
}

func (s *Service) afterSend(gift *models.Gift, result *SendResult) {
	tx := &result.Transaction
	s.wsServer.EmitKenUpdate(tx.SenderID, result.SenderBalance)
	for _, id := range []uuid.UUID{tx.SenderID, tx.ReceiverID} {
		if err := s.userCache.InvalidateUser(id); err != nil {
			s.logger.Warnw("Failed to invalidate user cache after gift", "user_id", id, "error", err.Error())
		}
	}

	if tx.Source == models.GiftSourceChat {
		s.sendGiftMessage(gift, tx)
		return
	}
	txID := tx.ID
	senderID := tx.SenderID
	s.notifSvc.Create(tx.ReceiverID, &senderID, models.AppNotificationGiftReceived, &txID, giftPreview(tx.GiftName, tx.Quantity))
}

func (s *Service) sendGiftMessage(gift *models.Gift, tx *models.GiftTransaction) {
	meta, err := json.Marshal(GiftMessageMetadata{
		TransactionID: tx.ID.String(),
		GiftID:        tx.GiftID.String(),
		GiftName:      tx.GiftName,
		GiftNameEn:    gift.NameEn,
		ImageURL:      tx.GiftImageURL,
		Animation:     gift.Animation,
		Quantity:      tx.Quantity,
		CharmPoints:   tx.CharmPoints,
	})
	if err != nil {
		s.logger.Errorw("Failed to marshal gift message metadata", "transaction_id", tx.ID, "error", err.Error())
		return
	}
	msg, err := s.msgService.SendDirectMessage(
		tx.SenderID,
		tx.ReceiverID,
		constants.MessageTypeGift,
		tx.Note,
		string(meta),
		"gift:"+tx.ClientRequestID,
	)
	if err != nil {
		s.logger.Warnw("Failed to send gift chat message", "transaction_id", tx.ID, "error", err.Error())
		return
	}
	conversationID, err := uuid.Parse(msg.ConversationID)
	if err != nil {
		return
	}
	if err := s.repo.SetMessage(tx.ID, conversationID, msg.ID); err != nil {
		s.logger.Warnw("Failed to link gift message", "transaction_id", tx.ID, "error", err.Error())
		return
	}
	tx.ConversationID = &conversationID
	tx.MessageID = msg.ID
}

func (s *Service) ensureCanViewWall(viewerID, ownerID uuid.UUID) error {
	if viewerID == ownerID {
		return nil
	}
	privacy, err := s.repo.GiftWallPrivacy(ownerID)
	if err != nil {
		return err
	}
	switch privacy {
	case models.SettingGiftWallPrivacyOnlyMe:
		return ErrGiftWallPrivate
	case models.SettingGiftWallPrivacyFriends:
		friends, err := s.relRepo.AreFriends(viewerID, ownerID)
		if err != nil {
			return err
		}
		if !friends {
			return ErrGiftWallPrivate
		}
	}
	return nil
}

func (s *Service) Wall(viewerID, userID uuid.UUID) (*GiftWallResponse, error) {
	charm, err := s.repo.UserCharm(userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}
	if err := s.ensureCanViewWall(viewerID, userID); err != nil {
		return nil, err
	}
	rows, err := s.repo.Wall(userID)
	if err != nil {
		return nil, err
	}
	items := make([]GiftWallItem, 0, len(rows))
	total := 0
	for _, row := range rows {
		total += row.Quantity
		items = append(items, GiftWallItem{
			Gift: GiftItem{
				ID:          row.GiftID.String(),
				Name:        row.Name,
				NameEn:      row.NameEn,
				ImageURL:    row.ImageURL,
				Animation:   row.Animation,
				KenPrice:    row.KenPrice,
				CharmPoints: row.CharmPoints,
			},
			Quantity: row.Quantity,
		})
	}
	return &GiftWallResponse{UserID: userID.String(), Charm: charm, TotalGifts: total, Items: items}, nil
}

func (s *Service) userBriefs(ids []uuid.UUID) map[uuid.UUID]GiftUserBrief {
	users := s.userCache.GetUsersBatch(ids, true)
	out := make(map[uuid.UUID]GiftUserBrief, len(ids))
	for _, id := range ids {
		u, ok := users[id]
		if !ok || u == nil {
			out[id] = GiftUserBrief{ID: id.String(), Username: id.String()[:8]}
			continue
		}
		brief := GiftUserBrief{
			ID:       id.String(),
			Username: u.Username,
			FullName: u.FullName,
			Avatar:   u.Avatar,
			Gender:   u.Gender,
			VipUsed:  u.VipUsed,
		}
		if u.VipEndTime != nil {
			end := u.VipEndTime.UTC().Format(time.RFC3339)
			brief.VipEndTime = &end
		}
		out[id] = brief
	}
	return out
}

func (s *Service) giftAnimations(items []models.GiftTransaction) map[uuid.UUID]string {
	ids := make([]uuid.UUID, 0, len(items))
	seen := make(map[uuid.UUID]bool, len(items))
	for i := range items {
		if !seen[items[i].GiftID] {
			seen[items[i].GiftID] = true
			ids = append(ids, items[i].GiftID)
		}
	}
	animations, err := s.repo.GiftAnimations(ids)
	if err != nil {
		s.logger.Warnw("Failed to load gift animations for history", "error", err.Error())
	}
	return animations
}

func (s *Service) History(userID uuid.UUID, direction, cursor string, limit int) (*GiftHistoryResponse, error) {
	cursorAt, cursorID, err := utils.DecodeTimeCursor(cursor)
	if err != nil {
		return nil, utils.NewHTTPError(400, err.Error())
	}
	items, err := s.repo.History(userID, direction, cursorAt, cursorID, limit+1)
	if err != nil {
		return nil, err
	}
	hasMore := len(items) > limit
	if hasMore {
		items = items[:limit]
	}
	ids := make([]uuid.UUID, 0, len(items))
	for i := range items {
		ids = append(ids, counterpartyOf(&items[i], direction))
	}
	briefs := s.userBriefs(ids)
	animations := s.giftAnimations(items)
	out := make([]GiftHistoryItem, 0, len(items))
	for i := range items {
		t := &items[i]
		out = append(out, GiftHistoryItem{
			ID:            t.ID.String(),
			Counterparty:  briefs[counterpartyOf(t, direction)],
			GiftID:        t.GiftID.String(),
			GiftName:      t.GiftName,
			GiftImageURL:  t.GiftImageURL,
			GiftAnimation: animations[t.GiftID],
			Quantity:      t.Quantity,
			TotalKen:      t.TotalKen,
			CharmPoints:   t.CharmPoints,
			Note:          t.Note,
			Source:        t.Source,
			CreatedAt:     t.CreatedAt.UTC().Format(time.RFC3339),
		})
	}
	resp := &GiftHistoryResponse{Items: out}
	if hasMore && len(items) > 0 {
		last := items[len(items)-1]
		resp.NextCursor = utils.EncodeTimeCursor(last.CreatedAt, last.ID)
	}
	return resp, nil
}

func counterpartyOf(t *models.GiftTransaction, direction string) uuid.UUID {
	if direction == HistoryDirectionSent {
		return t.ReceiverID
	}
	return t.SenderID
}

func NormalizeLeaderboardType(v string) string {
	if v == LeaderboardTypeSender {
		return LeaderboardTypeSender
	}
	return LeaderboardTypeReceiver
}

func NormalizeLeaderboardPeriod(v string) string {
	switch v {
	case utils.PeriodWeek, utils.PeriodMonth, utils.PeriodAll:
		return v
	}
	return utils.PeriodWeek
}

type cachedLeaderboard struct {
	Rows []LeaderboardRow `json:"rows"`
}

func (s *Service) Leaderboard(userID uuid.UUID, boardType, period string, limit int) (*LeaderboardResponse, error) {
	boardType = NormalizeLeaderboardType(boardType)
	period = NormalizeLeaderboardPeriod(period)
	var from *time.Time
	if start, ok := utils.VietnamPeriodStart(time.Now(), period); ok {
		from = &start
	}

	cacheKey := fmt.Sprintf(CacheKeyGiftLeaderboard, boardType, period)
	var cached cachedLeaderboard
	var rows []LeaderboardRow
	if err := s.cache.Get(cacheKey, &cached); err == nil && cached.Rows != nil {
		rows = cached.Rows
	} else {
		fresh, err := s.repo.Leaderboard(boardType, from, LeaderboardMaxLimit)
		if err != nil {
			return nil, err
		}
		rows = fresh
		if rows == nil {
			rows = []LeaderboardRow{}
		}
		if err := s.cache.Set(cacheKey, cachedLeaderboard{Rows: rows}, CacheTTLGiftLeaderboard); err != nil {
			s.logger.Warnw("Failed to cache gift leaderboard", "key", cacheKey, "error", err.Error())
		}
	}
	if len(rows) > limit {
		rows = rows[:limit]
	}

	ids := make([]uuid.UUID, 0, len(rows))
	for _, row := range rows {
		ids = append(ids, row.UserID)
	}
	briefs := s.userBriefs(ids)
	items := make([]LeaderboardEntry, 0, len(rows))
	for i, row := range rows {
		items = append(items, LeaderboardEntry{Rank: i + 1, User: briefs[row.UserID], Value: row.Value})
	}

	rank, value, err := s.repo.Rank(boardType, from, userID)
	if err != nil {
		return nil, err
	}
	return &LeaderboardResponse{Type: boardType, Period: period, Items: items, Me: LeaderboardMe{Rank: rank, Value: value}}, nil
}
