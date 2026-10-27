import type {
  AdminStoryComment,
  AdminStoryFilter,
  AppSetting,
  StoryCookie,
  StoryCrawlError,
  StoryCrawlerSetting,
  StoryCrawlLog,
  StoryReadingSetting,
  StorySetting,
} from '@/types'
import { normalizePlatformRules, OPEN_PLATFORM_RULES } from '@/lib/platformRules'
import { settingValue } from '@/lib/appSetting'
import { errorMessage } from '@/lib/apiError'
import { formatCount } from '@/lib/format'
import {
  DEFAULT_STORY_READING_SETTING,
  KIND_LABEL,
  SOURCE_LABEL,
  STORY_READING_SETTING_KEY,
  STORY_SETTING_KEY,
  STORY_STATUS_TAG,
  VISIBILITY_LABEL,
} from './constants'
import type { ConfigSnapshot } from './types'

export function storySetting(settings: AppSetting[] | undefined): StorySetting {
  return normalizePlatformRules(settingValue(settings, STORY_SETTING_KEY, OPEN_PLATFORM_RULES))
}

export function storyReadingSetting(settings: AppSetting[] | undefined): StoryReadingSetting {
  return settingValue(settings, STORY_READING_SETTING_KEY, DEFAULT_STORY_READING_SETTING)
}

export function percent(part: number, total: number) {
  return total > 0 ? Math.round((part / total) * 1000) / 10 : 0
}

export function sourceLabel(source: string) {
  return SOURCE_LABEL[source] ?? source
}

export function describeFilter(filter: AdminStoryFilter): string[] {
  const parts: string[] = []
  if (filter.source) parts.push(`nguồn ${sourceLabel(filter.source)}`)
  if (filter.genre) parts.push(`thể loại ${filter.genre}`)
  if (filter.kind) parts.push(KIND_LABEL[filter.kind].toLowerCase())
  if (filter.status) parts.push(STORY_STATUS_TAG[filter.status].label.toLowerCase())
  if (filter.visibility && filter.visibility !== 'all') {
    parts.push(VISIBILITY_LABEL[filter.visibility].toLowerCase())
  }
  if (filter.q) parts.push(`tìm “${filter.q}”`)
  return parts
}

export function contentParagraphs(content: string): string[] {
  return content
    .split(/\n\s*\n/)
    .map((paragraph) => paragraph.trim())
    .filter((paragraph) => paragraph.length > 0)
}

export function errorText(error: unknown): string {
  return errorMessage(error, 'Lỗi không xác định, thử lại sau')
}

export function authorName(comment: AdminStoryComment) {
  return comment.author?.fullName || comment.author?.username || '—'
}

export const cleanCookie = (value: string | undefined) => (value ?? '').trim().replace(/^cookie:\s*/i, '')

export function changeParts(log: StoryCrawlLog): string[] {
  const parts = log.chaptersAdded > 0 ? [`+${formatCount(log.chaptersAdded)} chương`] : []
  if (log.storiesUpdated > 0) parts.push(`${formatCount(log.storiesUpdated)} truyện cập nhật`)
  if (log.storiesCreated > 0) parts.push(`${formatCount(log.storiesCreated)} truyện mới`)
  if (log.storiesFailed > 0) parts.push(`${formatCount(log.storiesFailed)} lỗi`)
  return parts
}

export function runSummary(log: StoryCrawlLog): string {
  const parts = changeParts(log)
  return parts.length > 0 ? parts.join(' · ') : 'Không có gì mới'
}

export function retryNote(error: StoryCrawlError): string {
  return error.willRetry
    ? `sẽ thử lại ở lượt sau (đã thử ${error.attempts} lần)`
    : `đã thử ${error.attempts} lần, bỏ qua đến khi truyện được sửa lại`
}

export function settingKey(value: Partial<StoryCrawlerSetting>): string {
  return JSON.stringify([
    value.enabled === true,
    value.intervalHours,
    value.importNewStories === true,
    value.randomUserAgent === true,
    value.useCookies === true,
    (value.cookies ?? []).map((item) => [
      (item?.name ?? '').trim(),
      cleanCookie(item?.cookie),
      item?.status ?? 'active',
    ]),
  ])
}

export function deadAtByCookie(cookies: StoryCookie[]): Map<string, string> {
  const result = new Map<string, string>()
  for (const item of cookies) {
    if (item.status === 'dead' && item.deadAt) result.set(cleanCookie(item.cookie), item.deadAt)
  }
  return result
}

export function sameSnapshot(a: ConfigSnapshot, b: ConfigSnapshot): boolean {
  return a.updatedAt === b.updatedAt && settingKey(a.config) === settingKey(b.config)
}
