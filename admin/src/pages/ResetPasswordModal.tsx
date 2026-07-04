import { App, Form, Input, Modal } from 'antd'
import { useResetPassword } from '@/hooks/useUsers'
import { ApiError } from '@/lib/apiError'

interface ResetPasswordFormValues {
  password: string
  confirm: string
}

interface ResetPasswordModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

export function ResetPasswordModal({ open, userId, username, onClose }: ResetPasswordModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<ResetPasswordFormValues>()
  const { mutateAsync, isPending } = useResetPassword()

  async function onOk() {
    if (!userId) return
    const values = await form.validateFields()
    try {
      await mutateAsync({ id: userId, password: values.password })
      message.success('Đặt lại mật khẩu thành công')
      form.resetFields()
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Đặt lại mật khẩu thất bại')
    }
  }

  return (
    <Modal
      title={username ? `Đổi mật khẩu @${username}` : 'Đổi mật khẩu'}
      open={open}
      onOk={onOk}
      onCancel={() => {
        form.resetFields()
        onClose()
      }}
      okText="Lưu"
      cancelText="Huỷ"
      confirmLoading={isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false}>
        <Form.Item
          name="password"
          label="Mật khẩu mới"
          rules={[
            { required: true, message: 'Vui lòng nhập mật khẩu mới' },
            { min: 6, max: 20, message: 'Mật khẩu phải từ 6 đến 20 ký tự' },
          ]}
        >
          <Input.Password autoComplete="new-password" placeholder="6–20 ký tự" />
        </Form.Item>
        <Form.Item
          name="confirm"
          label="Nhập lại mật khẩu"
          dependencies={['password']}
          rules={[
            { required: true, message: 'Vui lòng nhập lại mật khẩu' },
            ({ getFieldValue }) => ({
              validator(_, value) {
                if (!value || value === getFieldValue('password')) {
                  return Promise.resolve()
                }
                return Promise.reject(new Error('Mật khẩu nhập lại không khớp'))
              },
            }),
          ]}
        >
          <Input.Password autoComplete="new-password" placeholder="Nhập lại mật khẩu mới" />
        </Form.Item>
      </Form>
    </Modal>
  )
}
