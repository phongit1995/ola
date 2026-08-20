package wheel

import (
	"errors"
	"fmt"
	"math"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var (
	ErrWheelNotFound   = errors.New("wheel not found")
	ErrInsufficientKen = errors.New("insufficient ken balance")
	ErrWheelEmpty      = errors.New("wheel has no active segments")
)

type SpinOutcome struct {
	SegmentID     uuid.UUID
	Kind          models.WheelSegmentKind
	RewardLabel   string
	KenAmount     *int
	VipDays       *int
	VipTypeID     *int16
	IsSuperLucky  bool
	SegmentWeight float64
	OptionWeight  float64
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
		logger:    logger.Named("[wheel_service]"),
	}
}

func (s *Service) invalidateUser(userID uuid.UUID) {
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after wheel spin", "user_id", userID, "error", err.Error())
	}
}

func (s *Service) loadWheelTree(wheelID uuid.UUID) ([]models.WheelSegment, []models.WheelSegmentOption, error) {
	segs, err := s.repo.SegmentsByWheels([]uuid.UUID{wheelID})
	if err != nil {
		return nil, nil, err
	}
	segIDs := make([]uuid.UUID, len(segs))
	for i, seg := range segs {
		segIDs[i] = seg.ID
	}
	options, err := s.repo.OptionsBySegments(segIDs)
	if err != nil {
		return nil, nil, err
	}
	return segs, options, nil
}

func (s *Service) listWheels(enabledOnly bool) ([]WheelView, error) {
	wheels, err := s.repo.ListWheels(enabledOnly)
	if err != nil {
		return nil, err
	}
	if len(wheels) == 0 {
		return []WheelView{}, nil
	}
	wheelIDs := make([]uuid.UUID, len(wheels))
	for i, w := range wheels {
		wheelIDs[i] = w.ID
	}
	segs, err := s.repo.SegmentsByWheels(wheelIDs)
	if err != nil {
		return nil, err
	}
	segIDs := make([]uuid.UUID, len(segs))
	for i, seg := range segs {
		segIDs[i] = seg.ID
	}
	options, err := s.repo.OptionsBySegments(segIDs)
	if err != nil {
		return nil, err
	}
	return buildWheelViews(wheels, segs, options), nil
}

func (s *Service) ListAllWheels() (*WheelListResponse, error) {
	views, err := s.listWheels(false)
	if err != nil {
		return nil, err
	}
	return &WheelListResponse{Items: views}, nil
}

func (s *Service) PlayerConfig(userID uuid.UUID) (*PlayerConfigResponse, error) {
	wheel, err := s.repo.FirstEnabledWheel()
	if err != nil {
		return nil, ErrWheelNotFound
	}
	segs, options, err := s.loadWheelTree(wheel.ID)
	if err != nil {
		return nil, err
	}
	active := activeSortedSegments(segs)
	totalSegWeight := 0.0
	for _, seg := range active {
		if seg.Weight > 0 {
			totalSegWeight += seg.Weight
		}
	}
	segPercents := map[uuid.UUID]float64{}
	for _, seg := range active {
		if totalSegWeight > 0 && seg.Weight > 0 {
			segPercents[seg.ID] = seg.Weight / totalSegWeight * 100
		}
	}
	playableOptions := playableOptionsBySegment(options, segPercents)
	views := make([]PlayerSegmentView, len(active))
	for i, seg := range active {
		views[i] = PlayerSegmentView{
			ID:        seg.ID,
			Kind:      seg.Kind,
			Label:     seg.Label,
			KenAmount: seg.KenAmount,
			KenMin:    seg.KenMin,
			KenMax:    seg.KenMax,
			VipDays:   seg.VipDays,
			VipTypeID: seg.VipTypeID,
			SortOrder: seg.SortOrder,
			Percent:   segPercents[seg.ID],
			Options:   playableOptions[seg.ID],
		}
	}
	freeAvailable := false
	if wheel.FreeDailyEnabled {
		claimed, err := s.repo.HasFreeClaimToday(userID, wheel.ID)
		if err != nil {
			return nil, err
		}
		freeAvailable = !claimed
	}
	return &PlayerConfigResponse{
		ID:               wheel.ID,
		Name:             wheel.Name,
		KenCost:          wheel.KenCost,
		FreeDailyEnabled: wheel.FreeDailyEnabled,
		FreeAvailable:    freeAvailable,
		Segments:         views,
	}, nil
}

