import type { PlatformRules } from './common'

export type WheelSegmentKind =
  | 'miss'
  | 'ken_fixed'
  | 'ken_random'
  | 'vip_days'
  | 'vip_item'
  | 'vip_random'

export interface WheelSegmentOption {
  id: string
  label: string
  weight: number
  vipTypeId?: number
  vipDays?: number
  kenAmount?: number
  isActive: boolean
  sortOrder: number
}

export interface WheelSegment {
  id: string
  kind: WheelSegmentKind
  label: string
  weight: number
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  vipDays?: number
  vipTypeId?: number
  isSuperLucky: boolean
  isActive: boolean
  sortOrder: number
  options: WheelSegmentOption[]
}

export interface Wheel {
  id: string
  name: string
  kenCost: number
  freeDailyEnabled: boolean
  isEnabled: boolean
  sortOrder: number
  megaphoneEnabled: boolean
  oddsVisibility: PlatformRules
  segments: WheelSegment[]
}

export interface WheelSegmentOptionInput {
  label: string
  weight: number
  vipTypeId?: number
  vipDays?: number
  kenAmount?: number
  isActive: boolean
  sortOrder: number
}

export interface WheelSegmentInput {
  kind: WheelSegmentKind
  label: string
  weight: number
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  vipDays?: number
  vipTypeId?: number
  isSuperLucky: boolean
  isActive: boolean
  sortOrder: number
  options: WheelSegmentOptionInput[]
}

export interface CreateWheelRequest {
  name: string
  kenCost: number
  freeDailyEnabled: boolean
  isEnabled: boolean
  sortOrder: number
  megaphoneEnabled: boolean
  oddsVisibility: PlatformRules
  segments?: WheelSegmentInput[]
}

export interface UpdateWheelRequest {
  name?: string
  kenCost?: number
  freeDailyEnabled?: boolean
  isEnabled?: boolean
  sortOrder?: number
  megaphoneEnabled?: boolean
  oddsVisibility?: PlatformRules
}

export interface SaveWheelConfigRequest {
  segments: WheelSegmentInput[]
}

export interface WheelSpin {
  id: string
  wheelId: string
  wheelName: string
  kenCost: number
  isFree: boolean
  segmentKind: WheelSegmentKind
  rewardLabel?: string
  kenAmount?: number
  vipDays?: number
  vipTypeId?: number
  isSuperLucky: boolean
  createdAt: string
}

export interface WheelSpinUser {
  id: string
  username: string
  fullName: string
  avatar: string
}

export interface AdminWheelSpin extends WheelSpin {
  user: WheelSpinUser
}

export interface WheelSpinListParams {
  q?: string
  userId?: string
  segmentKind?: WheelSegmentKind
  outcome?: 'win' | 'miss'
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface WheelStatsOverview {
  totalSpins: number
  uniquePlayers: number
  kenIn: number
  kenOut: number
  vipDaysOut: number
  vipItemsOut: number
  freeSpins: number
  winSpins: number
  winRate: number
  netKen: number
}

export interface WheelStatsKind {
  segmentKind: WheelSegmentKind
  spins: number
  percent: number
}

export interface WheelStatsReward {
  segmentKind: WheelSegmentKind
  rewardLabel: string
  count: number
}

export interface WheelStatsWheel {
  wheelId: string
  wheelName: string
  spins: number
  kenIn: number
  kenOut: number
  rtp: number
}

export interface WheelStatsTimePoint {
  date: string
  spins: number
  kenIn: number
  kenOut: number
}

export interface WheelStatsPlayer {
  user: WheelSpinUser
  spins: number
  kenSpent: number
}

export interface WheelStatsResponse {
  overview: WheelStatsOverview
  byKind: WheelStatsKind[]
  topRewards: WheelStatsReward[]
  byWheel: WheelStatsWheel[]
  timeseries: WheelStatsTimePoint[]
  topPlayers: WheelStatsPlayer[]
  bucket: 'day' | 'month'
}

export interface WheelStatsParams {
  wheelId?: string
  from?: string
  to?: string
}

export type WheelUserStatsSortBy = 'kenSpent' | 'kenWon' | 'netKen' | 'spins' | 'vipDays'

export interface WheelUserStatsItem {
  user: WheelSpinUser
  spins: number
  winSpins: number
  winRate: number
  freeSpins: number
  kenSpent: number
  kenWon: number
  netKen: number
  vipDays: number
  vipItems: number
  lastSpinAt: string
}

export interface WheelUserStatsParams {
  wheelId?: string
  userId?: string
  from?: string
  to?: string
  sortBy?: WheelUserStatsSortBy
  limit?: number
  offset?: number
}

export interface WheelVipStatsRow {
  vipTypeId: number
  itemWins: number
  dayWins: number
  vipDays: number
}

export interface WheelVipStatsParams {
  wheelId?: string
  userId?: string
  from?: string
  to?: string
}
