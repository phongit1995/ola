import type { StoryCrawlerSetting, StoryCrawlerStatus, StoryCrawlLog } from '@/types'

export interface CrawlerSourceInfo {
  label: string
  cookiePlaceholder: string
  cookieHelp: string
  unit: string
  emptyNote: string
  truncatedWarning?: string
  scope: (status: StoryCrawlerStatus) => string
  enabledHint: (status: StoryCrawlerStatus) => string
  newStoriesHint: (status: StoryCrawlerStatus) => string
  logScope: (log: StoryCrawlLog) => string
}

export interface ConfigSnapshot {
  config: StoryCrawlerSetting
  updatedAt: string | null
}
