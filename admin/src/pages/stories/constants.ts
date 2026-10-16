import type { StoryKind, StorySort, StoryStatus } from '@ola/shared/types'
import type {
  AdminStoryVisibility,
  StoryCookie,
  StoryCrawlerSource,
  StoryCrawlStatus,
  StoryCrawlTrigger,
  StoryReadingSetting,
} from '@/types'
import { formatCount, formatDateTime } from '@/lib/format'
import type { CrawlerSourceInfo } from './types'

export const STORY_SETTING_KEY = 'story'

export const STORY_READING_SETTING_KEY = 'story_reading'

export const DEFAULT_STORY_READING_SETTING: StoryReadingSetting = {
  enabled: true,
  freeChaptersPerDay: 10,
  commentUnlockMinChars: 20,
}

export const STORY_FREE_CHAPTERS_MAX = 1000

export const STORY_UNLOCK_CHARS_MIN = 1

export const STORY_UNLOCK_CHARS_MAX = 500

export const COVER_WIDTH = 44

export const COVER_HEIGHT = 58

export const ALL = 'all'

export const SOURCE_LABEL: Record<string, string> = {
  vnkings: 'Vnkings',
  rookies: 'Rookies',
}

export const KIND_LABEL: Record<StoryKind, string> = {
  long: 'Truyện dài',
  short: 'Truyện ngắn',
}

export const STORY_STATUS_TAG: Record<StoryStatus, { label: string; color?: string }> = {
  ongoing: { label: 'Đang ra', color: 'orange' },
  completed: { label: 'Hoàn thành', color: 'green' },
  unknown: { label: 'Không rõ' },
}

export const VISIBILITY_LABEL: Record<AdminStoryVisibility, string> = {
  all: 'Cả ẩn và hiện',
  visible: 'Đang hiện',
  hidden: 'Đang ẩn',
}

export const KIND_OPTIONS = [
  { value: ALL, label: 'Mọi loại' },
  { value: 'long', label: KIND_LABEL.long },
  { value: 'short', label: KIND_LABEL.short },
]

export const STATUS_OPTIONS = [
  { value: ALL, label: 'Mọi tình trạng' },
  { value: 'ongoing', label: STORY_STATUS_TAG.ongoing.label },
  { value: 'completed', label: STORY_STATUS_TAG.completed.label },
]

export const VISIBILITY_OPTIONS: { value: AdminStoryVisibility; label: string }[] = [
  { value: 'all', label: VISIBILITY_LABEL.all },
  { value: 'visible', label: VISIBILITY_LABEL.visible },
  { value: 'hidden', label: VISIBILITY_LABEL.hidden },
]

export const SORT_OPTIONS: { value: StorySort; label: string }[] = [
  { value: 'updated', label: 'Mới cập nhật' },
  { value: 'views', label: 'Xem nhiều' },
  { value: 'new', label: 'Mới đăng' },
]

export const CHAPTER_PAGE_SIZE = 20

export const POLL_MS_PER_CHAPTER = 2000

export const POLL_GRACE_MS = 30000

export const COMMENT_PAGE_SIZE = 20

export const INTERVAL_OPTIONS = [1, 2, 3, 6, 12, 24].map((hours) => ({
  value: hours,
  label: `${hours} giờ`,
}))

export const HISTORY_DRAWER_WIDTH = 1100

export const CRAWL_STATUS_TAG: Record<StoryCrawlStatus, { label: string; color: string }> = {
  running: { label: 'Đang chạy', color: 'processing' },
  success: { label: 'Thành công', color: 'success' },
  partial: { label: 'Có lỗi', color: 'warning' },
  blocked: { label: 'Bị chặn', color: 'error' },
  failed: { label: 'Thất bại', color: 'error' },
}

export const TRIGGER_LABEL: Record<StoryCrawlTrigger, string> = {
  schedule: 'Tự động',
  manual: 'Thủ công',
}

export const NEW_COOKIE: StoryCookie = { name: '', cookie: '', status: 'active', deadAt: null }

export const CRAWLER_SOURCES: Record<StoryCrawlerSource, CrawlerSourceInfo> = {
  vnkings: {
    label: 'Vnkings',
    cookiePlaceholder: 'wordpress_logged_in_…=…',
    cookieHelp:
      'Đăng nhập vnkings.com trên trình duyệt, mở F12 → Network, chọn một request tới vnkings.com và copy nguyên giá trị header Cookie.',
    unit: 'bài',
    emptyNote: 'truyện mới chưa có chương',
    scope: (status) => `${status.scanLimit} truyện sửa gần nhất trong ${status.scanDays} ngày`,
    enabledHint: (status) =>
      `Mỗi lượt lấy ${status.scanLimit} truyện sửa gần nhất trong ${status.scanDays} ngày trên vnkings, chỉ tải lại truyện có giờ sửa mới hơn bản đã lưu để thêm chương mới.`,
    newStoriesHint: (status) =>
      `Tắt: chỉ thêm chương cho truyện đã có. Bật: truyện mới nằm trong ${status.scanLimit} truyện sửa gần nhất (${status.scanDays} ngày) được thêm và hiện ngay trong app.`,
    logScope: (log) =>
      `Lấy ${formatCount(log.postsFound)} bài sửa gần nhất sau ${formatDateTime(log.since)}, đã xử lý ${formatCount(log.postsProcessed)}${log.truncated ? ' (khoảng này còn bài sửa cũ hơn, không lấy)' : ''}`,
  },
  rookies: {
    label: 'Rookies',
    cookiePlaceholder: 'rookies_session=…; XSRF-TOKEN=…',
    cookieHelp:
      'Đăng nhập rookies.vn trên trình duyệt, mở F12 → Network, chọn một request tới rookies.vn và copy nguyên giá trị header Cookie (có rookies_session).',
    unit: 'truyện',
    emptyNote: 'truyện chưa có chương đọc miễn phí',
    truncatedWarning:
      'Trang 1 đã đầy truyện ra chương sau lượt trước nên có thể sót truyện, nên giảm chu kỳ.',
    scope: (status) =>
      (status.scanPages ?? 1) > 1
        ? `${status.scanPages} trang đầu danh sách truyện mới ra chương`
        : 'Trang 1 danh sách truyện mới ra chương',
    enabledHint: () =>
      'Mỗi lượt đọc trang 1 danh sách truyện mới ra chương trên rookies, chỉ mở truyện có thay đổi để thêm chương mới. Không lấy chương VIP và truyện dịch.',
    newStoriesHint: () =>
      'Tắt: chỉ thêm chương cho truyện đã có. Bật: truyện mới trên trang 1 được thêm và hiện ngay trong app.',
    logScope: (log) =>
      `Đọc ${formatCount(log.postsFound)} truyện ra chương từ ${formatDateTime(log.since)}, đã xử lý ${formatCount(log.postsProcessed)}`,
  },
}

export const TAB_KEYS = ['display', 'reading', 'crawler', 'crawler-rookies'] as const
