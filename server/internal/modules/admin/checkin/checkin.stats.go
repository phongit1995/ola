package admincheckin

import (
	"fmt"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/checkin"
	"ola-chat-server/internal/modules/vip"
	"ola-chat-server/internal/utils"
)

var statsRewardTypes = []string{
	models.CheckinRewardVipDays,
	models.CheckinRewardVipIcon,
	models.CheckinRewardAvatarFrame,
	models.CheckinRewardMegaphoneTicket,
	models.CheckinRewardKen,
}

func (s *Service) Stats(value string) (*StatsResponse, error) {
	row, err := s.loadMonth(s.db(), value)
	if err != nil {
		return nil, err
	}
	now := s.now()
	today := checkin.CalendarDate(now)
	month := row.Month
	slotCount := int(row.SlotCount)
	resp := &StatsResponse{Month: checkin.MonthKey(month), OpenedByType: make(map[string]int64, len(statsRewardTypes))}
	for _, t := range statsRewardTypes {
		resp.OpenedByType[t] = 0
	}
	db := s.db()

	var daily []struct {
		Day   time.Time
		Users int64
	}
	if err := db.Model(&models.UserCheckin{}).Select("day, COUNT(*) AS users").Where("month = ?", month).Group("day").Order("day").Scan(&daily).Error; err != nil {
		return nil, err
	}
	perDay := make(map[string]int64, len(daily))
	for _, d := range daily {
		perDay[checkin.DayKey(d.Day)] = d.Users
	}
	lastDay := checkin.DaysInMonth(month)
	if month.Equal(checkin.MonthDate(now)) {
		lastDay = now.In(utils.VietnamTime).Day()
	} else if month.After(checkin.MonthDate(now)) {
		lastDay = 0
	}
	resp.Daily = make([]StatsDay, 0, lastDay)
	for d := 1; d <= lastDay; d++ {
		key := checkin.DayKey(time.Date(month.Year(), month.Month(), d, 0, 0, 0, 0, time.UTC))
		resp.Daily = append(resp.Daily, StatsDay{Day: key, Users: perDay[key]})
	}
	resp.CheckedInToday = perDay[checkin.DayKey(today)]

	if err := db.Model(&models.UserCheckin{}).Where("month = ?", month).Distinct("user_id").Count(&resp.CheckedInUsers).Error; err != nil {
		return nil, err
	}
	if err := db.Model(&models.UserCheckin{}).Where("month = ? AND slot = ?", month, slotCount).Count(&resp.CompletedUsers).Error; err != nil {
		return nil, err
	}

	slots, err := checkin.SlotsTx(db, month)
	if err != nil {
		return nil, err
	}
	config := make(map[int]models.CheckinSlot, len(slots))
	for _, slot := range slots {
		config[int(slot.Slot)] = slot
	}

	var perSlot []struct {
		Slot      int
		CheckedIn int64
		Opened    int64
		Lost      int64
	}
	if err := db.Model(&models.UserCheckin{}).
		Select("slot, COUNT(*) AS checked_in, COUNT(*) FILTER (WHERE reward_status = ?) AS opened, COUNT(*) FILTER (WHERE reward_status = ? AND day < ?) AS lost",
			models.CheckinRewardStatusClaimed, models.CheckinRewardStatusPending, today).
		Where("month = ?", month).Group("slot").Scan(&perSlot).Error; err != nil {
		return nil, err
	}
	slotStats := make(map[int]*StatsSlot, slotCount)
	resp.Slots = make([]StatsSlot, slotCount)
	for n := 1; n <= slotCount; n++ {
		cfg := config[n]
		gifts := make([]StatsGift, len(cfg.Gifts))
		for gi, gift := range cfg.Gifts {
			gifts[gi] = StatsGift{Counts: make([]int64, len(gift.Options))}
		}
		resp.Slots[n-1] = StatsSlot{Slot: n, Box: checkin.SlotBox(cfg.Gifts, cfg.Featured), Gifts: gifts}
		slotStats[n] = &resp.Slots[n-1]
	}
	for _, ps := range perSlot {
		if st := slotStats[ps.Slot]; st != nil {
			st.CheckedIn, st.Opened, st.Lost = ps.CheckedIn, ps.Opened, ps.Lost
			resp.BoxesOpened += ps.Opened
		}
	}

	var picks []struct {
		Slot   int
		Gift   int
		Option int
		Type   string
		Total  int64
	}
	if err := db.Raw(`SELECT uc.slot, (item->>'gift')::int AS gift, (item->>'option')::int AS option, item->>'type' AS type, COUNT(*) AS total
		FROM user_checkins uc, jsonb_array_elements(uc.reward_result->'items') AS item
		WHERE uc.month = ? AND uc.reward_status = ?
		GROUP BY 1, 2, 3, 4`, month, models.CheckinRewardStatusClaimed).Scan(&picks).Error; err != nil {
		return nil, err
	}
	for _, p := range picks {
		resp.OpenedByType[p.Type] += p.Total
		st := slotStats[p.Slot]
		if st == nil || p.Gift < 1 || p.Option < 1 {
			continue
		}
		for len(st.Gifts) < p.Gift {
			st.Gifts = append(st.Gifts, StatsGift{Counts: []int64{}})
		}
		gift := &st.Gifts[p.Gift-1]
		for len(gift.Counts) < p.Option {
			gift.Counts = append(gift.Counts, 0)
		}
		gift.Counts[p.Option-1] += p.Total
	}

	if err := s.fillTaskStats(resp, month, today); err != nil {
		return nil, err
	}
	if err := s.fillVipPurchases(resp, month); err != nil {
		return nil, err
	}

	var tickets struct {
		Granted int64
		Used    int64
		Expired int64
	}
	if err := db.Raw(`SELECT COUNT(*) AS granted,
			COUNT(*) FILTER (WHERE t.used_at IS NOT NULL) AS used,
			COUNT(*) FILTER (WHERE t.used_at IS NULL AND t.revoked_at IS NULL AND t.expires_at IS NOT NULL AND t.expires_at <= ?) AS expired
		FROM user_megaphone_tickets t JOIN user_checkins uc ON uc.id = t.source_ref
		WHERE t.source = ? AND uc.month = ?`, now, models.MegaphoneTicketSourceCheckin, month).Scan(&tickets).Error; err != nil {
		return nil, err
	}
	resp.TicketsGranted, resp.TicketsUsed, resp.TicketsExpired = tickets.Granted, tickets.Used, tickets.Expired
	return resp, nil
}

