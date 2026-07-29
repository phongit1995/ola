package media

import (
	"bytes"
	"encoding/binary"
	"errors"
	"fmt"
	"math"
	"ola-chat-server/internal/constants"
	"path/filepath"
	"strings"

	"github.com/gabriel-vasile/mimetype"
)

const (
	maxAudioBytesPerSecond = 256 * 1024
	audioContainerOverhead = 256 * 1024
)

var (
	ErrUnsupportedAudio = errors.New("unsupported audio type")
	ErrInvalidAudio     = errors.New("invalid audio")
)

var webMVideoCodecIDs = []string{
	"V_VP8",
	"V_VP9",
	"V_AV1",
	"V_MPEG1",
	"V_MPEG2",
	"V_MPEG4",
	"V_MPEGH",
	"V_THEORA",
	"V_REAL",
	"V_QUICKTIME",
	"V_DIRAC",
	"V_PRORES",
	"V_UNCOMPRESSED",
	"V_MS/VFW/FOURCC",
}

func BaseMime(value string) string {
	if idx := strings.Index(value, ";"); idx >= 0 {
		value = value[:idx]
	}
	return strings.ToLower(strings.TrimSpace(value))
}

func IsAllowedAudioMime(mime string) bool {
	base := BaseMime(mime)
	for _, m := range constants.AllowedAudioMimes {
		if strings.EqualFold(m, base) {
			return true
		}
	}
	return false
}

func PickAudioExtension(mime, originalName string) string {
	switch BaseMime(mime) {
	case "audio/webm":
		return ".webm"
	case "audio/mp4", "audio/x-m4a", "audio/aac":
		return ".m4a"
	case "audio/mpeg":
		return ".mp3"
	case "audio/wav", "audio/x-wav":
		return ".wav"
	case "audio/ogg":
		return ".ogg"
	}
	if ext := strings.ToLower(filepath.Ext(originalName)); ext != "" {
		return ext
	}
	return ".bin"
}

func ValidateDuration(duration float64) error {
	if math.IsNaN(duration) || math.IsInf(duration, 0) || duration <= 0 {
		return fmt.Errorf("%w: invalid duration", ErrInvalidAudio)
	}
	return nil
}

func ValidateWaveform(waveform []float64, maxSamples int) error {
	if len(waveform) > maxSamples {
		return fmt.Errorf("%w: invalid waveform", ErrInvalidAudio)
	}
	for _, sample := range waveform {
		if math.IsNaN(sample) || math.IsInf(sample, 0) || sample < 0 || sample > 1 {
			return fmt.Errorf("%w: invalid waveform", ErrInvalidAudio)
		}
	}
	return nil
}

// The multipart Content-Type is untrusted; WebM and generic MP4 containers
// also need evidence that they contain audio and no video track.
func DetectAudioMime(data []byte, declared string) (string, error) {
	declared = BaseMime(declared)
	detected := BaseMime(mimetype.Detect(data).String())

	switch detected {
	case "video/webm", "audio/webm":
		if declared == "audio/webm" && isAudioOnlyWebM(data) {
			return "audio/webm", nil
		}
	case "video/mp4", "audio/mp4", "audio/x-m4a":
		if (declared == "audio/mp4" || declared == "audio/x-m4a") && isAudioOnlyMP4(data) {
			return "audio/mp4", nil
		}
	case "audio/aac":
		if declared == "audio/aac" {
			return "audio/aac", nil
		}
	case "audio/mpeg":
		if declared == "audio/mpeg" {
			return "audio/mpeg", nil
		}
	case "audio/wav":
		if declared == "audio/wav" || declared == "audio/x-wav" {
			return "audio/wav", nil
		}
	case "audio/ogg":
		if declared == "audio/ogg" {
			return "audio/ogg", nil
		}
	}

	return "", fmt.Errorf("%w: declared=%s detected=%s", ErrUnsupportedAudio, declared, detected)
}

func ValidatePayloadSize(size int64, duration float64) error {
	if err := ValidateDuration(duration); err != nil {
		return err
	}
	maximum := int64(math.Ceil(duration))*maxAudioBytesPerSecond + audioContainerOverhead
	if size > maximum {
		return fmt.Errorf("%w: duration does not match payload size", ErrInvalidAudio)
	}
	return nil
}

func ValidateMeasuredDuration(data []byte, mime string, reported, maximum float64) error {
	actual, ok := measureAudioDuration(data, mime)
	if !ok {
		return nil
	}
	if actual <= 0 {
		return fmt.Errorf("%w: measured duration out of range", ErrInvalidAudio)
	}
	tolerance := math.Max(1.25, actual*0.05)
	if actual > maximum+tolerance {
		return fmt.Errorf("%w: measured duration out of range", ErrInvalidAudio)
	}
	if math.Abs(actual-reported) > tolerance {
		return fmt.Errorf("%w: duration does not match audio", ErrInvalidAudio)
	}
	return nil
}

func measureAudioDuration(data []byte, mime string) (float64, bool) {
	switch BaseMime(mime) {
	case "audio/wav", "audio/x-wav":
		return measureWAVDuration(data)
	case "audio/mp4", "audio/x-m4a":
		return measureMP4Duration(data, 0)
	default:
		return 0, false
	}
}

