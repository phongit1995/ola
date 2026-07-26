package adminken

import (
	"net/http"
	"strconv"
	"time"

	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_ken_controller]")}
}

// Adjust godoc
// @Summary      Cộng/trừ ken cho user (admin)
// @Description  Admin tặng (grant) hoặc trừ (deduct) ken; ghi ken_transactions và bắn KEN_UPDATED
// @Tags         admin-ken
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        userId path string true "User ID"
// @Param        request body AdjustRequest true "Adjust request"
// @Success      200  {object}  AdjustSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /admin/ken/users/{userId}/adjust [post]
func (ctrl *Controller) Adjust(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDParam(c, "userId", "invalid user id")
	if err != nil {
		return nil, err
	}

	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(401, "admin not authenticated")
	}

	req, err := utils.BindJSON[AdjustRequest](c)
	if err != nil {
		return nil, err
	}

	resp, err := ctrl.service.Adjust(userID, adminID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListTransactions godoc
// @Summary      Lịch sử giao dịch ken của user (admin)
// @Tags         admin-ken
// @Produce      json
// @Security     BearerAuth
// @Param        userId path string true "User ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  TransactionListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Router       /admin/ken/users/{userId}/transactions [get]
func (ctrl *Controller) ListTransactions(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDParam(c, "userId", "invalid user id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	resp, err := ctrl.service.ListTransactions(userID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func parseUUIDQuery(c *gin.Context, key string) (*uuid.UUID, error) {
	raw := c.Query(key)
	if raw == "" {
		return nil, nil
	}
	id, err := uuid.Parse(raw)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid "+key)
	}
	return &id, nil
}

func parseIntQuery(c *gin.Context, key string) *int {
	raw := c.Query(key)
	if raw == "" {
		return nil
	}
	n, err := strconv.Atoi(raw)
	if err != nil {
		return nil
	}
	return &n
}

func parseTransferFilter(c *gin.Context) (TransferFilter, error) {
	var f TransferFilter
	senderID, err := parseUUIDQuery(c, "senderId")
	if err != nil {
		return f, err
	}
	f.SenderID = senderID

	receiverID, err := parseUUIDQuery(c, "receiverId")
	if err != nil {
		return f, err
	}
	f.ReceiverID = receiverID

	userID, err := parseUUIDQuery(c, "userId")
	if err != nil {
		return f, err
	}
	f.UserID = userID

	f.MinAmount = parseIntQuery(c, "minAmount")
	f.MaxAmount = parseIntQuery(c, "maxAmount")

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

// ListTransfers godoc
// @Summary      Lịch sử chuyển ken giữa các user (admin)
// @Tags         admin-ken
// @Produce      json
// @Security     BearerAuth
// @Param        senderId query string false "Lọc theo người gửi"
// @Param        receiverId query string false "Lọc theo người nhận"
// @Param        userId query string false "Lọc theo user (gửi hoặc nhận)"
// @Param        minAmount query int false "Số ken tối thiểu"
// @Param        maxAmount query int false "Số ken tối đa"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  TransferListSuccessResponse
// @Router       /admin/ken/transfers [get]
func (ctrl *Controller) ListTransfers(c *gin.Context) (interface{}, error) {
	f, err := parseTransferFilter(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	resp, err := ctrl.service.ListTransfers(f, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// TransferUserStats godoc
// @Summary      Thống kê chuyển/nhận ken theo từng user (admin)
// @Tags         admin-ken
// @Produce      json
// @Security     BearerAuth
// @Param        userId query string false "Lọc theo user"
// @Param        minAmount query int false "Số ken tối thiểu mỗi giao dịch"
// @Param        maxAmount query int false "Số ken tối đa mỗi giao dịch"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        sortBy query string false "sentTotal|receivedTotal|netKen|transfers (mặc định sentTotal)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  TransferUserStatsSuccessResponse
// @Router       /admin/ken/transfers/users [get]
func (ctrl *Controller) TransferUserStats(c *gin.Context) (interface{}, error) {
	f, err := parseTransferFilter(c)
	if err != nil {
		return nil, err
	}
	f.SenderID = nil
	f.ReceiverID = nil
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	resp, err := ctrl.service.TransferUserStats(f, c.Query("sortBy"), limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