func buildConfigModels(input []SegmentInput) ([]models.WheelSegment, map[int][]models.WheelSegmentOption) {
	segs := make([]models.WheelSegment, len(input))
	optionsBySeg := map[int][]models.WheelSegmentOption{}
	for i, seg := range input {
		segs[i] = models.WheelSegment{
			Kind:         seg.Kind,
			Label:        seg.Label,
			Weight:       seg.Weight,
			KenAmount:    seg.KenAmount,
			KenMin:       seg.KenMin,
			KenMax:       seg.KenMax,
			VipDays:      seg.VipDays,
			VipTypeID:    seg.VipTypeID,
			IsSuperLucky: seg.IsSuperLucky,
			IsActive:     seg.IsActive,
			SortOrder:    seg.SortOrder,
		}
		options := make([]models.WheelSegmentOption, len(seg.Options))
		for j, opt := range seg.Options {
			options[j] = models.WheelSegmentOption{
				Label:     opt.Label,
				Weight:    opt.Weight,
				VipTypeID: opt.VipTypeID,
				VipDays:   opt.VipDays,
				KenAmount: opt.KenAmount,
				IsActive:  opt.IsActive,
				SortOrder: opt.SortOrder,
			}
		}
		optionsBySeg[i] = options
	}
	return segs, optionsBySeg
}

func validateConfig(segs []SegmentInput) error {
	active := 0
	var segSum float64
	for _, seg := range segs {
		if !seg.IsActive {
			continue
		}
		active++
		segSum += seg.Weight
	}
	if active == 0 {
		return errors.New("vòng quay phải có ít nhất 1 ô đang bật")
	}
	if math.Abs(segSum-100) > 0.5 {
		return fmt.Errorf("tổng %% các ô phải = 100%% (hiện %.2f%%)", segSum)
	}
	for _, seg := range segs {
		if !seg.IsActive {
			continue
		}
		switch seg.Kind {
		case models.WheelSegmentKenFixed:
			if seg.KenAmount == nil || *seg.KenAmount < 1 {
				return fmt.Errorf("ô \"%s\" cần số KEN >= 1", seg.Label)
			}
		case models.WheelSegmentKenRandom:
			if seg.KenMin == nil || seg.KenMax == nil || *seg.KenMin < 0 || *seg.KenMax < *seg.KenMin {
				return fmt.Errorf("ô \"%s\" cần KEN min/max hợp lệ", seg.Label)
			}
		case models.WheelSegmentVipDays:
			if seg.VipDays == nil || *seg.VipDays < 1 {
				return fmt.Errorf("ô \"%s\" cần số ngày VIP >= 1", seg.Label)
			}
		case models.WheelSegmentVipItem:
			if seg.VipTypeID == nil {
				return fmt.Errorf("ô \"%s\" cần chọn VIP", seg.Label)
			}
		case models.WheelSegmentVipRandom:
			n := 0
			var optSum float64
			for _, opt := range seg.Options {
				if !opt.IsActive {
					continue
				}
				n++
				optSum += opt.Weight
				if opt.VipTypeID == nil && opt.VipDays == nil && (opt.KenAmount == nil || *opt.KenAmount < 1) {
					return fmt.Errorf("ô \"%s\" có lựa chọn chưa cấu hình phần thưởng", seg.Label)
				}
			}
			if n == 0 {
				return fmt.Errorf("ô \"%s\" đang bật nhưng chưa có lựa chọn", seg.Label)
			}
			if math.Abs(optSum-100) > 0.5 {
				return fmt.Errorf("tổng %% lựa chọn trong ô \"%s\" phải = 100%% (hiện %.2f%%)", seg.Label, optSum)
			}
		}
	}
	return nil
}

func (s *Service) CreateWheel(req CreateWheelRequest) (*WheelView, error) {
	if err := validateConfig(req.Segments); err != nil {
		return nil, err
	}
	wheel := models.Wheel{
		Name:             req.Name,
		KenCost:          req.KenCost,
		FreeDailyEnabled: req.FreeDailyEnabled,
		IsEnabled:        req.IsEnabled,
		SortOrder:        req.SortOrder,
	}
	segs, optionsBySeg := buildConfigModels(req.Segments)
	if err := s.repo.CreateWheelWithConfig(&wheel, segs, optionsBySeg); err != nil {
		return nil, err
	}
	return s.getWheelView(wheel.ID)
}

