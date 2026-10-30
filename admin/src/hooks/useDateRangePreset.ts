import { useState } from 'react'
import { DEFAULT_DATE_RANGE_PRESET, type DateRangePreset, type FixedDateRange } from '@/lib/constants'
import { presetRange } from '@/lib/dateRange'

export function useDateRangePreset(initial: FixedDateRange = DEFAULT_DATE_RANGE_PRESET) {
  const [preset, setPreset] = useState<DateRangePreset>(initial)
  const [range, setRange] = useState(() => presetRange(initial))

  function selectPreset(value: DateRangePreset) {
    setPreset(value)
    if (value !== 'custom') setRange(presetRange(value))
  }

  return {
    preset,
    from: range.from,
    to: range.to,
    selectPreset,
    setFrom: (from: string) => setRange((prev) => ({ ...prev, from })),
    setTo: (to: string) => setRange((prev) => ({ ...prev, to })),
  }
}

export type DateRangePresetState = ReturnType<typeof useDateRangePreset>
