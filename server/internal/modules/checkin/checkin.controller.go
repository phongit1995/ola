package checkin

import (
	"strings"

	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

// @Summary      Lịch điểm danh tháng này của người gọi
// @Description  enabled=false khi công tắc tổng hoặc nền tảng tắt, hoặc tháng này chưa có lịch đã phát hành. Không trả quà hay nhiệm vụ của ô chưa mở.
// @Tags         checkin
// @Produce      json
// @Security     BearerAuth
// @Param        X-Platform header string false "web | android | ios"
// @Success      200  {object}  utils.BaseResponse[StatusResponse]
// @Router       /checkin [get]
func (ctrl *Controller) Status(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Status(userID, setting.ClientFrom(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Điểm danh hôm nay
// @Description  Đi tiếp 1 ô. Ô có quà mà nhiệm vụ đã làm từ 0h (và đủ VIP nếu cần) thì mở hộp luôn, trả items. Còn lại trả reason task_pending / vip_required. Bấm lại trong ngày trả trạng thái hiện tại. clientRequestId sinh mới mỗi lần bấm, gửi lại thì dùng lại mã cũ: mã đã dùng thì trả kết quả của lượt đó (kể cả lượt của hôm trước), không tính thêm lượt.
// @Tags         checkin
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        X-Platform header string false "web | android | ios"
// @Param        request body CheckInRequest true "Check-in"
// @Success      200  {object}  utils.BaseResponse[ActionResponse]
// @Failure      403  {object}  utils.APIError "CHECKIN_DISABLED, CHECKIN_EMAIL_NOT_VERIFIED"
// @Failure      409  {object}  utils.APIError "CHECKIN_COMPLETED"
// @Router       /checkin [post]
func (ctrl *Controller) CheckIn(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[CheckInRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.CheckIn(userID, setting.ClientFrom(c), strings.TrimSpace(req.ClientRequestID))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Mở hộp quà của hôm nay
// @Description  Bốc mỗi quà 1 món theo cấu hình chụp lúc điểm danh và phát. Hộp đã mở thì trả lại đúng kết quả cũ.
// @Tags         checkin
// @Produce      json
// @Security     BearerAuth
// @Param        X-Platform header string false "web | android | ios"
// @Success      200  {object}  utils.BaseResponse[ActionResponse]
// @Failure      403  {object}  utils.APIError "CHECKIN_DISABLED, CHECKIN_VIP_REQUIRED"
// @Failure      409  {object}  utils.APIError "CHECKIN_TASK_NOT_DONE, CHECKIN_NOTHING_TO_OPEN"
// @Router       /checkin/open [post]
func (ctrl *Controller) Open(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Open(userID, setting.ClientFrom(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
