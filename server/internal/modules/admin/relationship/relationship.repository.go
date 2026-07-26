package adminrelationship

import (
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

type relationshipStatsRow struct {
	Total    int64 `gorm:"column:total"`
	Pending  int64 `gorm:"column:pending"`
	Accepted int64 `gorm:"column:accepted"`
	Rejected int64 `gorm:"column:rejected"`
	Blocked  int64 `gorm:"column:blocked"`
}

func (r *Repository) RelationshipStats(f StatsFilter) (relationshipStatsRow, error) {
	q := r.db.Table("relationships").Where("deleted_at IS NULL")
	if f.From != nil {
		q = q.Where("created_at >= ?", *f.From)
	}
	if f.To != nil {
		q = q.Where("created_at <= ?", *f.To)
	}
	var row relationshipStatsRow
	err := q.Select(`count(*) as total,
		count(*) filter (where status = ?) as pending,
		count(*) filter (where status = ?) as accepted,
		count(*) filter (where status = ?) as rejected,
		count(*) filter (where status = ?) as blocked`,
		models.RelationshipStatusPending,
		models.RelationshipStatusAccepted,
		models.RelationshipStatusRejected,
		models.RelationshipStatusBlocked,
	).Scan(&row).Error
	return row, err
}

func (r *Repository) FollowCount(f StatsFilter) (int64, error) {
	q := r.db.Table("follows")
	if f.From != nil {
		q = q.Where("created_at >= ?", *f.From)
	}
	if f.To != nil {
		q = q.Where("created_at <= ?", *f.To)
	}
	var total int64
	err := q.Count(&total).Error
	return total, err
}

func relationshipScope(f ListFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		db = db.Where("relationships.deleted_at IS NULL")
		if f.Status != "" {
			db = db.Where("relationships.status = ?", f.Status)
		}
		if f.UserID != nil {
			db = db.Where("(relationships.requester_id = ? OR relationships.addressee_id = ?)", *f.UserID, *f.UserID)
		}
		if f.From != nil {
			db = db.Where("relationships.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("relationships.created_at <= ?", *f.To)
		}
		return db
	}
}

type relationshipRow struct {
	ID                uuid.UUID  `gorm:"column:id"`
	RequesterID       uuid.UUID  `gorm:"column:requester_id"`
	AddresseeID       uuid.UUID  `gorm:"column:addressee_id"`
	Status            string     `gorm:"column:status"`
	CreatedAt         time.Time  `gorm:"column:created_at"`
	ActionedAt        *time.Time `gorm:"column:actioned_at"`
	RequesterUsername string     `gorm:"column:requester_username"`
	RequesterFullName string     `gorm:"column:requester_full_name"`
	RequesterAvatar   string     `gorm:"column:requester_avatar"`
	AddresseeUsername string     `gorm:"column:addressee_username"`
	AddresseeFullName string     `gorm:"column:addressee_full_name"`
	AddresseeAvatar   string     `gorm:"column:addressee_avatar"`
}

func (r *Repository) ListRelationships(f ListFilter, limit, offset int) ([]relationshipRow, int64, error) {
	var total int64
	if err := r.db.Table("relationships").Scopes(relationshipScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []relationshipRow
	err := r.db.Table("relationships").
		Select(`relationships.id, relationships.requester_id, relationships.addressee_id,
			relationships.status, relationships.created_at, relationships.actioned_at,
			requester.username AS requester_username, requester.full_name AS requester_full_name, requester.avatar AS requester_avatar,
			addressee.username AS addressee_username, addressee.full_name AS addressee_full_name, addressee.avatar AS addressee_avatar`).
		Joins("LEFT JOIN users AS requester ON requester.id = relationships.requester_id").
		Joins("LEFT JOIN users AS addressee ON addressee.id = relationships.addressee_id").
		Scopes(relationshipScope(f)).
		Order("relationships.created_at DESC, relationships.id DESC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}

func followScope(f FollowFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if f.FollowerID != nil {
			db = db.Where("follows.follower_id = ?", *f.FollowerID)
		}
		if f.FolloweeID != nil {
			db = db.Where("follows.followee_id = ?", *f.FolloweeID)
		}
		if f.UserID != nil {
			db = db.Where("(follows.follower_id = ? OR follows.followee_id = ?)", *f.UserID, *f.UserID)
		}
		if f.From != nil {
			db = db.Where("follows.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("follows.created_at <= ?", *f.To)
		}
		return db
	}
}

type followRow struct {
	ID               uuid.UUID `gorm:"column:id"`
	FollowerID       uuid.UUID `gorm:"column:follower_id"`
	FolloweeID       uuid.UUID `gorm:"column:followee_id"`
	CreatedAt        time.Time `gorm:"column:created_at"`
	FollowerUsername string    `gorm:"column:follower_username"`
	FollowerFullName string    `gorm:"column:follower_full_name"`
	FollowerAvatar   string    `gorm:"column:follower_avatar"`
	FolloweeUsername string    `gorm:"column:followee_username"`
	FolloweeFullName string    `gorm:"column:followee_full_name"`
	FolloweeAvatar   string    `gorm:"column:followee_avatar"`
}

func (r *Repository) ListFollows(f FollowFilter, limit, offset int) ([]followRow, int64, error) {
	var total int64
	if err := r.db.Table("follows").Scopes(followScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []followRow
	err := r.db.Table("follows").
		Select(`follows.id, follows.follower_id, follows.followee_id, follows.created_at,
			follower.username AS follower_username, follower.full_name AS follower_full_name, follower.avatar AS follower_avatar,
			followee.username AS followee_username, followee.full_name AS followee_full_name, followee.avatar AS followee_avatar`).
		Joins("LEFT JOIN users AS follower ON follower.id = follows.follower_id").
		Joins("LEFT JOIN users AS followee ON followee.id = follows.followee_id").
		Scopes(followScope(f)).
		Order("follows.created_at DESC, follows.id DESC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}

var userStatsSorts = map[string]string{
	"friends":   "friends",
	"blocked":   "blocked",
	"followers": "followers",
	"following": "following",
}

type userStatsRow struct {
	UserID    uuid.UUID `gorm:"column:user_id"`
	Username  string    `gorm:"column:username"`
	FullName  string    `gorm:"column:full_name"`
	Avatar    string    `gorm:"column:avatar"`
	Friends   int64     `gorm:"column:friends"`
	Blocked   int64     `gorm:"column:blocked"`
	Followers int64     `gorm:"column:followers"`
	Following int64     `gorm:"column:following"`
}

func (r *Repository) relationshipSideQuery(f UserStatsFilter, requester bool) *gorm.DB {
	uid := "requester_id"
	blocked := "CASE WHEN relationships.status = 'blocked' THEN 1 ELSE 0 END"
	if !requester {
		uid = "addressee_id"
		blocked = "0"
	}
	q := r.db.Table("relationships").
		Select(`relationships.` + uid + ` AS uid,
			CASE WHEN relationships.status = 'accepted' THEN 1 ELSE 0 END AS friends,
			` + blocked + ` AS blocked,
			0 AS followers, 0 AS following`).
		Where("relationships.deleted_at IS NULL")
	if f.From != nil {
		q = q.Where("relationships.created_at >= ?", *f.From)
	}
	if f.To != nil {
		q = q.Where("relationships.created_at <= ?", *f.To)
	}
	return q
}

func (r *Repository) followSideQuery(f UserStatsFilter, follower bool) *gorm.DB {
	uid, followers, following := "follower_id", "0", "1"
	if !follower {
		uid, followers, following = "followee_id", "1", "0"
	}
	q := r.db.Table("follows").
		Select(`follows.` + uid + ` AS uid, 0 AS friends, 0 AS blocked, ` + followers + ` AS followers, ` + following + ` AS following`)
	if f.From != nil {
		q = q.Where("follows.created_at >= ?", *f.From)
	}
	if f.To != nil {
		q = q.Where("follows.created_at <= ?", *f.To)
	}
	return q
}

func (r *Repository) UserStats(f UserStatsFilter, sortBy string, limit, offset int) ([]userStatsRow, int64, error) {
	base := func() *gorm.DB {
		q := r.db.Table("(? UNION ALL ? UNION ALL ? UNION ALL ?) AS t",
			r.relationshipSideQuery(f, true),
			r.relationshipSideQuery(f, false),
			r.followSideQuery(f, true),
			r.followSideQuery(f, false),
		)
		if f.UserID != nil {
			q = q.Where("t.uid = ?", *f.UserID)
		}
		return q
	}

	var total int64
	if err := base().Distinct("t.uid").Count(&total).Error; err != nil {
		return nil, 0, err
	}

	order, ok := userStatsSorts[sortBy]
	if !ok {
		order = "friends"
	}

	var rows []userStatsRow
	err := base().
		Select(`t.uid AS user_id, users.username, users.full_name, users.avatar,
			coalesce(sum(t.friends), 0) as friends,
			coalesce(sum(t.blocked), 0) as blocked,
			coalesce(sum(t.followers), 0) as followers,
			coalesce(sum(t.following), 0) as following`).
		Joins("LEFT JOIN users ON users.id = t.uid").
		Group("t.uid, users.username, users.full_name, users.avatar").
		Order(order + " DESC, t.uid ASC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}
