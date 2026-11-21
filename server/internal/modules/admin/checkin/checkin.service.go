package admincheckin

import (
	"fmt"
	"net/http"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/checkin"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"go.uber.org/zap"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

var (
	errMonthNotFound = utils.NewHTTPError(http.StatusNotFound, "Tháng này chưa có lịch")
	errMonthExists   = utils.NewHTTPError(http.StatusConflict, "Tháng này đã có lịch")
	errMonthPast     = utils.NewHTTPError(http.StatusBadRequest, "Tháng đã qua chỉ xem, không sửa được")
	errMonthInvalid  = utils.NewHTTPError(http.StatusBadRequest, "Tháng không hợp lệ")
	errPublished     = utils.NewHTTPError(http.StatusConflict, "Lịch tháng này đã phát hành")
	errDeleteRunning = utils.NewHTTPError(http.StatusBadRequest, "Chỉ xoá được lịch nháp hoặc lịch của tháng chưa bắt đầu")
	errDeleteUsed    = utils.NewHTTPError(http.StatusBadRequest, "Tháng này đã có người điểm danh, không xoá được")
	errUserNotFound  = utils.NewHTTPError(http.StatusNotFound, "Không tìm thấy người dùng")
	errSwapSame      = utils.NewHTTPError(http.StatusBadRequest, "Chọn hai ô khác nhau để đổi chỗ")
)

type Service struct {
	repo       *checkin.Repository
	checkinSvc *checkin.Service
	cache      *services.CacheService
	logger     *zap.SugaredLogger
	now        func() time.Time
}

func NewService(repo *checkin.Repository, checkinSvc *checkin.Service, cache *services.CacheService, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, checkinSvc: checkinSvc, cache: cache, logger: logger.Named("[admin_checkin_service]"), now: time.Now}
}

func (s *Service) db() *gorm.DB {
	return s.repo.DB()
}

func toMonthDTO(m models.CheckinMonth) MonthDTO {
	return MonthDTO{
		Month:       checkin.MonthKey(m.Month),
		SlotCount:   int(m.SlotCount),
		PublishedAt: m.PublishedAt,
		CreatedAt:   m.CreatedAt,
		UpdatedAt:   m.UpdatedAt,
	}
}

func toSlotDTO(slot models.CheckinSlot) SlotDTO {
	gifts := slot.Gifts
	if gifts == nil {
		gifts = models.CheckinGifts{}
	}
	updatedAt := slot.UpdatedAt
	return SlotDTO{Slot: int(slot.Slot), Gifts: gifts, Featured: slot.Featured, RequireVip: slot.RequireVip, Task: slot.Task, UpdatedAt: &updatedAt}
}

func emptySlot(month time.Time, n int, now time.Time) models.CheckinSlot {
	return models.CheckinSlot{Month: month, Slot: int16(n), Gifts: models.CheckinGifts{}, UpdatedAt: now}
}

func parseMonth(value string) (time.Time, error) {
	month, ok := checkin.ParseMonth(value)
	if !ok {
		return time.Time{}, errMonthInvalid
	}
	return month, nil
}

func (s *Service) loadMonth(tx *gorm.DB, value string) (*models.CheckinMonth, error) {
	month, err := parseMonth(value)
	if err != nil {
		return nil, err
	}
	row, err := checkin.FindMonthTx(tx, month)
	if err != nil {
		return nil, err
	}
	if row == nil {
		return nil, errMonthNotFound
	}
	return row, nil
}

func (s *Service) lockMonth(tx *gorm.DB, value string) (*models.CheckinMonth, error) {
	month, err := parseMonth(value)
	if err != nil {
		return nil, err
	}
	row, err := checkin.LockMonthTx(tx, month)
	if err != nil {
		return nil, err
	}
	if row == nil {
		return nil, errMonthNotFound
	}
	return row, nil
}

