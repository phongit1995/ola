import { useEffect } from 'react'
import { App, Form, InputNumber, Modal } from 'antd'
import { useAddVipDays } from '@/hooks/useUsers'
import { ApiError } from '@/lib/apiError'
import type { AddVipDaysRequest } from '@/types'

interface AddVipDaysModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

export function AddVipDaysModal({ open, userId, username, onClose }: AddVipDaysModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<AddVipDaysRequest>()
  const addDays = useAddVipDays()

  useEffect(() => {
    if (open) form.resetFields()
  }, [open, form])

  async function onOk() {
    if (!userId) return
    const values = await form.validateFields()
    try {
      await addDays.mutateAsync({ id: userId, payload: values })
      message.success(`Đã cộng ${values.days} ngày VIP`)
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Cộng ngày VIP thất bại')
    }
  }

  return (
    <Modal
      title={`Cộng ngày VIP${username ? ` — @${username}` : ''}`}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText="Cộng ngày"
      cancelText="Huỷ"
      confirmLoading={addDays.isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false}>
        <Form.Item
          name="days"
          label="Số ngày VIP"
          rules={[{ required: true, message: 'Vui lòng nhập số ngày' }]}
          extra="Cộng dồn vào hạn VIP hiện tại (nếu còn hạn) hoặc tính từ hôm nay."
        >
          <InputNumber min={1} max={3650} style={{ width: '100%' }} placeholder="Ví dụ: 30" autoFocus />
        </Form.Item>
      </Form>
    </Modal>
  )
}
