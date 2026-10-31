export const PAGE_SIZE = 20

export type DateRangePreset = '1d' | '3d' | '1w' | '2w' | '3w' | '1m' | 'custom'

export type FixedDateRange = Exclude<DateRangePreset, 'custom'>

export const DATE_RANGE_PRESET_DAYS: Record<FixedDateRange, { days: number; endDaysAgo: number }> = {
  '1d': { days: 1, endDaysAgo: 1 },
  '3d': { days: 3, endDaysAgo: 0 },
  '1w': { days: 7, endDaysAgo: 0 },
  '2w': { days: 14, endDaysAgo: 0 },
  '3w': { days: 21, endDaysAgo: 0 },
  '1m': { days: 30, endDaysAgo: 0 },
}

export const DEFAULT_DATE_RANGE_PRESET: FixedDateRange = '1d'

export const DATE_RANGE_PRESET_OPTIONS: { label: string; value: DateRangePreset }[] = [
  { label: '1 ngày', value: '1d' },
  { label: '3 ngày', value: '3d' },
  { label: '1 tuần', value: '1w' },
  { label: '2 tuần', value: '2w' },
  { label: '3 tuần', value: '3w' },
  { label: '1 tháng', value: '1m' },
  { label: 'Tuỳ chọn', value: 'custom' },
]

export const ANALYTICS_QUERY_KEY = 'admin-analytics'

export const ROOM_IMAGE_PURGE_TIMEOUT_MS = 10 * 60 * 1000