func (s *Service) UpdateWheel(id uuid.UUID, req UpdateWheelRequest) (*WheelView, error) {
	if _, err := s.repo.FindWheel(id); err != nil {
		return nil, ErrWheelNotFound
	}
	fields := map[string]interface{}{}
	if req.Name != nil {
		fields["name"] = *req.Name
	}
	if req.KenCost != nil {
		fields["ken_cost"] = *req.KenCost
	}
	if req.FreeDailyEnabled != nil {
		fields["free_daily_enabled"] = *req.FreeDailyEnabled
	}
	if req.IsEnabled != nil {
		fields["is_enabled"] = *req.IsEnabled
	}
	if req.SortOrder != nil {
		fields["sort_order"] = *req.SortOrder
	}
	if len(fields) > 0 {
		if err := s.repo.UpdateWheel(id, fields); err != nil {
			return nil, err
		}
	}
	return s.getWheelView(id)
}

func (s *Service) DeleteWheel(id uuid.UUID) error {
	if _, err := s.repo.FindWheel(id); err != nil {
		return ErrWheelNotFound
	}
	return s.repo.SoftDeleteWheel(id)
}

func (s *Service) SaveConfig(wheelID uuid.UUID, req SaveConfigRequest) (*WheelView, error) {
	if _, err := s.repo.FindWheel(wheelID); err != nil {
		return nil, ErrWheelNotFound
	}
	if err := validateConfig(req.Segments); err != nil {
		return nil, err
	}
	segs, optionsBySeg := buildConfigModels(req.Segments)
	if err := s.repo.ReplaceConfig(wheelID, segs, optionsBySeg); err != nil {
		return nil, err
	}
	return s.getWheelView(wheelID)
}

func (s *Service) getWheelView(wheelID uuid.UUID) (*WheelView, error) {
	wheel, err := s.repo.FindWheel(wheelID)
	if err != nil {
		return nil, ErrWheelNotFound
	}
	segs, options, err := s.loadWheelTree(wheelID)
	if err != nil {
		return nil, err
	}
	views := buildWheelViews([]models.Wheel{*wheel}, segs, options)
	return &views[0], nil
}

func (s *Service) SpinFirstEnabled(userID uuid.UUID, idempotencyKey string) (*SpinResult, error) {
	wheel, err := s.repo.FirstEnabledWheel()
	if err != nil {
		return nil, ErrWheelNotFound
	}
	return s.Spin(userID, wheel.ID, idempotencyKey)
}

func (s *Service) Spin(userID, wheelID uuid.UUID, idempotencyKey string) (*SpinResult, error) {
	wheel, err := s.repo.FindWheel(wheelID)
	if err != nil || !wheel.IsEnabled {
		return nil, ErrWheelNotFound
	}

	segs, options, err := s.loadWheelTree(wheelID)
	if err != nil {
		return nil, err
	}

	active := activeSortedSegments(segs)
	outcome, _, ok := s.draw(active, options)
	if !ok {
		return nil, ErrWheelEmpty
	}

	spin, updatedUser, err := s.repo.ApplySpin(userID, wheel, outcome, idempotencyKey)
	if err != nil {
		return nil, err
	}

	s.invalidateUser(userID)

	freeAvailable := false
	if wheel.FreeDailyEnabled {
		claimed, err := s.repo.HasFreeClaimToday(userID, wheelID)
		if err == nil {
			freeAvailable = !claimed
		}
	}

	segmentID := uuid.Nil
	index := 0
	if spin.SegmentID != nil {
		segmentID = *spin.SegmentID
		for i, seg := range active {
			if seg.ID == segmentID {
				index = i
				break
			}
		}
	}

	kenReward := 0
	if spin.KenAmount != nil && *spin.KenAmount > 0 {
		kenReward = *spin.KenAmount
	}

	return &SpinResult{
		SpinID:              spin.ID,
		WheelID:             wheel.ID,
		SegmentIndex:        index,
		SegmentID:           segmentID,
		SegmentKind:         spin.SegmentKind,
		IsWin:               spin.SegmentKind != models.WheelSegmentMiss,
		IsSuperLucky:        spin.IsSuperLucky,
		KenCost:             spin.KenCost,
		IsFree:              spin.IsFree,
		KenBalance:          updatedUser.Ken,
		KenBalanceAfterCost: updatedUser.Ken - kenReward,
		FreeAvailable:       freeAvailable,
		RewardLabel:         spin.RewardLabel,
		KenAmount:           spin.KenAmount,
		VipDays:             spin.VipDays,
		VipTypeID:           spin.VipTypeID,
	}, nil
}

