package adminconversation

import (
	"encoding/json"
	"net/http"
	"sort"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/message"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/sync/errgroup"
)

const (
	hiddenEnrichConcurrency = 8
	previewMaxRunes         = 100
)

var (
	ErrConversationNotFound = utils.NewHTTPError(http.StatusNotFound, "conversation not found")
	ErrInvalidCursor        = utils.NewHTTPError(http.StatusBadRequest, "invalid message id")
)

type Service struct {
	repo      *Repository
	userCache *userModule.CacheService
	snapshots snapshotStore
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, userCache *userModule.CacheService, cache *services.CacheService, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, userCache: userCache, snapshots: snapshotStore{cache: cache}, logger: logger.Named("[admin_conversation_service]")}
}

func toGocql(id uuid.UUID) gocql.UUID {
	return gocql.UUID(id)
}

func toGoogle(id gocql.UUID) uuid.UUID {
	return uuid.UUID(id)
}

func formatTime(t time.Time) string {
	if t.IsZero() {
		return ""
	}
	return t.UTC().Format(time.RFC3339)
}

func formatTimePtr(t *time.Time) string {
	if t == nil {
		return ""
	}
	return formatTime(*t)
}

func (s *Service) users(ids []uuid.UUID) map[uuid.UUID]*models.User {
	if len(ids) == 0 {
		return map[uuid.UUID]*models.User{}
	}
	return s.userCache.GetUsersBatch(ids, true)
}

func briefOf(id uuid.UUID, users map[uuid.UUID]*models.User, fallbackName, fallbackAvatar string) UserBrief {
	if u, ok := users[id]; ok && u != nil {
		return UserBrief{ID: id.String(), Username: u.Username, FullName: u.FullName, Avatar: u.Avatar}
	}
	return UserBrief{ID: id.String(), Username: fallbackName, Avatar: fallbackAvatar}
}

func previewOf(row messageRow) string {
	switch row.Type {
	case constants.MessageTypeText:
		if utf8.RuneCountInString(row.Content) > previewMaxRunes {
			return string([]rune(row.Content)[:previewMaxRunes]) + "…"
		}
		return row.Content
	case constants.MessageTypeImage:
		return "📷 Hình ảnh"
	case constants.MessageTypeAudio:
		return "🎤 Tin nhắn thoại"
	case constants.MessageTypeVideo:
		return "🎬 Video"
	case constants.MessageTypeFile:
		return "📎 Tệp"
	case constants.MessageTypeCall:
		return "📞 Cuộc gọi"
	default:
		return row.Content
	}
}

type listEntry struct {
	item    ConversationItem
	otherID *uuid.UUID
	sortAt  time.Time
}

// Neither conversations_by_user nor hidden_conversations is clustered by time, so the first page reads both
// partitions whole and freezes the sorted order in a snapshot; later pages only read their slice of it.
func (s *Service) ListByUser(userID uuid.UUID, hidden bool, limit, offset int, snapshotID string) (*ConversationListResponse, error) {
	var page []listEntry
	var total int
	if snapshotID == "" {
		entries, err := s.sortedEntries(userID, hidden)
		if err != nil {
			return nil, err
		}
		total = len(entries)
		page = entries[:min(limit, total)]
		if total > len(page) {
			if snapshotID, err = s.snapshots.save(userID, hidden, entries); err != nil {
				return nil, err
			}
		}
		offset = 0
	} else {
		var err error
		if page, total, err = s.snapshots.page(userID, hidden, snapshotID, offset, limit); err != nil {
			return nil, err
		}
	}

	if hidden {
		if err := s.enrichHidden(userID, page); err != nil {
			return nil, err
		}
	}

	otherIDs := make([]uuid.UUID, 0, len(page))
	for _, e := range page {
		if e.otherID != nil {
			otherIDs = append(otherIDs, *e.otherID)
		}
	}
	users := s.users(otherIDs)

	items := make([]ConversationItem, 0, len(page))
	for _, e := range page {
		if e.otherID != nil {
			brief := briefOf(*e.otherID, users, e.item.Name, e.item.Avatar)
			e.item.OtherUser = &brief
		}
		items = append(items, e.item)
	}
	hasMore := offset+len(page) < total
	if !hasMore {
		snapshotID = ""
	}
	return &ConversationListResponse{Items: items, Total: total, HasMore: hasMore, Snapshot: snapshotID}, nil
}

