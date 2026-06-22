import { useEffect } from 'react'
import { Form, Input, InputNumber, Modal, Select, Slider, Space, Switch } from 'antd'
import { VIP_CATALOG, vipIconUrl, vipName } from '@/lib/vipCatalog'
import type { EggCategoryType, EggReward } from './egg/mockEgg'

export interface EggItemFormValues {
  label: string
  weight: number
  vipTypeId?: number
  kenAmount?: number
  vipDays?: number
  isActive: boolean
}

interface EggRewardFormModalProps {
  open: boolean
  categoryType: EggCategoryType
  categoryLabel: string
  editing: EggReward | null
  onClose: () => void
  onSubmit: (values: EggItemFormValues) => void
}

export function EggRewardFormModal({
  open,
  categoryType,
  categoryLabel,
  editing,
  onClose,
  onSubmit,
}: EggRewardFormModalProps) {
  const [form] = Form.useForm<EggItemFormValues>()
  const isEdit = editing != null

  useEffect(() => {
    if (!open) return
    form.setFieldsValue({
      label: editing?.label ?? '',
      weight: editing?.weight ?? 10,
      vipTypeId: editing?.vipTypeId,
      kenAmount: editing?.kenAmount,
      vipDays: editing?.vipDays,
      isActive: editing?.isActive ?? true,
    })
  }, [open, editing, form])

  async function onOk() {
    const values = await form.validateFields()
    const payload: EggItemFormValues = {
      label: values.label.trim(),
      weight: values.weight,
      isActive: values.isActive,
    }
    if (categoryType === 'vip_icon') payload.vipTypeId = values.vipTypeId
    if (categoryType === 'ken') payload.kenAmount = values.kenAmount
    if (categoryType === 'vip_days') payload.vipDays = values.vipDays
    onSubmit(payload)
    onClose()
  }

  return (
    <Modal
      title={isEdit ? 'Sửa phần thưởng' : `Thêm phần thưởng — ${categoryLabel}`}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText={isEdit ? 'Lưu' : 'Thêm'}
      cancelText="Huỷ"
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false}>
        {categoryType === 'vip_icon' && (
          <Form.Item
            name="vipTypeId"
            label="Chọn VIP"
            rules={[{ required: true, message: 'Vui lòng chọn VIP' }]}
          >
            <Select
              showSearch
              placeholder="Tìm và chọn VIP..."
              filterOption={(input, option) =>
                String(option?.name ?? '').toLowerCase().includes(input.toLowerCase())
              }
              onChange={(value: number) => {
                if (!form.getFieldValue('label')) form.setFieldValue('label', vipName(value))
              }}
              options={VIP_CATALOG.map((entry) => ({
                value: entry.id,
                name: `#${entry.id} ${entry.name}`,
                label: (
                  <Space>
                    <img
                      src={vipIconUrl(entry.id)}
                      alt=""
                      width={22}
                      height={22}
                      style={{ objectFit: 'contain' }}
                    />
                    <span>
                      #{entry.id} — {entry.name}
                    </span>
                  </Space>
                ),
              }))}
            />
          </Form.Item>
        )}

        {categoryType === 'ken' && (
          <Form.Item
            name="kenAmount"
            label="Số Ken thưởng"
            rules={[{ required: true, message: 'Vui lòng nhập số Ken' }]}
          >
            <InputNumber min={1} style={{ width: '100%' }} addonAfter="Ken" placeholder="1000" />
          </Form.Item>
        )}

        {categoryType === 'vip_days' && (
          <Form.Item
            name="vipDays"
            label="Số ngày VIP"
            rules={[{ required: true, message: 'Vui lòng nhập số ngày' }]}
          >
            <InputNumber min={1} max={3650} style={{ width: '100%' }} addonAfter="ngày" placeholder="7" />
          </Form.Item>
        )}

        <Form.Item
          name="label"
          label="Nhãn hiển thị"
          rules={[
            { required: true, message: 'Vui lòng nhập nhãn' },
            { max: 100, message: 'Tối đa 100 ký tự' },
          ]}
        >
          <Input placeholder="Ví dụ: 1000 Ken" />
        </Form.Item>

        <Form.Item
          name="weight"
          label="Mức cơ hội (kéo thanh) — % sẽ tự tính theo các phần thưởng cùng nhóm"
        >
          <Slider min={0} max={100} tooltip={{ formatter: (v) => `mức ${v}` }} />
        </Form.Item>

        <Form.Item name="isActive" label="Đang bật" valuePropName="checked">
          <Switch />
        </Form.Item>
      </Form>
    </Modal>
  )
}
