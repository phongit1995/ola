package main

import (
	"strings"
	"testing"
)

func TestResetNeedsExactDatabaseName(t *testing.T) {
	cases := []struct {
		input    string
		expected string
		want     bool
	}{
		{"ola_chat_server_dev\n", "ola_chat_server_dev", true},
		{"  ola_chat_server_dev  \n", "ola_chat_server_dev", true},
		{"ola_chat_server_dev", "ola_chat_server_dev", true},
		{"yes\n", "ola_chat_server_dev", false},
		{"\n", "ola_chat_server_dev", false},
		{"", "", false},
	}
	for _, c := range cases {
		if got := confirmed(strings.NewReader(c.input), c.expected); got != c.want {
			t.Errorf("confirmed(%q, %q) = %v, want %v", c.input, c.expected, got, c.want)
		}
	}
}

func TestChapterContentMatchedByID(t *testing.T) {
	chapters := []exportChapter{
		{ID: "900", Position: 1, Title: "Chương mới chèn đầu"},
		{ID: "101", Position: 2, Title: "Chương 1"},
	}
	contents := map[string]string{"101": "nội dung chương 1", "1": "nội dung theo vị trí cũ"}
	items := toChapterImports(chapters, contents)
	if items[0].Content != nil {
		t.Fatalf("inserted chapter must not take another chapter's content, got %q", *items[0].Content)
	}
	if items[1].Content == nil || *items[1].Content != "nội dung chương 1" {
		t.Fatalf("content must follow the chapter id, got %v", items[1].Content)
	}
}
