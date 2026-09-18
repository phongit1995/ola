package push

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"strings"
	"testing"
	"time"

	"firebase.google.com/go/v4/messaging"
	"go.uber.org/zap"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
)

type fakeConns struct{ count int }

func (f *fakeConns) GetConnectionCount(string) int { return f.count }

type fakeCache struct {
	values map[string]string
	failed bool
}

func newFakeCache() *fakeCache { return &fakeCache{values: map[string]string{}} }

func (f *fakeCache) Exists(key string) (bool, error) {
	if f.failed {
		return false, errors.New("redis down")
	}
	_, ok := f.values[key]
	return ok, nil
}

func (f *fakeCache) SetNX(key string, value interface{}, _ time.Duration) (bool, error) {
	if f.failed {
		return false, errors.New("redis down")
	}
	if _, ok := f.values[key]; ok {
		return false, nil
	}
	f.values[key] = fmt.Sprintf("%v", value)
	return true, nil
}

func (f *fakeCache) DeleteIfValue(key string, value interface{}) (bool, error) {
	if f.values[key] == fmt.Sprintf("%v", value) {
		delete(f.values, key)
		return true, nil
	}
	return false, nil
}

func (f *fakeCache) Get(key string, dest interface{}) error {
	if f.failed {
		return errors.New("redis down")
	}
	raw, ok := f.values[key]
	if !ok {
		return errors.New("key not found")
	}
	return json.Unmarshal([]byte(raw), dest)
}

func (f *fakeCache) Set(key string, value interface{}, _ time.Duration) error {
	if f.failed {
		return errors.New("redis down")
	}
	raw, err := json.Marshal(value)
	if err != nil {
		return err
	}
	f.values[key] = string(raw)
	return nil
}

func (f *fakeCache) Delete(key string) error {
	delete(f.values, key)
	return nil
}

func (f *fakeCache) GetDel(key string, dest interface{}) error {
	if err := f.Get(key, dest); err != nil {
		return err
	}
	delete(f.values, key)
	return nil
}

type fakeStore struct {
	tokens       []models.DeviceToken
	tokensErr    error
	deleted      []string
	notifMessage bool
	pushDisabled bool
}

func (f *fakeStore) PushEnabled() bool { return !f.pushDisabled }

func (f *fakeStore) ActiveTokens(string) ([]models.DeviceToken, error) {
	return f.tokens, f.tokensErr
}

func (f *fakeStore) DeleteToken(token string) error {
	f.deleted = append(f.deleted, token)
	return nil
}

func (f *fakeStore) NotifMessageEnabled(string) bool { return f.notifMessage }

type fakeFCM struct {
	resp   *messaging.BatchResponse
	err    error
	sent   [][]*messaging.Message
	onSend func()
}

func (f *fakeFCM) Enabled() bool { return true }

func (f *fakeFCM) SendEach(_ context.Context, msgs []*messaging.Message) (*messaging.BatchResponse, error) {
	f.sent = append(f.sent, msgs)
	if f.onSend != nil {
		hook := f.onSend
		f.onSend = nil
		hook()
	}
	if f.err != nil {
		return nil, f.err
	}
	if f.resp != nil {
		return f.resp, nil
	}
	responses := make([]*messaging.SendResponse, len(msgs))
	for i := range msgs {
		responses[i] = &messaging.SendResponse{Success: true}
	}
	return &messaging.BatchResponse{SuccessCount: len(msgs), Responses: responses}, nil
}

func newTestSender(fcm fcmSender, cache cacheStore, conns ConnectionCounter, store tokenStore) *Sender {
	s := &Sender{
		fcm:    fcm,
		cache:  cache,
		conns:  conns,
		store:  store,
		logger: zap.NewNop().Sugar(),
		jobs:   make(chan func(), 16),
	}
	testScheduled = nil
	s.schedule = func(_ time.Duration, fn func()) { testScheduled = append(testScheduled, fn) }
	return s
}

var testScheduled []func()

func runScheduled(s *Sender) {
	fns := testScheduled
	testScheduled = nil
	for _, fn := range fns {
		fn()
	}
	drainJobs(s)
}

func drainJobs(s *Sender) {
	for {
		select {
		case job := <-s.jobs:
			job()
		default:
			return
		}
	}
}

func oneToken() []models.DeviceToken {
	return []models.DeviceToken{{Token: "tok-1", Platform: "android"}}
}

