package me

import (
	"context"
	"testing"
	"time"

	"ola-chat-server/internal/models"
	sociallimit "ola-chat-server/internal/modules/social-limit"

	"github.com/google/uuid"
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

type fakePostQuota struct{ kinds []sociallimit.PostKind }

func (f *fakePostQuota) ConsumePost(_ context.Context, _ uuid.UUID, kind sociallimit.PostKind) (func(), error) {
	f.kinds = append(f.kinds, kind)
	return func() {}, nil
}

func TestClanPostsSkipTheDailyMePostQuota(t *testing.T) {
	quota := &fakePostQuota{}
	svc := &Service{postLimits: quota}
	clanID := uuid.New()

	if _, err := svc.consumePostQuota(uuid.New(), &clanID); err != nil {
		t.Fatal(err)
	}
	if len(quota.kinds) != 0 {
		t.Fatalf("clan post consumed quota %v", quota.kinds)
	}
	if _, err := svc.consumePostQuota(uuid.New(), nil); err != nil {
		t.Fatal(err)
	}
	if len(quota.kinds) != 1 || quota.kinds[0] != sociallimit.PostKindMe {
		t.Fatalf("personal post must consume one Me quota, got %v", quota.kinds)
	}
}
