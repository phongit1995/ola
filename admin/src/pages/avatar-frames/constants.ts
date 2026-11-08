import type { AvatarFramePurchaseSource } from '@/types'

export const AVATAR_FRAME_MAX_BATCH = 200

export const AVATAR_FRAME_PICKER_PAGE_SIZE = 60

export const AVATAR_FRAME_DEFAULT_PRICE = 5000

export const AVATAR_FRAME_STATS_DEFAULT_DAYS = 30

export const AVATAR_FRAME_SOURCE_META: Record<
  AvatarFramePurchaseSource,
  { label: string; color: string }
> = {
  purchase: { label: 'Tự mua', color: 'blue' },
  gift: { label: 'Tặng', color: 'green' },
}

export const AVATAR_FRAME_SHOP_STATUS_OPTIONS = [
  { value: 'active', label: 'Đang bán' },
  { value: 'inactive', label: 'Đang tắt' },
]
