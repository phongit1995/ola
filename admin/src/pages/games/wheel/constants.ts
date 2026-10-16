import type { WheelUserStatsSortBy } from '@/types'
import type { WheelKindMeta } from './types'

export const WHEEL_KINDS: WheelKindMeta[] = [
  { kind: 'miss', label: 'Trượt', color: '#94a3b8', hasOptions: false },
  { kind: 'ken_fixed', label: 'KEN cố định', color: '#2563eb', hasOptions: false },
  { kind: 'ken_random', label: 'KEN ngẫu nhiên', color: '#0ea5e9', hasOptions: false },
  { kind: 'vip_days', label: 'Ngày VIP', color: '#5b8c2a', hasOptions: false },
  { kind: 'vip_item', label: 'VIP cố định', color: '#faad14', hasOptions: false },
  { kind: 'vip_random', label: 'VIP ngẫu nhiên', color: '#ec4899', hasOptions: true },
]

export const OUTCOME_OPTIONS = [
  { value: '', label: 'Tất cả' },
  { value: 'win', label: 'Trúng' },
  { value: 'miss', label: 'Trượt' },
]

export const USER_STATS_SORTS: WheelUserStatsSortBy[] = ['kenSpent', 'kenWon', 'netKen', 'spins', 'vipDays']
