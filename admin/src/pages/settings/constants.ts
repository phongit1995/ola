import type { PushAudience, PushCampaignStatus } from '@/types'

export const CREDENTIAL_KEY = 'push_firebase'

export const TOGGLE_KEY = 'push_notification'

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
