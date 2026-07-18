package me

import (
	"encoding/json"
	"errors"
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

func (r *Repository) Create(post *models.Me) error {
	return r.db.Create(post).Error
}

func (r *Repository) Save(post *models.Me) error {
	return r.db.Save(post).Error
}

func (r *Repository) UpdateEditable(post *models.Me) error {
	return r.db.Model(post).
		Select("Content", "Images", "Mentions", "CheckIn", "Sticker", "Visibility").
		Updates(post).Error
}

func (r *Repository) GetByID(id uuid.UUID) (*models.Me, error) {
	var post models.Me
	if err := r.db.Preload("Author").Preload("Clan").First(&post, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &post, nil
}

func (r *Repository) Disable(id uuid.UUID) error {
	return r.db.Model(&models.Me{}).Where("id = ?", id).Update("enabled", false).Error
}

func (r *Repository) paginate(db *gorm.DB, limit, offset int) ([]*models.Me, int64, error) {
	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var posts []*models.Me
	if err := db.Preload("Author").Preload("Clan").Order("pinned_at DESC NULLS LAST").Order("created_at DESC").Limit(limit).Offset(offset).Find(&posts).Error; err != nil {
		return nil, 0, err
	}
	return posts, total, nil
}

const clanVisibleCond = "me.clan_id IS NULL"

const clanVisibleCondAliasM = "m.clan_id IS NULL"

func (r *Repository) SetPinned(authorID, postID uuid.UUID, pinned bool) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&models.Me{}).
			Where("author_id = ? AND pinned_at IS NOT NULL", authorID).
			Update("pinned_at", nil).Error; err != nil {
			return err
		}
		if !pinned {
			return nil
		}
		now := time.Now()
		return tx.Model(&models.Me{}).
			Where("id = ? AND author_id = ?", postID, authorID).
			Update("pinned_at", now).Error
	})
}

func (r *Repository) ListByAuthor(authorID uuid.UUID, visibilities []models.MeVisibility, limit, offset int) ([]*models.Me, int64, error) {
	db := r.db.Model(&models.Me{}).
		Where("author_id = ? AND enabled = ? AND visibility IN ?", authorID, true, visibilities).
		Where(clanVisibleCond)
	return r.paginate(db, limit, offset)
}

type PhotoRow struct {
	URL       string
	Width     int
	Height    int
	MimeType  string
	PostID    uuid.UUID
	CreatedAt time.Time
}

