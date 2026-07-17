package adminaudit

import (
	"ola-chat-server/internal/models"

	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) Create(log *models.AdminAuditLog) error {
	return r.db.Create(log).Error
}

func filterScope(f ListFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if f.AdminID != nil {
			db = db.Where("admin_audit_logs.admin_id = ?", *f.AdminID)
		}
		if f.Resource != "" {
			db = db.Where("admin_audit_logs.resource = ?", f.Resource)
		}
		if f.Method != "" {
			db = db.Where("admin_audit_logs.method = ?", f.Method)
		}
		if f.Route != "" {
			db = db.Where("admin_audit_logs.route LIKE ?", "%"+f.Route)
		}
		if f.From != nil {
			db = db.Where("admin_audit_logs.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("admin_audit_logs.created_at <= ?", *f.To)
		}
		return db
	}
}

type auditRow struct {
	models.AdminAuditLog
	AdminUsername string `gorm:"column:admin_username"`
	AdminFullName string `gorm:"column:admin_full_name"`
}

func (r *Repository) List(f ListFilter) ([]auditRow, int64, error) {
	var total int64
	if err := r.db.Model(&models.AdminAuditLog{}).Scopes(filterScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []auditRow
	err := r.db.Table("admin_audit_logs").
		Select("admin_audit_logs.*, admin_users.username as admin_username, admin_users.full_name as admin_full_name").
		Joins("LEFT JOIN admin_users ON admin_users.id = admin_audit_logs.admin_id").
		Scopes(filterScope(f)).
		Order("admin_audit_logs.created_at DESC").
		Limit(f.Limit).
		Offset(f.Offset).
		Scan(&rows).Error
	return rows, total, err
}
