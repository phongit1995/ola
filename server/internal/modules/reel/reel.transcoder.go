package reel

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"math"
	"os/exec"
	"slices"
	"strconv"
	"strings"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"

	"go.uber.org/zap"
)

type videoPlan string

const (
	planRemux  videoPlan = "remux"
	planEncode videoPlan = "encode"
)

var (
	errProbeFailed        = errors.New("ffprobe could not read the file")
	errProbeNoVideo       = errors.New("file has no video stream")
	errProbeNoDuration    = errors.New("video duration is unknown")
	errTranscoderDisabled = errors.New("reel video transcoding is disabled")
)

type probedVideo struct {
	Containers []string
	Codec      string
	PixFmt     string
	AudioCodec string
	Width      int
	Height     int
	Duration   float64
	HDR        bool
}

type ffprobeStream struct {
	CodecType     string `json:"codec_type"`
	CodecName     string `json:"codec_name"`
	PixFmt        string `json:"pix_fmt"`
	Width         int    `json:"width"`
	Height        int    `json:"height"`
	Duration      string `json:"duration"`
	ColorTransfer string `json:"color_transfer"`
	Tags          struct {
		Rotate string `json:"rotate"`
	} `json:"tags"`
	SideDataList []struct {
		Rotation float64 `json:"rotation"`
	} `json:"side_data_list"`
	Disposition struct {
		AttachedPic int `json:"attached_pic"`
	} `json:"disposition"`
}

type ffprobeOutput struct {
	Format struct {
		FormatName string `json:"format_name"`
		Duration   string `json:"duration"`
	} `json:"format"`
	Streams []ffprobeStream `json:"streams"`
}

type Transcoder struct {
	ffmpeg  string
	ffprobe string
	logger  *zap.SugaredLogger
}

func NewTranscoder(cfg *config.Config, logger *zap.SugaredLogger) *Transcoder {
	log := logger.Named("[reel_transcoder]")
	if cfg.FFmpegPath == "" {
		log.Infow("Reel video transcoding disabled, only H.264 MP4 is accepted")
		return &Transcoder{logger: log}
	}
	ffmpeg, err := exec.LookPath(cfg.FFmpegPath)
	if err != nil {
		log.Warnw("ffmpeg not found, only H.264 MP4 is accepted", "path", cfg.FFmpegPath)
		return &Transcoder{logger: log}
	}
	ffprobe, err := exec.LookPath(cfg.FFprobePath)
	if err != nil {
		log.Warnw("ffprobe not found, only H.264 MP4 is accepted", "path", cfg.FFprobePath)
		return &Transcoder{logger: log}
	}
	log.Infow("ffmpeg ready for reel videos", "ffmpeg", ffmpeg, "ffprobe", ffprobe)
	return &Transcoder{ffmpeg: ffmpeg, ffprobe: ffprobe, logger: log}
}

func (t *Transcoder) Available() bool {
	return t.ffmpeg != "" && t.ffprobe != ""
}

func (v *probedVideo) remuxableContainer() bool {
	for _, container := range v.Containers {
		if slices.Contains(constants.ReelRemuxContainers, container) {
			return true
		}
	}
	return false
}

func planVideo(info *probedVideo, size int64) videoPlan {
	switch {
	case info.HDR,
		info.Codec != constants.ReelRemuxVideoCodec,
		info.PixFmt != "yuv420p" && info.PixFmt != "yuvj420p",
		!info.remuxableContainer(),
		info.AudioCodec != "" && info.AudioCodec != constants.ReelRemuxAudioCodec,
		max(info.Width, info.Height) > constants.ReelTranscodeMaxEdge,
		info.Duration > 0 && float64(size*8)/info.Duration > constants.ReelTranscodeMaxBitrate:
		return planEncode
	}
	return planRemux
}

func videoFilter(hdr bool) string {
	edge := strconv.Itoa(constants.ReelTranscodeMaxEdge)
	scale := fmt.Sprintf("scale=w='if(gte(iw,ih),trunc(min(%[1]s,iw)/2)*2,-2)':h='if(gte(iw,ih),-2,trunc(min(%[1]s,ih)/2)*2)'", edge)
	if hdr {
		return constants.ReelTonemapFilter + "," + scale
	}
	return scale
}

func videoArgs(plan videoPlan, hdr bool, src, dst string) []string {
	args := []string{"-hide_banner", "-loglevel", "error", "-nostdin", "-y", "-i", src,
		"-map", "0:v:0", "-map", "0:a:0?", "-map_metadata", "-1", "-map_chapters", "-1"}
	if plan == planEncode {
		args = append(args,
			"-vf", videoFilter(hdr),
			"-c:v", "libx264", "-preset", constants.ReelTranscodePreset,
			"-crf", strconv.Itoa(constants.ReelTranscodeCRF),
			"-profile:v", "high", "-pix_fmt", "yuv420p",
			"-c:a", "aac", "-b:a", constants.ReelTranscodeAudioBitrate, "-ac", "2",
			"-threads", strconv.Itoa(constants.ReelTranscodeThreads))
	} else {
		args = append(args, "-c", "copy")
	}
	return append(args, "-movflags", "+faststart", "-f", "mp4", dst)
}

