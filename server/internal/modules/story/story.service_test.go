package story

import (
	"context"
	"errors"
	"strings"
	"sync"
	"sync/atomic"
	"testing"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"go.uber.org/zap"
)

type fakeStore struct {
	mu        sync.Mutex
	stories   map[int64]models.Story
	chapters  map[int64][]models.StoryChapter
	lastQuery ListQuery
	total     int64
	err       error
	saveErr   error
	saves     int
}

type fakeSource struct {
	content string
	err     error
	calls   atomic.Int32
	release chan struct{}
}

func (f *fakeSource) ChapterContent(context.Context, *ChapterRow) (string, error) {
	f.calls.Add(1)
	if f.release != nil {
		<-f.release
	}
	return f.content, f.err
}

func newTestService(store *fakeStore, source ContentSource) *Service {
	return &Service{store: store, admin: &fakeAdminStore{fakeStore: store}, source: source, logger: zap.NewNop().Sugar()}
}

func (f *fakeStore) List(_ context.Context, query ListQuery) ([]models.Story, int64, error) {
	f.lastQuery = query
	var items []models.Story
	for id := int64(1); id <= int64(len(f.stories)); id++ {
		items = append(items, f.stories[id])
	}
	end := query.Offset + query.Limit
	if query.Offset >= len(items) {
		return nil, f.total, f.err
	}
	if end > len(items) {
		end = len(items)
	}
	return items[query.Offset:end], f.total, f.err
}

func (f *fakeStore) Genres(context.Context) ([]GenreItem, error) {
	return nil, f.err
}

func (f *fakeStore) FindStory(_ context.Context, id int64) (*models.Story, error) {
	item, ok := f.stories[id]
	if !ok || item.IsHidden {
		return nil, f.err
	}
	return &item, f.err
}

func (f *fakeStore) Chapters(_ context.Context, storyID int64) ([]models.StoryChapter, error) {
	return f.chapters[storyID], f.err
}

func (f *fakeStore) Chapter(_ context.Context, storyID int64, position int) (*ChapterRow, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	chapters := f.chapters[storyID]
	for i, chapter := range chapters {
		if chapter.Position != position {
			continue
		}
		row := &ChapterRow{StoryChapter: chapter}
		if i > 0 {
			row.PrevPosition = &chapters[i-1].Position
		}
		if i < len(chapters)-1 {
			row.NextPosition = &chapters[i+1].Position
		}
		return row, f.err
	}
	return nil, f.err
}

func (f *fakeStore) SaveChapterContent(_ context.Context, chapterID, storyID int64, content string, wordCount int, _ []byte, replace bool) error {
	f.mu.Lock()
	defer f.mu.Unlock()
	f.saves++
	if f.saveErr != nil {
		return f.saveErr
	}
	for i := range f.chapters[storyID] {
		chapter := &f.chapters[storyID][i]
		if chapter.ID == chapterID && (replace || chapter.ContentText == "") {
			chapter.ContentText = content
			chapter.WordCount = wordCount
		}
	}
	return nil
}

func newFakeStore(count int) *fakeStore {
	store := &fakeStore{stories: map[int64]models.Story{}, chapters: map[int64][]models.StoryChapter{}, total: int64(count)}
	for id := int64(1); id <= int64(count); id++ {
		store.stories[id] = models.Story{ID: id, Title: "Truyện", Kind: "long", PublishedAt: time.Unix(id, 0)}
	}
	return store
}

