import { REPORT_TARGET_LABEL } from '@/lib/moderation'
import type { ReportAlertChannel, ReportStatus, ReportTargetType } from '@/types'

export const REPORT_STATUS_TAG: Record<ReportStatus, { label: string; color: string }> = {
  pending: { label: 'Chờ xử lý', color: 'orange' },
  resolved: { label: 'Đã xử lý', color: 'green' },
  dismissed: { label: 'Bỏ qua', color: 'default' },
}

export const REPORT_STATUS_OPTIONS = [
  { value: 'all', label: 'Tất cả trạng thái' },
  ...Object.entries(REPORT_STATUS_TAG).map(([value, meta]) => ({ value, label: meta.label })),
]

export const REPORT_TARGET_OPTIONS = [
  { value: 'all', label: 'Tất cả loại' },
  ...Object.entries(REPORT_TARGET_LABEL).map(([value, label]) => ({ value, label })),
]

export const REPORT_CONTENT_ACTION_LABEL: Record<ReportTargetType, string | null> = {
  account: null,
  post: 'Ẩn bài đăng',
  comment: 'Xoá bình luận',
  story_comment: 'Xoá bình luận',
  message: null,
  room_message: 'Xoá tin nhắn',
  moment: 'Ẩn khoảnh khắc',
  megaphone: 'Gỡ loa',
}

export const REPORT_TARGETS_WITHOUT_CONTEXT: readonly ReportTargetType[] = ['post', 'moment', 'megaphone']

export const REPORT_EXCERPT_MAX = 80

export const REPORT_HANDLER_NOTE_MAX = 1000

export const REPORT_ALERT_KEY = 'report_alert'

export const REPORT_ALERT_CHANNEL_LABEL: Record<ReportAlertChannel, string> = {
  discord: 'Discord',
  telegram: 'Telegram',
}

export const DISCORD_WEBHOOK_PLACEHOLDER = 'https://discord.com/api/webhooks/...'

export const TELEGRAM_TOKEN_PLACEHOLDER = '123456789:AAH...'

export const TELEGRAM_CHAT_ID_PLACEHOLDER = '-1001234567890'

export const TELEGRAM_GET_UPDATES_URL = 'https://api.telegram.org/bot<token>/getUpdates'

export const MODERATION_POINTS_MIN = 1

export const MODERATION_POINTS_MAX = 20

export const MODERATION_HOURS_MAX = 24 * 365 * 10

export const MODERATION_LOCK_STEPS_MAX = 5

export const MODERATION_SETTINGS_TITLE = 'Cài đặt điểm vi phạm'

export const REPORT_ALERT_SETTINGS_TITLE = 'Thông báo báo cáo vi phạm'
