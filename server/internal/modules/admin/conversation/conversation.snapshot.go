package adminconversation

import (
	"encoding/json"
	"fmt"
	"net/http"
	"time"

	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

const (
	snapshotTTL       = 15 * time.Minute
	snapshotPushChunk = 500
)

var ErrSnapshotExpired = utils.NewHTTPError(http.StatusGone, "danh sách hội thoại đã hết hạn, tải lại từ đầu")

type snapshotEntry struct {
	Item    ConversationItem `json:"i"`
	OtherID *uuid.UUID       `json:"o,omitempty"`
}

// The page order is frozen in a Redis list when the first page is built, so later pages neither
// re-read Scylla nor shift when a conversation receives a new message mid-pagination.
type snapshotStore struct {
	cache *services.CacheService
}

func snapshotKey(userID uuid.UUID, hidden bool, snapshotID string) string {
	return fmt.Sprintf("admin:conversation-snapshot:%s:%t:%s", userID, hidden, snapshotID)
}

func (s snapshotStore) save(userID uuid.UUID, hidden bool, entries []listEntry) (string, error) {
	snapshotID := uuid.NewString()
	key := snapshotKey(userID, hidden, snapshotID)
	client, ctx := s.cache.GetClient(), s.cache.GetContext()
	pipe := client.TxPipeline()
	for start := 0; start < len(entries); start += snapshotPushChunk {
		end := min(start+snapshotPushChunk, len(entries))
		values := make([]interface{}, 0, end-start)
		for _, e := range entries[start:end] {
			raw, err := json.Marshal(snapshotEntry{Item: e.item, OtherID: e.otherID})
			if err != nil {
				return "", err
			}
			values = append(values, raw)
		}
		pipe.RPush(ctx, key, values...)
	}
	pipe.Expire(ctx, key, snapshotTTL)
	if _, err := pipe.Exec(ctx); err != nil {
		return "", err
	}
	return snapshotID, nil
}

func (s snapshotStore) page(userID uuid.UUID, hidden bool, snapshotID string, offset, limit int) ([]listEntry, int, error) {
	key := snapshotKey(userID, hidden, snapshotID)
	client, ctx := s.cache.GetClient(), s.cache.GetContext()
	pipe := client.Pipeline()
	rangeCmd := pipe.LRange(ctx, key, int64(offset), int64(offset+limit-1))
	lenCmd := pipe.LLen(ctx, key)
	pipe.Expire(ctx, key, snapshotTTL)
	if _, err := pipe.Exec(ctx); err != nil {
		return nil, 0, err
	}
	total := int(lenCmd.Val())
	if total == 0 {
		return nil, 0, ErrSnapshotExpired
	}
	raws := rangeCmd.Val()
	entries := make([]listEntry, 0, len(raws))
	for _, raw := range raws {
		var stored snapshotEntry
		if err := json.Unmarshal([]byte(raw), &stored); err != nil {
			return nil, 0, err
		}
		entries = append(entries, listEntry{item: stored.Item, otherID: stored.OtherID})
	}
	return entries, total, nil
}
