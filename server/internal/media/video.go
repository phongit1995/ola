package media

import (
	"encoding/binary"
	"errors"
)

var (
	ErrNotMP4Video          = errors.New("not an mp4 video")
	ErrUnknownVideoDuration = errors.New("unknown video duration")
)

type VideoInfo struct {
	Duration float64
	Width    int
	Height   int
	Codec    string
	HasAudio bool
}

func IsISOBaseMedia(data []byte) bool {
	return len(data) >= 12 && string(data[4:8]) == "ftyp"
}

func IsQuickTimeMovie(data []byte) bool {
	return IsISOBaseMedia(data) && string(data[8:12]) == "qt  "
}

func ProbeMP4Video(data []byte) (VideoInfo, error) {
	if !IsISOBaseMedia(data) {
		return VideoInfo{}, ErrNotMP4Video
	}
	moov, ok := findMP4Box(data, "moov")
	if !ok {
		return VideoInfo{}, ErrNotMP4Video
	}
	duration, ok := measureMP4Duration(data, 0)
	if !ok {
		return VideoInfo{}, ErrUnknownVideoDuration
	}
	info := VideoInfo{Duration: duration}
	eachMP4Box(moov, "trak", func(trak []byte) {
		handler := trackHandler(trak)
		switch handler {
		case "soun":
			info.HasAudio = true
		case "vide":
			if info.Codec != "" {
				return
			}
			info.Codec = trackCodec(trak)
			if tkhd, ok := findMP4Box(trak, "tkhd"); ok {
				info.Width, info.Height = trackDimensions(tkhd)
			}
		}
	})
	if info.Codec == "" {
		return VideoInfo{}, ErrNotMP4Video
	}
	return info, nil
}

func trackHandler(trak []byte) string {
	hdlr, ok := findMP4Box(trak, "mdia", "hdlr")
	if !ok || len(hdlr) < 12 {
		return ""
	}
	return string(hdlr[8:12])
}

func trackCodec(trak []byte) string {
	stsd, ok := findMP4Box(trak, "mdia", "minf", "stbl", "stsd")
	if !ok || len(stsd) < 16 {
		return ""
	}
	return string(stsd[12:16])
}

func trackDimensions(tkhd []byte) (int, int) {
	matrixAt, sizeAt := 40, 76
	if len(tkhd) > 0 && tkhd[0] == 1 {
		matrixAt, sizeAt = 52, 88
	}
	if len(tkhd) < sizeAt+8 {
		return 0, 0
	}
	width := int(binary.BigEndian.Uint32(tkhd[sizeAt:sizeAt+4]) >> 16)
	height := int(binary.BigEndian.Uint32(tkhd[sizeAt+4:sizeAt+8]) >> 16)
	a := int32(binary.BigEndian.Uint32(tkhd[matrixAt : matrixAt+4]))
	b := int32(binary.BigEndian.Uint32(tkhd[matrixAt+4 : matrixAt+8]))
	if a == 0 && b != 0 {
		width, height = height, width
	}
	return width, height
}

func findMP4Box(data []byte, path ...string) ([]byte, bool) {
	if len(path) == 0 {
		return data, true
	}
	for offset := 0; offset+8 <= len(data); {
		size, headerSize, ok := mp4BoxSize(data, offset)
		if !ok {
			return nil, false
		}
		if string(data[offset+4:offset+8]) == path[0] {
			return findMP4Box(data[offset+headerSize:offset+size], path[1:]...)
		}
		offset += size
	}
	return nil, false
}

func eachMP4Box(data []byte, typ string, fn func(payload []byte)) {
	for offset := 0; offset+8 <= len(data); {
		size, headerSize, ok := mp4BoxSize(data, offset)
		if !ok {
			return
		}
		if string(data[offset+4:offset+8]) == typ {
			fn(data[offset+headerSize : offset+size])
		}
		offset += size
	}
}
