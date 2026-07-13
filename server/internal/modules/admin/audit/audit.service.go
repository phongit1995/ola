package adminaudit

import (
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Service struct {
	repo   *Repository
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, logger: logger.Named("[admin_audit_service]")}
}

type RecordInput struct {
	AdminID  uuid.UUID
	Method   string
	Resource string
	Path     string
	Route    string
	Status   int
	IP       string
	Detail   models.JSONB
}

func (s *Service) Record(in RecordInput) {
	log := &models.AdminAuditLog{
		AdminID:  in.AdminID,
		Method:   in.Method,
		Resource: in.Resource,
		Path:     in.Path,
		Route:    in.Route,
		Status:   in.Status,
		IP:       in.IP,
		Detail:   in.Detail,
	}
	if err := s.repo.Create(log); err != nil {
		s.logger.Errorw("failed to write admin audit log", "resource", in.Resource, "error", err)
	}
}

func (s *Service) List(f ListFilter) (*AuditLogListResponse, error) {
	rows, total, err := s.repo.List(f)
	if err != nil {
		return nil, err
	}
	items := make([]AuditLogItem, len(rows))
	for i, row := range rows {
		items[i] = AuditLogItem{
			ID:            row.ID.String(),
			AdminID:       row.AdminID.String(),
			AdminUsername: row.AdminUsername,
			AdminFullName: row.AdminFullName,
			Method:        row.Method,
			Resource:      row.Resource,
			Path:          row.Path,
			Route:         row.Route,
			Status:        row.Status,
			IP:            row.IP,
			Detail:        row.Detail,
			CreatedAt:     row.CreatedAt.Format(time.RFC3339),
		}
	}
	return &AuditLogListResponse{Items: items, Total: total, Limit: f.Limit, Offset: f.Offset}, nil
}
