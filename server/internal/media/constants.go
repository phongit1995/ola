package media

const (
	MaxImageUploadSize      = 3 * 1024 * 1024
	MaxAudioUploadSize      = 10 * 1024 * 1024
	MaxAudioWaveformSamples = 64
	UploadDateLayout        = "02012006"
	UploadDateLayoutDay     = "2006-01-02"
)

var AllowedImageMimes = []string{
	"image/jpeg",
	"image/png",
	"image/gif",
	"image/webp",
}

var AllowedAudioMimes = []string{
	"audio/webm",
	"audio/mp4",
	"audio/x-m4a",
	"audio/aac",
	"audio/mpeg",
	"audio/wav",
	"audio/x-wav",
	"audio/ogg",
}
