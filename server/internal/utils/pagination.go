package utils

import (
	"strconv"

	"github.com/gin-gonic/gin"
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
