import { useEffect } from 'react'
import { App, Form, Input, InputNumber, Modal, Segmented } from 'antd'
import { useAdjustKen } from '@/hooks/useKen'
import { ApiError } from '@/lib/apiError'
import { kenNumberInputProps } from '@/lib/format'
import type { KenAdjustRequest } from '@/types'

interface KenAdjustModalProps {
  open: boolean
  userId: string | null
  username?: string
  currentKen?: number
  onClose: () => void
}

export function KenAdjustModal({
  open,
  userId,
  username,
  currentKen,
  onClose,
}: KenAdjustModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<KenAdjustRequest>()
  const adjust = useAdjustKen()

  useEffect(() => {
    if (open) {
      form.setFieldsValue({ action: 'grant', amount: undefined, description: '' })
    }
  }, [open, form])

  async function onOk() {
    if (!userId) return
    const values = await form.validateFields()
    try {
      const res = await adjust.mutateAsync({ userId, payload: values })
      message.success(
        `${values.action === 'grant' ? 'Đã cộng' : 'Đã trừ'} ${values.amount.toLocaleString('vi-VN')} ken — số dư mới: ${res.balanceAfter.toLocaleString('vi-VN')}`,
      )
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
    }
  }

  return (
    <Modal
      title={`Tặng / Trừ Ken${username ? ` — @${username}` : ''}`}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText="Xác nhận"
      cancelText="Huỷ"
      confirmLoading={adjust.isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false} initialValues={{ action: 'grant' }}>
        {currentKen != null && (
          <div style={{ marginBottom: 12, color: '#6b7785' }}>
            Số dư hiện tại: <b>{currentKen.toLocaleString('vi-VN')}</b> ken
          </div>
        )}
        <Form.Item name="action" label="Hành động">
          <Segmented
            options={[
              { label: 'Cộng ken', value: 'grant' },
              { label: 'Trừ ken', value: 'deduct' },
            ]}
          />
        </Form.Item>
        <Form.Item
          name="amount"
          label="Số ken"
          rules={[{ required: true, message: 'Vui lòng nhập số ken' }]}
        >
          <InputNumber min={1} style={{ width: '100%' }} placeholder="500" {...kenNumberInputProps} />
        </Form.Item>
        <Form.Item
          name="description"
          label="Lý do (tuỳ chọn)"
          rules={[{ max: 255, message: 'Tối đa 255 ký tự' }]}
        >
          <Input.TextArea rows={2} placeholder="Ví dụ: Đền bù sự kiện" />
        </Form.Item>
      </Form>
    </Modal>
  )
}
