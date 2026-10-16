import type { KenChestRewardMode, KenChestScheduleType } from '@/types'

export interface AutoJobFormValues {
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
