package moment

import (
	"context"
	"errors"
	"os"
	"path"
	"path/filepath"
	"time"

	"ola-chat-server/internal/media"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"go.uber.org/zap"
)

type Processor struct {
	repo       *Repository
	s3         *services.S3Service
	transcoder *Transcoder
	logger     *zap.SugaredLogger
	wake       chan struct{}
	stopped    chan struct{}
}

type transientError struct {
	err error
}

func (e *transientError) Error() string { return e.err.Error() }

func (e *transientError) Unwrap() error { return e.err }

func transient(err error) error {
	if err == nil {
		return nil
	}
	return &transientError{err: err}
}

func isTransient(err error) bool {
	var target *transientError
	return errors.As(err, &target)
}

func retryDelay(failures int) time.Duration {
	delays := MomentTranscodeRetryDelays
	if failures >= len(delays) {
		return delays[len(delays)-1]
	}
	return delays[failures]
}

func NewProcessor(repo *Repository, s3 *services.S3Service, transcoder *Transcoder, logger *zap.SugaredLogger) *Processor {
	return &Processor{
		repo:       repo,
		s3:         s3,
		transcoder: transcoder,
		logger:     logger.Named("[moment_processor]"),
		wake:       make(chan struct{}, 1),
	}
}

func (p *Processor) Enabled() bool {
	return p.transcoder.Available()
}

func (p *Processor) Start(ctx context.Context) {
	if !p.Enabled() {
		return
	}
	p.stopped = make(chan struct{})
	utils.SafeGo(p.logger, func() {
		defer close(p.stopped)
		p.loop(ctx)
	})
}

func (p *Processor) Wait(ctx context.Context) {
	if p.stopped == nil {
		return
	}
	select {
	case <-p.stopped:
	case <-ctx.Done():
	}
}

func (p *Processor) Notify() {
	select {
	case p.wake <- struct{}{}:
	default:
	}
}

func (p *Processor) loop(ctx context.Context) {
	for {
		p.drain(ctx)
		select {
		case <-ctx.Done():
			return
		case <-p.wake:
		case <-time.After(MomentTranscodePollInterval):
		}
	}
}

func (p *Processor) drain(ctx context.Context) {
	if ids, err := p.repo.FailExhausted(time.Now().UTC()); err != nil {
		p.logger.Warnw("Failed to close exhausted moment videos", "error", err)
	} else if len(ids) > 0 {
		p.logger.Warnw("Moment videos failed after their last attempt stalled", "moment_ids", ids)
	}
	for ctx.Err() == nil {
		moment, err := p.repo.ClaimProcessing(time.Now().UTC())
		if err != nil {
			p.logger.Warnw("Failed to claim moment video", "error", err)
			return
		}
		if moment == nil {
			return
		}
		p.handle(ctx, moment)
	}
}

func (p *Processor) handle(ctx context.Context, moment *models.Moment) {
	started := time.Now()
	result, err := p.process(ctx, moment)
	if err == nil {
		err = transient(p.finish(moment, result))
	}
	if err == nil {
		p.logger.Infow("Moment video ready", "moment_id", moment.ID, "plan", result.plan, "took", time.Since(started).String())
		return
	}
	if result != nil {
		p.deleteObjects(result.objects()...)
	}
	if ctx.Err() != nil {
		p.logger.Infow("Moment video processing interrupted by shutdown, requeued", "moment_id", moment.ID)
		if err := p.repo.Requeue(moment.ID); err != nil {
			p.logger.Warnw("Failed to requeue moment video", "moment_id", moment.ID, "error", err)
		}
		return
	}

	temporary := isTransient(err)
	p.logger.Warnw("Moment video processing failed", "moment_id", moment.ID, "attempt", moment.Attempts, "transient", temporary, "error", err)
	if !temporary && moment.Attempts >= MomentTranscodeMaxAttempts {
		if err := p.repo.MarkFailed(moment.ID, time.Now().UTC()); err != nil {
			p.logger.Warnw("Failed to mark moment video failed", "moment_id", moment.ID, "error", err)
		}
		return
	}
	retryAt := time.Now().UTC().Add(retryDelay(moment.Failures))
	if err := p.repo.RetryLater(moment.ID, retryAt, temporary); err != nil {
		p.logger.Warnw("Failed to schedule moment video retry", "moment_id", moment.ID, "error", err)
	}
}

type processedVideo struct {
	plan   videoPlan
	video  *uploadedMedia
	poster *uploadedMedia
}

func (r *processedVideo) objects() []string {
	names := make([]string, 0, 2)
	if r.video != nil {
		names = append(names, r.video.ObjectName)
	}
	if r.poster != nil {
		names = append(names, r.poster.ObjectName)
	}
	return names
}

