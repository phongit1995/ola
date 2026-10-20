package room

import (
	"context"
	"encoding/json"
	"errors"

	"github.com/google/uuid"
)

var ErrMessageNotFound = errors.New("message not found")

type MessageSnapshot struct {
	SenderID  string
	Type      string
	Content   string
	ImageURL  string
	AudioURL  string
	CreatedAt string
}

func (s *Service) FindMessage(ctx context.Context, roomID uuid.UUID, messageID string) (*MessageSnapshot, error) {
	data, err := s.redisMsg.Get(ctx, roomID.String(), messageID)
	if err != nil {
		return nil, err
	}
	if data == nil {
		return nil, ErrMessageNotFound
	}
	var stored storedRoomMessage
	if err := json.Unmarshal(data, &stored); err != nil {
		return nil, err
	}
	return &MessageSnapshot{
		SenderID:  stored.SenderID,
		Type:      stored.Type,
		Content:   stored.Content,
		ImageURL:  stored.ImageURL,
		AudioURL:  stored.AudioURL,
		CreatedAt: stored.CreatedAt,
	}, nil
}
