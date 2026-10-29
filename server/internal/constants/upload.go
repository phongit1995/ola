package constants

const (
	MaxImageUploadSize           = 3 * 1024 * 1024
	MaxAudioUploadSize           = 10 * 1024 * 1024
	MaxAudioWaveformSamples      = 64
	UploadDateLayout             = "02012006"
	UploadDateLayoutDay          = "2006-01-02"
	CacheKeyRateLimitUpload      = "RATE_LIMIT:%s:UPLOAD"
	RateLimitUploadMaxRequests   = 30
	RateLimitUploadWindowSeconds = 60
)

var AllowedImageMimes = []string{
	"image/jpeg",
	"image/png",
	"image/gif",
	"image/webp",
}
