package story

import (
	"context"
	"errors"
	"testing"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
)

type fakeAdminStore struct {
	*fakeStore
	bulkQuery ListQuery
}

func (f *fakeAdminStore) Sources(context.Context) ([]SourceItem, error) {
	return nil, f.err
}

func (f *fakeAdminStore) setHiddenWhere(match func(models.Story) bool, hidden bool) int64 {
	f.mu.Lock()
	defer f.mu.Unlock()
	var updated int64
	for id, item := range f.stories {
		if item.IsHidden == hidden || !match(item) {
			continue
		}
		item.IsHidden = hidden
		f.stories[id] = item
		updated++
	}
	return updated
}

func (f *fakeAdminStore) SetHiddenByIDs(_ context.Context, ids []int64, hidden bool) (int64, error) {
	wanted := map[int64]bool{}
	for _, id := range ids {
		wanted[id] = true
	}
	return f.setHiddenWhere(func(item models.Story) bool { return wanted[item.ID] }, hidden), f.err
}

func (f *fakeAdminStore) SetHiddenByFilter(_ context.Context, query ListQuery, hidden bool) (int64, error) {
	f.bulkQuery = query
	return f.setHiddenWhere(func(item models.Story) bool {
		return (query.Source == "" || item.Source == query.Source) && (query.Kind == "" || item.Kind == query.Kind)
	}, hidden), f.err
}

func (f *fakeAdminStore) AllGenres(context.Context) ([]GenreItem, error) {
	return nil, f.err
}

func (f *fakeAdminStore) Summary(context.Context) (*AdminSummaryResponse, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	return &AdminSummaryResponse{Stories: int64(len(f.stories))}, f.err
}

func (f *fakeAdminStore) ContentCounts(_ context.Context, storyIDs []int64) (map[int64]int, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	counts := map[int64]int{}
	for _, id := range storyIDs {
		for _, chapter := range f.chapters[id] {
			if chapter.ContentText != "" {
				counts[id]++
			}
		}
	}
	return counts, f.err
}

func (f *fakeAdminStore) FindAnyStory(_ context.Context, id int64) (*models.Story, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	item, ok := f.stories[id]
	if !ok {
		return nil, f.err
	}
	return &item, f.err
}

func (f *fakeAdminStore) SetHidden(_ context.Context, id int64, hidden bool) (bool, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	item, ok := f.stories[id]
	if !ok {
		return false, f.err
	}
	item.IsHidden = hidden
	f.stories[id] = item
	return true, f.err
}

func (f *fakeAdminStore) DeleteStory(_ context.Context, id int64) (bool, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	if _, ok := f.stories[id]; !ok {
		return false, f.err
	}
	delete(f.stories, id)
	delete(f.chapters, id)
	return true, f.err
}

func (f *fakeAdminStore) AdminChapters(_ context.Context, storyID int64) ([]AdminChapterRow, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	var rows []AdminChapterRow
	for _, chapter := range f.chapters[storyID] {
		rows = append(rows, AdminChapterRow{StoryChapter: chapter, HasContent: chapter.ContentText != ""})
	}
	return rows, f.err
}

func (f *fakeAdminStore) AnyChapter(ctx context.Context, storyID int64, position int) (*ChapterRow, error) {
	return f.Chapter(ctx, storyID, position)
}

func (f *fakeAdminStore) MissingContentChapters(_ context.Context, storyID int64) ([]ChapterRow, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	var rows []ChapterRow
	for _, chapter := range f.chapters[storyID] {
		if chapter.ContentText == "" {
			rows = append(rows, ChapterRow{StoryChapter: chapter})
		}
	}
	return rows, f.err
}

