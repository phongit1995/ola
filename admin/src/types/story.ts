import type { ReportReason, ReportTargetType, Story, StoryChapterSummary, StoryComment, StoryKind, StorySort, StoryStatus } from '@ola/shared/types'
import type { ListParams, PlatformRules } from './common'

export type AdminStoryVisibility = 'all' | 'visible' | 'hidden'

export interface AdminStory extends Story {
  source: string
  sourceStoryId: string
  isHidden: boolean
  contentChapters: number
  crawledAt: string | null
  createdAt: string
}

export interface AdminStoryFilter {
  q?: string
  genre?: string
  status?: Exclude<StoryStatus, 'unknown'>
  kind?: StoryKind
  visibility?: AdminStoryVisibility
  source?: string
}

export interface AdminStoryListParams extends ListParams, AdminStoryFilter {
  sort?: StorySort
}

export interface AdminStorySource {
  name: string
  count: number
}

export type AdminStoryBulkVisibilityInput =
  | { isHidden: boolean; ids: string[] }
  | { isHidden: boolean; filter: AdminStoryFilter }

export interface AdminStoryBulkVisibilityResult {
  updated: number
}

export type StorySetting = PlatformRules

export interface StoryReadingSetting {
  enabled: boolean
  freeChaptersPerDay: number
  commentUnlockMinChars: number
}

export interface AdminStorySummary {
  stories: number
  hiddenStories: number
  longStories: number
  shortStories: number
  chapters: number
  contentChapters: number
  lastCrawledAt: string | null
}

export interface AdminStoryChapter extends StoryChapterSummary {
  sourceUrl: string
  hasContent: boolean
  crawledAt: string | null
}

export interface AdminStoryChapterDetail extends AdminStoryChapter {
  content: string
}

export interface AdminStoryFetchResult {
  queued: number
}

export interface AdminStoryComment extends StoryComment {
  deletedAt: string | null
}

export interface AdminStoryCommentDeleteResult {
  commentCount: number
}

export type StoryCookieStatus = 'active' | 'dead'

export interface StoryCookie {
  name: string
  cookie: string
  status: StoryCookieStatus
  deadAt: string | null
}

export type StoryCrawlerSource = 'vnkings' | 'rookies'

export interface StoryCrawlerSetting {
  enabled: boolean
  intervalHours: number
  importNewStories: boolean
  randomUserAgent: boolean
  useCookies: boolean
  cookies: StoryCookie[]
}

export type StoryCrawlTrigger = 'schedule' | 'manual'

export type StoryCrawlStatus = 'running' | 'success' | 'partial' | 'blocked' | 'failed'

export interface StoryCrawlError {
  sourceStoryId: string
  title: string
  message: string
  attempts: number
  willRetry: boolean
}

export interface StoryCrawlLog {
  id: string
  trigger: StoryCrawlTrigger
  status: StoryCrawlStatus
  message?: string
  importNewStories: boolean
  userAgent: string
  useCookies: boolean
  cookie?: string
  cookiesDied?: string[]
  since: string
  startedAt: string
  finishedAt: string | null
  durationMs: number
  truncated: boolean
  postsFound: number
  postsProcessed: number
  retried: number
  retryPending: number
  storiesChecked: number
  storiesUpdated: number
  storiesCreated: number
  storiesUnchanged: number
  storiesSkippedNew: number
  storiesEmpty: number
  storiesFailed: number
  chaptersAdded: number
  chaptersUpdated: number
  chaptersRemoved: number
  requests: number
  errors: StoryCrawlError[]
}

export interface StoryCrawlerStatus {
  config: StoryCrawlerSetting
  configUpdatedAt: string | null
  userAgents: number
  running: boolean
  progress: StoryCrawlLog | null
  lastRunAt: string | null
  nextRunAt: string | null
  // vnkings: số truyện sửa gần nhất trong số ngày gần nhất
  scanDays?: number
  scanLimit?: number
  // rookies: số trang truyện mới ra chương
  scanPages?: number
  retryPending: number
  logs: StoryCrawlLog[]
}

export interface StoryCrawlRunResult {
  started: boolean
}

export type { ReportReason, ReportTargetType }
