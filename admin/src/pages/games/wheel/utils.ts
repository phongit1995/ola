import type {
  AdminWheelSpin,
  SaveWheelConfigRequest,
  Wheel,
  WheelSegment,
  WheelSegmentKind,
  WheelSegmentOption,
} from '@/types'
import type { LoadedWheel, WheelBreakdown, WheelKindMeta, WheelOptionStats } from './types'
import { WHEEL_KINDS } from './constants'
import { newId, percent, round4, sumActiveWeight } from '../egg/utils'

export { newId, percent, sumActiveWeight, formatPercent, rebalanceWeights } from '../egg/utils'

export function kindMeta(kind: WheelSegmentKind): WheelKindMeta {
  return WHEEL_KINDS.find((k) => k.kind === kind) ?? WHEEL_KINDS[0]
}

export function isBalanced(pct: number): boolean {
  return Math.abs(pct - 100) < 0.05
}

export function segmentPercent(seg: WheelSegment, activeTotal: number): number {
  return seg.isActive ? percent(seg.weight, activeTotal) : seg.weight
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

export function optionStats(options: WheelSegmentOption[]): WheelOptionStats {
  const total = sumActiveWeight(options)
  const activePct = options
    .filter((o) => o.isActive)
    .reduce((acc, o) => acc + percent(o.weight, total), 0)
  return { total, activePct, balanced: isBalanced(activePct) }
}

export function loadWheel(wheel: Wheel | null): LoadedWheel {
  if (!wheel) {
    return { name: 'Vòng quay mới', kenCost: 5000, freeDailyEnabled: true, isEnabled: true, segments: [] }
  }
  const segments: WheelSegment[] = (wheel.segments ?? []).map((s) => ({
    id: s.id,
    kind: s.kind,
    label: s.label,
    weight: s.weight,
    kenAmount: s.kenAmount,
    kenMin: s.kenMin,
    kenMax: s.kenMax,
    vipDays: s.vipDays,
    vipTypeId: s.vipTypeId,
    isSuperLucky: s.isSuperLucky,
    isActive: s.isActive,
    sortOrder: s.sortOrder,
    options: (s.options ?? []).map((o) => ({
      id: o.id || newId('opt'),
      label: o.label,
      weight: o.weight,
      vipTypeId: o.vipTypeId,
      vipDays: o.vipDays,
      kenAmount: o.kenAmount,
      isActive: o.isActive,
      sortOrder: o.sortOrder,
    })),
  }))
  return {
    name: wheel.name,
    kenCost: wheel.kenCost,
    freeDailyEnabled: wheel.freeDailyEnabled,
    isEnabled: wheel.isEnabled,
    segments,
  }
}

export function validate(name: string, segments: WheelSegment[]): string | null {
  if (!name.trim()) return 'Vui lòng nhập tên vòng quay.'
  const active = segments.filter((s) => s.isActive)
  if (active.length === 0) return 'Vòng quay phải có ít nhất 1 ô đang bật.'
  if (active.reduce((sum, s) => sum + s.weight, 0) <= 0) return 'Hãy phân bổ % cho các ô.'
  for (const s of active) {
    if (s.kind === 'ken_fixed' && (s.kenAmount == null || s.kenAmount < 1))
      return `Ô "${s.label}" cần số KEN >= 1.`
    if (s.kind === 'ken_random' && (s.kenMin == null || s.kenMax == null || s.kenMax < s.kenMin))
      return `Ô "${s.label}" cần KEN min/max hợp lệ.`
    if (s.kind === 'vip_days' && (s.vipDays == null || s.vipDays < 1))
      return `Ô "${s.label}" cần số ngày VIP >= 1.`
    if (s.kind === 'vip_item' && s.vipTypeId == null) return `Ô "${s.label}" cần chọn VIP.`
    if (s.kind === 'vip_random') {
      const opts = s.options.filter((o) => o.isActive)
      if (opts.length === 0) return `Ô "${s.label}" cần ít nhất 1 lựa chọn.`
      if (opts.some((o) => o.vipTypeId == null && o.vipDays == null && (o.kenAmount ?? 0) < 1))
        return `Ô "${s.label}" có lựa chọn chưa cấu hình phần thưởng.`
      if (opts.reduce((sum, o) => sum + o.weight, 0) <= 0)
        return `Hãy phân bổ % cho lựa chọn trong ô "${s.label}".`
    }
  }
  return null
}

export function toConfigRequest(segments: WheelSegment[]): SaveWheelConfigRequest {
  const activeTotal = segments.filter((s) => s.isActive).reduce((s, seg) => s + seg.weight, 0) || 1
  return {
    segments: segments.map((seg, index) => {
      const optionTotal = seg.options.filter((o) => o.isActive).reduce((s, o) => s + o.weight, 0) || 1
      return {
        kind: seg.kind,
        label: seg.label,
        weight: seg.isActive ? round4((seg.weight / activeTotal) * 100) : 0,
        kenAmount: seg.kenAmount,
        kenMin: seg.kenMin,
        kenMax: seg.kenMax,
        vipDays: seg.vipDays,
        vipTypeId: seg.vipTypeId,
        isSuperLucky: seg.isSuperLucky,
        isActive: seg.isActive,
        sortOrder: index,
        options:
          seg.kind === 'vip_random'
            ? seg.options.map((o, oi) => ({
                label: o.label,
                weight: o.isActive ? round4((o.weight / optionTotal) * 100) : 0,
                vipTypeId: o.vipTypeId,
                vipDays: o.vipDays,
                kenAmount: o.kenAmount,
                isActive: o.isActive,
                sortOrder: oi,
              }))
            : [],
      }
    }),
  }
}

export function rewardText(spin: AdminWheelSpin): string {
  if (spin.segmentKind === 'miss') return 'Trượt'
  if (spin.kenAmount) return `+${spin.kenAmount.toLocaleString('vi-VN')} Ken`
  if (spin.vipDays) return `${spin.vipDays} ngày VIP`
  return spin.rewardLabel ?? 'Trúng'
}
