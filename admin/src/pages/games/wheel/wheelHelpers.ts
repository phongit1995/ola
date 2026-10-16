import type { WheelSegment, WheelSegmentKind, WheelSegmentOption } from '@/types'
import { percent, sumActiveWeight } from '../egg/eggHelpers'

export { newId, percent, sumActiveWeight, formatPercent, rebalanceWeights } from '../egg/eggHelpers'

export interface WheelKindMeta {
  kind: WheelSegmentKind
  label: string
  color: string
  hasOptions: boolean
}

export const WHEEL_KINDS: WheelKindMeta[] = [
  { kind: 'miss', label: 'Trượt', color: '#94a3b8', hasOptions: false },
  { kind: 'ken_fixed', label: 'KEN cố định', color: '#2563eb', hasOptions: false },
  { kind: 'ken_random', label: 'KEN ngẫu nhiên', color: '#0ea5e9', hasOptions: false },
  { kind: 'vip_days', label: 'Ngày VIP', color: '#5b8c2a', hasOptions: false },
  { kind: 'vip_item', label: 'VIP cố định', color: '#faad14', hasOptions: false },
  { kind: 'vip_random', label: 'VIP ngẫu nhiên', color: '#ec4899', hasOptions: true },
]

export function kindMeta(kind: WheelSegmentKind): WheelKindMeta {
  return WHEEL_KINDS.find((k) => k.kind === kind) ?? WHEEL_KINDS[0]
}

export function isBalanced(pct: number): boolean {
  return Math.abs(pct - 100) < 0.05
}

export function segmentPercent(seg: WheelSegment, activeTotal: number): number {
  return seg.isActive ? percent(seg.weight, activeTotal) : seg.weight
}

export interface WheelKindStat {
  meta: WheelKindMeta
  count: number
  pct: number
}

export interface WheelBreakdown {
  stats: WheelKindStat[]
  totalPct: number
  balanced: boolean
}

export function kindBreakdown(segments: WheelSegment[]): WheelBreakdown {
  const activeTotal = sumActiveWeight(segments)
  const active = segments.filter((s) => s.isActive)
  const stats = WHEEL_KINDS.map((meta) => {
    const rows = active.filter((s) => s.kind === meta.kind)
    return {
      meta,
      count: rows.length,
      pct: rows.reduce((acc, s) => acc + percent(s.weight, activeTotal), 0),
    }
  }).filter((row) => row.count > 0)
  const totalPct = stats.reduce((acc, row) => acc + row.pct, 0)
  return { stats, totalPct, balanced: isBalanced(totalPct) }
}

export interface WheelOptionStats {
  total: number
  activePct: number
  balanced: boolean
}

export function optionStats(options: WheelSegmentOption[]): WheelOptionStats {
  const total = sumActiveWeight(options)
  const activePct = options
    .filter((o) => o.isActive)
    .reduce((acc, o) => acc + percent(o.weight, total), 0)
  return { total, activePct, balanced: isBalanced(activePct) }
}
