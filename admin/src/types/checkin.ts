import type { ListParams, PlatformRules } from './common'
import type { RewardItem } from './rewardItem'

export type CheckinRewardItem = RewardItem

export type CheckinTaskCode =
  | 'me_post'
  | 'me_comment'
  | 'me_react'
  | 'moment_post'
  | 'moment_comment'
  | 'story_comment'
  | 'send_gift'
  | 'send_megaphone'
  | 'play_game'

export type CheckinSlotTask = CheckinTaskCode | 'random'

export type CheckinBox = 'none' | 'normal' | 'big'

export type CheckinMonthSource = 'copy' | 'empty'

export type CheckinGiftOption = CheckinRewardItem & { weight: number }

export interface CheckinGift {
  options: CheckinGiftOption[]
}

export interface CheckinSlot {
  slot: number
  gifts: CheckinGift[]
  featured: boolean
  requireVip: boolean
  task: CheckinSlotTask | null
  updatedAt?: string
}

export interface CheckinMonth {
  month: string
  slotCount: number
  publishedAt: string | null
  createdAt: string
  updatedAt: string
}

export interface CheckinMonthDetail extends CheckinMonth {
  slots: CheckinSlot[]
}

export interface CheckinCreateMonthRequest {
  month: string
  slotCount: number
  source: CheckinMonthSource
  copyFrom?: string
}

export interface CheckinSetting {
  enabled: boolean
  platforms: PlatformRules
  popup: boolean
  requireEmailVerified: boolean
  randomTasks: CheckinTaskCode[]
}

export interface CheckinStatsGift {
  counts: number[]
}

export interface CheckinStatsSlot {
  slot: number
  box: CheckinBox
  checkedIn: number
  opened: number
  lost: number
  gifts: CheckinStatsGift[]
}

export interface CheckinStatsTask {
  task: CheckinTaskCode
  assigned: number
  done: number
  notDone: number
  doneNotOpened: number
}

export interface CheckinStatsDay {
  day: string
  users: number
}

export interface CheckinStats {
  month: string
  checkedInToday: number
  checkedInUsers: number
  completedUsers: number
  boxesOpened: number
  openedByType: Record<CheckinRewardItem['type'], number>
  lostNoVip: number
  boughtVipToOpen: number
  ticketsGranted: number
  ticketsUsed: number
  ticketsExpired: number
  daily: CheckinStatsDay[]
  slots: CheckinStatsSlot[]
  tasks: CheckinStatsTask[]
}

export type CheckinHistoryStatus = 'claimed' | 'pending' | 'missed' | 'none'

export type CheckinMissReason = 'task' | 'vip' | 'not_opened'

export interface CheckinHistoryUser {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface CheckinHistoryItem {
  id: string
  user: CheckinHistoryUser
  day: string
  slot: number
  box: CheckinBox
  requireVip: boolean
  task: CheckinTaskCode | null
  taskDoneAt: string | null
  status: CheckinHistoryStatus
  missReason?: CheckinMissReason
  vipAtCheckin: boolean
  rewards: RewardItem[]
  createdAt: string
  claimedAt: string | null
}

export interface CheckinHistoryParams extends ListParams {
  month: string
  userId?: string
  status?: CheckinHistoryStatus
  slot?: number
}

export interface CheckinUserMonth {
  user: CheckinHistoryUser
  month: string
  slotCount: number
  entries: CheckinHistoryItem[]
}
