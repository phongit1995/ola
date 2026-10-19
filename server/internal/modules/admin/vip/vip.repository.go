package adminvip

import (
	"fmt"
	"strings"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/vip"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

const giverExpr = "CASE WHEN vp.source = 'gift' THEN kt.user_id END"

func rangeScope(from, to *time.Time) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if from != nil {
			db = db.Where("vp.created_at >= ?", *from)
		}
		if to != nil {
			db = db.Where("vp.created_at <= ?", *to)
		}
		return db
	}
}

func purchaseScope(f PurchaseFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		switch f.Kind {
		case PurchaseKindPackage:
			db = db.Where(vip.PurchaseIsPackageSQL)
		case PurchaseKindIcon:
			db = db.Where("NOT (" + vip.PurchaseIsPackageSQL + ")")
		}
		switch f.Mode {
		case PurchaseModeGift:
			db = db.Where("vp.source = ?", vip.PurchaseSourceGift)
		case PurchaseModeSelf:
			db = db.Where("vp.source <> ?", vip.PurchaseSourceGift)
		}
		if search := strings.TrimPrefix(f.Search, "@"); search != "" {
			like := "%" + search + "%"
			db = db.Joins("LEFT JOIN users u ON u.id = vp.user_id").
				Joins("LEFT JOIN users g ON g.id = kt.user_id").
				Where("(u.username ILIKE ? OR u.full_name ILIKE ? OR g.username ILIKE ?)", like, like, like)
		}
		return rangeScope(f.From, f.To)(db)
	}
}

type purchaseRow struct {
	ID              uuid.UUID  `gorm:"column:id"`
	UserID          uuid.UUID  `gorm:"column:user_id"`
	PackageID       *uuid.UUID `gorm:"column:package_id"`
	PackageName     string     `gorm:"column:package_name"`
	Days            int        `gorm:"column:days"`
	Source          string     `gorm:"column:source"`
	VipEndTimeAfter time.Time  `gorm:"column:vip_end_time_after"`
	KenPaid         int64      `gorm:"column:ken_paid"`
	GiverID         *uuid.UUID `gorm:"column:giver_id"`
	CreatedAt       time.Time  `gorm:"column:created_at"`
}

func (r *Repository) ListPurchases(f PurchaseFilter, limit, offset int) ([]purchaseRow, int64, error) {
	var total int64
	if err := vip.BoughtPurchases(r.db).Scopes(purchaseScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []purchaseRow
	err := vip.BoughtPurchases(r.db).Scopes(purchaseScope(f)).
		Select(fmt.Sprintf("vp.id, vp.user_id, vp.package_id, vp.package_name, vp.days, vp.source, vp.vip_end_time_after, vp.created_at, %s AS ken_paid, %s AS giver_id", vip.PurchasePaidExpr, giverExpr)).
		Order("vp.created_at DESC, vp.id DESC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}

type totalsRow struct {
	Count        int64 `gorm:"column:count"`
	Ken          int64 `gorm:"column:ken"`
	PackageCount int64 `gorm:"column:package_count"`
	PackageKen   int64 `gorm:"column:package_ken"`
	IconCount    int64 `gorm:"column:icon_count"`
	IconKen      int64 `gorm:"column:icon_ken"`
	GiftCount    int64 `gorm:"column:gift_count"`
	Buyers       int64 `gorm:"column:buyers"`
}

func (r *Repository) PurchaseTotals(from, to *time.Time) (totalsRow, error) {
	paid, pkg := vip.PurchasePaidExpr, vip.PurchaseIsPackageSQL
	var row totalsRow
	err := vip.BoughtPurchases(r.db).Scopes(rangeScope(from, to)).
		Select(fmt.Sprintf(`count(*) AS count,
			coalesce(sum(%[1]s),0) AS ken,
			count(*) FILTER (WHERE %[2]s) AS package_count,
			coalesce(sum(%[1]s) FILTER (WHERE %[2]s),0) AS package_ken,
			count(*) FILTER (WHERE NOT (%[2]s)) AS icon_count,
			coalesce(sum(%[1]s) FILTER (WHERE NOT (%[2]s)),0) AS icon_ken,
			count(*) FILTER (WHERE vp.source = '%[3]s') AS gift_count,
			count(DISTINCT %[4]s) AS buyers`, paid, pkg, vip.PurchaseSourceGift, vip.PurchasePayerExpr)).
		Scan(&row).Error
	return row, err
}

type seriesRow struct {
	Date       string `gorm:"column:date"`
	PackageKen int64  `gorm:"column:package_ken"`
	IconKen    int64  `gorm:"column:icon_ken"`
	Count      int64  `gorm:"column:count"`
}

func (r *Repository) PurchaseSeries(from, to time.Time, bucket string) ([]seriesRow, error) {
	trunc, format := "day", "YYYY-MM-DD"
	if bucket == "month" {
		trunc, format = "month", "YYYY-MM"
	}
	paid, pkg := vip.PurchasePaidExpr, vip.PurchaseIsPackageSQL
	var rows []seriesRow
	err := vip.BoughtPurchases(r.db).Scopes(rangeScope(&from, &to)).
		Select(fmt.Sprintf(`to_char(date_trunc('%[1]s', vp.created_at), '%[2]s') AS date,
			coalesce(sum(%[3]s) FILTER (WHERE %[4]s),0) AS package_ken,
			coalesce(sum(%[3]s) FILTER (WHERE NOT (%[4]s)),0) AS icon_ken,
			count(*) AS count`, trunc, format, paid, pkg)).
		Group(fmt.Sprintf("date_trunc('%s', vp.created_at)", trunc)).
		Order(fmt.Sprintf("date_trunc('%s', vp.created_at) ASC", trunc)).
		Scan(&rows).Error
	return rows, err
}

type breakdownRow struct {
	IsPackage bool   `gorm:"column:is_package"`
	Name      string `gorm:"column:name"`
	Count     int64  `gorm:"column:count"`
	GiftCount int64  `gorm:"column:gift_count"`
	Ken       int64  `gorm:"column:ken"`
}

func (r *Repository) PurchaseBreakdown(from, to time.Time) ([]breakdownRow, error) {
	pkg := vip.PurchaseIsPackageSQL
	var rows []breakdownRow
	err := vip.BoughtPurchases(r.db).Scopes(rangeScope(&from, &to)).
		Select(fmt.Sprintf(`%[1]s AS is_package, vp.package_name AS name, count(*) AS count,
			count(*) FILTER (WHERE vp.source = '%[2]s') AS gift_count,
			coalesce(sum(%[3]s),0) AS ken`, pkg, vip.PurchaseSourceGift, vip.PurchasePaidExpr)).
		Group(fmt.Sprintf("%s, vp.package_name", pkg)).
		Order("ken DESC, count DESC").
		Scan(&rows).Error
	return rows, err
}

func (r *Repository) CountActiveVipUsers(now time.Time) (int64, error) {
	var n int64
	err := r.db.Model(&models.User{}).Where("vip_end_time > ?", now).Count(&n).Error
	return n, err
}

func (r *Repository) FindUsersByIDs(ids []uuid.UUID) (map[uuid.UUID]models.User, error) {
	result := make(map[uuid.UUID]models.User, len(ids))
	if len(ids) == 0 {
		return result, nil
	}
	var users []models.User
	if err := r.db.Unscoped().
		Select("id", "username", "full_name", "avatar").
		Where("id IN ?", ids).
		Find(&users).Error; err != nil {
		return nil, err
	}
	for i := range users {
		result[users[i].ID] = users[i]
	}
	return result, nil
}
