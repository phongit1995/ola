package message

import (
	"encoding/json"
	"net/http"
	"strconv"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

const (
	maxAudioWaveformSamples = 64
	maxClientMessageIDBytes = 64
)

func multipartClientMessageID(c *gin.Context) (string, error) {
	clientMsgID := c.PostForm("clientMsgId")
	if len(clientMsgID) > maxClientMessageIDBytes {
		return "", utils.NewHTTPError(http.StatusBadRequest, "invalid client message ID")
	}
	return clientMsgID, nil
}

func validateJSONMessageType(messageType string) error {
	if messageType == constants.MessageTypeImage || messageType == constants.MessageTypeAudio {
		return ErrMediaRequiresUpload
	}
	return nil
}

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{
		service: service,
		logger:  logger.Named("[message_controller]"),
	}
}

func (ctrl *Controller) messageHTTPError(err error, fallback, logMessage string) *utils.HTTPError {
	status := httpStatusForError(err)
	message := err.Error()
	if status == http.StatusInternalServerError {
		message = fallback
		ctrl.logger.Errorw(logMessage, "error", err)
	}
	if code := errorCodeForError(err); code != "" {
		return utils.NewHTTPErrorWithCode(status, message, code)
	}
	return utils.NewHTTPError(status, message)
}

// SendMessage godoc
// @Summary      Send message
// @Description  Send a message in a conversation
// @Tags         messages
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body SendMessageRequest true "Send Message"
// @Success      201  {object}  MessageSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /messages [post]
func (ctrl *Controller) SendMessage(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	req, err := utils.BindJSON[SendMessageRequest](c)
	if err != nil {
		return nil, err
	}
	if err := validateJSONMessageType(req.Type); err != nil {
		return nil, ctrl.messageHTTPError(err, "invalid message type", "Invalid JSON message type")
	}

	conversationID, err := uuid.Parse(req.ConversationID)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid conversation ID")
	}

	var replyToID *uuid.UUID
	if req.ReplyToID != nil && *req.ReplyToID != "" {
		parsed, err := uuid.Parse(*req.ReplyToID)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid reply to ID")
		}
		replyToID = &parsed
	}

	message, err := ctrl.service.SendMessage(userID, conversationID, req.Type, req.Content, req.Metadata, replyToID, req.ClientMsgID)
	if err != nil {
		return nil, ctrl.messageHTTPError(err, "failed to send message", "Failed to send message")
	}

	return message, nil
}

// SendDirectMessage godoc
// @Summary      Send direct message
// @Description  Send a message directly to a user (creates conversation if not exists)
// @Tags         messages
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body SendDirectMessageRequest true "Send Direct Message"
// @Success      201  {object}  MessageSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /messages/direct [post]
func (ctrl *Controller) SendDirectMessage(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	req, err := utils.BindJSON[SendDirectMessageRequest](c)
	if err != nil {
		return nil, err
	}
	if err := validateJSONMessageType(req.Type); err != nil {
		return nil, ctrl.messageHTTPError(err, "invalid message type", "Invalid direct JSON message type")
	}

	recipientID, err := uuid.Parse(req.RecipientID)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid recipient ID")
	}

	if userID == recipientID {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "cannot send message to yourself")
	}

	message, err := ctrl.service.SendDirectMessage(userID, recipientID, req.Type, req.Content, req.Metadata, req.ClientMsgID)
	if err != nil {
		return nil, ctrl.messageHTTPError(err, "failed to send message", "Failed to send direct message")
	}

	return message, nil
}

// GetMessages godoc
// @Summary      Get messages
// @Description  Get messages from a conversation with pagination
// @Tags         messages
// @Produce      json
// @Security     BearerAuth
// @Param        conversationId path string true "Conversation ID"
// @Param        limit query int false "Limit number of messages" default(50)
// @Param        before query string false "Get messages before this message ID (timeuuid)"
// @Success      200  {object}  MessagesListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /messages/{conversationId} [get]
func (ctrl *Controller) GetMessages(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	conversationID, err := utils.ParseUUIDParam(c, "conversationId", "invalid conversation ID")
	if err != nil {
		return nil, err
	}

	limit := utils.ParseLimit(c, 50, 200)

	var beforeMessageID *string
	if before := c.Query("before"); before != "" {
		beforeMessageID = &before
	}

	messages, err := ctrl.service.GetMessages(userID, conversationID, limit, beforeMessageID)
	if err != nil {
		ctrl.logger.Errorw("Failed to get messages", "error", err)
		return nil, utils.NewHTTPError(http.StatusInternalServerError, "failed to get messages")
	}

	return messages, nil
}

// UpdateMessage godoc
// @Summary      Update message
// @Description  Update message content (edit message)
// @Tags         messages
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        conversationId path string true "Conversation ID"
// @Param        messageId path string true "Message ID (timeuuid)"
// @Param        request body UpdateMessageRequest true "Update Message"
// @Success      200  {object}  MessageSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /messages/{conversationId}/{messageId} [patch]
func (ctrl *Controller) UpdateMessage(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	conversationID := c.Param("conversationId")
	messageID := c.Param("messageId")

	req, err := utils.BindJSON[UpdateMessageRequest](c)
	if err != nil {
		return nil, err
	}

	message, err := ctrl.service.UpdateMessage(userID, conversationID, messageID, req.Content)
	if err != nil {
		return nil, ctrl.messageHTTPError(err, "failed to update message", "Failed to update message")
	}

	return message, nil
}

