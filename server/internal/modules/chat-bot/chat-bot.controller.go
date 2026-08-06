package chatbot

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"strings"
	"unicode/utf8"

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

func validateMessageLengths(messages []Message) error {
	for index := range messages {
		limit := constants.ChatBotMaxUserContentRunes
		if messages[index].Role == constants.ChatBotRoleAssistant {
			limit = constants.ChatBotMaxAssistantContentRunes
		}
		if utf8.RuneCountInString(messages[index].Content) > limit {
			return fmt.Errorf("messages[%d].content exceeds %d characters", index, limit)
		}
	}
	return nil
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
// @Description  Body gồm `messages`, `type` và `stream`. Tính cách của bot do server tự gắn theo `type` (OLALA mặc định, OLAVI là thầy tử vi); client không gửi được message `system`.
// @Description  `stream=false` (mặc định) trả JSON đầy đủ theo schema dưới đây.
// @Description  `stream=true` trả `text/event-stream`, mỗi frame là một dòng `data: <json>` rồi một dòng trống:
// @Description  - chunk nội dung: `{"id":"chatbot-...","delta":"Chào "}`
// @Description  - chunk cuối: `{"id":"...","finishReason":"stop"}`
// @Description  - nếu lỗi giữa stream: `{"id":"...","error":"..."}`
// @Description  - kết thúc: `data: [DONE]`
// @Description  Ghép toàn bộ `delta` theo thứ tự sẽ được câu trả lời đầy đủ.
// @Description  Có dòng `: ping` xen giữa các frame để giữ kết nối, client bỏ qua dòng không bắt đầu bằng `data: `.
// @Description  Giới hạn: tối đa 80 message, 4000 ký tự cho `user`, 32000 ký tự cho `assistant`, toàn bộ body 2MB (vượt trả 413).
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
	c.Request.Body = http.MaxBytesReader(c.Writer, c.Request.Body, constants.ChatBotMaxRequestBytes)

	var req CompletionRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		var tooLarge *http.MaxBytesError
		if errors.As(err, &tooLarge) {
			utils.RespondError(c, http.StatusRequestEntityTooLarge, "chat bot request body is too large")
			return
		}
		utils.RespondError(c, http.StatusBadRequest, err.Error())
		return
	}

	if err := validateMessageLengths(req.Messages); err != nil {
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
	session, ok := newSSESession(c)
	if !ok {
		utils.RespondError(c, http.StatusInternalServerError, "streaming is not supported by this connection")
		return
	}

	completionID := newCompletionID()

	stopHeartbeat := session.startHeartbeat(c.Request.Context())
	defer stopHeartbeat()

	prompt, full, err := ctrl.service.Stream(c.Request.Context(), req, func(delta string) error {
		return session.writeChunk(StreamChunk{ID: completionID, Delta: delta})
	})

	if err != nil {
		if errors.Is(err, context.Canceled) || errors.Is(err, context.DeadlineExceeded) || errors.Is(err, errEmitAborted) {
			return
		}
		ctrl.logger.Errorw("chat bot stream failed", "promptLen", len(prompt), "streamed", len(full), "error", err)
		_, message := httpStatusForError(err)
		session.fail(completionID, message)
		return
	}

	// Header SSE đã gửi từ đầu nên không còn trả 502 được; upstream im lặng phải
	// thành error frame, nếu không client nhận "stop" với nội dung rỗng và mất nút thử lại.
	if strings.TrimSpace(full) == "" {
		ctrl.logger.Errorw("chat bot stream returned empty content", "promptLen", len(prompt))
		_, message := httpStatusForError(ErrEmptyResponse)
		session.fail(completionID, message)
		return
	}

	session.finish(completionID)
}
