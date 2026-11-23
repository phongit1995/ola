package checkin

import (
	"errors"
	"fmt"
	"math"
	"time"

	"ola-chat-server/internal/ledger"
	"ola-chat-server/internal/models"
	avatarframe "ola-chat-server/internal/modules/avatar-frame"
	"ola-chat-server/internal/modules/megaphone"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/modules/vip"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var errKenOverflow = errors.New("checkin ken reward would overflow balance")

type Service struct {
	repo      *Repository
	settings  *setting.Service
	cache     *services.CacheService
	userCache *user.CacheService
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
	now       func() time.Time
	pick      func(weights []float64) int
}

func NewService(repo *Repository, settings *setting.Service, cache *services.CacheService, userCache *user.CacheService, wsServer *websocket.Server, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		settings:  settings,
		cache:     cache,
		userCache: userCache,
		wsServer:  wsServer,
		logger:    logger.Named("[checkin_service]"),
		now:       time.Now,
		pick:      utils.WeightedPick,
	}
}

type calendar struct {
	Found bool
	Month models.CheckinMonth
	Slots []models.CheckinSlot
}

func (c *calendar) slot(n int) models.CheckinSlot {
	for _, s := range c.Slots {
		if int(s.Slot) == n {
			return s
		}
	}
	return models.CheckinSlot{Slot: int16(n), Gifts: models.CheckinGifts{}}
}

func (c *calendar) live(now time.Time) bool {
	return c.Found && IsLive(&c.Month, now)
}

func (s *Service) currentCalendar(now time.Time) (*calendar, error) {
	month := MonthDate(now)
	key := fmt.Sprintf(CacheKeyCheckinMonth, MonthKey(month))
	var cached calendar
	if err := s.cache.Get(key, &cached); err == nil {
		return &cached, nil
	}
	cal := &calendar{}
	row, err := s.repo.FindMonth(month)
	if err != nil {
		return nil, err
	}
	if row != nil {
		slots, err := s.repo.Slots(month)
		if err != nil {
			return nil, err
		}
		cal = &calendar{Found: true, Month: *row, Slots: slots}
	}
	if err := s.cache.Set(key, cal, CacheTTLCheckinMonth); err != nil {
		s.logger.Warnw("Failed to cache checkin month", "month", MonthKey(month), "error", err.Error())
	}
	return cal, nil
}

func (s *Service) InvalidateMonth(month time.Time) {
	if err := s.cache.Delete(fmt.Sprintf(CacheKeyCheckinMonth, MonthKey(month))); err != nil {
		s.logger.Warnw("Failed to invalidate checkin month cache", "month", MonthKey(month), "error", err.Error())
	}
}

func (s *Service) config() setting.CheckinConfig {
	cfg, err := s.settings.GetCheckin()
	if err != nil {
		s.logger.Warnw("Failed to load checkin settings, using default", "error", err.Error())
	}
	return cfg
}

func RandomTasks(cfg setting.CheckinConfig) []string {
	tasks := filterTasks(cfg.RandomTasks, IsTaskCode)
	if len(tasks) == 0 {
		return DefaultRandomTasks()
	}
	return tasks
}

func (s *Service) gateOpen(gate taskGate, client setting.Client) bool {
	var (
		open bool
		err  error
	)
	switch gate {
	case gateStory:
		var cfg setting.StoryConfig
		cfg, err = s.settings.GetStory()
		open = cfg.EnabledFor(client.Platform, client.AppVersion)
	case gateMoment:
		var cfg setting.MomentConfig
		cfg, err = s.settings.GetMoment()
		open = cfg.EnabledFor(client.Platform, client.AppVersion)
	case gateGift:
		var cfg setting.GiftConfig
		cfg, err = s.settings.GetGift()
		open = cfg.EnabledFor(client)
	case gateMegaphone:
		var cfg setting.MegaphoneConfig
		cfg, err = s.settings.GetMegaphone()
		open = cfg.EnabledFor(client)
	default:
		return true
	}
	if err != nil {
		s.logger.Warnw("Failed to load feature settings for checkin task", "gate", gate, "error", err.Error())
		return false
	}
	return open
}

func (s *Service) taskAvailable(client setting.Client) func(string) bool {
	gates := make(map[taskGate]bool)
	return func(code string) bool {
		def, ok := findTask(code)
		if !ok {
			return false
		}
		if def.gate == gateNone {
			return true
		}
		open, seen := gates[def.gate]
		if !seen {
			open = s.gateOpen(def.gate, client)
			gates[def.gate] = open
		}
		return open
	}
}

