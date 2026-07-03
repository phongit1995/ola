package marriagediary

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
	return &Controller{service: service, logger: logger.Named("[marriage_diary_controller]")}
}

// List godoc
// @Summary      Danh sách nhật ký Box - Kết Hôn
// @Tags         marriage-diary
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  DiaryListSuccessResponse
// @Failure      403  {object}  utils.APIError
// @Router       /marriage/diary [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.List(userID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Create godoc
// @Summary      Viết Box - Kết Hôn
// @Tags         marriage-diary
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CreateDiaryRequest true "Diary entry"
// @Success      201  {object}  CreateDiarySuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Router       /marriage/diary [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[CreateDiaryRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Create(userID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Delete godoc
// @Summary      Xoá một bài Box - Kết Hôn
// @Tags         marriage-diary
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Diary entry ID"
// @Success      200  {object}  MessageSuccessResponse
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /marriage/diary/{id} [delete]
func (ctrl *Controller) Delete(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid diary entry id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Delete(userID, id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "diary entry deleted"}, nil
}
