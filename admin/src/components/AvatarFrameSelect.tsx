import { Select, Space } from 'antd'
import { AVATAR_FRAMES } from '@ola/shared/lib/avatarFrame'

const AVATAR_FRAME_OPTIONS = AVATAR_FRAMES.map((frame) => ({
  value: frame.id,
  name: `#${frame.id} ${frame.name}`,
  label: (
    <Space>
      <img src={frame.url} alt="" width={24} height={24} loading="lazy" style={{ objectFit: 'contain' }} />
      <span>{frame.name ? `#${frame.id} — ${frame.name}` : `#${frame.id}`}</span>
    </Space>
  ),
}))

interface AvatarFrameSelectProps {
  value?: string
  onChange?: (value: string) => void
  disabled?: boolean
  disabledIds?: ReadonlySet<string>
}

export function AvatarFrameSelect({ value, onChange, disabled, disabledIds }: AvatarFrameSelectProps) {
  const options =
    disabledIds == null || disabledIds.size === 0
      ? AVATAR_FRAME_OPTIONS
      : AVATAR_FRAME_OPTIONS.map((option) => ({ ...option, disabled: disabledIds.has(option.value) }))
  return (
    <Select
      value={value}
      onChange={onChange}
      disabled={disabled}
      showSearch
      placeholder="Tìm và chọn khung avatar..."
      options={options}
      filterOption={(input, option) => String(option?.name ?? '').toLowerCase().includes(input.toLowerCase())}
    />
  )
}
