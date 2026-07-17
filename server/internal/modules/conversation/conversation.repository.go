package conversation

import (
	"context"
	"fmt"
	"sort"
	"sync"
	"time"

	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
)

type Repository struct {
	session *gocql.Session
	logger  *zap.SugaredLogger
	queries map[string]string
}

func NewRepository(session *gocql.Session, logger *zap.SugaredLogger) *Repository {
	r := &Repository{
		session: session,
		logger:  logger.Named("[conversation_repository]"),
		queries: make(map[string]string),
	}

	r.queries["create_conversation"] = `
		INSERT INTO conversations (conversation_id, type, name, avatar, created_by, created_at, updated_at, participant_count)
		VALUES (?, ?, ?, ?, ?, ?, ?, ?)
	`

	r.queries["get_conversation"] = `
		SELECT conversation_id, type, name, avatar, created_by, created_at, updated_at, participant_count
		FROM conversations WHERE conversation_id = ?
	`

	r.queries["add_member"] = `
		INSERT INTO conversation_members_by_conversation
		(conversation_id, user_id, joined_at, is_active, role)
		VALUES (?, ?, ?, ?, ?)
	`

	r.queries["get_members"] = `
		SELECT conversation_id, user_id, joined_at, left_at, is_active, role
		FROM conversation_members_by_conversation WHERE conversation_id = ?
	`

	r.queries["get_user_conversations"] = `
		SELECT user_id, conversation_id, conversation_type, display_name, display_avatar,
		       other_user_id, other_user_name, other_user_avatar,
		       last_message_at, last_message_id, last_message_preview, last_message_sender,
		       unread_count, last_read_message_id, last_read_at, updated_at, is_muted
		FROM conversations_by_user WHERE user_id = ? AND conversation_id = ?
	`

	r.queries["get_direct_conversation"] = `
		SELECT conversation_id FROM direct_conversations_by_user_pair WHERE user_a = ? AND user_b = ?
	`

	r.queries["create_direct_pair"] = `
		INSERT INTO direct_conversations_by_user_pair (user_a, user_b, conversation_id) VALUES (?, ?, ?)
	`

	r.queries["mark_as_read"] = `
		INSERT INTO conversation_read_by_user (conversation_id, user_id, last_read_message_id, last_read_at)
		VALUES (?, ?, ?, ?)
	`

	r.queries["mark_inbox_read"] = `
		UPDATE conversations_by_user
		SET unread_count = 0, last_read_message_id = ?, last_read_at = ?, updated_at = ?
		WHERE user_id = ? AND conversation_id = ?
		IF EXISTS
	`

	r.queries["mark_inbox_read_no_marker"] = `
		UPDATE conversations_by_user
		SET unread_count = 0, last_read_at = ?, updated_at = ?
		WHERE user_id = ? AND conversation_id = ?
		IF EXISTS
	`

	r.queries["get_read_status"] = `
		SELECT last_read_message_id, last_read_at FROM conversation_read_by_user
		WHERE conversation_id = ? AND user_id = ?
	`

	r.queries["check_hidden"] = `
		SELECT conversation_id FROM hidden_conversations
		WHERE user_id = ? AND conversation_id = ?
	`

	r.queries["get_hidden_conversation"] = `
		SELECT user_id, conversation_id, hidden_at, is_archived, is_muted
		FROM hidden_conversations
		WHERE user_id = ? AND conversation_id = ?
	`

	r.queries["get_all_user_conversations"] = `
		SELECT user_id, conversation_id, conversation_type, display_name, display_avatar,
		       other_user_id, other_user_name, other_user_avatar,
		       last_message_at, last_message_id, last_message_preview, last_message_sender,
		       unread_count, last_read_message_id, last_read_at, updated_at, is_muted
		FROM conversations_by_user
		WHERE user_id = ?
	`

	r.queries["get_user_last_read"] = `
		SELECT last_read_message_id FROM conversations_by_user
		WHERE user_id = ? AND conversation_id = ?
	`

	r.queries["get_cleared_marker"] = `
		SELECT cleared_before FROM conversation_cleared_by_user
		WHERE user_id = ? AND conversation_id = ?
	`

	r.queries["set_cleared_marker"] = `
		INSERT INTO conversation_cleared_by_user (user_id, conversation_id, cleared_before, cleared_at)
		VALUES (?, ?, ?, ?)
	`

	return r
}

