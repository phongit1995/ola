import { useEffect } from 'react'
import { App, Form, InputNumber, Modal, Segmented } from 'antd'
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
    if (open) form.setFieldsValue({ action: 'add', days: undefined })
  }, [open, form])

  async function onOk() {
    if (!userId) return
    const values = await form.validateFields()
    try {
      await addDays.mutateAsync({ id: userId, payload: values })
      message.success(
        `${values.action === 'subtract' ? 'Đã trừ' : 'Đã cộng'} ${values.days} ngày VIP`,
      )
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
    }
  }

  return (
    <Modal
      title={`Cộng / Trừ ngày VIP${username ? ` — @${username}` : ''}`}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText="Xác nhận"
      cancelText="Huỷ"
      confirmLoading={addDays.isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false} initialValues={{ action: 'add' }}>
        <Form.Item name="action" label="Hành động">
          <Segmented
            options={[
              { label: 'Cộng ngày', value: 'add' },
              { label: 'Trừ ngày', value: 'subtract' },
            ]}
          />
        </Form.Item>
        <Form.Item
          noStyle
          shouldUpdate={(prev, cur) => prev.action !== cur.action}
        >
          {({ getFieldValue }) => (
            <Form.Item
              name="days"
              label="Số ngày VIP"
              rules={[{ required: true, message: 'Vui lòng nhập số ngày' }]}
              extra={
                getFieldValue('action') === 'subtract'
                  ? 'Trừ vào hạn VIP hiện tại. Nếu trừ quá hạn còn lại, VIP sẽ hết hạn ngay.'
                  : 'Cộng dồn vào hạn VIP hiện tại (nếu còn hạn) hoặc tính từ hôm nay.'
              }
            >
              <InputNumber min={1} max={3650} style={{ width: '100%' }} placeholder="Ví dụ: 30" autoFocus />
            </Form.Item>
          )}
        </Form.Item>
      </Form>
    </Modal>
  )
}
