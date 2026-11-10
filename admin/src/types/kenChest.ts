export interface KenClaimHistoryItem {
  id: string
  kenAmount: number
  isEmpty: boolean
  chestSource: 'manual' | 'auto'
  createdAt: string
  user: { id: string; username: string; fullName?: string; avatar?: string }
}

export type KenChestRewardMode = 'fixed' | 'random'

export interface KenChest {
  id: string
  rewardMode: KenChestRewardMode
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  maxRecipients: number
  claimedRecipients: number
  durationSeconds: number
  status: string
  startedAt: string
  expiresAt: string
  claimsCount: number
  totalKenGiven: number
  source: 'manual' | 'auto'
  autoJobId?: string
  createdAt: string
}

export type KenChestScheduleType = 'interval' | 'daily'

export interface KenChestAutoJob {
  id: string
  name: string
  enabled: boolean
  scheduleType: KenChestScheduleType
  intervalMinMinutes?: number
  intervalMaxMinutes?: number
  dailyTimes?: string[]
  rewardMode: KenChestRewardMode
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  maxRecipients: number
  durationSeconds: number
  remainingRuns?: number
  runCount: number
  nextRunAt?: string
  lastRunAt?: string
  createdAt: string
}

export interface KenChestAutoJobRequest {
  name: string
  enabled: boolean
  scheduleType: KenChestScheduleType
  intervalMinMinutes?: number
  intervalMaxMinutes?: number
  dailyTimes?: string[]
  rewardMode: KenChestRewardMode
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  maxRecipients: number
  durationSeconds: number
  remainingRuns?: number
}

export interface KenChestAutoSettings {
  enabled: boolean
  updatedAt: string
}

export interface CreateKenChestRequest {
  rewardMode: KenChestRewardMode
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  maxRecipients: number
  durationSeconds: number
}

export interface KenChestClaim {
  id: string
  kenAmount: number
  isEmpty: boolean
  createdAt: string
  user: {
    id: string
    username: string
    fullName?: string
    avatar?: string
  }
}

export type KenChestSource = 'manual' | 'auto'

export interface KenChestStatsOverview {
  totalChests: number
  manualChests: number
  autoChests: number
  activeChests: number
  expiredChests: number
  totalClaims: number
  emptyClaims: number
  emptyRate: number
  totalKenGiven: number
  uniqueUsers: number
}

export interface KenChestStatsSourceRow {
  source: KenChestSource
  chests: number
  claims: number
  kenGiven: number
}

export interface KenChestStatsTimePoint {
  date: string
  claims: number
  empty: number
  kenGiven: number
}

export interface KenChestStatsResponse {
  overview: KenChestStatsOverview
  bySource: KenChestStatsSourceRow[]
  timeseries: KenChestStatsTimePoint[]
  bucket: 'day' | 'month'
}

export interface KenChestStatsParams {
  source?: KenChestSource
  userId?: string
  from?: string
  to?: string
}

export type KenChestUserStatsSortBy = 'kenTotal' | 'claims' | 'empty'

export interface KenChestUserStatsItem {
  user: KenChestClaim['user']
  claims: number
  chests: number
  emptyClaims: number
  emptyRate: number
  kenTotal: number
  lastClaimAt: string
}

export interface KenChestUserStatsParams extends KenChestStatsParams {
  sortBy?: KenChestUserStatsSortBy
  limit?: number
  offset?: number
}
