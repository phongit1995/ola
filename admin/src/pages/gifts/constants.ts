import type { GiftSetting } from '@/types'

export const GIFT_SETTING_KEY = 'gift'

export const DEFAULT_GIFT_SETTING: GiftSetting = {
  enabled: true,
  quantityOptions: [1, 5, 10, 99],
  quantityMax: 99,
  noteMaxLength: 100,
  confirmOverKen: 1000,
}

export const GIFT_QUANTITY_MAX_LIMIT = 999
export const GIFT_NOTE_MAX_LENGTH_LIMIT = 100
export const GIFT_QUANTITY_OPTIONS_MAX = 6
export const GIFT_KEN_PRICE_MAX = 10_000_000

export const GIFT_SOURCE_LABEL: Record<string, string> = {
  chat: 'Chat 1-1',
  profile: 'Trang cá nhân',
}

export const GIFT_SOURCE_COLOR: Record<string, string> = {
  chat: 'blue',
  profile: 'magenta',
}
