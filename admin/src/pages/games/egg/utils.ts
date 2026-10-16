import type { EggPack as ApiEggPack, SaveEggConfigRequest } from '@/types'
import type { CategoryTemplate, EggCategory, EggCategoryType, EggReward } from './types'
import { CATEGORY_TEMPLATES, EDITOR_PACK_ID } from './constants'

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
  result.set(id, target)
  const others = active.filter((r) => r.id !== id)
  if (others.length === 0) {
    result.set(id, 100)
    return result
  }
  others.forEach((r) => result.set(r.id, r.weight))
  const ranked = [...others].sort((a, b) => b.weight - a.weight)
  const othersSum = others.reduce((acc, r) => acc + r.weight, 0)
  let diff = othersSum - (100 - target)
  if (diff > 1e-9) {
    for (const r of ranked) {
      if (diff <= 1e-9) break
      const take = Math.min(result.get(r.id) ?? 0, diff)
      result.set(r.id, (result.get(r.id) ?? 0) - take)
      diff -= take
    }
    if (diff > 1e-9) result.set(id, target - diff)
  } else if (diff < -1e-9) {
    result.set(ranked[0].id, (result.get(ranked[0].id) ?? 0) - diff)
  }
  return result
}

export function loadPack(pack: ApiEggPack | null): {
  name: string
  kenCost: number
  isEnabled: boolean
  categories: EggCategory[]
  rewards: EggReward[]
} {
  if (!pack) {
    return { name: 'Gói mới', kenCost: 100, isEnabled: true, categories: [], rewards: [] }
  }
  const categories: EggCategory[] = []
  const rewards: EggReward[] = []
  for (const c of pack.categories ?? []) {
    categories.push({
      id: c.id,
      packId: EDITOR_PACK_ID,
      type: c.type,
      label: c.label,
      weight: c.weight,
      isActive: c.isActive,
    })
    for (const r of c.rewards ?? []) {
      rewards.push({
        id: r.id,
        categoryId: c.id,
        label: r.label,
        weight: r.weight,
        vipTypeId: r.vipTypeId,
        kenAmount: r.kenAmount,
        vipDays: r.vipDays,
        isSuperLucky: r.isSuperLucky,
        isActive: r.isActive,
        sortOrder: r.sortOrder,
      })
    }
  }
  return { name: pack.name, kenCost: pack.kenCost, isEnabled: pack.isEnabled, categories, rewards }
}

export function validateConfig(name: string, categories: EggCategory[], rewards: EggReward[]): string | null {
  if (!name.trim()) return 'Vui lòng nhập tên gói.'
  const active = categories.filter((c) => c.isActive)
  if (active.length === 0) return 'Gói phải có ít nhất 1 nhóm đang bật.'
  if (active.reduce((sum, c) => sum + c.weight, 0) <= 0) return 'Hãy phân bổ % cho các nhóm.'
  for (const c of active) {
    if (c.type === 'nothing') continue
    const items = rewards.filter((r) => r.categoryId === c.id && r.isActive)
    if (items.length === 0) return `Nhóm "${c.label}" đang bật nhưng chưa có phần thưởng.`
    if (items.reduce((s, r) => s + r.weight, 0) <= 0) return `Hãy phân bổ % cho phần thưởng trong nhóm "${c.label}".`
  }
  return null
}

export const round4 = (n: number) => Math.round(n * 10000) / 10000

export function toConfigRequest(categories: EggCategory[], rewards: EggReward[]): SaveEggConfigRequest {
  const activeCatTotal = categories.filter((c) => c.isActive).reduce((s, c) => s + c.weight, 0) || 1
  return {
    categories: categories.map((c, index) => {
      const groupRewards = rewards.filter((r) => r.categoryId === c.id).sort((a, b) => a.sortOrder - b.sortOrder)
      const activeRewardTotal = groupRewards.filter((r) => r.isActive).reduce((s, r) => s + r.weight, 0) || 1
      return {
        type: c.type,
        label: c.label,
        weight: c.isActive ? round4((c.weight / activeCatTotal) * 100) : 0,
        isActive: c.isActive,
        sortOrder: index,
        rewards: groupRewards.map((r, ri) => ({
          label: r.label,
          weight: r.isActive ? round4((r.weight / activeRewardTotal) * 100) : 0,
          vipTypeId: r.vipTypeId,
          kenAmount: r.kenAmount,
          vipDays: r.vipDays,
          isSuperLucky: r.isSuperLucky,
          isActive: r.isActive,
          sortOrder: ri,
        })),
      }
    }),
  }
}
