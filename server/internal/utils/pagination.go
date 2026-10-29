package utils

import (
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

func ParseLimit(c *gin.Context, defaultLimit, maxLimit int) int {
	limit := defaultLimit
	if s := c.Query("limit"); s != "" {
		if n, err := strconv.Atoi(s); err == nil && n > 0 {
			limit = n
		}
	}
	if maxLimit > 0 && limit > maxLimit {
		limit = maxLimit
	}
	return limit
}

func ParseOffset(c *gin.Context) int {
	if s := c.Query("offset"); s != "" {
		if n, err := strconv.Atoi(s); err == nil && n >= 0 {
			return n
		}
	}
	return 0
}

func ParseOptionalBool(c *gin.Context, key string) *bool {
	switch c.Query(key) {
	case "true":
		t := true
		return &t
	case "false":
		f := false
		return &f
	default:
		return nil
	}
}

func ParseIntQuery(c *gin.Context, key string) *int {
	s := c.Query(key)
	if s == "" {
		return nil
	}
	n, err := strconv.Atoi(s)
	if err != nil {
		return nil
	}
	return &n
}

func ParseTimeQuery(c *gin.Context, key string) (*time.Time, error) {
	raw := c.Query(key)
	if raw == "" {
		return nil, nil
	}
	t, err := time.Parse(time.RFC3339, raw)
	if err != nil {
		return nil, NewHTTPError(http.StatusBadRequest, "invalid "+key+" time")
	}
	return &t, nil
}

func ParseTimeRange(c *gin.Context) (*time.Time, *time.Time, error) {
	from, err := ParseTimeQuery(c, "from")
	if err != nil {
		return nil, nil, err
	}
	to, err := ParseTimeQuery(c, "to")
	if err != nil {
		return nil, nil, err
	}
	return from, to, nil
}

func ParseUUIDQuery(c *gin.Context, key string) (*uuid.UUID, error) {
	raw := c.Query(key)
	if raw == "" {
		return nil, nil
	}
	id, err := uuid.Parse(raw)
	if err != nil {
		return nil, NewHTTPError(http.StatusBadRequest, "invalid "+key)
	}
	return &id, nil
}
