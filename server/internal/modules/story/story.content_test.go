package story

import (
	"errors"
	"reflect"
	"testing"
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
