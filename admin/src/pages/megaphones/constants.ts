import type { ContentCheckReason, ContentFilterSetting, MegaphoneSetting, MegaphoneStatus } from '@/types'

export const MEGAPHONE_SETTING_KEY = 'megaphone'
export const CONTENT_FILTER_SETTING_KEY = 'content_filter'

export const DEFAULT_MEGAPHONE_SETTING: MegaphoneSetting = {
  enabled: true,
  kenPrice: 2000,
  maxLength: 80,
  displaySeconds: 10,
  cooldownSeconds: 60,
  dailyLimit: 20,
  maxQueueSeconds: 300,
}

export const DEFAULT_CONTENT_FILTER_SETTING: ContentFilterSetting = {
  bannedWords: [],
}

export const MEGAPHONE_KEN_PRICE_MAX = 1_000_000
export const MEGAPHONE_MAX_LENGTH_LIMIT = 200
export const MEGAPHONE_DISPLAY_SECONDS_MIN = 3
export const MEGAPHONE_DISPLAY_SECONDS_MAX = 60
export const MEGAPHONE_COOLDOWN_SECONDS_MAX = 24 * 60 * 60
export const MEGAPHONE_DAILY_LIMIT_MAX = 1000
export const MEGAPHONE_MAX_QUEUE_SECONDS_MAX = 60 * 60
export const MEGAPHONE_SEND_RATE_PER_MINUTE = 6

export const CONTENT_FILTER_WORDS_MAX = 5000
export const CONTENT_FILTER_WORD_LENGTH_MAX = 60
export const CONTENT_CHECK_TEXT_MAX = 1000

export const MEGAPHONE_REMOVE_REASON_MAX = 200

export const MEGAPHONE_STATUS_TAG: Record<MegaphoneStatus, { label: string; color: string }> = {
  active: { label: 'Bình thường', color: 'green' },
  removed: { label: 'Đã gỡ', color: 'red' },
}

export const MEGAPHONE_STATUS_OPTIONS = [
  { value: 'all', label: 'Tất cả trạng thái' },
  ...Object.entries(MEGAPHONE_STATUS_TAG).map(([value, meta]) => ({ value, label: meta.label })),
]

export const CONTENT_CHECK_REASON_LABEL: Record<ContentCheckReason, string> = {
  link: 'Có link hoặc tên trang web',
  banned_word: 'Dính từ cấm',
}
