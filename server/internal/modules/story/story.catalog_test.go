package story

import (
	"context"
	"errors"
	"net/http"
	"net/http/httptest"
	"strings"
	"sync/atomic"
	"testing"
	"time"

	"ola-chat-server/internal/constants"
)

const storyPageFixture = `<html><head>
<meta property="og:image" content="https://vnkings.com/og.jpg" />
</head><body>
<ul>
<li><span>Tác giả</span>: <a href="/tac-gia/x">Dori &amp; Meui</a></li>
<li><span>Tình trạng</span>: Chưa hoàn thành</li>
<li><span>Rating</span>: [T] Không dành cho trẻ dưới 13 tuổi</li>
</ul>
<span>Lượt thích</span><strong>: 1.234</strong>
<img class="lazyload" data-original="https://vnkings.com/cover.jpg" />
<div class="chapters" data-story-id="203538" data-nonce="ebbc4c4173"></div>
</body></html>`

func TestParseStoryPage(t *testing.T) {
	info := parseStoryPage(storyPageFixture)
	if info.AuthorName != "Dori & Meui" || info.Status != constants.StoryStatusOngoing || info.AgeRating != "[T] Không dành cho trẻ dưới 13 tuổi" {
		t.Fatalf("unexpected info %+v", info)
	}
	if info.LikeCount != 1234 || info.Nonce != "ebbc4c4173" || info.CoverURL == nil || *info.CoverURL != "https://vnkings.com/cover.jpg" {
		t.Fatalf("unexpected info %+v", info)
	}
	bare := parseStoryPage(`<meta property="og:image" content="https://vnkings.com/og.jpg" /><li><span>Tình trạng</span>: Full</li>`)
	if bare.CoverURL == nil || *bare.CoverURL != "https://vnkings.com/og.jpg" || bare.Status != constants.StoryStatusCompleted || bare.Nonce != "" {
		t.Fatalf("unexpected fallback info %+v", bare)
	}
	if parseStoryPage("").Status != constants.StoryStatusUnknown {
		t.Fatal("missing status must be unknown")
	}
}

func TestParseChapterLinks(t *testing.T) {
	items := `<li><a href="https://vnkings.com/truyen-x-p203539.html">Chương 1: <b>Mở màn</b></a>
		<i class="pull-right">18/11/2022 10:28</i></li>
		<li><a href="https://vnkings.com/khac.html">Ngoại truyện</a><i class="pull-right">1/2/2023</i></li>`
	links := parseChapterLinks(items)
	if len(links) != 2 {
		t.Fatalf("got %d links", len(links))
	}
	if links[0].SourceID != "203539" || links[0].Title != "Chương 1: Mở màn" || links[0].DateLabel != "18/11/2022 10:28" {
		t.Fatalf("unexpected first link %+v", links[0])
	}
	if links[1].SourceID != "https://vnkings.com/khac.html" {
		t.Fatalf("link without post id must keep href, got %+v", links[1])
	}
}

func TestChapterDateUsesVietnamMidnight(t *testing.T) {
	got := chapterDate("18/11/2022 10:28")
	want := time.Date(2022, 11, 17, 17, 0, 0, 0, time.UTC)
	if got == nil || !got.Equal(want) {
		t.Fatalf("got %v, want %v", got, want)
	}
	if chapterDate("hôm qua") != nil {
		t.Fatal("unparseable label must give nil")
	}
}

func TestParseChapterPage(t *testing.T) {
	failed, err := parseChapterPage([]byte(`{"success":false,"data":{"message":"Truyện không tồn tại"}}`))
	if err != nil || failed.Success {
		t.Fatalf("got %+v, %v", failed, err)
	}
	numeric, err := parseChapterPage([]byte(`{"success":true,"data":{"items":"<li></li>","totalPages":3}}`))
	if err != nil || !numeric.Success || numeric.Data.TotalPages != 3 {
		t.Fatalf("got %+v, %v", numeric, err)
	}
	text, err := parseChapterPage([]byte(`{"success":true,"data":{"items":"","totalPages":"2"}}`))
	if err != nil || text.Data.TotalPages != 2 {
		t.Fatalf("got %+v, %v", text, err)
	}
}

