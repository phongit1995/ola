import { useEffect } from 'react'
import { App, Form, Input, Modal } from 'antd'
import { useUpdateUsername } from '@/hooks/useUsers'
import { ApiError } from '@/lib/apiError'

interface EditUsernameFormValues {
  username: string
}

interface EditUsernameModalProps {
  open: boolean
  userId: string | null
  currentUsername?: string
  onClose: () => void
}

const USERNAME_PATTERN = /^[a-z][a-z0-9]*$/

export function EditUsernameModal({ open, userId, currentUsername, onClose }: EditUsernameModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<EditUsernameFormValues>()
  const { mutateAsync, isPending } = useUpdateUsername()

  useEffect(() => {
    if (open) {
      form.setFieldsValue({ username: currentUsername ?? '' })
    }
  }, [open, currentUsername, form])

  async function onOk() {
    if (!userId) return
    const values = await form.validateFields()
    const username = values.username.trim().toLowerCase()
    if (username === currentUsername) {
      onClose()
      return
    }
    try {
      await mutateAsync({ id: userId, username })
      message.success('Cập nhật username thành công')
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Cập nhật username thất bại')
    }
  }

  return (
    <Modal
      title="Đổi username"
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText="Lưu"
      cancelText="Huỷ"
      confirmLoading={isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false}>
        <Form.Item
          name="username"
          label="Username"
          normalize={(value: string) => value.toLowerCase()}
          rules={[
            { required: true, message: 'Vui lòng nhập username' },
            { min: 2, max: 20, message: 'Username phải từ 2 đến 20 ký tự' },
            {
              pattern: USERNAME_PATTERN,
              message: 'Chỉ gồm chữ thường và số, phải bắt đầu bằng chữ',
            },
          ]}
        >
          <Input autoComplete="off" addonBefore="@" />
        </Form.Item>
      </Form>
    </Modal>
  )
}
