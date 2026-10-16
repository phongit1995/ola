import type { KenChestSource, KenChestUserStatsSortBy } from '@/types'
import type { AutoJobFormValues } from './types'

export const TIME_PATTERN = /^([01]\d|2[0-3]):([0-5]\d)$/

export const DEFAULT_AUTO_JOB_VALUES: AutoJobFormValues = {
  name: '',
  enabled: true,
  scheduleType: 'interval',
  intervalMinMinutes: 60,
  intervalMaxMinutes: 90,
  dailyTimes: [],
  rewardMode: 'fixed',
  maxRecipients: 100,
  durationSeconds: 90,
}

export const SOURCE_META: Record<KenChestSource, { label: string; color: string }> = {
  manual: { label: 'Thủ công', color: 'blue' },
  auto: { label: 'Tự động', color: 'purple' },
}

export const SOURCE_OPTIONS = (Object.keys(SOURCE_META) as KenChestSource[]).map((source) => ({
  value: source,
  label: SOURCE_META[source].label,
}))

export const USER_STATS_SORTS: KenChestUserStatsSortBy[] = ['kenTotal', 'claims', 'empty']
