package chatbot

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strings"

	"ola-chat-server/internal/constants"
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
	return &Controller{service: service, logger: logger.Named("[chat_bot_controller]")}
}

func newCompletionID() string {
	return "chatbot-" + strings.ReplaceAll(uuid.NewString(), "-", "")[:12]
}

func httpStatusForError(err error) (int, string) {
	switch {
	case errors.Is(err, errEmptyPrompt):
		return http.StatusBadRequest, "chat bot prompt is empty"
	case errors.Is(err, ErrUpstreamRejected), errors.Is(err, ErrStreamChanged), errors.Is(err, ErrEmptyResponse):
		return http.StatusBadGateway, err.Error()
	default:
		return http.StatusBadGateway, "chat bot upstream unavailable"
	}
}

// Chat godoc
// @Summary      Chat với bot
// @Description  Body chỉ gồm `messages` và `stream`. Tính cách của bot do server tự gắn, client không cần gửi message `system`.
// @Description  `stream=false` (mặc định) trả JSON đầy đủ theo schema dưới đây.
// @Description  `stream=true` trả `text/event-stream`, mỗi frame là một dòng `data: <json>` rồi một dòng trống:
// @Description  - chunk nội dung: `{"id":"chatbot-...","delta":"Chào "}`
// @Description  - chunk cuối: `{"id":"...","finishReason":"stop"}`
// @Description  - nếu lỗi giữa stream: `{"id":"...","error":"..."}`
// @Description  - kết thúc: `data: [DONE]`
// @Description  Ghép toàn bộ `delta` theo thứ tự sẽ được câu trả lời đầy đủ.
// @Tags         chat-bot
// @Accept       json
// @Produce      json
// @Produce      text/event-stream
// @Security     BearerAuth
// @Param        request  body      CompletionRequest  true  "Hội thoại"
// @Success      200      {object}  utils.BaseResponse[CompletionResponse]
// @Failure      400      {object}  utils.APIError
// @Failure      401      {object}  utils.APIError
// @Failure      502      {object}  utils.APIError
// @Router       /chat-bot [post]
func (ctrl *Controller) Chat(c *gin.Context) {
	var req CompletionRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		utils.RespondError(c, http.StatusBadRequest, err.Error())
		return
	}

	if req.Stream {
		ctrl.stream(c, &req)
		return
	}

	result, prompt, err := ctrl.service.Complete(c.Request.Context(), &req)
	if err != nil {
		ctrl.logger.Errorw("chat bot completion failed", "promptLen", len(prompt), "error", err)
		status, msg := httpStatusForError(err)
		utils.RespondError(c, status, msg)
		return
	}

	result.ID = newCompletionID()
	utils.RespondSuccess(c, http.StatusOK, result)
}

func (ctrl *Controller) stream(c *gin.Context, req *CompletionRequest) {
	flusher, ok := c.Writer.(http.Flusher)
	if !ok {
		utils.RespondError(c, http.StatusInternalServerError, "streaming is not supported by this connection")
		return
	}

	completionID := newCompletionID()
	headerSent := false

	writeChunk := func(chunk StreamChunk) error {
		payload, err := json.Marshal(chunk)
		if err != nil {
			return err
		}
		if _, err := fmt.Fprintf(c.Writer, "data: %s\n\n", payload); err != nil {
			return err
		}
		flusher.Flush()
		return nil
	}

	prompt, full, err := ctrl.service.Stream(c.Request.Context(), req, func(delta string) error {
		if !headerSent {
			c.Writer.Header().Set("Content-Type", "text/event-stream")
			c.Writer.Header().Set("Cache-Control", "no-cache")
			c.Writer.Header().Set("Connection", "keep-alive")
			c.Writer.Header().Set("X-Accel-Buffering", "no")
			c.Writer.WriteHeader(http.StatusOK)
			headerSent = true
		}
		return writeChunk(StreamChunk{ID: completionID, Delta: delta})
	})

	if err != nil {
		if errors.Is(err, context.Canceled) || errors.Is(err, context.DeadlineExceeded) || errors.Is(err, errEmitAborted) {
			return
		}
		ctrl.logger.Errorw("chat bot stream failed", "promptLen", len(prompt), "streamed", len(full), "error", err)
		if !headerSent {
			status, msg := httpStatusForError(err)
			utils.RespondError(c, status, msg)
			return
		}
		_, message := httpStatusForError(err)
		if writeChunk(StreamChunk{ID: completionID, Error: message}) != nil {
			return
		}
		_, _ = fmt.Fprintf(c.Writer, "data: %s\n\n", constants.ChatBotSSEDoneMarker)
		flusher.Flush()
		return
	}

	if !headerSent {
		utils.RespondError(c, http.StatusBadGateway, ErrEmptyResponse.Error())
		return
	}

	_ = writeChunk(StreamChunk{
		ID:           completionID,
		FinishReason: constants.ChatBotFinishReasonStop,
	})
	_, _ = fmt.Fprintf(c.Writer, "data: %s\n\n", constants.ChatBotSSEDoneMarker)
	flusher.Flush()
}
