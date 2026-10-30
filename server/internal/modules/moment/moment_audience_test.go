package moment

import (
	"context"
	"net"
	"strconv"
	"strings"
	"testing"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"

	miniredis "github.com/alicebob/miniredis/v2"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func newAudienceStore(t *testing.T) (*RedisStore, *miniredis.Miniredis) {
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
	return NewRedisStore(cache), server
}

func TestAudienceSnapshotKeepsNewestFirstWithEachReactorsReactions(t *testing.T) {
	store, server := newAudienceStore(t)
	ctx := context.Background()
	now := time.Now().UTC().Truncate(time.Second)
	server.SetTime(now)
	moment := &models.Moment{ID: uuid.New(), ExpiresAt: now.Add(time.Hour)}
	early, late := uuid.New(), uuid.New()

	if _, err := store.MarkSeen(ctx, early, []*models.Moment{moment}, now); err != nil {
		t.Fatal(err)
	}
	if _, err := store.MarkSeen(ctx, late, []*models.Moment{moment}, now.Add(time.Minute)); err != nil {
		t.Fatal(err)
	}
	if _, _, err := store.AddReaction(ctx, moment, early, "LOVE", 2, now.Add(2*time.Minute)); err != nil {
		t.Fatal(err)
	}
	if _, _, err := store.AddReaction(ctx, moment, early, "HAHA", 1, now.Add(3*time.Minute)); err != nil {
		t.Fatal(err)
	}

	if ttl := server.TTL(viewersKey(moment.ID)); ttl < MomentAudienceKeepAfter {
		t.Fatalf("viewers must outlive the moment by %v so the cleaner can archive them, got ttl %v", MomentAudienceKeepAfter, ttl)
	}
	if ttl := server.TTL(reactorsKey(moment.ID)); ttl < MomentAudienceKeepAfter {
		t.Fatalf("reactors must outlive the moment by %v, got ttl %v", MomentAudienceKeepAfter, ttl)
	}

	snapshot, err := store.AudienceSnapshot(ctx, moment.ID)
	if err != nil {
		t.Fatal(err)
	}
	viewers, reactors := snapshot.viewers, snapshot.reactors
	if len(viewers) != 2 || viewers[0].UserID != late || viewers[1].UserID != early {
		t.Fatalf("viewers are newest first like the live list, got %+v", viewers)
	}
	if viewers[1].At != now.UnixMilli() {
		t.Fatalf("the view time is kept in milliseconds, got %d", viewers[1].At)
	}
	if len(reactors) != 1 || reactors[0].UserID != early {
		t.Fatalf("only the user who reacted is a reactor, got %+v", reactors)
	}
	if got := reactors[0].Reactions; len(got) != 2 || got["LOVE"] != 2 || got["HAHA"] != 1 {
		t.Fatalf("each reactor keeps their own counts and no totals leak in, got %+v", got)
	}
	if snapshot.totals["LOVE"] != 2 || snapshot.totals["HAHA"] != 1 || len(snapshot.totals) != 2 {
		t.Fatalf("the moment totals come from the same hash, got %+v", snapshot.totals)
	}
}

func TestAudienceSnapshotOfAMomentNobodySawIsEmptyNotMissing(t *testing.T) {
	store, _ := newAudienceStore(t)
	snapshot, err := store.AudienceSnapshot(context.Background(), uuid.New())
	if err != nil {
		t.Fatal(err)
	}
	archive := archiveOf(&models.Moment{}, snapshot)
	if archive.viewers == nil || archive.reactors == nil || archive.viewersLost || archive.reactorsLost {
		t.Fatalf("a moment nobody saw is archived as two empty lists, got %+v", archive)
	}
}

func TestArchiveOfMarksEachMissingListAsLost(t *testing.T) {
	viewer := models.MomentAudienceEntry{UserID: uuid.New(), At: 1}
	reactor := models.MomentAudienceEntry{UserID: viewer.UserID, At: 2, Reactions: map[string]int64{"LOVE": 2}}
	full := audienceSnapshot{
		viewers:  models.MomentAudience{viewer},
		reactors: models.MomentAudience{reactor},
		totals:   map[string]int64{"LOVE": 2},
	}

	archive := archiveOf(&models.Moment{ViewerCount: 1}, full)
	if archive.viewersLost || archive.reactorsLost || len(archive.viewers) != 1 || len(archive.reactors) != 1 {
		t.Fatalf("a full snapshot is archived as is, got %+v", archive)
	}
	if archive.reactionCounts["LOVE"] != 2 || archive.viewerCount != 1 {
		t.Fatalf("totals that were never synced come from the snapshot, got %+v %d", archive.reactionCounts, archive.viewerCount)
	}

	archive = archiveOf(&models.Moment{ViewerCount: 3}, audienceSnapshot{reactors: full.reactors, totals: full.totals})
	if !archive.viewersLost || archive.viewers != nil || archive.reactorsLost {
		t.Fatalf("viewers gone while the count says 3 loses only the viewer list, got %+v", archive)
	}

	archive = archiveOf(&models.Moment{ViewerCount: 1}, audienceSnapshot{viewers: full.viewers, totals: full.totals})
	if !archive.reactorsLost || archive.reactors != nil || archive.viewersLost {
		t.Fatalf("reactors gone while the totals say 2 loses only the reactor list, got %+v", archive)
	}

	bare := models.MomentAudience{{UserID: viewer.UserID, At: 2}}
	archive = archiveOf(&models.Moment{ViewerCount: 1, ReactionCounts: models.MomentReactionCounts{"LOVE": 2}}, audienceSnapshot{viewers: full.viewers, reactors: bare})
	if !archive.reactorsLost {
		t.Fatalf("reactors without their own counts are incomplete, got %+v", archive)
	}
	if archive.reactionCounts["LOVE"] != 2 {
		t.Fatalf("stored totals are kept when the hash is gone, got %+v", archive.reactionCounts)
	}
}

func TestAudienceAvailabilityFollowsTheArchiveOnceProcessed(t *testing.T) {
	processed := time.Now()
	viewers, reactors := audienceAvailability(&models.Moment{AudienceArchivedAt: &processed, ArchivedReactorsLost: true, ViewerCount: 2}, 0, nil)
	if !viewers || reactors {
		t.Fatalf("an archived viewer list with lost reactors, got %v %v", viewers, reactors)
	}
	viewers, reactors = audienceAvailability(&models.Moment{ViewerCount: 2, ReactionCounts: models.MomentReactionCounts{"LOVE": 1}}, 0, nil)
	if viewers || reactors {
		t.Fatalf("an old moment whose Redis lists expired before archiving has neither list, got %v %v", viewers, reactors)
	}
	viewers, reactors = audienceAvailability(&models.Moment{ViewerCount: 2}, 2, map[string]int64{"LOVE": 1})
	if !viewers || !reactors {
		t.Fatalf("a moment still in Redis has both lists, got %v %v", viewers, reactors)
	}
	viewers, reactors = audienceAvailability(&models.Moment{}, 0, nil)
	if !viewers || !reactors {
		t.Fatalf("a moment nobody saw opens empty lists, got %v %v", viewers, reactors)
	}
}

func TestArchivedPageMatchesTheLivePaging(t *testing.T) {
	audience := models.MomentAudience{
		{UserID: uuid.New(), At: 3},
		{UserID: uuid.New(), At: 2},
		{UserID: uuid.New(), At: 1},
	}
	page, total := archivedPage(audience, 1, 5)
	if total != 3 || len(page) != 2 || page[0].Score != 2 || page[0].Member != audience[1].UserID.String() {
		t.Fatalf("offset 1 returns the last two entries, got %d %+v", total, page)
	}
	if next := nextViewerOffset(0, 2, total); next == nil || *next != 2 {
		t.Fatalf("a short first page points at the rest, got %v", next)
	}
	if page, total := archivedPage(audience, 9, 5); total != 3 || len(page) != 0 || page == nil {
		t.Fatalf("an offset past the end is an empty page, got %d %#v", total, page)
	}
}

func TestHistoryListDoesNotLoadArchivedAudiences(t *testing.T) {
	db, err := gorm.Open(postgres.New(postgres.Config{DSN: "host=127.0.0.1 user=dry dbname=dry sslmode=disable"}), &gorm.Config{
		DryRun:               true,
		DisableAutomaticPing: true,
	})
	if err != nil {
		t.Fatal(err)
	}
	var history string
	if err := db.Callback().Query().After("gorm:query").Register("capture_history_sql", func(tx *gorm.DB) {
		if tx.Statement.Table == "moments" {
			history = tx.Statement.SQL.String()
		}
	}); err != nil {
		t.Fatal(err)
	}
	if _, err := NewRepository(db).ListHistory(uuid.New(), 10, 0); err != nil {
		t.Fatal(err)
	}
	for _, needed := range []string{"audience_archived_at", "archived_viewers_lost", "archived_reactors_lost"} {
		if !strings.Contains(history, `"moments"."`+needed+`"`) {
			t.Fatalf("the history still needs %s to tell which lists can open, got %s", needed, history)
		}
	}
	for _, column := range ArchivedAudienceColumns {
		if strings.Contains(history, `"moments"."`+column+`"`) {
			t.Fatalf("history must not load %s for every row, got %s", column, history)
		}
	}
}
