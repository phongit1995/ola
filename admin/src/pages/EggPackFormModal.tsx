import { useEffect } from 'react'
import { Form, Input, InputNumber, Modal, Switch } from 'antd'
import type { EggPack } from './egg/mockEgg'

export interface EggPackFormValues {
  name: string
  kenCost: number
  isEnabled: boolean
}

interface EggPackFormModalProps {
  open: boolean
  editing: EggPack | null
  onClose: () => void
  onSubmit: (values: EggPackFormValues) => void
}

export function EggPackFormModal({ open, editing, onClose, onSubmit }: EggPackFormModalProps) {
  const [form] = Form.useForm<EggPackFormValues>()
  const isEdit = editing != null

  useEffect(() => {
    if (!open) return
    form.setFieldsValue({
      name: editing?.name ?? '',
      kenCost: editing?.kenCost ?? 100,
      isEnabled: editing?.isEnabled ?? true,
    })
  }, [open, editing, form])

  async function onOk() {
    const values = await form.validateFields()
    onSubmit({ name: values.name.trim(), kenCost: values.kenCost, isEnabled: values.isEnabled })
    onClose()
  }

  return (
    <Modal
      title={isEdit ? 'Sửa gói đập trứng' : 'Thêm gói đập trứng'}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText={isEdit ? 'Lưu' : 'Tạo'}
      cancelText="Huỷ"
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false}>
        <Form.Item
          name="name"
          label="Tên gói"
          rules={[
            { required: true, message: 'Vui lòng nhập tên gói' },
            { max: 100, message: 'Tối đa 100 ký tự' },
          ]}
        >
          <Input placeholder="Ví dụ: Trứng Đồng" />
        </Form.Item>
        <Form.Item
          name="kenCost"
          label="Giá mỗi lượt đập"
          rules={[{ required: true, message: 'Vui lòng nhập giá' }]}
        >
          <InputNumber min={0} style={{ width: '100%' }} addonAfter="Ken" placeholder="100" />
        </Form.Item>
        <Form.Item name="isEnabled" label="Bật gói" valuePropName="checked">
          <Switch />
        </Form.Item>
      </Form>
    </Modal>
  )
}
