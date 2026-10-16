import type { EggCategoryType, EggUserStatsSortBy } from '@/types'
import type { CategoryTemplate } from './types'

export const CATEGORY_COLORS: Record<EggCategoryType, string> = {
  nothing: '#94a3b8',
  vip_icon: '#faad14',
  ken: '#2563eb',
  vip_days: '#5b8c2a',
}

export const CATEGORY_TEMPLATES: CategoryTemplate[] = [
  { type: 'nothing', label: 'Không trúng', hasItems: false },
  { type: 'vip_icon', label: 'VIP', hasItems: true },
  { type: 'ken', label: 'Ken', hasItems: true },
  { type: 'vip_days', label: 'Ngày VIP', hasItems: true },
]

export const CATEGORY_LABEL: Record<EggCategoryType, string> = {
  nothing: 'Không trúng',
  vip_icon: 'VIP Icon',
  ken: 'Ken',
  vip_days: 'Ngày VIP',
}

export const CATEGORY_OPTIONS = (Object.keys(CATEGORY_LABEL) as EggCategoryType[]).map((type) => ({
  value: type,
  label: CATEGORY_LABEL[type],
}))

export const OUTCOME_OPTIONS = [
  { value: 'win' as const, label: 'Trúng' },
  { value: 'miss' as const, label: 'Trượt' },
]

export const EDITOR_PACK_ID = 'editor'

export const CATEGORY_META: Record<EggCategoryType, { label: string; color: string }> = {
  nothing: { label: 'Không trúng', color: '#94a3b8' },
  vip_icon: { label: 'VIP icon', color: '#faad14' },
  ken: { label: 'Ken', color: '#2563eb' },
  vip_days: { label: 'Ngày VIP', color: '#5b8c2a' },
}

export const USER_STATS_SORTS: EggUserStatsSortBy[] = ['kenSpent', 'kenWon', 'netKen', 'draws', 'vipDays']