func TestNormalizeAdminListQuery(t *testing.T) {
	got := normalizeAdminListQuery(ListQuery{Visibility: "bogus", Kind: "poem", Limit: 0})
	want := ListQuery{Sort: constants.StorySortUpdated, Visibility: constants.StoryVisibilityAll, Limit: constants.StoryAdminPageSize}
	if got != want {
		t.Fatalf("got %+v, want %+v", got, want)
	}
	got = normalizeAdminListQuery(ListQuery{Visibility: constants.StoryVisibilityHidden, Kind: constants.StoryKindShort, Limit: 1000})
	if got.Visibility != constants.StoryVisibilityHidden || got.Kind != constants.StoryKindShort || got.Limit != constants.StoryAdminPageMax {
		t.Fatalf("got %+v", got)
	}
	if got := normalizeAdminListQuery(ListQuery{Source: "  vnkings "}); got.Source != constants.StorySourceVnkings {
		t.Fatalf("source not trimmed: %+v", got)
	}
	public := normalizeListQuery(ListQuery{Visibility: constants.StoryVisibilityHidden, Kind: constants.StoryKindShort, Source: constants.StorySourceVnkings})
	if public.Visibility != "" || public.Kind != "" || public.Source != "" {
		t.Fatalf("public query must not use admin filters: %+v", public)
	}
}

func TestSetHiddenMany(t *testing.T) {
	store := newFakeStore(5)
	for id := int64(1); id <= 5; id++ {
		item := store.stories[id]
		item.Source = constants.StorySourceVnkings
		if id > 3 {
			item.Source = "other"
			item.Kind = constants.StoryKindShort
		}
		store.stories[id] = item
	}
	service := newTestService(store, &fakeSource{})
	admin := service.admin.(*fakeAdminStore)
	ctx := context.Background()
	hide, show := true, false

	resp, err := service.SetHiddenMany(ctx, BulkVisibilityRequest{IsHidden: &hide, IDs: []string{"1", "2", "99"}})
	if err != nil || resp.Updated != 2 {
		t.Fatalf("hide by ids: %+v, %v", resp, err)
	}
	resp, err = service.SetHiddenMany(ctx, BulkVisibilityRequest{IsHidden: &hide, Filter: &StoryFilter{Source: " vnkings ", Visibility: "bogus"}})
	if err != nil || resp.Updated != 1 {
		t.Fatalf("hide by filter counts only changed stories: %+v, %v", resp, err)
	}
	if admin.bulkQuery.Source != constants.StorySourceVnkings || admin.bulkQuery.Visibility != constants.StoryVisibilityAll {
		t.Fatalf("filter not normalized: %+v", admin.bulkQuery)
	}
	for id := int64(1); id <= 5; id++ {
		if want := id <= 3; store.stories[id].IsHidden != want {
			t.Fatalf("story %d hidden = %v", id, store.stories[id].IsHidden)
		}
	}
	resp, err = service.SetHiddenMany(ctx, BulkVisibilityRequest{IsHidden: &show, Filter: &StoryFilter{}})
	if err != nil || resp.Updated != 3 {
		t.Fatalf("show all: %+v, %v", resp, err)
	}

	tooMany := make([]string, constants.StoryBulkIDsMax+1)
	for i := range tooMany {
		tooMany[i] = "1"
	}
	cases := []struct {
		name string
		req  BulkVisibilityRequest
		want error
	}{
		{"no target", BulkVisibilityRequest{IsHidden: &hide}, ErrBulkTargetRequired},
		{"empty ids without filter", BulkVisibilityRequest{IsHidden: &hide, IDs: []string{}}, ErrBulkTargetRequired},
		{"invalid id", BulkVisibilityRequest{IsHidden: &hide, IDs: []string{"1", "x"}}, ErrInvalidStoryIDs},
		{"too many ids", BulkVisibilityRequest{IsHidden: &hide, IDs: tooMany}, ErrInvalidStoryIDs},
	}
	for _, tc := range cases {
		if _, err := service.SetHiddenMany(ctx, tc.req); !errors.Is(err, tc.want) {
			t.Fatalf("%s: got %v, want %v", tc.name, err, tc.want)
		}
	}
	for id := int64(1); id <= 5; id++ {
		if store.stories[id].IsHidden {
			t.Fatalf("rejected request changed story %d", id)
		}
	}
}

