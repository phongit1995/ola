import { VIP_CATALOG } from '@/lib/vipCatalog'
import type { UserAvatarFrameSource, ViolationSource } from '@/types'
import type {
  UserFramePurchaseRole,
  UserFramesTab,
  UserFrameTransferDirection,
  ViolationState,
} from './types'

export const KEN_TX_TYPE: Record<string, string> = {
  VIP_PACKAGE: 'Mua gói VIP',
  VIP_ICON: 'Mua VIP icon',
  AVATAR_FRAME: 'Mua khung avatar',
  ADMIN_GRANT: 'Admin cộng',
  ADMIN_DEDUCT: 'Admin trừ',
  REWARD: 'Phần thưởng',
  TOPUP: 'Nạp ken',
  REFUND: 'Hoàn ken',
  GIFT_SENT: 'Tặng quà',
  GIFT_RECEIVED: 'Nhận quà',
  TRANSFER_IN: 'Nhận chuyển',
  TRANSFER_OUT: 'Chuyển đi',
  WORD_CHAIN_HINT: 'Gợi ý nối từ',
  WORD_CHAIN_GUESS: 'Mua lượt nối từ',
}

export const GENDER: Record<string, { label: string; color: string }> = {
  male: { label: 'Nam', color: 'blue' },
  female: { label: 'Nữ', color: 'magenta' },
  other: { label: 'Khác', color: 'default' },
}

export const USERNAME_PATTERN = /^[a-z][a-z0-9]*$/

export const VIP_OPTIONS = VIP_CATALOG.map((v) => ({ value: v.id, label: `${v.name} (#${v.id})` }))

export const MODAL_PAGE_SIZE = 10

export const PLATFORM_LABEL: Record<string, string> = {
  web: 'Web',
  ios: 'iOS',
  android: 'Android',
}

export const SORT_OPTIONS = [
  { value: 'newest', label: 'Mới nhất', params: {} as { sortBy?: string; sortDir?: string } },
  { value: 'oldest', label: 'Cũ nhất', params: { sortBy: 'createdAt', sortDir: 'asc' } },
  { value: 'recent_login', label: 'Đăng nhập gần đây', params: { sortBy: 'lastLoginAt', sortDir: 'desc' } },
  { value: 'followers', label: 'Nhiều follower', params: { sortBy: 'followerCount', sortDir: 'desc' } },
  { value: 'ken_desc', label: 'Ken cao nhất', params: { sortBy: 'ken', sortDir: 'desc' } },
  { value: 'ken_asc', label: 'Ken thấp nhất', params: { sortBy: 'ken', sortDir: 'asc' } },
  { value: 'name', label: 'Tên A–Z', params: { sortBy: 'username', sortDir: 'asc' } },
]

export const VIP_HISTORY_SOURCE_META: Record<string, { label: string; color: string }> = {
  package: { label: 'Mua gói', color: 'blue' },
  icon: { label: 'Mua icon', color: 'purple' },
  admin: { label: 'Admin cấp', color: 'gold' },
  gift: { label: 'Được tặng', color: 'green' },
  email_verify: { label: 'Xác thực email', color: 'cyan' },
  gift_code: { label: 'Mã quà tặng', color: 'magenta' },
}

export const VIP_ICON_SOURCE_LABEL: Record<string, string> = {
  purchase: 'Mua',
  icon: 'Mua',
  transfer: 'Nhận chuyển',
  gift: 'Tặng',
  admin: 'Admin',
  gift_code: 'Mã quà tặng',
}

export const USER_AVATAR_FRAME_SOURCE_LABEL: Record<UserAvatarFrameSource, string> = {
  purchase: 'Mua',
  gift: 'Được tặng',
  transfer: 'Nhận chuyển',
  gift_code: 'Mã quà tặng',
  admin: 'Admin',
}

export const USER_FRAMES_TAB_OPTIONS: { value: UserFramesTab; label: string }[] = [
  { value: 'owned', label: 'Đang có' },
  { value: 'purchases', label: 'Lịch sử mua / tặng' },
  { value: 'transfers', label: 'Lịch sử chuyển' },
]

export const USER_FRAME_HISTORY_PAGE_SIZE = 10

export const USER_FRAME_PURCHASE_ROLE_TAG: Record<UserFramePurchaseRole, { label: string; color: string }> = {
  self: { label: 'Tự mua', color: 'blue' },
  sent: { label: 'Tặng đi', color: 'orange' },
  received: { label: 'Được tặng', color: 'green' },
}

export const USER_FRAME_TRANSFER_DIRECTION_TAG: Record<UserFrameTransferDirection, { label: string; color: string }> = {
  out: { label: 'Chuyển đi', color: 'orange' },
  in: { label: 'Nhận chuyển', color: 'green' },
}

export const LOCK_REASON_VIOLATIONS = 'violations'

export const VIOLATION_LOCK_LABEL = 'Khoá do vi phạm'

export const VIOLATION_SOURCE_LABEL: Record<ViolationSource, string> = {
  report: 'Báo cáo',
  me_hide: 'Admin ẩn bài',
  megaphone_remove: 'Admin gỡ loa',
}

export const VIOLATION_STATE_TAG: Record<ViolationState, { label: string; color: string }> = {
  active: { label: 'Đang tính', color: 'red' },
  expired: { label: 'Hết hạn', color: 'default' },
  revoked: { label: 'Đã gỡ', color: 'default' },
}
