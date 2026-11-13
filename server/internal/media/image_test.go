package media

import (
	"bytes"
	"errors"
	"image"
	"image/png"
	"strings"
	"testing"
)

func pngBytes(t *testing.T, width, height int) []byte {
	t.Helper()
	var buf bytes.Buffer
	if err := png.Encode(&buf, image.NewRGBA(image.Rect(0, 0, width, height))); err != nil {
		t.Fatal(err)
	}
	return buf.Bytes()
}

func TestIsAllowedImageMime(t *testing.T) {
	for _, mime := range AllowedImageMimes {
		if !IsAllowedImageMime(mime) || !IsAllowedImageMime(strings.ToUpper(mime)) {
			t.Fatalf("%s should be allowed", mime)
		}
	}
	for _, mime := range []string{"", "image/svg+xml", "text/plain; charset=utf-8", "application/octet-stream"} {
		if IsAllowedImageMime(mime) {
			t.Fatalf("%s should not be allowed", mime)
		}
	}
}

func TestReadImageReturnsDataAndDimensions(t *testing.T) {
	data := pngBytes(t, 7, 3)
	img, err := ReadImage(bytes.NewReader(data), int64(len(data)))
	if err != nil {
		t.Fatalf("ReadImage: %v", err)
	}
	if !bytes.Equal(img.Data, data) || img.Mime != "image/png" || img.Width != 7 || img.Height != 3 {
		t.Fatalf("got mime=%s size=%d %dx%d", img.Mime, len(img.Data), img.Width, img.Height)
	}
}

func TestReadImageRejectsUnsupportedType(t *testing.T) {
	_, err := ReadImage(strings.NewReader("hello world"), 1024)
	if !errors.Is(err, ErrUnsupportedImage) || err.Error() != "unsupported image type: text/plain; charset=utf-8" {
		t.Fatalf("err = %v", err)
	}
}

func TestReadImageRejectsOversizedData(t *testing.T) {
	data := pngBytes(t, 64, 64)
	if _, err := ReadImage(bytes.NewReader(data), int64(len(data)-1)); err != ErrFileTooLarge {
		t.Fatalf("err = %v", err)
	}
	if _, err := ReadImage(bytes.NewReader(data), 10); err != ErrFileTooLarge {
		t.Fatalf("small limit err = %v", err)
	}
}

func TestReadImageRejectsUndecodableData(t *testing.T) {
	data := pngBytes(t, 4, 4)[:20]
	_, err := ReadImage(bytes.NewReader(data), 1024)
	if !errors.Is(err, ErrDecodeImage) || !strings.HasPrefix(err.Error(), "failed to decode image: ") {
		t.Fatalf("err = %v", err)
	}
}

func TestPlainImageError(t *testing.T) {
	cases := map[error]error{
		ErrFileTooLarge:                   ErrImageTooLarge,
		ErrUnsupportedImage:               ErrUnsupportedImage,
		errors.Join(ErrDecodeImage):       ErrDecodeImage,
		errors.New("failed to read file"): ErrReadImage,
	}
	for in, want := range cases {
		if got := PlainImageError(in); got != want {
			t.Fatalf("PlainImageError(%v) = %v, want %v", in, got, want)
		}
	}
}

func TestReadAllLimited(t *testing.T) {
	data, err := ReadAllLimited(strings.NewReader("abcd"), 4)
	if err != nil || string(data) != "abcd" {
		t.Fatalf("data=%q err=%v", data, err)
	}
	if _, err := ReadAllLimited(strings.NewReader("abcde"), 4); err != ErrFileTooLarge {
		t.Fatalf("err = %v", err)
	}
}

func TestReadAudioRejectsOversizedAndUnsupported(t *testing.T) {
	big := bytes.NewReader(make([]byte, MaxAudioUploadSize+1))
	if _, _, err := ReadAudio(big, "audio/webm", 1, 10); err != ErrFileTooLarge {
		t.Fatalf("oversized err = %v", err)
	}
	if _, _, err := ReadAudio(strings.NewReader("not audio"), "audio/webm", 1, 10); !errors.Is(err, ErrUnsupportedAudio) {
		t.Fatalf("unsupported err = %v", err)
	}
}