func testCatalog() *VnkingsCatalog {
	catalog := NewVnkingsCatalog()
	catalog.gap = 0
	catalog.retryWait = time.Millisecond
	return catalog
}

func TestCatalogStatusHandling(t *testing.T) {
	var hits atomic.Int32
	statuses := map[string]int{"/blocked": http.StatusTooManyRequests, "/gone": http.StatusNotFound, "/flaky": http.StatusBadGateway}
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		hits.Add(1)
		if status, ok := statuses[r.URL.Path]; ok {
			w.WriteHeader(status)
			return
		}
		w.Header().Set("Content-Type", "text/html")
		_, _ = w.Write([]byte("<html></html>"))
	}))
	defer server.Close()
	catalog := testCatalog()
	ctx := context.Background()

	if _, _, err := catalog.do(ctx, http.MethodGet, server.URL+"/blocked", nil); !errors.Is(err, errSourceBlocked) {
		t.Fatalf("429 must be blocked, got %v", err)
	}
	if _, _, err := catalog.do(ctx, http.MethodGet, server.URL+"/gone", nil); !errors.Is(err, errStoryGone) {
		t.Fatalf("404 must be gone, got %v", err)
	}
	hits.Store(0)
	if _, _, err := catalog.do(ctx, http.MethodGet, server.URL+"/flaky", nil); err == nil {
		t.Fatal("502 must fail after retries")
	}
	if got := hits.Load(); got != int32(constants.StoryCrawlRetries+1) {
		t.Fatalf("502 must be retried, got %d attempts", got)
	}
	var out []int
	if _, err := catalog.getJSON(ctx, server.URL+"/html", &out); err == nil {
		t.Fatal("HTML body must be rejected for JSON endpoints")
	}
	if catalog.Requests() == 0 {
		t.Fatal("requests must be counted")
	}
}

func TestCatalogGap(t *testing.T) {
	catalog := testCatalog()
	catalog.gap = 30 * time.Millisecond
	start := time.Now()
	for range 3 {
		if err := catalog.wait(context.Background()); err != nil {
			t.Fatal(err)
		}
	}
	if elapsed := time.Since(start); elapsed < 60*time.Millisecond {
		t.Fatalf("requests must be spaced by the gap, elapsed %v", elapsed)
	}
}

func TestCatalogSendsCookieAndChecksLogin(t *testing.T) {
	var received atomic.Value
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		received.Store(r.Header.Get("Cookie"))
		w.Header().Set("Content-Type", "text/html")
		if r.Header.Get("Cookie") == "wordpress_logged_in_x=good" {
			_, _ = w.Write([]byte(`<a href="https://vnkings.com/wp-login.php?action=logout">Thoát</a>`))
			return
		}
		_, _ = w.Write([]byte(`<a href="https://vnkings.com/dang-nhap.html" class="login_plus">Đăng nhập</a>`))
	}))
	defer server.Close()
	catalog := testCatalog()
	catalog.homeURL = server.URL
	ctx := context.Background()

	cases := []struct {
		cookie string
		want   bool
	}{
		{" wordpress_logged_in_x=good ", true},
		{"wordpress_logged_in_x=expired", false},
		{"", false},
	}
	for _, tc := range cases {
		catalog.SetCookie(tc.cookie)
		got, err := catalog.CheckLogin(ctx)
		if err != nil || got != tc.want {
			t.Fatalf("cookie %q: got %v %v, want %v", tc.cookie, got, err, tc.want)
		}
		if sent, _ := received.Load().(string); sent != strings.TrimSpace(tc.cookie) {
			t.Fatalf("cookie header %q, want %q", sent, strings.TrimSpace(tc.cookie))
		}
	}
	if parseStoryPage(`<a class="login_plus">Đăng nhập</a>`).LoggedIn {
		t.Fatal("guest story page must not count as logged in")
	}
	if !parseStoryPage(`<div class="story"></div>`).LoggedIn {
		t.Fatal("page without the guest link must not kill a cookie")
	}
}