func slotConflict(slot int) error {
	return utils.NewHTTPError(http.StatusConflict, fmt.Sprintf("Ô %d vừa được sửa ở nơi khác. Tải lại lịch rồi sửa lại", slot))
}

func (s *Service) detail(tx *gorm.DB, month models.CheckinMonth) (*MonthDetailDTO, error) {
	slots, err := checkin.SlotsTx(tx, month.Month)
	if err != nil {
		return nil, err
	}
	bySlot := make(map[int]models.CheckinSlot, len(slots))
	for _, slot := range slots {
		bySlot[int(slot.Slot)] = slot
	}
	items := make([]SlotDTO, 0, month.SlotCount)
	for n := 1; n <= int(month.SlotCount); n++ {
		slot, ok := bySlot[n]
		if !ok {
			slot = emptySlot(month.Month, n, month.UpdatedAt)
		}
		items = append(items, toSlotDTO(slot))
	}
	return &MonthDetailDTO{MonthDTO: toMonthDTO(month), Slots: items}, nil
}

func (s *Service) ListMonths() (*MonthListResponse, error) {
	var rows []models.CheckinMonth
	if err := s.db().Order("month").Find(&rows).Error; err != nil {
		return nil, err
	}
	items := make([]MonthDTO, 0, len(rows))
	for _, row := range rows {
		items = append(items, toMonthDTO(row))
	}
	return &MonthListResponse{Items: items}, nil
}

func (s *Service) GetMonth(value string) (*MonthDetailDTO, error) {
	row, err := s.loadMonth(s.db(), value)
	if err != nil {
		return nil, err
	}
	return s.detail(s.db(), *row)
}

func (s *Service) CreateMonth(req CreateMonthRequest) (*MonthDetailDTO, error) {
	month, err := parseMonth(req.Month)
	if err != nil {
		return nil, err
	}
	now := s.now()
	if month.Before(checkin.MonthDate(now)) {
		return nil, errMonthPast
	}
	days := checkin.DaysInMonth(month)
	if req.SlotCount < 1 || req.SlotCount > days {
		return nil, invalid("Số ô phải từ 1 tới %d", days)
	}
	var result *MonthDetailDTO
	err = s.repo.Transaction(func(tx *gorm.DB) error {
		existing, err := checkin.FindMonthTx(tx, month)
		if err != nil {
			return err
		}
		if existing != nil {
			return errMonthExists
		}
		var source []models.CheckinSlot
		if req.Source == "copy" {
			from, err := s.loadMonth(tx, req.CopyFrom)
			if err != nil {
				return err
			}
			if source, err = checkin.SlotsTx(tx, from.Month); err != nil {
				return err
			}
		}
		row := models.CheckinMonth{Month: month, SlotCount: int16(req.SlotCount), CreatedAt: now, UpdatedAt: now}
		if err := tx.Create(&row).Error; err != nil {
			return err
		}
		slots := make([]models.CheckinSlot, 0, req.SlotCount)
		for n := 1; n <= req.SlotCount; n++ {
			slots = append(slots, emptySlot(month, n, now))
		}
		for _, src := range source {
			if n := int(src.Slot); n >= 1 && n <= req.SlotCount {
				slots[n-1] = models.CheckinSlot{Month: month, Slot: src.Slot, Gifts: src.Gifts, Featured: src.Featured, RequireVip: src.RequireVip, Task: src.Task, UpdatedAt: now}
			}
		}
		if err := tx.Create(&slots).Error; err != nil {
			return err
		}
		result, err = s.detail(tx, row)
		return err
	})
	if err != nil {
		if apperr.IsUniqueViolation(err) {
			return nil, errMonthExists
		}
		return nil, err
	}
	s.checkinSvc.InvalidateMonth(month)
	return result, nil
}

