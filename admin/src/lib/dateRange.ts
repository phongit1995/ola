import dayjs from 'dayjs'
import { DATE_RANGE_PRESET_DAYS, type FixedDateRange } from './constants'

export function isoDaysAgo(days: number): string {
  return dayjs().subtract(days, 'day').format('YYYY-MM-DD')
}

export function presetRange(preset: FixedDateRange): { from: string; to: string } {
  const { days, endDaysAgo } = DATE_RANGE_PRESET_DAYS[preset]
  return { from: isoDaysAgo(endDaysAgo + days - 1), to: isoDaysAgo(endDaysAgo) }
}

export function toIsoRange(from: string, to: string): { from?: string; to?: string } {
  return {
    from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
    to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
  }
}
