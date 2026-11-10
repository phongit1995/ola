import type {
  GiftCodeAttemptRange,
  GiftCodeAttemptReason,
  GiftCodeCodeStatus,
  GiftCodeKind,
  GiftCodePlatform,
  GiftCodeSetting,
  GiftCodeStatus,
} from '@/types'
import { OPEN_PLATFORM_RULES } from '@/lib/platformRules'

export const GIFT_CODE_QUERY_KEY = 'admin-gift-codes'

export const GIFT_CODE_SETTING_KEY = 'gift_code'

export const DEFAULT_GIFT_CODE_SETTING: GiftCodeSetting = {
  enabled: true,
  platforms: OPEN_PLATFORM_RULES,
  requireEmailVerified: true,
}

export const GIFT_CODE_STATUS_META: Record<GiftCodeStatus, { label: string; badge: 'processing' | 'default' | 'warning' | 'error'; color?: string }> = {
  running: { label: 'Đang chạy', badge: 'processing' },
  scheduled: { label: 'Chưa bắt đầu', badge: 'default' },
  soldout: { label: 'Hết lượt', badge: 'warning' },
  expired: { label: 'Hết hạn', badge: 'default', color: '#9aa3ad' },
  off: { label: 'Đã tắt', badge: 'error' },
}

export const GIFT_CODE_STATUS_OPTIONS = (Object.keys(GIFT_CODE_STATUS_META) as GiftCodeStatus[]).map((value) => ({
  value,
  label: GIFT_CODE_STATUS_META[value].label,
}))

export const GIFT_CODE_KIND_META: Record<GiftCodeKind, { label: string; color: string }> = {
  shared: { label: 'Mã chung', color: 'blue' },
  unique: { label: 'Mã riêng', color: 'cyan' },
}

export const GIFT_CODE_KIND_OPTIONS = (Object.keys(GIFT_CODE_KIND_META) as GiftCodeKind[]).map((value) => ({
  value,
  label: GIFT_CODE_KIND_META[value].label,
}))

export const GIFT_CODE_CODE_STATUS_META: Record<GiftCodeCodeStatus, { label: string; color?: string }> = {
  unused: { label: 'Chưa dùng' },
  used: { label: 'Đã dùng', color: 'green' },
  locked: { label: 'Đã khoá', color: 'red' },
}

export const GIFT_CODE_REASON_META: Record<GiftCodeAttemptReason, { label: string; color?: string }> = {
  wrong: { label: 'Sai mã', color: 'red' },
  disabled: { label: 'Đợt đã tắt', color: 'default' },
  locked: { label: 'Mã đã khoá', color: 'magenta' },
  not_started: { label: 'Chưa bắt đầu', color: 'default' },
  expired: { label: 'Hết hạn', color: 'default' },
  sold_out: { label: 'Hết lượt', color: 'gold' },
  used: { label: 'Mã đã dùng', color: 'orange' },
  redeemed: { label: 'Đã nhận rồi', color: 'orange' },
  device: { label: 'Thiết bị đã nhận', color: 'volcano' },
  young: { label: 'Tài khoản mới', color: 'geekblue' },
  platform: { label: 'Nền tảng không hỗ trợ', color: 'default' },
  unverified: { label: 'Chưa xác thực email', color: 'purple' },
  no_device: { label: 'Không rõ thiết bị', color: 'volcano' },
  owned: { label: 'Đã có khung', color: 'cyan' },
}

export const GIFT_CODE_REASON_OPTIONS = (Object.keys(GIFT_CODE_REASON_META) as GiftCodeAttemptReason[]).map((value) => ({
  value,
  label: GIFT_CODE_REASON_META[value].label,
}))

export const GIFT_CODE_PLATFORM_LABEL: Record<GiftCodePlatform, string> = {
  web: 'Web',
  android: 'Android',
  ios: 'iOS',
}

export const GIFT_CODE_PLATFORM_OPTIONS = (Object.keys(GIFT_CODE_PLATFORM_LABEL) as GiftCodePlatform[]).map((value) => ({
  value,
  label: GIFT_CODE_PLATFORM_LABEL[value],
}))

export const GIFT_CODE_ATTEMPT_RANGE_OPTIONS: { value: GiftCodeAttemptRange; label: string }[] = [
  { value: '1h', label: '1 giờ qua' },
  { value: '24h', label: '24 giờ qua' },
  { value: '7d', label: '7 ngày qua' },
  { value: '30d', label: '30 ngày qua' },
]

export const GIFT_CODE_ALPHABET = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789'
export const GIFT_CODE_SAMPLE_SEED = 'K7QMX2PDH4VN8ZKA'
export const GIFT_CODE_SHARED_MIN = 4
export const GIFT_CODE_SHARED_MAX = 20
export const GIFT_CODE_RANDOM_SHARED_LENGTH = 8
export const GIFT_CODE_PREFIX_MAX = 8
export const GIFT_CODE_LENGTH_MIN = 6
export const GIFT_CODE_LENGTH_MAX = 16
export const GIFT_CODE_DEFAULT_LENGTH = 8
export const GIFT_CODE_MAX_BATCH = 50000
export const GIFT_CODE_MAX_SHARED_USES = 1000000
export const GIFT_CODE_MESSAGE_MAX = 150
export const GIFT_CODE_LOCK_REASON_MAX = 200
export const GIFT_CODE_MAX_REWARDS = 5
export const GIFT_CODE_REWARD_PLACEHOLDER = '{quà}'
export const GIFT_CODE_DEFAULT_MESSAGE = 'Bạn nhận được {quà}.'
export const GIFT_CODE_MULTI_ACCOUNT = 3
export const GIFT_CODE_HEAVY_FAILURES = 20
export const GIFT_CODE_DATE_FORMAT = 'DD/MM/YYYY HH:mm'
export const GIFT_CODE_SUMMARY_DATE_FORMAT = 'HH:mm DD/MM/YYYY'

export const GIFT_CODE_REWARD_TYPE_OPTIONS = [
  { value: 'vip_days', label: 'Ngày VIP' },
  { value: 'vip_icon', label: 'Icon VIP' },
  { value: 'avatar_frame', label: 'Khung avatar' },
]

export const GIFT_CODE_DETAIL_TABS = ['redemptions', 'codes'] as const
