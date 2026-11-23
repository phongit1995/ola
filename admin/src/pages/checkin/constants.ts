import type {
  CheckinBox,
  CheckinHistoryStatus,
  CheckinMissReason,
  CheckinMonthSource,
  CheckinSetting,
  CheckinSlotTask,
  CheckinTaskCode,
  RewardItemType,
} from '@/types'
import { OPEN_PLATFORM_RULES } from '@/lib/platformRules'
import type { CheckinMonthStatus } from './types'

export const CHECKIN_QUERY_KEY = 'admin-checkin'

export const CHECKIN_SETTING_KEY = 'checkin'

export const CHECKIN_MONTH_FORMAT = 'YYYY-MM'

export const CHECKIN_VN_UTC_OFFSET_MINUTES = 7 * 60

export const CHECKIN_DEFAULT_SLOT_COUNT = 28

export const CHECKIN_MAX_GIFTS = 5

export const CHECKIN_MAX_OPTIONS = 10
export const CHECKIN_MAX_EXPIRY_DAYS = 365

export const CHECKIN_TOTAL_WEIGHT = 100

export const CHECKIN_MIN_WEIGHT = 1

export const CHECKIN_NEXT_MONTH_WARN_DAY = 20

export const CHECKIN_UPCOMING_MONTHS = 2

export const CHECKIN_GRID_COLUMNS = 7

export const CHECKIN_DRAG_ACTIVATION_DISTANCE = 6

export const CHECKIN_TASK_META: Record<CheckinTaskCode, { label: string; costsKen: boolean }> = {
  me_post: { label: 'Đăng 1 bài Me', costsKen: false },
  me_comment: { label: 'Bình luận 1 bài Me', costsKen: false },
  me_react: { label: 'Thả cảm xúc 1 bài Me', costsKen: false },
  moment_post: { label: 'Đăng 1 khoảnh khắc', costsKen: false },
  moment_comment: { label: 'Bình luận 1 khoảnh khắc', costsKen: false },
  story_comment: { label: 'Bình luận 1 truyện', costsKen: false },
  play_game: { label: 'Chơi xong 1 ván game online', costsKen: false },
  send_gift: { label: 'Tặng 1 món quà', costsKen: true },
  send_megaphone: { label: 'Phát 1 loa', costsKen: true },
}

export const CHECKIN_TASK_CODES = Object.keys(CHECKIN_TASK_META) as CheckinTaskCode[]

export const CHECKIN_DEFAULT_RANDOM_TASKS = CHECKIN_TASK_CODES.filter((code) => !CHECKIN_TASK_META[code].costsKen)

export const CHECKIN_RANDOM_TASK_LABEL = 'Ngẫu nhiên'

export const CHECKIN_SLOT_TASK_OPTIONS: { value: CheckinSlotTask; label: string }[] = [
  { value: 'random', label: CHECKIN_RANDOM_TASK_LABEL },
  ...CHECKIN_TASK_CODES.map((code) => ({
    value: code,
    label: CHECKIN_TASK_META[code].costsKen ? `${CHECKIN_TASK_META[code].label} (tốn KEN)` : CHECKIN_TASK_META[code].label,
  })),
]

export const DEFAULT_CHECKIN_SETTING: CheckinSetting = {
  enabled: false,
  platforms: OPEN_PLATFORM_RULES,
  popup: true,
  requireEmailVerified: true,
  randomTasks: CHECKIN_DEFAULT_RANDOM_TASKS,
}

export const CHECKIN_MONTH_STATUS_META: Record<CheckinMonthStatus, { label: string; color: string }> = {
  past: { label: 'Đã qua', color: 'default' },
  running: { label: 'Đang chạy', color: 'green' },
  upcoming: { label: 'Sắp tới', color: 'blue' },
  draft: { label: 'Nháp', color: 'orange' },
  missing: { label: 'Chưa tạo', color: 'red' },
}

export const CHECKIN_MONTH_SOURCE_OPTIONS: { value: CheckinMonthSource; label: string }[] = [
  { value: 'copy', label: 'Chép từ tháng khác' },
  { value: 'empty', label: 'Để trống, tự nhập' },
]

export const CHECKIN_BOX_LABEL: Record<CheckinBox, string> = {
  none: 'Chỉ điểm danh',
  normal: 'Hộp thường',
  big: 'Hộp đặc biệt',
}

export const CHECKIN_REWARD_TYPES: RewardItemType[] = ['vip_days', 'vip_icon', 'avatar_frame', 'megaphone_ticket', 'ken']

export const CHECKIN_NEW_ITEM = { type: 'megaphone_ticket', count: 1, expiresInDays: 7, kenRandom: false } as const

export const CHECKIN_HISTORY_STATUS_META: Record<CheckinHistoryStatus, { label: string; color: string }> = {
  claimed: { label: 'Đã mở', color: 'green' },
  pending: { label: 'Chờ mở', color: 'blue' },
  missed: { label: 'Mất hộp', color: 'red' },
  none: { label: 'Chỉ điểm danh', color: 'default' },
}

export const CHECKIN_MISS_REASON_LABEL: Record<CheckinMissReason, string> = {
  task: 'không làm nhiệm vụ',
  vip: 'làm nhiệm vụ rồi nhưng chưa có VIP',
  not_opened: 'đủ điều kiện nhưng không bấm mở',
}

export const CHECKIN_HISTORY_STATUS_OPTIONS = (Object.keys(CHECKIN_HISTORY_STATUS_META) as CheckinHistoryStatus[]).map((status) => ({
  value: status,
  label: CHECKIN_HISTORY_STATUS_META[status].label,
}))