func (r *Repository) ListPhotosByAuthor(authorID uuid.UUID, visibilities []models.MeVisibility, limit, offset int) ([]PhotoRow, int64, error) {
	where := "m.author_id = ? AND m.enabled = ? AND m.visibility IN ? AND m.deleted_at IS NULL AND " + clanVisibleCondAliasM

	var total int64
	if err := r.db.Table("me AS m").
		Where(where, authorID, true, visibilities).
		Select("COALESCE(SUM(jsonb_array_length(m.images)), 0)").
		Scan(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []PhotoRow
	err := r.db.Table("me AS m").
		Joins("CROSS JOIN LATERAL jsonb_array_elements(COALESCE(m.images, '[]'::jsonb)) WITH ORDINALITY AS elem(value, ord)").
		Where(where, authorID, true, visibilities).
		Select("elem.value->>'url' AS url, " +
			"COALESCE(NULLIF(elem.value->>'width', '')::int, 0) AS width, " +
			"COALESCE(NULLIF(elem.value->>'height', '')::int, 0) AS height, " +
			"COALESCE(elem.value->>'mimeType', '') AS mime_type, " +
			"m.id AS post_id, m.created_at AS created_at").
		Order("m.created_at DESC, m.id DESC, elem.ord ASC").
		Limit(limit).Offset(offset).
		Scan(&rows).Error
	if err != nil {
		return nil, 0, err
	}
	return rows, total, nil
}

const likedVisibilityCond = `(me.visibility = ? OR me.author_id = ? OR (me.visibility = ? AND EXISTS (
	SELECT 1 FROM relationships rel
	WHERE rel.status = ?
	  AND ((rel.requester_id = ? AND rel.addressee_id = me.author_id)
	    OR (rel.addressee_id = ? AND rel.requester_id = me.author_id))
)))`

func (r *Repository) ListLikedByUser(userID uuid.UUID, limit, offset int) ([]*models.Me, int64, error) {
	db := r.db.Model(&models.Me{}).
		Joins("JOIN me_reactions mr ON mr.post_id = me.id AND mr.user_id = ? AND mr.type = ?", userID, models.MeReactionLike).
		Where("me.enabled = ?", true).
		Where(likedVisibilityCond, models.MeVisibilityPublic, userID, models.MeVisibilityFriend, models.RelationshipStatusAccepted, userID, userID).
		Where(clanVisibleCond)

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var posts []*models.Me
	if err := db.Select("me.*").Preload("Author").Preload("Clan").
		Order("mr.created_at DESC").
		Limit(limit).Offset(offset).
		Find(&posts).Error; err != nil {
		return nil, 0, err
	}
	return posts, total, nil
}

type feedRow struct {
	ID        uuid.UUID `gorm:"column:id"`
	CreatedAt time.Time `gorm:"column:created_at"`
}

func feedFilterFragment(filter string) string {
	switch filter {
	case "media":
		return " AND jsonb_array_length(m.images) > 0"
	case "tagged":
		return " AND COALESCE(jsonb_array_length(m.mentions), 0) > 0"
	case "mentions":
		return " AND m.mentions @> @viewerJson"
	default:
		return ""
	}
}

func (r *Repository) FeedPage(viewerID uuid.UUID, filter string, cursorTime *time.Time, cursorID *uuid.UUID, limit int) ([]*models.Me, bool, error) {
	filterFrag := feedFilterFragment(filter)
	cursorFrag := ""
	if cursorTime != nil && cursorID != nil {
		cursorFrag = " AND (m.created_at, m.id) < (@curTs, @curId)"
	}

	branch := func(cond string) string {
		return "(SELECT m.id, m.created_at FROM me m WHERE m.deleted_at IS NULL AND m.enabled = true AND " + clanVisibleCondAliasM + " AND " + cond + filterFrag + cursorFrag +
			" ORDER BY m.created_at DESC, m.id DESC LIMIT @lim)"
	}
	friendCond := "m.visibility = 'friend' AND EXISTS (SELECT 1 FROM relationships rel WHERE rel.status = 'accepted'" +
		" AND ((rel.requester_id = @viewer AND rel.addressee_id = m.author_id)" +
		" OR (rel.addressee_id = @viewer AND rel.requester_id = m.author_id)))"

	followeeCond := "m.author_id IN (SELECT f.followee_id FROM follows f WHERE f.follower_id = @viewer)"
	clanPublicBranch := "(SELECT m.id, m.created_at FROM me m WHERE m.deleted_at IS NULL AND m.enabled = true" +
		" AND m.clan_id IS NOT NULL AND m.visibility = 'public'" +
		" AND EXISTS (SELECT 1 FROM clans c WHERE c.id = m.clan_id AND c.policy != 4 AND c.deleted_at IS NULL)" +
		cursorFrag + " ORDER BY m.created_at DESC, m.id DESC LIMIT @lim)"
	var query string
	if filter == "clan" {
		query = "SELECT id, created_at FROM (" + clanPublicBranch +
			") u ORDER BY created_at DESC, id DESC LIMIT @lim"
	} else if filter == "following" {
		query = "SELECT id, created_at FROM (" +
			branch("m.author_id = @viewer") + " UNION " +
			branch("m.visibility = 'public' AND "+followeeCond) + " UNION " +
			branch(friendCond+" AND "+followeeCond) +
			") u ORDER BY created_at DESC, id DESC LIMIT @lim"
	} else {
		query = "SELECT id, created_at FROM (" +
			branch("m.visibility = 'public'") + " UNION " +
			branch("m.author_id = @viewer") + " UNION " +
			branch(friendCond) +
			") u ORDER BY created_at DESC, id DESC LIMIT @lim"
	}

	args := map[string]interface{}{"viewer": viewerID, "lim": limit + 1}
	if filter == "mentions" {
		target, err := json.Marshal([]string{viewerID.String()})
		if err != nil {
			return nil, false, err
		}
		args["viewerJson"] = string(target)
	}
	if cursorTime != nil && cursorID != nil {
		args["curTs"] = *cursorTime
		args["curId"] = *cursorID
	}

	var rows []feedRow
	if err := r.db.Raw(query, args).Scan(&rows).Error; err != nil {
		return nil, false, err
	}

	hasMore := len(rows) > limit
	if hasMore {
		rows = rows[:limit]
	}
	if len(rows) == 0 {
		return []*models.Me{}, false, nil
	}

	ids := make([]uuid.UUID, len(rows))
	for i, row := range rows {
		ids[i] = row.ID
	}

	var posts []*models.Me
	if err := r.db.Preload("Author").Preload("Clan").Where("id IN ?", ids).Find(&posts).Error; err != nil {
		return nil, false, err
	}

	byID := make(map[uuid.UUID]*models.Me, len(posts))
	for _, p := range posts {
		byID[p.ID] = p
	}
	ordered := make([]*models.Me, 0, len(rows))
	for _, row := range rows {
		if p, ok := byID[row.ID]; ok {
			ordered = append(ordered, p)
		}
	}
	return ordered, hasMore, nil
}

func (r *Repository) ListByClanPage(clanID, viewerID uuid.UUID, excludeID *uuid.UUID, cursorTime *time.Time, cursorID *uuid.UUID, limit int) ([]*models.Me, bool, error) {
	db := r.db.Model(&models.Me{}).
		Where("me.clan_id = ? AND me.enabled = ?", clanID, true)
	if excludeID != nil {
		db = db.Where("me.id != ?", *excludeID)
	}
	if cursorTime != nil && cursorID != nil {
		db = db.Where("(me.created_at, me.id) < (?, ?)", *cursorTime, *cursorID)
	}

	var posts []*models.Me
	if err := db.Preload("Author").Preload("Clan").
		Order("me.created_at DESC").Order("me.id DESC").
		Limit(limit + 1).
		Find(&posts).Error; err != nil {
		return nil, false, err
	}

	hasMore := len(posts) > limit
	if hasMore {
		posts = posts[:limit]
	}
	return posts, hasMore, nil
}

func (r *Repository) DisableAllByClanAuthor(clanID, authorID uuid.UUID) error {
	return r.db.Model(&models.Me{}).
		Where("clan_id = ? AND author_id = ? AND enabled = ?", clanID, authorID, true).
		Update("enabled", false).Error
}

type LikerRow struct {
	ID       uuid.UUID `gorm:"column:id"`
	Username string    `gorm:"column:username"`
	FullName string    `gorm:"column:full_name"`
	Avatar   string    `gorm:"column:avatar"`
	IsFriend bool      `gorm:"column:is_friend"`
}

const likerFriendExists = `EXISTS (
	SELECT 1 FROM relationships rel
	WHERE rel.status = ?
	  AND ((rel.requester_id = ? AND rel.addressee_id = users.id)
	    OR (rel.addressee_id = ? AND rel.requester_id = users.id))
) AS is_friend`

func (r *Repository) ListLikers(viewerID, postID uuid.UUID, limit, offset int) ([]LikerRow, int64, error) {
	base := r.db.Model(&models.User{}).
		Joins("JOIN me_reactions ON me_reactions.user_id = users.id").
		Where("me_reactions.post_id = ? AND me_reactions.type = ?", postID, models.MeReactionLike)

	var total int64
	if err := base.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []LikerRow
	if err := base.
		Select("users.id, users.username, users.full_name, users.avatar, "+likerFriendExists,
			models.RelationshipStatusAccepted, viewerID, viewerID).
		Order("me_reactions.created_at DESC").
		Limit(limit).Offset(offset).
		Scan(&rows).Error; err != nil {
		return nil, 0, err
	}
	return rows, total, nil
}

type topLikerRow struct {
	EntityID uuid.UUID `gorm:"column:entity_id"`
	UserID   uuid.UUID `gorm:"column:user_id"`
}

const topLikersQuery = `
SELECT p.id AS entity_id, tl.user_id AS user_id
FROM me p
CROSS JOIN LATERAL (
    SELECT r.user_id, r.created_at
    FROM me_reactions r
    WHERE r.post_id = p.id AND r.type = ?
    ORDER BY r.created_at DESC
    LIMIT ?
) tl
WHERE p.id IN ?
ORDER BY p.id, tl.created_at DESC`

func (r *Repository) TopLikerIDsByPosts(postIDs []uuid.UUID, perPost int) (map[uuid.UUID][]uuid.UUID, error) {
	result := make(map[uuid.UUID][]uuid.UUID)
	if len(postIDs) == 0 {
		return result, nil
	}

	var rows []topLikerRow
	if err := r.db.Raw(topLikersQuery, models.MeReactionLike, perPost, postIDs).Scan(&rows).Error; err != nil {
		return nil, err
	}

	for _, row := range rows {
		result[row.EntityID] = append(result[row.EntityID], row.UserID)
	}
	return result, nil
}

func (r *Repository) FindUserIDsByUsernames(names []string) (map[string]uuid.UUID, error) {
	result := make(map[string]uuid.UUID)
	if len(names) == 0 {
		return result, nil
	}
	var users []models.User
	if err := r.db.Select("id", "username").Where("username IN ?", names).Find(&users).Error; err != nil {
		return nil, err
	}
	for _, u := range users {
		result[u.Username] = u.ID
	}
	return result, nil
}

func (r *Repository) GetReaction(postID, userID uuid.UUID) (*models.MeReaction, error) {
	var reaction models.MeReaction
	if err := r.db.First(&reaction, "post_id = ? AND user_id = ?", postID, userID).Error; err != nil {
		return nil, err
	}
	return &reaction, nil
}

func (r *Repository) GetUserReactions(userID uuid.UUID, postIDs []uuid.UUID) (map[uuid.UUID]models.MeReactionType, error) {
	result := make(map[uuid.UUID]models.MeReactionType)
	if len(postIDs) == 0 {
		return result, nil
	}
	var reactions []models.MeReaction
	if err := r.db.Where("user_id = ? AND post_id IN ?", userID, postIDs).Find(&reactions).Error; err != nil {
		return nil, err
	}
	for _, reaction := range reactions {
		result[reaction.PostID] = reaction.Type
	}
	return result, nil
}

func (r *Repository) React(postID, userID uuid.UUID, newType models.MeReactionType) (*models.Me, *models.MeReactionType, error) {
	var post *models.Me
	var current *models.MeReactionType

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var existing models.MeReaction
		errFind := tx.First(&existing, "post_id = ? AND user_id = ?", postID, userID).Error

		likeDelta, dislikeDelta := 0, 0
		switch {
		case errors.Is(errFind, gorm.ErrRecordNotFound):
			reaction := models.MeReaction{PostID: postID, UserID: userID, Type: newType}
			if err := tx.Create(&reaction).Error; err != nil {
				return err
			}
			if newType == models.MeReactionLike {
				likeDelta = 1
			} else {
				dislikeDelta = 1
			}
			t := newType
			current = &t
		case errFind != nil:
			return errFind
		case existing.Type == newType:
			if err := tx.Delete(&existing).Error; err != nil {
				return err
			}
			if newType == models.MeReactionLike {
				likeDelta = -1
			} else {
				dislikeDelta = -1
			}
			current = nil
		default:
			existing.Type = newType
			if err := tx.Save(&existing).Error; err != nil {
				return err
			}
			if newType == models.MeReactionLike {
				likeDelta, dislikeDelta = 1, -1
			} else {
				likeDelta, dislikeDelta = -1, 1
			}
			t := newType
			current = &t
		}

		if err := r.applyCounts(tx, postID, likeDelta, dislikeDelta); err != nil {
			return err
		}

		var p models.Me
		if err := tx.Preload("Author").First(&p, "id = ?", postID).Error; err != nil {
			return err
		}
		post = &p
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return post, current, nil
}

func (r *Repository) RemoveReaction(postID, userID uuid.UUID) (*models.Me, error) {
	var post *models.Me

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var existing models.MeReaction
		errFind := tx.First(&existing, "post_id = ? AND user_id = ?", postID, userID).Error

		switch {
		case errors.Is(errFind, gorm.ErrRecordNotFound):
		case errFind != nil:
			return errFind
		default:
			if err := tx.Delete(&existing).Error; err != nil {
				return err
			}
			likeDelta, dislikeDelta := 0, -1
			if existing.Type == models.MeReactionLike {
				likeDelta, dislikeDelta = -1, 0
			}
			if err := r.applyCounts(tx, postID, likeDelta, dislikeDelta); err != nil {
				return err
			}
		}

		var p models.Me
		if err := tx.Preload("Author").First(&p, "id = ?", postID).Error; err != nil {
			return err
		}
		post = &p
		return nil
	})
	if err != nil {
		return nil, err
	}
	return post, nil
}