func (s *Service) resolveTask(slotTask *string, cfg setting.CheckinConfig, available func(string) bool) string {
	if slotTask != nil && *slotTask != models.CheckinTaskRandom && IsTaskCode(*slotTask) && available(*slotTask) {
		return *slotTask
	}
	tasks := PickableTasks(cfg, available)
	weights := make([]float64, len(tasks))
	for i := range weights {
		weights[i] = 1
	}
	idx := s.pick(weights)
	if idx < 0 {
		idx = 0
	}
	return tasks[idx]
}

func (s *Service) disabledStatus(now time.Time) *StatusResponse {
	_, end := DayRange(CalendarDate(now))
	return &StatusResponse{Enabled: false, EndsAt: end, Slots: []SlotState{}}
}

func (s *Service) Status(userID uuid.UUID, client setting.Client) (*StatusResponse, error) {
	now := s.now()
	cfg := s.config()
	cal, err := s.currentCalendar(now)
	if err != nil {
		return nil, err
	}
	if !cfg.EnabledFor(client) || !cal.live(now) {
		return s.disabledStatus(now), nil
	}
	rows, err := s.repo.UserRows(userID, cal.Month.Month)
	if err != nil {
		return nil, err
	}
	today := CalendarDate(now)
	todayRow := findRow(rows, today)
	emailVerified := true
	if cfg.RequireEmailVerified && todayRow == nil && len(rows) < int(cal.Month.SlotCount) {
		if emailVerified, err = s.repo.EmailVerified(userID); err != nil {
			return nil, err
		}
	}
	if todayRow != nil && todayRow.RewardStatus == models.CheckinRewardStatusPending && todayRow.TaskDoneAt == nil && todayRow.Task != nil {
		start, end := DayRange(today)
		doneAt, err := TaskDoneAt(s.repo.DB(), *todayRow.Task, userID, start, end)
		if err != nil {
			s.logger.Warnw("Failed to check checkin task", "user_id", userID, "task", *todayRow.Task, "error", err.Error())
		} else if doneAt != nil {
			if err := s.repo.SetTaskDone(todayRow.ID, *doneAt); err != nil {
				s.logger.Warnw("Failed to save checkin task done", "user_id", userID, "error", err.Error())
			}
			todayRow.TaskDoneAt = doneAt
		}
	}
	return buildStatus(cfg, cal, rows, todayRow, emailVerified, now), nil
}

func findRow(rows []models.UserCheckin, day time.Time) *models.UserCheckin {
	for i := range rows {
		if rows[i].Day.Equal(day) {
			return &rows[i]
		}
	}
	return nil
}

func ResultRewards(row *models.UserCheckin) []models.CheckinReward {
	if row.RewardResult == nil {
		return []models.CheckinReward{}
	}
	items := make([]models.CheckinReward, 0, len(row.RewardResult.Items))
	for _, item := range row.RewardResult.Items {
		items = append(items, item.CheckinReward)
	}
	return items
}

