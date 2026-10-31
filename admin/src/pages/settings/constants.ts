import type { ChatBotType, PushAudience, PushCampaignStatus } from '@/types'
import type { AppUpdatePlatform, AppUpdateSetting } from './types'

export const CREDENTIAL_KEY = 'push_firebase'

export const TOGGLE_KEY = 'push_notification'

export const MAIL_KEY = 'mail_resend'

export const NOTIFICATION_TAB_KEYS = ['push', 'email'] as const

export const NOTIFICATION_DEFAULT_TAB = 'push'

export const MAIL_DEFAULT_FROM = 'Ola Chat <noreply@olachat.net>'

export const PUSH_TITLE_MAX = 100

export const PUSH_BODY_MAX = 500

export const PUSH_HISTORY_POLL_MS = 3_000

export const PUSH_AUDIENCE_LABEL: Record<PushAudience, string> = {
  all: 'Tất cả người dùng',
  vip: 'Người có VIP còn hạn',
  user: 'Một người dùng',
}

export const PUSH_CAMPAIGN_STATUS_TAG: Record<PushCampaignStatus, { label: string; color: string }> = {
  queued: { label: 'Đang chờ', color: 'default' },
  sending: { label: 'Đang gửi', color: 'processing' },
  done: { label: 'Đã gửi', color: 'green' },
  failed: { label: 'Thất bại', color: 'red' },
}

export const CHAT_BOT_SETTING_KEY = 'chat_bot'

export const CHAT_BOT_DAILY_LIMIT_MAX = 100_000

export const CHAT_BOT_PROMPT_MAX = 20_000

export const CHAT_BOT_REMINDER_MAX = 5_000

export const CHAT_BOT_TYPES: ChatBotType[] = ['OLALA', 'OLAVI']

export const CHAT_BOT_LABEL: Record<ChatBotType, string> = {
  OLALA: 'Olala (trợ lý trò chuyện)',
  OLAVI: 'Olavi (thầy tử vi)',
}

export const APP_UPDATE_SETTING_KEY = 'app_update'

export const APP_UPDATE_PLATFORMS: { key: AppUpdatePlatform; label: string }[] = [
  { key: 'android', label: 'Android' },
  { key: 'ios', label: 'iOS' },
]

export const DEFAULT_APP_UPDATE_SETTING: AppUpdateSetting = { android: [], ios: [] }
