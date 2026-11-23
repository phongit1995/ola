import type { ReactNode } from 'react'
import { Button, Form, InputNumber, Select, Space } from 'antd'
import { DeleteOutlined } from '@ant-design/icons'
import type { NamePath } from 'antd/es/form/interface'
import { AvatarFrameSelect } from '@/components/AvatarFrameSelect'
import { VIP_CATALOG, vipIconUrl } from '@/lib/vipCatalog'
import { kenNumberInputProps } from '@/lib/format'
import {
  GIFT_CODE_REWARD_TYPES,
  REWARD_ITEM_MAX_EXPIRY_DAYS,
  REWARD_KEN_MAX_AMOUNT,
  REWARD_KEN_RANDOM_DEFAULT_MAX,
  REWARD_KEN_RANDOM_DEFAULT_MIN,
  REWARD_KEN_RANDOM_STEP,
  REWARD_TICKET_MAX_COUNT,
  REWARD_TICKET_MAX_DAYS,
  rewardItemTypeOptions,
} from '@/lib/rewardItem'
import type { RewardItemType } from '@/types'

const VIP_ICON_OPTIONS = VIP_CATALOG.map((entry) => ({
  value: entry.id,
  name: `#${entry.id} ${entry.name}`,
  label: (
    <Space>
      <img src={vipIconUrl(entry.id)} alt="" width={22} height={22} style={{ objectFit: 'contain' }} />
      <span>
        #{entry.id} — {entry.name}
      </span>
    </Space>
  ),
}))

const KEN_MODE_OPTIONS = [
  { value: false, label: 'Cố định' },
  { value: true, label: 'Ngẫu nhiên' },
]

const KEN_INPUT_PROPS = { precision: 0, addonAfter: 'KEN', style: { width: '100%' }, ...kenNumberInputProps }

function roundedKenRule(label: string) {
  return {
    validator: async (_: unknown, value: number | undefined) => {
      if (value == null) throw new Error(`Nhập ${label}`)
      if (value % REWARD_KEN_RANDOM_STEP !== 0) throw new Error(`Tròn ${REWARD_KEN_RANDOM_STEP}`)
    },
  }
}

interface KenAmountFieldsProps {
  base: (string | number)[]
  name: number
  disabled: boolean
  allowRandom: boolean
}

function KenAmountFields({ base, name, disabled, allowRandom }: KenAmountFieldsProps) {
  const form = Form.useFormInstance()
  const random = Form.useWatch([...base, name, 'kenRandom'], form) === true
  const minPath = [...base, name, 'amountMin']
  const onModeChange = (next: boolean) => {
    if (!next) return
    if (form.getFieldValue(minPath) == null) form.setFieldValue(minPath, REWARD_KEN_RANDOM_DEFAULT_MIN)
    if (form.getFieldValue([...base, name, 'amountMax']) == null) {
      form.setFieldValue([...base, name, 'amountMax'], REWARD_KEN_RANDOM_DEFAULT_MAX)
    }
  }
  return (
    <>
      {allowRandom ? (
        <Form.Item name={[name, 'kenRandom']} style={{ width: 120, marginBottom: 12 }}>
          <Select disabled={disabled} options={KEN_MODE_OPTIONS} onChange={onModeChange} />
        </Form.Item>
      ) : null}
      {allowRandom && random ? (
        <>
          <Form.Item name={[name, 'amountMin']} style={{ flex: 1, minWidth: 0, marginBottom: 12 }} rules={[roundedKenRule('số nhỏ nhất')]}>
            <InputNumber
              disabled={disabled}
              min={REWARD_KEN_RANDOM_STEP}
              max={REWARD_KEN_MAX_AMOUNT - REWARD_KEN_RANDOM_STEP}
              step={REWARD_KEN_RANDOM_STEP}
              placeholder="Từ"
              {...KEN_INPUT_PROPS}
            />
          </Form.Item>
          <Form.Item
            name={[name, 'amountMax']}
            dependencies={[minPath]}
            style={{ flex: 1, minWidth: 0, marginBottom: 12 }}
            rules={[
              roundedKenRule('số lớn nhất'),
              {
                validator: async (_, value: number | undefined) => {
                  const min = form.getFieldValue(minPath) as number | undefined
                  if (value != null && min != null && value <= min) throw new Error('Phải lớn hơn số nhỏ nhất')
                },
              },
            ]}
          >
            <InputNumber
              disabled={disabled}
              min={REWARD_KEN_RANDOM_STEP * 2}
              max={REWARD_KEN_MAX_AMOUNT}
              step={REWARD_KEN_RANDOM_STEP}
              placeholder="Tới"
              {...KEN_INPUT_PROPS}
            />
          </Form.Item>
        </>
      ) : (
        <Form.Item name={[name, 'amount']} style={{ flex: 1, minWidth: 0, marginBottom: 12 }} rules={[{ required: true, message: 'Nhập số KEN' }]}>
          <InputNumber disabled={disabled} min={1} max={REWARD_KEN_MAX_AMOUNT} {...KEN_INPUT_PROPS} />
        </Form.Item>
      )}
    </>
  )
}

