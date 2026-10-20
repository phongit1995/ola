package adminconversation

import (
	"errors"
	"time"

	"github.com/gocql/gocql"
	"go.uber.org/zap"
)

const messageColumns = `message_id, sender_id, sender_name, sender_avatar, message_type, content, metadata,
	created_at, deleted_at, reply_snapshot, reactions, edited_at`

type Repository struct {
	session *gocql.Session
	logger  *zap.SugaredLogger
}

func NewRepository(session *gocql.Session, logger *zap.SugaredLogger) *Repository {
	return &Repository{session: session, logger: logger.Named("[admin_conversation_repository]")}
}

type inboxRow struct {
	ConversationID     gocql.UUID
	Type               string
	DisplayName        string
	DisplayAvatar      string
	OtherUserID        *gocql.UUID
	LastMessageAt      *gocql.UUID
	LastMessagePreview string
}

type hiddenRow struct {
	ConversationID gocql.UUID
	HiddenAt       time.Time
}

type conversationRow struct {
	ConversationID gocql.UUID
	Type           string
	Name           string
	Avatar         string
	CreatedAt      time.Time
}

type memberRow struct {
	UserID   gocql.UUID
	Role     string
	IsActive bool
	JoinedAt time.Time
	LeftAt   *time.Time
}

type messageRow struct {
	MessageID     gocql.UUID
	SenderID      gocql.UUID
	SenderName    string
	SenderAvatar  string
	Type          string
	Content       string
	Metadata      string
	CreatedAt     time.Time
	DeletedAt     *time.Time
	ReplySnapshot string
	Reactions     string
	EditedAt      *time.Time
}

func (r *Repository) Inbox(userID gocql.UUID) ([]inboxRow, error) {
	iter := r.session.Query(`
		SELECT conversation_id, conversation_type, display_name, display_avatar, other_user_id, last_message_at, last_message_preview
		FROM conversations_by_user WHERE user_id = ?`, userID).Iter()
	var rows []inboxRow
	var row inboxRow
	for iter.Scan(&row.ConversationID, &row.Type, &row.DisplayName, &row.DisplayAvatar, &row.OtherUserID, &row.LastMessageAt, &row.LastMessagePreview) {
		rows = append(rows, row)
		row = inboxRow{}
	}
	return rows, iter.Close()
}

func (r *Repository) Hidden(userID gocql.UUID) ([]hiddenRow, error) {
	iter := r.session.Query(`SELECT conversation_id, hidden_at FROM hidden_conversations WHERE user_id = ?`, userID).Iter()
	var rows []hiddenRow
	var row hiddenRow
	for iter.Scan(&row.ConversationID, &row.HiddenAt) {
		rows = append(rows, row)
	}
	return rows, iter.Close()
}

// Conversation returns nil when the conversation does not exist.
func (r *Repository) Conversation(conversationID gocql.UUID) (*conversationRow, error) {
	var row conversationRow
	err := r.session.Query(`
		SELECT conversation_id, type, name, avatar, created_at FROM conversations WHERE conversation_id = ?`, conversationID).
		Scan(&row.ConversationID, &row.Type, &row.Name, &row.Avatar, &row.CreatedAt)
	if errors.Is(err, gocql.ErrNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &row, nil
}

func (r *Repository) Members(conversationID gocql.UUID) ([]memberRow, error) {
	iter := r.session.Query(`
		SELECT user_id, role, is_active, joined_at, left_at
		FROM conversation_members_by_conversation WHERE conversation_id = ?`, conversationID).Iter()
	var rows []memberRow
	var row memberRow
	for iter.Scan(&row.UserID, &row.Role, &row.IsActive, &row.JoinedAt, &row.LeftAt) {
		rows = append(rows, row)
		row = memberRow{}
	}
	return rows, iter.Close()
}

// MessagesBefore returns newest first; a nil cursor starts from the latest message.
func (r *Repository) MessagesBefore(conversationID gocql.UUID, before *gocql.UUID, limit int) ([]messageRow, error) {
	if before == nil {
		return r.scanMessages(r.session.Query(`SELECT `+messageColumns+`
			FROM messages_by_conversation WHERE conversation_id = ? LIMIT ?`, conversationID, limit).Iter())
	}
	return r.scanMessages(r.session.Query(`SELECT `+messageColumns+`
		FROM messages_by_conversation WHERE conversation_id = ? AND message_id < ? LIMIT ?`, conversationID, *before, limit).Iter())
}

// MessagesAfter returns oldest first.
func (r *Repository) MessagesAfter(conversationID, after gocql.UUID, limit int) ([]messageRow, error) {
	return r.scanMessages(r.session.Query(`SELECT `+messageColumns+`
		FROM messages_by_conversation WHERE conversation_id = ? AND message_id > ?
		ORDER BY message_id ASC LIMIT ?`, conversationID, after, limit).Iter())
}

// Message returns nil when the message does not exist.
func (r *Repository) Message(conversationID, messageID gocql.UUID) (*messageRow, error) {
	rows, err := r.scanMessages(r.session.Query(`SELECT `+messageColumns+`
		FROM messages_by_conversation WHERE conversation_id = ? AND message_id = ?`, conversationID, messageID).Iter())
	if err != nil || len(rows) == 0 {
		return nil, err
	}
	return &rows[0], nil
}

func (r *Repository) scanMessages(iter *gocql.Iter) ([]messageRow, error) {
	var rows []messageRow
	var row messageRow
	for iter.Scan(&row.MessageID, &row.SenderID, &row.SenderName, &row.SenderAvatar, &row.Type, &row.Content, &row.Metadata,
		&row.CreatedAt, &row.DeletedAt, &row.ReplySnapshot, &row.Reactions, &row.EditedAt) {
		rows = append(rows, row)
		row = messageRow{}
	}
	return rows, iter.Close()
}
