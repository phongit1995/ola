package admindashboard

import (
	"fmt"
	"time"

	"ola-chat-server/internal/models"

	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func inRange(q OverviewQuery, column string) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		return db.Where(fmt.Sprintf("%s >= ? AND %s <= ?", column, column), q.From, q.To)
	}
}

func (r *Repository) count(model interface{}) (int64, error) {
	var n int64
	err := r.db.Model(model).Count(&n).Error
	return n, err
}

func (r *Repository) Totals() (Totals, error) {
	var t Totals
	var err error
	if t.Users, err = r.count(&models.User{}); err != nil {
		return t, err
	}
	if t.Posts, err = r.count(&models.Me{}); err != nil {
		return t, err
	}
	if t.Rooms, err = r.count(&models.Room{}); err != nil {
		return t, err
	}
	if err = r.db.Model(&models.User{}).Select("coalesce(sum(ken),0)").Scan(&t.KenInCirculation).Error; err != nil {
		return t, err
	}
	if err = r.db.Model(&models.User{}).Select("coalesce(sum(kisses),0)").Scan(&t.Kisses).Error; err != nil {
		return t, err
	}
	err = r.db.Model(&models.Marriage{}).Where("status = ?", models.MarriageStatusActive).Count(&t.ActiveMarriages).Error
	return t, err
}

func (r *Repository) CountUsersSince(since time.Time) (int64, error) {
	var n int64
	err := r.db.Model(&models.User{}).Where("created_at >= ?", since).Count(&n).Error
	return n, err
}

func (r *Repository) Users(q OverviewQuery) (UsersSection, error) {
	var s UsersSection
	var err error
	if err = r.db.Model(&models.User{}).Scopes(inRange(q, "created_at")).Count(&s.New).Error; err != nil {
		return s, err
	}
	if err = r.db.Model(&models.User{}).Where("last_login_at >= ? AND last_login_at <= ?", q.From, q.To).Count(&s.Active).Error; err != nil {
		return s, err
	}
	if err = r.db.Model(&models.User{}).Where("verified = ?", true).Count(&s.Verified).Error; err != nil {
		return s, err
	}

	type genderRow struct {
		Gender string
		Count  int64
	}
	var rows []genderRow
	if err = r.db.Model(&models.User{}).Select("gender, count(*) as count").Group("gender").Scan(&rows).Error; err != nil {
		return s, err
	}
	for _, row := range rows {
		if row.Gender == "female" {
			s.Female = row.Count
		} else {
			s.Male += row.Count
		}
	}
	return s, nil
}

func (r *Repository) Revenue(q OverviewQuery) (RevenueSection, error) {
	var s RevenueSection

	type sumCount struct {
		Sum   int64
		Count int64
	}
	var topup sumCount
	if err := r.db.Model(&models.KenTransaction{}).
		Scopes(inRange(q, "created_at")).
		Where("type = ?", models.KenTxTypeTopup).
		Select("coalesce(sum(amount),0) as sum, count(*) as count").
		Scan(&topup).Error; err != nil {
		return s, err
	}
	s.TopupKen = topup.Sum
	s.TopupCount = topup.Count

	var vip sumCount
	if err := r.db.Model(&models.VipPurchase{}).
		Scopes(inRange(q, "created_at")).
		Select("coalesce(sum(ken_price),0) as sum, count(*) as count").
		Scan(&vip).Error; err != nil {
		return s, err
	}
	s.VipRevenueKen = vip.Sum
	s.VipPurchases = vip.Count

	if err := r.db.Model(&models.KenTransaction{}).
		Scopes(inRange(q, "created_at")).
		Where("direction = ?", models.KenDirectionDebit).
		Select("type, coalesce(sum(amount),0) as amount, count(*) as count").
		Group("type").
		Order("amount DESC").
		Scan(&s.SpendByType).Error; err != nil {
		return s, err
	}
	return s, nil
}