type Conversation struct {
	ConversationID   uuid.UUID
	Type             string
	Name             string
	Avatar           string
	CreatedBy        uuid.UUID
	CreatedAt        time.Time
	UpdatedAt        time.Time
	ParticipantCount int
}

type ConversationMember struct {
	ConversationID uuid.UUID
	UserID         uuid.UUID
	JoinedAt       time.Time
	LeftAt         *time.Time
	IsActive       bool
	Role           string
}

type ConversationByUser struct {
	UserID             gocql.UUID
	ConversationID     gocql.UUID
	ConversationType   string
	DisplayName        string
	DisplayAvatar      string
	OtherUserID        *gocql.UUID
	OtherUserName      string
	OtherUserAvatar    string
	LastMessageAt      gocql.UUID
	LastMessageID      *gocql.UUID
	LastMessagePreview string
	LastMessageSender  *gocql.UUID
	UnreadCount        int
	LastReadMessageID  *gocql.UUID
	LastReadAt         *time.Time
	UpdatedAt          *time.Time
	IsMuted            bool
}

type DirectConversationPair struct {
	UserA          uuid.UUID
	UserB          uuid.UUID
	ConversationID uuid.UUID
}

type HiddenConversation struct {
	UserID         uuid.UUID
	ConversationID uuid.UUID
	HiddenAt       time.Time
	IsArchived     bool
	IsMuted        bool
}

func (r *Repository) CreateConversation(conv *Conversation) error {
	gocqlConvID, _ := utils.ToGocqlUUID(conv.ConversationID)
	gocqlCreatedBy, _ := utils.ToGocqlUUID(conv.CreatedBy)

	return r.session.Query(r.queries["create_conversation"],
		gocqlConvID, conv.Type, conv.Name, conv.Avatar,
		gocqlCreatedBy, conv.CreatedAt, conv.UpdatedAt, conv.ParticipantCount,
	).Exec()
}

func (r *Repository) GetConversationByID(conversationID uuid.UUID) (*Conversation, error) {
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)

	var gocqlConv struct {
		ConversationID   gocql.UUID
		Type             string
		Name             string
		Avatar           string
		CreatedBy        gocql.UUID
		CreatedAt        time.Time
		UpdatedAt        time.Time
		ParticipantCount int
	}

	err := r.session.Query(r.queries["get_conversation"], gocqlConvID).Scan(
		&gocqlConv.ConversationID, &gocqlConv.Type, &gocqlConv.Name, &gocqlConv.Avatar,
		&gocqlConv.CreatedBy, &gocqlConv.CreatedAt, &gocqlConv.UpdatedAt, &gocqlConv.ParticipantCount,
	)
	if err != nil {
		return nil, err
	}

	// Convert back to uuid.UUID
	convID, _ := uuid.Parse(gocqlConv.ConversationID.String())
	createdBy, _ := uuid.Parse(gocqlConv.CreatedBy.String())

	return &Conversation{
		ConversationID:   convID,
		Type:             gocqlConv.Type,
		Name:             gocqlConv.Name,
		Avatar:           gocqlConv.Avatar,
		CreatedBy:        createdBy,
		CreatedAt:        gocqlConv.CreatedAt,
		UpdatedAt:        gocqlConv.UpdatedAt,
		ParticipantCount: gocqlConv.ParticipantCount,
	}, nil
}

func (r *Repository) AddMember(member *ConversationMember) error {
	gocqlConvID, _ := utils.ToGocqlUUID(member.ConversationID)
	gocqlUserID, _ := utils.ToGocqlUUID(member.UserID)

	return r.session.Query(r.queries["add_member"],
		gocqlConvID, gocqlUserID, member.JoinedAt, member.IsActive, member.Role,
	).Exec()
}

