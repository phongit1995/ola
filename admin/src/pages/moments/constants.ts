import type { MomentFontKey } from '@ola/shared/constants/moment'
import type { MomentHiddenBy, MomentType, MomentVisibility } from '@ola/shared/types'
import type {
  AdminMomentState,
  MomentMediaPurgeSetting,
  MomentMediaPurgeStatus,
  MomentMediaPurgeTrigger,
  MomentVideoSetting,
} from '@/types'

interface TagMeta {
  label: string
  color: string
}

export const MOMENT_TYPE_TAG: Record<MomentType, TagMeta> = {
  text: { label: 'Chữ', color: 'purple' },
  image: { label: 'Ảnh', color: 'blue' },
  video: { label: 'Video', color: 'magenta' },
}

export const MOMENT_STATE_TAG: Record<AdminMomentState, TagMeta> = {
  live: { label: 'Còn hạn', color: 'green' },
  processing: { label: 'Đang xử lý video', color: 'processing' },
  failed: { label: 'Lỗi xử lý video', color: 'red' },
  expired: { label: 'Hết hạn', color: 'default' },
  deleted: { label: 'Đã xoá', color: 'volcano' },
}

export const MOMENT_VISIBILITY_TAG: Record<MomentVisibility, TagMeta> = {
  public: { label: 'Công khai', color: 'green' },
  friend: { label: 'Bạn bè', color: 'blue' },
}

export const MOMENT_TOGGLE_LOCKED_HINT = 'Chỉ ẩn/hiện được khoảnh khắc đã xử lý xong và chưa bị xoá'

export const MOMENT_SWITCHLESS_STATES: readonly AdminMomentState[] = ['deleted', 'failed']

export const MOMENT_SWITCHLESS_HINT = 'Khoảnh khắc đã xoá hoặc lỗi xử lý nên không hiển thị cho ai'

export const MOMENT_NO_COVER_LABEL = 'Không có ảnh bìa'

export const MOMENT_HIDDEN_BY_LABEL: Record<MomentHiddenBy, string> = {
  owner: 'Tác giả ẩn',
  admin: 'Admin ẩn',
}

export const MOMENT_SORT_OPTIONS = [
  { value: 'newest', label: 'Mới nhất', params: {} as { sortBy?: string; sortDir?: string } },
  { value: 'oldest', label: 'Cũ nhất', params: { sortBy: 'createdAt', sortDir: 'asc' } },
  {
    value: 'most_reported',
    label: 'Nhiều báo cáo nhất',
    params: { sortBy: 'reportCount', sortDir: 'desc' },
  },
]

export const MOMENT_FONT_FACE: Record<
  MomentFontKey,
  { family: string; weight: number; boldWeight: number }
> = {
  sans: { family: 'system-ui, -apple-system, sans-serif', weight: 600, boldWeight: 800 },
  serif: { family: "Georgia, 'Times New Roman', serif", weight: 600, boldWeight: 800 },
  mono: { family: "'Courier New', ui-monospace, monospace", weight: 400, boldWeight: 700 },
  hand: { family: "'Dancing Script', 'Segoe Script', cursive", weight: 400, boldWeight: 700 },
  round: { family: "'Baloo 2', system-ui, sans-serif", weight: 400, boldWeight: 800 },
  art: { family: "Lobster, 'Brush Script MT', cursive", weight: 400, boldWeight: 400 },
}

export const MOMENT_PLAIN_SHADOW = '0 1px 3px rgba(0, 0, 0, 0.45)'

export const MOMENT_TABLE_PREVIEW_WIDTH = 54

export const MOMENT_DETAIL_PREVIEW_WIDTH = 270

export const MOMENT_PAGE_THUMB_WIDTH = 64

export const MOMENT_VIEWER_PAGE_SIZE = 20
export const MOMENT_COMMENT_PAGE_SIZE = 20

export const HTTP_NOT_FOUND = 404

export const MOMENT_EXCERPT_SEPARATOR = ' · '

export const MOMENT_DISPLAY_SETTING_KEY = 'moment'

export const MOMENT_VIDEO_SETTING_KEY = 'moment_video'

export const DEFAULT_MOMENT_VIDEO_SETTING: MomentVideoSetting = { vipRequired: false }

export const MOMENT_MEDIA_PURGE_SETTING_KEY = 'moment_media_purge'

export const MOMENT_PURGE_AFTER_HOURS_MIN = 24

export const MOMENT_PURGE_AFTER_HOURS_MAX = 24 * 365

export const DEFAULT_MOMENT_MEDIA_PURGE_SETTING: MomentMediaPurgeSetting = {
  enabled: false,
  afterHours: 72,
}

export const MOMENT_PURGE_TRIGGER_TAG: Record<MomentMediaPurgeTrigger, TagMeta> = {
  auto: { label: 'Tự động', color: 'default' },
  manual: { label: 'Chạy tay', color: 'blue' },
}

export const MOMENT_PURGE_STATUS_TAG: Record<MomentMediaPurgeStatus, TagMeta> = {
  success: { label: 'Thành công', color: 'green' },
  partial: { label: 'Một phần', color: 'orange' },
  failed: { label: 'Lỗi', color: 'red' },
}

export const MOMENT_PURGE_LOGS_REFRESH_MS = 30_000

export const MOMENT_PURGE_RUNNING_REFRESH_MS = 3_000

export const MOMENT_PURGE_LOGS_PAGE_SIZE = 20

export const MOMENT_PURGE_LOG_RETENTION_DAYS = 30

export const MOMENT_SETTINGS_DRAWER_WIDTH = 1240
