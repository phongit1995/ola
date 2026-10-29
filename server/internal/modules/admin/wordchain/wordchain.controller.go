package adminwordchain

import (
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/modules/room/wordchain"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type Controller struct {
	service   *wordchain.Service
	purchases *PurchaseRepository
}

func NewController(service *wordchain.Service, purchases *PurchaseRepository) *Controller {
	return &Controller{service: service, purchases: purchases}
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
	limit := utils.ParseLimit(c, wordchain.WordChainMessagePageSize, wordchain.WordChainMessagePageMax)
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
	limit := utils.ParseLimit(c, wordchain.WordChainWinPageSize, wordchain.WordChainWinPageMax)
	resp, err := ctrl.service.AdminWins(c.Request.Context(), userID, c.Query("before"), limit)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func parseTimeQuery(c *gin.Context, key string) (*time.Time, error) {
	raw := c.Query(key)
	if raw == "" {
		return nil, nil
	}
	t, err := time.Parse(time.RFC3339, raw)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid "+key+" time")
	}
	return &t, nil
}

// Purchases godoc
// @Summary      Lịch sử mua gợi ý và mua lượt nối từ (admin, mới nhất trước)
// @Description  summary là tổng số giao dịch và KEN theo từng loại, tính trên cùng bộ lọc
// @Tags         admin-word-chain
// @Produce      json
// @Security     BearerAuth
// @Param        type query string false "hint | guess, bỏ trống là cả hai"
// @Param        search query string false "Tìm theo username hoặc tên"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size (mặc định 20, tối đa 100)"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[PurchaseListResponse]
// @Failure      400  {object}  utils.APIError
// @Router       /admin/word-chain/purchases [get]
func (ctrl *Controller) Purchases(c *gin.Context) (interface{}, error) {
	f := PurchaseFilter{Type: c.Query("type"), Search: strings.TrimSpace(c.Query("search"))}
	if f.Type != "" {
		if _, ok := purchaseTxTypes[f.Type]; !ok {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid purchase type")
		}
	}
	var err error
	if f.From, err = parseTimeQuery(c, "from"); err != nil {
		return nil, err
	}
	if f.To, err = parseTimeQuery(c, "to"); err != nil {
		return nil, err
	}
	resp, err := ctrl.purchases.List(f, utils.ParseLimit(c, 20, 100), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
