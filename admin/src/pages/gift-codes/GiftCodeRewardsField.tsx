import { Button, Divider, Form, InputNumber, Select, Space, Typography } from 'antd'
import { DeleteOutlined, PlusOutlined } from '@ant-design/icons'
import { AvatarFrameSelect } from '@/components/AvatarFrameSelect'
import { VIP_CATALOG, vipIconUrl } from '@/lib/vipCatalog'
import { GIFT_CODE_MAX_REWARDS, GIFT_CODE_REWARD_TYPE_OPTIONS } from './constants'
import type { GiftCodeFormValues } from './types'
import { cleanRewards } from './utils'

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

function GiftCodeRewardRow({ name, disabled, onRemove }: { name: number; disabled: boolean; onRemove?: () => void }) {
  const form = Form.useFormInstance<GiftCodeFormValues>()
  const type = Form.useWatch(['rewards', name, 'type'], form)
  return (
    <div style={{ display: 'flex', gap: 8, alignItems: 'flex-start' }}>
      <Form.Item name={[name, 'type']} style={{ width: 160, marginBottom: 12 }}>
        <Select disabled={disabled} options={GIFT_CODE_REWARD_TYPE_OPTIONS} />
      </Form.Item>
      {type === 'avatar_frame' ? (
        <Form.Item name={[name, 'frameId']} style={{ flex: 1, marginBottom: 12 }} rules={[{ required: true, message: 'Chọn khung avatar' }]}>
          <AvatarFrameSelect disabled={disabled} />
        </Form.Item>
      ) : type === 'vip_icon' ? (
        <Form.Item name={[name, 'vipIconId']} style={{ flex: 1, marginBottom: 12 }} rules={[{ required: true, message: 'Chọn icon VIP' }]}>
          <Select
            disabled={disabled}
            showSearch
            placeholder="Tìm và chọn icon VIP..."
            options={VIP_ICON_OPTIONS}
            filterOption={(input, option) => String(option?.name ?? '').toLowerCase().includes(input.toLowerCase())}
          />
        </Form.Item>
      ) : (
        <Form.Item name={[name, 'days']} style={{ flex: 1, marginBottom: 12 }} rules={[{ required: true, message: 'Nhập số ngày' }]}>
          <InputNumber disabled={disabled} min={1} max={3650} addonAfter="ngày" style={{ width: '100%' }} />
        </Form.Item>
      )}
      <Button type="text" danger icon={<DeleteOutlined />} disabled={disabled || onRemove == null} onClick={onRemove} />
    </div>
  )
}

export function GiftCodeRewardsField({ locked }: { locked: boolean }) {
  return (
    <>
      <Divider titlePlacement="start" plain style={{ margin: '4px 0 16px' }}>
        Quà nhận được
      </Divider>
      <Form.List
        name="rewards"
        rules={[
          {
            validator: async (_, value) => {
              if (cleanRewards(value).length === 0) throw new Error('Thêm ít nhất một món quà')
            },
          },
        ]}
      >
        {(fields, { add, remove }, { errors }) => (
          <>
            {fields.map((field) => (
              <GiftCodeRewardRow
                key={field.key}
                name={field.name}
                disabled={locked}
                onRemove={fields.length > 1 ? () => remove(field.name) : undefined}
              />
            ))}
            <Button
              type="dashed"
              icon={<PlusOutlined />}
              disabled={locked || fields.length >= GIFT_CODE_MAX_REWARDS}
              onClick={() => add({ type: 'vip_icon' })}
              style={{ marginBottom: 8 }}
            >
              Thêm quà
            </Button>
            <Form.ErrorList errors={errors} />
          </>
        )}
      </Form.List>
      <Typography.Paragraph type="secondary" style={{ fontSize: 13 }}>
        Ngày VIP tính từ lúc nhận, đang có VIP thì cộng dồn. Icon và khung giữ vĩnh viễn nhưng không chuyển được cho người khác.
        Khung cần còn VIP mới đeo được. Ai đã có sẵn khung thì chỉ nhận các quà còn lại; mã chỉ có khung thì họ không nhận được và không mất lượt.
      </Typography.Paragraph>
    </>
  )
}
