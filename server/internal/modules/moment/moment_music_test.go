package moment

import (
	"errors"
	"mime/multipart"
	"slices"
	"strings"
	"testing"

	"ola-chat-server/internal/models"
)

func TestValidateMusicRequest(t *testing.T) {
	valid := &CreateMomentMusic{Title: "  Bài   hát  ", StartMs: 0}
	if err := validateMusicRequest(MomentTypeImage, valid); err != nil {
		t.Fatalf("valid request rejected: %v", err)
	}
	if valid.Title != "Bài hát" {
		t.Fatalf("title not normalized: %q", valid.Title)
	}
	cases := []struct {
		momentType string
		music      CreateMomentMusic
		want       error
	}{
		{MomentTypeVideo, CreateMomentMusic{Title: "a"}, errMusicNotAllowed},
		{MomentTypeText, CreateMomentMusic{Title: "a", StartMs: -1}, errMusicRange},
		{MomentTypeText, CreateMomentMusic{Title: strings.Repeat("a", MaxMomentMusicTitleRunes+1)}, errMusicTitle},
	}
	for _, tc := range cases {
		music := tc.music
		if err := validateMusicRequest(tc.momentType, &music); !errors.Is(err, tc.want) {
			t.Fatalf("%+v: got %v, want %v", tc.music, err, tc.want)
		}
	}
}

func TestMusicInputStartIsOptional(t *testing.T) {
	cases := []struct {
		values map[string][]string
		want   error
		start  int
	}{
		{map[string][]string{}, nil, 0},
		{map[string][]string{"musicStartMs": {"  "}}, nil, 0},
		{map[string][]string{"musicStartMs": {"21000"}}, nil, 21000},
		{map[string][]string{"musicStartMs": {"abc"}}, errMusicRange, 0},
		{map[string][]string{"musicStartMs": {"-5"}}, errMusicRange, 0},
	}
	for _, tc := range cases {
		form := &multipart.Form{
			Value: tc.values,
			File:  map[string][]*multipart.FileHeader{"music": {{Filename: "bai.mp3"}}},
		}
		music := musicInput(form)
		if music == nil {
			t.Fatalf("%v: music input missing", tc.values)
		}
		err := validateMusicRequest(MomentTypeImage, music)
		if !errors.Is(err, tc.want) {
			t.Fatalf("%v: got %v, want %v", tc.values, err, tc.want)
		}
		if tc.want == nil && music.StartMs != tc.start {
			t.Fatalf("%v: start %d, want %d", tc.values, music.StartMs, tc.start)
		}
	}
}

func TestBlankMusicTitleUsesFileName(t *testing.T) {
	cases := []struct{ title, fileName, want string }{
		{"", "Bai_hat  moi.mp3", "Bai hat moi"},
		{"   ", "Ghi âm 12.m4a", "Ghi âm 12"},
		{"", "___.mp3", "___.mp3"},
		{"", strings.Repeat("á", MaxMomentMusicTitleRunes+5) + ".mp3", strings.Repeat("á", MaxMomentMusicTitleRunes)},
		{" Tên  riêng ", "file.mp3", "Tên riêng"},
	}
	for _, tc := range cases {
		music := CreateMomentMusic{Title: tc.title, File: &multipart.FileHeader{Filename: tc.fileName}}
		if err := validateMusicRequest(MomentTypeText, &music); err != nil {
			t.Fatalf("%q: %v", tc.fileName, err)
		}
		if music.Title != tc.want {
			t.Fatalf("%q: got %q, want %q", tc.fileName, music.Title, tc.want)
		}
	}
}

func TestCheckMusicLength(t *testing.T) {
	cases := []struct {
		duration int
		want     error
	}{
		{60000, nil},
		{MinMomentMusicMs, nil},
		{4000, errMusicTooShort},
		{MaxMomentMusicMs + 1, errMusicTooLong},
	}
	for _, tc := range cases {
		if err := checkMusicLength(tc.duration); !errors.Is(err, tc.want) {
			t.Fatalf("%+v: got %v", tc, err)
		}
	}
}

func TestPlanMusicStart(t *testing.T) {
	cases := []struct {
		duration, start, wantStart int
		wantLoop                   bool
	}{
		{60000, 10000, 10000, false},
		{60000, 50000, 45000, false},
		{MomentMusicTotalMs, 3000, 0, false},
		{10000, 4000, 0, true},
	}
	for _, tc := range cases {
		start, loop := planMusicStart(tc.duration, tc.start)
		if start != tc.wantStart || loop != tc.wantLoop {
			t.Fatalf("%+v: got %d %v", tc, start, loop)
		}
	}
}

func TestParseMusicProbe(t *testing.T) {
	info, err := parseMusicProbe([]byte(`{"format":{"format_name":"mov,mp4,m4a,3gp,3g2,mj2","duration":"12.5"},"streams":[{"codec_type":"audio"}]}`))
	if err != nil || info.DurationMs != 12500 {
		t.Fatalf("m4a: %+v %v", info, err)
	}
	if _, err := parseMusicProbe([]byte(`{"format":{"format_name":"matroska,webm","duration":"12"},"streams":[{"codec_type":"audio"}]}`)); !errors.Is(err, errProbeNotMusic) {
		t.Fatalf("matroska should be rejected: %v", err)
	}
	if _, err := parseMusicProbe([]byte(`{"format":{"format_name":"mp3","duration":"12"},"streams":[{"codec_type":"video"}]}`)); !errors.Is(err, errProbeNoAudio) {
		t.Fatalf("no audio stream should be rejected: %v", err)
	}
}

func TestMusicClipArgsDropMetadataAndVideo(t *testing.T) {
	args := musicClipArgs("in", "out", 1500, 5000, false)
	for _, want := range []string{"-vn", "1.500", "5.000", "aac"} {
		if !slices.Contains(args, want) {
			t.Fatalf("missing %s in %v", want, args)
		}
	}
	if slices.Contains(args, "-stream_loop") {
		t.Fatalf("unexpected loop in %v", args)
	}
	looped := musicClipArgs("in", "out", 7500, 7500, true)
	if slices.Index(looped, "-stream_loop") < 0 || slices.Index(looped, "-stream_loop") > slices.Index(looped, "-i") {
		t.Fatalf("loop must come before the input in %v", looped)
	}
}

func TestMusicResponseHiddenUnlessReady(t *testing.T) {
	row := &models.Moment{MusicURL: "u", MusicTitle: "t", MusicDurationMs: 5000, Status: MomentStatusReady}
	if got := musicResponse(row); got == nil || got.URL != "u" {
		t.Fatalf("ready moment should expose music: %+v", got)
	}
	row.Status = MomentStatusPurged
	if musicResponse(row) != nil {
		t.Fatal("purged moment must not expose music")
	}
}

func TestCleanupCandidateIncludesMusic(t *testing.T) {
	row := cleanupCandidate{MediaObject: "a", MusicObject: "m"}
	if !slices.Contains(row.objects(), "m") {
		t.Fatalf("music object missing: %v", row.objects())
	}
}
