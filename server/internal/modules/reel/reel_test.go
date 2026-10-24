package reel

import (
	"errors"
	"fmt"
	"mime/multipart"
	"strings"
	"testing"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func validOverlay() models.ReelOverlay {
	return models.ReelOverlay{
		ID:       "o1",
		Text:     "  Chào buổi sáng  ",
		X:        0.5,
		Y:        0.4,
		W:        0.8,
		Scale:    1.2,
		Rotation: -8,
		Color:    "#FFFFFF",
		Style:    constants.ReelOverlayStyleSolid,
		Font:     "sans",
		Align:    constants.ReelAlignCenter,
	}
}

func TestNormalizeOverlaysAcceptsAndCleansInput(t *testing.T) {
	blank := validOverlay()
	blank.Text = "   "
	overlays, err := normalizeOverlays([]models.ReelOverlay{validOverlay(), blank})
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if len(overlays) != 1 {
		t.Fatalf("expected blank overlay to be dropped, got %d overlays", len(overlays))
	}
	if overlays[0].Text != "Chào buổi sáng" || overlays[0].Color != "#ffffff" {
		t.Fatalf("unexpected overlay %+v", overlays[0])
	}
}

func TestNormalizeOverlaysGeneratesMissingID(t *testing.T) {
	input := validOverlay()
	input.ID = ""
	overlays, err := normalizeOverlays([]models.ReelOverlay{input})
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if _, err := uuid.Parse(overlays[0].ID); err != nil {
		t.Fatalf("expected generated uuid id, got %q", overlays[0].ID)
	}
}

func TestNormalizeOverlaysRejectsInvalidInput(t *testing.T) {
	cases := map[string]func(*models.ReelOverlay){
		"x outside canvas":   func(o *models.ReelOverlay) { o.X = 1.2 },
		"y below zero":       func(o *models.ReelOverlay) { o.Y = -0.1 },
		"width too small":    func(o *models.ReelOverlay) { o.W = 0.05 },
		"scale too large":    func(o *models.ReelOverlay) { o.Scale = 9 },
		"rotation too large": func(o *models.ReelOverlay) { o.Rotation = 270 },
		"bad color":          func(o *models.ReelOverlay) { o.Color = "red" },
		"bad style":          func(o *models.ReelOverlay) { o.Style = "neon" },
		"bad align":          func(o *models.ReelOverlay) { o.Align = "justify" },
		"bad font key":       func(o *models.ReelOverlay) { o.Font = "Comic Sans" },
		"text too long":      func(o *models.ReelOverlay) { o.Text = strings.Repeat("á", constants.MaxReelOverlayRunes+1) },
	}
	for name, mutate := range cases {
		t.Run(name, func(t *testing.T) {
			input := validOverlay()
			mutate(&input)
			if _, err := normalizeOverlays([]models.ReelOverlay{input}); !errors.Is(err, errInvalidOverlay) {
				t.Fatalf("expected errInvalidOverlay, got %v", err)
			}
		})
	}
}

func TestNormalizeOverlaysRejectsTooMany(t *testing.T) {
	inputs := make([]models.ReelOverlay, constants.MaxReelOverlays+1)
	for i := range inputs {
		inputs[i] = validOverlay()
	}
	if _, err := normalizeOverlays(inputs); !errors.Is(err, errTooManyOverlays) {
		t.Fatalf("expected errTooManyOverlays, got %v", err)
	}
}

func TestNormalizeVisibility(t *testing.T) {
	for input, want := range map[string]string{"": "friend", "friend": "friend", "public": "public"} {
		got, err := normalizeVisibility(input)
		if err != nil || got != want {
			t.Fatalf("normalizeVisibility(%q) = %q, %v; want %q", input, got, err, want)
		}
	}
	if _, err := normalizeVisibility("private"); !errors.Is(err, errInvalidVisibility) {
		t.Fatalf("expected errInvalidVisibility, got %v", err)
	}
}

func TestBuildDraftsTextReel(t *testing.T) {
	userID := uuid.New()
	drafts, err := buildDrafts(userID, constants.ReelTypeText, "friend", []CreateReelItem{
		{Background: "sunset", Overlays: []models.ReelOverlay{validOverlay()}},
	})
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if len(drafts) != 1 || drafts[0].Background != "sunset" || drafts[0].AuthorID != userID {
		t.Fatalf("unexpected drafts %+v", drafts)
	}
}

func TestBuildDraftsRejectsInvalidItems(t *testing.T) {
	blank := validOverlay()
	blank.Text = ""
	image := CreateReelItem{Overlays: []models.ReelOverlay{validOverlay()}}
	cases := map[string]struct {
		reelType string
		items    []CreateReelItem
		want     error
	}{
		"text without text":    {constants.ReelTypeText, []CreateReelItem{{Background: "sky", Overlays: []models.ReelOverlay{blank}}}, errEmptyTextReel},
		"text bad background":  {constants.ReelTypeText, []CreateReelItem{{Background: "Sky Blue", Overlays: []models.ReelOverlay{validOverlay()}}}, errInvalidBackground},
		"two text items":       {constants.ReelTypeText, []CreateReelItem{image, image}, errInvalidItems},
		"too many images":      {constants.ReelTypeImage, []CreateReelItem{image, image, image, image}, errInvalidItems},
		"no image items":       {constants.ReelTypeImage, nil, errInvalidItems},
		"two videos in a post": {constants.ReelTypeVideo, []CreateReelItem{image, image}, errInvalidItems},
	}
	for name, tc := range cases {
		t.Run(name, func(t *testing.T) {
			if _, err := buildDrafts(uuid.New(), tc.reelType, "friend", tc.items); !errors.Is(err, tc.want) {
				t.Fatalf("expected %v, got %v", tc.want, err)
			}
		})
	}
}

func TestBuildDraftsIgnoresBackgroundForMedia(t *testing.T) {
	drafts, err := buildDrafts(uuid.New(), constants.ReelTypeImage, "public", []CreateReelItem{
		{Background: "not used", Overlays: nil},
		{Overlays: []models.ReelOverlay{validOverlay()}},
	})
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if drafts[0].Background != "" || drafts[1].Position != 1 || drafts[1].Visibility != "public" {
		t.Fatalf("unexpected drafts %+v %+v", drafts[0], drafts[1])
	}
}

func TestValidateFiles(t *testing.T) {
	file := &multipart.FileHeader{Filename: "a"}
	cases := map[string]struct {
		reelType string
		input    CreateReelInput
		items    int
		ok       bool
	}{
		"text without files":      {constants.ReelTypeText, CreateReelInput{}, 1, true},
		"text with image":         {constants.ReelTypeText, CreateReelInput{Images: []*multipart.FileHeader{file}}, 1, false},
		"images match items":      {constants.ReelTypeImage, CreateReelInput{Images: []*multipart.FileHeader{file, file}, Thumbs: []*multipart.FileHeader{file}}, 2, true},
		"images fewer than items": {constants.ReelTypeImage, CreateReelInput{Images: []*multipart.FileHeader{file}}, 2, false},
		"image with video":        {constants.ReelTypeImage, CreateReelInput{Images: []*multipart.FileHeader{file}, Video: file}, 1, false},
		"video only":              {constants.ReelTypeVideo, CreateReelInput{Video: file, Thumb: file}, 1, true},
		"video missing":           {constants.ReelTypeVideo, CreateReelInput{Thumb: file}, 1, false},
	}
	for name, tc := range cases {
		t.Run(name, func(t *testing.T) {
			input := tc.input
			err := validateFiles(tc.reelType, &input, tc.items)
			if (err == nil) != tc.ok {
				t.Fatalf("validateFiles ok=%v, got err %v", tc.ok, err)
			}
		})
	}
}

func TestGroupTrayRowsKeepsAuthorOrderAndReelOrder(t *testing.T) {
	alice, bob := uuid.New(), uuid.New()
	latest := time.Date(2026, 10, 23, 8, 0, 0, 0, time.UTC)
	a1, a2, b1 := uuid.New(), uuid.New(), uuid.New()
	rows := []trayPageRow{
		{ID: a1, AuthorID: alice, Latest: latest},
		{ID: a2, AuthorID: alice, Latest: latest},
		{ID: b1, AuthorID: bob, Latest: latest.Add(-time.Hour)},
	}

	groups, next := groupTrayRows(rows, 5)

	if next != nil {
		t.Fatalf("expected no next cursor, got %+v", next)
	}
	if len(groups) != 2 || groups[0].authorID != alice || groups[1].authorID != bob {
		t.Fatalf("unexpected groups %+v", groups)
	}
	if len(groups[0].reelIDs) != 2 || groups[0].reelIDs[0] != a1 || groups[0].reelIDs[1] != a2 {
		t.Fatalf("expected alice reels in query order, got %v", groups[0].reelIDs)
	}
}

func TestGroupTrayRowsCutsExtraAuthorIntoCursor(t *testing.T) {
	base := time.Date(2026, 10, 23, 8, 0, 0, 0, time.UTC)
	authors := []uuid.UUID{uuid.New(), uuid.New(), uuid.New()}
	rows := make([]trayPageRow, 0, len(authors))
	for i, author := range authors {
		rows = append(rows, trayPageRow{ID: uuid.New(), AuthorID: author, Latest: base.Add(-time.Duration(i) * time.Minute)})
	}

	groups, next := groupTrayRows(rows, 2)

	if len(groups) != 2 {
		t.Fatalf("expected 2 groups, got %d", len(groups))
	}
	if next == nil || next.AuthorID != authors[1] || !next.Latest.Equal(rows[1].Latest) {
		t.Fatalf("expected cursor at the last kept author, got %+v", next)
	}
}

func TestTrayCursorRoundTrip(t *testing.T) {
	cursor := &trayCursor{Latest: time.Date(2026, 10, 23, 8, 1, 2, 345678000, time.UTC), AuthorID: uuid.New()}
	decoded, err := decodeTrayCursor(encodeTrayCursor(cursor))
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if !decoded.Latest.Equal(cursor.Latest) || decoded.AuthorID != cursor.AuthorID {
		t.Fatalf("expected %+v, got %+v", cursor, decoded)
	}
	if empty, err := decodeTrayCursor("  "); err != nil || empty != nil {
		t.Fatalf("expected empty cursor to mean first page, got %+v %v", empty, err)
	}
	for _, bad := range []string{"%%%", "bm90LWEtY3Vyc29y", encodeTrayCursor(cursor)[:10]} {
		if _, err := decodeTrayCursor(bad); err == nil {
			t.Fatalf("expected %q to be rejected", bad)
		}
	}
}

func TestRetryDelayGrowsAndCaps(t *testing.T) {
	delays := constants.ReelTranscodeRetryDelays
	if retryDelay(0) != delays[0] || retryDelay(1) != delays[1] {
		t.Fatalf("unexpected first delays %v %v", retryDelay(0), retryDelay(1))
	}
	if retryDelay(1) <= retryDelay(0) {
		t.Fatalf("expected delays to grow")
	}
	if retryDelay(99) != delays[len(delays)-1] {
		t.Fatalf("expected delay to cap at %v, got %v", delays[len(delays)-1], retryDelay(99))
	}
}

func TestTransientErrorsAreRecognisedThroughWrapping(t *testing.T) {
	cause := errors.New("s3 unavailable")
	if !isTransient(fmt.Errorf("upload: %w", transient(cause))) {
		t.Fatalf("expected wrapped transient error to be recognised")
	}
	if isTransient(cause) || transient(nil) != nil {
		t.Fatalf("expected plain errors to be content errors")
	}
}

func TestUniqueIDsDropsInvalidAndDuplicates(t *testing.T) {
	id := uuid.New()
	ids := uniqueIDs([]string{id.String(), "nope", " " + id.String() + " ", uuid.NewString()})
	if len(ids) != 2 || ids[0] != id {
		t.Fatalf("unexpected ids %v", ids)
	}
}

func TestNextViewerOffsetSkipsPastFilteredViewers(t *testing.T) {
	if next := nextViewerOffset(0, 2, 2); next != nil {
		t.Fatalf("expected no next page when every viewer was fetched, got %d", *next)
	}
	next := nextViewerOffset(0, 50, 51)
	if next == nil || *next != 50 {
		t.Fatalf("expected next offset 50, got %v", next)
	}
	if next := nextViewerOffset(50, 0, 51); next != nil {
		t.Fatalf("expected empty page to end pagination, got %d", *next)
	}
}