func (r *Repository) GetMembers(conversationID uuid.UUID) ([]ConversationMember, error) {
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)

	var members []ConversationMember
	iter := r.session.Query(r.queries["get_members"], gocqlConvID).Iter()

	var gocqlMember struct {
		ConversationID gocql.UUID
		UserID         gocql.UUID
		JoinedAt       time.Time
		LeftAt         *time.Time
		IsActive       bool
		Role           string
	}

	for iter.Scan(&gocqlMember.ConversationID, &gocqlMember.UserID, &gocqlMember.JoinedAt,
		&gocqlMember.LeftAt, &gocqlMember.IsActive, &gocqlMember.Role) {

		// Convert gocql.UUID to uuid.UUID
		convID, _ := uuid.Parse(gocqlMember.ConversationID.String())
		userID, _ := uuid.Parse(gocqlMember.UserID.String())

		members = append(members, ConversationMember{
			ConversationID: convID,
			UserID:         userID,
			JoinedAt:       gocqlMember.JoinedAt,
			LeftAt:         gocqlMember.LeftAt,
			IsActive:       gocqlMember.IsActive,
			Role:           gocqlMember.Role,
		})
	}

	if err := iter.Close(); err != nil {
		return nil, err
	}
	return members, nil
}

func (r *Repository) AddConversationToUserInbox(conv *ConversationByUser) error {
	query := `INSERT INTO conversations_by_user
	          (user_id, conversation_id, conversation_type, display_name, display_avatar,
	           other_user_id, other_user_name, other_user_avatar,
	           last_message_at, last_message_id, last_message_preview, last_message_sender,
	           unread_count, last_read_message_id, last_read_at, updated_at)
	          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`

	var otherUserID interface{}
	if conv.OtherUserID != nil {
		otherUserID = *conv.OtherUserID
	}

	var lastMessageID interface{}
	if conv.LastMessageID != nil {
		lastMessageID = *conv.LastMessageID
	}

	var lastMessageSender interface{}
	if conv.LastMessageSender != nil {
		lastMessageSender = *conv.LastMessageSender
	}

	var lastReadMessageID interface{}
	if conv.LastReadMessageID != nil {
		lastReadMessageID = *conv.LastReadMessageID
	}

	return r.session.Query(query,
		conv.UserID, conv.ConversationID, conv.ConversationType, conv.DisplayName, conv.DisplayAvatar,
		otherUserID, conv.OtherUserName, conv.OtherUserAvatar,
		conv.LastMessageAt, lastMessageID, conv.LastMessagePreview, lastMessageSender,
		conv.UnreadCount, lastReadMessageID, conv.LastReadAt, conv.UpdatedAt,
	).Exec()
}

type OtherUserReadState struct {
	UserID            uuid.UUID
	ConversationID    uuid.UUID
	LastReadMessageID *gocql.UUID
}

func (r *Repository) GetOtherUsersLastRead(pairs []OtherUserReadState) (map[string]*gocql.UUID, error) {
	result := make(map[string]*gocql.UUID, len(pairs))
	if len(pairs) == 0 {
		return result, nil
	}

	type item struct {
		key      string
		lastRead *gocql.UUID
	}

	var mu sync.Mutex
	g, ctx := errgroup.WithContext(context.Background())
	g.SetLimit(16)

	for _, p := range pairs {
		p := p
		g.Go(func() error {
			gocqlUserID, err := utils.ToGocqlUUID(p.UserID)
			if err != nil {
				return fmt.Errorf("invalid user ID %s: %w", p.UserID, err)
			}
			gocqlConvID, err := utils.ToGocqlUUID(p.ConversationID)
			if err != nil {
				return fmt.Errorf("invalid conversation ID %s: %w", p.ConversationID, err)
			}

			var lastRead *gocql.UUID
			err = r.session.Query(r.queries["get_user_last_read"], gocqlUserID, gocqlConvID).
				WithContext(ctx).
				Scan(&lastRead)
			if err != nil && err != gocql.ErrNotFound {
				return fmt.Errorf("scan last_read for user %s conv %s: %w", p.UserID, p.ConversationID, err)
			}

			it := item{
				key:      p.UserID.String() + ":" + p.ConversationID.String(),
				lastRead: lastRead,
			}
			mu.Lock()
			result[it.key] = it.lastRead
			mu.Unlock()
			return nil
		})
	}
	if err := g.Wait(); err != nil {
		return result, err
	}
	return result, nil
}

