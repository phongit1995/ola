package adminwordchain

import (
	"net/http"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/modules/room/wordchain"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type Controller struct {
	service *wordchain.Service
}

func NewController(service *wordchain.Service) *Controller {
	return &Controller{service: service}
}

// Overview godoc
// @Summary      Word chain room overview (admin): current word, words of the current game, player counts
// @Tags         admin-word-chain
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[wordchain.AdminOverviewResponse]
// @Router       /admin/word-chain [get]
func (ctrl *Controller) Overview(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.AdminOverview(c.Request.Context())
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Messages godoc
// @Summary      Word chain message history (admin, newest first)
// @Tags         admin-word-chain
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        before query string false "Message ID to paginate before (nextBefore of the previous page)"
// @Success      200  {object}  utils.BaseResponse[wordchain.MessageListResponse]
// @Router       /admin/word-chain/messages [get]
func (ctrl *Controller) Messages(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, constants.WordChainMessagePageSize, constants.WordChainMessagePageMax)
	resp, err := ctrl.service.AdminMessages(c.Request.Context(), limit, c.Query("before"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Wins godoc
// @Summary      Word chain win history (admin, newest first)
// @Tags         admin-word-chain
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        before query string false "Win id to paginate before (nextBefore of the previous page)"
// @Param        userId query string false "Only wins of this user"
// @Success      200  {object}  utils.BaseResponse[wordchain.WinListResponse]
// @Router       /admin/word-chain/wins [get]
func (ctrl *Controller) Wins(c *gin.Context) (interface{}, error) {
	var userID *uuid.UUID
	if raw := c.Query("userId"); raw != "" {
		parsed, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid user id")
		}
		userID = &parsed
	}
	limit := utils.ParseLimit(c, constants.WordChainWinPageSize, constants.WordChainWinPageMax)
	resp, err := ctrl.service.AdminWins(c.Request.Context(), userID, c.Query("before"), limit)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