func (s *Service) sortedEntries(userID uuid.UUID, hidden bool) ([]listEntry, error) {
	inbox, err := s.repo.Inbox(toGocql(userID))
	if err != nil {
		return nil, err
	}
	if hidden {
		return s.hiddenEntries(userID, inbox)
	}
	return inboxEntries(inbox), nil
}

func inboxEntries(inbox []inboxRow) []listEntry {
	entries := make([]listEntry, 0, len(inbox))
	for _, row := range inbox {
		e := listEntry{item: ConversationItem{
			ID:                 row.ConversationID.String(),
			Type:               row.Type,
			Name:               row.DisplayName,
			Avatar:             row.DisplayAvatar,
			LastMessagePreview: row.LastMessagePreview,
		}}
		if row.LastMessageAt != nil {
			e.sortAt = row.LastMessageAt.Time()
			e.item.LastMessageAt = formatTime(e.sortAt)
		}
		if row.OtherUserID != nil {
			other := toGoogle(*row.OtherUserID)
			e.otherID = &other
		}
		entries = append(entries, e)
	}
	sort.SliceStable(entries, func(i, j int) bool { return entries[i].sortAt.After(entries[j].sortAt) })
	return entries
}

// Hiding deletes the inbox row, so hidden conversations only carry an id and hidden_at until enriched.
func (s *Service) hiddenEntries(userID uuid.UUID, inbox []inboxRow) ([]listEntry, error) {
	hidden, err := s.repo.Hidden(toGocql(userID))
	if err != nil {
		return nil, err
	}
	inInbox := make(map[gocql.UUID]bool, len(inbox))
	for _, row := range inbox {
		inInbox[row.ConversationID] = true
	}
	entries := make([]listEntry, 0, len(hidden))
	for _, h := range hidden {
		if inInbox[h.ConversationID] {
			continue
		}
		entries = append(entries, listEntry{
			item:   ConversationItem{ID: h.ConversationID.String(), Hidden: true, HiddenAt: formatTime(h.HiddenAt)},
			sortAt: h.HiddenAt,
		})
	}
	sort.SliceStable(entries, func(i, j int) bool { return entries[i].sortAt.After(entries[j].sortAt) })
	return entries, nil
}

func (s *Service) enrichHidden(userID uuid.UUID, page []listEntry) error {
	var g errgroup.Group
	g.SetLimit(hiddenEnrichConcurrency)
	for i := range page {
		e := &page[i]
		g.Go(func() error { return s.enrichHiddenEntry(userID, e) })
	}
	return g.Wait()
}

func (s *Service) enrichHiddenEntry(userID uuid.UUID, e *listEntry) error {
	convID, err := gocql.ParseUUID(e.item.ID)
	if err != nil {
		return err
	}
	conv, err := s.repo.Conversation(convID)
	if err != nil {
		return err
	}
	if conv == nil {
		e.item.Missing = true
		return nil
	}
	e.item.Type = conv.Type
	e.item.Name = conv.Name
	e.item.Avatar = conv.Avatar
	if conv.Type == constants.ConversationTypeDirect {
		members, err := s.repo.Members(convID)
		if err != nil {
			return err
		}
		for _, m := range members {
			if other := toGoogle(m.UserID); other != userID {
				e.otherID = &other
				break
			}
		}
	}
	latest, err := s.repo.MessagesBefore(convID, nil, 1)
	if err != nil {
		return err
	}
	if len(latest) > 0 {
		e.item.LastMessageAt = formatTime(latest[0].CreatedAt)
		e.item.LastMessagePreview = previewOf(latest[0])
	}
	return nil
}

