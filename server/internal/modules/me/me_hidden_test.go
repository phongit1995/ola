package me

import (
	"testing"
	"time"

	"ola-chat-server/internal/models"
)

func TestOnlyAdminHiddenPostsExplainThemselvesToTheOwner(t *testing.T) {
	by := func(value string) *string { return &value }
	cases := []struct {
		name string
		post models.Me
		want bool
	}{
		{"visible", models.Me{Enabled: true}, false},
		{"owner deleted", models.Me{HiddenBy: by(MeHiddenByOwner)}, false},
		{"clan staff removed", models.Me{HiddenBy: by(MeHiddenByClan)}, false},
		{"disabled before hidden_by existed", models.Me{}, false},
		{"admin hidden", models.Me{HiddenBy: by(MeHiddenByAdmin)}, true},
		{"admin hid then showed again", models.Me{Enabled: true, HiddenBy: by(MeHiddenByAdmin)}, false},
	}
	for _, tc := range cases {
		if got := hiddenByAdmin(&tc.post); got != tc.want {
			t.Errorf("%s: got %v", tc.name, got)
		}
	}
}

func TestHiddenFieldsClearWhoHidWhenShownAgain(t *testing.T) {
	shown := HiddenFields(false, MeHiddenByAdmin, time.Now())
	if shown["enabled"] != true || shown["hidden_by"] != nil || shown["hidden_at"] != nil {
		t.Fatalf("shown fields: %v", shown)
	}
	hidden := HiddenFields(true, MeHiddenByOwner, time.Now())
	if hidden["enabled"] != false || hidden["hidden_by"] != MeHiddenByOwner {
		t.Fatalf("hidden fields: %v", hidden)
	}
}
