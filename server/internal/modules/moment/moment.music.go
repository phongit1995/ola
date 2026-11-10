package moment

import (
	"context"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"mime/multipart"
	"net/http"
	"os"
	"path/filepath"
	"slices"
	"strconv"
	"strings"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/media"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/utils"
)

var (
	errMusicNotAllowed  = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "video moments cannot have music", ErrorCodeMomentMusicNotAllowed)
	errMusicDisabled    = utils.NewHTTPErrorWithCode(http.StatusForbidden, "moment music is turned off", ErrorCodeMomentMusicDisabled)
	errMusicUnavailable = utils.NewHTTPErrorWithCode(http.StatusServiceUnavailable, "moment music is unavailable", ErrorCodeMomentMusicUnavailable)
	errMusicTooLarge    = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "music file too large", ErrorCodeMomentMusicTooLarge)
	errMusicInvalid     = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "invalid music file", ErrorCodeMomentMusicInvalid)
	errMusicTooShort    = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "music file too short", ErrorCodeMomentMusicTooShort)
	errMusicTooLong     = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "music file too long", ErrorCodeMomentMusicTooLong)
	errMusicRange       = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "selected music part is out of range", ErrorCodeMomentMusicRange)
	errMusicBlocked     = utils.NewHTTPErrorWithCode(http.StatusForbidden, "this music file is blocked", ErrorCodeMomentMusicBlocked)
	errMusicTitle       = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "invalid music title", ErrorCodeMomentMusicTitle)
	errProbeNoAudio     = errors.New("file has no audio stream")
	errProbeNotMusic    = errors.New("file format is not allowed for music")
)

var (
	momentMusicSlideSeconds = []int{5, 10, 15}
	momentMusicContainers   = []string{"m4a", "mp3", "aac", "wav", "flac", "ogg", "amr", "caf"}
)

type momentMusicSettings interface {
	GetMomentMusic() (setting.MomentMusicConfig, error)
}

type probedMusic struct {
	DurationMs int
}

func musicInput(form *multipart.Form) *CreateMomentMusic {
	file := firstFile(form.File["music"])
	if file == nil {
		return nil
	}
	return &CreateMomentMusic{
		File:         file,
		Title:        firstValue(form.Value["musicTitle"]),
		StartMs:      formInt(firstValue(form.Value["musicStartMs"])),
		SlideSeconds: formInt(firstValue(form.Value["slideSeconds"])),
	}
}

func formInt(value string) int {
	number, err := strconv.Atoi(strings.TrimSpace(value))
	if err != nil {
		return -1
	}
	return number
}

func collapseSpaces(value string) string {
	return strings.Join(strings.Fields(value), " ")
}

func defaultMusicTitle(fileName string) string {
	base := strings.TrimSuffix(fileName, filepath.Ext(fileName))
	title := collapseSpaces(strings.ReplaceAll(base, "_", " "))
	if title == "" {
		title = collapseSpaces(fileName)
	}
	runes := []rune(title)
	if len(runes) > MaxMomentMusicTitleRunes {
		return strings.TrimSpace(string(runes[:MaxMomentMusicTitleRunes]))
	}
	return title
}

func normalizeMusicTitle(value, fileName string) (string, error) {
	title := collapseSpaces(value)
	if title == "" {
		return defaultMusicTitle(fileName), nil
	}
	if utf8.RuneCountInString(title) > MaxMomentMusicTitleRunes {
		return "", errMusicTitle
	}
	return title, nil
}

func validateMusicRequest(momentType string, music *CreateMomentMusic) error {
	if momentType == MomentTypeVideo {
		return errMusicNotAllowed
	}
	if !slices.Contains(momentMusicSlideSeconds, music.SlideSeconds) || music.StartMs < 0 {
		return errMusicRange
	}
	fileName := ""
	if music.File != nil {
		fileName = music.File.Filename
	}
	title, err := normalizeMusicTitle(music.Title, fileName)
	if err != nil {
		return err
	}
	music.Title = title
	return nil
}

