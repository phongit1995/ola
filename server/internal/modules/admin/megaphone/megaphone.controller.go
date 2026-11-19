package adminmegaphone

import (
	"net/http"

	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_megaphone_controller]")}
}

var megaphoneTypes = map[string]bool{
	models.MegaphoneTypeMessage: true,
	models.MegaphoneTypeGift:    true,
	models.MegaphoneTypeLucky:   true,
}

var megaphonePaidWith = map[string]bool{
	PaidWithKen:    true,
	PaidWithTicket: true,
}

var megaphoneStatuses = map[string]bool{
	models.MegaphoneStatusActive:  true,
	models.MegaphoneStatusRemoved: true,
}

// @Summary      Danh sách loa đã phát (admin)
// @Tags         admin-megaphones
// @Produce      json
// @Security     BearerAuth
// @Param        senderId query string false "Người phát"
// @Param        status   query string false "active, removed"
// @Param        type     query string false "Loại tin: message, gift, lucky"
// @Param        paidWith query string false "Trả bằng: ken, ticket"
// @Param        q        query string false "Tìm trong nội dung"
// @Param        from     query string false "Từ thời gian (RFC3339)"
// @Param        to       query string false "Đến thời gian (RFC3339)"
// @Param        limit    query int    false "Page size"
// @Param        offset   query int    false "Offset"
// @Success      200  {object}  ListSuccessResponse
// @Router       /admin/megaphones [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	f := ListFilter{
		Query:  c.Query("q"),
		Limit:  utils.ParseLimit(c, 20, 100),
		Offset: utils.ParseOffset(c),
	}
	var err error
	if f.SenderID, err = utils.ParseUUIDQuery(c, "senderId"); err != nil {
		return nil, err
	}
	if status := c.Query("status"); megaphoneStatuses[status] {
		f.Status = status
	}
	if megaphoneType := c.Query("type"); megaphoneTypes[megaphoneType] {
		f.Type = megaphoneType
	}
	if paidWith := c.Query("paidWith"); megaphonePaidWith[paidWith] {
		f.PaidWith = paidWith
	}
	if f.From, f.To, err = utils.ParseTimeRange(c); err != nil {
		return nil, err
	}
	resp, err := ctrl.service.List(f)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Gỡ một loa (admin)
// @Description  Loa biến mất trên mọi máy, không hoàn KEN. Có penalty thì tính điểm vi phạm cho người phát.
// @Tags         admin-megaphones
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id      path string        true "Megaphone ID"
// @Param        request body RemoveRequest true "Lý do + điểm vi phạm"
// @Success      200  {object}  RemoveSuccessResponse
// @Failure      404  {object}  utils.APIError
// @Router       /admin/megaphones/{id}/remove [post]
func (ctrl *Controller) Remove(c *gin.Context) (interface{}, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid megaphone id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[RemoveRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Remove(adminID, id, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Thử một câu với bộ lọc nội dung (admin)
// @Tags         admin-megaphones
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CheckContentRequest true "Câu cần thử"
// @Success      200  {object}  CheckContentSuccessResponse
// @Router       /admin/content-filter/check [post]
func (ctrl *Controller) CheckContent(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[CheckContentRequest](c)
	if err != nil {
		return nil, err
	}
	return ctrl.service.CheckContent(req.Text), nil
}

// @Summary      Vé loa của một user (admin)
// @Description  Tất cả vé kèm trạng thái: usable, used, expired, revoked.
// @Tags         admin-megaphones
// @Produce      json
// @Security     BearerAuth
// @Param        id   path string true "User ID"
// @Success      200  {object}  UserTicketListSuccessResponse
// @Failure      404  {object}  utils.APIError
// @Router       /admin/users/{id}/megaphone-tickets [get]
func (ctrl *Controller) ListUserTickets(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDParam(c, "id", "invalid user id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListUserTickets(userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Tặng vé loa cho user (admin)
// @Description  expiresInDays = 0 là vé không hạn. Tối đa 100 vé mỗi lần, hạn 1–365 ngày.
// @Tags         admin-megaphones
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id      path string              true "User ID"
// @Param        request body GrantTicketsRequest true "Số vé + hạn"
// @Success      200  {object}  UserTicketListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /admin/users/{id}/megaphone-tickets [post]
func (ctrl *Controller) GrantUserTickets(c *gin.Context) (interface{}, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	userID, err := utils.ParseUUIDParam(c, "id", "invalid user id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[GrantTicketsRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GrantUserTickets(adminID, userID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Thu hồi một vé loa còn dùng được (admin)
// @Tags         admin-megaphones
// @Produce      json
// @Security     BearerAuth
// @Param        id       path string true "User ID"
// @Param        ticketId path string true "Ticket ID"
// @Success      200  {object}  UserTicketSuccessResponse
// @Failure      409  {object}  utils.APIError
// @Router       /admin/users/{id}/megaphone-tickets/{ticketId}/revoke [post]
func (ctrl *Controller) RevokeUserTicket(c *gin.Context) (interface{}, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	userID, err := utils.ParseUUIDParam(c, "id", "invalid user id")
	if err != nil {
		return nil, err
	}
	ticketID, err := utils.ParseUUIDParam(c, "ticketId", "invalid ticket id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.RevokeUserTicket(adminID, userID, ticketID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
