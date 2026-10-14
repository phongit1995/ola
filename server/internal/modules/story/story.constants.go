package story

import "time"

const (
	StoryPageSize      = 10
	StoryPageMax       = 50
	StoryAdminPageSize = 20
	StoryAdminPageMax  = 100
	StoryBulkIDsMax    = 500
	StoryQueryMaxRunes = 100
	StorySourceVnkings = "vnkings"
	StorySourceRookies = "rookies"

	StorySortUpdated = "updated"
	StorySortViews   = "views"
	StorySortNew     = "new"

	StoryStatusAll       = "all"
	StoryStatusOngoing   = "ongoing"
	StoryStatusCompleted = "completed"
	StoryStatusUnknown   = "unknown"

	StoryKindShort = "short"
	StoryKindLong  = "long"

	StoryVisibilityAll     = "all"
	StoryVisibilityVisible = "visible"
	StoryVisibilityHidden  = "hidden"

	StoryFetchTimeout     = 15 * time.Second
	StoryFetchMaxBytes    = 4 << 20
	StoryFetchConcurrency = 4
	StoryFetchUserAgent   = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0 Safari/537.36"
	StoryVnkingsHost      = "vnkings.com"
	StoryVnkingsPostURL   = "https://vnkings.com/?rest_route=/wp/v2/posts/%d&_fields=content"
	StoryVnkingsContentID = "content"
	StoryBulkFetchTimeout = 30 * time.Minute
	StoryBulkFetchGap     = 500 * time.Millisecond
	StoryViewGuardTTL     = 6 * time.Hour
	StoryViewTrackTimeout = 3 * time.Second
	StoryViewFlushMin     = 5
	StoryViewFlushMax     = 10

	StoryCommentPageSize       = 20
	StoryCommentPageMax        = 50
	StoryCommentMaxRunes       = 1000
	StoryCommentExcerptRunes   = 120
	StoryUnlockSourceComment   = "comment"
	StoryFreeReadsTTL          = 48 * time.Hour
	StoryReadingUTCOffset      = 7 * 60 * 60
	StoryReadingConfigTTL      = time.Minute
	StoryFreeReadRefundTimeout = 3 * time.Second

	StoryVnkingsHomeURL          = "https://vnkings.com/"
	StoryVnkingsRESTURL          = "https://vnkings.com/?rest_route="
	StoryVnkingsAjaxURL          = "https://vnkings.com/wp-admin/admin-ajax.php"
	StoryVnkingsGuestMarker      = `class="login_plus"`
	StoryVnkingsLogoutMarker     = "logout"
	StoryVnkingsChaptersAction   = "vnk_single_chapters"
	StoryVnkingsCategoryIDs      = "1,3,126,137,21,132,319,131,5,127,258,110,2,112,2639,267,129,111,22008,130,1776,844,1549,1548,4037,17770,17774,17826,209"
	StoryVnkingsShortCategoryID  = 3
	StoryVnkingsRootCategoryID   = 1
	StoryVnkingsPerPage          = 100
	StoryVnkingsUTCOffsetSeconds = 7 * 60 * 60
	StoryShortMinChars           = 1500
	StoryChapterAnchorTolerance  = 5 * time.Minute

	StoryContentSaveTimeout = 30 * time.Second

	StoryRookiesSite             = "https://rookies.vn"
	StoryRookiesHost             = "rookies.vn"
	StoryRookiesCoverBase        = "https://rookies.vn/uploads/"
	StoryRookiesLatestPath       = "/truyen/hot?orderby%5Bpublished_at%5D=desc"
	StoryRookiesListComponent    = "Filter/Hot_Full_Free_Paid"
	StoryRookiesStoryComponent   = "Novels/IP_info"
	StoryRookiesReadingComponent = "Novels/Reading_Full_view"
	StoryRookiesPartialData      = "novels"
	StoryRookiesHomeComponent    = "Home/Home"
	StoryRookiesAuthData         = "auth"
	StoryRookiesScanPages        = 1
	StoryRookiesGroupKind        = 1
	StoryRookiesGroupForm        = 2
	StoryRookiesGroupGenre       = 3
	StoryRookiesTranslatedLabel  = "Truyện dịch"
	StoryRookiesMatureRating     = "18+"
	StoryRookiesTitleMaxRunes    = 500
	StoryRookiesAuthorMaxRunes   = 200
	StoryRookiesPageMaxBytes     = 8 << 20
	StoryRookiesContentMaxBytes  = 32 << 20
	StoryRookiesFetchTimeout     = 45 * time.Second
	StoryRookiesMaxRetryAfter    = time.Minute

	StoryCrawlGap           = time.Second
	StoryCrawlRetries       = 2
	StoryCrawlRetryWait     = 3 * time.Second
	StoryCrawlRunTimeout    = 25 * time.Minute
	StoryCrawlLockTTL       = 30 * time.Minute
	StoryCrawlWindowDays    = 3
	StoryCrawlWindow        = StoryCrawlWindowDays * 24 * time.Hour
	StoryCrawlBatch         = 20
	StoryCrawlLogLimit      = 50
	StoryCrawlErrorLimit    = 20
	StoryCrawlRetryAttempts = 5
	StoryCrawlRetryBatch    = 100
	StoryCrawlRetryMax      = 500
	StoryCrawlMaxSleep      = time.Minute

	StoryCrawlTriggerSchedule = "schedule"
	StoryCrawlTriggerManual   = "manual"

	StoryCrawlStatusRunning = "running"
	StoryCrawlStatusSuccess = "success"
	StoryCrawlStatusPartial = "partial"
	StoryCrawlStatusBlocked = "blocked"
	StoryCrawlStatusFailed  = "failed"

	CacheKeyStoryCrawlLock     = "LOCK:STORY_CRAWL"
	CacheKeyStoryCrawlState    = "STORY_CRAWL:STATE"
	CacheKeyStoryCrawlLogs     = "STORY_CRAWL:LOGS"
	CacheKeyStoryCrawlProgress = "STORY_CRAWL:PROGRESS"
	CacheKeyStoryViewGuard     = "STORY:%s:VIEW:%s"
	CacheKeyStoryViewsPending  = "STORY_VIEWS:PENDING"
	CacheKeyStoryFreeReads     = "STORY_FREE:%s:%s"

	CacheKeyRookiesCrawlLock     = "LOCK:STORY_CRAWL_ROOKIES"
	CacheKeyRookiesCrawlState    = "STORY_CRAWL_ROOKIES:STATE"
	CacheKeyRookiesCrawlLogs     = "STORY_CRAWL_ROOKIES:LOGS"
	CacheKeyRookiesCrawlProgress = "STORY_CRAWL_ROOKIES:PROGRESS"
	CacheKeyRookiesCrawlSeen     = "STORY_CRAWL_ROOKIES:SEEN"

	ErrorCodeStoryContentUnavailable = "STORY_CONTENT_UNAVAILABLE"
	ErrorCodeStoryContentNotSaved    = "STORY_CONTENT_NOT_SAVED"
	ErrorCodeStoryCrawlRunning       = "STORY_CRAWL_RUNNING"
)