func vipLostSQL() string {
	return "(uc.reward_snapshot->>'requireVip')::boolean AND NOT uc.vip_at_checkin AND NOT EXISTS (SELECT 1 FROM vip_purchases vp WHERE vp.user_id = uc.user_id AND vp.days > 0 AND vp.source <> @transferOut AND vp.deleted_at IS NULL AND vp.created_at >= " +
		checkin.NaiveFromZonedSQL("uc.created_at") + " AND vp.created_at < " + checkin.NaiveDayStartSQL("uc.day") + " + interval '1 day')"
}

func (s *Service) backfillMonth(month, today time.Time) error {
	key := fmt.Sprintf(CacheKeyCheckinBackfilledDay, checkin.MonthKey(month))
	var from time.Time
	var doneDay string
	if err := s.cache.Get(key, &doneDay); err == nil {
		if day, err := time.Parse(checkin.DayLayout, doneDay); err == nil {
			from = day
		}
	}
	if !from.Before(today) {
		return nil
	}
	if err := checkin.BackfillMissedTaskDone(s.db(), month, from, today); err != nil {
		return err
	}
	if err := s.cache.Set(key, checkin.DayKey(today), CacheTTLCheckinBackfilledDay); err != nil {
		s.logger.Warnw("Failed to cache checkin backfill day", "month", checkin.MonthKey(month), "error", err.Error())
	}
	return nil
}

func (s *Service) fillTaskStats(resp *StatsResponse, month, today time.Time) error {
	if err := s.backfillMonth(month, today); err != nil {
		return err
	}
	var rows []struct {
		Task        string
		Assigned    int64
		Done        int64
		NotDone     int64
		NotOpened   int64
		LostNoVip   int64
		FirstSeenAt time.Time
	}
	missed := "uc.reward_status = @pending AND uc.day < @today"
	vipLost := vipLostSQL()
	if err := s.db().Raw(`SELECT uc.task,
			COUNT(*) AS assigned,
			COUNT(*) FILTER (WHERE uc.reward_status = @claimed OR uc.task_done_at IS NOT NULL) AS done,
			COUNT(*) FILTER (WHERE `+missed+` AND uc.task_done_at IS NULL) AS not_done,
			COUNT(*) FILTER (WHERE `+missed+` AND uc.task_done_at IS NOT NULL AND NOT (`+vipLost+`)) AS not_opened,
			COUNT(*) FILTER (WHERE `+missed+` AND uc.task_done_at IS NOT NULL AND `+vipLost+`) AS lost_no_vip,
			MIN(uc.created_at) AS first_seen_at
		FROM user_checkins uc
		WHERE uc.month = @month AND uc.task IS NOT NULL
		GROUP BY uc.task
		ORDER BY first_seen_at`,
		map[string]interface{}{
			"month":       month,
			"today":       today,
			"pending":     models.CheckinRewardStatusPending,
			"claimed":     models.CheckinRewardStatusClaimed,
			"transferOut": vip.PurchaseSourceDayTransferOut,
		},
	).Scan(&rows).Error; err != nil {
		return err
	}
	resp.Tasks = make([]StatsTask, 0, len(rows))
	for _, row := range rows {
		resp.Tasks = append(resp.Tasks, StatsTask{Task: row.Task, Assigned: row.Assigned, Done: row.Done, NotDone: row.NotDone, DoneNotOpened: row.NotOpened})
		resp.LostNoVip += row.LostNoVip
	}
	return nil
}

func (s *Service) fillVipPurchases(resp *StatsResponse, month time.Time) error {
	return s.db().Raw(`SELECT COUNT(DISTINCT uc.user_id) FROM user_checkins uc
		WHERE uc.month = ? AND uc.reward_status = ? AND NOT uc.vip_at_checkin AND (uc.reward_snapshot->>'requireVip')::boolean AND uc.claimed_at IS NOT NULL
		AND EXISTS (SELECT 1 FROM vip_purchases vp WHERE vp.user_id = uc.user_id AND vp.source = ? AND vp.deleted_at IS NULL
			AND vp.created_at >= `+checkin.NaiveFromZonedSQL("uc.created_at")+` AND vp.created_at <= `+checkin.NaiveFromZonedSQL("uc.claimed_at")+`)`,
		month, models.CheckinRewardStatusClaimed, vip.PurchaseSourcePackage,
	).Scan(&resp.BoughtVipToOpen).Error
}
