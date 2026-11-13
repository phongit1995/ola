package media

import (
	"bytes"
	"errors"
	"fmt"
	"image"
	_ "image/gif"
	_ "image/jpeg"
	_ "image/png"
	"io"
	"net/http"
	"path/filepath"
	"strings"

	_ "golang.org/x/image/webp"
)

var (
	ErrUnsupportedImage = errors.New("unsupported image type")
	ErrDecodeImage      = errors.New("failed to decode image")
	ErrImageTooLarge    = errors.New("image too large")
	ErrOpenImage        = errors.New("failed to open image")
	ErrReadImage        = errors.New("failed to read image")
)

var imageExtensions = map[string]string{
	"image/jpeg": ".jpg",
	"image/png":  ".png",
	"image/gif":  ".gif",
	"image/webp": ".webp",
}

type Image struct {
	Data   []byte
	Mime   string
	Width  int
	Height int
}

func ImageExtension(mime string) string {
	if ext, ok := imageExtensions[strings.ToLower(mime)]; ok {
		return ext
	}
	return ".jpg"
}

func ImageExtensionOrFile(mime, fileName string) string {
	if ext, ok := imageExtensions[strings.ToLower(mime)]; ok {
		return ext
	}
	return strings.ToLower(filepath.Ext(fileName))
}

func IsAllowedImageMime(mime string) bool {
	for _, m := range AllowedImageMimes {
		if strings.EqualFold(m, mime) {
			return true
		}
	}
	return false
}

func ReadImage(r io.Reader, maxSize int64) (*Image, error) {
	head := make([]byte, imageSniffBytes)
	n, _ := io.ReadFull(r, head)
	head = head[:n]
	mime := http.DetectContentType(head)
	if !IsAllowedImageMime(mime) {
		return nil, fmt.Errorf("%w: %s", ErrUnsupportedImage, mime)
	}
	rest, err := ReadAllLimited(r, maxSize-int64(n))
	if err != nil {
		return nil, err
	}
	data := append(head, rest...)
	cfg, _, err := image.DecodeConfig(bytes.NewReader(data))
	if err != nil {
		return nil, fmt.Errorf("%w: %v", ErrDecodeImage, err)
	}
	return &Image{Data: data, Mime: mime, Width: cfg.Width, Height: cfg.Height}, nil
}

func PlainImageError(err error) error {
	switch {
	case errors.Is(err, ErrFileTooLarge):
		return ErrImageTooLarge
	case errors.Is(err, ErrUnsupportedImage):
		return ErrUnsupportedImage
	case errors.Is(err, ErrDecodeImage):
		return ErrDecodeImage
	default:
		return ErrReadImage
	}
}