func (r *Repository) CreateComment(comment *models.MeComment) (*models.MeComment, error) {
	err := r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(comment).Error; err != nil {
			return err
		}
		return tx.Model(&models.Me{}).Where("id = ?", comment.PostID).
			Update("comment_count", gorm.Expr("comment_count + ?", 1)).Error
	})
	if err != nil {
		return nil, err
	}
	return r.GetCommentByID(comment.ID)
}

func (r *Repository) GetCommentByID(id uuid.UUID) (*models.MeComment, error) {
	var comment models.MeComment
	if err := r.db.Preload("Author").First(&comment, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &comment, nil
}

func (r *Repository) GetCommentsByIDs(ids []uuid.UUID) ([]*models.MeComment, error) {
	if len(ids) == 0 {
		return []*models.MeComment{}, nil
	}
	var comments []*models.MeComment
	if err := r.db.Preload("Author").Where("id IN ?", ids).Find(&comments).Error; err != nil {
		return nil, err
	}
	return comments, nil
}

func (r *Repository) ListComments(postID uuid.UUID, limit, offset int) ([]*models.MeComment, int64, error) {
	db := r.db.Model(&models.MeComment{}).Where("post_id = ?", postID)

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var comments []*models.MeComment
	if err := db.Preload("Author").Order("created_at ASC").Limit(limit).Offset(offset).Find(&comments).Error; err != nil {
		return nil, 0, err
	}
	return comments, total, nil
}

func (r *Repository) DeleteComment(postID, commentID uuid.UUID) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		res := tx.Delete(&models.MeComment{}, "id = ?", commentID)
		if res.Error != nil {
			return res.Error
		}
		if res.RowsAffected == 0 {
			return nil
		}
		return tx.Model(&models.Me{}).Where("id = ?", postID).
			Update("comment_count", gorm.Expr("comment_count - ?", 1)).Error
	})
}