func posterArgs(src, dst string) []string {
	edge := strconv.Itoa(constants.ReelPosterMaxEdge)
	scale := fmt.Sprintf("scale=w='if(gte(iw,ih),min(%[1]s,iw),-2)':h='if(gte(iw,ih),-2,min(%[1]s,ih))'", edge)
	return []string{"-hide_banner", "-loglevel", "error", "-nostdin", "-y",
		"-ss", constants.ReelPosterSeekSeconds, "-i", src,
		"-frames:v", "1", "-vf", scale, "-q:v", "4", dst}
}

func probeArgs(src string) []string {
	return []string{"-v", "error", "-print_format", "json", "-show_format", "-show_streams", src}
}

func packetTimesArgs(src string) []string {
	return []string{"-v", "error", "-select_streams", "v:0", "-show_entries", "packet=pts_time", "-of", "csv=p=0", src}
}

func parseSeconds(value string) float64 {
	seconds, err := strconv.ParseFloat(strings.TrimSpace(value), 64)
	if err != nil || math.IsNaN(seconds) || math.IsInf(seconds, 0) || seconds < 0 {
		return 0
	}
	return seconds
}

func streamRotation(stream *ffprobeStream) float64 {
	for _, side := range stream.SideDataList {
		if side.Rotation != 0 {
			return side.Rotation
		}
	}
	rotation, _ := strconv.ParseFloat(strings.TrimSpace(stream.Tags.Rotate), 64)
	return rotation
}

func parseProbe(data []byte) (*probedVideo, error) {
	var out ffprobeOutput
	if err := json.Unmarshal(data, &out); err != nil {
		return nil, errProbeFailed
	}
	info := &probedVideo{Containers: strings.Split(out.Format.FormatName, ",")}
	var video *ffprobeStream
	for i := range out.Streams {
		stream := &out.Streams[i]
		switch {
		case stream.CodecType == "video" && stream.Disposition.AttachedPic == 0 && video == nil:
			video = stream
		case stream.CodecType == "audio" && info.AudioCodec == "":
			info.AudioCodec = stream.CodecName
		}
	}
	if video == nil || video.Width == 0 || video.Height == 0 {
		return nil, errProbeNoVideo
	}
	info.Codec = video.CodecName
	info.PixFmt = video.PixFmt
	info.Width, info.Height = video.Width, video.Height
	if quarterTurns := int(math.Round(streamRotation(video) / constants.ReelProbeRotationQuarterDeg)); quarterTurns%2 != 0 {
		info.Width, info.Height = info.Height, info.Width
	}
	info.HDR = slices.Contains(constants.ReelHDRTransfers, video.ColorTransfer)
	info.Duration = parseSeconds(out.Format.Duration)
	if info.Duration == 0 {
		info.Duration = parseSeconds(video.Duration)
	}
	return info, nil
}

func lastPacketTime(data []byte) float64 {
	last := 0.0
	for _, line := range strings.Split(string(data), "\n") {
		last = max(last, parseSeconds(strings.TrimSuffix(line, ",")))
	}
	return last
}

func (t *Transcoder) Probe(ctx context.Context, src string) (*probedVideo, error) {
	if !t.Available() {
		return nil, errTranscoderDisabled
	}
	out, err := t.run(ctx, t.ffprobe, probeArgs(src))
	if err != nil {
		return nil, fmt.Errorf("%w: %v", errProbeFailed, err)
	}
	info, err := parseProbe(out)
	if err != nil {
		return nil, err
	}
	if info.Duration == 0 {
		packets, err := t.run(ctx, t.ffprobe, packetTimesArgs(src))
		if err != nil {
			return nil, fmt.Errorf("%w: %v", errProbeFailed, err)
		}
		info.Duration = lastPacketTime(packets)
	}
	if info.Duration == 0 {
		return nil, errProbeNoDuration
	}
	return info, nil
}

func (t *Transcoder) Video(ctx context.Context, plan videoPlan, hdr bool, src, dst string) error {
	_, err := t.run(ctx, t.ffmpeg, videoArgs(plan, hdr, src, dst))
	return err
}

func (t *Transcoder) Poster(ctx context.Context, src, dst string) error {
	_, err := t.run(ctx, t.ffmpeg, posterArgs(src, dst))
	return err
}

func (t *Transcoder) run(ctx context.Context, binary string, args []string) ([]byte, error) {
	var stdout, stderr bytes.Buffer
	cmd := exec.CommandContext(ctx, binary, args...)
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr
	cmd.WaitDelay = constants.ReelTranscodeKillWait
	if err := cmd.Run(); err != nil {
		tail := stderr.Bytes()
		if len(tail) > constants.ReelTranscodeLogTailBytes {
			tail = tail[len(tail)-constants.ReelTranscodeLogTailBytes:]
		}
		return nil, fmt.Errorf("%s failed: %w: %s", binary, err, bytes.TrimSpace(tail))
	}
	return stdout.Bytes(), nil
}