func (s *Service) draw(active []models.WheelSegment, options []models.WheelSegmentOption) (SpinOutcome, int, bool) {
	if len(active) == 0 {
		return SpinOutcome{}, 0, false
	}
	weights := make([]float64, len(active))
	for i, seg := range active {
		weights[i] = seg.Weight
	}
	idx := weightedPick(weights)
	if idx < 0 {
		return SpinOutcome{}, 0, false
	}
	seg := active[idx]

	outcome := SpinOutcome{
		SegmentID:     seg.ID,
		Kind:          seg.Kind,
		IsSuperLucky:  seg.IsSuperLucky,
		SegmentWeight: seg.Weight,
	}
	if seg.Kind != models.WheelSegmentMiss {
		outcome.RewardLabel = seg.Label
	}

	switch seg.Kind {
	case models.WheelSegmentMiss:
	case models.WheelSegmentKenFixed:
		outcome.KenAmount = seg.KenAmount
	case models.WheelSegmentKenRandom:
		amount := randomKenRounded(seg.KenMin, seg.KenMax)
		outcome.KenAmount = &amount
	case models.WheelSegmentVipDays:
		outcome.VipDays = seg.VipDays
	case models.WheelSegmentVipItem:
		outcome.VipTypeID = seg.VipTypeID
	case models.WheelSegmentVipRandom:
		segOptions := make([]models.WheelSegmentOption, 0)
		for _, opt := range options {
			if opt.SegmentID == seg.ID && opt.IsActive && opt.Weight > 0 {
				segOptions = append(segOptions, opt)
			}
		}
		if len(segOptions) > 0 {
			oWeights := make([]float64, len(segOptions))
			for i, opt := range segOptions {
				oWeights[i] = opt.Weight
			}
			oi := weightedPick(oWeights)
			if oi >= 0 {
				opt := segOptions[oi]
				outcome.RewardLabel = opt.Label
				outcome.VipTypeID = opt.VipTypeID
				outcome.VipDays = opt.VipDays
				outcome.KenAmount = opt.KenAmount
				outcome.OptionWeight = opt.Weight
			}
		}
	}

	return outcome, idx, true
}

func (s *Service) ListHistory(userID uuid.UUID, outcome string, limit, offset int) (*SpinListResponse, error) {
	spins, total, err := s.repo.ListSpins(userID, outcome, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]SpinView, len(spins))
	for i, sp := range spins {
		items[i] = toSpinView(sp)
	}
	return &SpinListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) ListAllSpins(filter AdminSpinFilter, limit, offset int) (*AdminSpinListResponse, error) {
	rows, total, err := s.repo.ListAllSpins(filter, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]AdminSpinView, len(rows))
	for i, r := range rows {
		items[i] = AdminSpinView{
			SpinView: toSpinView(r.WheelSpin),
			User: SpinUserView{
				ID:       r.UserID,
				Username: r.Username,
				FullName: r.FullName,
				Avatar:   r.Avatar,
			},
		}
	}
	return &AdminSpinListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) Stats(filter AdminSpinFilter) (*StatsResponse, error) {
	overview, err := s.repo.StatsOverview(filter)
	if err != nil {
		return nil, err
	}
	if overview.TotalSpins > 0 {
		overview.WinRate = float64(overview.WinSpins) / float64(overview.TotalSpins) * 100
	}
	overview.NetKen = overview.KenIn - overview.KenOut

	byKind, err := s.repo.StatsByKind(filter)
	if err != nil {
		return nil, err
	}
	for i := range byKind {
		if overview.TotalSpins > 0 {
			byKind[i].Percent = float64(byKind[i].Spins) / float64(overview.TotalSpins) * 100
		}
	}

	topRewards, err := s.repo.StatsTopRewards(filter, 10)
	if err != nil {
		return nil, err
	}

	byWheel, err := s.repo.StatsByWheel(filter)
	if err != nil {
		return nil, err
	}
	for i := range byWheel {
		if byWheel[i].KenIn > 0 {
			byWheel[i].Rtp = float64(byWheel[i].KenOut) / float64(byWheel[i].KenIn) * 100
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
			User:     SpinUserView{ID: p.UserID, Username: p.Username, FullName: p.FullName, Avatar: p.Avatar},
			Spins:    p.Spins,
			KenSpent: p.KenSpent,
		}
	}

	return &StatsResponse{
		Overview:   overview,
		ByKind:     byKind,
		TopRewards: topRewards,
		ByWheel:    byWheel,
		Timeseries: timeseries,
		TopPlayers: players,
		Bucket:     bucket,
	}, nil
}

