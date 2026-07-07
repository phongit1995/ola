import type { WheelSegmentKind } from '@/types'

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
