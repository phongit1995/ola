import type { PlatformRules } from './common'

export type EggCategoryType = 'nothing' | 'vip_icon' | 'ken' | 'vip_days'

export interface EggReward {
  id: string
  label: string
  weight: number
  vipTypeId?: number
  kenAmount?: number
  vipDays?: number
  isSuperLucky: boolean
  isActive: boolean
  sortOrder: number
}

export interface EggCategory {
  id: string
  type: EggCategoryType
  label: string
  weight: number
  isActive: boolean
  sortOrder: number
  rewards: EggReward[]
}

export interface EggPack {
  id: string
  name: string
  kenCost: number
  isEnabled: boolean
  sortOrder: number
  megaphoneEnabled: boolean
  oddsVisibility: PlatformRules
  categories: EggCategory[]
}

export interface CreateEggPackRequest {
  name: string
  kenCost: number
  isEnabled: boolean
  sortOrder: number
  megaphoneEnabled: boolean
  oddsVisibility: PlatformRules
  categories?: EggCategoryInput[]
}

export interface UpdateEggPackRequest {
  name?: string
  kenCost?: number
  isEnabled?: boolean
  sortOrder?: number
  megaphoneEnabled?: boolean
  oddsVisibility?: PlatformRules
}

export interface EggRewardInput {
  label: string
  weight: number
  vipTypeId?: number
  kenAmount?: number
  vipDays?: number
  isSuperLucky: boolean
  isActive: boolean
  sortOrder: number
}

export interface EggCategoryInput {
  type: EggCategoryType
  label: string
  weight: number
  isActive: boolean
  sortOrder: number
  rewards: EggRewardInput[]
}

export interface SaveEggConfigRequest {
  categories: EggCategoryInput[]
}

export interface EggDraw {
  id: string
  packId: string
  packName: string
  kenCost: number
  categoryType: EggCategoryType
  rewardType?: EggCategoryType
  rewardLabel?: string
  vipTypeId?: number
  kenAmount?: number
  vipDays?: number
  isSuperLucky: boolean
  createdAt: string
}

export interface EggDrawUser {
  id: string
  username: string
  fullName: string
  avatar: string
}

export interface AdminEggDraw extends EggDraw {
  user: EggDrawUser
}

export interface EggDrawListParams {
  userId?: string
  categoryType?: EggCategoryType
  outcome?: 'win' | 'miss'
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface EggStatsOverview {
  totalDraws: number
  uniquePlayers: number
  kenIn: number
  kenOut: number
  vipDaysOut: number
  vipIconsOut: number
  winDraws: number
  winRate: number
  netKen: number
}

export interface EggStatsCategory {
  categoryType: EggCategoryType
  draws: number
  percent: number
}

export interface EggStatsReward {
  categoryType: EggCategoryType
  rewardLabel: string
  count: number
}

export interface EggStatsPack {
  packId: string
  packName: string
  draws: number
  kenIn: number
  kenOut: number
  rtp: number
}

export interface EggStatsTimePoint {
  date: string
  draws: number
  kenIn: number
  kenOut: number
}

export interface EggStatsPlayer {
  user: EggDrawUser
  draws: number
  kenSpent: number
}

export interface EggStatsResponse {
  overview: EggStatsOverview
  byCategory: EggStatsCategory[]
  topRewards: EggStatsReward[]
  byPack: EggStatsPack[]
  timeseries: EggStatsTimePoint[]
  topPlayers: EggStatsPlayer[]
  bucket: 'day' | 'month'
}

export interface EggStatsParams {
  packId?: string
  from?: string
  to?: string
}

export type EggUserStatsSortBy = 'kenSpent' | 'kenWon' | 'netKen' | 'draws' | 'vipDays'

export interface EggUserStatsItem {
  user: EggDrawUser
  draws: number
  winDraws: number
  winRate: number
  kenSpent: number
  kenWon: number
  netKen: number
  vipDays: number
  vipIcons: number
  lastDrawAt: string
}

export interface EggUserStatsParams {
  packId?: string
  userId?: string
  from?: string
  to?: string
  sortBy?: EggUserStatsSortBy
  limit?: number
  offset?: number
}

export interface EggVipStatsRow {
  vipTypeId: number
  iconWins: number
  dayWins: number
  vipDays: number
}

export interface EggVipStatsParams {
  packId?: string
  userId?: string
  from?: string
  to?: string
}
