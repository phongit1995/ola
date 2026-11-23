import { useEffect } from 'react'
import { Alert, App, Button, Checkbox, DatePicker, Form, Modal, Space } from 'antd'
import dayjs, { type Dayjs } from 'dayjs'
import { errorMessage } from '@/lib/apiError'
import type { UpdateItemGrantRequest } from '@/types'
import { ITEM_GRANT_EXTEND_DAYS } from './constants'

interface EditItemGrantFormValues {
  expiresAt: Dayjs | null
  locked: boolean
}

interface EditItemGrantModalProps {
  open: boolean
  title: string
  locked: boolean
  expiresAt?: string | null
  submitting: boolean
  onSubmit: (payload: UpdateItemGrantRequest) => Promise<unknown>
  onClose: () => void
}

function extendBase(current: Dayjs | null): Dayjs {
  const now = dayjs()
  return current && current.isAfter(now) ? current : now
}

export function EditItemGrantModal({ open, title, locked, expiresAt, submitting, onSubmit, onClose }: EditItemGrantModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<EditItemGrantFormValues>()
  const timed = expiresAt != null && expiresAt !== ''

  useEffect(() => {
    if (!open) return
    form.setFieldsValue({
      expiresAt: timed ? dayjs(expiresAt) : null,
      locked: timed ? true : locked,
    })
  }, [open, timed, expiresAt, locked, form])

  const extend = (days: number) => {
    const current = form.getFieldValue('expiresAt') as Dayjs | null
    form.setFieldsValue({ expiresAt: extendBase(current).add(days, 'day') })
  }

  async function onOk() {
    const values = await form.validateFields()
    const payload: UpdateItemGrantRequest = timed
      ? { expiresAt: values.expiresAt ? values.expiresAt.toISOString() : null, locked: true }
      : { expiresAt: null, locked: values.locked }
    try {
      await onSubmit(payload)
      message.success('Đã cập nhật')
      onClose()
    } catch (err) {
      message.error(errorMessage(err, 'Cập nhật thất bại'))
    }
  }

  return (
    <Modal
      title={title}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText="Lưu"
      cancelText="Huỷ"
      confirmLoading={submitting}
      destroyOnHidden
    >
      <Alert
        type="info"
        showIcon
        style={{ marginBottom: 16 }}
        title={
          timed
            ? 'Món có hạn chỉ đổi được ngày hết hạn (gia hạn hoặc rút ngắn), không chuyển thành vĩnh viễn. Muốn vĩnh viễn thì tặng thêm một món vĩnh viễn.'
            : 'Món vĩnh viễn chỉ đổi được khoá, không chuyển thành có hạn.'
        }
      />
      <Form form={form} layout="vertical" requiredMark={false}>
        {timed && (
          <>
            <Form.Item
              name="expiresAt"
              label="Hết hạn lúc"
              rules={[
                { required: true, message: 'Chọn thời điểm hết hạn' },
                {
                  validator: (_, value: Dayjs | null) =>
                    !value || value.isAfter(dayjs())
                      ? Promise.resolve()
                      : Promise.reject(new Error('Thời điểm hết hạn phải ở tương lai')),
                },
              ]}
            >
              <DatePicker showTime format="DD/MM/YYYY HH:mm" style={{ width: '100%' }} />
            </Form.Item>
            <Space wrap style={{ marginBottom: 16 }}>
              {ITEM_GRANT_EXTEND_DAYS.map((days) => (
                <Button key={days} size="small" onClick={() => extend(days)}>
                  {`+${days} ngày`}
                </Button>
              ))}
            </Space>
          </>
        )}
        <Form.Item name="locked" valuePropName="checked" style={{ marginBottom: 0 }}>
          <Checkbox disabled={timed}>Khoá (không cho chuyển, tặng lại, giao dịch)</Checkbox>
        </Form.Item>
      </Form>
    </Modal>
  )
}