func (r *Repository) ToggleCommentLike(commentID, userID uuid.UUID) (bool, int, error) {
	var liked bool
	var likeCount int
	err := r.db.Transaction(func(tx *gorm.DB) error {
		var existing models.MeCommentLike
		errFind := tx.First(&existing, "comment_id = ? AND user_id = ?", commentID, userID).Error

		delta := 0
		switch {
		case errors.Is(errFind, gorm.ErrRecordNotFound):
			if err := tx.Create(&models.MeCommentLike{CommentID: commentID, UserID: userID}).Error; err != nil {
				return err
			}
			delta = 1
			liked = true
		case errFind != nil:
			return errFind
		default:
			if err := tx.Delete(&existing).Error; err != nil {
				return err
			}
			delta = -1
			liked = false
		}

		if err := tx.Model(&models.MeComment{}).Where("id = ?", commentID).
			Update("like_count", gorm.Expr("like_count + ?", delta)).Error; err != nil {
			return err
		}

		var c models.MeComment
		if err := tx.Select("like_count").First(&c, "id = ?", commentID).Error; err != nil {
			return err
		}
		likeCount = c.LikeCount
		return nil
	})
	if err != nil {
		return false, 0, err
	}
	return liked, likeCount, nil
}

func (r *Repository) GetUserCommentLikes(userID uuid.UUID, commentIDs []uuid.UUID) (map[uuid.UUID]bool, error) {
	result := make(map[uuid.UUID]bool)
	if len(commentIDs) == 0 {
		return result, nil
	}
	var likes []models.MeCommentLike
	if err := r.db.Where("user_id = ? AND comment_id IN ?", userID, commentIDs).Find(&likes).Error; err != nil {
		return nil, err
	}
	for _, l := range likes {
		result[l.CommentID] = true
	}
	return result, nil
}