// SendImageMessage godoc
// @Summary      Send image message
// @Description  Upload an image and create a message of type=image in one call (≤3MB jpeg/png/gif/webp)
// @Tags         messages
// @Accept       multipart/form-data
// @Produce      json
// @Security     BearerAuth
// @Param        file formData file true "Image file"
// @Param        conversationId formData string true "Conversation ID"
// @Param        clientMsgId formData string false "Idempotency key"
// @Success      201  {object}  MessageSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      413  {object}  utils.APIError
// @Failure      429  {object}  utils.APIError
// @Router       /messages/images [post]
func (ctrl *Controller) SendImageMessage(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	conversationID, err := uuid.Parse(c.PostForm("conversationId"))
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid conversation ID")
	}

	fileHeader, err := c.FormFile("file")
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "missing file")
	}

	clientMsgID, err := multipartClientMessageID(c)
	if err != nil {
		return nil, err
	}

	result, err := ctrl.service.SendImageMessage(c.Request.Context(), userID, conversationID, fileHeader, clientMsgID)
	if err != nil {
		return nil, ctrl.messageHTTPError(err, "failed to send image message", "Failed to send image message")
	}

	return result, nil
}

// SendAudioMessage godoc
// @Summary      Send audio message
// @Description  Upload voice recording and create a message of type=audio (≤10MB, ≤300s)
// @Tags         messages
// @Accept       multipart/form-data
// @Produce      json
// @Security     BearerAuth
// @Param        file formData file true "Audio file (webm/m4a/mp3/wav/ogg)"
// @Param        conversationId formData string true "Conversation ID"
// @Param        duration formData number true "Duration in seconds"
// @Param        waveform formData string false "JSON array of amplitudes (max 64 values)"
// @Param        replyToId formData string false "Message UUID being replied to"
// @Param        clientMsgId formData string false "Idempotency key"
// @Success      201  {object}  MessageSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      413  {object}  utils.APIError
// @Failure      429  {object}  utils.APIError
// @Router       /messages/audio [post]
func (ctrl *Controller) SendAudioMessage(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	conversationID, err := uuid.Parse(c.PostForm("conversationId"))
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid conversation ID")
	}

	fileHeader, err := c.FormFile("file")
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "missing file")
	}

	durationStr := c.PostForm("duration")
	duration, err := strconv.ParseFloat(durationStr, 64)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid duration")
	}
	if err := validateAudioDuration(duration); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid duration")
	}

	var waveform []float64
	if raw := c.PostForm("waveform"); raw != "" {
		if err := json.Unmarshal([]byte(raw), &waveform); err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid waveform")
		}
		if err := validateAudioWaveform(waveform, maxAudioWaveformSamples); err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid waveform")
		}
	}

	var replyToID *uuid.UUID
	if raw := c.PostForm("replyToId"); raw != "" {
		parsed, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid reply to ID")
		}
		replyToID = &parsed
	}

	clientMsgID, err := multipartClientMessageID(c)
	if err != nil {
		return nil, err
	}

	result, err := ctrl.service.SendAudioMessage(c.Request.Context(), userID, conversationID, fileHeader, duration, waveform, replyToID, clientMsgID)
	if err != nil {
		return nil, ctrl.messageHTTPError(err, "failed to send audio message", "Failed to send audio message")
	}

	return result, nil
}

// ToggleReaction godoc
// @Summary      Toggle reaction
// @Description  Toggle a reaction (LIKE/LOVE/HAHA/WOW/SAD/ANGRY) on a message. Idempotent per (user, message, type).
// @Tags         messages
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        conversationId path string true "Conversation ID"
// @Param        messageId path string true "Message ID (timeuuid)"
// @Param        request body ToggleReactionRequest true "Reaction type"
// @Success      200  {object}  MessageSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      429  {object}  utils.APIError
// @Router       /messages/{conversationId}/{messageId}/reactions [post]
func (ctrl *Controller) ToggleReaction(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	conversationID, err := utils.ParseUUIDParam(c, "conversationId", "invalid conversation ID")
	if err != nil {
		return nil, err
	}
	messageID := c.Param("messageId")

	req, err := utils.BindJSON[ToggleReactionRequest](c)
	if err != nil {
		return nil, err
	}

	result, err := ctrl.service.ToggleReaction(c.Request.Context(), userID, conversationID, messageID, req.Type)
	if err != nil {
		return nil, ctrl.messageHTTPError(err, "failed to toggle reaction", "Failed to toggle reaction")
	}
	return result, nil
}

// DeleteMessage godoc
// @Summary      Delete message
// @Description  Delete a message (soft delete)
// @Tags         messages
// @Produce      json
// @Security     BearerAuth
// @Param        conversationId path string true "Conversation ID"
// @Param        messageId path string true "Message ID (timeuuid)"
// @Success      200  {object}  SimpleSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /messages/{conversationId}/{messageId} [delete]
func (ctrl *Controller) DeleteMessage(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	conversationID := c.Param("conversationId")
	messageID := c.Param("messageId")

	if err := ctrl.service.DeleteMessage(userID, conversationID, messageID); err != nil {
		ctrl.logger.Warnw("Failed to delete message", "error", err)
		return nil, utils.ServiceError(err)
	}

	return map[string]string{"message": "Message deleted successfully"}, nil
}
