import { avatarFrameById } from '@ola/shared/lib/avatarFrame'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import { formatCount, formatKen } from '@/lib/format'
import type { RewardItem, RewardItemType } from '@/types'

export const REWARD_ITEM_TYPE_LABEL: Record<RewardItemType, string> = {
  vip_days: 'Ngày VIP',
  vip_icon: 'Icon VIP',
  avatar_frame: 'Khung avatar',
  megaphone_ticket: 'Vé loa',
  ken: 'KEN',
}

export const GIFT_CODE_REWARD_TYPES: RewardItemType[] = ['vip_days', 'vip_icon', 'avatar_frame', 'megaphone_ticket']

const REWARD_LABEL_BY_TYPE: Partial<Record<string, string>> = REWARD_ITEM_TYPE_LABEL

export function rewardItemTypeLabel(type: string): string {
  return REWARD_LABEL_BY_TYPE[type] ?? type
}

export function rewardItemTypeOptions(types: RewardItemType[]): { value: RewardItemType; label: string }[] {
  return types.map((type) => ({ value: type, label: REWARD_ITEM_TYPE_LABEL[type] }))
}

export const REWARD_TICKET_MAX_COUNT = 100
export const REWARD_TICKET_MAX_DAYS = 365
export const REWARD_KEN_MAX_AMOUNT = 10000
export const REWARD_KEN_RANDOM_STEP = 100
export const REWARD_KEN_RANDOM_DEFAULT_MIN = 100
export const REWARD_KEN_RANDOM_DEFAULT_MAX = 1000
export const REWARD_ITEM_MAX_EXPIRY_DAYS = 3650

export function isRewardItemIncomplete(item: RewardItem): boolean {
  if (item.type === 'vip_icon') return (item.vipIconId ?? 0) <= 0
  if (item.type === 'avatar_frame') return !item.frameId
  return false
}

export function rewardItemImage(item: RewardItem): string | undefined {
  if (item.type === 'vip_icon' && item.vipIconId) return vipIconUrl(item.vipIconId)
  if (item.type === 'avatar_frame' && item.frameId) return avatarFrameById(item.frameId)?.url
  return undefined
}

function expiryText(item: RewardItem, permanent: string): string {
  return (item.expiresInDays ?? 0) > 0 ? `${item.expiresInDays} ngày` : permanent
}

export function rewardItemText(item: RewardItem): string {
  switch (item.type) {
    case 'vip_days':
      return `${item.days ?? 0} ngày VIP`
    case 'vip_icon':
      return item.vipIconId
        ? `Icon ${vipName(item.vipIconId)} · ${expiryText(item, 'vĩnh viễn')}`
        : `Icon VIP chưa chọn · ${expiryText(item, 'vĩnh viễn')}`
    case 'avatar_frame': {
      const frame = item.frameId ? avatarFrameById(item.frameId) : undefined
      const label = frame ? `Khung ${frame.name || `#${frame.id}`}` : 'Khung chưa chọn'
      return `${label} · ${expiryText(item, 'vĩnh viễn')}`
    }
    case 'megaphone_ticket':
      return `${item.count ?? 0} vé loa · ${expiryText(item, 'không hạn')}`
    case 'ken':
      return (item.amountMax ?? 0) > 0
        ? `${formatCount(item.amountMin ?? 0)}–${formatKen(item.amountMax ?? 0)} ngẫu nhiên`
        : formatKen(item.amount ?? 0)
    default:
      return ''
  }
}
