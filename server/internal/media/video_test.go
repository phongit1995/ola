package media

import (
	"encoding/binary"
	"errors"
	"testing"
)

func mp4Box(typ string, payloads ...[]byte) []byte {
	size := 8
	for _, p := range payloads {
		size += len(p)
	}
	out := make([]byte, 8, size)
	binary.BigEndian.PutUint32(out[0:4], uint32(size))
	copy(out[4:8], typ)
	for _, p := range payloads {
		out = append(out, p...)
	}
	return out
}

func mvhdPayload(timescale, duration uint32) []byte {
	payload := make([]byte, 100)
	binary.BigEndian.PutUint32(payload[12:16], timescale)
	binary.BigEndian.PutUint32(payload[16:20], duration)
	return payload
}

func tkhdPayload(width, height uint32, rotated bool) []byte {
	payload := make([]byte, 84)
	a, b := uint32(0x00010000), uint32(0)
	if rotated {
		a, b = 0, 0x00010000
	}
	binary.BigEndian.PutUint32(payload[40:44], a)
	binary.BigEndian.PutUint32(payload[44:48], b)
	binary.BigEndian.PutUint32(payload[76:80], width<<16)
	binary.BigEndian.PutUint32(payload[80:84], height<<16)
	return payload
}

func hdlrPayload(handler string) []byte {
	payload := make([]byte, 24)
	copy(payload[8:12], handler)
	return payload
}

func stsdPayload(codec string) []byte {
	payload := make([]byte, 16)
	binary.BigEndian.PutUint32(payload[4:8], 1)
	binary.BigEndian.PutUint32(payload[8:12], 8)
	copy(payload[12:16], codec)
	return payload
}

func videoTrak(codec string, width, height uint32, rotated bool) []byte {
	return mp4Box("trak",
		mp4Box("tkhd", tkhdPayload(width, height, rotated)),
		mp4Box("mdia",
			mp4Box("hdlr", hdlrPayload("vide")),
			mp4Box("minf", mp4Box("stbl", mp4Box("stsd", stsdPayload(codec)))),
		),
	)
}

func audioTrak() []byte {
	return mp4Box("trak", mp4Box("mdia", mp4Box("hdlr", hdlrPayload("soun"))))
}

func sampleMP4(moovChildren ...[]byte) []byte {
	ftyp := mp4Box("ftyp", []byte("isom"), make([]byte, 4), []byte("isomavc1"))
	return append(ftyp, mp4Box("moov", moovChildren...)...)
}

func TestProbeMP4VideoReadsDurationSizeAndCodec(t *testing.T) {
	data := sampleMP4(
		mp4Box("mvhd", mvhdPayload(1000, 12500)),
		videoTrak("avc1", 1080, 1920, false),
		audioTrak(),
	)
	info, err := ProbeMP4Video(data)
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if info.Duration != 12.5 || info.Width != 1080 || info.Height != 1920 || info.Codec != "avc1" || !info.HasAudio {
		t.Fatalf("unexpected info %+v", info)
	}
}

func TestProbeMP4VideoSwapsRotatedDimensions(t *testing.T) {
	data := sampleMP4(
		mp4Box("mvhd", mvhdPayload(600, 3000)),
		videoTrak("hvc1", 1920, 1080, true),
	)
	info, err := ProbeMP4Video(data)
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if info.Width != 1080 || info.Height != 1920 || info.Codec != "hvc1" || info.HasAudio {
		t.Fatalf("unexpected info %+v", info)
	}
}

func TestIsQuickTimeMovie(t *testing.T) {
	mp4 := sampleMP4(mp4Box("mvhd", mvhdPayload(1000, 5000)), videoTrak("avc1", 720, 1280, false))
	mov := append([]byte(nil), mp4...)
	copy(mov[8:12], "qt  ")
	if IsQuickTimeMovie(mp4) {
		t.Fatal("isom brand must not be treated as QuickTime")
	}
	if !IsQuickTimeMovie(mov) {
		t.Fatal("qt brand must be treated as QuickTime")
	}
	if IsQuickTimeMovie([]byte("not a video at all")) {
		t.Fatal("random bytes must not be QuickTime")
	}
}

func TestProbeMP4VideoRejectsInvalidInput(t *testing.T) {
	cases := map[string]struct {
		data []byte
		want error
	}{
		"not iso media":  {data: []byte("this is not a video file"), want: ErrNotMP4Video},
		"audio only":     {data: sampleMP4(mp4Box("mvhd", mvhdPayload(1000, 5000)), audioTrak()), want: ErrNotMP4Video},
		"zero duration":  {data: sampleMP4(mp4Box("mvhd", mvhdPayload(1000, 0)), videoTrak("avc1", 720, 1280, false)), want: ErrUnknownVideoDuration},
		"missing moov":   {data: mp4Box("ftyp", []byte("isom"), make([]byte, 8)), want: ErrNotMP4Video},
		"truncated moov": {data: sampleMP4(mp4Box("mvhd", mvhdPayload(1000, 5000)), videoTrak("avc1", 720, 1280, false))[:40], want: ErrNotMP4Video},
	}
	for name, tc := range cases {
		t.Run(name, func(t *testing.T) {
			if _, err := ProbeMP4Video(tc.data); !errors.Is(err, tc.want) {
				t.Fatalf("expected %v, got %v", tc.want, err)
			}
		})
	}
}
