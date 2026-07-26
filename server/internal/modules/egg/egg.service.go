package egg

import (
	"errors"
	"fmt"
	"math"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var (
	ErrPackNotFound    = errors.New("egg pack not found")
	ErrInsufficientKen = errors.New("insufficient ken balance")
	ErrPackEmpty       = errors.New("egg pack has no active rewards")
)

type DrawOutcome struct {
	CategoryType   models.EggCategoryType
	RewardType     *string
	RewardLabel    string
	VipTypeID      *int16
	KenAmount      *int
	VipDays        *int
	IsSuperLucky   bool
	CategoryWeight float64
	RewardWeight   float64
}

type Service struct {
	repo      *Repository
	userCache *user.CacheService
	cache     *services.CacheService
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, userCache *user.CacheService, cache *services.CacheService, wsServer *websocket.Server, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		userCache: userCache,
		cache:     cache,
		wsServer:  wsServer,
		logger:    logger.Named("[egg_service]"),
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

func (s *Service) invalidateUser(userID uuid.UUID) {
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after egg draw", "user_id", userID, "error", err.Error())
	}
}

func (s *Service) listPacks(enabledOnly, includeConfig bool) ([]PackView, error) {
	packs, err := s.repo.ListPacks(enabledOnly)
	if err != nil {
		return nil, err
	}
	if len(packs) == 0 {
		return []PackView{}, nil
	}
	if !includeConfig {
		return buildPackViews(packs, nil, nil, false), nil
	}
	packIDs := make([]uuid.UUID, len(packs))
	for i, p := range packs {
		packIDs[i] = p.ID
	}
	cats, err := s.repo.CategoriesByPacks(packIDs)
	if err != nil {
		return nil, err
	}
	catIDs := make([]uuid.UUID, len(cats))
	for i, c := range cats {
		catIDs[i] = c.ID
	}
	rewards, err := s.repo.RewardsByCategories(catIDs)
	if err != nil {
		return nil, err
	}
	return buildPackViews(packs, cats, rewards, true), nil
}

func (s *Service) ListPacksForUser() (*PackListResponse, error) {
	views, err := s.listPacks(true, false)
	if err != nil {
		return nil, err
	}
	return &PackListResponse{Items: views}, nil
}

func giftIdentity(catType models.EggCategoryType, rw models.EggReward) string {
	switch catType {
	case models.EggCategoryKen:
		if rw.KenAmount != nil {
			return fmt.Sprintf("ken:%d", *rw.KenAmount)
		}
	case models.EggCategoryVipDays:
		if rw.VipDays != nil {
			return fmt.Sprintf("vip_days:%d", *rw.VipDays)
		}
	case models.EggCategoryVipIcon:
		if rw.VipTypeID != nil {
			return fmt.Sprintf("vip_icon:%d", *rw.VipTypeID)
		}
	}
	return fmt.Sprintf("%s:%s", catType, rw.Label)
}

func (s *Service) ListGifts(packID uuid.UUID) (*GiftListResponse, error) {
	pack, err := s.repo.FindPack(packID)
	if err != nil || !pack.IsEnabled {
		return nil, ErrPackNotFound
	}
	cats, err := s.repo.CategoriesByPacks([]uuid.UUID{pack.ID})
	if err != nil {
		return nil, err
	}
	activeCats := make([]models.EggCategory, 0, len(cats))
	catIDs := make([]uuid.UUID, 0, len(cats))
	for _, c := range cats {
		if !c.IsActive || c.Type == models.EggCategoryNothing {
			continue
		}
		activeCats = append(activeCats, c)
		catIDs = append(catIDs, c.ID)
	}
	rewards, err := s.repo.RewardsByCategories(catIDs)
	if err != nil {
		return nil, err
	}
	rewardsByCat := map[uuid.UUID][]models.EggReward{}
	for _, rw := range rewards {
		if !rw.IsActive {
			continue
		}
		rewardsByCat[rw.CategoryID] = append(rewardsByCat[rw.CategoryID], rw)
	}
	byType := map[models.EggCategoryType][]GiftRewardView{}
	typeOrder := make([]models.EggCategoryType, 0, len(activeCats))
	seen := map[string]bool{}
	for _, c := range activeCats {
		if _, ok := byType[c.Type]; !ok {
			typeOrder = append(typeOrder, c.Type)
			byType[c.Type] = []GiftRewardView{}
		}
		for _, rw := range rewardsByCat[c.ID] {
			key := giftIdentity(c.Type, rw)
			if seen[key] {
				continue
			}
			seen[key] = true
			byType[c.Type] = append(byType[c.Type], GiftRewardView{
				Label:        rw.Label,
				VipTypeID:    rw.VipTypeID,
				KenAmount:    rw.KenAmount,
				VipDays:      rw.VipDays,
				IsSuperLucky: rw.IsSuperLucky,
			})
		}
	}
	items := make([]GiftSectionView, 0, len(typeOrder))
	for _, catType := range typeOrder {
		if len(byType[catType]) == 0 {
			continue
		}
		items = append(items, GiftSectionView{Type: catType, Rewards: byType[catType]})
	}
	return &GiftListResponse{Items: items}, nil
}

func (s *Service) ListAllPacks() (*PackListResponse, error) {
	views, err := s.listPacks(false, true)
	if err != nil {
		return nil, err
	}
	return &PackListResponse{Items: views}, nil
}

func buildConfigModels(input []CategoryInput) ([]models.EggCategory, map[int][]models.EggReward) {
	cats := make([]models.EggCategory, len(input))
	rewardsByCat := map[int][]models.EggReward{}
	for i, c := range input {
		cats[i] = models.EggCategory{
			Type:      c.Type,
			Label:     c.Label,
			Weight:    c.Weight,
			IsActive:  c.IsActive,
			SortOrder: c.SortOrder,
		}
		rewards := make([]models.EggReward, len(c.Rewards))
		for j, rw := range c.Rewards {
			rewards[j] = models.EggReward{
				Label:        rw.Label,
				Weight:       rw.Weight,
				VipTypeID:    rw.VipTypeID,
				KenAmount:    rw.KenAmount,
				VipDays:      rw.VipDays,
				IsSuperLucky: rw.IsSuperLucky,
				IsActive:     rw.IsActive,
				SortOrder:    rw.SortOrder,
			}
		}
		rewardsByCat[i] = rewards
	}
	return cats, rewardsByCat
}

func (s *Service) CreatePack(req CreatePackRequest) (*PackView, error) {
	if err := validateConfig(req.Categories); err != nil {
		return nil, err
	}
	pack := models.EggPack{
		Name:      req.Name,
		KenCost:   req.KenCost,
		IsEnabled: req.IsEnabled,
		SortOrder: req.SortOrder,
	}
	cats, rewardsByCat := buildConfigModels(req.Categories)
	if err := s.repo.CreatePackWithConfig(&pack, cats, rewardsByCat); err != nil {
		return nil, err
	}
	return s.getPackView(pack.ID)
}

func (s *Service) UpdatePack(id uuid.UUID, req UpdatePackRequest) (*PackView, error) {
	if _, err := s.repo.FindPack(id); err != nil {
		return nil, ErrPackNotFound
	}
	fields := map[string]interface{}{}
	if req.Name != nil {
		fields["name"] = *req.Name
	}
	if req.KenCost != nil {
		fields["ken_cost"] = *req.KenCost
	}
	if req.IsEnabled != nil {
		fields["is_enabled"] = *req.IsEnabled
	}
	if req.SortOrder != nil {
		fields["sort_order"] = *req.SortOrder
	}
	if len(fields) > 0 {
		if err := s.repo.UpdatePack(id, fields); err != nil {
			return nil, err
		}
	}
	return s.getPackView(id)
}

func (s *Service) DeletePack(id uuid.UUID) error {
	if _, err := s.repo.FindPack(id); err != nil {
		return ErrPackNotFound
	}
	return s.repo.SoftDeletePack(id)
}

func validateConfig(cats []CategoryInput) error {
	active := 0
	var catSum float64
	for _, c := range cats {
		if !c.IsActive {
			continue
		}
		active++
		catSum += c.Weight
	}
	if active == 0 {
		return errors.New("gói phải có ít nhất 1 nhóm đang bật")
	}
	if math.Abs(catSum-100) > 0.5 {
		return fmt.Errorf("tổng %% các nhóm phải = 100%% (hiện %.2f%%)", catSum)
	}
	for _, c := range cats {
		if !c.IsActive || c.Type == models.EggCategoryNothing {
			continue
		}
		n := 0
		var rewardSum float64
		for _, r := range c.Rewards {
			if !r.IsActive {
				continue
			}
			n++
			rewardSum += r.Weight
		}
		if n == 0 {
			return fmt.Errorf("nhóm \"%s\" đang bật nhưng chưa có phần thưởng", c.Label)
		}
		if math.Abs(rewardSum-100) > 0.5 {
			return fmt.Errorf("tổng %% trong nhóm \"%s\" phải = 100%% (hiện %.2f%%)", c.Label, rewardSum)
		}
	}
	return nil
}

func (s *Service) SaveConfig(packID uuid.UUID, req SaveConfigRequest) (*PackView, error) {
	if _, err := s.repo.FindPack(packID); err != nil {
		return nil, ErrPackNotFound
	}
	if err := validateConfig(req.Categories); err != nil {
		return nil, err
	}
	cats, rewardsByCat := buildConfigModels(req.Categories)
	if err := s.repo.ReplaceConfig(packID, cats, rewardsByCat); err != nil {
		return nil, err
	}
	return s.getPackView(packID)
}

func (s *Service) getPackView(packID uuid.UUID) (*PackView, error) {
	pack, err := s.repo.FindPack(packID)
	if err != nil {
		return nil, ErrPackNotFound
	}
	cats, err := s.repo.CategoriesByPacks([]uuid.UUID{packID})
	if err != nil {
		return nil, err
	}
	catIDs := make([]uuid.UUID, len(cats))
	for i, c := range cats {
		catIDs[i] = c.ID
	}
	rewards, err := s.repo.RewardsByCategories(catIDs)
	if err != nil {
		return nil, err
	}
	views := buildPackViews([]models.EggPack{*pack}, cats, rewards, true)
	return &views[0], nil
}

func (s *Service) OpenPack(userID, packID uuid.UUID, idempotencyKey string) (*OpenResult, error) {
	pack, err := s.repo.FindPack(packID)
	if err != nil || !pack.IsEnabled {
		return nil, ErrPackNotFound
	}

	cats, err := s.repo.CategoriesByPacks([]uuid.UUID{packID})
	if err != nil {
		return nil, err
	}
	catIDs := make([]uuid.UUID, len(cats))
	for i, c := range cats {
		catIDs[i] = c.ID
	}
	rewards, err := s.repo.RewardsByCategories(catIDs)
	if err != nil {
		return nil, err
	}

	outcome, ok := s.draw(cats, rewards)
	if !ok {
		return nil, ErrPackEmpty
	}

	draw, updatedUser, err := s.repo.ApplyDraw(userID, pack, outcome, idempotencyKey)
	if err != nil {
		return nil, err
	}

	s.invalidateUser(userID)
	s.emitKenUpdate(userID, updatedUser.Ken)

	return &OpenResult{
		DrawID:       draw.ID,
		PackID:       pack.ID,
		KenCost:      draw.KenCost,
		KenBalance:   updatedUser.Ken,
		CategoryType: draw.CategoryType,
		IsWin:        draw.RewardType != nil,
		IsSuperLucky: draw.IsSuperLucky,
		RewardType:   draw.RewardType,
		RewardLabel:  draw.RewardLabel,
		VipTypeID:    draw.VipTypeID,
		KenAmount:    draw.KenAmount,
		VipDays:      draw.VipDays,
	}, nil
}

func (s *Service) draw(cats []models.EggCategory, rewards []models.EggReward) (DrawOutcome, bool) {
	activeCats := make([]models.EggCategory, 0, len(cats))
	for _, c := range cats {
		if c.IsActive && c.Weight > 0 {
			activeCats = append(activeCats, c)
		}
	}
	if len(activeCats) == 0 {
		return DrawOutcome{}, false
	}
	catWeights := make([]float64, len(activeCats))
	for i, c := range activeCats {
		catWeights[i] = c.Weight
	}
	ci := weightedPick(catWeights)
	if ci < 0 {
		return DrawOutcome{}, false
	}
	category := activeCats[ci]

	outcome := DrawOutcome{CategoryType: category.Type, CategoryWeight: category.Weight}

	if category.Type == models.EggCategoryNothing {
		return outcome, true
	}

	catRewards := make([]models.EggReward, 0)
	for _, rw := range rewards {
		if rw.CategoryID == category.ID && rw.IsActive && rw.Weight > 0 {
			catRewards = append(catRewards, rw)
		}
	}
	if len(catRewards) == 0 {
		return outcome, true
	}
	rWeights := make([]float64, len(catRewards))
	for i, rw := range catRewards {
		rWeights[i] = rw.Weight
	}
	ri := weightedPick(rWeights)
	if ri < 0 {
		return outcome, true
	}
	reward := catRewards[ri]

	rewardType := string(category.Type)
	outcome.RewardType = &rewardType
	outcome.RewardLabel = reward.Label
	outcome.VipTypeID = reward.VipTypeID
	outcome.KenAmount = reward.KenAmount
	outcome.VipDays = reward.VipDays
	outcome.IsSuperLucky = reward.IsSuperLucky
	outcome.RewardWeight = reward.Weight
	return outcome, true
}

func (s *Service) ListHistory(userID uuid.UUID, outcome string, limit, offset int) (*DrawListResponse, error) {
	draws, total, err := s.repo.ListDraws(userID, outcome, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]DrawView, len(draws))
	for i, d := range draws {
		items[i] = DrawView{
			ID:           d.ID,
			PackID:       d.PackID,
			PackName:     d.PackName,
			KenCost:      d.KenCost,
			CategoryType: d.CategoryType,
			RewardType:   d.RewardType,
			RewardLabel:  d.RewardLabel,
			VipTypeID:    d.VipTypeID,
			KenAmount:    d.KenAmount,
			VipDays:      d.VipDays,
			IsSuperLucky: d.IsSuperLucky,
			CreatedAt:    d.CreatedAt,
		}
	}
	return &DrawListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) ListAllDraws(filter AdminDrawFilter, limit, offset int) (*AdminDrawListResponse, error) {
	rows, total, err := s.repo.ListAllDraws(filter, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]AdminDrawView, len(rows))
	for i, r := range rows {
		items[i] = AdminDrawView{
			DrawView: DrawView{
				ID:           r.ID,
				PackID:       r.PackID,
				PackName:     r.PackName,
				KenCost:      r.KenCost,
				CategoryType: r.CategoryType,
				RewardType:   r.RewardType,
				RewardLabel:  r.RewardLabel,
				VipTypeID:    r.VipTypeID,
				KenAmount:    r.KenAmount,
				VipDays:      r.VipDays,
				IsSuperLucky: r.IsSuperLucky,
				CreatedAt:    r.CreatedAt,
			},
			User: DrawUserView{
				ID:       r.UserID,
				Username: r.Username,
				FullName: r.FullName,
				Avatar:   r.Avatar,
			},
		}
	}
	return &AdminDrawListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) Stats(filter AdminDrawFilter) (*StatsResponse, error) {
	overview, err := s.repo.StatsOverview(filter)
	if err != nil {
		return nil, err
	}
	if overview.TotalDraws > 0 {
		overview.WinRate = float64(overview.WinDraws) / float64(overview.TotalDraws) * 100
	}
	overview.NetKen = overview.KenIn - overview.KenOut

	byCategory, err := s.repo.StatsByCategory(filter)
	if err != nil {
		return nil, err
	}
	for i := range byCategory {
		if overview.TotalDraws > 0 {
			byCategory[i].Percent = float64(byCategory[i].Draws) / float64(overview.TotalDraws) * 100
		}
	}

	topRewards, err := s.repo.StatsTopRewards(filter, 10)
	if err != nil {
		return nil, err
	}

	byPack, err := s.repo.StatsByPack(filter)
	if err != nil {
		return nil, err
	}
	for i := range byPack {
		if byPack[i].KenIn > 0 {
			byPack[i].Rtp = float64(byPack[i].KenOut) / float64(byPack[i].KenIn) * 100
		}
	}

	bucket := "day"
	if filter.From != nil && filter.To != nil && filter.To.Sub(*filter.From) > 90*24*time.Hour {
		bucket = "month"
	}
	timeseries, err := s.repo.StatsTimeseries(filter, bucket)
	if err != nil {
		return nil, err
	}

	playerRows, err := s.repo.StatsTopPlayers(filter, 10)
	if err != nil {
		return nil, err
	}
	players := make([]StatsPlayer, len(playerRows))
	for i, p := range playerRows {
		players[i] = StatsPlayer{
			User:     DrawUserView{ID: p.UserID, Username: p.Username, FullName: p.FullName, Avatar: p.Avatar},
			Draws:    p.Draws,
			KenSpent: p.KenSpent,
		}
	}

	return &StatsResponse{
		Overview:   overview,
		ByCategory: byCategory,
		TopRewards: topRewards,
		ByPack:     byPack,
		Timeseries: timeseries,
		TopPlayers: players,
		Bucket:     bucket,
	}, nil
}