func (r *Repository) GetUserConversations(userID uuid.UUID, limit int) ([]ConversationByUser, error) {
	gocqlUserID, err := utils.ToGocqlUUID(userID)
	if err != nil {
		return nil, fmt.Errorf("failed to convert user ID: %w", err)
	}

	var conversations []ConversationByUser
	iter := r.session.Query(r.queries["get_all_user_conversations"], gocqlUserID).Iter()

	var conv ConversationByUser
	for iter.Scan(
		&conv.UserID, &conv.ConversationID, &conv.ConversationType, &conv.DisplayName, &conv.DisplayAvatar,
		&conv.OtherUserID, &conv.OtherUserName, &conv.OtherUserAvatar,
		&conv.LastMessageAt, &conv.LastMessageID, &conv.LastMessagePreview, &conv.LastMessageSender,
		&conv.UnreadCount, &conv.LastReadMessageID, &conv.LastReadAt, &conv.UpdatedAt, &conv.IsMuted,
	) {
		conversations = append(conversations, conv)
	}

	if err := iter.Close(); err != nil {
		return nil, err
	}

	sort.Slice(conversations, func(i, j int) bool {
		timeI := conversations[i].LastMessageAt.Time()
		timeJ := conversations[j].LastMessageAt.Time()
		return timeI.After(timeJ)
	})

	if limit > 0 && len(conversations) > limit {
		conversations = conversations[:limit]
	}

	return conversations, nil
}

func (r *Repository) GetOrCreateDirectConversation(user1ID, user2ID uuid.UUID) (uuid.UUID, bool, error) {
	userA, userB := user1ID, user2ID
	if user1ID.String() > user2ID.String() {
		userA, userB = user2ID, user1ID
	}

	gocqlUserA, _ := utils.ToGocqlUUID(userA)
	gocqlUserB, _ := utils.ToGocqlUUID(userB)

	var gocqlConvID gocql.UUID
	err := r.session.Query(r.queries["get_direct_conversation"], gocqlUserA, gocqlUserB).Scan(&gocqlConvID)

	if err == nil {
		conversationID, _ := uuid.Parse(gocqlConvID.String())
		return conversationID, false, nil
	}

	if err != gocql.ErrNotFound {
		return uuid.Nil, false, fmt.Errorf("failed to check existing conversation: %w", err)
	}

	conversationID := uuid.New()
	gocqlNewConvID, _ := utils.ToGocqlUUID(conversationID)

	if err := r.session.Query(r.queries["create_direct_pair"], gocqlUserA, gocqlUserB, gocqlNewConvID).Exec(); err != nil {
		return uuid.Nil, false, fmt.Errorf("failed to create direct conversation pair: %w", err)
	}

	return conversationID, true, nil
}

func (r *Repository) GetDirectConversationID(userA, userB uuid.UUID) (*uuid.UUID, error) {
	var conversationID gocql.UUID
	query := `SELECT conversation_id FROM direct_conversations_by_user_pair WHERE user_a = ? AND user_b = ?`

	// Convert uuid.UUID to gocql.UUID for querying
	gocqlUserA, _ := utils.ToGocqlUUID(userA)
	gocqlUserB, _ := utils.ToGocqlUUID(userB)

	err := r.session.Query(query, gocqlUserA, gocqlUserB).Scan(&conversationID)
	if err == gocql.ErrNotFound {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}

	// Convert back to uuid.UUID
	resultUUID, err := uuid.Parse(conversationID.String())
	if err != nil {
		return nil, err
	}
	return &resultUUID, nil
}

func (r *Repository) MarkAsRead(conversationID, userID uuid.UUID, lastReadMessageID *gocql.UUID, lastReadAt time.Time) (bool, error) {
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)
	gocqlUserID, _ := utils.ToGocqlUUID(userID)

	var applied bool
	var err error
	if lastReadMessageID != nil {
		applied, err = r.session.Query(r.queries["mark_inbox_read"],
			lastReadMessageID, lastReadAt, lastReadAt, gocqlUserID, gocqlConvID).MapScanCAS(map[string]interface{}{})
	} else {
		applied, err = r.session.Query(r.queries["mark_inbox_read_no_marker"],
			lastReadAt, lastReadAt, gocqlUserID, gocqlConvID).MapScanCAS(map[string]interface{}{})
	}
	if err != nil || !applied {
		return applied, err
	}

	if lastReadMessageID != nil {
		if err := r.session.Query(r.queries["mark_as_read"], gocqlConvID, gocqlUserID, lastReadMessageID, lastReadAt).Exec(); err != nil {
			return true, err
		}
	}
	return true, nil
}

