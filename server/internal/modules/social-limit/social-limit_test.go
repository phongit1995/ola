package sociallimit

import (
	"context"
	"errors"
	"net"
	"net/http"
	"strconv"
	"testing"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"

	miniredis "github.com/alicebob/miniredis/v2"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type fakeConfig struct{ cfg setting.SocialLimitConfig }

func (f fakeConfig) GetSocialLimit() (setting.SocialLimitConfig, error) { return f.cfg, nil }

type fakeVip map[uuid.UUID]bool

func (f fakeVip) HasActiveVip(userID uuid.UUID, _ time.Time) (bool, error) { return f[userID], nil }

func newTestService(t *testing.T, cfg setting.SocialLimitConfig, vip fakeVip) *Service {
	t.Helper()
	server := miniredis.RunT(t)
	host, portValue, err := net.SplitHostPort(server.Addr())
	if err != nil {
		t.Fatal(err)
	}
	port, err := strconv.Atoi(portValue)
	if err != nil {
		t.Fatal(err)
	}
	cache, err := services.NewCacheService(&config.Config{RedisHost: host, RedisPort: port}, zap.NewNop().Sugar())
	if err != nil {
		t.Fatalf("create cache service: %v", err)
	}
	t.Cleanup(func() { _ = cache.Close() })
	return newService(fakeConfig{cfg}, cache, vip, zap.NewNop().Sugar())
}

func expectLimit(t *testing.T, err error, code string) {
	t.Helper()
	var limitErr *LimitError
	if !errors.As(err, &limitErr) || limitErr.Code != code {
		t.Fatalf("want limit error %s, got %v", code, err)
	}
}

func TestNewChatLimitCountsDistinctPeoplePerDay(t *testing.T) {
	svc := newTestService(t, setting.DefaultSocialLimitConfig(), fakeVip{})
	ctx := context.Background()
	user := uuid.New()
	targets := make([]uuid.UUID, 6)
	for i := range targets {
		targets[i] = uuid.New()
	}

	for i := 0; i < 5; i++ {
		if _, err := svc.ConsumeNewChat(ctx, user, targets[i]); err != nil {
			t.Fatalf("chat %d should pass: %v", i+1, err)
		}
	}
	if _, err := svc.ConsumeNewChat(ctx, user, targets[0]); err != nil {
		t.Fatalf("same person again must not use another slot: %v", err)
	}
	_, err := svc.ConsumeNewChat(ctx, user, targets[5])
	expectLimit(t, err, ErrorCodeDailyNewChatLimit)

	if _, err := svc.ConsumeFriendRequest(ctx, user, targets[5]); err != nil {
		t.Fatalf("friend request quota is separate from new chat quota: %v", err)
	}
}

func TestReleaseRefundsSlot(t *testing.T) {
	cfg := setting.DefaultSocialLimitConfig()
	cfg.Normal.FriendRequestsPerDay = 1
	svc := newTestService(t, cfg, fakeVip{})
	ctx := context.Background()
	user := uuid.New()

	release, err := svc.ConsumeFriendRequest(ctx, user, uuid.New())
	if err != nil {
		t.Fatal(err)
	}
	release()
	if _, err := svc.ConsumeFriendRequest(ctx, user, uuid.New()); err != nil {
		t.Fatalf("slot should be refunded: %v", err)
	}
	_, err = svc.ConsumeFriendRequest(ctx, user, uuid.New())
	expectLimit(t, err, ErrorCodeDailyFriendRequestLimit)
}

func TestVipUsesVipTier(t *testing.T) {
	cfg := setting.DefaultSocialLimitConfig()
	cfg.Normal.NewChatsPerDay = 1
	cfg.Vip.NewChatsPerDay = 3
	vipUser, normalUser := uuid.New(), uuid.New()
	svc := newTestService(t, cfg, fakeVip{vipUser: true})
	ctx := context.Background()

	for i := 0; i < 3; i++ {
		if _, err := svc.ConsumeNewChat(ctx, vipUser, uuid.New()); err != nil {
			t.Fatalf("vip chat %d should pass: %v", i+1, err)
		}
	}
	_, err := svc.ConsumeNewChat(ctx, vipUser, uuid.New())
	expectLimit(t, err, ErrorCodeDailyNewChatLimit)
	var vipErr *LimitError
	if !errors.As(err, &vipErr) || !vipErr.Vip || vipErr.Limit != 3 {
		t.Fatalf("vip limit error = %+v", vipErr)
	}

	if _, err := svc.ConsumeNewChat(ctx, normalUser, uuid.New()); err != nil {
		t.Fatal(err)
	}
	_, err = svc.ConsumeNewChat(ctx, normalUser, uuid.New())
	expectLimit(t, err, ErrorCodeDailyNewChatLimit)

	if maxFriends, maxPending := svc.FriendCaps(vipUser); maxFriends != cfg.Vip.MaxFriends || maxPending != cfg.Vip.MaxPendingRequests {
		t.Fatalf("vip caps = %d/%d", maxFriends, maxPending)
	}
	if maxFriends, _ := svc.FriendCaps(normalUser); maxFriends != cfg.Normal.MaxFriends {
		t.Fatalf("normal max friends = %d", maxFriends)
	}
}

func TestDisabledSkipsDailyLimitsButKeepsFriendCaps(t *testing.T) {
	cfg := setting.DefaultSocialLimitConfig()
	cfg.Enabled = false
	cfg.Normal.NewChatsPerDay = 0
	svc := newTestService(t, cfg, fakeVip{})
	user := uuid.New()

	if _, err := svc.ConsumeNewChat(context.Background(), user, uuid.New()); err != nil {
		t.Fatalf("disabled config must not limit: %v", err)
	}
	if maxFriends, _ := svc.FriendCaps(user); maxFriends != cfg.Normal.MaxFriends {
		t.Fatalf("friend cap must still apply, got %d", maxFriends)
	}
}

func TestHTTPErrorMapsTo429WithCode(t *testing.T) {
	httpErr := HTTPError(&LimitError{Code: ErrorCodeDailyNewChatLimit, Limit: 5})
	if httpErr == nil || httpErr.Status != http.StatusTooManyRequests || httpErr.Code != ErrorCodeDailyNewChatLimit {
		t.Fatalf("unexpected http error %+v", httpErr)
	}
	details, ok := httpErr.Details.(map[string]any)
	if !ok || details["limit"] != 5 || details["isVip"] != false {
		t.Fatalf("unexpected details %+v", httpErr.Details)
	}
	if HTTPError(errors.New("other")) != nil {
		t.Fatal("non-limit errors must not map")
	}
}