func (s *Service) UpdateSlotCount(value string, req UpdateMonthRequest) (*MonthDetailDTO, error) {
	now := s.now()
	var result *MonthDetailDTO
	var month time.Time
	err := s.repo.Transaction(func(tx *gorm.DB) error {
		row, err := s.lockMonth(tx, value)
		if err != nil {
			return err
		}
		month = row.Month
		current := checkin.MonthDate(now)
		if row.Month.Before(current) {
			return errMonthPast
		}
		days := checkin.DaysInMonth(row.Month)
		if req.SlotCount < 1 || req.SlotCount > days {
			return invalid("Số ô phải từ 1 tới %d", days)
		}
		old := int(row.SlotCount)
		if row.PublishedAt != nil && row.Month.Equal(current) && req.SlotCount < old {
			return invalid("Tháng đang chạy chỉ được tăng số ô")
		}
		if req.SlotCount > old {
			slots := make([]models.CheckinSlot, 0, req.SlotCount-old)
			for n := old + 1; n <= req.SlotCount; n++ {
				slots = append(slots, emptySlot(row.Month, n, now))
			}
			if err := tx.Create(&slots).Error; err != nil {
				return err
			}
		} else if req.SlotCount < old {
			if err := tx.Where("month = ? AND slot > ?", row.Month, req.SlotCount).Delete(&models.CheckinSlot{}).Error; err != nil {
				return err
			}
		}
		row.SlotCount = int16(req.SlotCount)
		row.UpdatedAt = now
		if err := tx.Model(row).Select("slot_count", "updated_at").Updates(row).Error; err != nil {
			return err
		}
		result, err = s.detail(tx, *row)
		return err
	})
	if err != nil {
		return nil, err
	}
	s.checkinSvc.InvalidateMonth(month)
	return result, nil
}

func (s *Service) Publish(value string) (*MonthDetailDTO, error) {
	now := s.now()
	var result *MonthDetailDTO
	var month time.Time
	err := s.repo.Transaction(func(tx *gorm.DB) error {
		row, err := s.lockMonth(tx, value)
		if err != nil {
			return err
		}
		month = row.Month
		if row.Month.Before(checkin.MonthDate(now)) {
			return errMonthPast
		}
		if row.PublishedAt != nil {
			return errPublished
		}
		slots, err := checkin.SlotsTx(tx, row.Month)
		if err != nil {
			return err
		}
		for _, slot := range slots {
			if _, err := cleanSlot(toSlotDTO(slot)); err != nil {
				return err
			}
		}
		row.PublishedAt = &now
		row.UpdatedAt = now
		if err := tx.Model(row).Select("published_at", "updated_at").Updates(row).Error; err != nil {
			return err
		}
		result, err = s.detail(tx, *row)
		return err
	})
	if err != nil {
		return nil, err
	}
	s.checkinSvc.InvalidateMonth(month)
	return result, nil
}

func (s *Service) DeleteMonth(value string) error {
	now := s.now()
	var month time.Time
	err := s.repo.Transaction(func(tx *gorm.DB) error {
		row, err := s.lockMonth(tx, value)
		if err != nil {
			return err
		}
		month = row.Month
		current := checkin.MonthDate(now)
		if row.Month.Before(current) || (row.PublishedAt != nil && !row.Month.After(current)) {
			return errDeleteRunning
		}
		return tx.Where("month = ?", row.Month).Delete(&models.CheckinMonth{}).Error
	})
	if err != nil {
		if apperr.IsForeignKeyViolation(err) {
			return errDeleteUsed
		}
		return err
	}
	s.checkinSvc.InvalidateMonth(month)
	return nil
}

