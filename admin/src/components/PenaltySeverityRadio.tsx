import { Radio } from 'antd'
import { useAppSettings } from '@/hooks/useAppSettingQueries'
import { moderationSetting, penaltySeverityOptions } from '@/lib/moderation'
import type { PenaltySeverity } from '@/types'

interface PenaltySeverityRadioProps {
  value?: PenaltySeverity
  onChange?: (value: PenaltySeverity) => void
  disabled?: boolean
}

export function PenaltySeverityRadio({ value, onChange, disabled }: PenaltySeverityRadioProps) {
  const { data: settings } = useAppSettings()
  const { deliberatePoints } = moderationSetting(settings)

  return (
    <Radio.Group
      value={value}
      disabled={disabled}
      options={penaltySeverityOptions(deliberatePoints)}
      onChange={(event) => onChange?.(event.target.value as PenaltySeverity)}
    />
  )
}
