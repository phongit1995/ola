package utils

import (
	"errors"
	"net/http"

	"ola-chat-server/internal/apperr"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

func RequireUserID(c *gin.Context) (uuid.UUID, error) {
	v, exists := c.Get("user_id")
	if !exists {
		return uuid.Nil, NewHTTPError(http.StatusUnauthorized, "user not authenticated")
	}
	id, ok := v.(uuid.UUID)
	if !ok {
		return uuid.Nil, NewHTTPError(http.StatusUnauthorized, "user not authenticated")
	}
	return id, nil
}

func ParseUUIDParam(c *gin.Context, param, label string) (uuid.UUID, error) {
	id, err := uuid.Parse(c.Param(param))
	if err != nil {
		return uuid.Nil, NewHTTPError(http.StatusBadRequest, label)
	}
	return id, nil
}

func BindJSON[T any](c *gin.Context) (*T, error) {
	var req T
	if err := c.ShouldBindJSON(&req); err != nil {
		return nil, NewHTTPError(http.StatusBadRequest, err.Error())
	}
	return &req, nil
}

func ServiceError(err error) error {
	var httpErr *HTTPError
	if errors.As(err, &httpErr) {
		return httpErr
	}
	if status, known := KnownHTTPStatusFromMessage(err.Error()); known {
		return NewHTTPError(status, err.Error())
	}
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return NewHTTPError(http.StatusNotFound, "resource not found")
	}
	if apperr.IsDatabaseError(err) {
		return NewHTTPError(http.StatusInternalServerError, "internal server error")
	}
	return NewHTTPError(http.StatusBadRequest, err.Error())
}
