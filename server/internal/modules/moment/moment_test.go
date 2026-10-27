package moment

import (
	"errors"
	"fmt"
	"mime/multipart"
	"strings"
	"testing"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func validOverlay() models.MomentOverlay {
	return models.MomentOverlay{
		ID:       "o1",
		Text:     "  Chào buổi sáng  ",
		X:        0.5,
		Y:        0.4,
		W:        0.8,
		Scale:    1.2,
		Rotation: -8,
		Color:    "#FFFFFF",
		Style:    MomentOverlayStyleSolid,
		Font:     "sans",
		Align:    MomentAlignCenter,
	}
}

func TestNormalizeOverlaysAcceptsAndCleansInput(t *testing.T) {
	blank := validOverlay()
	blank.Text = "   "
	styled := validOverlay()
	styled.Font, styled.Bold, styled.Italic = "hand", true, true
	overlays, err := normalizeOverlays([]models.MomentOverlay{validOverlay(), blank, styled})
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if len(overlays) != 2 {
		t.Fatalf("expected blank overlay to be dropped, got %d overlays", len(overlays))
	}
	if overlays[0].Text != "Chào buổi sáng" || overlays[0].Color != "#ffffff" || overlays[0].Bold || overlays[0].Italic {
		t.Fatalf("unexpected overlay %+v", overlays[0])
	}
	if overlays[1].Font != "hand" || !overlays[1].Bold || !overlays[1].Italic {
		t.Fatalf("expected font, bold and italic to be kept, got %+v", overlays[1])
	}
}

func TestNormalizeOverlaysGeneratesMissingID(t *testing.T) {
	input := validOverlay()
	input.ID = ""
	overlays, err := normalizeOverlays([]models.MomentOverlay{input})
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if _, err := uuid.Parse(overlays[0].ID); err != nil {
		t.Fatalf("expected generated uuid id, got %q", overlays[0].ID)
	}
}

func TestNormalizeOverlaysRejectsInvalidInput(t *testing.T) {
	cases := map[string]func(*models.MomentOverlay){
		"x outside canvas":   func(o *models.MomentOverlay) { o.X = 1.2 },
		"y below zero":       func(o *models.MomentOverlay) { o.Y = -0.1 },
		"width too small":    func(o *models.MomentOverlay) { o.W = 0.05 },
		"scale too large":    func(o *models.MomentOverlay) { o.Scale = 9 },
		"rotation too large": func(o *models.MomentOverlay) { o.Rotation = 270 },
		"bad color":          func(o *models.MomentOverlay) { o.Color = "red" },
		"bad style":          func(o *models.MomentOverlay) { o.Style = "neon" },
		"bad align":          func(o *models.MomentOverlay) { o.Align = "justify" },
		"bad font key":       func(o *models.MomentOverlay) { o.Font = "Comic Sans" },
		"text too long":      func(o *models.MomentOverlay) { o.Text = strings.Repeat("á", MaxMomentOverlayRunes+1) },
	}
	for name, mutate := range cases {
		t.Run(name, func(t *testing.T) {
			input := validOverlay()
			mutate(&input)
			if _, err := normalizeOverlays([]models.MomentOverlay{input}); !errors.Is(err, errInvalidOverlay) {
				t.Fatalf("expected errInvalidOverlay, got %v", err)
			}
		})
	}
}

func TestNormalizeOverlaysRejectsTooMany(t *testing.T) {
	inputs := make([]models.MomentOverlay, MaxMomentOverlays+1)
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

func TestBuildDraftsTextMoment(t *testing.T) {
	userID := uuid.New()
	drafts, err := buildDrafts(userID, MomentTypeText, "friend", []CreateMomentItem{
		{Background: "sunset", Overlays: []models.MomentOverlay{validOverlay()}},
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
	image := CreateMomentItem{Overlays: []models.MomentOverlay{validOverlay()}}
	text := CreateMomentItem{Type: MomentTypeText, Background: "sky", Overlays: []models.MomentOverlay{validOverlay()}}
	cases := map[string]struct {
		momentType string
		items      []CreateMomentItem
		want       error
	}{
		"text without text":    {MomentTypeText, []CreateMomentItem{{Background: "sky", Overlays: []models.MomentOverlay{blank}}}, errEmptyTextMoment},
		"text bad background":  {MomentTypeText, []CreateMomentItem{{Background: "Sky Blue", Overlays: []models.MomentOverlay{validOverlay()}}}, errInvalidBackground},
		"too many text slides": {MomentTypeText, []CreateMomentItem{text, text, text, text}, errInvalidItems},
		"too many images":      {MomentTypeImage, []CreateMomentItem{image, image, image, image}, errInvalidItems},
		"no image items":       {MomentTypeImage, nil, errInvalidItems},
		"two videos in a post": {MomentTypeVideo, []CreateMomentItem{image, image}, errInvalidItems},
		"unknown slide type":   {MomentTypeImage, []CreateMomentItem{{Type: "gif", Overlays: []models.MomentOverlay{validOverlay()}}}, errInvalidType},
		"video slide in post":  {MomentTypeImage, []CreateMomentItem{{Type: MomentTypeVideo}}, errInvalidType},
		"text slide in video":  {MomentTypeVideo, []CreateMomentItem{text}, errInvalidType},
		"mixed text no text":   {MomentTypeImage, []CreateMomentItem{image, {Type: MomentTypeText, Background: "sky", Overlays: []models.MomentOverlay{blank}}}, errEmptyTextMoment},
	}
	for name, tc := range cases {
		t.Run(name, func(t *testing.T) {
			if _, err := buildDrafts(uuid.New(), tc.momentType, "friend", tc.items); !errors.Is(err, tc.want) {
				t.Fatalf("expected %v, got %v", tc.want, err)
			}
		})
	}
}

func TestBuildDraftsMixedSlides(t *testing.T) {
	drafts, err := buildDrafts(uuid.New(), MomentTypeImage, "public", []CreateMomentItem{
		{Type: MomentTypeText, Background: "sky", Overlays: []models.MomentOverlay{validOverlay()}},
		{Type: MomentTypeImage, Background: "ignored"},
		{Type: MomentTypeText, Background: "sunset", Overlays: []models.MomentOverlay{validOverlay()}},
	})
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	got := make([]string, 0, len(drafts))
	for _, draft := range drafts {
		got = append(got, fmt.Sprintf("%d:%s:%s", draft.Position, draft.Type, draft.Background))
	}
	want := []string{"0:text:sky", "1:image:", "2:text:sunset"}
	if strings.Join(got, ",") != strings.Join(want, ",") {
		t.Fatalf("expected %v, got %v", want, got)
	}
	images := imageDrafts(drafts)
	if len(images) != 1 || images[0] != drafts[1] {
		t.Fatalf("expected only the second slide to take an image, got %+v", images)
	}
}

func TestBuildDraftsIgnoresBackgroundForMedia(t *testing.T) {
	drafts, err := buildDrafts(uuid.New(), MomentTypeImage, "public", []CreateMomentItem{
		{Background: "not used", Overlays: nil},
		{Overlays: []models.MomentOverlay{validOverlay()}},
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
	files := func(count int) []*multipart.FileHeader {
		headers := make([]*multipart.FileHeader, count)
		for i := range headers {
			headers[i] = file
		}
		return headers
	}
	text, image, video := MomentTypeText, MomentTypeImage, MomentTypeVideo
	cases := map[string]struct {
		momentType string
		input      CreateMomentInput
		slides     []string
		ok         bool
	}{
		"text without files":       {text, CreateMomentInput{}, []string{text}, true},
		"text with image":          {text, CreateMomentInput{Images: files(1)}, []string{text}, false},
		"images match items":       {image, CreateMomentInput{Images: files(2), Thumbs: files(1)}, []string{image, image}, true},
		"images fewer than items":  {image, CreateMomentInput{Images: files(1)}, []string{image, image}, false},
		"image with video":         {image, CreateMomentInput{Images: files(1), Video: file}, []string{image}, false},
		"mixed matches image only": {image, CreateMomentInput{Images: files(2), Thumbs: files(2)}, []string{image, text, image}, true},
		"mixed one image per page": {image, CreateMomentInput{Images: files(3)}, []string{image, text, image}, false},
		"mixed too many thumbs":    {image, CreateMomentInput{Images: files(1), Thumbs: files(2)}, []string{text, image}, false},
		"video only":               {video, CreateMomentInput{Video: file, Thumb: file}, []string{video}, true},
		"video missing":            {video, CreateMomentInput{Thumb: file}, []string{video}, false},
	}
	for name, tc := range cases {
		t.Run(name, func(t *testing.T) {
			input := tc.input
			drafts := make([]*models.Moment, len(tc.slides))
			for i, slide := range tc.slides {
				drafts[i] = &models.Moment{Type: slide}
			}
			err := validateFiles(tc.momentType, &input, drafts)
			if (err == nil) != tc.ok {
				t.Fatalf("validateFiles ok=%v, got err %v", tc.ok, err)
			}
		})
	}
}

func TestGroupTrayRowsKeepsAuthorOrderAndMomentOrder(t *testing.T) {
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
	if len(groups[0].momentIDs) != 2 || groups[0].momentIDs[0] != a1 || groups[0].momentIDs[1] != a2 {
		t.Fatalf("expected alice moments in query order, got %v", groups[0].momentIDs)
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
	delays := MomentTranscodeRetryDelays
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

func TestUploadFolderGroupsByVietnamDayThenKind(t *testing.T) {
	userID := uuid.MustParse("72c6ace6-562c-415a-96a2-7dfd6bdb9186")
	cases := []struct {
		momentType string
		now        time.Time
		want       string
	}{
		{MomentTypeImage, time.Date(2026, 10, 24, 16, 59, 0, 0, time.UTC), "moments/2026-10-24/images"},
		{MomentTypeVideo, time.Date(2026, 10, 24, 16, 59, 0, 0, time.UTC), "moments/2026-10-24/videos"},
		{MomentTypeImage, time.Date(2026, 10, 24, 17, 0, 0, 0, time.UTC), "moments/2026-10-25/images"},
		{MomentTypeVideo, time.Date(2026, 10, 24, 17, 0, 0, 0, time.UTC), "moments/2026-10-25/videos"},
	}
	for _, tc := range cases {
		if got := uploadFolder(tc.momentType, tc.now); got != tc.want {
			t.Errorf("uploadFolder(%s, %s) = %q, want %q", tc.momentType, tc.now, got, tc.want)
		}
	}
	if got, want := quotaKey(userID, time.Date(2026, 10, 24, 17, 0, 0, 0, time.UTC)), fmt.Sprintf(CacheKeyMomentQuota, userID.String(), "20261025"); got != want {
		t.Errorf("quota day should follow the same Vietnam day: %q, want %q", got, want)
	}
}

func TestMomentResponseHiddenFollowsEnabled(t *testing.T) {
	for _, enabled := range []bool{true, false} {
		moment := models.Moment{
			ID:        uuid.New(),
			Type:      MomentTypeText,
			Status:    MomentStatusReady,
			Enabled:   enabled,
			ExpiresAt: time.Date(2026, 10, 26, 0, 0, 0, 0, time.UTC),
		}
		resp := toMomentResponse(&moment, MomentAuthorResponse{})
		if resp.Hidden != !enabled {
			t.Fatalf("enabled=%v: hidden=%v, want %v", enabled, resp.Hidden, !enabled)
		}
	}
}

func TestMomentResponseMarksPurgedMediaOnlyForImageAndVideo(t *testing.T) {
	cases := []struct {
		momentType string
		status     string
		purged     bool
	}{
		{MomentTypeImage, MomentStatusPurged, true},
		{MomentTypeVideo, MomentStatusPurged, true},
		{MomentTypeVideo, MomentStatusPurging, false},
		{MomentTypeText, MomentStatusPurged, false},
		{MomentTypeImage, MomentStatusReady, false},
	}
	for _, tc := range cases {
		moment := models.Moment{
			ID:       uuid.New(),
			Type:     tc.momentType,
			Status:   tc.status,
			Enabled:  true,
			MediaURL: "https://cdn.example/media.jpg",
			ThumbURL: "https://cdn.example/thumb.jpg",
		}
		resp := toMomentResponse(&moment, MomentAuthorResponse{})
		if resp.MediaPurged != tc.purged {
			t.Fatalf("%s/%s: mediaPurged=%v, want %v", tc.momentType, tc.status, resp.MediaPurged, tc.purged)
		}
		mediaGone := tc.status != MomentStatusReady
		if mediaGone && (resp.MediaURL != "" || resp.ThumbURL != "") {
			t.Fatalf("%s/%s: urls of removed media must be blank, got %q %q", tc.momentType, tc.status, resp.MediaURL, resp.ThumbURL)
		}
	}
}

func TestMomentResponseHiddenByOnlyWhenHidden(t *testing.T) {
	admin := MomentHiddenByAdmin
	hidden := models.Moment{ID: uuid.New(), Status: MomentStatusReady, Enabled: false, HiddenBy: &admin}
	if got := toMomentResponse(&hidden, MomentAuthorResponse{}).HiddenBy; got != admin {
		t.Fatalf("hiddenBy=%q, want %q", got, admin)
	}
	shown := models.Moment{ID: uuid.New(), Status: MomentStatusReady, Enabled: true, HiddenBy: &admin}
	if got := toMomentResponse(&shown, MomentAuthorResponse{}).HiddenBy; got != "" {
		t.Fatalf("visible moment reported hiddenBy=%q", got)
	}
}

func TestHiddenFieldsClearAuthorOnShow(t *testing.T) {
	at := time.Date(2026, 10, 26, 8, 0, 0, 0, time.UTC)
	hide := HiddenFields(true, MomentHiddenByAdmin, at)
	if hide["enabled"] != false || hide["hidden_by"] != MomentHiddenByAdmin || hide["hidden_at"] != at {
		t.Fatalf("unexpected hide fields %v", hide)
	}
	show := HiddenFields(false, MomentHiddenByAdmin, at)
	if show["enabled"] != true || show["hidden_by"] != nil || show["hidden_at"] != nil {
		t.Fatalf("unexpected show fields %v", show)
	}
}

func TestStaleViewerCountsOnlyRaisesBehindRows(t *testing.T) {
	behind := &models.Moment{ID: uuid.New(), ViewerCount: 3}
	equal := &models.Moment{ID: uuid.New(), ViewerCount: 5}
	ahead := &models.Moment{ID: uuid.New(), ViewerCount: 9}
	missing := &models.Moment{ID: uuid.New(), ViewerCount: 4}
	live := map[uuid.UUID]int64{behind.ID: 7, equal.ID: 5, ahead.ID: 2}
	got := staleViewerCounts([]*models.Moment{behind, equal, ahead, missing}, live)
	if len(got) != 1 || got[behind.ID] != 7 {
		t.Fatalf("stale counts = %v, want only %s=7", got, behind.ID)
	}
}