func (s *Service) Detail(conversationID uuid.UUID) (*ConversationDetailResponse, error) {
	conv, err := s.repo.Conversation(toGocql(conversationID))
	if err != nil {
		return nil, err
	}
	if conv == nil {
		return nil, ErrConversationNotFound
	}
	members, err := s.repo.Members(conv.ConversationID)
	if err != nil {
		return nil, err
	}
	ids := make([]uuid.UUID, 0, len(members))
	for _, m := range members {
		ids = append(ids, toGoogle(m.UserID))
	}
	users := s.users(ids)

	resp := &ConversationDetailResponse{
		ID:        conv.ConversationID.String(),
		Type:      conv.Type,
		Name:      conv.Name,
		Avatar:    conv.Avatar,
		CreatedAt: formatTime(conv.CreatedAt),
		Members:   make([]ConversationMember, 0, len(members)),
	}
	for _, m := range members {
		resp.Members = append(resp.Members, ConversationMember{
			User:     briefOf(toGoogle(m.UserID), users, "", ""),
			Role:     m.Role,
			IsActive: m.IsActive,
			JoinedAt: formatTime(m.JoinedAt),
			LeftAt:   formatTimePtr(m.LeftAt),
		})
	}
	return resp, nil
}

func parseCursor(raw string) (*gocql.UUID, error) {
	if raw == "" {
		return nil, nil
	}
	id, err := gocql.ParseUUID(raw)
	if err != nil {
		return nil, ErrInvalidCursor
	}
	return &id, nil
}

// Messages pages backwards from before, or centres the page on around (used when opening a reported message).
func (s *Service) Messages(conversationID uuid.UUID, limit int, beforeRaw, aroundRaw string) (*MessagesResponse, error) {
	convID := toGocql(conversationID)
	before, err := parseCursor(beforeRaw)
	if err != nil {
		return nil, err
	}
	around, err := parseCursor(aroundRaw)
	if err != nil {
		return nil, err
	}

	var rows []messageRow
	resp := &MessagesResponse{}
	if around != nil {
		half := limit / 2
		newer, err := s.repo.MessagesAfter(convID, *around, half+1)
		if err != nil {
			return nil, err
		}
		if len(newer) > half {
			newer = newer[:half]
			resp.HasNewer = true
		}
		for i := len(newer) - 1; i >= 0; i-- {
			rows = append(rows, newer[i])
		}
		target, err := s.repo.Message(convID, *around)
		if err != nil {
			return nil, err
		}
		if target != nil {
			rows = append(rows, *target)
		}
		older, err := s.repo.MessagesBefore(convID, around, half+1)
		if err != nil {
			return nil, err
		}
		if len(older) > half {
			older = older[:half]
			resp.HasMore = true
		}
		rows = append(rows, older...)
	} else {
		rows, err = s.repo.MessagesBefore(convID, before, limit+1)
		if err != nil {
			return nil, err
		}
		if len(rows) > limit {
			rows = rows[:limit]
			resp.HasMore = true
		}
	}
	if resp.HasMore && len(rows) > 0 {
		resp.NextBefore = rows[len(rows)-1].MessageID.String()
	}

	senderSet := make(map[uuid.UUID]struct{}, len(rows))
	for _, row := range rows {
		senderSet[toGoogle(row.SenderID)] = struct{}{}
	}
	senderIDs := make([]uuid.UUID, 0, len(senderSet))
	for id := range senderSet {
		senderIDs = append(senderIDs, id)
	}
	users := s.users(senderIDs)

	resp.Messages = make([]Message, 0, len(rows))
	for _, row := range rows {
		resp.Messages = append(resp.Messages, toMessage(row, users))
	}
	return resp, nil
}

func toMessage(row messageRow, users map[uuid.UUID]*models.User) Message {
	msg := Message{
		ID:        row.MessageID.String(),
		Sender:    briefOf(toGoogle(row.SenderID), users, row.SenderName, row.SenderAvatar),
		Type:      row.Type,
		Content:   row.Content,
		Metadata:  row.Metadata,
		CreatedAt: formatTime(row.CreatedAt),
		EditedAt:  formatTimePtr(row.EditedAt),
		DeletedAt: formatTimePtr(row.DeletedAt),
	}
	if row.ReplySnapshot != "" {
		var reply message.ReplySnapshot
		if json.Unmarshal([]byte(row.ReplySnapshot), &reply) == nil {
			msg.ReplyTo = &reply
		}
	}
	if row.Reactions != "" {
		var reactions map[string][]string
		if json.Unmarshal([]byte(row.Reactions), &reactions) == nil && len(reactions) > 0 {
			msg.Reactions = reactions
		}
	}
	return msg
}
