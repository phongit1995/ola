package adminvip

import (
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/vip"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

const monthlyBucketThreshold = 62 * 24 * time.Hour

type Service struct {
	repo   *Repository
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, logger: logger.Named("[admin_vip_service]")}
}

func (s *Service) ListPurchases(f PurchaseFilter, limit, offset int) (*PurchaseListResponse, error) {
	rows, total, err := s.repo.ListPurchases(f, limit, offset)
	if err != nil {
		return nil, err
	}

	idSet := make(map[uuid.UUID]struct{}, len(rows)*2)
	for i := range rows {
		idSet[rows[i].UserID] = struct{}{}
		if rows[i].GiverID != nil {
			idSet[*rows[i].GiverID] = struct{}{}
		}
	}
	ids := make([]uuid.UUID, 0, len(idSet))
	for id := range idSet {
		ids = append(ids, id)
	}
	users, err := s.repo.FindUsersByIDs(ids)
	if err != nil {
		return nil, err
	}

	items := make([]PurchaseItem, 0, len(rows))
	for i := range rows {
		items = append(items, toPurchaseItem(&rows[i], users))
	}
	return &PurchaseListResponse{Total: total, Limit: limit, Offset: offset, Items: items}, nil
}

func (s *Service) PurchaseStats(from, to time.Time) (*PurchaseStatsResponse, error) {
	bucket := "day"
	if to.Sub(from) > monthlyBucketThreshold {
		bucket = "month"
	}

	now := time.Now()
	startOfDay := time.Date(now.Year(), now.Month(), now.Day(), 0, 0, 0, 0, now.Location())
	startOfMonth := time.Date(now.Year(), now.Month(), 1, 0, 0, 0, 0, now.Location())

	today, err := s.repo.PurchaseTotals(&startOfDay, nil)
	if err != nil {
		return nil, err
	}
	thisMonth, err := s.repo.PurchaseTotals(&startOfMonth, nil)
	if err != nil {
		return nil, err
	}
	inRange, err := s.repo.PurchaseTotals(&from, &to)
	if err != nil {
		return nil, err
	}
	activeVip, err := s.repo.CountActiveVipUsers(now)
	if err != nil {
		return nil, err
	}
	seriesRows, err := s.repo.PurchaseSeries(from, to, bucket)
	if err != nil {
		return nil, err
	}
	breakdownRows, err := s.repo.PurchaseBreakdown(from, to)
	if err != nil {
		return nil, err
	}

	series := make([]PurchaseSeriesItem, len(seriesRows))
	for i, row := range seriesRows {
		series[i] = PurchaseSeriesItem{Date: row.Date, PackageKen: row.PackageKen, IconKen: row.IconKen, Count: row.Count}
	}
	breakdown := make([]PurchaseBreakdownItem, len(breakdownRows))
	for i, row := range breakdownRows {
		item := PurchaseBreakdownItem{
			Kind:      PurchaseKindPackage,
			Name:      row.Name,
			Count:     row.Count,
			GiftCount: row.GiftCount,
			Ken:       row.Ken,
		}
		if !row.IsPackage {
			item.Kind = PurchaseKindIcon
			item.VipIconID = vip.IconIDFromPurchaseName(row.Name)
		}
		breakdown[i] = item
	}

	return &PurchaseStatsResponse{
		Bucket:         bucket,
		Today:          toPurchaseTotals(today),
		ThisMonth:      toPurchaseTotals(thisMonth),
		Range:          toPurchaseTotals(inRange),
		ActiveVipUsers: activeVip,
		Series:         series,
		Breakdown:      breakdown,
	}, nil
}

func toPurchaseTotals(row totalsRow) PurchaseTotals {
	return PurchaseTotals{
		Count:        row.Count,
		Ken:          row.Ken,
		PackageCount: row.PackageCount,
		PackageKen:   row.PackageKen,
		IconCount:    row.IconCount,
		IconKen:      row.IconKen,
		GiftCount:    row.GiftCount,
		Buyers:       row.Buyers,
	}
}

func toUserInfo(users map[uuid.UUID]models.User, id uuid.UUID) *UserInfo {
	u, ok := users[id]
	if !ok {
		return nil
	}
	return &UserInfo{ID: u.ID.String(), Username: u.Username, FullName: u.FullName, Avatar: u.Avatar}
}

func toPurchaseItem(row *purchaseRow, users map[uuid.UUID]models.User) PurchaseItem {
	item := PurchaseItem{
		ID:        row.ID.String(),
		Kind:      PurchaseKindPackage,
		Source:    row.Source,
		Name:      row.PackageName,
		Days:      row.Days,
		KenPaid:   row.KenPaid,
		User:      toUserInfo(users, row.UserID),
		CreatedAt: row.CreatedAt.UTC().Format(time.RFC3339),
	}
	if row.PackageID == nil {
		item.Kind = PurchaseKindIcon
		item.VipIconID = vip.IconIDFromPurchaseName(row.PackageName)
	} else {
		item.VipEndTime = row.VipEndTimeAfter.UTC().Format(time.RFC3339)
	}
	if row.GiverID != nil {
		item.Giver = toUserInfo(users, *row.GiverID)
	}
	return item
}
