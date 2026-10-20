package adminconversation

import (
	"net/http"

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
	return &Controller{service: service, logger: logger.Named("[admin_conversation_controller]")}
}

// ListByUser godoc
// @Summary      Hội thoại của một user (admin, chỉ xem)
// @Description  hidden=false: hội thoại đang hiển thị, sắp theo tin mới nhất. hidden=true: hội thoại user đã ẩn, sắp theo lúc ẩn. missing=true là hội thoại không còn dữ liệu
// @Tags         admin-conversation
// @Produce      json
// @Security     BearerAuth
// @Param        userId query string true "User ID"
// @Param        hidden query bool false "Lấy hội thoại đã ẩn"
// @Param        limit query int false "Số hội thoại (mặc định 30, tối đa 100)"
// @Param        offset query int false "Offset trong snapshot"
// @Param        snapshot query string false "Snapshot trả về ở trang đầu; bỏ trống để tạo danh sách mới"
// @Success      200  {object}  ConversationListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      410  {object}  utils.APIError  "snapshot hết hạn (15 phút), tải lại từ đầu"
// @Router       /admin/conversations [get]
func (ctrl *Controller) ListByUser(c *gin.Context) (interface{}, error) {
	userID, err := uuid.Parse(c.Query("userId"))
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid user id")
	}
	hidden := c.Query("hidden") == "true"
	resp, err := ctrl.service.ListByUser(userID, hidden, utils.ParseLimit(c, 30, 100), utils.ParseOffset(c), c.Query("snapshot"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Detail godoc
// @Summary      Thông tin và thành viên của hội thoại (admin)
// @Tags         admin-conversation
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Conversation ID"
// @Success      200  {object}  ConversationDetailSuccessResponse
// @Failure      404  {object}  utils.APIError
// @Router       /admin/conversations/{id} [get]
func (ctrl *Controller) Detail(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid conversation id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Detail(id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Messages godoc
// @Summary      Tin nhắn của hội thoại (admin, chỉ xem)
// @Description  Trả mới nhất trước, gồm cả tin đã bị xoá (deletedAt). Truyền around để lấy các tin quanh một tin (mở từ báo cáo vi phạm)
// @Tags         admin-conversation
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Conversation ID"
// @Param        limit query int false "Số tin (mặc định 50, tối đa 100)"
// @Param        before query string false "Cursor: message id, lấy các tin cũ hơn"
// @Param        around query string false "Message id cần xem ngữ cảnh"
// @Success      200  {object}  MessagesSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/conversations/{id}/messages [get]
func (ctrl *Controller) Messages(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid conversation id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 50, 100)
	resp, err := ctrl.service.Messages(id, limit, c.Query("before"), c.Query("around"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