func (r *Repository) GetReadStatus(conversationID, userID uuid.UUID) (*gocql.UUID, *time.Time, error) {
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)
	gocqlUserID, _ := utils.ToGocqlUUID(userID)

	var lastReadMessageID gocql.UUID
	var lastReadAt time.Time
	err := r.session.Query(r.queries["get_read_status"], gocqlConvID, gocqlUserID).Scan(&lastReadMessageID, &lastReadAt)
	if err == gocql.ErrNotFound {
		return nil, nil, nil
	}
	if err != nil {
		return nil, nil, err
	}
	return &lastReadMessageID, &lastReadAt, nil
}

func (r *Repository) NewBatch() *gocql.Batch {
	return r.session.NewBatch(gocql.LoggedBatch)
}

func (r *Repository) ExecuteBatch(batch *gocql.Batch) error {
	return r.session.ExecuteBatch(batch)
}

func (r *Repository) AddConversationToBatch(batch *gocql.Batch, conv *Conversation) {
	query := `INSERT INTO conversations (conversation_id, type, name, avatar, created_by, created_at, updated_at, participant_count)
	          VALUES (?, ?, ?, ?, ?, ?, ?, ?)`

	// Convert uuid.UUID to gocql.UUID
	gocqlConvID, _ := utils.ToGocqlUUID(conv.ConversationID)
	gocqlCreatedBy, _ := utils.ToGocqlUUID(conv.CreatedBy)

	batch.Query(query,
		gocqlConvID, conv.Type, conv.Name, conv.Avatar,
		gocqlCreatedBy, conv.CreatedAt, conv.UpdatedAt, conv.ParticipantCount,
	)
}

func (r *Repository) AddMemberToBatch(batch *gocql.Batch, member *ConversationMember) {
	query := `INSERT INTO conversation_members_by_conversation
	          (conversation_id, user_id, joined_at, is_active, role)
	          VALUES (?, ?, ?, ?, ?)`

	// Convert uuid.UUID to gocql.UUID
	gocqlConvID, _ := utils.ToGocqlUUID(member.ConversationID)
	gocqlUserID, _ := utils.ToGocqlUUID(member.UserID)

	batch.Query(query,
		gocqlConvID, gocqlUserID, member.JoinedAt, member.IsActive, member.Role,
	)
}

func (r *Repository) AddConversationToUserInboxBatch(batch *gocql.Batch, conv *ConversationByUser) {
	query := `INSERT INTO conversations_by_user
	          (user_id, conversation_id, conversation_type, display_name, display_avatar,
	           other_user_id, other_user_name, other_user_avatar,
	           last_message_at, last_message_id, last_message_preview, last_message_sender,
	           unread_count, last_read_message_id, last_read_at, updated_at)
	          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`

	var otherUserID interface{}
	if conv.OtherUserID != nil {
		otherUserID = *conv.OtherUserID
	}

	var lastMessageID interface{}
	if conv.LastMessageID != nil {
		lastMessageID = *conv.LastMessageID
	}

	var lastMessageSender interface{}
	if conv.LastMessageSender != nil {
		lastMessageSender = *conv.LastMessageSender
	}

	var lastReadMessageID interface{}
	if conv.LastReadMessageID != nil {
		lastReadMessageID = *conv.LastReadMessageID
	}

	values := []interface{}{
		conv.UserID,
		conv.ConversationID,
		conv.ConversationType,
		conv.DisplayName,
		conv.DisplayAvatar,
		otherUserID,
		conv.OtherUserName,
		conv.OtherUserAvatar,
		conv.LastMessageAt,
		lastMessageID,
		conv.LastMessagePreview,
		lastMessageSender,
		conv.UnreadCount,
		lastReadMessageID,
		conv.LastReadAt,
		conv.UpdatedAt,
	}

	batch.Query(query, values...)
}