func buildStatus(cfg setting.CheckinConfig, cal *calendar, rows []models.UserCheckin, todayRow *models.UserCheckin, emailVerified bool, now time.Time) *StatusResponse {
	today := CalendarDate(now)
	_, endsAt := DayRange(today)
	count := len(rows)
	slotCount := int(cal.Month.SlotCount)
	checkedToday := todayRow != nil
	reachable := Reachable(count, checkedToday, cal.Month.Month, now)
	slot := 0
	if checkedToday {
		slot = int(todayRow.Slot)
	} else if count < slotCount {
		slot = count + 1
	}
	bySlot := make(map[int]*models.UserCheckin, len(rows))
	for i := range rows {
		bySlot[int(rows[i].Slot)] = &rows[i]
	}
	slots := make([]SlotState, 0, slotCount)
	for n := 1; n <= slotCount; n++ {
		if row := bySlot[n]; row != nil {
			box := SlotBox(row.RewardSnapshot.Gifts, row.RewardSnapshot.Featured)
			state := SlotState{Slot: n, Box: box, RequireVip: box != BoxNone && row.RewardSnapshot.RequireVip, CheckedInOn: DayKey(row.Day)}
			switch row.RewardStatus {
			case models.CheckinRewardStatusClaimed:
				state.Status = SlotStatusClaimed
				state.Items = ResultRewards(row)
			case models.CheckinRewardStatusPending:
				state.Status = SlotStatusMissed
				if row.Day.Equal(today) {
					state.Status = SlotStatusPending
				}
			default:
				state.Status = SlotStatusNone
			}
			slots = append(slots, state)
			continue
		}
		config := cal.slot(n)
		box := SlotBox(config.Gifts, config.Featured)
		status := SlotStatusUpcoming
		if !checkedToday && n == count+1 {
			status = SlotStatusToday
		} else if n > reachable {
			status = SlotStatusOutOfReach
		}
		slots = append(slots, SlotState{Slot: n, Box: box, RequireVip: box != BoxNone && config.RequireVip, Status: status})
	}
	resp := &StatusResponse{
		Enabled:          true,
		Popup:            cfg.Popup,
		NeedsEmailVerify: cfg.RequireEmailVerified && !emailVerified && !checkedToday,
		Month:            MonthKey(cal.Month.Month),
		SlotCount:        slotCount,
		Count:            count,
		Slot:             slot,
		Completed:        count >= slotCount,
		CheckedInToday:   checkedToday,
		Reachable:        reachable,
		EndsAt:           endsAt,
		Slots:            slots,
	}
	if todayRow != nil {
		claimed := todayRow.RewardStatus == models.CheckinRewardStatusClaimed
		if todayRow.Task != nil {
			resp.TodayTask = &TaskState{Code: *todayRow.Task, Done: claimed || todayRow.TaskDoneAt != nil}
		}
		resp.CanOpen = todayRow.RewardStatus == models.CheckinRewardStatusPending && todayRow.TaskDoneAt != nil
		if claimed {
			resp.TodayResult = ResultRewards(todayRow)
		}
	}
	return resp
}

type claimOutcome struct {
	slot       int
	items      []models.CheckinReward
	kenBalance *int
	reason     string
	replayed   bool
}

func replayOutcome(row *models.UserCheckin, hasVip bool) claimOutcome {
	outcome := claimOutcome{slot: int(row.Slot), replayed: true}
	switch {
	case row.RewardStatus == models.CheckinRewardStatusClaimed:
		outcome.items = ResultRewards(row)
	case row.RewardStatus != models.CheckinRewardStatusPending:
	case row.TaskDoneAt == nil:
		outcome.reason = OpenReasonTaskPending
	case row.RewardSnapshot.RequireVip && !hasVip:
		outcome.reason = OpenReasonVipRequired
	}
	return outcome
}

func (s *Service) CheckIn(userID uuid.UUID, client setting.Client, clientRequestID string) (*ActionResponse, error) {
	if clientRequestID == "" {
		return nil, ErrCheckinRequestID
	}
	now := s.now()
	cfg := s.config()
	cal, err := s.currentCalendar(now)
	if err != nil {
		return nil, err
	}
	if !cfg.EnabledFor(client) || !cal.live(now) {
		var replayed *claimOutcome
		err := s.repo.Transaction(func(tx *gorm.DB) error {
			u, err := ledger.LockUser(tx, userID)
			if err != nil {
				return err
			}
			replay, err := findByClientRequestTx(tx, userID, clientRequestID)
			if err != nil || replay == nil {
				return err
			}
			outcome := replayOutcome(replay, u.HasActiveVip(now))
			replayed = &outcome
			return nil
		})
		if err != nil {
			return nil, err
		}
		if replayed == nil {
			return nil, ErrCheckinDisabled
		}
		return s.actionResponse(userID, client, *replayed)
	}
	today := CalendarDate(now)
	var outcome claimOutcome
	err = s.repo.Transaction(func(tx *gorm.DB) error {
		u, err := ledger.LockUser(tx, userID)
		if err != nil {
			return err
		}
		replay, err := findByClientRequestTx(tx, userID, clientRequestID)
		if err != nil {
			return err
		}
		if replay != nil {
			outcome = replayOutcome(replay, u.HasActiveVip(now))
			return nil
		}
		existing, err := findDayRowTx(tx, userID, today)
		if err != nil || existing != nil {
			return err
		}
		if cfg.RequireEmailVerified && !u.EmailVerified {
			return ErrCheckinEmailNotVerified
		}
		maxSlot, err := maxSlotTx(tx, userID, cal.Month.Month)
		if err != nil {
			return err
		}
		next := maxSlot + 1
		if next > int(cal.Month.SlotCount) {
			return ErrCheckinCompleted
		}
		config, err := findSlotTx(tx, cal.Month.Month, next)
		if err != nil {
			return err
		}
		outcome.slot = next
		row := models.UserCheckin{
			ID:           uuid.New(),
			UserID:       userID,
			Day:          today,
			Month:        cal.Month.Month,
			Slot:         int16(next),
			RewardStatus: models.CheckinRewardStatusNone,
			RewardSnapshot: models.CheckinSnapshot{
				Gifts:      models.CheckinGifts{},
				Featured:   false,
				RequireVip: false,
			},
			VipAtCheckin:    u.HasActiveVip(now),
			ClientRequestID: clientRequestID,
			CreatedAt:       now,
		}
		if len(config.Gifts) > 0 {
			task := s.resolveTask(config.Task, cfg, s.taskAvailable(client))
			row.Task = &task
			row.RewardStatus = models.CheckinRewardStatusPending
			row.RewardSnapshot = models.CheckinSnapshot{Gifts: config.Gifts, Featured: config.Featured, RequireVip: config.RequireVip}
			start, end := DayRange(today)
			doneAt, err := TaskDoneAt(tx, task, userID, start, end)
			if err != nil {
				return err
			}
			row.TaskDoneAt = doneAt
			switch {
			case doneAt == nil:
				outcome.reason = OpenReasonTaskPending
			case row.RewardSnapshot.RequireVip && !u.HasActiveVip(now):
				outcome.reason = OpenReasonVipRequired
			default:
				items, kenBalance, err := s.claimTx(tx, &row, now)
				if err != nil {
					return err
				}
				outcome.items, outcome.kenBalance = items, kenBalance
			}
		}
		return tx.Create(&row).Error
	})
	if err != nil {
		return nil, err
	}
	if !outcome.replayed {
		s.afterClaim(userID, outcome)
	}
	return s.actionResponse(userID, client, outcome)
}

