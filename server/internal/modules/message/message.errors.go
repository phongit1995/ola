package message

import (
	"errors"
	"net/http"
	"ola-chat-server/internal/modules/conversation"
)

var (
	ErrFileTooLarge     = errors.New("file too large")
	ErrRateLimit        = errors.New("upload rate limit exceeded")
	ErrNotMember        = errors.New("user is not a member of this conversation")
	ErrUnsupportedImage = errors.New("unsupported image type")
	ErrDecodeImage      = errors.New("failed to decode image")
	ErrInvalidMetadata  = errors.New("invalid image metadata")
	ErrMaxReactions     = errors.New("max reaction types per user reached")
	ErrReplyNotFound    = errors.New("replied message not found")
)

func httpStatusForError(err error) int {
	switch {
	case errors.Is(err, ErrFileTooLarge):
		return http.StatusRequestEntityTooLarge
	case errors.Is(err, ErrRateLimit):
		return http.StatusTooManyRequests
	case errors.Is(err, ErrNotMember), errors.Is(err, conversation.ErrBlocked), errors.Is(err, conversation.ErrNotAllowedToMessage), errors.Is(err, conversation.ErrDirectRecipientUnavailable):
		return http.StatusForbidden
	case errors.Is(err, ErrUnsupportedImage), errors.Is(err, ErrDecodeImage), errors.Is(err, ErrInvalidMetadata), errors.Is(err, ErrMaxReactions), errors.Is(err, ErrReplyNotFound):
		return http.StatusBadRequest
	}
	return http.StatusInternalServerError
}

func errorCodeForError(err error) string {
	switch {
	case errors.Is(err, conversation.ErrBlocked):
		return conversation.ErrorCodeMessageBlocked
	case errors.Is(err, conversation.ErrNotAllowedToMessage):
		return conversation.ErrorCodeMessageFriendsOnly
	case errors.Is(err, conversation.ErrDirectRecipientUnavailable):
		return conversation.ErrorCodeDirectRecipientUnavailable
	default:
		return ""
	}
}