func (r *Repository) AddDirectConversationPairToBatch(batch *gocql.Batch, userA, userB, conversationID uuid.UUID) {
	query := `INSERT INTO direct_conversations_by_user_pair (user_a, user_b, conversation_id) VALUES (?, ?, ?)`

	gocqlUserA, _ := utils.ToGocqlUUID(userA)
	gocqlUserB, _ := utils.ToGocqlUUID(userB)
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)

	batch.Query(query, gocqlUserA, gocqlUserB, gocqlConvID)
}

func (r *Repository) TryInsertDirectConversationPair(userA, userB, conversationID uuid.UUID) (applied bool, existingConvID *uuid.UUID, err error) {
	gocqlUserA, _ := utils.ToGocqlUUID(userA)
	gocqlUserB, _ := utils.ToGocqlUUID(userB)
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)

	query := `INSERT INTO direct_conversations_by_user_pair (user_a, user_b, conversation_id) 
	          VALUES (?, ?, ?) IF NOT EXISTS`

	var appliedResult bool
	var existingUserA, existingUserB, existingGocqlConvID gocql.UUID

	err = r.session.Query(query, gocqlUserA, gocqlUserB, gocqlConvID).Scan(
		&appliedResult, &existingUserA, &existingUserB, &existingGocqlConvID,
	)
	if err != nil {
		return false, nil, fmt.Errorf("LWT query failed: %w", err)
	}

	if !appliedResult {
		existingID, _ := uuid.Parse(existingGocqlConvID.String())
		return false, &existingID, nil
	}

	return true, nil, nil
}

func (r *Repository) GetUserConversationByID(userID, conversationID uuid.UUID) (*ConversationByUser, error) {
	gocqlUserID, _ := utils.ToGocqlUUID(userID)
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)

	var conv ConversationByUser
	query := `SELECT user_id, conversation_id, conversation_type, display_name, display_avatar,
	                 other_user_id, other_user_name, other_user_avatar,
	                 last_message_at, last_message_id, last_message_preview, last_message_sender,
	                 unread_count, last_read_message_id, last_read_at, updated_at, is_muted
	          FROM conversations_by_user WHERE user_id = ? AND conversation_id = ?`
	err := r.session.Query(query, gocqlUserID, gocqlConvID).Scan(
		&conv.UserID, &conv.ConversationID, &conv.ConversationType, &conv.DisplayName, &conv.DisplayAvatar,
		&conv.OtherUserID, &conv.OtherUserName, &conv.OtherUserAvatar,
		&conv.LastMessageAt, &conv.LastMessageID, &conv.LastMessagePreview, &conv.LastMessageSender,
		&conv.UnreadCount, &conv.LastReadMessageID, &conv.LastReadAt, &conv.UpdatedAt, &conv.IsMuted,
	)
	if err == gocql.ErrNotFound {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &conv, nil
}

// CheckIfHidden checks if a conversation is hidden by a user
func (r *Repository) CheckIfHidden(userID, conversationID uuid.UUID) (bool, error) {
	gocqlUserID, _ := utils.ToGocqlUUID(userID)
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)

	var gocqlResultConvID gocql.UUID
	err := r.session.Query(r.queries["check_hidden"], gocqlUserID, gocqlConvID).Scan(&gocqlResultConvID)
	if err == gocql.ErrNotFound {
		return false, nil
	}
	if err != nil {
		return false, err
	}
	return true, nil
}

// GetHiddenConversation retrieves hidden conversation data
func (r *Repository) GetHiddenConversation(userID, conversationID uuid.UUID) (*HiddenConversation, error) {
	gocqlUserID, _ := utils.ToGocqlUUID(userID)
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)

	var gocqlHidden struct {
		UserID         gocql.UUID
		ConversationID gocql.UUID
		HiddenAt       time.Time
		IsArchived     bool
		IsMuted        bool
	}

	err := r.session.Query(r.queries["get_hidden_conversation"], gocqlUserID, gocqlConvID).Scan(
		&gocqlHidden.UserID, &gocqlHidden.ConversationID, &gocqlHidden.HiddenAt,
		&gocqlHidden.IsArchived, &gocqlHidden.IsMuted,
	)
	if err == gocql.ErrNotFound {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}

	resultUserID, _ := uuid.Parse(gocqlHidden.UserID.String())
	resultConvID, _ := uuid.Parse(gocqlHidden.ConversationID.String())

	return &HiddenConversation{
		UserID:         resultUserID,
		ConversationID: resultConvID,
		HiddenAt:       gocqlHidden.HiddenAt,
		IsArchived:     gocqlHidden.IsArchived,
		IsMuted:        gocqlHidden.IsMuted,
	}, nil
}

