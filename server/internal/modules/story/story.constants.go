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

	ErrorCodeStoryContentUnavailable = "STORY_CONTENT_UNAVAILABLE"
	ErrorCodeStoryContentNotSaved    = "STORY_CONTENT_NOT_SAVED"
	ErrorCodeStoryCrawlRunning       = "STORY_CRAWL_RUNNING"
)