func (s *Service) SaveSlots(value string, req SaveSlotsRequest) (*MonthDetailDTO, error) {
	now := s.now()
	if len(req.Slots) == 0 {
		return nil, invalid("Chưa có ô nào để lưu")
	}
	var result *MonthDetailDTO
	var month time.Time
	err := s.repo.Transaction(func(tx *gorm.DB) error {
		row, err := s.lockMonth(tx, value)
		if err != nil {
			return err
		}
		month = row.Month
		if row.Month.Before(checkin.MonthDate(now)) {
			return errMonthPast
		}
		locked := checkin.LockedThrough(row, now)
		seen := make(map[int]bool, len(req.Slots))
		for _, in := range req.Slots {
			if in.Slot < 1 || in.Slot > int(row.SlotCount) {
				return invalid("Ô %d vượt số ô của tháng", in.Slot)
			}
			if seen[in.Slot] {
				return invalid("Ô %d bị trùng", in.Slot)
			}
			seen[in.Slot] = true
			if in.Slot <= locked {
				return invalid("Ô %d có thể đã có người nhận, không sửa được", in.Slot)
			}
			slot, err := cleanSlot(in)
			if err != nil {
				return err
			}
			slot.Month = row.Month
			slot.UpdatedAt = now
			query := tx.Model(&models.CheckinSlot{}).Where("month = ? AND slot = ?", row.Month, slot.Slot)
			if in.UpdatedAt != nil {
				query = query.Where("updated_at = ?", *in.UpdatedAt)
			}
			res := query.Select("gifts", "featured", "require_vip", "task", "updated_at").Updates(&slot)
			if res.Error != nil {
				return res.Error
			}
			if res.RowsAffected == 0 {
				return slotConflict(in.Slot)
			}
		}
		row.UpdatedAt = now
		if err := tx.Model(row).Select("updated_at").Updates(row).Error; err != nil {
			return err
		}
		result, err = s.detail(tx, *row)
		return err
	})
	if err != nil {
		return nil, err
	}
	s.checkinSvc.InvalidateMonth(month)
	return result, nil
}

func (s *Service) SwapSlots(value string, req SwapSlotsRequest) (*MonthDetailDTO, error) {
	if req.From == req.To {
		return nil, errSwapSame
	}
	now := s.now()
	var result *MonthDetailDTO
	var month time.Time
	err := s.repo.Transaction(func(tx *gorm.DB) error {
		row, err := s.lockMonth(tx, value)
		if err != nil {
			return err
		}
		month = row.Month
		if row.Month.Before(checkin.MonthDate(now)) {
			return errMonthPast
		}
		locked := checkin.LockedThrough(row, now)
		for _, n := range []int{req.From, req.To} {
			if n < 1 || n > int(row.SlotCount) {
				return invalid("Ô %d vượt số ô của tháng", n)
			}
			if n <= locked {
				return invalid("Ô %d có thể đã có người nhận, không đổi chỗ được", n)
			}
		}
		var pair []models.CheckinSlot
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).
			Where("month = ? AND slot IN ?", row.Month, []int{req.From, req.To}).
			Find(&pair).Error; err != nil {
			return err
		}
		if len(pair) != 2 {
			return errMonthNotFound
		}
		a, b := pair[0], pair[1]
		for _, move := range []struct {
			target int16
			from   models.CheckinSlot
		}{{a.Slot, b}, {b.Slot, a}} {
			next := models.CheckinSlot{Gifts: move.from.Gifts, Featured: move.from.Featured, RequireVip: move.from.RequireVip, Task: move.from.Task, UpdatedAt: now}
			if next.Gifts == nil {
				next.Gifts = models.CheckinGifts{}
			}
			if err := tx.Model(&models.CheckinSlot{}).
				Where("month = ? AND slot = ?", row.Month, move.target).
				Select("gifts", "featured", "require_vip", "task", "updated_at").
				Updates(&next).Error; err != nil {
				return err
			}
		}
		row.UpdatedAt = now
		if err := tx.Model(row).Select("updated_at").Updates(row).Error; err != nil {
			return err
		}
		result, err = s.detail(tx, *row)
		return err
	})
	if err != nil {
		return nil, err
	}
	s.checkinSvc.InvalidateMonth(month)
	return result, nil
}