const topCommentLikersQuery = `
SELECT c.id AS entity_id, tl.user_id AS user_id
FROM me_comments c
CROSS JOIN LATERAL (
    SELECT l.user_id, l.created_at
    FROM me_comment_likes l
    WHERE l.comment_id = c.id
    ORDER BY l.created_at DESC
    LIMIT ?
) tl
WHERE c.id IN ?
ORDER BY c.id, tl.created_at DESC`

func (r *Repository) TopCommentLikerIDsByComments(commentIDs []uuid.UUID, perComment int) (map[uuid.UUID][]uuid.UUID, error) {
	result := make(map[uuid.UUID][]uuid.UUID)
	if len(commentIDs) == 0 {
		return result, nil
	}

	var rows []topLikerRow
	if err := r.db.Raw(topCommentLikersQuery, perComment, commentIDs).Scan(&rows).Error; err != nil {
		return nil, err
	}

	for _, row := range rows {
		result[row.EntityID] = append(result[row.EntityID], row.UserID)
	}
	return result, nil
}

func (r *Repository) ListCommentLikers(viewerID, commentID uuid.UUID, limit, offset int) ([]LikerRow, int64, error) {
	base := r.db.Model(&models.User{}).
		Joins("JOIN me_comment_likes ON me_comment_likes.user_id = users.id").
		Where("me_comment_likes.comment_id = ?", commentID)

	var total int64
	if err := base.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []LikerRow
	if err := base.
		Select("users.id, users.username, users.full_name, users.avatar, "+likerFriendExists,
			models.RelationshipStatusAccepted, viewerID, viewerID).
		Order("me_comment_likes.created_at DESC").
		Limit(limit).Offset(offset).
		Scan(&rows).Error; err != nil {
		return nil, 0, err
	}
	return rows, total, nil
}

