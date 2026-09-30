package wordchain

import (
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

// Overview godoc
// @Summary      Get the word chain room, current session state and my points
// @Tags         word-chain
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[OverviewResponse]
// @Router       /rooms/word-chain [get]
func (ctrl *Controller) Overview(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Overview(c.Request.Context(), userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Messages godoc
// @Summary      List messages of the current session (newest first)
// @Tags         word-chain
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        before query string false "Message ID to paginate before"
// @Success      200  {object}  utils.BaseResponse[MessageListResponse]
// @Router       /rooms/word-chain/messages [get]
func (ctrl *Controller) Messages(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, MessagePageSize, MessagePageMax)
	resp, err := ctrl.service.Messages(c.Request.Context(), limit, c.Query("before"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Move godoc
// @Summary      Play a word in the word chain room
// @Tags         word-chain
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body MoveRequest true "Word"
// @Success      200  {object}  utils.BaseResponse[MoveResponse]
// @Router       /rooms/word-chain/moves [post]
func (ctrl *Controller) Move(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[MoveRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.HandleMove(c.Request.Context(), userID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Hint godoc
// @Summary      Buy hints for the current word (costs KEN, nothing is charged when no hint is found)
// @Tags         word-chain
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[HintResponse]
// @Router       /rooms/word-chain/hints [post]
func (ctrl *Controller) Hint(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Hint(c.Request.Context(), userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Leaderboard godoc
// @Summary      Word chain leaderboard (top 10 by points, one point per valid word)
// @Tags         word-chain
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[LeaderboardResponse]
// @Router       /rooms/word-chain/leaderboard [get]
func (ctrl *Controller) Leaderboard(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Leaderboard(c.Request.Context(), userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Lookup godoc
// @Summary      Look up a Vietnamese word (dict.minhqnd.com)
// @Tags         word-chain
// @Produce      json
// @Security     BearerAuth
// @Param        word query string true "Word"
// @Success      200  {object}  utils.BaseResponse[LookupResponse]
// @Router       /rooms/word-chain/lookup [get]
func (ctrl *Controller) Lookup(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Lookup(c.Request.Context(), userID, c.Query("word"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
