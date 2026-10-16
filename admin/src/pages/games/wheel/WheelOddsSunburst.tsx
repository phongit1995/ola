import type { WheelSegment } from '@/types'
import { vipName } from '@/lib/vipCatalog'
import { OddsSunburst } from '../OddsSunburst'
import { kindMeta } from './utils'

interface WheelOddsSunburstProps {
  segments: WheelSegment[]
  size?: number
}

export function WheelOddsSunburst({ segments, size = 300 }: WheelOddsSunburstProps) {
  const groups = segments
    .filter((segment) => segment.isActive && segment.weight > 0)
    .map((segment) => ({
      id: segment.id,
      label: segment.label,
      weight: segment.weight,
      color: kindMeta(segment.kind).color,
      children:
        segment.kind === 'vip_random'
          ? segment.options
              .filter((option) => option.isActive && option.weight > 0)
              .map((option) => ({
                label: option.vipTypeId != null ? vipName(option.vipTypeId) : 'VIP',
                weight: option.weight,
              }))
          : [],
    }))
  return (
    <OddsSunburst
      groups={groups}
      size={size}
      icon="🎡"
      ariaLabel="Tỉ lệ vòng quay"
      emptyText="Chưa có ô nào bật — hãy bật và phân bổ % cho các ô."
    />
  )
}
