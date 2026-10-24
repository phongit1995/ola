import type { ReportReason, ReportStatus, ReportTargetType } from '@/types'

export const REPORT_STATUS_TAG: Record<ReportStatus, { label: string; color: string }> = {
  pending: { label: 'Chờ xử lý', color: 'orange' },
  resolved: { label: 'Đã xử lý', color: 'green' },
  dismissed: { label: 'Bỏ qua', color: 'default' },
}

export const REPORT_TARGET_LABEL: Record<ReportTargetType, string> = {
  account: 'Tài khoản',
  post: 'Bài đăng Me',
  comment: 'Bình luận Me',
  story_comment: 'Bình luận truyện',
  message: 'Tin nhắn 1-1',
  room_message: 'Tin nhắn phòng',
  reel: 'Reel',
}

export const REPORT_REASON_LABEL: Record<ReportReason, string> = {
  spam: 'Spam / quảng cáo',
  sensitive: 'Nội dung nhạy cảm',
  scam: 'Lừa đảo',
  harassment: 'Quấy rối / xúc phạm',
  other: 'Khác',
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
  reel: 'Ẩn reel',
}

export const REPORT_TARGETS_WITHOUT_CONTEXT: readonly ReportTargetType[] = ['post', 'reel']

export const REPORT_EXCERPT_MAX = 80

export const REPORT_HANDLER_NOTE_MAX = 1000
