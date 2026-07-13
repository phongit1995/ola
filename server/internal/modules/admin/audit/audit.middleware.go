package adminaudit

import (
	"bytes"
	"encoding/json"
	"io"
	"net/http"
	"strings"

	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/models"

	"github.com/gin-gonic/gin"
)

const maxAuditBodyBytes = 4096

type Middleware struct {
	service *Service
}

func NewMiddleware(service *Service) *Middleware {
	return &Middleware{service: service}
}

func (m *Middleware) Record() gin.HandlerFunc {
	return func(c *gin.Context) {
		method := c.Request.Method
		if !isMutating(method) {
			c.Next()
			return
		}

		var bodyCopy []byte
		if strings.HasPrefix(c.ContentType(), "application/json") && c.Request.Body != nil {
			bodyCopy, _ = io.ReadAll(io.LimitReader(c.Request.Body, maxAuditBodyBytes))
			c.Request.Body = io.NopCloser(io.MultiReader(bytes.NewReader(bodyCopy), c.Request.Body))
		}

		c.Next()

		adminID, ok := middleware.GetAdminID(c)
		if !ok {
			return
		}
		status := c.Writer.Status()
		if status < 200 || status >= 300 {
			return
		}

		detail := models.JSONB{}
		if params := paramsMap(c); len(params) > 0 {
			detail["params"] = params
		}
		if query := queryMap(c); len(query) > 0 {
			detail["query"] = query
		}
		if body := parseBody(bodyCopy); body != nil {
			detail["body"] = body
		}

		m.service.Record(RecordInput{
			AdminID:  adminID,
			Method:   method,
			Resource: resourceFromPath(c.FullPath()),
			Path:     c.Request.URL.Path,
			Route:    c.FullPath(),
			Status:   status,
			IP:       c.ClientIP(),
			Detail:   detail,
		})
	}
}

func isMutating(method string) bool {
	switch method {
	case http.MethodPost, http.MethodPut, http.MethodPatch, http.MethodDelete:
		return true
	default:
		return false
	}
}

func resourceFromPath(route string) string {
	marker := "/admin/"
	idx := strings.Index(route, marker)
	if idx < 0 {
		return "admin"
	}
	rest := route[idx+len(marker):]
	if slash := strings.Index(rest, "/"); slash >= 0 {
		rest = rest[:slash]
	}
	if rest == "" {
		return "admin"
	}
	return rest
}

func paramsMap(c *gin.Context) map[string]string {
	out := map[string]string{}
	for _, p := range c.Params {
		out[p.Key] = p.Value
	}
	return out
}

func queryMap(c *gin.Context) map[string]string {
	out := map[string]string{}
	for key, vals := range c.Request.URL.Query() {
		if len(vals) > 0 {
			out[key] = vals[0]
		}
	}
	return out
}

func parseBody(raw []byte) map[string]interface{} {
	if len(raw) == 0 {
		return nil
	}
	var parsed map[string]interface{}
	if err := json.Unmarshal(raw, &parsed); err != nil {
		return nil
	}
	redact(parsed)
	return parsed
}

func redact(m map[string]interface{}) {
	for key, val := range m {
		lower := strings.ToLower(key)
		if strings.Contains(lower, "password") || strings.Contains(lower, "token") || strings.Contains(lower, "secret") {
			m[key] = "***"
			continue
		}
		if nested, ok := val.(map[string]interface{}); ok {
			redact(nested)
		}
	}
}