func toSpinView(sp models.WheelSpin) SpinView {
	return SpinView{
		ID:           sp.ID,
		WheelID:      sp.WheelID,
		WheelName:    sp.WheelName,
		KenCost:      sp.KenCost,
		IsFree:       sp.IsFree,
		SegmentKind:  sp.SegmentKind,
		RewardLabel:  sp.RewardLabel,
		KenAmount:    sp.KenAmount,
		VipDays:      sp.VipDays,
		VipTypeID:    sp.VipTypeID,
		IsSuperLucky: sp.IsSuperLucky,
		CreatedAt:    sp.CreatedAt,
	}
}

func playableOptionsBySegment(options []models.WheelSegmentOption, segPercents map[uuid.UUID]float64) map[uuid.UUID][]PlayerOptionView {
	grouped := map[uuid.UUID][]models.WheelSegmentOption{}
	for _, opt := range options {
		if !opt.IsActive || opt.Weight <= 0 {
			continue
		}
		grouped[opt.SegmentID] = append(grouped[opt.SegmentID], opt)
	}
	views := map[uuid.UUID][]PlayerOptionView{}
	for segID, segOptions := range grouped {
		optWeightTotal := 0.0
		for _, opt := range segOptions {
			optWeightTotal += opt.Weight
		}
		for _, opt := range segOptions {
			percent := 0.0
			if optWeightTotal > 0 {
				percent = segPercents[segID] * opt.Weight / optWeightTotal
			}
			views[segID] = append(views[segID], PlayerOptionView{
				Label:     opt.Label,
				VipTypeID: opt.VipTypeID,
				VipDays:   opt.VipDays,
				KenAmount: opt.KenAmount,
				Percent:   percent,
			})
		}
	}
	return views
}

func activeSortedSegments(segs []models.WheelSegment) []models.WheelSegment {
	active := make([]models.WheelSegment, 0, len(segs))
	for _, seg := range segs {
		if seg.IsActive {
			active = append(active, seg)
		}
	}
	return active
}

func buildWheelViews(wheels []models.Wheel, segs []models.WheelSegment, options []models.WheelSegmentOption) []WheelView {
	optionsBySeg := map[uuid.UUID][]OptionView{}
	for _, opt := range options {
		optionsBySeg[opt.SegmentID] = append(optionsBySeg[opt.SegmentID], OptionView{
			ID:        opt.ID,
			Label:     opt.Label,
			Weight:    opt.Weight,
			VipTypeID: opt.VipTypeID,
			VipDays:   opt.VipDays,
			KenAmount: opt.KenAmount,
			IsActive:  opt.IsActive,
			SortOrder: opt.SortOrder,
		})
	}
	segsByWheel := map[uuid.UUID][]SegmentView{}
	for _, seg := range segs {
		items := optionsBySeg[seg.ID]
		if items == nil {
			items = []OptionView{}
		}
		segsByWheel[seg.WheelID] = append(segsByWheel[seg.WheelID], SegmentView{
			ID:           seg.ID,
			Kind:         seg.Kind,
			Label:        seg.Label,
			Weight:       seg.Weight,
			KenAmount:    seg.KenAmount,
			KenMin:       seg.KenMin,
			KenMax:       seg.KenMax,
			VipDays:      seg.VipDays,
			VipTypeID:    seg.VipTypeID,
			IsSuperLucky: seg.IsSuperLucky,
			IsActive:     seg.IsActive,
			SortOrder:    seg.SortOrder,
			Options:      items,
		})
	}
	views := make([]WheelView, len(wheels))
	for i, w := range wheels {
		list := segsByWheel[w.ID]
		if list == nil {
			list = []SegmentView{}
		}
		views[i] = WheelView{
			ID:               w.ID,
			Name:             w.Name,
			KenCost:          w.KenCost,
			FreeDailyEnabled: w.FreeDailyEnabled,
			IsEnabled:        w.IsEnabled,
			SortOrder:        w.SortOrder,
			Segments:         list,
		}
	}
	return views
}

func randomKenRounded(min, max *int) int {
	lo, hi := 0, 0
	if min != nil {
		lo = *min
	}
	if max != nil {
		hi = *max
	}
	if hi < lo {
		hi = lo
	}
	loK := (lo + 999) / 1000
	hiK := hi / 1000
	if hiK < loK {
		return randomIntInRange(lo, hi)
	}
	span := hiK - loK + 1
	k := loK + int(utils.CryptoFloat()*float64(span))
	if k > hiK {
		k = hiK
	}
	return k * 1000
}

func randomIntInRange(lo, hi int) int {
	if lo < 0 {
		lo = 0
	}
	if hi <= lo {
		return lo
	}
	v := lo + int(utils.CryptoFloat()*float64(hi-lo+1))
	if v > hi {
		v = hi
	}
	return v
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
