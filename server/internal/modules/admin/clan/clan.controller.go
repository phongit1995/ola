package adminclan

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
	return &Controller{service: service, logger: logger.Named("[admin_clan_controller]")}
}

// ListClans godoc
// @Summary      List clans (admin)
// @Tags         admin-clan
// @Produce      json
// @Security     BearerAuth
// @Param        q query string false "Search by handle"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[ClanListResponse]
// @Router       /admin/clans [get]
func (ctrl *Controller) ListClans(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.List(c.Query("q"), limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Members godoc
// @Summary      List clan members (admin)
// @Tags         admin-clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[MemberListResponse]
// @Router       /admin/clans/{id}/members [get]
func (ctrl *Controller) Members(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid clan id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.Members(id, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// DeleteClan godoc
// @Summary      Delete clan (admin)
// @Tags         admin-clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Success      200  {object}  map[string]string
// @Router       /admin/clans/{id} [delete]
func (ctrl *Controller) DeleteClan(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid clan id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Delete(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "clan deleted"}, nil
}