func isDedupedMeNotificationType(ntype string) bool {
	return ntype == models.MeNotificationLike || ntype == models.MeNotificationCommentLike
}

func meNotificationDedupScope(db *gorm.DB, n *models.MeNotification) *gorm.DB {
	q := db.Where("recipient_id = ? AND actor_id = ? AND post_id = ? AND type = ?",
		n.RecipientID, n.ActorID, n.PostID, n.Type)
	if n.CommentID != nil {
		q = q.Where("comment_id = ?", *n.CommentID)
	}
	return q
}

func (r *Repository) CreateMeNotification(n *models.MeNotification) (*models.MeNotification, error) {
	if isDedupedMeNotificationType(n.Type) {
		res := meNotificationDedupScope(r.db.Model(&models.MeNotification{}), n).
			Updates(map[string]interface{}{
				"is_read":    false,
				"created_at": time.Now(),
				"updated_at": time.Now(),
			})
		if res.Error != nil {
			return nil, res.Error
		}
		if res.RowsAffected == 0 {
			if err := r.db.Create(n).Error; err != nil {
				return nil, err
			}
		}
		var row models.MeNotification
		if err := meNotificationDedupScope(r.db.Preload("Actor"), n).First(&row).Error; err != nil {
			return nil, err
		}
		return &row, nil
	}

	if err := r.db.Create(n).Error; err != nil {
		return nil, err
	}
	var row models.MeNotification
	if err := r.db.Preload("Actor").First(&row, "id = ?", n.ID).Error; err != nil {
		return nil, err
	}
	return &row, nil
}

