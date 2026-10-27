package moment

import (
	"errors"
	"slices"
	"strings"
	"testing"

	"github.com/google/uuid"
)

func mp4H264(width, height int, duration float64) *probedVideo {
	return &probedVideo{
		Containers: []string{"mov", "mp4", "m4a", "3gp", "3g2", "mj2"},
		Codec:      "h264",
		PixFmt:     "yuv420p",
		AudioCodec: "aac",
		Width:      width,
		Height:     height,
		Duration:   duration,
	}
}

func TestPlanVideo(t *testing.T) {
	with := func(change func(*probedVideo)) *probedVideo {
		info := mp4H264(720, 1280, 10)
		change(info)
		return info
	}
	cases := map[string]struct {
		info *probedVideo
		size int64
		want videoPlan
	}{
		"small h264 mp4 is remuxed":  {mp4H264(720, 1280, 10), 3_000_000, planRemux},
		"silent h264 is remuxed":     {with(func(v *probedVideo) { v.AudioCodec = "" }), 3_000_000, planRemux},
		"edge exactly 1280 is kept":  {mp4H264(1280, 720, 20), 10_000_000, planRemux},
		"hevc is encoded":            {with(func(v *probedVideo) { v.Codec = "hevc" }), 3_000_000, planEncode},
		"hdr h264 is encoded":        {with(func(v *probedVideo) { v.HDR = true }), 3_000_000, planEncode},
		"10-bit h264 is encoded":     {with(func(v *probedVideo) { v.PixFmt = "yuv420p10le" }), 3_000_000, planEncode},
		"pcm audio is encoded":       {with(func(v *probedVideo) { v.AudioCodec = "pcm_s16le" }), 3_000_000, planEncode},
		"h264 in mkv is encoded":     {with(func(v *probedVideo) { v.Containers = []string{"matroska", "webm"} }), 3_000_000, planEncode},
		"1080p h264 is downscaled":   {mp4H264(1080, 1920, 10), 3_000_000, planEncode},
		"high bitrate is re-encoded": {mp4H264(720, 1280, 10), 10_000_000, planEncode},
	}
	for name, tc := range cases {
		t.Run(name, func(t *testing.T) {
			if got := planVideo(tc.info, tc.size); got != tc.want {
				t.Fatalf("planVideo = %s, want %s", got, tc.want)
			}
		})
	}
}

func TestVideoArgsRemuxCopiesStreamsAndStripsMetadata(t *testing.T) {
	args := videoArgs(planRemux, false, "/tmp/in", "/tmp/out.mp4")
	joined := strings.Join(args, " ")
	for _, want := range []string{"-c copy", "-map_metadata -1", "-movflags +faststart", "-map 0:a:0?"} {
		if !strings.Contains(joined, want) {
			t.Fatalf("expected %q in %q", want, joined)
		}
	}
	if slices.Contains(args, "libx264") {
		t.Fatalf("remux must not re-encode: %q", joined)
	}
	if args[len(args)-1] != "/tmp/out.mp4" {
		t.Fatalf("output must be last, got %q", args[len(args)-1])
	}
}

func TestVideoArgsEncodeUsesH264WithBoundedSize(t *testing.T) {
	joined := strings.Join(videoArgs(planEncode, false, "/tmp/in", "/tmp/out.mp4"), " ")
	for _, want := range []string{"-c:v libx264", "-pix_fmt yuv420p", "-c:a aac", "-threads 2", "min(1280,iw)", "-map_metadata -1"} {
		if !strings.Contains(joined, want) {
			t.Fatalf("expected %q in %q", want, joined)
		}
	}
	if strings.Contains(joined, "tonemap") {
		t.Fatalf("sdr video must not be tonemapped: %q", joined)
	}
}

func TestVideoArgsEncodeTonemapsHDRBeforeScaling(t *testing.T) {
	filter := videoFilter(true)
	tonemap, scale := strings.Index(filter, "tonemap="), strings.Index(filter, "scale=w=")
	if tonemap < 0 || scale < 0 || tonemap > scale {
		t.Fatalf("expected tonemap before scale, got %q", filter)
	}
}

func TestParseProbeReadsMovFromIPhone(t *testing.T) {
	info, err := parseProbe([]byte(`{
		"format": {"format_name": "mov,mp4,m4a,3gp,3g2,mj2", "duration": "12.480000"},
		"streams": [
			{"codec_type": "video", "codec_name": "hevc", "pix_fmt": "yuv420p10le", "width": 1920, "height": 1080,
			 "color_transfer": "arib-std-b67", "side_data_list": [{"side_data_type": "Display Matrix", "rotation": -90}]},
			{"codec_type": "audio", "codec_name": "aac"}
		]}`))
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if info.Width != 1080 || info.Height != 1920 {
		t.Fatalf("expected rotated portrait size, got %dx%d", info.Width, info.Height)
	}
	if !info.HDR || info.Codec != "hevc" || info.AudioCodec != "aac" || info.Duration != 12.48 || !info.remuxableContainer() {
		t.Fatalf("unexpected info %+v", info)
	}
}

func TestParseProbeSkipsCoverArtAndFallsBackToStreamDuration(t *testing.T) {
	info, err := parseProbe([]byte(`{
		"format": {"format_name": "matroska,webm"},
		"streams": [
			{"codec_type": "video", "codec_name": "mjpeg", "width": 300, "height": 300, "disposition": {"attached_pic": 1}},
			{"codec_type": "video", "codec_name": "vp9", "width": 1280, "height": 720, "duration": "4.2", "tags": {"rotate": "180"}},
			{"codec_type": "audio", "codec_name": "opus"}
		]}`))
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if info.Codec != "vp9" || info.Width != 1280 || info.Height != 720 || info.Duration != 4.2 || info.remuxableContainer() {
		t.Fatalf("unexpected info %+v", info)
	}
}

func TestParseProbeRejectsFilesWithoutVideo(t *testing.T) {
	for name, raw := range map[string]string{
		"audio only": `{"format": {"format_name": "mp3", "duration": "3"}, "streams": [{"codec_type": "audio", "codec_name": "mp3"}]}`,
		"garbage":    `not json`,
	} {
		if _, err := parseProbe([]byte(raw)); err == nil {
			t.Fatalf("%s: expected error", name)
		}
	}
	_, err := parseProbe([]byte(`{"format": {}, "streams": [{"codec_type": "audio"}]}`))
	if !errors.Is(err, errProbeNoVideo) {
		t.Fatalf("expected errProbeNoVideo, got %v", err)
	}
}

func TestLastPacketTimeFindsLatestTimestamp(t *testing.T) {
	if got := lastPacketTime([]byte("0.000000\n0.033000,\nN/A\n5.966000\n5.933000\n")); got != 5.966 {
		t.Fatalf("expected 5.966, got %v", got)
	}
}

func TestCleanupCandidateObjectsSkipsEmptyAndDuplicates(t *testing.T) {
	row := cleanupCandidate{ID: uuid.New(), MediaObject: "moments/a.source", ThumbObject: "", SourceObject: "moments/a.source"}
	if got := row.objects(); len(got) != 1 || got[0] != "moments/a.source" {
		t.Fatalf("unexpected objects %v", got)
	}
}
