import { Segmented, Space } from 'antd'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import type { DateRangePresetState } from '@/hooks/useDateRangePreset'
import { DATE_RANGE_PRESET_OPTIONS, type DateRangePreset } from '@/lib/constants'

export function DateRangePresetFilter({ range }: { range: DateRangePresetState }) {
  return (
    <Space wrap>
      <Segmented<DateRangePreset>
        options={DATE_RANGE_PRESET_OPTIONS}
        value={range.preset}
        onChange={range.selectPreset}
      />
      {range.preset === 'custom' && (
        <DateRangeFilter from={range.from} to={range.to} onFromChange={range.setFrom} onToChange={range.setTo} />
      )}
    </Space>
  )
}
