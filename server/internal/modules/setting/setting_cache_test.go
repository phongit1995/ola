package setting

import (
	"net"
	"strconv"
	"sync"
	"sync/atomic"
	"testing"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"

	"github.com/alicebob/miniredis/v2"
	"go.uber.org/zap"
)

type fakeSettingsTable struct {
	mu    sync.Mutex
	rows  map[string]models.JSONB
	loads atomic.Int32
}

func newFakeSettingsTable() *fakeSettingsTable {
	return &fakeSettingsTable{rows: map[string]models.JSONB{}}
}

func (f *fakeSettingsTable) set(key string, value models.JSONB) {
	f.mu.Lock()
	defer f.mu.Unlock()
	f.rows[key] = value
}

func (f *fakeSettingsTable) list() ([]models.AppSetting, error) {
	f.loads.Add(1)
	f.mu.Lock()
	defer f.mu.Unlock()
	rows := make([]models.AppSetting, 0, len(f.rows))
	for key, value := range f.rows {
		rows = append(rows, models.AppSetting{Key: key, Value: value})
	}
	return rows, nil
}

func newTestRedis(t *testing.T) (*services.CacheService, *miniredis.Miniredis) {
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
	return cache, server
}

func newCachedTestService(table *fakeSettingsTable, redis *services.CacheService) *Service {
	logger := zap.NewNop().Sugar()
	return &Service{settings: newSettingsCache(redis, table.list, logger), logger: logger}
}

func TestSettingsCacheLoadsEveryKeyWithOneQuery(t *testing.T) {
	redis, _ := newTestRedis(t)
	table := newFakeSettingsTable()
	table.set(KeyUsernameChange, models.JSONB{"tiers": []interface{}{map[string]interface{}{"minLength": usernameChangeMinLength, "cost": 9}}})
	table.set(KeyWordChain, models.JSONB{"hintPrice": 700})
	api := newCachedTestService(table, redis)
	chat := newCachedTestService(table, redis)

	usernameChange, err := api.GetUsernameChange()
	if err != nil || usernameChange.Tiers[0].Cost != 9 {
		t.Fatalf("usernameChange = %+v, err = %v", usernameChange, err)
	}
	if _, err := api.GetTopup(); err != nil {
		t.Fatal(err)
	}
	wordChain, err := chat.GetWordChain()
	if err != nil || wordChain.HintPrice != 700 {
		t.Fatalf("wordChain = %+v, err = %v", wordChain, err)
	}
	if got := table.loads.Load(); got != 1 {
		t.Fatalf("loads = %d, want 1 shared by every key and process", got)
	}
}

func TestSettingsCacheWriteReachesEveryProcess(t *testing.T) {
	redis, _ := newTestRedis(t)
	table := newFakeSettingsTable()
	table.set(KeyWordChain, models.JSONB{"hintPrice": 700})
	api := newCachedTestService(table, redis)
	chat := newCachedTestService(table, redis)

	if wordChain, _ := chat.GetWordChain(); wordChain.HintPrice != 700 {
		t.Fatal("hintPrice must start at 700")
	}
	table.set(KeyWordChain, models.JSONB{"hintPrice": 900})
	api.settingsChanged()
	if wordChain, _ := chat.GetWordChain(); wordChain.HintPrice != 900 {
		t.Fatal("a write in one process must drop the copy every process reads")
	}
}

func TestSettingsCacheSlowReaderCannotOverwriteNewerCopy(t *testing.T) {
	redis, _ := newTestRedis(t)
	table := newFakeSettingsTable()
	table.set(KeyWordChain, models.JSONB{"hintPrice": 700})
	logger := zap.NewNop().Sugar()

	started := make(chan struct{})
	release := make(chan struct{})
	slow := &Service{logger: logger, settings: newSettingsCache(redis, func() ([]models.AppSetting, error) {
		rows, err := table.list()
		close(started)
		<-release
		return rows, err
	}, logger)}
	admin := newCachedTestService(table, redis)
	other := newCachedTestService(table, redis)

	done := make(chan struct{})
	go func() {
		defer close(done)
		_, _ = slow.GetWordChain()
	}()
	<-started

	table.set(KeyWordChain, models.JSONB{"hintPrice": 900})
	admin.settingsChanged()
	if wordChain, _ := other.GetWordChain(); wordChain.HintPrice != 900 {
		t.Fatalf("a read after the write must see 900, got %d", wordChain.HintPrice)
	}

	close(release)
	<-done
	if wordChain, _ := other.GetWordChain(); wordChain.HintPrice != 900 {
		t.Fatalf("the slow reader must not put 700 back into the cache, got %d", wordChain.HintPrice)
	}
}

func TestSettingsCacheConcurrentMissesShareOneQuery(t *testing.T) {
	redis, _ := newTestRedis(t)
	table := newFakeSettingsTable()
	table.set(KeyWordChain, models.JSONB{"hintPrice": 700})
	logger := zap.NewNop().Sugar()

	release := make(chan struct{})
	svc := &Service{logger: logger, settings: newSettingsCache(redis, func() ([]models.AppSetting, error) {
		<-release
		return table.list()
	}, logger)}

	const readers = 16
	var wg sync.WaitGroup
	var wrong atomic.Int32
	for i := 0; i < readers; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			if wordChain, err := svc.GetWordChain(); err != nil || wordChain.HintPrice != 700 {
				wrong.Add(1)
			}
		}()
	}
	time.Sleep(100 * time.Millisecond)
	close(release)
	wg.Wait()

	if wrong.Load() != 0 {
		t.Fatalf("%d readers got a wrong config", wrong.Load())
	}
	if got := table.loads.Load(); got != 1 {
		t.Fatalf("loads = %d, want 1 for concurrent misses", got)
	}
}

func TestSettingsCacheFallsBackToDatabase(t *testing.T) {
	redis, server := newTestRedis(t)
	table := newFakeSettingsTable()
	table.set(KeyWordChain, models.JSONB{"hintPrice": 700})
	svc := newCachedTestService(table, redis)
	server.Close()

	wordChain, err := svc.GetWordChain()
	if err != nil || wordChain.HintPrice != 700 {
		t.Fatalf("redis down must still serve from the database, got %+v err %v", wordChain, err)
	}

	noRedis := newCachedTestService(table, nil)
	if wordChain, err := noRedis.GetWordChain(); err != nil || wordChain.HintPrice != 700 {
		t.Fatalf("without redis = %+v, err = %v", wordChain, err)
	}
}

func TestSettingsCacheMissingKeyUsesDefaults(t *testing.T) {
	redis, _ := newTestRedis(t)
	table := newFakeSettingsTable()
	table.set(KeyStory, models.JSONB{})
	svc := newCachedTestService(table, redis)

	for i := 0; i < 2; i++ {
		wordChain, err := svc.GetWordChain()
		if err != nil || wordChain != DefaultWordChainConfig() {
			t.Fatalf("missing key must fall back to defaults, got %+v err %v", wordChain, err)
		}
	}
	if got := table.loads.Load(); got != 1 {
		t.Fatalf("a missing key must be served from the cache too, loads = %d", got)
	}
}