func TestProcessSkipsWhenOnlineForeground(t *testing.T) {
	fcm := &fakeFCM{}
	s := newTestSender(fcm, newFakeCache(), &fakeConns{count: 1}, &fakeStore{tokens: oneToken(), notifMessage: true})
	s.process("u1", "dm:c1", "m1", true, buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"}))
	if len(fcm.sent) != 0 {
		t.Fatalf("expected no send, got %d", len(fcm.sent))
	}
}

func TestProcessSendsWhenOnlineButBackground(t *testing.T) {
	fcm := &fakeFCM{}
	cache := newFakeCache()
	cache.values[fmt.Sprintf(constants.CacheKeyPresenceBackground, "u1")] = "1"
	s := newTestSender(fcm, cache, &fakeConns{count: 1}, &fakeStore{tokens: oneToken(), notifMessage: true})
	s.process("u1", "dm:c1", "m1", true, buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"}))
	if len(fcm.sent) != 1 {
		t.Fatalf("expected 1 send, got %d", len(fcm.sent))
	}
}

func TestProcessSendsWhenOffline(t *testing.T) {
	fcm := &fakeFCM{}
	s := newTestSender(fcm, newFakeCache(), &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	s.process("u1", "dm:c1", "m1", true, buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"}))
	if len(fcm.sent) != 1 {
		t.Fatalf("expected 1 send, got %d", len(fcm.sent))
	}
}

func TestProcessNotifMessageGateBlocksDMOnly(t *testing.T) {
	fcm := &fakeFCM{}
	store := &fakeStore{tokens: oneToken(), notifMessage: false}
	s := newTestSender(fcm, newFakeCache(), &fakeConns{}, store)

	s.process("u1", "dm:c1", "m1", true, buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"}))
	if len(fcm.sent) != 0 {
		t.Fatalf("expected DM blocked by setting, got %d sends", len(fcm.sent))
	}

	s.process("u1", constants.PushSourceMeNotif, "n1", false, buildMeNotifContent("n1", "Hoa", models.MeNotificationLike, "", 0))
	if len(fcm.sent) != 1 {
		t.Fatalf("expected me notification to bypass setting gate, got %d sends", len(fcm.sent))
	}
}

func TestProcessNoTokensDoesNotConsumeThrottle(t *testing.T) {
	fcm := &fakeFCM{}
	cache := newFakeCache()
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{notifMessage: true})
	s.process("u1", "dm:c1", "m1", true, buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"}))
	if len(cache.values) != 0 {
		t.Fatalf("expected no cache keys written, got %v", cache.values)
	}
}

func TestProcessThrottleSuppressesSecondSend(t *testing.T) {
	fcm := &fakeFCM{}
	cache := newFakeCache()
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	content := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"})
	s.process("u1", "dm:c1", "m1", true, content)
	s.process("u1", "dm:c1", "m2", true, content)
	if len(fcm.sent) != 1 {
		t.Fatalf("expected second send throttled, got %d", len(fcm.sent))
	}
}

func TestProcessTrailingSendsLatestPendingAfterWindow(t *testing.T) {
	fcm := &fakeFCM{}
	cache := newFakeCache()
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	first := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct", SenderName: "An", Preview: "1", UnreadCount: 1})
	second := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct", SenderName: "An", Preview: "2", UnreadCount: 2})
	third := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct", SenderName: "An", Preview: "3", UnreadCount: 3})
	s.process("u1", "dm:c1", "m1", true, first)
	s.process("u1", "dm:c1", "m2", true, second)
	s.process("u1", "dm:c1", "m3", true, third)
	if len(fcm.sent) != 1 || len(testScheduled) != 1 {
		t.Fatalf("expected one send and one scheduled flush, got %d sends %d scheduled", len(fcm.sent), len(testScheduled))
	}

	delete(cache.values, fmt.Sprintf(constants.CacheKeyPushThrottle, "u1", "dm:c1"))
	runScheduled(s)
	if len(fcm.sent) != 2 {
		t.Fatalf("expected trailing send, got %d", len(fcm.sent))
	}
	data := fcm.sent[1][0].Data
	if data["body"] != "3" || data["unreadCount"] != "3" {
		t.Fatalf("expected latest pending content, got %v", data)
	}
	if _, ok := cache.values[fmt.Sprintf(constants.CacheKeyPushPending, "u1", "dm:c1")]; ok {
		t.Fatal("expected pending key cleared")
	}

	delete(cache.values, fmt.Sprintf(constants.CacheKeyPushThrottle, "u1", "dm:c1"))
	runScheduled(s)
	if len(fcm.sent) != 2 {
		t.Fatalf("expected no send without pending, got %d", len(fcm.sent))
	}
}

func TestProcessFreshSendSupersedesOlderPending(t *testing.T) {
	fcm := &fakeFCM{}
	cache := newFakeCache()
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	mk := func(body string, unread int) Content {
		return buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct", SenderName: "An", Preview: body, UnreadCount: unread})
	}
	s.process("u1", "dm:c1", "m1", true, mk("1", 1))
	s.process("u1", "dm:c1", "m2", true, mk("2", 2))
	delete(cache.values, fmt.Sprintf(constants.CacheKeyPushThrottle, "u1", "dm:c1"))
	s.process("u1", "dm:c1", "m3", true, mk("3", 3))
	if len(fcm.sent) != 2 {
		t.Fatalf("expected m1 and m3 sent, got %d", len(fcm.sent))
	}
	if _, ok := cache.values[fmt.Sprintf(constants.CacheKeyPushPending, "u1", "dm:c1")]; ok {
		t.Fatal("expected older pending cleared by the fresh send")
	}
	delete(cache.values, fmt.Sprintf(constants.CacheKeyPushThrottle, "u1", "dm:c1"))
	runScheduled(s)
	if len(fcm.sent) != 2 {
		t.Fatalf("expected no stale trailing send, got %d", len(fcm.sent))
	}
}

func TestProcessPendingStoredDuringInFlightSendSurvives(t *testing.T) {
	fcm := &fakeFCM{}
	cache := newFakeCache()
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	first := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct", SenderName: "An", Preview: "1", UnreadCount: 1})
	second := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct", SenderName: "An", Preview: "2", UnreadCount: 2})
	fcm.onSend = func() { s.process("u1", "dm:c1", "m2", true, second) }
	s.process("u1", "dm:c1", "m1", true, first)
	if len(fcm.sent) != 1 {
		t.Fatalf("expected only m1 sent, got %d", len(fcm.sent))
	}
	delete(cache.values, fmt.Sprintf(constants.CacheKeyPushThrottle, "u1", "dm:c1"))
	runScheduled(s)
	if len(fcm.sent) != 2 || fcm.sent[1][0].Data["body"] != "2" {
		t.Fatalf("expected trailing send of m2, got %d sends", len(fcm.sent))
	}
}

func TestStorePendingKeepsNewerSeq(t *testing.T) {
	fcm := &fakeFCM{}
	cache := newFakeCache()
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	mk := func(body string, seq int64) Content {
		c := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct", SenderName: "An", Preview: body})
		c.Seq = seq
		return c
	}
	s.process("u1", "dm:c1", "m1", true, mk("1", 1))
	s.process("u1", "dm:c1", "m3", true, mk("3", 3))
	s.process("u1", "dm:c1", "m2", true, mk("2", 2))
	delete(cache.values, fmt.Sprintf(constants.CacheKeyPushThrottle, "u1", "dm:c1"))
	runScheduled(s)
	if len(fcm.sent) != 2 || fcm.sent[1][0].Data["body"] != "3" {
		t.Fatalf("expected newer pending m3 to win, got %v", fcm.sent)
	}
}

func TestSendDMUsesPerRecipientUnread(t *testing.T) {
	fcm := &fakeFCM{}
	s := newTestSender(fcm, newFakeCache(), &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	s.SendDM([]string{"sender", "a", "b"}, DMPush{
		ConversationID:   "c1",
		ConversationType: "direct",
		SenderID:         "sender",
		MessageID:        "m1",
		UnreadByUser:     map[string]int{"a": 4, "sender": 0},
	})
	drainJobs(s)
	if len(fcm.sent) != 2 {
		t.Fatalf("expected 2 sends, got %d", len(fcm.sent))
	}
	got := map[string]string{}
	for _, batch := range fcm.sent {
		got[batch[0].Data["conversationId"]+":"+batch[0].Data["unreadCount"]] = batch[0].Data["unreadCount"]
	}
	if _, ok := got["c1:4"]; !ok {
		t.Fatalf("expected recipient a to get unreadCount 4, got %v", got)
	}
	if _, ok := got["c1:"]; !ok {
		t.Fatalf("expected recipient b without unreadCount, got %v", got)
	}
}

func TestProcessEventDedupe(t *testing.T) {
	fcm := &fakeFCM{}
	cache := newFakeCache()
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	content := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"})
	s.process("u1", "dm:c1", "m1", true, content)
	delete(cache.values, fmt.Sprintf(constants.CacheKeyPushThrottle, "u1", "dm:c1"))
	s.process("u1", "dm:c1", "m1", true, content)
	if len(fcm.sent) != 1 {
		t.Fatalf("expected duplicate event suppressed, got %d", len(fcm.sent))
	}
}

func TestProcessTotalFailureRollsBackThrottle(t *testing.T) {
	fcm := &fakeFCM{err: errors.New("unavailable")}
	cache := newFakeCache()
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	s.process("u1", "dm:c1", "m1", true, buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"}))
	if _, ok := cache.values[fmt.Sprintf(constants.CacheKeyPushThrottle, "u1", "dm:c1")]; ok {
		t.Fatal("expected throttle rolled back after total failure")
	}
}

func TestProcessAllResponsesFailedRollsBackThrottle(t *testing.T) {
	fcm := &fakeFCM{resp: &messaging.BatchResponse{
		SuccessCount: 0,
		FailureCount: 1,
		Responses:    []*messaging.SendResponse{{Success: false, Error: errors.New("temporary")}},
	}}
	cache := newFakeCache()
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	s.process("u1", "dm:c1", "m1", true, buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"}))
	if _, ok := cache.values[fmt.Sprintf(constants.CacheKeyPushThrottle, "u1", "dm:c1")]; ok {
		t.Fatal("expected throttle rolled back when no delivery succeeded")
	}
}

func TestProcessDeletesOnlyUnregisteredTokens(t *testing.T) {
	prev := isUnregistered
	isUnregistered = func(err error) bool { return err != nil && err.Error() == "unregistered" }
	defer func() { isUnregistered = prev }()

	fcm := &fakeFCM{resp: &messaging.BatchResponse{
		SuccessCount: 1,
		FailureCount: 1,
		Responses: []*messaging.SendResponse{
			{Success: true},
			{Success: false, Error: errors.New("unregistered")},
		},
	}}
	store := &fakeStore{
		tokens: []models.DeviceToken{
			{Token: "tok-live", Platform: "android"},
			{Token: "tok-dead", Platform: "android"},
		},
		notifMessage: true,
	}
	s := newTestSender(fcm, newFakeCache(), &fakeConns{}, store)
	s.process("u1", "dm:c1", "m1", true, buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"}))
	if len(store.deleted) != 1 || store.deleted[0] != "tok-dead" {
		t.Fatalf("expected only tok-dead deleted, got %v", store.deleted)
	}
}

func TestProcessRedisFailureFailsOpen(t *testing.T) {
	fcm := &fakeFCM{}
	cache := newFakeCache()
	cache.failed = true
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	s.process("u1", "dm:c1", "m1", true, buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"}))
	if len(fcm.sent) != 1 {
		t.Fatalf("expected fail-open send on redis failure, got %d", len(fcm.sent))
	}
}

func TestProcessTotalFailureAllowsEventRetry(t *testing.T) {
	fcm := &fakeFCM{err: errors.New("unavailable")}
	cache := newFakeCache()
	s := newTestSender(fcm, cache, &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	content := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"})

	s.process("u1", "dm:c1", "m1", true, content)
	if len(cache.values) != 0 {
		t.Fatalf("expected event and throttle keys rolled back, got %v", cache.values)
	}

	fcm.err = nil
	s.process("u1", "dm:c1", "m1", true, content)
	if len(fcm.sent) != 2 {
		t.Fatalf("expected retry of same event to send, got %d attempts", len(fcm.sent))
	}
}

func TestProcessKillSwitchBeforeSendRollsBack(t *testing.T) {
	fcm := &fakeFCM{}
	cache := newFakeCache()
	store := &fakeStore{tokens: oneToken(), notifMessage: true, pushDisabled: true}
	s := newTestSender(fcm, cache, &fakeConns{}, store)
	s.process("u1", "dm:c1", "m1", true, buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"}))
	if len(fcm.sent) != 0 {
		t.Fatal("expected no send when push disabled at send time")
	}
	if len(cache.values) != 0 {
		t.Fatalf("expected keys rolled back when disabled, got %v", cache.values)
	}
}

func TestSendInChunksSplitsBatches(t *testing.T) {
	fcm := &fakeFCM{}
	tokens := make([]models.DeviceToken, 501)
	msgs := make([]*messaging.Message, 501)
	for i := range tokens {
		tokens[i] = models.DeviceToken{Token: fmt.Sprintf("tok-%d", i), Platform: "android"}
		msgs[i] = &messaging.Message{Token: tokens[i].Token}
	}
	s := newTestSender(fcm, newFakeCache(), &fakeConns{}, &fakeStore{notifMessage: true})
	success, failure, err := s.sendInChunks("u1", "dm:c1", tokens, msgs)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if len(fcm.sent) != 2 || len(fcm.sent[0]) != 500 || len(fcm.sent[1]) != 1 {
		t.Fatalf("expected batches of 500+1, got %d batches", len(fcm.sent))
	}
	if success != 501 || failure != 0 {
		t.Fatalf("unexpected counts: %d/%d", success, failure)
	}
}

func TestSendDMSkippedWhenPushDisabled(t *testing.T) {
	fcm := &fakeFCM{}
	s := newTestSender(fcm, newFakeCache(), &fakeConns{}, &fakeStore{
		tokens:       oneToken(),
		notifMessage: true,
		pushDisabled: true,
	})
	s.SendDM([]string{"receiver"}, DMPush{
		ConversationID:   "c1",
		ConversationType: "direct",
		SenderID:         "sender",
	})
	if len(s.jobs) != 0 {
		t.Fatalf("expected no jobs while push disabled, got %d", len(s.jobs))
	}
}

func TestSendDMFiltersSenderAndGroups(t *testing.T) {
	fcm := &fakeFCM{}
	s := newTestSender(fcm, newFakeCache(), &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})

	s.SendDM([]string{"sender", "receiver"}, DMPush{
		ConversationID:   "c1",
		ConversationType: "group",
		SenderID:         "sender",
	})
	if len(s.jobs) != 0 {
		t.Fatalf("expected group message to enqueue nothing, got %d", len(s.jobs))
	}

	s.SendDM([]string{"sender", "receiver"}, DMPush{
		ConversationID:   "c1",
		ConversationType: "direct",
		SenderID:         "sender",
	})
	if len(s.jobs) != 1 {
		t.Fatalf("expected exactly one job for the receiver, got %d", len(s.jobs))
	}
	drainJobs(s)
	if len(fcm.sent) != 1 {
		t.Fatalf("expected 1 send, got %d", len(fcm.sent))
	}
}

func TestSendDMPayload(t *testing.T) {
	fcm := &fakeFCM{}
	s := newTestSender(fcm, newFakeCache(), &fakeConns{}, &fakeStore{tokens: oneToken(), notifMessage: true})
	s.SendDM([]string{"receiver"}, DMPush{
		ConversationID:   "c1",
		ConversationType: "direct",
		SenderID:         "sender",
		SenderName:       "Hoa",
		SenderAvatar:     "https://cdn/avatar.png",
		Preview:          "xin chào",
		MessageID:        "m1",
		SentAt:           "2026-09-16T10:00:00Z",
	})
	drainJobs(s)
	if len(fcm.sent) != 1 {
		t.Fatalf("expected 1 send, got %d", len(fcm.sent))
	}
	msg := fcm.sent[0][0]
	if msg.Notification != nil {
		t.Fatal("expected data-only message without notification payload")
	}
	if msg.Android == nil || msg.Android.Priority != "high" || msg.Android.CollapseKey != constants.PushCollapseDM {
		t.Fatal("expected android high priority with stable dm collapse key")
	}
	data := msg.Data
	if data["type"] != constants.PushDataTypeDM || data["conversationId"] != "c1" || data["notifId"] != "dm:c1" {
		t.Fatalf("unexpected data payload: %v", data)
	}
	if data["title"] != "Hoa" || data["body"] != "xin chào" {
		t.Fatalf("unexpected content: %v", data)
	}
	if data["senderId"] != "sender" || data["senderAvatar"] != "https://cdn/avatar.png" || data["sentAt"] != "2026-09-16T10:00:00Z" {
		t.Fatalf("unexpected sender fields: %v", data)
	}
}

func TestBuildDMContentFallbacks(t *testing.T) {
	c := buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct"})
	if c.Title != fallbackTitle || c.Body != "Bạn có tin nhắn mới" {
		t.Fatalf("unexpected fallbacks: %q %q", c.Title, c.Body)
	}
	if _, ok := c.Data["senderAvatar"]; ok {
		t.Fatal("expected no senderAvatar when empty")
	}
	if _, ok := c.Data["sentAt"]; ok {
		t.Fatal("expected no sentAt when empty")
	}

	long := strings.Repeat("а", constants.PushExcerptMaxRunes+40)
	c = buildDMContent(DMPush{ConversationID: "c1", ConversationType: "direct", SenderName: "An", Preview: long})
	if len([]rune(c.Body)) != constants.PushExcerptMaxRunes+1 {
		t.Fatalf("expected truncated body, got %d runes", len([]rune(c.Body)))
	}
}

func TestBuildMeNotifContentAllTypes(t *testing.T) {
	for _, ntype := range []string{
		models.MeNotificationLike,
		models.MeNotificationComment,
		models.MeNotificationReply,
		models.MeNotificationMention,
		models.MeNotificationCommentLike,
	} {
		c := buildMeNotifContent("n1", "Hoa", ntype, "nội dung", 0)
		if c.Title != "Hoa" || c.Body == "" || c.Channel != constants.PushChannelSocial {
			t.Fatalf("bad content for %s: %+v", ntype, c)
		}
	}

	c := buildMeNotifContent("n1", "", "unknown_type", "x", 0)
	if c.Title != fallbackTitle || c.Body != "Bạn có thông báo mới" {
		t.Fatalf("unexpected unknown-type content: %+v", c)
	}
	c = buildMeNotifContent("n1", "Hoa", models.MeNotificationComment, "bình luận dài", 0)
	if !strings.Contains(c.Body, "bình luận dài") {
		t.Fatalf("expected preview appended: %q", c.Body)
	}
	c = buildMeNotifContent("n1", "Hoa", models.MeNotificationLike, "preview", 0)
	if strings.Contains(c.Body, "preview") {
		t.Fatalf("like should not include preview: %q", c.Body)
	}
}

func TestBuildAppNotifContentAllTypes(t *testing.T) {
	for _, ntype := range []string{
		models.AppNotificationFriendRequest,
		models.AppNotificationMarriageProposal,
		models.AppNotificationClanRoleAssigned,
		models.AppNotificationClanRoleRevoked,
		models.AppNotificationClanVerified,
		models.AppNotificationClanUnverified,
		models.AppNotificationClanBanned,
	} {
		c := buildAppNotifContent("n1", "Hoa", ntype, "", 0)
		if c.Body == "" || c.Channel != constants.PushChannelSystem {
			t.Fatalf("bad content for %s: %+v", ntype, c)
		}
	}

	if c := buildAppNotifContent("n1", "Hoa", models.AppNotificationFriendRequest, "", 0); c.Title != "Hoa" {
		t.Fatalf("expected actor title, got %q", c.Title)
	}
	if c := buildAppNotifContent("n1", "Admin", models.AppNotificationClanBanned, "", 0); c.Title != fallbackTitle {
		t.Fatalf("expected system title for clan type, got %q", c.Title)
	}
	if c := buildAppNotifContent("n1", "", "unknown", "", 0); c.Body != "Bạn có thông báo mới" {
		t.Fatalf("unexpected unknown-type body: %q", c.Body)
	}
}

func TestParseNotifFields(t *testing.T) {
	id, ntype, actor, preview := parseNotifFields(map[string]interface{}{
		"id":      "n1",
		"type":    "like",
		"preview": "p",
		"actor":   map[string]interface{}{"fullName": "", "username": "hoa123"},
	})
	if id != "n1" || ntype != "like" || actor != "hoa123" || preview != "p" {
		t.Fatalf("unexpected parse: %q %q %q %q", id, ntype, actor, preview)
	}

	id, ntype, actor, preview = parseNotifFields(map[string]interface{}{})
	if id != "" || ntype != "" || actor != "" || preview != "" {
		t.Fatal("expected empty fields for empty notification")
	}
}