func TestNormalizeListQuery(t *testing.T) {
	long := strings.Repeat("ạ", constants.StoryQueryMaxRunes+20)
	cases := []struct {
		name string
		in   ListQuery
		want ListQuery
	}{
		{
			name: "defaults",
			in:   ListQuery{},
			want: ListQuery{Sort: constants.StorySortUpdated, Limit: constants.StoryPageSize},
		},
		{
			name: "keeps valid values",
			in:   ListQuery{Sort: constants.StorySortViews, Status: constants.StoryStatusCompleted, Genre: " Tiểu Thuyết ", Query: "  oan gia ", Offset: 20, Limit: 30},
			want: ListQuery{Sort: constants.StorySortViews, Status: constants.StoryStatusCompleted, Genre: "Tiểu Thuyết", Query: "oan gia", Offset: 20, Limit: 30},
		},
		{
			name: "drops unknown sort and status",
			in:   ListQuery{Sort: "random", Status: constants.StoryStatusAll, Offset: -5, Limit: constants.StoryPageMax + 1},
			want: ListQuery{Sort: constants.StorySortUpdated, Limit: constants.StoryPageMax},
		},
		{
			name: "truncates long query by runes",
			in:   ListQuery{Query: long},
			want: ListQuery{Sort: constants.StorySortUpdated, Query: strings.Repeat("ạ", constants.StoryQueryMaxRunes), Limit: constants.StoryPageSize},
		},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			if got := normalizeListQuery(tc.in); got != tc.want {
				t.Fatalf("got %+v, want %+v", got, tc.want)
			}
		})
	}
}

func TestListHasMore(t *testing.T) {
	store := newFakeStore(25)
	service := newTestService(store, &fakeSource{})
	cases := []struct {
		offset, limit int
		items         int
		hasMore       bool
	}{
		{offset: 0, limit: 10, items: 10, hasMore: true},
		{offset: 20, limit: 10, items: 5, hasMore: false},
		{offset: 15, limit: 10, items: 10, hasMore: false},
		{offset: 40, limit: 10, items: 0, hasMore: false},
	}
	for _, tc := range cases {
		resp, err := service.List(context.Background(), ListQuery{Offset: tc.offset, Limit: tc.limit})
		if err != nil {
			t.Fatal(err)
		}
		if len(resp.Items) != tc.items || resp.HasMore != tc.hasMore || resp.Total != 25 {
			t.Fatalf("offset %d: got %d items hasMore=%v total=%d", tc.offset, len(resp.Items), resp.HasMore, resp.Total)
		}
	}
	if store.lastQuery.Sort != constants.StorySortUpdated {
		t.Fatalf("store got sort %q", store.lastQuery.Sort)
	}
}

func TestStoryResponseHasNoNullArrays(t *testing.T) {
	resp := toStoryResponse(models.Story{ID: 42})
	if resp.ID != "42" || resp.Genres == nil || resp.Tags == nil {
		t.Fatalf("got %+v", resp)
	}
}

func TestDetailNotFound(t *testing.T) {
	store := newFakeStore(2)
	hidden := store.stories[2]
	hidden.IsHidden = true
	store.stories[2] = hidden
	service := newTestService(store, &fakeSource{})
	for _, id := range []string{"", "abc", "0", "-1", "2", "3", "99999999999999999999"} {
		if _, err := service.Detail(context.Background(), id); !errors.Is(err, ErrStoryNotFound) {
			t.Fatalf("id %q: got %v", id, err)
		}
	}
	if _, err := service.Chapters(context.Background(), "2"); !errors.Is(err, ErrStoryNotFound) {
		t.Fatalf("hidden story chapters: got %v", err)
	}
}

