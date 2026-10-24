import type { ReelFontKey } from '@ola/shared/constants/reel'
import type { ReelType, ReelVisibility } from '@ola/shared/types'
import type { AdminReelState } from '@/types'

interface TagMeta {
  label: string
  color: string
}

export const REEL_TYPE_TAG: Record<ReelType, TagMeta> = {
  text: { label: 'Chữ', color: 'purple' },
  image: { label: 'Ảnh', color: 'blue' },
  video: { label: 'Video', color: 'magenta' },
}

export const REEL_STATE_TAG: Record<AdminReelState, TagMeta> = {
  live: { label: 'Còn hạn', color: 'green' },
  processing: { label: 'Đang xử lý video', color: 'processing' },
  failed: { label: 'Lỗi xử lý video', color: 'red' },
  expired: { label: 'Hết hạn', color: 'default' },
  deleted: { label: 'Đã xoá', color: 'volcano' },
}

export const REEL_VISIBILITY_TAG: Record<ReelVisibility, TagMeta> = {
  public: { label: 'Công khai', color: 'green' },
  friend: { label: 'Bạn bè', color: 'blue' },
}

export const REEL_TOGGLE_LOCKED_HINT = 'Chỉ ẩn/hiện được reel còn hạn và đã xử lý xong'

export const REEL_SORT_OPTIONS = [
  { value: 'newest', label: 'Mới nhất', params: {} as { sortBy?: string; sortDir?: string } },
  { value: 'oldest', label: 'Cũ nhất', params: { sortBy: 'createdAt', sortDir: 'asc' } },
  {
    value: 'most_reported',
    label: 'Nhiều báo cáo nhất',
    params: { sortBy: 'reportCount', sortDir: 'desc' },
  },
]

export const REEL_FONT_FACE: Record<ReelFontKey, { family: string; weight: number }> = {
  sans: { family: 'system-ui, -apple-system, sans-serif', weight: 600 },
  serif: { family: "Georgia, 'Times New Roman', serif", weight: 600 },
  bold: { family: 'system-ui, -apple-system, sans-serif', weight: 800 },
}

export const REEL_PLAIN_SHADOW = '0 1px 3px rgba(0, 0, 0, 0.45)'

export const REEL_TABLE_PREVIEW_WIDTH = 54

export const REEL_DETAIL_PREVIEW_WIDTH = 270

export const REEL_VIEWER_PAGE_SIZE = 20

export const HTTP_NOT_FOUND = 404

export const REEL_EXCERPT_SEPARATOR = ' · '
