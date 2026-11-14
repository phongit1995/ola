import { OPEN_PLATFORM_RULES } from '@/lib/platformRules'
import type {
  ContentCheckReason,
  ContentFilterSetting,
  MegaphoneSenderDisplay,
  MegaphoneSetting,
  MegaphoneStatus,
  MegaphoneType,
} from '@/types'

export const MEGAPHONE_SETTING_KEY = 'megaphone'
export const CONTENT_FILTER_SETTING_KEY = 'content_filter'

export const DEFAULT_MEGAPHONE_SETTING: MegaphoneSetting = {
  enabled: true,
  platforms: OPEN_PLATFORM_RULES,
  kenPrice: 5000,
  maxLength: 80,
  displaySeconds: 12,
  cooldownSeconds: 60,
  dailyLimit: 20,
  liveMinutes: 30,
  gapSeconds: 3,
  repeatBaseSeconds: 720,
  messageWeight: 3,
  giftTiers: [
    { minKen: 0, weight: 1 },
    { minKen: 1000, weight: 3 },
    { minKen: 20000, weight: 6 },
  ],
  senderDisplay: 'vip',
}

export const MEGAPHONE_SENDER_DISPLAY_OPTIONS: { value: MegaphoneSenderDisplay; label: string }[] = [
  { value: 'vip', label: 'Icon VIP' },
  { value: 'avatar', label: 'Avatar (kèm khung)' },
]

export const DEFAULT_CONTENT_FILTER_SETTING: ContentFilterSetting = {
  bannedWords: [],
}

export const MEGAPHONE_KEN_PRICE_MAX = 1_000_000
export const MEGAPHONE_MAX_LENGTH_LIMIT = 200
export const MEGAPHONE_DISPLAY_SECONDS_MIN = 3
export const MEGAPHONE_DISPLAY_SECONDS_MAX = 60
export const MEGAPHONE_COOLDOWN_SECONDS_MAX = 24 * 60 * 60
export const MEGAPHONE_DAILY_LIMIT_MAX = 1000
export const MEGAPHONE_LIVE_MINUTES_MAX = 24 * 60
export const MEGAPHONE_GAP_SECONDS_MAX = 60
export const MEGAPHONE_REPEAT_BASE_MIN = 10
export const MEGAPHONE_REPEAT_BASE_MAX = 24 * 60 * 60
export const MEGAPHONE_WEIGHT_MAX = 20
export const MEGAPHONE_GIFT_TIERS_MAX = 10
export const MEGAPHONE_WAIT_SHARE_OF_LIVE = 3
export const MEGAPHONE_GIFT_WAIT_SHARE = 2
export const MEGAPHONE_SEND_RATE_PER_MINUTE = 6

export const CONTENT_FILTER_WORDS_MAX = 5000
export const CONTENT_FILTER_WORD_LENGTH_MAX = 60
export const CONTENT_CHECK_TEXT_MAX = 1000

export const MEGAPHONE_REMOVE_REASON_MAX = 200

export const MEGAPHONE_STATUS_TAG: Record<MegaphoneStatus, { label: string; color: string }> = {
  active: { label: 'Bình thường', color: 'green' },
  removed: { label: 'Đã gỡ', color: 'red' },
}

export const MEGAPHONE_TYPE_TAG: Record<MegaphoneType, { label: string; color: string }> = {
  message: { label: 'Loa thường', color: 'blue' },
  gift: { label: 'Loa quà', color: 'magenta' },
  lucky: { label: 'Loa trúng thưởng', color: 'gold' },
}

export const MEGAPHONE_TYPE_OPTIONS = [
  { value: 'all', label: 'Tất cả loại' },
  ...Object.entries(MEGAPHONE_TYPE_TAG).map(([value, meta]) => ({ value, label: meta.label })),
]

export const MEGAPHONE_STATUS_OPTIONS = [
  { value: 'all', label: 'Tất cả trạng thái' },
  ...Object.entries(MEGAPHONE_STATUS_TAG).map(([value, meta]) => ({ value, label: meta.label })),
]

export const CONTENT_CHECK_REASON_LABEL: Record<ContentCheckReason, string> = {
  link: 'Có link hoặc tên trang web',
  banned_word: 'Dính từ cấm',
}
