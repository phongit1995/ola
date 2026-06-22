export type EggCategoryType = 'nothing' | 'vip_icon' | 'ken' | 'vip_days'

export interface EggPack {
  id: string
  name: string
  kenCost: number
  isEnabled: boolean
}

export interface EggCategory {
  id: string
  packId: string
  type: EggCategoryType
  label: string
  weight: number
  isActive: boolean
}

export interface EggReward {
  id: string
  categoryId: string
  label: string
  weight: number
  vipTypeId?: number
  kenAmount?: number
  vipDays?: number
  isSuperLucky: boolean
  isActive: boolean
  sortOrder: number
}

export const CATEGORY_COLORS: Record<EggCategoryType, string> = {
  nothing: '#94a3b8',
  vip_icon: '#faad14',
  ken: '#2563eb',
  vip_days: '#5b8c2a',
}

export interface CategoryTemplate {
  type: EggCategoryType
  label: string
  hasItems: boolean
}

export const CATEGORY_TEMPLATES: CategoryTemplate[] = [
  { type: 'nothing', label: 'Không trúng', hasItems: false },
  { type: 'vip_icon', label: 'VIP', hasItems: true },
  { type: 'ken', label: 'Ken', hasItems: true },
  { type: 'vip_days', label: 'Ngày VIP', hasItems: true },
]

export function newId(prefix: string): string {
  const rnd = Math.random().toString(36).slice(2, 8)
  return `${prefix}-${Date.now().toString(36)}-${rnd}`
}

export function sumActiveWeight<T extends { weight: number; isActive: boolean }>(rows: T[]): number {
  return rows.reduce((acc, row) => (row.isActive ? acc + row.weight : acc), 0)
}

export function percent(part: number, total: number): number {
  return total > 0 ? (part / total) * 100 : 0
}

export function formatPercent(value: number): string {
  if (value === 0) return '0%'
  return `${value.toFixed(value < 1 ? 2 : value % 1 === 0 ? 0 : 1)}%`
}

export function categoryTemplate(type: EggCategoryType): CategoryTemplate {
  return CATEGORY_TEMPLATES.find((t) => t.type === type) ?? CATEGORY_TEMPLATES[0]
}

export function rebalanceWeights<T extends { id: string; weight: number; isActive: boolean }>(
  rows: T[],
  id: string,
  targetPercent: number,
): Map<string, number> {
  const result = new Map<string, number>()
  const active = rows.filter((r) => r.isActive)
  if (!active.some((r) => r.id === id)) return result
  const target = Math.max(0, Math.min(100, targetPercent))
  const others = active.filter((r) => r.id !== id)
  result.set(id, others.length === 0 ? 100 : target)
  if (others.length === 0) return result
  const sumOthers = others.reduce((acc, r) => acc + r.weight, 0)
  if (sumOthers <= 0) {
    const each = (100 - target) / others.length
    others.forEach((r) => result.set(r.id, each))
  } else {
    others.forEach((r) => result.set(r.id, (r.weight / sumOthers) * (100 - target)))
  }
  return result
}
