package story

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"ola-chat-server/internal/models"
)

const rookiesReadingJSON = `{"component":"Novels/Reading_Full_view","props":{"novels":{
	"chapter_detail":{"id":%s,"title":["Mở đầu"],"is_vip":0,"is_preview":0,"price_coin_1":0,"price_coin_2":0,
		"content":"&lt;p&gt;Mở đầu&lt;/p&gt;&lt;p&gt;Đoạn một.&lt;/p&gt;&lt;p&gt;Đoạn hai.&lt;/p&gt;"},
	"novels_detail":{"novels_chapters_detail":[
		{"id":1,"title":"Mở đầu","is_vip":0,"content":"&lt;p&gt;Đoạn một.&lt;/p&gt;"},
		{"id":2,"title":"Chương 2","is_vip":0,"price_coin_1":0,"content":"&lt;p&gt;Chương hai miễn phí.&lt;/p&gt;"},
		{"id":3,"title":"Chương 3","is_vip":1,"content":"&lt;p&gt;Nội dung VIP.&lt;/p&gt;"},
		{"id":4,"title":"Chương 4","price_coin_2":5,"content":"&lt;p&gt;Chương có giá.&lt;/p&gt;"},
		{"id":5,"title":"Chương 5","is_preview":1,"content":"&lt;p&gt;Chương đọc trước.&lt;/p&gt;"},
		{"id":6,"title":"Chương 6","is_ban":1,"content":"&lt;p&gt;Chương bị khoá.&lt;/p&gt;"}
	]}}}}`

func rookiesReadingServer(t *testing.T, chapterJSON string) *httptest.Server {
	t.Helper()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/" {
			_, _ = w.Write([]byte(rookiesHome("v1")))
			return
		}
		if r.Header.Get("X-Inertia-Partial-Component") != StoryRookiesReadingComponent {
			t.Errorf("reading page must ask for the reading component, got %v", r.Header)
		}
		_, _ = w.Write([]byte(chapterJSON))
	}))
	t.Cleanup(server.Close)
	return server
}

func testRookiesService(site string) *RookiesService {
	return &RookiesService{client: testRookiesClient(site), slots: make(chan struct{}, 1)}
}

func rookiesRow(sourceURL, sourceChapterID string) *ChapterRow {
	return &ChapterRow{
		StoryChapter: models.StoryChapter{SourceURL: sourceURL, SourceChapterID: sourceChapterID, Title: "Mở đầu"},
		StorySource:  StorySourceRookies,
		StoryKind:    StoryKindLong,
	}
}

func TestRookiesServiceKeepsOnlyFreeSiblings(t *testing.T) {
	server := rookiesReadingServer(t, fmt.Sprintf(rookiesReadingJSON, "1"))
	text, siblings, err := testRookiesService(server.URL).ChapterWithSiblings(context.Background(), rookiesRow("https://rookies.vn/truyen/truyen-7/1", "1"))
	if err != nil {
		t.Fatal(err)
	}
	if text != "Đoạn một.\n\nĐoạn hai." {
		t.Fatalf("unexpected text %q", text)
	}
	if len(siblings) != 1 || siblings["2"] != "Chương hai miễn phí." {
		t.Fatalf("only the free sibling may be kept, got %v", siblings)
	}
}

func TestRookiesServiceRefusesPaidChapter(t *testing.T) {
	paid := strings.Replace(fmt.Sprintf(rookiesReadingJSON, "3"), `"is_vip":0,"is_preview":0`, `"is_vip":1,"is_preview":0`, 1)
	server := rookiesReadingServer(t, paid)
	_, _, err := testRookiesService(server.URL).ChapterWithSiblings(context.Background(), rookiesRow("https://rookies.vn/truyen/truyen-7/3", "3"))
	if !errors.Is(err, errChapterLocked) {
		t.Fatalf("paid chapter must be refused, got %v", err)
	}
}

func TestRookiesServiceChecksChapterURL(t *testing.T) {
	service := testRookiesService("http://127.0.0.1:1")
	bad := []struct{ url, id string }{
		{"http://rookies.vn/truyen/truyen-7/1", "1"},
		{"https://rookies.vn.evil.example/truyen/truyen-7/1", "1"},
		{"https://rookies.vn/truyen/truyen-7", "1"},
		{"https://rookies.vn/truyen/truyen-7/abc", "abc"},
		{"https://rookies.vn/truyen/../admin/1", "1"},
		{"https://rookies.vn/truyen/truyen-7/2", "1"},
	}
	for _, tc := range bad {
		if _, _, err := service.ChapterWithSiblings(context.Background(), rookiesRow(tc.url, tc.id)); !errors.Is(err, errUnsupportedSource) {
			t.Fatalf("%s: got %v", tc.url, err)
		}
	}
	if service.client.Requests() != 0 {
		t.Fatalf("bad URLs must not reach rookies, requests %d", service.client.Requests())
	}
}

func TestLoadContentSavesFreeSiblings(t *testing.T) {
	store := newFakeStore(1)
	story := testID(1)
	store.chapters[story] = []models.StoryChapter{
		{ID: testID(101), StoryID: story, SourceChapterID: "1", Position: 1, Title: "Mở đầu"},
		{ID: testID(102), StoryID: story, SourceChapterID: "2", Position: 2, Title: "Chương 2"},
	}
	server := rookiesReadingServer(t, fmt.Sprintf(rookiesReadingJSON, "1"))
	service := newTestService(store, &fakeSource{})
	service.sources[StorySourceRookies] = testRookiesService(server.URL)

	row := rookiesRow("https://rookies.vn/truyen/truyen-7/1", "1")
	row.ID, row.StoryID = testID(101), story
	filled, err := service.loadChapterContent(context.Background(), row, false)
	if err != nil {
		t.Fatal(err)
	}
	if row.ContentText != "Đoạn một.\n\nĐoạn hai." {
		t.Fatalf("unexpected content %q", row.ContentText)
	}
	if len(filled) != 1 || filled[0] != testID(102) || store.chapters[story][1].ContentText != "Chương hai miễn phí." {
		t.Fatalf("free sibling must be saved, filled %v chapters %+v", filled, store.chapters[story])
	}
}