func (s *Service) actionResponse(userID uuid.UUID, client setting.Client, outcome claimOutcome) (*ActionResponse, error) {
	status, err := s.Status(userID, client)
	if err != nil {
		return nil, err
	}
	return &ActionResponse{Status: status, Slot: outcome.slot, Items: outcome.items, Reason: outcome.reason}, nil
}

func (s *Service) Open(userID uuid.UUID, client setting.Client) (*ActionResponse, error) {
	now := s.now()
	cfg := s.config()
	cal, err := s.currentCalendar(now)
	if err != nil {
		return nil, err
	}
	if !cfg.EnabledFor(client) || !cal.live(now) {
		return nil, ErrCheckinDisabled
	}
	today := CalendarDate(now)
	var outcome claimOutcome
	var taskSeen *models.UserCheckin
	err = s.repo.Transaction(func(tx *gorm.DB) error {
		u, err := ledger.LockUser(tx, userID)
		if err != nil {
			return err
		}
		row, err := findDayRowTx(tx, userID, today)
		if err != nil {
			return err
		}
		if row == nil || row.RewardStatus == models.CheckinRewardStatusNone {
			return ErrCheckinNothingToOpen
		}
		outcome.slot = int(row.Slot)
		if row.RewardStatus == models.CheckinRewardStatusClaimed {
			outcome.items = ResultRewards(row)
			outcome.replayed = true
			return nil
		}
		if row.TaskDoneAt == nil && row.Task != nil {
			start, end := DayRange(today)
			doneAt, err := TaskDoneAt(tx, *row.Task, userID, start, end)
			if err != nil {
				return err
			}
			row.TaskDoneAt = doneAt
		}
		if row.TaskDoneAt == nil {
			return ErrCheckinTaskNotDone
		}
		if row.RewardSnapshot.RequireVip && !u.HasActiveVip(now) {
			taskSeen = row
			return ErrCheckinVipRequired
		}
		items, kenBalance, err := s.claimTx(tx, row, now)
		if err != nil {
			return err
		}
		outcome.items, outcome.kenBalance = items, kenBalance
		return tx.Model(row).Select("reward_status", "reward_result", "claimed_at", "task_done_at").Updates(row).Error
	})
	if taskSeen != nil && taskSeen.TaskDoneAt != nil {
		if saveErr := s.repo.SetTaskDone(taskSeen.ID, *taskSeen.TaskDoneAt); saveErr != nil {
			s.logger.Warnw("Failed to save checkin task done", "user_id", userID, "error", saveErr.Error())
		}
	}
	if err != nil {
		return nil, err
	}
	if !outcome.replayed {
		s.afterClaim(userID, outcome)
	}
	return s.actionResponse(userID, client, claimOutcome{slot: outcome.slot, items: outcome.items})
}

