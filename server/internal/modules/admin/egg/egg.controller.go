package adminegg

import (
	"net/http"
	"time"

	"ola-chat-server/internal/modules/egg"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *egg.Service
	repo    *Repository
	logger  *zap.SugaredLogger
}

func NewController(service *egg.Service, repo *Repository, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, repo: repo, logger: logger.Named("[admin_egg_controller]")}
}

// ListPacks godoc
// @Summary      Danh sách gói đập trứng + cấu hình (admin)
// @Tags         admin-egg
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  egg.PackListResponse
// @Router       /admin/egg/packs [get]
func (ctrl *Controller) ListPacks(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListAllPacks()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// CreatePack godoc
// @Summary      Tạo gói đập trứng (admin)
// @Tags         admin-egg
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body egg.CreatePackRequest true "Pack"
// @Success      201  {object}  egg.PackView
// @Router       /admin/egg/packs [post]
func (ctrl *Controller) CreatePack(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[egg.CreatePackRequest](c)
	if err != nil {
		return nil, err
	}
	pack, err := ctrl.service.CreatePack(*req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return pack, nil
}

// UpdatePack godoc
// @Summary      Cập nhật gói đập trứng (admin)
// @Tags         admin-egg
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Pack ID"
// @Param        request body egg.UpdatePackRequest true "Pack"
// @Success      200  {object}  egg.PackView
// @Failure      404  {object}  utils.APIError
// @Router       /admin/egg/packs/{id} [patch]
func (ctrl *Controller) UpdatePack(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid pack id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[egg.UpdatePackRequest](c)
	if err != nil {
		return nil, err
	}
	pack, err := ctrl.service.UpdatePack(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return pack, nil
}

// DeletePack godoc
// @Summary      Xoá gói đập trứng (admin)
// @Tags         admin-egg
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Pack ID"
// @Success      200  {object}  map[string]string
// @Failure      404  {object}  utils.APIError
// @Router       /admin/egg/packs/{id} [delete]
func (ctrl *Controller) DeletePack(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid pack id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeletePack(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "egg pack deleted"}, nil
}

// SaveConfig godoc
// @Summary      Lưu cả cây nhóm + phần thưởng của gói (admin)
// @Tags         admin-egg
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Pack ID"
// @Param        request body egg.SaveConfigRequest true "Config"
// @Success      200  {object}  egg.PackView
// @Failure      404  {object}  utils.APIError
// @Router       /admin/egg/packs/{id}/config [put]
func (ctrl *Controller) SaveConfig(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid pack id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[egg.SaveConfigRequest](c)
	if err != nil {
		return nil, err
	}
	pack, err := ctrl.service.SaveConfig(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return pack, nil
}

// ListDraws godoc
// @Summary      Lịch sử đập trứng toàn hệ thống (admin)
// @Tags         admin-egg
// @Produce      json
// @Security     BearerAuth
// @Param        userId query string false "Lọc theo user"
// @Param        categoryType query string false "Lọc theo loại (nothing|vip_icon|ken|vip_days)"
// @Param        outcome query string false "Lọc trúng/trượt (win|miss)"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  egg.AdminDrawListResponse
// @Router       /admin/egg/draws [get]
func (ctrl *Controller) ListDraws(c *gin.Context) (interface{}, error) {
	var filter egg.AdminDrawFilter
	if raw := c.Query("userId"); raw != "" {
		parsed, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid user id")
		}
		filter.UserID = &parsed
	}
	if raw := c.Query("categoryType"); raw != "" {
		switch raw {
		case "nothing", "vip_icon", "ken", "vip_days":
			filter.CategoryType = raw
		default:
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid category type")
		}
	}
	if raw := c.Query("outcome"); raw == "win" || raw == "miss" {
		filter.Outcome = raw
	}
	if raw := c.Query("from"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid from time")
		}
		filter.From = &t
	}
	if raw := c.Query("to"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid to time")
		}
		filter.To = &t
	}
	limit := utils.ParseLimit(c, 50, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListAllDraws(filter, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetStats godoc
// @Summary      Thống kê đập trứng (admin)
// @Tags         admin-egg
// @Produce      json
// @Security     BearerAuth
// @Param        packId query string false "Lọc theo gói"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  egg.StatsResponse
// @Router       /admin/egg/stats [get]
func (ctrl *Controller) GetStats(c *gin.Context) (interface{}, error) {
	var filter egg.AdminDrawFilter
	if raw := c.Query("packId"); raw != "" {
		parsed, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid pack id")
		}
		filter.PackID = &parsed
	}
	if raw := c.Query("from"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid from time")
		}
		filter.From = &t
	}
	if raw := c.Query("to"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid to time")
		}
		filter.To = &t
	}
	resp, err := ctrl.service.Stats(filter)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func parseStatsFilter(c *gin.Context) (StatsFilter, error) {
	var f StatsFilter
	if raw := c.Query("packId"); raw != "" {
		parsed, err := uuid.Parse(raw)
		if err != nil {
			return f, utils.NewHTTPError(http.StatusBadRequest, "invalid pack id")
		}
		f.PackID = &parsed
	}
	if raw := c.Query("userId"); raw != "" {
		parsed, err := uuid.Parse(raw)
		if err != nil {
			return f, utils.NewHTTPError(http.StatusBadRequest, "invalid user id")
		}
		f.UserID = &parsed
	}
	if raw := c.Query("from"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return f, utils.NewHTTPError(http.StatusBadRequest, "invalid from time")
		}
		f.From = &t
	}
	if raw := c.Query("to"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return f, utils.NewHTTPError(http.StatusBadRequest, "invalid to time")
		}
		f.To = &t
	}
	return f, nil
}

