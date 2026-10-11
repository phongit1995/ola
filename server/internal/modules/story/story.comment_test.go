package story

import (
	"context"
	"errors"
	"sort"
	"strings"
	"sync"
	"testing"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type fakeReadingSettings struct {
	cfg   setting.StoryReadingConfig
	err   error
	calls int
}

func (f *fakeReadingSettings) GetStoryReading() (setting.StoryReadingConfig, error) {
	f.calls++
	return f.cfg, f.err
}

type fakeUsers struct {
	users map[uuid.UUID]*models.User
}

func testUser(id uuid.UUID, fullName string, vipEnd *time.Time) *models.User {
	user := &models.User{Username: "u" + id.String()[:4], FullName: fullName, VipEndTime: vipEnd}
	user.ID = id
	return user
}

func (f *fakeUsers) GetUserCache(userID uuid.UUID, _ bool) (*models.User, error) {
	if user, ok := f.users[userID]; ok {
		return user, nil
	}
	return testUser(userID, "", nil), nil
}

func (f *fakeUsers) GetUsersBatch(userIDs []uuid.UUID, _ bool) map[uuid.UUID]*models.User {
	out := make(map[uuid.UUID]*models.User, len(userIDs))
	for _, id := range userIDs {
		out[id], _ = f.GetUserCache(id, true)
	}
	return out
}

type fakeCommentStore struct {
	mu       sync.Mutex
	comments []models.StoryComment
	likes    map[[2]uuid.UUID]bool
	unlocks  map[[2]uuid.UUID]bool
	counts   map[uuid.UUID]int
	clock    time.Time
	err      error
}

func newFakeCommentStore() *fakeCommentStore {
	return &fakeCommentStore{
		likes:   map[[2]uuid.UUID]bool{},
		unlocks: map[[2]uuid.UUID]bool{},
		counts:  map[uuid.UUID]int{},
		clock:   time.Date(2026, 10, 11, 8, 0, 0, 0, time.UTC),
	}
}

func (f *fakeCommentStore) CreateComment(_ context.Context, comment *models.StoryComment, unlock bool) (CommentWrite, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	comment.ID = uuid.New()
	f.clock = f.clock.Add(time.Second)
	comment.CreatedAt = f.clock
	f.comments = append(f.comments, *comment)
	f.counts[comment.StoryID]++
	key := [2]uuid.UUID{comment.AuthorID, comment.StoryID}
	if unlock {
		f.unlocks[key] = true
	}
	return CommentWrite{CommentCount: f.counts[comment.StoryID], Unlocked: f.unlocks[key]}, nil
}

func (f *fakeCommentStore) find(commentID uuid.UUID) *models.StoryComment {
	for i := range f.comments {
		if f.comments[i].ID == commentID && !f.comments[i].DeletedAt.Valid {
			return &f.comments[i]
		}
	}
	return nil
}

func (f *fakeCommentStore) FindComment(_ context.Context, storyID, commentID uuid.UUID) (*models.StoryComment, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	comment := f.find(commentID)
	if comment == nil || comment.StoryID != storyID {
		return nil, nil
	}
	copied := *comment
	return &copied, nil
}

func (f *fakeCommentStore) DeleteComment(_ context.Context, storyID, commentID uuid.UUID) (int, bool, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	comment := f.find(commentID)
	if comment == nil || comment.StoryID != storyID {
		return 0, false, nil
	}
	comment.DeletedAt = gorm.DeletedAt{Time: f.clock, Valid: true}
	f.counts[storyID]--
	return f.counts[storyID], true, nil
}

func (f *fakeCommentStore) ListComments(_ context.Context, storyID uuid.UUID, after *commentCursor, limit int) ([]models.StoryComment, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	var items []models.StoryComment
	for _, comment := range f.comments {
		if comment.StoryID != storyID || comment.DeletedAt.Valid {
			continue
		}
		if after != nil && !comment.CreatedAt.Before(after.CreatedAt) {
			continue
		}
		items = append(items, comment)
	}
	sort.Slice(items, func(i, j int) bool { return items[i].CreatedAt.After(items[j].CreatedAt) })
	if len(items) > limit {
		items = items[:limit]
	}
	return items, nil
}

func (f *fakeCommentStore) CommentsByIDs(_ context.Context, ids []uuid.UUID) ([]models.StoryComment, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	var items []models.StoryComment
	for _, id := range ids {
		if comment := f.find(id); comment != nil {
			items = append(items, *comment)
		}
	}
	return items, nil
}

func (f *fakeCommentStore) LikedComments(_ context.Context, userID uuid.UUID, ids []uuid.UUID) (map[uuid.UUID]bool, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	liked := map[uuid.UUID]bool{}
	for _, id := range ids {
		if f.likes[[2]uuid.UUID{id, userID}] {
			liked[id] = true
		}
	}
	return liked, nil
}

func (f *fakeCommentStore) ToggleCommentLike(_ context.Context, commentID, userID uuid.UUID) (bool, int, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	key := [2]uuid.UUID{commentID, userID}
	comment := f.find(commentID)
	if f.likes[key] {
		delete(f.likes, key)
		comment.LikeCount--
		return false, comment.LikeCount, nil
	}
	f.likes[key] = true
	comment.LikeCount++
	return true, comment.LikeCount, nil
}

func (f *fakeCommentStore) HasUnlock(_ context.Context, userID, storyID uuid.UUID) (bool, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	return f.unlocks[[2]uuid.UUID{userID, storyID}], f.err
}

func (f *fakeCommentStore) AdminComments(_ context.Context, storyID uuid.UUID, offset, limit int) ([]models.StoryComment, int64, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	var items []models.StoryComment
	for _, comment := range f.comments {
		if comment.StoryID == storyID {
			items = append(items, comment)
		}
	}
	total := int64(len(items))
	if offset >= len(items) {
		return nil, total, nil
	}
	items = items[offset:]
	if len(items) > limit {
		items = items[:limit]
	}
	return items, total, nil
}

func newCommentService(t *testing.T, minChars int) (*Service, *fakeCommentStore) {
	t.Helper()
	store := newFakeStore(2)
	hidden := store.stories[testID(2)]
	hidden.IsHidden = true
	store.stories[testID(2)] = hidden
	service := newTestService(store, &fakeSource{})
	comments := newFakeCommentStore()
	service.comments = comments
	service.users = &fakeUsers{users: map[uuid.UUID]*models.User{
		testReader: testUser(testReader, "Người Đọc", nil),
	}}
	service.settings = &fakeReadingSettings{cfg: setting.StoryReadingConfig{FreeChaptersPerDay: 1, CommentUnlockMinChars: minChars}}
	return service, comments
}

func TestCreateCommentValidatesContent(t *testing.T) {
	service, comments := newCommentService(t, 5)
	ctx := context.Background()

	cases := map[string]error{
		"   ": ErrCommentEmpty,
		strings.Repeat("a", StoryCommentMaxRunes+1): ErrCommentTooLong,
	}
	for content, want := range cases {
		if _, err := service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: content}); !errors.Is(err, want) {
			t.Fatalf("content len %d: got %v want %v", len(content), err, want)
		}
	}
	if _, err := service.CreateComment(ctx, testReader, sid(2), CreateStoryCommentRequest{Content: "hay quá"}); !errors.Is(err, ErrStoryNotFound) {
		t.Fatalf("hidden story: got %v", err)
	}
	if _, err := service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: "hay", ParentID: "x"}); !errors.Is(err, ErrCommentParent) {
		t.Fatalf("bad parent: got %v", err)
	}
	other := models.StoryComment{StoryID: testID(3), AuthorID: testReader, Content: "khác truyện"}
	if _, err := comments.CreateComment(ctx, &other, false); err != nil {
		t.Fatal(err)
	}
	if _, err := service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: "hay", ParentID: other.ID.String()}); !errors.Is(err, ErrCommentParent) {
		t.Fatalf("parent from other story: got %v", err)
	}
}

