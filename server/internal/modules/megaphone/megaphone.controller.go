package megaphone

import (
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[megaphone_controller]")}
}

// Config godoc
// @Summary      Cấu hình phát loa + trạng thái của người gọi
// @Description  Giá, số ký tự, thời gian hiện, số loa đã phát hôm nay, số giây còn phải chờ và thời gian chờ hàng loa hiện tại.
// @Tags         megaphones
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  ConfigSuccessResponse
// @Router       /megaphones/config [get]
func (ctrl *Controller) Config(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Config(userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// History godoc
// @Summary      Loa thường đã phát trong 24 giờ gần nhất
// @Tags         megaphones
// @Produce      json
// @Security     BearerAuth
// @Param        cursor query string false "Con trỏ trang sau"
// @Param        limit  query int    false "Số loa mỗi trang (mặc định 20, tối đa 50)"
// @Success      200  {object}  HistorySuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /megaphones [get]
func (ctrl *Controller) History(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.History(c.Query("cursor"), utils.ParseLimit(c, HistoryDefaultLimit, HistoryMaxLimit))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Send godoc
// @Summary      Phát loa tới mọi người
// @Description  Kiểm tra nội dung (link, từ cấm), thời gian chờ và giới hạn ngày trước khi trừ KEN (MEGAPHONE). Đang có quá nhiều tin chờ phát thì từ chối, không trừ KEN. Server tự phát loa theo lịch trong thời gian sống. clientRequestId chống trừ hai lần khi gửi lại.
// @Tags         megaphones
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body SendRequest true "Megaphone"
// @Success      200  {object}  SendSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      409  {object}  utils.APIError
// @Failure      429  {object}  utils.APIError
// @Router       /megaphones [post]
func (ctrl *Controller) Send(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[SendRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Send(userID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
