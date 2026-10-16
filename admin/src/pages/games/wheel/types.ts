import type { WheelSegment, WheelSegmentKind } from '@/types'

export interface WheelKindMeta {
  kind: WheelSegmentKind
  label: string
  color: string
  hasOptions: boolean
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

export interface WheelOptionStats {
  total: number
  activePct: number
  balanced: boolean
}

export interface LoadedWheel {
  name: string
  kenCost: number
  freeDailyEnabled: boolean
  isEnabled: boolean
  segments: WheelSegment[]
}
