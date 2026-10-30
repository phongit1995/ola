package moment

import "time"

const (
	MomentTypeImage = "image"
	MomentTypeVideo = "video"
	MomentTypeText  = "text"

	MomentVisibilityPublic = "public"
	MomentVisibilityFriend = "friend"

	MomentOverlayStylePlain = "plain"
	MomentOverlayStyleSolid = "solid"
	MomentOverlayStyleSoft  = "soft"

	MomentAlignLeft   = "left"
	MomentAlignCenter = "center"
	MomentAlignRight  = "right"

	MomentStatusReady      = "ready"
	MomentStatusProcessing = "processing"
	MomentStatusFailed     = "failed"
	MomentStatusPurging    = "purging"
	MomentStatusPurged     = "purged"

	MomentHiddenByOwner = "owner"
	MomentHiddenByAdmin = "admin"

	MomentRemuxVideoCodec         = "h264"
	MomentRemuxAudioCodec         = "aac"
	MomentProbeTimeout            = 30 * time.Second
	MomentProbeTempPattern        = "moment-probe-*"
	MomentVideoSourceExtension    = ".source"
	MomentVideoSourceContentType  = "application/octet-stream"
	MomentSourceCleanupBatchSize  = 100
	MomentTonemapFilter           = "zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p"
	MomentProbeRotationQuarterDeg = 90

	MomentTranscodeMaxEdge       = 1280
	MomentTranscodeMaxBitrate    = 5_000_000
	MomentTranscodeThreads       = 2
	MomentTranscodePreset        = "veryfast"
	MomentTranscodeCRF           = 23
	MomentTranscodeAudioBitrate  = "128k"
	MomentTranscodeTimeout       = 3 * time.Minute
	MomentTranscodePollInterval  = 15 * time.Second
	MomentTranscodeStaleAfter    = 10 * time.Minute
	MomentTranscodeKillWait      = time.Second
	MomentTranscodeMaxAttempts   = 3
	MomentPosterMaxEdge          = 480
	MomentPosterSeekSeconds      = "0.1"
	MomentTranscodeTempPattern   = "moment-video-*"
	MomentTranscodeLogTailBytes  = 2000
	MomentTranscodeSourceName    = "source"
	MomentTranscodeOutputName    = "output.mp4"
	MomentTranscodePosterName    = "poster.jpg"
	MomentPosterContentType      = "image/jpeg"
	MomentPosterExtension        = ".jpg"
	MomentLifetime               = 24 * time.Hour
	MaxMomentSlides              = 3
	MaxMomentOverlays            = 5
	MaxMomentOverlayRunes        = 200
	MaxMomentOverlayIDLen        = 64
	MaxMomentVideoUploadSize     = 70 * 1024 * 1024
	MaxMomentThumbUploadSize     = 300 * 1024
	MaxMomentVideoSeconds        = 30
	MomentVideoDurationTolerance = 0.5
	MaxMomentsPerDay             = 30
	MaxMomentSeenBatch           = 50
	MomentReactionMaxPerType     = 99
	MomentReactionMaxPerRequest  = 20
	MaxMomentCommentRunes        = 500
	MomentCommentsDefaultPage    = 30
	MomentCommentsMaxPage        = 100
	MomentTrayPageSize           = 20
	MomentHistoryDefaultPageSize = 30
	MomentHistoryMaxPageSize     = 60
	MomentViewersDefaultPageSize = 50
	MomentViewersMaxPageSize     = 100
	MomentOverlayWidthMin        = 0.2
	MomentOverlayWidthMax        = 1.0
	MomentOverlayScaleMin        = 0.3
	MomentOverlayScaleMax        = 4.0
	MomentOverlayRotationMax     = 180.0
	MomentDayUTCOffset           = 7 * time.Hour
	MomentQuotaDayLayout         = "20060102"
	MomentSeenTTL                = 25 * time.Hour
	MomentQuotaTTL               = 48 * time.Hour
	MomentCleanupInterval        = 10 * time.Minute
	MomentCleanupStartDelay      = time.Minute
	MomentCleanupLockTTL         = 9 * time.Minute
	MomentViewerSyncGrace        = time.Hour
	MomentViewerSyncLimit        = 5000
	MomentAudienceKeepAfter      = 24 * time.Hour
	MomentAudienceArchiveDelay   = 5 * time.Minute
	MomentAudienceArchiveWindow  = 23 * time.Hour
	MomentAudienceArchiveLimit   = 500
	MomentObjectDeleteTimeout    = 5 * time.Second
	MomentObjectStatTimeout      = 5 * time.Second
	MomentPurgeBatchSize         = 100
	MomentPurgeMaxBatches        = 10
	MomentPurgeLockTTL           = 9 * time.Minute
	MomentPurgeRunTimeout        = 8 * time.Minute
	MomentPurgeSettleTimeout     = 15 * time.Second
	MomentPurgeLogRetentionDays  = 30
	MomentPurgeLogRetention      = MomentPurgeLogRetentionDays * 24 * time.Hour
	MomentPurgeLogsDefaultPage   = 20
	MomentPurgeLogsMaxPage       = 100
	MomentPurgeDayLayout         = "20060102"
	MomentPurgeLogWriteTimeout   = 3 * time.Second
	MomentPurgeTriggerAuto       = "auto"
	MomentPurgeTriggerManual     = "manual"
	MomentPurgeStatusSuccess     = "success"
	MomentPurgeStatusPartial     = "partial"
	MomentPurgeStatusFailed      = "failed"
	MomentPurgeTotalMoments      = "moments"
	MomentPurgeTotalFiles        = "files"
	MomentPurgeTotalBytes        = "bytes"
	UploadFolderMoments          = "moments"
	MomentUploadImagesFolder     = "images"
	MomentUploadVideosFolder     = "videos"
	MomentVideoContentType       = "video/mp4"
	MomentVideoExtension         = ".mp4"
	CacheKeyMomentSeen           = "MOMENT:SEEN:%s"
	CacheKeyMomentViewers        = "MOMENT:VIEWERS:%s"
	CacheKeyMomentQuota          = "MOMENT:QUOTA:%s:%s"
	CacheKeyMomentCleanupLock    = "MOMENT:CLEANUP:LOCK"
	CacheKeyMomentPurgeLock      = "MOMENT:PURGE:LOCK"
	CacheKeyMomentReactions      = "MOMENT:REACTIONS:%s"
	CacheKeyMomentReactors       = "MOMENT:REACTORS:%s"
	MomentReactionViewerField    = "u:%s:%s"
	MomentReactionTotalField     = "t:%s"
	CacheKeyMomentPurgeLogs      = "MOMENT:PURGE:LOGS"
	CacheKeyMomentPurgeLast      = "MOMENT:PURGE:LAST"
	CacheKeyMomentPurgeTotals    = "MOMENT:PURGE:TOTALS:%s"
	ErrorCodeMomentQuotaExceeded = "MOMENT_QUOTA_EXCEEDED"
	ErrorCodeMomentHiddenByAdmin = "MOMENT_HIDDEN_BY_ADMIN"
	ErrorCodeMomentPurgeDisabled = "MOMENT_PURGE_DISABLED"
	ErrorCodeMomentVideoTooLong  = "MOMENT_VIDEO_TOO_LONG"
	ErrorCodeMomentVideoCodec    = "MOMENT_VIDEO_UNSUPPORTED_CODEC"
	ErrorCodeMomentVideoTooLarge = "MOMENT_VIDEO_TOO_LARGE"
	ErrorCodeMomentVideoInvalid  = "MOMENT_VIDEO_INVALID"
	ErrorCodeMomentVideoNotMP4   = "MOMENT_VIDEO_NOT_MP4"
	ErrorCodeMomentVideoVipOnly  = "MOMENT_VIDEO_VIP_REQUIRED"
	ErrorCodeMomentCommentExists = "MOMENT_COMMENT_EXISTS"
)

var AllowedMomentVideoCodecs = []string{"avc1", "avc3"}

var MomentPurgeableStatuses = []string{MomentStatusReady, MomentStatusFailed, MomentStatusPurging}

var MomentTranscodeRetryDelays = []time.Duration{time.Minute, 5 * time.Minute, 15 * time.Minute}

var MomentRemuxContainers = []string{"mov", "mp4"}

var MomentHDRTransfers = []string{"smpte2084", "arib-std-b67"}

var MomentMediaGoneStatuses = []string{MomentStatusPurging, MomentStatusPurged}

var ArchivedAudienceColumns = []string{"archived_viewers", "archived_reactors"}

const (
	AdminMomentStateLive       = "live"
	AdminMomentStateProcessing = "processing"
	AdminMomentStateFailed     = "failed"
	AdminMomentStateExpired    = "expired"
	AdminMomentStateDeleted    = "deleted"
	AdminMomentSortReportCount = "reportCount"
	AdminMomentDefaultPageSize = 20
	AdminMomentMaxPageSize     = 100
)