func checkMusicRange(durationMs, startMs, totalMs int) error {
	switch {
	case durationMs < MinMomentMusicMs:
		return errMusicTooShort
	case durationMs > MaxMomentMusicMs:
		return errMusicTooLong
	case startMs+totalMs > durationMs+MomentMusicToleranceMs:
		return errMusicRange
	}
	return nil
}

func (s *Service) checkMusic(momentType string, input *CreateMomentInput) error {
	if input.Music == nil {
		return nil
	}
	if err := validateMusicRequest(momentType, input.Music); err != nil {
		return err
	}
	cfg, err := s.music.GetMomentMusic()
	if err != nil {
		s.logger.Warnw("Failed to read moment music setting", "error", err)
		return errMusicUnavailable
	}
	if !cfg.EnabledFor(input.Client.Platform, input.Client.AppVersion) {
		return errMusicDisabled
	}
	if !s.processor.Enabled() {
		return errMusicUnavailable
	}
	return nil
}

func musicFolder(now time.Time) string {
	return fmt.Sprintf("%s/%s/%s", UploadFolderMoments, localDay(now).Format(media.UploadDateLayoutDay), MomentUploadMusicFolder)
}

func musicResponse(moment *models.Moment) *MomentMusicResponse {
	if moment.MusicURL == "" || moment.Status != MomentStatusReady {
		return nil
	}
	return &MomentMusicResponse{URL: moment.MusicURL, Title: moment.MusicTitle, DurationMs: moment.MusicDurationMs}
}

func parseMusicProbe(data []byte) (*probedMusic, error) {
	var out ffprobeOutput
	if err := json.Unmarshal(data, &out); err != nil {
		return nil, errProbeFailed
	}
	containers := strings.Split(out.Format.FormatName, ",")
	if !slices.ContainsFunc(containers, func(name string) bool { return slices.Contains(momentMusicContainers, name) }) {
		return nil, errProbeNotMusic
	}
	audio := slices.IndexFunc(out.Streams, func(stream ffprobeStream) bool { return stream.CodecType == "audio" })
	if audio < 0 {
		return nil, errProbeNoAudio
	}
	seconds := parseSeconds(out.Format.Duration)
	if seconds == 0 {
		seconds = parseSeconds(out.Streams[audio].Duration)
	}
	return &probedMusic{DurationMs: int(seconds * 1000)}, nil
}

func musicPacketTimesArgs(src string) []string {
	return []string{"-v", "error", "-select_streams", "a:0", "-show_entries", "packet=pts_time", "-of", "csv=p=0", src}
}

func msToSeconds(value int) string {
	return strconv.FormatFloat(float64(value)/1000, 'f', 3, 64)
}

func musicClipArgs(src, dst string, startMs, durationMs int) []string {
	return []string{"-hide_banner", "-loglevel", "error", "-nostdin", "-y",
		"-ss", msToSeconds(startMs), "-t", msToSeconds(durationMs), "-i", src,
		"-map", "0:a:0", "-vn", "-sn", "-dn", "-map_metadata", "-1", "-map_chapters", "-1",
		"-c:a", "aac", "-b:a", MomentMusicBitrate, "-ar", MomentMusicSampleRate, "-ac", MomentMusicChannels,
		"-threads", MomentMusicThreads, "-movflags", "+faststart", "-f", "mp4", dst}
}

func (s *Service) acquireMusicSlot(ctx context.Context) (func(), error) {
	select {
	case s.musicSlots <- struct{}{}:
		return func() { <-s.musicSlots }, nil
	case <-ctx.Done():
		return nil, errMusicUnavailable
	}
}

