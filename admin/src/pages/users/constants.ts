import { VIP_CATALOG } from '@/lib/vipCatalog'

export const KEN_TX_TYPE: Record<string, string> = {
  VIP_PACKAGE: 'Mua gói VIP',
  VIP_ICON: 'Mua VIP icon',
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
  admin: { label: 'Admin cấp', color: 'gold' },
  gift: { label: 'Được tặng', color: 'green' },
}

export const VIP_ICON_SOURCE_LABEL: Record<string, string> = {
  purchase: 'Mua',
  icon: 'Mua',
  transfer: 'Nhận chuyển',
  gift: 'Tặng',
  admin: 'Admin',
}