func (r *Repository) GetClearedMarker(userID, conversationID uuid.UUID) (*gocql.UUID, error) {
	gocqlUserID, _ := utils.ToGocqlUUID(userID)
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)

	var marker gocql.UUID
	err := r.session.Query(r.queries["get_cleared_marker"], gocqlUserID, gocqlConvID).Scan(&marker)
	if err == gocql.ErrNotFound {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &marker, nil
}

func (r *Repository) SetClearedMarker(userID, conversationID uuid.UUID, marker gocql.UUID) error {
	gocqlUserID, _ := utils.ToGocqlUUID(userID)
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)
	return r.session.Query(r.queries["set_cleared_marker"], gocqlUserID, gocqlConvID, marker, time.Now()).Exec()
}

func (r *Repository) SetMuted(userID, conversationID uuid.UUID, muted bool) (bool, error) {
	gocqlUserID, _ := utils.ToGocqlUUID(userID)
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)
	query := `UPDATE conversations_by_user SET is_muted = ? WHERE user_id = ? AND conversation_id = ? IF EXISTS`
	return r.session.Query(query, muted, gocqlUserID, gocqlConvID).MapScanCAS(map[string]interface{}{})
}

// HideConversation moves a conversation from inbox to hidden
func (r *Repository) HideConversation(userID, conversationID uuid.UUID) error {
	batch := r.session.NewBatch(gocql.LoggedBatch)

	gocqlUserID, _ := utils.ToGocqlUUID(userID)
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)

	deleteQuery := `DELETE FROM conversations_by_user WHERE user_id = ? AND conversation_id = ?`
	batch.Query(deleteQuery, gocqlUserID, gocqlConvID)

	insertHiddenQuery := `INSERT INTO hidden_conversations 
	                      (user_id, conversation_id, hidden_at, is_archived, is_muted)
	                      VALUES (?, ?, ?, ?, ?)`
	batch.Query(insertHiddenQuery, gocqlUserID, gocqlConvID, time.Now(), false, false)

	return r.session.ExecuteBatch(batch)
}

func (r *Repository) UnhideConversation(userID, conversationID uuid.UUID, newLastMessageAt gocql.UUID,
	lastMessageID *gocql.UUID, lastMessagePreview string, lastMessageSender *uuid.UUID,
	conversationType, displayName, displayAvatar string, otherUserID *gocql.UUID, otherUserName, otherUserAvatar string,
	unreadCount int) error {

	batch := r.session.NewBatch(gocql.LoggedBatch)

	gocqlUserID, _ := utils.ToGocqlUUID(userID)
	gocqlConvID, _ := utils.ToGocqlUUID(conversationID)

	deleteHiddenQuery := `DELETE FROM hidden_conversations WHERE user_id = ? AND conversation_id = ?`
	batch.Query(deleteHiddenQuery, gocqlUserID, gocqlConvID)

	var gocqlLastMessageSender *gocql.UUID
	if lastMessageSender != nil {
		gocqlSender, _ := utils.ToGocqlUUID(*lastMessageSender)
		gocqlLastMessageSender = &gocqlSender
	}

	now := time.Now()
	insertInboxQuery := `INSERT INTO conversations_by_user
	                     (user_id, conversation_id, conversation_type, display_name, display_avatar,
	                      other_user_id, other_user_name, other_user_avatar,
	                      last_message_at, last_message_id, last_message_preview, last_message_sender,
	                      unread_count, last_read_message_id, last_read_at, updated_at)
	                     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`
	batch.Query(insertInboxQuery,
		gocqlUserID, gocqlConvID, conversationType, displayName, displayAvatar,
		otherUserID, otherUserName, otherUserAvatar,
		newLastMessageAt, lastMessageID, lastMessagePreview, gocqlLastMessageSender,
		unreadCount, nil, nil, now,
	)

	return r.session.ExecuteBatch(batch)
}
