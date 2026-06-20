package room

import (
	"fmt"
	"time"

	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type MessageRepository struct {
	session *gocql.Session
	logger  *zap.SugaredLogger
}

func NewMessageRepository(session *gocql.Session, logger *zap.SugaredLogger) *MessageRepository {
	return &MessageRepository{session: session, logger: logger.Named("[room_message_repository]")}
}

type RoomMessageRow struct {
	MessageID    gocql.UUID
	SenderID     uuid.UUID
	SenderName   string
	SenderAvatar string
	Content      string
	CreatedAt    time.Time
}

func (r *MessageRepository) CreateMessage(roomID uuid.UUID, messageID gocql.UUID, senderID uuid.UUID, senderName, senderAvatar, content string, createdAt time.Time) error {
	gocqlRoomID, err := utils.ToGocqlUUID(roomID)
	if err != nil {
		return fmt.Errorf("invalid room ID: %w", err)
	}
	gocqlSenderID, err := utils.ToGocqlUUID(senderID)
	if err != nil {
		return fmt.Errorf("invalid sender ID: %w", err)
	}

	return r.session.Query(`
		INSERT INTO room_messages
		(room_id, message_id, sender_id, sender_name, sender_avatar, content, created_at)
		VALUES (?, ?, ?, ?, ?, ?, ?)
	`, gocqlRoomID, messageID, gocqlSenderID, senderName, senderAvatar, content, createdAt).Exec()
}

func (r *MessageRepository) GetMessages(roomID uuid.UUID, limit int, before *gocql.UUID) ([]RoomMessageRow, error) {
	gocqlRoomID, err := utils.ToGocqlUUID(roomID)
	if err != nil {
		return nil, fmt.Errorf("invalid room ID: %w", err)
	}

	var iter *gocql.Iter
	if before != nil {
		iter = r.session.Query(`
			SELECT message_id, sender_id, sender_name, sender_avatar, content, created_at
			FROM room_messages WHERE room_id = ? AND message_id < ? LIMIT ?
		`, gocqlRoomID, *before, limit).Iter()
	} else {
		iter = r.session.Query(`
			SELECT message_id, sender_id, sender_name, sender_avatar, content, created_at
			FROM room_messages WHERE room_id = ? LIMIT ?
		`, gocqlRoomID, limit).Iter()
	}

	var rows []RoomMessageRow
	var (
		msgID        gocql.UUID
		senderID     gocql.UUID
		senderName   string
		senderAvatar string
		content      string
		createdAt    time.Time
	)
	for iter.Scan(&msgID, &senderID, &senderName, &senderAvatar, &content, &createdAt) {
		uid, _ := uuid.Parse(senderID.String())
		rows = append(rows, RoomMessageRow{
			MessageID:    msgID,
			SenderID:     uid,
			SenderName:   senderName,
			SenderAvatar: senderAvatar,
			Content:      content,
			CreatedAt:    createdAt,
		})
	}
	if err := iter.Close(); err != nil {
		return nil, err
	}
	return rows, nil
}
