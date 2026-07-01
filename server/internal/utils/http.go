package utils

import (
	"errors"
	"net/http"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type AppHandler func(c *gin.Context) (interface{}, error)

type HandlerResult struct {
	Data       any
	StatusCode int
}

func NewHandlerResult(data any, statusCode int) *HandlerResult {
	return &HandlerResult{
		Data:       data,
		StatusCode: statusCode,
	}
}

type AppGroup struct {
	group *gin.RouterGroup
}

type ApiResponse struct {
	Success   bool        `json:"success"`
	Status    int         `json:"status"`
	TraceID   string      `json:"traceId"`
	Timestamp string      `json:"timestamp"`
	Path      string      `json:"path"`
	Data      interface{} `json:"data,omitempty"`
	Error     string      `json:"error,omitempty"`
}

type BaseResponse[T any] struct {
	Success   bool   `json:"success"`
	Status    int    `json:"status"`
	TraceID   string `json:"traceId"`
	Timestamp string `json:"timestamp"`
	Path      string `json:"path"`
	Data      T      `json:"data,omitempty"`
	Error     string `json:"error,omitempty"`
}

type APIError struct {
	Success   bool   `json:"success" example:"false"`
	Status    int    `json:"status" example:"400"`
	TraceID   string `json:"traceId" example:"550e8400-e29b-41d4-a716-446655440000"`
	Timestamp string `json:"timestamp" example:"2025-11-29T10:00:00Z"`
	Path      string `json:"path" example:"/api/v1/auth/login"`
	Error     string `json:"error" example:"validation error"`
}

type HTTPError struct {
	Status  int
	Message string
}

func (e *HTTPError) Error() string { return e.Message }

func NewHTTPError(status int, msg string) *HTTPError {
	return &HTTPError{Status: status, Message: msg}
}

func NewAppGroup(g *gin.RouterGroup) *AppGroup {
	return &AppGroup{group: g}
}

func (g *AppGroup) Use(middleware ...gin.HandlerFunc) {
	g.group.Use(middleware...)
}

func (g *AppGroup) Group(relativePath string, handlers ...gin.HandlerFunc) *AppGroup {
	return &AppGroup{group: g.group.Group(relativePath, handlers...)}
}

func (g *AppGroup) GET(path string, middlewareAndHandler ...any) {
	middleware, handler := extractMiddlewareAndHandler(middlewareAndHandler)
	handlers := append(middleware, wrap(handler))
	g.group.GET(path, handlers...)
}

func (g *AppGroup) POST(path string, middlewareAndHandler ...any) {
	middleware, handler := extractMiddlewareAndHandler(middlewareAndHandler)
	handlers := append(middleware, wrap(handler))
	g.group.POST(path, handlers...)
}

func (g *AppGroup) PUT(path string, middlewareAndHandler ...any) {
	middleware, handler := extractMiddlewareAndHandler(middlewareAndHandler)
	handlers := append(middleware, wrap(handler))
	g.group.PUT(path, handlers...)
}

func (g *AppGroup) DELETE(path string, middlewareAndHandler ...any) {
	middleware, handler := extractMiddlewareAndHandler(middlewareAndHandler)
	handlers := append(middleware, wrap(handler))
	g.group.DELETE(path, handlers...)
}

func (g *AppGroup) PATCH(path string, middlewareAndHandler ...any) {
	middleware, handler := extractMiddlewareAndHandler(middlewareAndHandler)
	handlers := append(middleware, wrap(handler))
	g.group.PATCH(path, handlers...)
}

func extractMiddlewareAndHandler(args []any) ([]gin.HandlerFunc, AppHandler) {
	if len(args) == 0 {
		panic("handler is required")
	}

	lastArg := args[len(args)-1]

	handler, ok := lastArg.(func(*gin.Context) (interface{}, error))
	if !ok {
		handler, ok = lastArg.(AppHandler)
		if !ok {
			panic("last argument must be AppHandler (func(*gin.Context) (interface{}, error))")
		}
	}

	var middleware []gin.HandlerFunc
	for i := 0; i < len(args)-1; i++ {
		if mw, ok := args[i].(gin.HandlerFunc); ok {
			middleware = append(middleware, mw)
		} else {
			panic("middleware must be gin.HandlerFunc")
		}
	}

	return middleware, handler
}

var (
	errorsUnauthorized = map[string]bool{
		"invalid username or password":        true,
		"invalid email or password":           true,
		"invalid or expired token":            true,
		"invalid or expired refresh token":    true,
		"refresh token has been revoked":      true,
		"authorization header required":       true,
		"invalid authorization header format": true,
		"invalid transfer password":           true,
	}

	errorsNotFound = map[string]bool{
		"user not found":                 true,
		"admin not found":                true,
		"room not found":                 true,
		"message not found":              true,
		"resource not found":             true,
		"friend request not found":       true,
		"friendship not found":           true,
		"block relationship not found":   true,
		"relationship not found":         true,
		"post not found":                 true,
		"comment not found":              true,
		"vip icon not found":             true,
		"vip package not found":          true,
		"vip shop item not found":        true,
		"egg pack not found":             true,
		"pen shot not found":             true,
		"marriage diary entry not found": true,
		"ken chest not found":            true,
	}

	errorsConflict = map[string]bool{
		"email already exists":                                           true,
		"username already exists":                                        true,
		"you are already friends":                                        true,
		"friend request already sent":                                    true,
		"vip already in shop":                                            true,
		"pen shot is no longer open":                                     true,
		"you have reached the maximum number of friends":                 true,
		"this user has reached the maximum number of friends":            true,
		"you have reached the maximum number of pending friend requests": true,
	}

	errorsForbidden = map[string]bool{
		"message is too old to delete":          true,
		"you can only delete your own messages": true,
		"admin access required":                 true,
		"admin account is disabled":             true,
		"account is disabled":                   true,
		"not a room member":                     true,
		"room is full":                          true,
		"room is disabled":                      true,
		"not your post":                         true,
		"not your comment":                      true,
		"post is too old to edit":               true,
		"vip is locked":                         true,
		"vip is in use":                         true,
		"vip does not belong to you":            true,
		"vip store is private":                  true,
		"you cannot catch your own pen":         true,
		"this pen is not yours":                 true,
		"you must be married to use the diary":  true,
		"diary entry does not belong to you":    true,
		"cannot propose to a blocked user":      true,
		"cannot transfer ken to a blocked user": true,
	}
)

func matchKnownError(msg string, table map[string]bool) bool {
	if table[msg] {
		return true
	}
	for key := range table {
		if strings.HasPrefix(msg, key+": ") {
			return true
		}
	}
	return false
}

func HTTPStatusFromError(err error) int {
	if err == nil {
		return http.StatusOK
	}

	msg := err.Error()

	if matchKnownError(msg, errorsUnauthorized) {
		return http.StatusUnauthorized
	}

	if matchKnownError(msg, errorsNotFound) {
		return http.StatusNotFound
	}

	if matchKnownError(msg, errorsConflict) {
		return http.StatusConflict
	}

	if matchKnownError(msg, errorsForbidden) {
		return http.StatusForbidden
	}

	return http.StatusBadRequest
}

func getOrCreateTraceID(c *gin.Context) string {
	traceID := c.GetHeader("X-Trace-Id")
	if traceID == "" {
		traceID = uuid.NewString()
	}
	c.Header("X-Trace-Id", traceID)
	return traceID
}

func RespondError(c *gin.Context, status int, message string) {
	traceID := getOrCreateTraceID(c)
	c.JSON(status, ApiResponse{
		Success:   false,
		Status:    status,
		TraceID:   traceID,
		Timestamp: time.Now().UTC().Format(time.RFC3339),
		Path:      c.Request.URL.Path,
		Error:     message,
	})
}

func wrap(h AppHandler) gin.HandlerFunc {
	return func(c *gin.Context) {
		traceID := getOrCreateTraceID(c)
		ts := time.Now().UTC().Format(time.RFC3339)
		path := c.Request.URL.Path

		result, err := h(c)
		if err != nil {
			var httpErr *HTTPError
			status := http.StatusInternalServerError
			msg := "internal server error"

			if errors.As(err, &httpErr) {
				status = httpErr.Status
				msg = httpErr.Message
			}

			c.JSON(status, ApiResponse{
				Success:   false,
				Status:    status,
				TraceID:   traceID,
				Timestamp: ts,
				Path:      path,
				Error:     msg,
			})
			return
		}

		status := http.StatusOK
		data := result

		if handlerResult, ok := result.(*HandlerResult); ok {
			status = handlerResult.StatusCode
			data = handlerResult.Data
		} else {
			switch c.Request.Method {
			case http.MethodPost:
				status = http.StatusCreated
			case http.MethodDelete:
				if result == nil {
					status = http.StatusNoContent
				} else {
					status = http.StatusOK
				}
			default:
				status = http.StatusOK
			}
		}

		if status == http.StatusNoContent {
			c.Status(status)
			return
		}

		c.JSON(status, ApiResponse{
			Success:   true,
			Status:    status,
			TraceID:   traceID,
			Timestamp: ts,
			Path:      path,
			Data:      data,
		})
	}
}