func userBriefFromRow(row userStatsRow) UserBrief {
	if row.Username == "" {
		return UserBrief{ID: row.UserID.String(), Username: row.UserID.String()[:8]}
	}
	return UserBrief{
		ID:       row.UserID.String(),
		Username: row.Username,
		FullName: row.FullName,
		Avatar:   row.Avatar,
	}
}

// GetUserStats godoc
// @Summary      Thống kê đập trứng theo từng user (admin)
// @Tags         admin-egg
// @Produce      json
// @Security     BearerAuth
// @Param        packId query string false "Lọc theo gói"
// @Param        userId query string false "Lọc theo user"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        sortBy query string false "kenSpent|kenWon|netKen|draws|vipDays (mặc định kenSpent)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  UserStatsSuccessResponse
// @Router       /admin/egg/stats/users [get]
func (ctrl *Controller) GetUserStats(c *gin.Context) (interface{}, error) {
	filter, err := parseStatsFilter(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	rows, total, err := ctrl.repo.UserStats(filter, c.Query("sortBy"), limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	items := make([]UserStatsItem, len(rows))
	for i, row := range rows {
		item := UserStatsItem{
			User:       userBriefFromRow(row),
			Draws:      row.Draws,
			WinDraws:   row.WinDraws,
			KenSpent:   row.KenSpent,
			KenWon:     row.KenWon,
			NetKen:     row.NetKen,
			VipDays:    row.VipDaysWon,
			VipIcons:   row.VipIconsWon,
			LastDrawAt: row.LastDrawAt.UTC().Format(time.RFC3339),
		}
		if row.Draws > 0 {
			item.WinRate = float64(row.WinDraws) / float64(row.Draws) * 100
		}
		items[i] = item
	}
	return &UserStatsResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}

// GetVipStats godoc
// @Summary      Thống kê đập trứng theo loại VIP (admin)
// @Tags         admin-egg
// @Produce      json
// @Security     BearerAuth
// @Param        packId query string false "Lọc theo gói"
// @Param        userId query string false "Lọc theo user"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  VipStatsSuccessResponse
// @Router       /admin/egg/stats/vip [get]
func (ctrl *Controller) GetVipStats(c *gin.Context) (interface{}, error) {
	filter, err := parseStatsFilter(c)
	if err != nil {
		return nil, err
	}
	rows, err := ctrl.repo.VipStats(filter)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	if rows == nil {
		rows = []VipStatsRow{}
	}
	return &VipStatsResponse{Items: rows}, nil
}
