package moment

import (
	"errors"
	"testing"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type fakeVideoSettings struct {
	cfg setting.MomentVideoConfig
	err error
}

func (f fakeVideoSettings) GetMomentVideo() (setting.MomentVideoConfig, error) {
	return f.cfg, f.err
}

type fakeVipUsers struct {
	user *models.User
	err  error
}

func (f fakeVipUsers) GetUserCache(uuid.UUID, bool) (*models.User, error) {
	return f.user, f.err
}

func TestCheckVideoAllowed(t *testing.T) {
	now := time.Date(2026, 10, 27, 10, 0, 0, 0, time.UTC)
	future := now.Add(24 * time.Hour)
	past := now.Add(-time.Hour)
	vip := &models.User{VipEndTime: &future}
	expired := &models.User{VipEndTime: &past}
	regular := &models.User{}
	required := setting.MomentVideoConfig{VipRequired: true}
	logger := zap.NewNop().Sugar()

	cases := []struct {
		name     string
		settings fakeVideoSettings
		users    fakeVipUsers
		wantErr  error
	}{
		{"default allows everyone", fakeVideoSettings{cfg: setting.DefaultMomentVideoConfig()}, fakeVipUsers{user: regular}, nil},
		{"unreadable setting allows", fakeVideoSettings{err: errors.New("db down")}, fakeVipUsers{user: regular}, nil},
		{"required allows active VIP", fakeVideoSettings{cfg: required}, fakeVipUsers{user: vip}, nil},
		{"required blocks non VIP", fakeVideoSettings{cfg: required}, fakeVipUsers{user: regular}, errVideoVipRequired},
		{"required blocks expired VIP", fakeVideoSettings{cfg: required}, fakeVipUsers{user: expired}, errVideoVipRequired},
		{"required blocks unknown user", fakeVideoSettings{cfg: required}, fakeVipUsers{}, errVideoVipRequired},
	}
	for _, tc := range cases {
		err := checkVideoAllowed(tc.settings, tc.users, uuid.New(), now, logger)
		if !errors.Is(err, tc.wantErr) {
			t.Fatalf("%s: got %v, want %v", tc.name, err, tc.wantErr)
		}
	}

	if err := checkVideoAllowed(fakeVideoSettings{cfg: required}, fakeVipUsers{err: errors.New("cache down")}, uuid.New(), now, logger); err == nil || errors.Is(err, errVideoVipRequired) {
		t.Fatalf("lookup failure should surface as an internal error, got %v", err)
	}
}