func measureWAVDuration(data []byte) (float64, bool) {
	if len(data) < 12 || string(data[:4]) != "RIFF" || string(data[8:12]) != "WAVE" {
		return 0, false
	}
	var byteRate uint32
	var dataSize uint32
	for offset := 12; offset+8 <= len(data); {
		chunkType := string(data[offset : offset+4])
		chunkSize := binary.LittleEndian.Uint32(data[offset+4 : offset+8])
		payloadStart := offset + 8
		payloadEnd := payloadStart + int(chunkSize)
		if payloadEnd > len(data) {
			return 0, false
		}
		switch chunkType {
		case "fmt ":
			if chunkSize >= 12 {
				byteRate = binary.LittleEndian.Uint32(data[payloadStart+8 : payloadStart+12])
			}
		case "data":
			dataSize = chunkSize
		}
		if byteRate > 0 && dataSize > 0 {
			return float64(dataSize) / float64(byteRate), true
		}
		offset = payloadEnd + int(chunkSize%2)
	}
	return 0, false
}

func measureMP4Duration(data []byte, depth int) (float64, bool) {
	if depth > 8 {
		return 0, false
	}
	for offset := 0; offset+8 <= len(data); {
		size, headerSize, ok := mp4BoxSize(data, offset)
		if !ok {
			break
		}
		typ := string(data[offset+4 : offset+8])
		payloadStart := offset + headerSize
		boxEnd := offset + size
		payload := data[payloadStart:boxEnd]
		if typ == "mvhd" {
			if duration, ok := mp4MovieHeaderDuration(payload); ok {
				return duration, true
			}
		}
		if typ == "moov" {
			if duration, ok := measureMP4Duration(payload, depth+1); ok {
				return duration, true
			}
		}
		offset = boxEnd
	}
	return 0, false
}

// A zero mvhd duration means "unknown" (fragmented MP4 writes it that way),
// not "zero seconds".
func mp4MovieHeaderDuration(payload []byte) (float64, bool) {
	if len(payload) < 20 {
		return 0, false
	}
	var timescale uint32
	var duration uint64
	if payload[0] == 1 {
		if len(payload) < 32 {
			return 0, false
		}
		timescale = binary.BigEndian.Uint32(payload[20:24])
		duration = binary.BigEndian.Uint64(payload[24:32])
	} else {
		timescale = binary.BigEndian.Uint32(payload[12:16])
		duration = uint64(binary.BigEndian.Uint32(payload[16:20]))
	}
	if timescale == 0 || duration == 0 {
		return 0, false
	}
	return float64(duration) / float64(timescale), true
}

// Matching only full CodecID strings: a bare "V_" probe would hit compressed
// audio payloads by chance and reject most real recordings.
func isAudioOnlyWebM(data []byte) bool {
	hasAudioCodec := bytes.Contains(data, []byte("A_OPUS")) ||
		bytes.Contains(data, []byte("A_VORBIS"))
	if !hasAudioCodec {
		return false
	}
	for _, codec := range webMVideoCodecIDs {
		if bytes.Contains(data, []byte(codec)) {
			return false
		}
	}
	return true
}

func isAudioOnlyMP4(data []byte) bool {
	hasAudio, hasVideo := scanMP4Boxes(data, 0)
	return hasAudio && !hasVideo
}

func scanMP4Boxes(data []byte, depth int) (hasAudio, hasVideo bool) {
	if depth > 8 {
		return false, false
	}
	for offset := 0; offset+8 <= len(data); {
		size, headerSize, ok := mp4BoxSize(data, offset)
		if !ok {
			break
		}
		typ := string(data[offset+4 : offset+8])
		payloadStart := offset + headerSize
		boxEnd := offset + size
		payload := data[payloadStart:boxEnd]
		switch typ {
		case "hdlr":
			if len(payload) >= 12 {
				switch string(payload[8:12]) {
				case "soun":
					hasAudio = true
				case "vide":
					hasVideo = true
				}
			}
		case "moov", "trak", "mdia":
			audio, video := scanMP4Boxes(payload, depth+1)
			hasAudio = hasAudio || audio
			hasVideo = hasVideo || video
		}
		if hasAudio && hasVideo {
			return true, true
		}
		offset = boxEnd
	}
	return hasAudio, hasVideo
}

func mp4BoxSize(data []byte, offset int) (size, headerSize int, ok bool) {
	if offset < 0 || offset+8 > len(data) {
		return 0, 0, false
	}
	rawSize := uint64(binary.BigEndian.Uint32(data[offset : offset+4]))
	rawHeaderSize := uint64(8)
	if rawSize == 1 {
		if offset+16 > len(data) {
			return 0, 0, false
		}
		rawSize = binary.BigEndian.Uint64(data[offset+8 : offset+16])
		rawHeaderSize = 16
	} else if rawSize == 0 {
		rawSize = uint64(len(data) - offset)
	}
	if rawSize < rawHeaderSize || rawSize > uint64(len(data)-offset) {
		return 0, 0, false
	}
	return int(rawSize), int(rawHeaderSize), true
}