func buildPackViews(packs []models.EggPack, cats []models.EggCategory, rewards []models.EggReward, includeConfig bool) []PackView {
	rewardsByCat := map[uuid.UUID][]RewardView{}
	for _, rw := range rewards {
		rewardsByCat[rw.CategoryID] = append(rewardsByCat[rw.CategoryID], RewardView{
			ID:           rw.ID,
			Label:        rw.Label,
			Weight:       rw.Weight,
			VipTypeID:    rw.VipTypeID,
			KenAmount:    rw.KenAmount,
			VipDays:      rw.VipDays,
			IsSuperLucky: rw.IsSuperLucky,
			IsActive:     rw.IsActive,
			SortOrder:    rw.SortOrder,
		})
	}
	catsByPack := map[uuid.UUID][]CategoryView{}
	for _, c := range cats {
		items := rewardsByCat[c.ID]
		if items == nil {
			items = []RewardView{}
		}
		catsByPack[c.PackID] = append(catsByPack[c.PackID], CategoryView{
			ID:        c.ID,
			Type:      c.Type,
			Label:     c.Label,
			Weight:    c.Weight,
			IsActive:  c.IsActive,
			SortOrder: c.SortOrder,
			Rewards:   items,
		})
	}
	views := make([]PackView, len(packs))
	for i, p := range packs {
		var list []CategoryView
		if includeConfig {
			list = catsByPack[p.ID]
			if list == nil {
				list = []CategoryView{}
			}
		}
		views[i] = PackView{
			ID:         p.ID,
			Name:       p.Name,
			KenCost:    p.KenCost,
			IsEnabled:  p.IsEnabled,
			SortOrder:  p.SortOrder,
			Categories: list,
		}
	}
	return views
}

func weightedPick(weights []float64) int {
	total := 0.0
	for _, w := range weights {
		if w > 0 {
			total += w
		}
	}
	if total <= 0 {
		return -1
	}
	target := utils.CryptoFloat() * total
	acc := 0.0
	last := -1
	for i, w := range weights {
		if w <= 0 {
			continue
		}
		last = i
		acc += w
		if target < acc {
			return i
		}
	}
	return last
}
