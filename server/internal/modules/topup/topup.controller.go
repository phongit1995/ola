package topup

import (
	"crypto/subtle"
	"encoding/json"
	"errors"
	"io"
	"net/http"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

const maxWebhookBodyBytes = 1 << 20

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[topup_controller]")}
}

// BankWebhook godoc
// @Summary      Webhook SieuThiCode nhận giao dịch ngân hàng để tự động cộng KEN
// @Tags         topup
// @Accept       json
// @Produce      json
// @Param        signature  header  string  true  "SieuThiCode webhook secret"
// @Success      200  {object}  WebhookResponse
// @Failure      401  {object}  WebhookResponse
// @Router       /topup/webhook/sieuthicode [post]
func (ctrl *Controller) BankWebhook(c *gin.Context) {
	secret, err := ctrl.service.WebhookSecret()
	if err != nil {
		ctrl.logger.Errorw("Failed to load webhook secret", "error", err.Error())
		c.JSON(http.StatusInternalServerError, WebhookResponse{Status: false, Msg: "Internal error"})
		return
	}
	signature := c.GetHeader("signature")
	if secret == "" || subtle.ConstantTimeCompare([]byte(signature), []byte(secret)) != 1 {
		ctrl.logger.Warnw("Topup webhook rejected: invalid signature", "ip", c.ClientIP())
		c.JSON(http.StatusUnauthorized, WebhookResponse{Status: false, Msg: "Chữ ký không hợp lệ"})
		return
	}

	c.Request.Body = http.MaxBytesReader(c.Writer, c.Request.Body, maxWebhookBodyBytes)
	body, err := io.ReadAll(c.Request.Body)
	if err != nil {
		var maxErr *http.MaxBytesError
		if errors.As(err, &maxErr) {
			c.JSON(http.StatusRequestEntityTooLarge, WebhookResponse{Status: false, Msg: "Body too large"})
			return
		}
		c.JSON(http.StatusBadRequest, WebhookResponse{Status: false, Msg: "Bad request"})
		return
	}

	var req WebhookRequest
	if err := json.Unmarshal(body, &req); err != nil {
		ctrl.logger.Warnw("Topup webhook bad payload", "error", err.Error())
		c.JSON(http.StatusBadRequest, WebhookResponse{Status: false, Msg: "Bad request"})
		return
	}

	failed := 0
	for _, wtx := range req.Transactions {
		if err := ctrl.service.ProcessTransaction(wtx); err != nil {
			failed++
		}
	}
	if failed > 0 {
		ctrl.logger.Errorw("Topup webhook processed with failures", "failed", failed, "total", len(req.Transactions))
		c.JSON(http.StatusInternalServerError, WebhookResponse{Status: false, Msg: "Internal error"})
		return
	}

	c.JSON(http.StatusOK, WebhookResponse{Status: true, Msg: "OK"})
}