func TestCreateCommentUnlocksByRuneCount(t *testing.T) {
	service, _ := newCommentService(t, 6)
	ctx := context.Background()

	short, err := service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: "  ừ hay  "})
	if err != nil {
		t.Fatal(err)
	}
	if short.Unlocked || short.CommentCount != 1 || short.Comment.Content != "ừ hay" {
		t.Fatalf("short comment: %+v", short)
	}
	long, err := service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: "đọc đã"})
	if err != nil {
		t.Fatal(err)
	}
	if !long.Unlocked || long.CommentCount != 2 {
		t.Fatalf("6-rune comment should unlock: %+v", long)
	}
	if !long.Comment.Mine || long.Comment.Author == nil || long.Comment.Author.FullName != "Người Đọc" {
		t.Fatalf("author: %+v", long.Comment)
	}
}

func TestDeleteCommentKeepsUnlock(t *testing.T) {
	service, comments := newCommentService(t, 1)
	ctx := context.Background()
	created, err := service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: "truyện hay"})
	if err != nil {
		t.Fatal(err)
	}
	stranger := testID(950)
	if _, err := service.DeleteComment(ctx, stranger, sid(1), created.Comment.ID); !errors.Is(err, ErrCommentForbidden) {
		t.Fatalf("stranger delete: got %v", err)
	}
	deleted, err := service.DeleteComment(ctx, testReader, sid(1), created.Comment.ID)
	if err != nil || deleted.CommentCount != 0 {
		t.Fatalf("delete: %+v, %v", deleted, err)
	}
	if _, err := service.DeleteComment(ctx, testReader, sid(1), created.Comment.ID); !errors.Is(err, ErrCommentNotFound) {
		t.Fatalf("second delete: got %v", err)
	}
	if unlocked, _ := comments.HasUnlock(ctx, testReader, testID(1)); !unlocked {
		t.Fatal("unlock revoked by delete")
	}
}