func (r *Repository) Engagement(q OverviewQuery) (EngagementSection, error) {
	var s EngagementSection
	if err := r.db.Model(&models.Me{}).Scopes(inRange(q, "created_at")).Count(&s.NewPosts).Error; err != nil {
		return s, err
	}
	if err := r.db.Model(&models.MeComment{}).Scopes(inRange(q, "created_at")).Count(&s.Comments).Error; err != nil {
		return s, err
	}

	type reactionRow struct {
		Type  string
		Count int64
	}
	var rows []reactionRow
	if err := r.db.Model(&models.MeReaction{}).Scopes(inRange(q, "created_at")).
		Select("type, count(*) as count").Group("type").Scan(&rows).Error; err != nil {
		return s, err
	}
	for _, row := range rows {
		if row.Type == string(models.MeReactionDislike) {
			s.Dislikes = row.Count
		} else if row.Type == string(models.MeReactionLike) {
			s.Likes = row.Count
		}
	}
	return s, nil
}

func (r *Repository) Social(q OverviewQuery) (SocialSection, error) {
	var s SocialSection
	if err := r.db.Model(&models.Follow{}).Scopes(inRange(q, "created_at")).Count(&s.NewFollows).Error; err != nil {
		return s, err
	}
	if err := r.db.Model(&models.Relationship{}).Scopes(inRange(q, "created_at")).Count(&s.FriendRequests).Error; err != nil {
		return s, err
	}
	if err := r.db.Model(&models.Relationship{}).Scopes(inRange(q, "created_at")).
		Where("status = ?", models.RelationshipStatusAccepted).Count(&s.NewFriendships).Error; err != nil {
		return s, err
	}
	err := r.db.Model(&models.Marriage{}).Where("married_at >= ? AND married_at <= ?", q.From, q.To).Count(&s.NewMarriages).Error
	return s, err
}

func (r *Repository) Games(q OverviewQuery) (GamesSection, error) {
	var s GamesSection
	if err := r.db.Model(&models.EggDraw{}).Scopes(inRange(q, "created_at")).Count(&s.EggDraws).Error; err != nil {
		return s, err
	}
	if err := r.db.Model(&models.WheelSpin{}).Scopes(inRange(q, "created_at")).Count(&s.WheelSpins).Error; err != nil {
		return s, err
	}
	err := r.db.Model(&models.PenShot{}).Scopes(inRange(q, "created_at")).Count(&s.PenShots).Error
	return s, err
}

type seriesRow struct {
	Date  string
	Value int64
}

func (r *Repository) series(q OverviewQuery, bucket string, model interface{}, dateColumn, valueExpr string, where func(*gorm.DB) *gorm.DB) ([]seriesRow, error) {
	trunc, format := "day", "YYYY-MM-DD"
	if bucket == "month" {
		trunc, format = "month", "YYYY-MM"
	}
	query := r.db.Model(model).
		Where(fmt.Sprintf("%s >= ? AND %s <= ?", dateColumn, dateColumn), q.From, q.To).
		Select(fmt.Sprintf("to_char(date_trunc('%s', %s), '%s') as date, %s as value", trunc, dateColumn, format, valueExpr)).
		Group(fmt.Sprintf("date_trunc('%s', %s)", trunc, dateColumn)).
		Order(fmt.Sprintf("date_trunc('%s', %s) ASC", trunc, dateColumn))
	if where != nil {
		query = where(query)
	}
	var rows []seriesRow
	err := query.Scan(&rows).Error
	return rows, err
}

func (r *Repository) SignupSeries(q OverviewQuery, bucket string) ([]seriesRow, error) {
	return r.series(q, bucket, &models.User{}, "created_at", "count(*)", nil)
}

func (r *Repository) PostSeries(q OverviewQuery, bucket string) ([]seriesRow, error) {
	return r.series(q, bucket, &models.Me{}, "created_at", "count(*)", nil)
}

func (r *Repository) TopupSeries(q OverviewQuery, bucket string) ([]seriesRow, error) {
	return r.series(q, bucket, &models.KenTransaction{}, "created_at", "coalesce(sum(amount),0)", func(db *gorm.DB) *gorm.DB {
		return db.Where("type = ?", models.KenTxTypeTopup)
	})
}

func (r *Repository) VipRevenueSeries(q OverviewQuery, bucket string) ([]seriesRow, error) {
	return r.series(q, bucket, &models.VipPurchase{}, "created_at", "coalesce(sum(ken_price),0)", nil)
}
