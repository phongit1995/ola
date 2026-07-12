package adminaudit

import (
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

type ListFilter struct {
	AdminID  *uuid.UUID
	Resource string
	Method   string
	From     *time.Time
	To       *time.Time
	Limit    int
	Offset   int
}

type AuditLogItem struct {
	ID            string       `json:"id"`
	AdminID       string       `json:"adminId"`
	AdminUsername string       `json:"adminUsername,omitempty"`
	AdminFullName string       `json:"adminFullName,omitempty"`
	Method        string       `json:"method"`
	Resource      string       `json:"resource"`
	Path          string       `json:"path"`
	Route         string       `json:"route,omitempty"`
	Status        int          `json:"status"`
	IP            string       `json:"ip,omitempty"`
	Detail        models.JSONB `json:"detail,omitempty"`
	CreatedAt     string       `json:"createdAt"`
}

type AuditLogListResponse struct {
	Items  []AuditLogItem `json:"items"`
	Total  int64          `json:"total"`
	Limit  int            `json:"limit"`
	Offset int            `json:"offset"`
}