interface RewardItemRowProps {
  path: NamePath
  name: number
  disabled?: boolean
  prefix?: ReactNode
  types?: RewardItemType[]
  maxExpiryDays?: number
  kenRandom?: boolean
  onRemove?: () => void
}

export function RewardItemRow({
  path,
  name,
  disabled = false,
  prefix,
  types = GIFT_CODE_REWARD_TYPES,
  maxExpiryDays = REWARD_ITEM_MAX_EXPIRY_DAYS,
  kenRandom = false,
  onRemove,
}: RewardItemRowProps) {
  const form = Form.useFormInstance()
  const base = (Array.isArray(path) ? path : [path]) as (string | number)[]
  const type = Form.useWatch([...base, name, 'type'], form)
  return (
    <div style={{ display: 'flex', gap: 8, alignItems: 'flex-start' }}>
      {prefix}
      <Form.Item name={[name, 'type']} style={{ width: 160, marginBottom: 12 }}>
        <Select disabled={disabled} options={rewardItemTypeOptions(types)} />
      </Form.Item>
      {type === 'avatar_frame' ? (
        <Form.Item
          name={[name, 'frameId']}
          style={{ flex: 1, minWidth: 0, marginBottom: 12 }}
          rules={[{ required: true, message: 'Chọn khung avatar' }]}
        >
          <AvatarFrameSelect disabled={disabled} />
        </Form.Item>
      ) : type === 'vip_icon' ? (
        <Form.Item
          name={[name, 'vipIconId']}
          style={{ flex: 1, minWidth: 0, marginBottom: 12 }}
          rules={[{ required: true, message: 'Chọn icon VIP' }]}
        >
          <Select
            disabled={disabled}
            showSearch
            placeholder="Tìm và chọn icon VIP..."
            options={VIP_ICON_OPTIONS}
            filterOption={(input, option) => String(option?.name ?? '').toLowerCase().includes(input.toLowerCase())}
          />
        </Form.Item>
      ) : type === 'ken' ? (
        <KenAmountFields base={base} name={name} disabled={disabled} allowRandom={kenRandom} />
      ) : type === 'megaphone_ticket' ? (
        <Form.Item name={[name, 'count']} style={{ flex: 1, minWidth: 0, marginBottom: 12 }} rules={[{ required: true, message: 'Nhập số vé' }]}>
          <InputNumber disabled={disabled} min={1} max={REWARD_TICKET_MAX_COUNT} precision={0} addonAfter="vé" style={{ width: '100%' }} />
        </Form.Item>
      ) : (
        <Form.Item name={[name, 'days']} style={{ flex: 1, minWidth: 0, marginBottom: 12 }} rules={[{ required: true, message: 'Nhập số ngày' }]}>
          <InputNumber disabled={disabled} min={1} max={3650} addonAfter="ngày" style={{ width: '100%' }} />
        </Form.Item>
      )}
      {type === 'avatar_frame' || type === 'vip_icon' ? (
        <Form.Item name={[name, 'expiresInDays']} style={{ width: 130, marginBottom: 12 }}>
          <InputNumber disabled={disabled} min={0} max={maxExpiryDays} precision={0} placeholder="Vĩnh viễn" addonAfter="ngày" />
        </Form.Item>
      ) : type === 'megaphone_ticket' ? (
        <Form.Item name={[name, 'expiresInDays']} style={{ width: 130, marginBottom: 12 }}>
          <InputNumber disabled={disabled} min={0} max={REWARD_TICKET_MAX_DAYS} precision={0} placeholder="Không hạn" addonAfter="ngày" />
        </Form.Item>
      ) : null}
      <Button type="text" danger icon={<DeleteOutlined />} disabled={disabled || onRemove == null} onClick={onRemove} />
    </div>
  )
}
