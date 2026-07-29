package message

import (
	"encoding/binary"
	"fmt"
	"math"
	"strings"

	"github.com/gabriel-vasile/mimetype"
)

const (
	maxAudioBytesPerSecond = 256 * 1024
	audioContainerOverhead = 256 * 1024
)

func baseMime(value string) string {
	if idx := strings.Index(value, ";"); idx >= 0 {
		value = value[:idx]
	}
	return strings.ToLower(strings.TrimSpace(value))
}

func validateAudioDuration(duration float64) error {
	if math.IsNaN(duration) || math.IsInf(duration, 0) || duration <= 0 {
		return fmt.Errorf("%w: invalid duration", ErrInvalidMetadata)
	}
	return nil
}

func validateAudioWaveform(waveform []float64, maxSamples int) error {
	if len(waveform) > maxSamples {
		return fmt.Errorf("%w: invalid waveform", ErrInvalidMetadata)
	}
	for _, sample := range waveform {
		if math.IsNaN(sample) || math.IsInf(sample, 0) || sample < 0 || sample > 1 {
			return fmt.Errorf("%w: invalid waveform", ErrInvalidMetadata)
		}
	}
	return nil
}

// The multipart Content-Type is untrusted; WebM and generic MP4 containers
// also need evidence that they contain audio and no video track.
func detectAudioMime(data []byte, declared string) (string, error) {
	declared = baseMime(declared)
	detected := baseMime(mimetype.Detect(data).String())

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

func validateAudioPayloadSize(size int64, duration float64) error {
	if err := validateAudioDuration(duration); err != nil {
		return err
	}
	maximum := int64(math.Ceil(duration))*maxAudioBytesPerSecond + audioContainerOverhead
	if size > maximum {
		return fmt.Errorf("%w: duration does not match payload size", ErrInvalidMetadata)
	}
	return nil
}

func validateMeasuredAudioDuration(data []byte, mime string, reported, maximum float64) error {
	actual, ok := measureAudioDuration(data, mime)
	if !ok {
		return nil
	}
	if actual <= 0 || actual > maximum {
		return fmt.Errorf("%w: measured duration out of range", ErrInvalidMetadata)
	}
	tolerance := math.Max(1.25, actual*0.05)
	if math.Abs(actual-reported) > tolerance {
		return fmt.Errorf("%w: duration does not match audio", ErrInvalidMetadata)
	}
	return nil
}

func measureAudioDuration(data []byte, mime string) (float64, bool) {
	switch baseMime(mime) {
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

func mp4MovieHeaderDuration(payload []byte) (float64, bool) {
	if len(payload) < 20 {
		return 0, false
	}
	if payload[0] == 1 {
		if len(payload) < 32 {
			return 0, false
		}
		timescale := binary.BigEndian.Uint32(payload[20:24])
		duration := binary.BigEndian.Uint64(payload[24:32])
		if timescale == 0 || duration == 0 {
			return 0, false
		}
		return float64(duration) / float64(timescale), true
	}
	timescale := binary.BigEndian.Uint32(payload[12:16])
	duration := binary.BigEndian.Uint32(payload[16:20])
	if timescale == 0 || duration == 0 {
		return 0, false
	}
	return float64(duration) / float64(timescale), true
}

func isAudioOnlyWebM(data []byte) bool {
	hasAudio, hasVideo := scanWebMTrackTypes(data)
	return hasAudio && !hasVideo
}

func scanWebMTrackTypes(data []byte) (hasAudio, hasVideo bool) {
	for offset := 0; offset < len(data); {
		id, payloadStart, payloadEnd, next, ok := readEBMLElement(data, offset)
		if !ok {
			return false, false
		}
		if id == 0x18538067 {
			return scanWebMSegment(data[payloadStart:payloadEnd])
		}
		offset = next
	}
	return false, false
}

func scanWebMSegment(data []byte) (hasAudio, hasVideo bool) {
	for offset := 0; offset < len(data); {
		id, payloadStart, payloadEnd, next, ok := readEBMLElement(data, offset)
		if !ok {
			return hasAudio, hasVideo
		}
		if id == 0x1654AE6B {
			audio, video := scanWebMTracks(data[payloadStart:payloadEnd])
			hasAudio = hasAudio || audio
			hasVideo = hasVideo || video
		}
		if hasAudio && hasVideo {
			return true, true
		}
		offset = next
	}
	return hasAudio, hasVideo
}

func scanWebMTracks(data []byte) (hasAudio, hasVideo bool) {
	for offset := 0; offset < len(data); {
		id, payloadStart, payloadEnd, next, ok := readEBMLElement(data, offset)
		if !ok {
			return hasAudio, hasVideo
		}
		if id == 0xAE {
			switch webMTrackType(data[payloadStart:payloadEnd]) {
			case 1:
				hasVideo = true
			case 2:
				hasAudio = true
			}
		}
		offset = next
	}
	return hasAudio, hasVideo
}

func webMTrackType(data []byte) uint64 {
	for offset := 0; offset < len(data); {
		id, payloadStart, payloadEnd, next, ok := readEBMLElement(data, offset)
		if !ok {
			return 0
		}
		if id == 0x83 {
			return readEBMLUnsigned(data[payloadStart:payloadEnd])
		}
		offset = next
	}
	return 0
}

func readEBMLElement(data []byte, offset int) (id uint64, payloadStart, payloadEnd, next int, ok bool) {
	id, idLength, _, ok := readEBMLVInt(data, offset, 4, true)
	if !ok {
		return 0, 0, 0, 0, false
	}
	size, sizeLength, unknownSize, ok := readEBMLVInt(data, offset+idLength, 8, false)
	if !ok {
		return 0, 0, 0, 0, false
	}
	payloadStart = offset + idLength + sizeLength
	if unknownSize {
		payloadEnd = len(data)
	} else {
		if size > uint64(len(data)-payloadStart) {
			return 0, 0, 0, 0, false
		}
		payloadEnd = payloadStart + int(size)
	}
	return id, payloadStart, payloadEnd, payloadEnd, true
}

func readEBMLVInt(data []byte, offset, maxLength int, keepMarker bool) (value uint64, length int, allOnes bool, ok bool) {
	if offset < 0 || offset >= len(data) || data[offset] == 0 {
		return 0, 0, false, false
	}
	marker := byte(0x80)
	length = 1
	for length <= maxLength && data[offset]&marker == 0 {
		marker >>= 1
		length++
	}
	if length > maxLength || offset+length > len(data) {
		return 0, 0, false, false
	}
	value = uint64(data[offset])
	if !keepMarker {
		value = uint64(data[offset] & (marker - 1))
	}
	for index := 1; index < length; index++ {
		value = value<<8 | uint64(data[offset+index])
	}
	if !keepMarker {
		allOnes = value == (uint64(1)<<uint(7*length))-1
	}
	return value, length, allOnes, true
}

func readEBMLUnsigned(data []byte) uint64 {
	if len(data) == 0 || len(data) > 8 {
		return 0
	}
	var value uint64
	for _, item := range data {
		value = value<<8 | uint64(item)
	}
	return value
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
