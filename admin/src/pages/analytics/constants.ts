import type { AnalyticsPlatform, AnalyticsSource } from '@/types'

export const ANALYTICS_SETTING_KEY = 'analytics'

export const ANALYTICS_REALTIME_POLL_MS = 60_000

export const ANALYTICS_STALE_MS = 5 * 60_000

export const APPROXIMATE_RANKING_HINT =
  'Mỗi nguồn có quá nhiều dòng nên chỉ cộng được phần đầu của từng nguồn. Thứ hạng và số liệu bảng này có thể chưa chính xác.'

export const PUSH_SETTINGS_PATH = '/settings/notification'

export const GA_DATA_API_URL = 'https://console.cloud.google.com/apis/library/analyticsdata.googleapis.com'

export const GA_HOME_URL = 'https://analytics.google.com/analytics/web/'

export const PLATFORM_OPTIONS: { label: string; value: AnalyticsPlatform }[] = [
  { label: 'Tất cả', value: 'all' },
  { label: 'Android', value: 'android' },
  { label: 'iOS', value: 'ios' },
  { label: 'Web', value: 'web' },
]

export const CHART_PLATFORMS = ['android', 'ios', 'web'] as const

export type ChartPlatform = (typeof CHART_PLATFORMS)[number]

export const PLATFORM_META: Record<ChartPlatform, { label: string; color: string }> = {
  android: { label: 'Android', color: '#52c41a' },
  ios: { label: 'iOS', color: '#1677ff' },
  web: { label: 'Web', color: '#fa8c16' },
}

export const REALTIME_EVENT_ROWS = 8

export const REALTIME_EVENTS_TRUNCATED_HINT =
  'Quá nhiều loại sự kiện nên Google chỉ trả phần đầu. Tổng số sự kiện vẫn đúng, nhưng bảng theo loại và biểu đồ sự kiện mỗi phút có thể thiếu.'

export type RealtimeMetric = 'activeUsers' | 'eventCount'

export const REALTIME_METRIC_META: Record<RealtimeMetric, { label: string; color: string }> = {
  activeUsers: { label: 'Người dùng', color: '#1677ff' },
  eventCount: { label: 'Sự kiện', color: '#722ed1' },
}

export const REALTIME_METRIC_OPTIONS: { label: string; value: RealtimeMetric }[] = [
  { label: 'Người dùng mỗi phút', value: 'activeUsers' },
  { label: 'Sự kiện mỗi phút', value: 'eventCount' },
]

export const SOURCE_LABEL: Record<AnalyticsSource, string> = {
  mobile: 'Mobile (Android + iOS)',
  web: 'Web',
  all: 'Mobile + Web',
}

export const EVENT_LABEL: Record<string, string> = {
  screen_view: 'Xem màn hình',
  page_view: 'Xem trang',
  session_start: 'Bắt đầu phiên',
  user_engagement: 'Tương tác',
  first_open: 'Mở app lần đầu',
  first_visit: 'Vào web lần đầu',
  app_update: 'Cập nhật app',
  app_remove: 'Gỡ app',
  os_update: 'Cập nhật hệ điều hành',
  app_clear_data: 'Xoá dữ liệu app',
  app_exception: 'App bị lỗi',
  notification_receive: 'Nhận thông báo',
  notification_open: 'Mở thông báo',
  notification_dismiss: 'Bỏ qua thông báo',
  scroll: 'Cuộn trang',
  click: 'Bấm liên kết ra ngoài',
  arcade_open: 'Mở trò chơi',
  app_review_prompt: 'Hiện lời mời đánh giá',
  app_review_manual: 'Bấm đánh giá app',
}
