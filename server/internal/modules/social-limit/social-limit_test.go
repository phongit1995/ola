package sociallimit

import (
	"context"
	"errors"
	"net"
	"net/http"
	"strconv"
	"sync"
	"sync/atomic"
	"testing"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

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

type fakePostLimits struct{ me, moment setting.PostLimitConfig }

func (f *fakePostLimits) GetMePostLimit() (setting.PostLimitConfig, error) { return f.me, nil }

func (f *fakePostLimits) GetMomentPostLimit() (setting.PostLimitConfig, error) { return f.moment, nil }

func newPostTestService(t *testing.T, limits *fakePostLimits, vip fakeVip) *Service {
	t.Helper()
	svc := newTestService(t, setting.DefaultSocialLimitConfig(), vip)
	svc.posts = limits
	return svc
}

func expectPostLimit(t *testing.T, err error, code string) map[string]any {
	t.Helper()
	var httpErr *utils.HTTPError
	if !errors.As(err, &httpErr) || httpErr.Status != http.StatusTooManyRequests || httpErr.Code != code {
		t.Fatalf("want 429 %s, got %v", code, err)
	}
	details, _ := httpErr.Details.(map[string]any)
	return details
}

func consumePosts(t *testing.T, svc *Service, userID uuid.UUID, kind PostKind, n int) {
	t.Helper()
	for i := 0; i < n; i++ {
		if _, err := svc.ConsumePost(context.Background(), userID, kind); err != nil {
			t.Fatalf("post %d: %v", i+1, err)
		}
	}
}

func TestPostLimitKeepsCountingWhileUnlimited(t *testing.T) {
	ctx := context.Background()
	user := uuid.New()
	limits := &fakePostLimits{me: setting.PostLimitConfig{}, moment: setting.PostLimitConfig{}}
	svc := newPostTestService(t, limits, fakeVip{})

	consumePosts(t, svc, user, PostKindMe, 3)
	if got := svc.PostQuotas(ctx, user).Me; got.Used != 3 || got.Limit != 0 {
		t.Fatalf("unlimited usage %+v", got)
	}

	limits.me = setting.PostLimitConfig{NormalPerDay: 3, VipPerDay: 5}
	_, err := svc.ConsumePost(ctx, user, PostKindMe)
	expectPostLimit(t, err, ErrorCodeDailyMePostLimit)
	if got := svc.PostQuotas(ctx, user).Me; got.Used != 3 || got.Limit != 3 {
		t.Fatalf("usage after limit set %+v", got)
	}
}

func TestPostLimitAppliesOnceVipExpires(t *testing.T) {
	ctx := context.Background()
	user := uuid.New()
	vip := fakeVip{user: true}
	svc := newPostTestService(t, &fakePostLimits{me: setting.PostLimitConfig{NormalPerDay: 3, VipPerDay: 0}}, vip)

	consumePosts(t, svc, user, PostKindMe, 4)
	vip[user] = false

	_, err := svc.ConsumePost(ctx, user, PostKindMe)
	expectPostLimit(t, err, ErrorCodeDailyMePostLimit)
	if got := svc.PostQuotas(ctx, user); got.IsVip || got.Me.Used != 4 || got.Me.Limit != 3 {
		t.Fatalf("usage after vip expired %+v", got)
	}
}

func TestPostLimitConcurrentPostsNeverExceedLimit(t *testing.T) {
	ctx := context.Background()
	user := uuid.New()
	svc := newPostTestService(t, &fakePostLimits{moment: setting.PostLimitConfig{NormalPerDay: 3, VipPerDay: 5}}, fakeVip{})

	var (
		wg      sync.WaitGroup
		allowed atomic.Int32
	)
	for i := 0; i < 20; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			if _, err := svc.ConsumePost(ctx, user, PostKindMoment); err == nil {
				allowed.Add(1)
			}
		}()
	}
	wg.Wait()

	if allowed.Load() != 3 {
		t.Fatalf("allowed %d concurrent posts, want 3", allowed.Load())
	}
	if got := svc.PostQuotas(ctx, user).Moment; got.Used != 3 {
		t.Fatalf("blocked attempts must not count, got %+v", got)
	}
}

