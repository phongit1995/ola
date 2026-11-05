import { GIFT_ANIMATION_RANDOM } from '@ola/shared/constants'
import type { GiftAnimationSetting } from '@ola/shared/types'
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

export const GIFT_ANIMATION_LABEL: Record<GiftAnimationSetting, string> = {
  [GIFT_ANIMATION_RANDOM]: 'Ngẫu nhiên',
  fly: 'Bay lên + tia sáng',
  drop: 'Rơi xuống + giấy màu',
  spin: 'Xoay + vòng sáng',
  zoom: 'Phóng to + quầng sáng',
  float: 'Lơ lửng + trái tim',
  swing: 'Đung đưa + giấy màu',
  pop: 'Bật ra + pháo hoa',
  flip: 'Lật + vòng cầu vồng',
  heartbeat: 'Đập như tim + trái tim',
  jelly: 'Nảy thạch + bong bóng',
  tornado: 'Xoáy + cánh hoa',
  slide: 'Trượt ngang + pháo hoa',
}

export const GIFT_ANIMATION_OPTIONS = (
  Object.keys(GIFT_ANIMATION_LABEL) as GiftAnimationSetting[]
).map((value) => ({ value, label: GIFT_ANIMATION_LABEL[value] }))

export const GIFT_SOURCE_LABEL: Record<string, string> = {
  chat: 'Chat 1-1',
  profile: 'Trang cá nhân',
}

export const GIFT_SOURCE_COLOR: Record<string, string> = {
  chat: 'blue',
  profile: 'magenta',
}
