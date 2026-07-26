package adminkenchest

import (
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/modules/kenchest"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *kenchest.Service
	repo    *Repository
	logger  *zap.SugaredLogger
}

func NewController(service *kenchest.Service, repo *Repository, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, repo: repo, logger: logger.Named("[admin_ken_chest_controller]")}
}

func parseStatsFilter(c *gin.Context) (StatsFilter, error) {
	var f StatsFilter
	if raw := c.Query("source"); raw == "manual" || raw == "auto" {
		f.Source = raw
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

// GetStats godoc
// @Summary      Thống kê rương ken (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        source query string false "manual|auto"
// @Param        userId query string false "Lọc theo user"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  StatsSuccessResponse
// @Router       /admin/ken/chest-stats [get]
func (ctrl *Controller) GetStats(c *gin.Context) (interface{}, error) {
	f, err := parseStatsFilter(c)
	if err != nil {
		return nil, err
	}

	overview, err := ctrl.repo.StatsOverview(f)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	if overview.TotalClaims > 0 {
		overview.EmptyRate = float64(overview.EmptyClaims) / float64(overview.TotalClaims) * 100
	}

	bySource, err := ctrl.repo.StatsBySource(f)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	bucket := "day"
	if f.From != nil && f.To != nil && f.To.Sub(*f.From) > 90*24*time.Hour {
		bucket = "month"
	}
	timeseries, err := ctrl.repo.StatsTimeseries(f, bucket)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	return &StatsResponse{
		Overview:   overview,
		BySource:   bySource,
		Timeseries: timeseries,
		Bucket:     bucket,
	}, nil
}

// GetUserStats godoc
// @Summary      Thống kê rương ken theo từng user (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        source query string false "manual|auto"
// @Param        userId query string false "Lọc theo user"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        sortBy query string false "kenTotal|claims|empty (mặc định kenTotal)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  UserStatsSuccessResponse
// @Router       /admin/ken/chest-stats/users [get]
func (ctrl *Controller) GetUserStats(c *gin.Context) (interface{}, error) {
	f, err := parseStatsFilter(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	rows, total, err := ctrl.repo.UserStats(f, c.Query("sortBy"), limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	items := make([]UserStatsItem, len(rows))
	for i, row := range rows {
		item := UserStatsItem{
			User:        userBriefFromRow(row),
			Claims:      row.Claims,
			Chests:      row.Chests,
			EmptyClaims: row.EmptyClaims,
			KenTotal:    row.KenTotal,
			LastClaimAt: row.LastClaimAt.UTC().Format(time.RFC3339),
		}
		if row.Claims > 0 {
			item.EmptyRate = float64(row.EmptyClaims) / float64(row.Claims) * 100
		}
		items[i] = item
	}
	return &UserStatsResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}

// Create godoc
// @Summary      Tạo & phát rương ken cho toàn bộ user online (admin)
// @Tags         admin-ken-chest
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body kenchest.CreateChestRequest true "Chest"
// @Success      201  {object}  kenchest.ChestView
// @Router       /admin/ken/chests [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	adminID, _ := middleware.GetAdminID(c)
	req, err := utils.BindJSON[kenchest.CreateChestRequest](c)
	if err != nil {
		return nil, err
	}
	chest, err := ctrl.service.CreateAndBroadcast(c.Request.Context(), adminID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return chest, nil
}

// List godoc
// @Summary      Lịch sử rương ken (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  kenchest.ChestListResponse
// @Router       /admin/ken/chests [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListChests(limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Detail godoc
// @Summary      Chi tiết rương ken (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Chest ID"
// @Success      200  {object}  kenchest.ChestView
// @Failure      404  {object}  utils.APIError
// @Router       /admin/ken/chests/{id} [get]
func (ctrl *Controller) Detail(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid chest id")
	if err != nil {
		return nil, err
	}
	chest, err := ctrl.service.GetChest(id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return chest, nil
}

// ListClaims godoc
// @Summary      Danh sách người đã mở 1 rương ken (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Chest ID"
// @Param        q query string false "Tìm theo username/tên người mở"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  kenchest.ClaimListResponse
// @Router       /admin/ken/chests/{id}/claims [get]
func (ctrl *Controller) ListClaims(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid chest id")
	if err != nil {
		return nil, err
	}
	search := strings.TrimSpace(c.Query("q"))
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListClaims(id, search, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListAllClaims godoc
// @Summary      Lịch sử nhận KEN tất cả rương (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        q query string false "Tìm theo username/tên người nhận"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  kenchest.ClaimHistoryListResponse
// @Router       /admin/ken/claims [get]
func (ctrl *Controller) ListAllClaims(c *gin.Context) (interface{}, error) {
	search := strings.TrimSpace(c.Query("q"))
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListAllClaims(search, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Delete godoc
// @Summary      Huỷ rương ken (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Chest ID"
// @Success      200  {object}  map[string]string
// @Failure      404  {object}  utils.APIError
// @Router       /admin/ken/chests/{id} [delete]
func (ctrl *Controller) Delete(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid chest id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeleteChest(c.Request.Context(), id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "ken chest deleted"}, nil
}

// ListAutoJobs godoc
// @Summary      Danh sách lịch rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Success      200  {array}  kenchest.AutoJobView
// @Router       /admin/ken/auto-jobs [get]
func (ctrl *Controller) ListAutoJobs(c *gin.Context) (interface{}, error) {
	items, err := ctrl.service.ListAutoJobs()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return items, nil
}

// CreateAutoJob godoc
// @Summary      Tạo lịch rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body kenchest.AutoJobRequest true "Auto job"
// @Success      201  {object}  kenchest.AutoJobView
// @Router       /admin/ken/auto-jobs [post]
func (ctrl *Controller) CreateAutoJob(c *gin.Context) (interface{}, error) {
	adminID, _ := middleware.GetAdminID(c)
	req, err := utils.BindJSON[kenchest.AutoJobRequest](c)
	if err != nil {
		return nil, err
	}
	job, err := ctrl.service.CreateAutoJob(adminID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return job, nil
}

// UpdateAutoJob godoc
// @Summary      Sửa lịch rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Auto job ID"
// @Param        request body kenchest.AutoJobRequest true "Auto job"
// @Success      200  {object}  kenchest.AutoJobView
// @Router       /admin/ken/auto-jobs/{id} [put]
func (ctrl *Controller) UpdateAutoJob(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid auto job id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[kenchest.AutoJobRequest](c)
	if err != nil {
		return nil, err
	}
	job, err := ctrl.service.UpdateAutoJob(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return job, nil
}

// DeleteAutoJob godoc
// @Summary      Xoá lịch rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Auto job ID"
// @Success      200  {object}  map[string]string
// @Router       /admin/ken/auto-jobs/{id} [delete]
func (ctrl *Controller) DeleteAutoJob(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid auto job id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeleteAutoJob(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "ken chest auto job deleted"}, nil
}

// GetAutoSettings godoc
// @Summary      Trạng thái công tắc tổng rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  kenchest.AutoSettingsView
// @Router       /admin/ken/auto-settings [get]
func (ctrl *Controller) GetAutoSettings(c *gin.Context) (interface{}, error) {
	settings, err := ctrl.service.GetAutoSettings()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return settings, nil
}

// UpdateAutoSettings godoc
// @Summary      Bật/tắt tất cả rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body kenchest.UpdateAutoSettingsRequest true "Settings"
// @Success      200  {object}  kenchest.AutoSettingsView
// @Router       /admin/ken/auto-settings [put]
func (ctrl *Controller) UpdateAutoSettings(c *gin.Context) (interface{}, error) {
	adminID, _ := middleware.GetAdminID(c)
	req, err := utils.BindJSON[kenchest.UpdateAutoSettingsRequest](c)
	if err != nil {
		return nil, err
	}
	settings, err := ctrl.service.UpdateAutoSettings(adminID, req.Enabled)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return settings, nil
}
