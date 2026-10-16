package story

import (
	"context"
	"errors"
	"reflect"
	"testing"

	"ola-chat-server/internal/models"
)

func TestPageParagraphs(t *testing.T) {
	page := []byte(`<!doctype html><html><head><title>Chương 3</title><script>var x = 1;</script></head>
<body>
<div class="sidebar"><p>Truyện đề cử</p></div>
<div id="content" class="vnkings-editor">
	<p>Chương 3</p>
	<p>Mưa&nbsp;rơi   trên <em>mái</em> ngói.<br>Gió thổi.</p>
	<p>* * *</p>
	<ins class="adsbygoogle">quảng cáo</ins>
	<script>track()</script>
	<div><span>Cô ấy</span> <strong>cười</strong>.</div>
	<p>&nbsp;</p>
	<h3>Phần hai</h3>
	<ul><li>Một</li><li>Hai</li></ul>
	<blockquote>“Đi thôi.”</blockquote>
</div>
<div class="comments"><p>Bình luận</p></div>
</body></html>`)

	paragraphs, err := pageParagraphs(page, "content")
	if err != nil {
		t.Fatal(err)
	}
	want := []string{"Chương 3", "Mưa rơi trên mái ngói.", "Gió thổi.", "Cô ấy cười.", "Phần hai", "Một", "Hai", "“Đi thôi.”"}
	if !reflect.DeepEqual(paragraphs, want) {
		t.Fatalf("got %q", paragraphs)
	}
	if got := dropRepeatedTitle(paragraphs, " chương  3 "); !reflect.DeepEqual(got, want[1:]) {
		t.Fatalf("dropRepeatedTitle: got %q", got)
	}
	if got := dropRepeatedTitle(paragraphs, "Chương 4"); len(got) != len(want) {
		t.Fatalf("kept title mismatch: got %q", got)
	}
}

func TestPageParagraphsWithoutContent(t *testing.T) {
	if _, err := pageParagraphs([]byte(`<html><body><p>404</p></body></html>`), "content"); !errors.Is(err, errContentNotFound) {
		t.Fatalf("got %v", err)
	}
}

func TestFragmentParagraphs(t *testing.T) {
	paragraphs, err := fragmentParagraphs(`<p>Con chày đất</p><p>Nhà tôi ở <a href="#">bến sông</a>.</p><p>___</p><p>UỲNH!</p>`)
	if err != nil {
		t.Fatal(err)
	}
	want := []string{"Con chày đất", "Nhà tôi ở bến sông.", "UỲNH!"}
	if !reflect.DeepEqual(paragraphs, want) {
		t.Fatalf("got %q", paragraphs)
	}
}

func TestLockedAtSource(t *testing.T) {
	guest := []byte(`<div class="vnkings-editor" id="content"><div class="vnktop_border"></div>
	Ở Nam Định có một làng nghề rèn đúc khá nổi tiếng là làng Kim Yên. [&hellip;]<br/><p style="text-align:center;color:red">Bạn cần <a target="_blank" href="https://vnkings.com/dang-nhap.html?postref=255747"><b>đăng nhập</b></a> để đọc truyện này!</p><div class="vnkbot_border"></div></div>`)
	paragraphs, err := pageParagraphs(guest, "content")
	if err != nil {
		t.Fatal(err)
	}
	if !lockedAtSource(paragraphs) {
		t.Fatalf("guest notice not detected: %q", paragraphs)
	}
	if !lockedAtSource([]string{"Jack cũng […]", "Bạn cần 10 Xu để đọc chương này! Hiện tại bạn không đủ xu! Xu của bạn: 0 Nạp Xu"}) {
		t.Fatal("paid notice not detected")
	}
	if lockedAtSource([]string{"Cô ấy bảo bạn cần đăng nhập vào máy tính trước.", "Bạn cần đọc truyện này!"}) {
		t.Fatal("normal text detected as locked")
	}
}

func TestVnkingsShortStoryNeedsNumericPostID(t *testing.T) {
	source := NewVnkingsService()
	for _, id := range []string{"", "abc", "12/../users", "-5", "1e3"} {
		row := &ChapterRow{StorySource: StorySourceVnkings, StoryKind: StoryKindShort, StorySourceID: id}
		if _, err := source.ShortStoryContent(context.Background(), row); !errors.Is(err, errUnsupportedSource) {
			t.Fatalf("post id %q: got %v", id, err)
		}
	}
}

func TestVnkingsChapterNeedsVnkingsURL(t *testing.T) {
	source := NewVnkingsService()
	for _, link := range []string{"", "http://vnkings.com/a-p1.html", "https://evil.example/a-p1.html", "https://vnkings.com.evil.example/a-p1.html"} {
		row := &ChapterRow{StoryChapter: models.StoryChapter{SourceURL: link}, StorySource: StorySourceVnkings, StoryKind: StoryKindLong}
		if _, err := source.ChapterContent(context.Background(), row); !errors.Is(err, errUnsupportedSource) {
			t.Fatalf("url %q: got %v", link, err)
		}
	}
}