func TestLikeCommentToggles(t *testing.T) {
	service, _ := newCommentService(t, 1)
	ctx := context.Background()
	created, err := service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: "hay"})
	if err != nil {
		t.Fatal(err)
	}
	liker := testID(951)
	first, err := service.LikeComment(ctx, liker, sid(1), created.Comment.ID)
	if err != nil || !first.Liked || first.LikeCount != 1 {
		t.Fatalf("like: %+v, %v", first, err)
	}
	list, err := service.Comments(ctx, liker, sid(1), "", 10)
	if err != nil || !list.Items[0].Liked || list.Items[0].Mine {
		t.Fatalf("list after like: %+v, %v", list, err)
	}
	second, err := service.LikeComment(ctx, liker, sid(1), created.Comment.ID)
	if err != nil || second.Liked || second.LikeCount != 0 {
		t.Fatalf("unlike: %+v, %v", second, err)
	}
	if _, err := service.LikeComment(ctx, liker, sid(1), uuid.NewString()); !errors.Is(err, ErrCommentNotFound) {
		t.Fatalf("missing comment: got %v", err)
	}
}

func TestCommentsPageWithCursorAndReplies(t *testing.T) {
	service, _ := newCommentService(t, 1)
	ctx := context.Background()
	root, err := service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: "bình luận gốc"})
	if err != nil {
		t.Fatal(err)
	}
	for _, content := range []string{"hai", "ba", "bốn"} {
		if _, err := service.CreateComment(ctx, testID(952), sid(1), CreateStoryCommentRequest{Content: content, ParentID: root.Comment.ID}); err != nil {
			t.Fatal(err)
		}
	}

	first, err := service.Comments(ctx, testReader, sid(1), "", 3)
	if err != nil {
		t.Fatal(err)
	}
	if len(first.Items) != 3 || first.NextCursor == "" || first.Items[0].Content != "bốn" {
		t.Fatalf("first page: %+v", first)
	}
	reply := first.Items[0]
	if reply.ParentID != root.Comment.ID || reply.ReplyTo == nil || reply.ReplyTo.AuthorName != "Người Đọc" || reply.ReplyTo.Excerpt != "bình luận gốc" {
		t.Fatalf("reply snapshot: %+v", reply.ReplyTo)
	}
	second, err := service.Comments(ctx, testReader, sid(1), first.NextCursor, 3)
	if err != nil {
		t.Fatal(err)
	}
	if len(second.Items) != 1 || second.NextCursor != "" || second.Items[0].ID != root.Comment.ID || !second.Items[0].Mine {
		t.Fatalf("second page: %+v", second)
	}
	if _, err := service.Comments(ctx, testReader, sid(1), "%%%", 3); !errors.Is(err, ErrCommentCursor) {
		t.Fatalf("bad cursor: got %v", err)
	}
}

func TestAdminCommentsIncludeDeleted(t *testing.T) {
	service, _ := newCommentService(t, 1)
	ctx := context.Background()
	created, err := service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: "hay"})
	if err != nil {
		t.Fatal(err)
	}
	if _, err := service.AdminDeleteComment(ctx, sid(1), created.Comment.ID); err != nil {
		t.Fatal(err)
	}
	list, err := service.AdminComments(ctx, sid(1), 0, 20)
	if err != nil || list.Total != 1 || list.Items[0].DeletedAt == nil {
		t.Fatalf("admin list: %+v, %v", list, err)
	}
}
