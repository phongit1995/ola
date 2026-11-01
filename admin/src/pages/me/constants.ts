import { REPORT_REASON_LABEL } from '@/lib/moderation'
import type { MeHiddenBy, ReportReason } from '@/types'

export const VISIBILITY: Record<string, { label: string; color: string }> = {
  public: { label: 'Công khai', color: 'green' },
  friend: { label: 'Bạn bè', color: 'blue' },
  private: { label: 'Riêng tư', color: 'default' },
}

export const SORT_OPTIONS = [
  { value: 'newest', label: 'Mới nhất', params: {} as { sortBy?: string; sortDir?: string } },
  { value: 'oldest', label: 'Cũ nhất', params: { sortBy: 'createdAt', sortDir: 'asc' } },
  { value: 'most_liked', label: 'Nhiều thích nhất', params: { sortBy: 'likeCount', sortDir: 'desc' } },
  {
    value: 'most_commented',
    label: 'Nhiều bình luận nhất',
    params: { sortBy: 'commentCount', sortDir: 'desc' },
  },
]

export const ME_HIDE_REASON_OPTIONS = Object.entries(REPORT_REASON_LABEL).map(([value, label]) => ({
  value: value as ReportReason,
  label,
}))

export const ME_HIDE_NOTE_MAX = 1000

export const ME_HIDDEN_BY_LABEL: Record<MeHiddenBy, string> = {
  owner: 'Tác giả xoá',
  admin: 'Admin ẩn',
  clan: 'Quản lý clan xoá',
}
