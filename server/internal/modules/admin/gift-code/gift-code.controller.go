package admingiftcode

import (
	"net/http"

	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

func requireAdmin(c *gin.Context) (uuid.UUID, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return uuid.Nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	return adminID, nil
}

func campaignParam(c *gin.Context) (uuid.UUID, error) {
	return utils.ParseUUIDParam(c, "id", "invalid campaign id")
}

func (ctrl *Controller) attemptFilter(c *gin.Context) AttemptFilter {
	return AttemptFilter{
		Since:  ctrl.service.now().Add(-ParseAttemptRange(c.Query("range"))),
		Search: c.Query("search"),
		Reason: c.Query("reason"),
		Limit:  utils.ParseLimit(c, 20, 100),
		Offset: utils.ParseOffset(c),
	}
}

// List godoc
// @Summary      Danh sách đợt mã quà tặng (admin)
// @Tags         admin-gift-codes
// @Produce      json
// @Security     BearerAuth
// @Param        search query string false "Tên đợt hoặc mã"
// @Param        status query string false "running | scheduled | soldout | expired | off"
// @Param        kind   query string false "shared | unique"
// @Param        limit  query int false "Page size (default 20, max 100)"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[CampaignListResponse]
// @Router       /admin/gift-codes [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.List(CampaignFilter{
		Search: c.Query("search"),
		Status: c.Query("status"),
		Kind:   c.Query("kind"),
		Limit:  utils.ParseLimit(c, 20, 100),
		Offset: utils.ParseOffset(c),
	})
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Get godoc
// @Summary      Chi tiết đợt mã quà tặng (admin)
// @Tags         admin-gift-codes
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Campaign ID"
// @Success      200  {object}  utils.BaseResponse[CampaignItem]
// @Router       /admin/gift-codes/{id} [get]
func (ctrl *Controller) Get(c *gin.Context) (interface{}, error) {
	id, err := campaignParam(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Get(id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Create godoc
// @Summary      Tạo đợt mã quà tặng (admin)
// @Description  Mã chung: code + totalUses là tổng lượt. Mã riêng: codePrefix + codeLength, totalUses là số mã cần sinh
// @Tags         admin-gift-codes
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CampaignRequest true "Campaign"
// @Success      200  {object}  utils.BaseResponse[CampaignItem]
// @Failure      400  {object}  utils.APIError
// @Failure      409  {object}  utils.APIError
// @Router       /admin/gift-codes [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	adminID, err := requireAdmin(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[CampaignRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Create(adminID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Update godoc
// @Summary      Sửa đợt mã quà tặng (admin)
// @Description  Đã có người nhận thì không đổi được loại mã, dạng mã và quà. Mã riêng thêm mã bằng POST /codes
// @Tags         admin-gift-codes
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Campaign ID"
// @Param        request body CampaignRequest true "Campaign"
// @Success      200  {object}  utils.BaseResponse[CampaignItem]
// @Failure      400  {object}  utils.APIError
// @Failure      409  {object}  utils.APIError
// @Router       /admin/gift-codes/{id} [put]
func (ctrl *Controller) Update(c *gin.Context) (interface{}, error) {
	adminID, err := requireAdmin(c)
	if err != nil {
		return nil, err
	}
	id, err := campaignParam(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[CampaignRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Update(adminID, id, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// SetEnabled godoc
// @Summary      Bật hoặc tắt đợt mã quà tặng (admin)
// @Tags         admin-gift-codes
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Campaign ID"
// @Param        request body EnabledRequest true "Enabled"
// @Success      200  {object}  utils.BaseResponse[CampaignItem]
// @Router       /admin/gift-codes/{id}/enabled [patch]
func (ctrl *Controller) SetEnabled(c *gin.Context) (interface{}, error) {
	adminID, err := requireAdmin(c)
	if err != nil {
		return nil, err
	}
	id, err := campaignParam(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[EnabledRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.SetEnabled(adminID, id, req.Enabled)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListCodes godoc
// @Summary      Danh sách mã của đợt (admin)
// @Tags         admin-gift-codes
// @Produce      json
// @Security     BearerAuth
// @Param        id     path  string true  "Campaign ID"
// @Param        status query string false "unused | used | locked"
// @Param        search query string false "Mã"
// @Param        limit  query int false "Page size (default 20, max 100)"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[CodeListResponse]
// @Router       /admin/gift-codes/{id}/codes [get]
func (ctrl *Controller) ListCodes(c *gin.Context) (interface{}, error) {
	id, err := campaignParam(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListCodes(id, c.Query("status"), c.Query("search"), utils.ParseLimit(c, 20, 100), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ExportCodes godoc
// @Summary      Toàn bộ mã của đợt để xuất CSV (admin)
// @Tags         admin-gift-codes
// @Produce      json
// @Security     BearerAuth
// @Param        id     path  string true  "Campaign ID"
// @Param        status query string false "unused | used | locked"
// @Success      200  {object}  utils.BaseResponse[CodeListResponse]
// @Router       /admin/gift-codes/{id}/codes/export [get]
func (ctrl *Controller) ExportCodes(c *gin.Context) (interface{}, error) {
	id, err := campaignParam(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListCodes(id, c.Query("status"), c.Query("search"), ExportMaxRows, 0)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GenerateCodes godoc
// @Summary      Sinh thêm mã cho đợt mã riêng (admin)
// @Tags         admin-gift-codes
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Campaign ID"
// @Param        request body GenerateCodesRequest true "Count"
// @Success      200  {object}  utils.BaseResponse[GenerateCodesResponse]
// @Failure      400  {object}  utils.APIError
// @Router       /admin/gift-codes/{id}/codes [post]
func (ctrl *Controller) GenerateCodes(c *gin.Context) (interface{}, error) {
	adminID, err := requireAdmin(c)
	if err != nil {
		return nil, err
	}
	id, err := campaignParam(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[GenerateCodesRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GenerateCodes(adminID, id, req.Count)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// SetCodeLock godoc
// @Summary      Khoá hoặc mở khoá một mã (admin)
// @Description  Khoá phải có lý do. Mã đã dùng thì không khoá được
// @Tags         admin-gift-codes
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id     path string true "Campaign ID"
// @Param        codeId path string true "Code ID"
// @Param        request body LockCodeRequest true "Lock"
// @Success      200  {object}  utils.BaseResponse[CodeItem]
// @Failure      400  {object}  utils.APIError
// @Failure      409  {object}  utils.APIError
// @Router       /admin/gift-codes/{id}/codes/{codeId}/lock [patch]
func (ctrl *Controller) SetCodeLock(c *gin.Context) (interface{}, error) {
	adminID, err := requireAdmin(c)
	if err != nil {
		return nil, err
	}
	id, err := campaignParam(c)
	if err != nil {
		return nil, err
	}
	codeID, err := utils.ParseUUIDParam(c, "codeId", "invalid code id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[LockCodeRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.SetCodeLock(adminID, id, codeID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListRedemptions godoc
// @Summary      Người đã nhận quà của đợt (admin)
// @Tags         admin-gift-codes
// @Produce      json
// @Security     BearerAuth
// @Param        id       path  string true  "Campaign ID"
// @Param        search   query string false "Nickname, tên hoặc mã"
// @Param        platform query string false "web | android | ios"
// @Param        limit    query int false "Page size (default 20, max 100)"
// @Param        offset   query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[RedemptionListResponse]
// @Router       /admin/gift-codes/{id}/redemptions [get]
func (ctrl *Controller) ListRedemptions(c *gin.Context) (interface{}, error) {
	id, err := campaignParam(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListRedemptions(id, c.Query("search"), c.Query("platform"), utils.ParseLimit(c, 20, 100), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ExportRedemptions godoc
// @Summary      Toàn bộ người đã nhận để xuất CSV (admin)
// @Tags         admin-gift-codes
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Campaign ID"
// @Success      200  {object}  utils.BaseResponse[RedemptionListResponse]
// @Router       /admin/gift-codes/{id}/redemptions/export [get]
func (ctrl *Controller) ExportRedemptions(c *gin.Context) (interface{}, error) {
	id, err := campaignParam(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListRedemptions(id, c.Query("search"), c.Query("platform"), ExportMaxRows, 0)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// AttemptSummary godoc
// @Summary      Thống kê nhập mã lỗi (admin)
// @Tags         admin-gift-codes
// @Produce      json
// @Security     BearerAuth
// @Param        range query string false "1h | 24h | 7d | 30d (default 24h)"
// @Success      200  {object}  utils.BaseResponse[AttemptSummary]
// @Router       /admin/gift-codes/attempts/summary [get]
func (ctrl *Controller) AttemptSummary(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AttemptSummary(ctrl.attemptFilter(c).Since)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// AttemptUsers godoc
// @Summary      Nhập mã lỗi gom theo người dùng (admin)
// @Tags         admin-gift-codes
// @Produce      json
// @Security     BearerAuth
// @Param        range  query string false "1h | 24h | 7d | 30d (default 24h)"
// @Param        search query string false "Nickname, mã hoặc IP"
// @Param        reason query string false "Lý do lỗi"
// @Param        limit  query int false "Page size (default 20, max 100)"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[AttemptUserListResponse]
// @Router       /admin/gift-codes/attempts/users [get]
func (ctrl *Controller) AttemptUsers(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AttemptUsers(ctrl.attemptFilter(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// AttemptDevices godoc
// @Summary      Nhập mã lỗi gom theo thiết bị (admin)
// @Tags         admin-gift-codes
// @Produce      json
// @Security     BearerAuth
// @Param        range  query string false "1h | 24h | 7d | 30d (default 24h)"
// @Param        search query string false "Tên thiết bị hoặc nickname"
// @Param        limit  query int false "Page size (default 20, max 100)"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[AttemptDeviceListResponse]
// @Router       /admin/gift-codes/attempts/devices [get]
func (ctrl *Controller) AttemptDevices(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AttemptDevices(ctrl.attemptFilter(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListAttempts godoc
// @Summary      Nhật ký từng lượt nhập mã lỗi (admin)
// @Tags         admin-gift-codes
// @Produce      json
// @Security     BearerAuth
// @Param        range  query string false "1h | 24h | 7d | 30d (default 24h)"
// @Param        search query string false "Nickname, mã hoặc IP"
// @Param        reason query string false "Lý do lỗi"
// @Param        limit  query int false "Page size (default 20, max 100)"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[AttemptListResponse]
// @Router       /admin/gift-codes/attempts [get]
func (ctrl *Controller) ListAttempts(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListAttempts(ctrl.attemptFilter(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