func TestChapterNavigation(t *testing.T) {
	store := newFakeStore(1)
	store.chapters[1] = []models.StoryChapter{
		{ID: 10, StoryID: 1, Position: 1, ContentText: "một"},
		{ID: 11, StoryID: 1, Position: 2, ContentText: "hai"},
		{ID: 12, StoryID: 1, Position: 3, ContentText: "ba"},
	}
	service := newTestService(store, &fakeSource{})

	first, err := service.Chapter(context.Background(), "1", "1")
	if err != nil {
		t.Fatal(err)
	}
	if first.PrevPosition != nil || first.NextPosition == nil || *first.NextPosition != 2 || first.Content != "một" || first.ID != "10" {
		t.Fatalf("first chapter: %+v", first)
	}
	last, err := service.Chapter(context.Background(), "1", "3")
	if err != nil {
		t.Fatal(err)
	}
	if last.NextPosition != nil || last.PrevPosition == nil || *last.PrevPosition != 2 {
		t.Fatalf("last chapter: %+v", last)
	}
	for _, position := range []string{"0", "-1", "x", "4"} {
		if _, err := service.Chapter(context.Background(), "1", position); !errors.Is(err, ErrChapterNotFound) {
			t.Fatalf("position %q: got %v", position, err)
		}
	}
	if _, err := service.Chapter(context.Background(), "x", "1"); !errors.Is(err, ErrStoryNotFound) {
		t.Fatalf("bad story id: got %v", err)
	}
}

func newEmptyChapterStore() *fakeStore {
	store := newFakeStore(1)
	store.chapters[1] = []models.StoryChapter{
		{ID: 10, StoryID: 1, Position: 1, Title: "Chương 1"},
		{ID: 11, StoryID: 1, Position: 2, Title: "Chương 2", ContentText: "đã có"},
	}
	return store
}

func TestChapterLoadsMissingContentOnce(t *testing.T) {
	store := newEmptyChapterStore()
	source := &fakeSource{content: "Đoạn một có năm chữ.\n\nĐoạn hai."}
	service := newTestService(store, source)

	for range 2 {
		chapter, err := service.Chapter(context.Background(), "1", "1")
		if err != nil {
			t.Fatal(err)
		}
		if chapter.Content != source.content || chapter.WordCount != 7 {
			t.Fatalf("got content %q wordCount %d", chapter.Content, chapter.WordCount)
		}
	}
	if source.calls.Load() != 1 || store.saves != 1 {
		t.Fatalf("source calls %d, saves %d", source.calls.Load(), store.saves)
	}
	if _, err := service.Chapter(context.Background(), "1", "2"); err != nil || source.calls.Load() != 1 {
		t.Fatalf("stored chapter should not be fetched: err %v calls %d", err, source.calls.Load())
	}
}

func TestChapterConcurrentReadsShareOneFetch(t *testing.T) {
	store := newEmptyChapterStore()
	source := &fakeSource{content: "nội dung", release: make(chan struct{})}
	service := newTestService(store, source)

	var wg sync.WaitGroup
	errs := make(chan error, 5)
	for range 5 {
		wg.Add(1)
		go func() {
			defer wg.Done()
			chapter, err := service.Chapter(context.Background(), "1", "1")
			if err == nil && chapter.Content != "nội dung" {
				err = errors.New("wrong content " + chapter.Content)
			}
			errs <- err
		}()
	}
	time.Sleep(50 * time.Millisecond)
	close(source.release)
	wg.Wait()
	close(errs)
	for err := range errs {
		if err != nil {
			t.Fatal(err)
		}
	}
	if source.calls.Load() != 1 {
		t.Fatalf("source called %d times", source.calls.Load())
	}
}

func TestChapterContentUnavailable(t *testing.T) {
	store := newEmptyChapterStore()
	service := newTestService(store, &fakeSource{err: errEmptyContent})
	if _, err := service.Chapter(context.Background(), "1", "1"); !errors.Is(err, ErrChapterContentUnavailable) {
		t.Fatalf("got %v", err)
	}
	if store.saves != 0 {
		t.Fatalf("saved %d times", store.saves)
	}
}

func TestChapterSaveFailureStillReturnsContent(t *testing.T) {
	store := newEmptyChapterStore()
	store.saveErr = errors.New("db down")
	service := newTestService(store, &fakeSource{content: "nội dung"})
	chapter, err := service.Chapter(context.Background(), "1", "1")
	if err != nil || chapter.Content != "nội dung" {
		t.Fatalf("got %+v, %v", chapter, err)
	}
}