func (p *Processor) process(parent context.Context, moment *models.Moment) (*processedVideo, error) {
	ctx, cancel := context.WithTimeout(parent, MomentTranscodeTimeout)
	defer cancel()

	dir, err := os.MkdirTemp("", MomentTranscodeTempPattern)
	if err != nil {
		return nil, transient(err)
	}
	defer os.RemoveAll(dir)

	source := filepath.Join(dir, MomentTranscodeSourceName)
	if err := p.s3.DownloadToFile(ctx, sourceObjectOf(moment), source); err != nil {
		return nil, transient(err)
	}
	stat, err := os.Stat(source)
	if err != nil {
		return nil, transient(err)
	}
	sourceInfo, err := p.transcoder.Probe(ctx, source)
	if err != nil {
		return nil, err
	}

	result := &processedVideo{plan: planVideo(sourceInfo, stat.Size())}
	output := filepath.Join(dir, MomentTranscodeOutputName)
	if err := p.transcoder.Video(ctx, result.plan, sourceInfo.HDR, source, output); err != nil {
		return result, err
	}
	outputData, err := os.ReadFile(output)
	if err != nil {
		return result, transient(err)
	}
	outputInfo, err := media.ProbeMP4Video(outputData)
	if err != nil {
		return result, err
	}

	folder := path.Dir(moment.MediaObject)
	upload, err := p.s3.UploadBytes(ctx, outputData, folder, MomentVideoExtension, MomentVideoContentType)
	if err != nil {
		return result, transient(err)
	}
	result.video = &uploadedMedia{
		URL:        upload.URL,
		ObjectName: upload.PublicID,
		Width:      outputInfo.Width,
		Height:     outputInfo.Height,
		Duration:   outputInfo.Duration,
		Size:       int64(len(outputData)),
		MimeType:   MomentVideoContentType,
	}

	if moment.ThumbObject == "" {
		poster, err := p.makePoster(ctx, folder, output, filepath.Join(dir, MomentTranscodePosterName))
		if err != nil {
			p.logger.Warnw("Failed to create moment video poster", "moment_id", moment.ID, "error", err)
		} else {
			result.poster = poster
		}
	}
	return result, nil
}

func (p *Processor) makePoster(ctx context.Context, folder, video, target string) (*uploadedMedia, error) {
	if err := p.transcoder.Poster(ctx, video, target); err != nil {
		return nil, err
	}
	data, err := os.ReadFile(target)
	if err != nil {
		return nil, err
	}
	upload, err := p.s3.UploadBytes(ctx, data, folder, MomentPosterExtension, MomentPosterContentType)
	if err != nil {
		return nil, err
	}
	return &uploadedMedia{URL: upload.URL, ObjectName: upload.PublicID, Size: int64(len(data)), MimeType: MomentPosterContentType}, nil
}

func (p *Processor) finish(moment *models.Moment, result *processedVideo) error {
	fields := map[string]interface{}{
		"media_url":    result.video.URL,
		"media_object": result.video.ObjectName,
		"width":        result.video.Width,
		"height":       result.video.Height,
		"duration":     result.video.Duration,
		"size":         result.video.Size,
		"mime_type":    result.video.MimeType,
	}
	if result.poster != nil {
		fields["thumb_url"] = result.poster.URL
		fields["thumb_object"] = result.poster.ObjectName
	}
	updated, err := p.repo.MarkReady(moment.ID, fields)
	if err != nil {
		return err
	}
	if !updated {
		p.deleteObjects(result.objects()...)
		return nil
	}
	if source := sourceObjectOf(moment); p.deleteObjects(source) {
		if err := p.repo.ClearSource(moment.ID, source); err != nil {
			p.logger.Warnw("Failed to forget deleted moment source", "moment_id", moment.ID, "error", err)
		}
	}
	return nil
}

func sourceObjectOf(moment *models.Moment) string {
	if moment.SourceObject != "" {
		return moment.SourceObject
	}
	return moment.MediaObject
}

func (p *Processor) ProbeUpload(ctx context.Context, data []byte) (*probedVideo, error) {
	ctx, cancel := context.WithTimeout(ctx, MomentProbeTimeout)
	defer cancel()
	dir, err := os.MkdirTemp("", MomentProbeTempPattern)
	if err != nil {
		return nil, err
	}
	defer os.RemoveAll(dir)
	source := filepath.Join(dir, MomentTranscodeSourceName)
	if err := os.WriteFile(source, data, 0o600); err != nil {
		return nil, err
	}
	return p.transcoder.Probe(ctx, source)
}

func (p *Processor) deleteObjects(objectNames ...string) bool {
	deleted := true
	for _, objectName := range objectNames {
		if objectName == "" {
			continue
		}
		ctx, cancel := context.WithTimeout(context.Background(), MomentObjectDeleteTimeout)
		err := p.s3.DeleteFile(ctx, objectName)
		cancel()
		if err != nil {
			deleted = false
			p.logger.Warnw("Failed to delete moment object", "object", objectName, "error", err)
		}
	}
	return deleted
}