func (s *Service) afterClaim(userID uuid.UUID, outcome claimOutcome) {
	if len(outcome.items) == 0 {
		return
	}
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after checkin", "user_id", userID, "error", err.Error())
	}
	if outcome.kenBalance != nil {
		s.wsServer.EmitKenUpdate(userID, *outcome.kenBalance)
	}
}

func (s *Service) draw(gifts models.CheckinGifts) []models.CheckinResultItem {
	items := make([]models.CheckinResultItem, 0, len(gifts))
	for gi, gift := range gifts {
		weights := make([]float64, len(gift.Options))
		for oi, option := range gift.Options {
			weights[oi] = float64(option.Weight)
		}
		idx := s.pick(weights)
		if idx < 0 || idx >= len(gift.Options) {
			continue
		}
		reward := gift.Options[idx].CheckinReward
		if reward.IsRandomKen() {
			reward = models.CheckinReward{Type: reward.Type, Amount: s.randomKen(reward.AmountMin, reward.AmountMax)}
		}
		items = append(items, models.CheckinResultItem{Gift: gi + 1, Option: idx + 1, CheckinReward: reward})
	}
	return items
}

func (s *Service) randomKen(min, max int) int {
	steps := (max-min)/KenRandomStep + 1
	if steps <= 1 {
		return min
	}
	weights := make([]float64, steps)
	for i := range weights {
		weights[i] = 1
	}
	idx := s.pick(weights)
	if idx < 0 || idx >= steps {
		idx = 0
	}
	return min + idx*KenRandomStep
}

func (s *Service) claimTx(tx *gorm.DB, row *models.UserCheckin, now time.Time) ([]models.CheckinReward, *int, error) {
	items := s.draw(row.RewardSnapshot.Gifts)
	kenBalance, err := grantTx(tx, row, items, now)
	if err != nil {
		s.logger.Errorw("Failed to grant checkin reward", "user_id", row.UserID, "month", MonthKey(row.Month), "slot", row.Slot, "items", items, "error", err.Error())
		return nil, nil, err
	}
	row.RewardResult = &models.CheckinResult{Items: items}
	row.RewardStatus = models.CheckinRewardStatusClaimed
	row.ClaimedAt = &now
	return ResultRewards(row), kenBalance, nil
}

func grantTx(tx *gorm.DB, row *models.UserCheckin, items []models.CheckinResultItem, now time.Time) (*int, error) {
	label := fmt.Sprintf("Điểm danh %s ô %d", MonthName(row.Month), row.Slot)
	var kenBalance *int
	for _, item := range items {
		switch item.Type {
		case models.CheckinRewardVipDays:
			if _, err := vip.GrantDaysTx(tx, row.UserID, item.Days, vip.PurchaseSourceCheckin, label); err != nil {
				return nil, err
			}
		case models.CheckinRewardVipIcon:
			if _, err := vip.GrantIconTx(tx, row.UserID, item.VipIconID, vip.IconSourceCheckin, vip.PurchaseSourceCheckin, models.LockedGrantForDays(item.ExpiresInDays)); err != nil {
				return nil, err
			}
		case models.CheckinRewardAvatarFrame:
			if _, err := avatarframe.GrantFrameTx(tx, row.UserID, item.FrameID, models.AvatarFrameSourceCheckin, now, models.LockedGrantForDays(item.ExpiresInDays)); err != nil {
				return nil, err
			}
		case models.CheckinRewardMegaphoneTicket:
			if _, err := megaphone.GrantTicketsTx(tx, row.UserID, item.Count, models.MegaphoneTicketSourceCheckin, &row.ID, item.ExpiresInDays, now); err != nil {
				return nil, err
			}
		case models.CheckinRewardKen:
			u, err := ledger.LockUser(tx, row.UserID)
			if err != nil {
				return nil, err
			}
			if item.Amount <= 0 || u.Ken > math.MaxInt32-item.Amount {
				return nil, errKenOverflow
			}
			if _, err := ledger.Credit(tx, u, item.Amount, ledger.Entry{
				Type:        models.KenTxTypeCheckin,
				Description: label,
				RefType:     KenRefTypeUserCheckin,
				RefID:       &row.ID,
				ActorType:   models.KenActorSystem,
			}); err != nil {
				return nil, err
			}
			balance := u.Ken
			kenBalance = &balance
		default:
			return nil, fmt.Errorf("unknown checkin reward type %q", item.Type)
		}
	}
	return kenBalance, nil
}
