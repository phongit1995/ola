import { useEffect, useMemo } from 'react'
import { Form, Input, InputNumber, Modal, Select, Space, Switch, Typography } from 'antd'
import { VIP_CATALOG, vipIconUrl, vipName } from '@/lib/vipCatalog'
import { rebalanceWeights, type EggCategoryType, type EggReward } from './egg/eggHelpers'

export interface EggItemFormValues {
  label: string
  weight: number
  vipTypeId?: number
  kenAmount?: number
  vipDays?: number
  isSuperLucky: boolean
  isActive: boolean
}

interface EggRewardFormModalProps {
  open: boolean
  categoryType: EggCategoryType
  categoryLabel: string
  editing: EggReward | null
  initialPercent?: number
  groupRewards?: EggReward[]
  onClose: () => void
  onSubmit: (values: EggItemFormValues) => void
}

export function EggRewardFormModal({
  open,
  categoryType,
  categoryLabel,
  editing,
  initialPercent,
  groupRewards = [],
  onClose,
  onSubmit,
}: EggRewardFormModalProps) {
  const [form] = Form.useForm<EggItemFormValues>()
  const isEdit = editing != null

  const weightWatch = Form.useWatch('weight', form)
  const labelWatch = Form.useWatch('label', form)
  const activeWatch = Form.useWatch('isActive', form)

  const previewId = editing?.id ?? '__new__'
  const preview = useMemo(() => {
    const target = Number(weightWatch) || 0
    const others = groupRewards.filter((r) => r.id !== previewId)
    const list = [
      ...others.map((r) => ({ id: r.id, label: r.label, weight: r.weight, isActive: r.isActive })),
      { id: previewId, label: labelWatch?.trim() || 'Phần thưởng này', weight: target, isActive: activeWatch ?? true },
    ]
    const next = rebalanceWeights(list, previewId, target)
    return list
      .filter((r) => r.isActive)
      .map((r) => ({ id: r.id, label: r.label, pct: next.get(r.id) ?? r.weight, current: r.id === previewId }))
  }, [groupRewards, previewId, weightWatch, labelWatch, activeWatch])

  useEffect(() => {
    if (!open) return
    form.setFieldsValue({
      label: editing?.label ?? '',
      weight: initialPercent ?? editing?.weight ?? 10,
      vipTypeId: editing?.vipTypeId,
      kenAmount: editing?.kenAmount,
      vipDays: editing?.vipDays,
      isSuperLucky: editing?.isSuperLucky ?? false,
      isActive: editing?.isActive ?? true,
    })
  }, [open, editing, initialPercent, form])

  async function onOk() {
    const values = await form.validateFields()
    const payload: EggItemFormValues = {
      label: values.label.trim(),
      weight: values.weight,
      isSuperLucky: values.isSuperLucky,
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
          label="% trong nhóm — các phần thưởng còn lại sẽ tự cân để tổng nhóm = 100%"
          rules={[{ required: true, message: 'Vui lòng nhập % trong nhóm' }]}
        >
          <InputNumber
            min={0}
            max={100}
            step={0.01}
            addonAfter="%"
            style={{ width: '100%' }}
            placeholder="Ví dụ: 0.01, 0.15, 25"
          />
        </Form.Item>

        {preview.length > 0 && (
          <div style={{ background: '#fafafa', borderRadius: 8, padding: '10px 12px', marginBottom: 16 }}>
            <Typography.Text type="secondary" style={{ fontSize: 12 }}>
              Xem trước phân bổ trong nhóm sau khi lưu:
            </Typography.Text>
            <div style={{ marginTop: 8, display: 'flex', flexDirection: 'column', gap: 4 }}>
              {preview.map((p) => (
                <div
                  key={p.id}
                  style={{
                    display: 'flex',
                    justifyContent: 'space-between',
                    fontWeight: p.current ? 700 : 400,
                    color: p.current ? '#d46b08' : undefined,
                  }}
                >
                  <span style={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', maxWidth: 320 }}>
                    {p.label}
                    {p.current && ' (đang sửa)'}
                  </span>
                  <span>{p.pct.toFixed(2)}%</span>
                </div>
              ))}
            </div>
          </div>
        )}

        <Form.Item
          name="isSuperLucky"
          label="Siêu may mắn — khi trúng sẽ hiện chúc mừng 'bạn quá may mắn'"
          valuePropName="checked"
        >
          <Switch />
        </Form.Item>

        <Form.Item name="isActive" label="Đang bật" valuePropName="checked">
          <Switch />
        </Form.Item>
      </Form>
    </Modal>
  )
}
