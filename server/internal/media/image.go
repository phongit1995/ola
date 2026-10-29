package media

import (
	"path/filepath"
	"strings"
)

var imageExtensions = map[string]string{
	"image/jpeg": ".jpg",
	"image/png":  ".png",
	"image/gif":  ".gif",
	"image/webp": ".webp",
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
