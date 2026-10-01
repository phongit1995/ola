package wordchain

import (
	"ola-chat-server/internal/constants"
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
	limit := utils.ParseLimit(c, constants.WordChainMessagePageSize, constants.WordChainMessagePageMax)
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
// @Description  Send sessionId and turn of the word being answered; if the word changed meanwhile the move is rejected with 409 WORD_CHAIN_WORD_CHANGED and no guess is used
// @Param        request body MoveRequest true "Word"
// @Success      200  {object}  utils.BaseResponse[MoveResponse]
// @Failure      409  {object}  utils.APIError
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
// @Summary      Buy hints for the current word (costs KEN once per word, nothing is charged when no hint is found)
// @Description  Buying again for the same word returns the same hints with charged=false; 409 WORD_CHAIN_WORD_CHANGED when the word changed before payment
// @Tags         word-chain
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[HintResponse]
// @Failure      409  {object}  utils.APIError
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
// @Summary      Word chain leaderboard (top 10 by points or wins, all time or current day/week/month in GMT+7)
// @Tags         word-chain
// @Produce      json
// @Security     BearerAuth
// @Param        sort query string false "points (default) or wins"
// @Param        period query string false "all (default), day, week or month"
// @Success      200  {object}  utils.BaseResponse[LeaderboardResponse]
// @Router       /rooms/word-chain/leaderboard [get]
func (ctrl *Controller) Leaderboard(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Leaderboard(c.Request.Context(), userID, c.Query("sort"), c.Query("period"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Wins godoc
// @Summary      Word chain win history (newest first)
// @Tags         word-chain
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        before query string false "Win id to paginate before (nextBefore of the previous page)"
// @Param        mine query bool false "Only the current user's wins"
// @Success      200  {object}  utils.BaseResponse[WinListResponse]
// @Router       /rooms/word-chain/wins [get]
func (ctrl *Controller) Wins(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, constants.WordChainWinPageSize, constants.WordChainWinPageMax)
	resp, err := ctrl.service.Wins(c.Request.Context(), userID, c.Query("mine") == "true", c.Query("before"), limit)
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
