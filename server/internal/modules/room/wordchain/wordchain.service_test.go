package wordchain

import (
	"context"
	"fmt"
	"math/rand/v2"
	"net"
	"strconv"
	"sync"
	"testing"
	"time"

	"ola-chat-server/internal/config"
	roomEvents "ola-chat-server/internal/domain/room"
	"ola-chat-server/internal/services"

	miniredis "github.com/alicebob/miniredis/v2"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type recordingPublisher struct {
	mu     sync.Mutex
	events []*roomEvents.WordChainEvent
}

func (p *recordingPublisher) PublishWordChainEvent(_ context.Context, event *roomEvents.WordChainEvent) error {
	p.mu.Lock()
	defer p.mu.Unlock()
	p.events = append(p.events, event)
	return nil
}

type acceptAllOracle struct{}

func (acceptAllOracle) Exists(string) (bool, error) { return true, nil }

func (acceptAllOracle) HasContinuation(string, map[string]struct{}) (bool, error) { return true, nil }

func (acceptAllOracle) StartWord() (string, error) { return "", fmt.Errorf("unexpected start word") }

var testPairs = map[string][]string{
	"mặt":  {"trời"},
	"trời": {"đất"},
	"đất":  {"nước"},
	"nước": {"mặt"},
}

func newTestService(t *testing.T) *Service {
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

	verifier := NewVerifier(cache)
	verifier.lookupURL = "http://127.0.0.1:1/lookup"
	verifier.suggestURL = "http://127.0.0.1:1/suggest"
	svc := &Service{
		dict:      newDictionaryFromSources(rand.New(rand.NewPCG(1, 2)), testPairs),
		verifier:  verifier,
		store:     NewStore(cache),
		cache:     cache,
		publisher: &recordingPublisher{},
		scores:    &recordingScoreLog{},
		logger:    zap.NewNop().Sugar(),
	}
	t.Cleanup(svc.stopTimer)
	markDictionaryWordsValid(t, svc)
	return svc
}

func markDictionaryWordsValid(t *testing.T, svc *Service) {
	t.Helper()
	for first, seconds := range testPairs {
		for _, second := range seconds {
			key := fmt.Sprintf(CacheKeyWordExists, first+" "+second)
			if err := svc.verifier.redis.Set(context.Background(), key, "1", time.Hour).Err(); err != nil {
				t.Fatal(err)
			}
		}
	}
}

func saveState(t *testing.T, svc *Service, state GameState) GameState {
	t.Helper()
	if _, err := svc.store.Apply(context.Background(), &Mutation{State: &state}); err != nil {
		t.Fatal(err)
	}
	return state
}

func addPlayerMessages(t *testing.T, svc *Service, state GameState, count int) {
	t.Helper()
	messages := make([]Message, 0, count)
	for i := range count {
		msg := newMessage(state.SessionID, time.Now())
		msg.Type = MessageTypeMove
		msg.SenderType = SenderTypeUser
		msg.Content = fmt.Sprintf("tin %d", i)
		messages = append(messages, msg)
	}
	if _, err := svc.store.Apply(context.Background(), &Mutation{Messages: messages}); err != nil {
		t.Fatal(err)
	}
}

func listAll(t *testing.T, svc *Service) []storedMessage {
	t.Helper()
	items, err := svc.store.ListMessages(context.Background(), MessagePageMax, "")
	if err != nil {
		t.Fatal(err)
	}
	return items
}

func TestExpiredBotWordIsReplacedAndMessagesKept(t *testing.T) {
	svc := newTestService(t)
	ctx := context.Background()

	started, err := svc.activeState(ctx)
	if err != nil {
		t.Fatal(err)
	}
	addPlayerMessages(t, svc, started, 9)
	before := listAll(t, svc)
	if len(before) != 10 {
		t.Fatalf("messages before = %d, want 10", len(before))
	}

	expired := started
	expired.LastProgressAt = time.Now().Add(-BotWordTimeout - time.Minute)
	expired.WrongCounts = map[string]int{"u1": MaxWrongGuesses}
	saveState(t, svc, expired)

	state, err := svc.activeState(ctx)
	if err != nil {
		t.Fatal(err)
	}
	if state.SessionID != started.SessionID {
		t.Fatalf("session changed from %s to %s", started.SessionID, state.SessionID)
	}
	if state.Turn != started.Turn+1 || len(state.History) != 1 || state.History[0] != state.Word {
		t.Fatalf("unexpected replaced state: %+v", state)
	}
	if state.RemainingGuesses("u1") != MaxWrongGuesses {
		t.Fatalf("wrong guesses were not reset: %+v", state.WrongCounts)
	}
	if state.Expired(time.Now()) || !state.CanExpire() {
		t.Fatalf("new bot word should be fresh and still expirable")
	}

	announcedID := started.BotMessageID
	if announcedID == "" || before[len(before)-1].ID != announcedID {
		t.Fatalf("session_started should be the announced bot message, got %q", announcedID)
	}
	after := listAll(t, svc)
	if len(after) != len(before) {
		t.Fatalf("messages after = %d, want %d", len(after), len(before))
	}
	newest := after[0]
	if newest.ID != announcedID || state.BotMessageID != announcedID {
		t.Fatalf("bot message should keep its id %s, got %s (state %s)", announcedID, newest.ID, state.BotMessageID)
	}
	if newest.Type != MessageTypeGameStarted || newest.Word != state.Word || newest.Seq <= before[0].Seq {
		t.Fatalf("newest message = %+v, want the new bot word %q at the end", newest, state.Word)
	}
	for i, msg := range before[:len(before)-1] {
		if after[i+1].ID != msg.ID {
			t.Fatalf("player message %d was lost", i)
		}
	}
	if indexed, err := svc.store.client.ZCard(ctx, CacheKeyMsgIndex).Result(); err != nil || indexed != int64(len(before)) {
		t.Fatalf("message index size = %d (err %v), want %d", indexed, err, len(before))
	}
	if !publishedBotWord(svc, announcedID, state.Word) {
		t.Fatalf("realtime event should resend message %s with word %q", announcedID, state.Word)
	}
}

func publishedBotWord(svc *Service, messageID, word string) bool {
	pub := svc.publisher.(*recordingPublisher)
	pub.mu.Lock()
	defer pub.mu.Unlock()
	for _, event := range pub.events {
		msg, ok := event.Data["message"].(map[string]any)
		if ok && msg["id"] == messageID && msg["word"] == word && msg["type"] == MessageTypeGameStarted {
			return true
		}
	}
	return false
}

func TestWinAnnouncementBecomesTheReplaceableBotMessage(t *testing.T) {
	svc := newTestService(t)
	ctx := context.Background()

	session := saveState(t, svc, newSession("mặt trời", time.Now()))
	userID := uuid.New()
	res, err := processMove(session, userID.String(), "trời đất", acceptAllOracle{})
	if err != nil {
		t.Fatal(err)
	}
	res.Code = CodeWin
	res.State.Word = "đất nước"
	res.State.History = []string{"đất nước"}

	resp, err := svc.commitMove(ctx, userID, nil, "trời đất", session.Revision, res)
	if err != nil {
		t.Fatal(err)
	}
	state, err := svc.store.LoadState(ctx)
	if err != nil {
		t.Fatal(err)
	}
	started := resp.BotMessages[len(resp.BotMessages)-1]
	if started.Type != MessageTypeGameStarted || state.BotMessageID != started.ID || !state.CanExpire() {
		t.Fatalf("win should record the game_started message as the bot word announcement: %+v", state)
	}
}

func TestPlayerWordNeverExpires(t *testing.T) {
	svc := newTestService(t)
	ctx := context.Background()

	saved := saveState(t, svc, GameState{
		SessionID:        uuid.NewString(),
		Word:             "trời đất",
		History:          []string{"mặt trời", "trời đất"},
		SessionStartedAt: time.Now().Add(-10 * time.Hour),
		LastProgressAt:   time.Now().Add(-5 * time.Hour),
		Turn:             2,
	})

	state, err := svc.activeState(ctx)
	if err != nil {
		t.Fatal(err)
	}
	if state.Revision != saved.Revision || state.Word != "trời đất" {
		t.Fatalf("player word was replaced: %+v", state)
	}
	if view := toStateView(state); view.WordExpiresAt != "" {
		t.Fatalf("player word should not expose an expiry, got %s", view.WordExpiresAt)
	}

	svc.expireBotWord()
	current, err := svc.store.LoadState(ctx)
	if err != nil {
		t.Fatal(err)
	}
	if current.Revision != saved.Revision {
		t.Fatalf("timer replaced a player word: %+v", current)
	}
	if len(listAll(t, svc)) != 0 {
		t.Fatalf("timer should not add messages for a player word")
	}
}

func TestConnectedWordsStayAsOneList(t *testing.T) {
	svc := newTestService(t)
	ctx := context.Background()

	state, err := svc.activeState(ctx)
	if err != nil {
		t.Fatal(err)
	}
	players := []uuid.UUID{uuid.New(), uuid.New()}
	for i := range 3 {
		userID := players[i%len(players)]
		word := fmt.Sprintf("%s nối%d", lastWord(state.Word), i)
		res, err := processMove(state, userID.String(), word, acceptAllOracle{})
		if err != nil || res.Code != CodeOK {
			t.Fatalf("move %q: code %s err %v", word, res.Code, err)
		}
		if _, err := svc.commitMove(ctx, userID, nil, word, state.Revision, res); err != nil {
			t.Fatal(err)
		}
		if state, err = svc.store.LoadState(ctx); err != nil {
			t.Fatal(err)
		}
	}
	before := listAll(t, svc)

	old := state
	old.LastProgressAt = time.Now().Add(-10 * BotWordTimeout)
	saveState(t, svc, old)
	if _, err := svc.activeState(ctx); err != nil {
		t.Fatal(err)
	}
	svc.expireBotWord()

	current, err := svc.store.LoadState(ctx)
	if err != nil {
		t.Fatal(err)
	}
	if current.Word != state.Word || current.Turn != state.Turn {
		t.Fatalf("connected word was replaced: %q -> %q", state.Word, current.Word)
	}
	after := listAll(t, svc)
	if len(after) != len(before) || len(after) != 4 {
		t.Fatalf("messages = %d, want %d (bot word + 3 moves)", len(after), len(before))
	}
	for i := range before {
		if after[i].ID != before[i].ID {
			t.Fatalf("message %d changed", i)
		}
	}
	if after[len(after)-1].Type != MessageTypeSessionStarted {
		t.Fatalf("the bot message of a connected word must be kept, oldest = %+v", after[len(after)-1])
	}
}

func TestExpireTimerReplacesBotWord(t *testing.T) {
	svc := newTestService(t)
	ctx := context.Background()

	session := newSession("mặt trời", time.Now().Add(-2*BotWordTimeout))
	saveState(t, svc, session)
	addPlayerMessages(t, svc, session, 3)

	svc.expireBotWord()

	state, err := svc.store.LoadState(ctx)
	if err != nil {
		t.Fatal(err)
	}
	if state.SessionID != session.SessionID || state.Turn != session.Turn+1 || state.Expired(time.Now()) {
		t.Fatalf("timer did not replace the bot word: %+v", state)
	}
	if got := len(listAll(t, svc)); got != 4 {
		t.Fatalf("messages = %d, want 4", got)
	}
}

func TestExpiredBotWordKeptWhenDictionaryIsDown(t *testing.T) {
	svc := newTestService(t)
	ctx := context.Background()
	if err := svc.verifier.redis.FlushAll(ctx).Err(); err != nil {
		t.Fatal(err)
	}

	session := saveState(t, svc, newSession("mặt trời", time.Now().Add(-2*BotWordTimeout)))

	state, err := svc.activeState(ctx)
	if err != nil {
		t.Fatalf("activeState should keep serving the old bot word, got %v", err)
	}
	if state.Revision != session.Revision || state.Word != "mặt trời" {
		t.Fatalf("state changed while dictionary is down: %+v", state)
	}
}

func TestMoveOnExpiredBotWordStillCommits(t *testing.T) {
	svc := newTestService(t)
	ctx := context.Background()

	session := saveState(t, svc, newSession("mặt trời", time.Now().Add(-2*BotWordTimeout)))
	userID := uuid.New()
	res, err := processMove(session, userID.String(), "trời đất", acceptAllOracle{})
	if err != nil {
		t.Fatal(err)
	}

	resp, err := svc.commitMove(ctx, userID, nil, "trời đất", session.Revision, res)
	if err != nil {
		t.Fatalf("commitMove: %v", err)
	}
	if resp.State.Word != "trời đất" || resp.State.WordExpiresAt != "" {
		t.Fatalf("unexpected state after move: %+v", resp.State)
	}
	state, err := svc.store.LoadState(ctx)
	if err != nil {
		t.Fatal(err)
	}
	if !state.HasPlayerWord() || state.Expired(time.Now().Add(24*time.Hour)) {
		t.Fatalf("player word should never expire: %+v", state)
	}
}
