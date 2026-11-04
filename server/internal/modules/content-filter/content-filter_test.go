package contentfilter

import "testing"

func TestNormalizeContent(t *testing.T) {
	got := NormalizeContent("  Xin   chào\n\nmọi\tngười \u0007 ")
	if got != "Xin chào mọi người" {
		t.Fatalf("unexpected %q", got)
	}
}

func TestContainsLink(t *testing.T) {
	blocked := []string{"vào https://abc.xyz nhé", "www.trang.net", "ib zalo.me/123", "ghé shop abc.com", "t.me/kenre", "ABC.VN giá rẻ", "bit.ly/abc", "x.com"}
	for _, text := range blocked {
		if !ContainsLink(text) {
			t.Fatalf("expected link in %q", text)
		}
	}
	allowed := []string{"tăng 1.5 lần", "chào cả nhà.", "giá 2.000 KEN", "mai 8.30 gặp", "ok...", "ok.co ai choi ko", "chao.me oi", "gg.wp nha", "di.tv xem bong da"}
	for _, text := range allowed {
		if ContainsLink(text) {
			t.Fatalf("unexpected link in %q", text)
		}
	}
}

func TestMatchBannedWord(t *testing.T) {
	words := []string{"địt", "nạp ken giá rẻ", "zalo", "con cac"}
	blocked := []string{"Địt mẹ", "d i t", "đ.ị.t", "đị.t", "ĐỊT!!!", "ai cần NẠP KEN GIÁ RẺ ib", "nap-ken-gia-re", "napkengiare luôn", "add Zalo mình", "add za lo 0901", "z.a.l.o", "con các"}
	for _, text := range blocked {
		if _, ok := MatchBannedWord(text, words); !ok {
			t.Fatalf("expected %q to be blocked", text)
		}
	}
	allowed := []string{"đi tắm", "điều tra", "chào mọi người", "nạp ken ở đâu", "đi tìm người yêu", "con cách", "zalora shop"}
	for _, text := range allowed {
		if word, ok := MatchBannedWord(text, words); ok {
			t.Fatalf("unexpected block of %q by %q", text, word)
		}
	}
}

func TestMatchBannedWordIgnoresEmptyEntries(t *testing.T) {
	if _, ok := MatchBannedWord("xin chào", []string{"", "!!!", "  "}); ok {
		t.Fatal("empty entries must not match")
	}
}