func (s *Service) cutMusicClips(ctx context.Context, data []byte, music *CreateMomentMusic, count int) ([][]byte, error) {
	release, err := s.acquireMusicSlot(ctx)
	if err != nil {
		return nil, err
	}
	defer release()

	dir, err := os.MkdirTemp("", MomentMusicTempPattern)
	if err != nil {
		return nil, err
	}
	defer os.RemoveAll(dir)
	src := filepath.Join(dir, MomentMusicSourceName)
	if err := os.WriteFile(src, data, 0o600); err != nil {
		return nil, err
	}

	transcoder := s.processor.transcoder
	info, err := transcoder.ProbeMusic(ctx, src)
	switch {
	case errors.Is(err, errProbeFailed), errors.Is(err, errProbeNoAudio), errors.Is(err, errProbeNotMusic), errors.Is(err, errProbeNoDuration):
		return nil, errMusicInvalid
	case err != nil:
		return nil, err
	}
	slideMs := music.SlideSeconds * 1000
	if err := checkMusicRange(info.DurationMs, music.StartMs, slideMs*count); err != nil {
		return nil, err
	}

	clips := make([][]byte, 0, count)
	for index := range count {
		dst := filepath.Join(dir, fmt.Sprintf(MomentMusicClipNameFormat, index))
		if err := transcoder.CutMusic(ctx, src, dst, music.StartMs+index*slideMs, slideMs); err != nil {
			s.logger.Warnw("Failed to cut moment music", "error", err)
			return nil, errMusicInvalid
		}
		clip, err := os.ReadFile(dst)
		if err != nil {
			return nil, err
		}
		if len(clip) == 0 {
			return nil, errMusicInvalid
		}
		clips = append(clips, clip)
	}
	return clips, nil
}

func (s *Service) attachMusic(ctx context.Context, folder string, music *CreateMomentMusic, drafts []*models.Moment, uploads *uploadTracker) error {
	data, tooLarge, err := readUpload(music.File, MaxMomentMusicUploadSize)
	if err != nil {
		return errMusicInvalid
	}
	if tooLarge {
		return errMusicTooLarge
	}
	sum := sha256.Sum256(data)
	hash := hex.EncodeToString(sum[:])
	blocked, err := s.repo.MusicBlocked(hash)
	if err != nil {
		return err
	}
	if blocked {
		return errMusicBlocked
	}

	cutCtx, cancel := context.WithTimeout(ctx, MomentMusicTimeout)
	defer cancel()
	clips, err := s.cutMusicClips(cutCtx, data, music, len(drafts))
	if err != nil {
		return err
	}

	slideMs := music.SlideSeconds * 1000
	for index, draft := range drafts {
		upload, err := s.s3.UploadBytes(ctx, clips[index], folder, MomentMusicExtension, MomentMusicContentType)
		if err != nil {
			s.logger.Errorw("Failed to upload moment music", "error", err)
			return errUploadFailed
		}
		uploads.add(upload.PublicID)
		draft.MusicURL = upload.URL
		draft.MusicObject = upload.PublicID
		draft.MusicTitle = music.Title
		draft.MusicStartMs = music.StartMs + index*slideMs
		draft.MusicDurationMs = slideMs
		draft.MusicSourceHash = hash
		draft.Duration = float64(music.SlideSeconds)
	}
	return nil
}

func (c *Cleaner) RemoveMusic(ctx context.Context, found *models.Moment, block bool) error {
	objects, err := c.repo.ClearMusic(ctx, found, block)
	if err != nil {
		return err
	}
	if deleted := c.deleteQueuedMusic(ctx, objects); deleted < len(objects) {
		c.logger.Warnw("Removed moment music queued for retry", "moment_id", found.ID, "count", len(objects)-deleted)
	}
	return nil
}

func (c *Cleaner) deleteQueuedMusic(ctx context.Context, objects []string) int {
	deleted := make([]string, 0, len(objects))
	for _, object := range objects {
		if ctx.Err() != nil {
			break
		}
		if c.deleteObjects(ctx, object) {
			deleted = append(deleted, object)
		}
	}
	if len(deleted) == 0 {
		return 0
	}
	if err := c.repo.ForgetMusicDeletes(context.WithoutCancel(ctx), deleted); err != nil {
		c.logger.Warnw("Failed to forget deleted moment music", "count", len(deleted), "error", err)
	}
	return len(deleted)
}

func (c *Cleaner) retryMusicDeletes(ctx context.Context) int {
	now := time.Now()
	objects, err := c.repo.ClaimMusicDeletes(ctx, now, now.Add(MomentMusicDeleteRetryDelay), MomentMusicDeleteBatchSize)
	if err != nil {
		c.logger.Warnw("Failed to claim moment music deletes", "error", err)
		return 0
	}
	return c.deleteQueuedMusic(ctx, objects)
}
