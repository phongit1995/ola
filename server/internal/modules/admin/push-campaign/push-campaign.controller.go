package adminpushcampaign

import (
	"net/http"

	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/push"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_push_campaign_controller]")}
}

var audiences = map[string]bool{
	push.PushAudienceAll:  true,
	push.PushAudienceVIP:  true,
	push.PushAudienceUser: true,
}

// ListCampaigns godoc
// @Summary      List push campaigns (admin)
// @Tags         admin-push-campaign
// @Produce      json
// @Security     BearerAuth
// @Param        limit  query int false "Page size (default 20, max 100)"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[CampaignListResponse]
// @Router       /admin/push-campaigns [get]
func (ctrl *Controller) ListCampaigns(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.List(utils.ParseLimit(c, 20, 100), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Audience godoc
// @Summary      Count users and devices a push campaign would reach (admin)
// @Tags         admin-push-campaign
// @Produce      json
// @Security     BearerAuth
// @Param        audience query string true  "all, vip, user"
// @Param        username query string false "Username when audience=user"
// @Success      200  {object}  utils.BaseResponse[AudienceResponse]
// @Router       /admin/push-campaigns/audience [get]
func (ctrl *Controller) Audience(c *gin.Context) (interface{}, error) {
	audience := c.Query("audience")
	if !audiences[audience] {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid audience")
	}
	resp, err := ctrl.service.Audience(audience, c.Query("username"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// CreateCampaign godoc
// @Summary      Queue a push campaign (admin)
// @Tags         admin-push-campaign
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CreateCampaignRequest true "Campaign request"
// @Success      200  {object}  utils.BaseResponse[CampaignItem]
// @Router       /admin/push-campaigns [post]
func (ctrl *Controller) CreateCampaign(c *gin.Context) (interface{}, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	req, err := utils.BindJSON[CreateCampaignRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Create(c.Request.Context(), adminID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