func TestPostLimitRefundsFailedPosts(t *testing.T) {
	ctx := context.Background()
	user := uuid.New()
	svc := newPostTestService(t, &fakePostLimits{moment: setting.PostLimitConfig{NormalPerDay: 1, VipPerDay: 5}}, fakeVip{})

	release, err := svc.ConsumePost(ctx, user, PostKindMoment)
	if err != nil {
		t.Fatal(err)
	}
	_, err = svc.ConsumePost(ctx, user, PostKindMoment)
	expectPostLimit(t, err, ErrorCodeDailyMomentPostLimit)

	release()
	if got := svc.PostQuotas(ctx, user).Moment; got.Used != 0 {
		t.Fatalf("refund not applied %+v", got)
	}
	consumePosts(t, svc, user, PostKindMoment, 1)
}

func TestPostLimitDayFollowsVietnamTime(t *testing.T) {
	user := uuid.New()
	before := time.Date(2026, 11, 17, 16, 59, 59, 0, time.UTC)
	after := before.Add(time.Second)

	if quotaDay(before) != "20261117" || quotaDay(after) != "20261118" {
		t.Fatalf("vietnam midnight boundary: %s -> %s", quotaDay(before), quotaDay(after))
	}
	if postKey(PostKindMe, user, quotaDay(before)) == postKey(PostKindMe, user, quotaDay(after)) {
		t.Fatal("a new vietnam day must use a fresh counter")
	}
	if postKey(PostKindMe, user, quotaDay(after)) == postKey(PostKindMoment, user, quotaDay(after)) {
		t.Fatal("me and moment counters must be separate")
	}
}

func TestPostLimitOffersVipOnlyWhenVipRaisesTheLimit(t *testing.T) {
	ctx := context.Background()
	cases := []struct {
		name string
		cfg  setting.PostLimitConfig
		vip  bool
		want bool
	}{
		{"vip has more", setting.PostLimitConfig{NormalPerDay: 3, VipPerDay: 5}, false, true},
		{"vip unlimited", setting.PostLimitConfig{NormalPerDay: 3, VipPerDay: 0}, false, true},
		{"vip same", setting.PostLimitConfig{NormalPerDay: 3, VipPerDay: 3}, false, false},
		{"vip lower", setting.PostLimitConfig{NormalPerDay: 3, VipPerDay: 2}, false, false},
		{"already vip", setting.PostLimitConfig{NormalPerDay: 1, VipPerDay: 3}, true, false},
	}
	for _, tc := range cases {
		user := uuid.New()
		svc := newPostTestService(t, &fakePostLimits{me: tc.cfg}, fakeVip{user: tc.vip})
		consumePosts(t, svc, user, PostKindMe, tc.cfg.PerDay(tc.vip))

		_, err := svc.ConsumePost(ctx, user, PostKindMe)
		details := expectPostLimit(t, err, ErrorCodeDailyMePostLimit)
		if details["upgradable"] != tc.want {
			t.Errorf("%s: upgradable %v, want %v", tc.name, details["upgradable"], tc.want)
		}
		if got := svc.PostQuotas(ctx, user).Me.Upgradable; got != tc.want {
			t.Errorf("%s: quota upgradable %v, want %v", tc.name, got, tc.want)
		}
	}
}

func TestSocialLimitOffersVipOnlyWhenVipRaisesTheLimit(t *testing.T) {
	ctx := context.Background()
	for _, vipChats := range []int{1, 2} {
		cfg := setting.DefaultSocialLimitConfig()
		cfg.Enabled = true
		cfg.Normal.NewChatsPerDay = 1
		cfg.Vip.NewChatsPerDay = vipChats
		svc := newTestService(t, cfg, fakeVip{})
		user := uuid.New()

		if _, err := svc.ConsumeNewChat(ctx, user, uuid.New()); err != nil {
			t.Fatal(err)
		}
		_, err := svc.ConsumeNewChat(ctx, user, uuid.New())
		expectLimit(t, err, ErrorCodeDailyNewChatLimit)
		var limitErr *LimitError
		errors.As(err, &limitErr)
		if want := vipChats > 1; limitErr.Upgradable != want {
			t.Errorf("vip chats %d: upgradable %v, want %v", vipChats, limitErr.Upgradable, want)
		}
	}
}