func (r *Repository) DeleteMeNotification(recipientID, actorID uuid.UUID, ntype string, postID uuid.UUID, commentID *uuid.UUID) (*models.MeNotification, error) {
	q := r.db.Where("recipient_id = ? AND actor_id = ? AND post_id = ? AND type = ?",
		recipientID, actorID, postID, ntype)
	if commentID != nil {
		q = q.Where("comment_id = ?", *commentID)
	}
	var row models.MeNotification
	if err := q.First(&row).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	if err := r.db.Unscoped().Delete(&models.MeNotification{}, "id = ?", row.ID).Error; err != nil {
		return nil, err
	}
	return &row, nil
}

func (r *Repository) DeleteMeNotificationsByComment(commentID uuid.UUID) ([]*models.MeNotification, error) {
	var rows []*models.MeNotification
	if err := r.db.Where("comment_id = ?", commentID).Find(&rows).Error; err != nil {
		return nil, err
	}
	if len(rows) == 0 {
		return rows, nil
	}
	if err := r.db.Unscoped().Where("comment_id = ?", commentID).Delete(&models.MeNotification{}).Error; err != nil {
		return nil, err
	}
	return rows, nil
}

func (r *Repository) ListMeNotificationsPage(recipientID uuid.UUID, cursorTime *time.Time, cursorID *uuid.UUID, limit int) ([]*models.MeNotification, bool, error) {
	db := r.db.Model(&models.MeNotification{}).Where("recipient_id = ?", recipientID)
	if cursorTime != nil && cursorID != nil {
		db = db.Where("(created_at, id) < (?, ?)", *cursorTime, *cursorID)
	}

	var items []*models.MeNotification
	if err := db.Preload("Actor").
		Order("created_at DESC").Order("id DESC").
		Limit(limit + 1).
		Find(&items).Error; err != nil {
		return nil, false, err
	}

	hasMore := len(items) > limit
	if hasMore {
		items = items[:limit]
	}
	return items, hasMore, nil
}

func (r *Repository) CountUnreadMeNotifications(recipientID uuid.UUID) (int64, error) {
	var count int64
	err := r.db.Model(&models.MeNotification{}).
		Where("recipient_id = ? AND is_read = ?", recipientID, false).
		Count(&count).Error
	return count, err
}

func (r *Repository) MarkAllMeNotificationsRead(recipientID uuid.UUID) error {
	return r.db.Model(&models.MeNotification{}).
		Where("recipient_id = ? AND is_read = ?", recipientID, false).
		Update("is_read", true).Error
}

func (r *Repository) applyCounts(tx *gorm.DB, postID uuid.UUID, likeDelta, dislikeDelta int) error {
	updates := map[string]interface{}{}
	if likeDelta != 0 {
		updates["like_count"] = gorm.Expr("like_count + ?", likeDelta)
	}
	if dislikeDelta != 0 {
		updates["dislike_count"] = gorm.Expr("dislike_count + ?", dislikeDelta)
	}
	if len(updates) == 0 {
		return nil
	}
	return tx.Model(&models.Me{}).Where("id = ?", postID).Updates(updates).Error
}
