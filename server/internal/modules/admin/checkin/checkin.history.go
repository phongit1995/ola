package admincheckin

import (
	"strings"
	"time"

	"ola-chat-server/internal/models"
	admincommon "ola-chat-server/internal/modules/admin/common"
	"ola-chat-server/internal/modules/checkin"
	"ola-chat-server/internal/modules/vip"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

const (
	historyStatusClaimed = "claimed"
	historyStatusPending = "pending"
	historyStatusMissed  = "missed"
	historyStatusNone    = "none"
)

type HistoryQuery struct {
	Month  string
	Q      string
	UserID *uuid.UUID
	Status string
	Slot   int
	Limit  int
	Offset int
}

func historyStatus(row *models.UserCheckin, today time.Time) string {
	switch row.RewardStatus {
	case models.CheckinRewardStatusClaimed:
		return historyStatusClaimed
	case models.CheckinRewardStatusPending:
		if row.Day.Equal(today) {
			return historyStatusPending
		}
		return historyStatusMissed
	default:
		return historyStatusNone
	}
}

func (s *Service) missReasons(rows []models.UserCheckin, today time.Time) (map[uuid.UUID]string, error) {
	var missed, undone []uuid.UUID
	for i := range rows {
		if historyStatus(&rows[i], today) != historyStatusMissed {
			continue
		}
		missed = append(missed, rows[i].ID)
		if rows[i].TaskDoneAt == nil && rows[i].Task != nil {
			undone = append(undone, rows[i].ID)
		}
	}
	if len(missed) == 0 {
		return nil, nil
	}
	if len(undone) > 0 {
		if err := checkin.BackfillTaskDoneByIDs(s.db(), undone, today); err != nil {
			return nil, err
		}
		var found []struct {
			ID         uuid.UUID
			TaskDoneAt time.Time
		}
		if err := s.db().Model(&models.UserCheckin{}).Select("id, task_done_at").Where("id IN ? AND task_done_at IS NOT NULL", undone).Scan(&found).Error; err != nil {
			return nil, err
		}
		doneAt := make(map[uuid.UUID]time.Time, len(found))
		for _, f := range found {
			doneAt[f.ID] = f.TaskDoneAt
		}
		for i := range rows {
			if t, ok := doneAt[rows[i].ID]; ok {
				rows[i].TaskDoneAt = &t
			}
		}
	}
	var vipLost []uuid.UUID
	if err := s.db().Raw(`SELECT uc.id FROM user_checkins uc WHERE uc.id IN @ids AND uc.task_done_at IS NOT NULL AND `+vipLostSQL(),
		map[string]interface{}{"ids": missed, "transferOut": vip.PurchaseSourceDayTransferOut},
	).Scan(&vipLost).Error; err != nil {
		return nil, err
	}
	lostNoVip := make(map[uuid.UUID]bool, len(vipLost))
	for _, id := range vipLost {
		lostNoVip[id] = true
	}
	reasons := make(map[uuid.UUID]string, len(missed))
	for i := range rows {
		row := &rows[i]
		if historyStatus(row, today) != historyStatusMissed {
			continue
		}
		switch {
		case row.TaskDoneAt == nil:
			reasons[row.ID] = checkin.MissReasonTask
		case lostNoVip[row.ID]:
			reasons[row.ID] = checkin.MissReasonVip
		default:
			reasons[row.ID] = checkin.MissReasonNotOpened
		}
	}
	return reasons, nil
}

func (s *Service) toHistoryItems(rows []models.UserCheckin, today time.Time) ([]HistoryItem, error) {
	ids := make([]uuid.UUID, 0, len(rows))
	for _, row := range rows {
		ids = append(ids, row.UserID)
	}
	users, err := admincommon.FindUsersByIDs(s.db(), ids)
	if err != nil {
		return nil, err
	}
	reasons, err := s.missReasons(rows, today)
	if err != nil {
		return nil, err
	}
	items := make([]HistoryItem, 0, len(rows))
	for i := range rows {
		row := &rows[i]
		status := historyStatus(row, today)
		item := HistoryItem{
			ID:           row.ID,
			Day:          checkin.DayKey(row.Day),
			Slot:         int(row.Slot),
			Box:          checkin.SlotBox(row.RewardSnapshot.Gifts, row.RewardSnapshot.Featured),
			Task:         row.Task,
			Status:       status,
			VipAtCheckin: row.VipAtCheckin,
			Rewards:      checkin.ResultRewards(row),
			CreatedAt:    row.CreatedAt,
			ClaimedAt:    row.ClaimedAt,
		}
		item.RequireVip = item.Box != checkin.BoxNone && row.RewardSnapshot.RequireVip
		item.MissReason = reasons[row.ID]
		item.TaskDoneAt = row.TaskDoneAt
		u := users[row.UserID]
		item.User = admincommon.UserBriefOf(row.UserID, u.Username, u.FullName, u.Avatar)
		items = append(items, item)
	}
	return items, nil
}

func applyStatusFilter(q *gorm.DB, status string, today time.Time) *gorm.DB {
	switch status {
	case historyStatusClaimed:
		return q.Where("user_checkins.reward_status = ?", models.CheckinRewardStatusClaimed)
	case historyStatusNone:
		return q.Where("user_checkins.reward_status = ?", models.CheckinRewardStatusNone)
	case historyStatusPending:
		return q.Where("user_checkins.reward_status = ? AND user_checkins.day = ?", models.CheckinRewardStatusPending, today)
	case historyStatusMissed:
		return q.Where("user_checkins.reward_status = ? AND user_checkins.day < ?", models.CheckinRewardStatusPending, today)
	}
	return q
}

func (s *Service) History(query HistoryQuery) ([]HistoryItem, int64, error) {
	row, err := s.loadMonth(s.db(), query.Month)
	if err != nil {
		return nil, 0, err
	}
	today := checkin.CalendarDate(s.now())
	q := s.db().Model(&models.UserCheckin{}).Where("user_checkins.month = ?", row.Month)
	if query.UserID != nil {
		q = q.Where("user_checkins.user_id = ?", *query.UserID)
	}
	if query.Slot > 0 {
		q = q.Where("user_checkins.slot = ?", query.Slot)
	}
	q = applyStatusFilter(q, query.Status, today)
	if term := strings.TrimSpace(query.Q); term != "" {
		like := "%" + term + "%"
		q = q.Joins("JOIN users ON users.id = user_checkins.user_id").
			Where("users.username ILIKE ? OR users.full_name ILIKE ? OR users.id::text = ?", like, like, term)
	}
	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var rows []models.UserCheckin
	if err := q.Select("user_checkins.*").Order("user_checkins.created_at DESC").Limit(query.Limit).Offset(query.Offset).Find(&rows).Error; err != nil {
		return nil, 0, err
	}
	items, err := s.toHistoryItems(rows, today)
	if err != nil {
		return nil, 0, err
	}
	return items, total, nil
}

func (s *Service) UserMonth(userID uuid.UUID, value string) (*UserMonthResponse, error) {
	row, err := s.loadMonth(s.db(), value)
	if err != nil {
		return nil, err
	}
	users, err := admincommon.FindUsersByIDs(s.db(), []uuid.UUID{userID})
	if err != nil {
		return nil, err
	}
	u, ok := users[userID]
	if !ok {
		return nil, errUserNotFound
	}
	rows, err := s.repo.UserRows(userID, row.Month)
	if err != nil {
		return nil, err
	}
	entries, err := s.toHistoryItems(rows, checkin.CalendarDate(s.now()))
	if err != nil {
		return nil, err
	}
	return &UserMonthResponse{
		User:      admincommon.UserBriefOf(userID, u.Username, u.FullName, u.Avatar),
		Month:     checkin.MonthKey(row.Month),
		SlotCount: int(row.SlotCount),
		Entries:   entries,
	}, nil
}