func TestAdminHideShowAndDelete(t *testing.T) {
	store := newEmptyChapterStore()
	service := newTestService(store, &fakeSource{})
	ctx := context.Background()

	hidden, err := service.SetHidden(ctx, "1", true)
	if err != nil || !hidden.IsHidden || hidden.ContentChapters != 1 {
		t.Fatalf("hide: %+v, %v", hidden, err)
	}
	if _, err := service.Detail(ctx, "1"); !errors.Is(err, ErrStoryNotFound) {
		t.Fatalf("hidden story visible to users: %v", err)
	}
	if detail, err := service.AdminDetail(ctx, "1"); err != nil || !detail.IsHidden {
		t.Fatalf("admin detail: %+v, %v", detail, err)
	}
	if shown, err := service.SetHidden(ctx, "1", false); err != nil || shown.IsHidden {
		t.Fatalf("show: %+v, %v", shown, err)
	}
	for _, id := range []string{"x", "0", "99"} {
		if _, err := service.SetHidden(ctx, id, true); !errors.Is(err, ErrStoryNotFound) {
			t.Fatalf("hide %q: %v", id, err)
		}
		if err := service.DeleteStory(ctx, id); !errors.Is(err, ErrStoryNotFound) {
			t.Fatalf("delete %q: %v", id, err)
		}
	}
	if err := service.DeleteStory(ctx, "1"); err != nil {
		t.Fatal(err)
	}
	if _, err := service.AdminDetail(ctx, "1"); !errors.Is(err, ErrStoryNotFound) {
		t.Fatalf("deleted story still found: %v", err)
	}
}

func TestAdminChapterDoesNotFetch(t *testing.T) {
	store := newEmptyChapterStore()
	source := &fakeSource{content: "mới"}
	service := newTestService(store, source)
	chapter, err := service.AdminChapter(context.Background(), "1", "1")
	if err != nil || chapter.HasContent || chapter.Content != "" || source.calls.Load() != 0 {
		t.Fatalf("got %+v, %v, calls %d", chapter, err, source.calls.Load())
	}
}

func TestRefetchChapterReplacesContent(t *testing.T) {
	store := newEmptyChapterStore()
	service := newTestService(store, &fakeSource{content: "bản mới tải lại"})
	chapter, err := service.RefetchChapter(context.Background(), "1", "2")
	if err != nil || chapter.Content != "bản mới tải lại" || !chapter.HasContent || chapter.WordCount != 4 || chapter.CrawledAt == nil {
		t.Fatalf("got %+v, %v", chapter, err)
	}
	if stored := store.chapters[1][1].ContentText; stored != "bản mới tải lại" {
		t.Fatalf("stored %q", stored)
	}
	if _, err := newTestService(store, &fakeSource{err: errEmptyContent}).RefetchChapter(context.Background(), "1", "2"); !errors.Is(err, ErrChapterContentUnavailable) {
		t.Fatalf("got %v", err)
	}
	if stored := store.chapters[1][1].ContentText; stored != "bản mới tải lại" {
		t.Fatalf("failed refetch changed content to %q", stored)
	}
}

func TestFetchMissingContentRunsInBackground(t *testing.T) {
	store := newEmptyChapterStore()
	store.chapters[1] = append(store.chapters[1], models.StoryChapter{ID: 12, StoryID: 1, Position: 3, Title: "Chương 3"})
	source := &fakeSource{content: "nội dung", release: make(chan struct{})}
	service := newTestService(store, source)
	ctx := context.Background()

	resp, err := service.FetchMissingContent(ctx, "1")
	if err != nil || resp.Queued != 2 {
		t.Fatalf("got %+v, %v", resp, err)
	}
	if _, err := service.FetchMissingContent(ctx, "1"); !errors.Is(err, ErrBulkFetchRunning) {
		t.Fatalf("second run: %v", err)
	}
	close(source.release)

	deadline := time.Now().Add(5 * time.Second)
	for {
		counts, _ := service.admin.ContentCounts(ctx, []int64{1})
		if _, running := service.bulkFetches.Load(int64(1)); counts[1] == 3 && !running {
			break
		}
		if time.Now().After(deadline) {
			t.Fatalf("bulk fetch did not finish: counts %v", counts)
		}
		time.Sleep(20 * time.Millisecond)
	}
	if resp, err := service.FetchMissingContent(ctx, "1"); err != nil || resp.Queued != 0 {
		t.Fatalf("nothing left: %+v, %v", resp, err)
	}
	if source.calls.Load() != 2 {
		t.Fatalf("source called %d times", source.calls.Load())
	}
}
