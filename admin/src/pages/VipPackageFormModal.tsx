import { useEffect } from 'react'
import { App, Form, Input, InputNumber, Modal, Switch } from 'antd'
import { useCreateVipPackage, useUpdateVipPackage } from '@/hooks/useVipPackages'
import { ApiError } from '@/lib/apiError'
import { kenNumberInputProps } from '@/lib/format'
import type { CreateVipPackageRequest, VipPackage } from '@/types'

interface VipPackageFormModalProps {
  open: boolean
  pkg: VipPackage | null
  onClose: () => void
}

export function VipPackageFormModal({ open, pkg, onClose }: VipPackageFormModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<CreateVipPackageRequest>()
  const createPackage = useCreateVipPackage()
  const updatePackage = useUpdateVipPackage()
  const isEdit = pkg != null

  useEffect(() => {
    if (open) {
      form.setFieldsValue({
        name: pkg?.name ?? '',
        days: pkg?.days ?? undefined,
        kenPrice: pkg?.kenPrice ?? undefined,
        sortOrder: pkg?.sortOrder ?? 0,
        isActive: pkg?.isActive ?? true,
      })
    }
  }, [open, pkg, form])

  async function onOk() {
    const values = await form.validateFields()
    try {
      if (isEdit && pkg) {
        await updatePackage.mutateAsync({ id: pkg.id, payload: values })
        message.success('Đã cập nhật gói VIP')
      } else {
        await createPackage.mutateAsync(values)
        message.success('Đã tạo gói VIP')
      }
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu gói VIP thất bại')
    }
  }

  return (
    <Modal
      title={isEdit ? 'Sửa gói VIP' : 'Tạo gói VIP'}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText={isEdit ? 'Lưu' : 'Tạo'}
      cancelText="Huỷ"
      confirmLoading={createPackage.isPending || updatePackage.isPending}
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
          <Input placeholder="Ví dụ: Gói 30 ngày" />
        </Form.Item>
        <Form.Item
          name="days"
          label="Số ngày VIP"
          rules={[{ required: true, message: 'Vui lòng nhập số ngày' }]}
        >
          <InputNumber min={1} max={3650} style={{ width: '100%' }} placeholder="30" />
        </Form.Item>
        <Form.Item
          name="kenPrice"
          label="Giá (KEN)"
          rules={[{ required: true, message: 'Vui lòng nhập giá' }]}
        >
          <InputNumber min={0} style={{ width: '100%' }} placeholder="250" {...kenNumberInputProps} />
        </Form.Item>
        <Form.Item name="sortOrder" label="Thứ tự sắp xếp (nhỏ hơn hiển thị trước)">
          <InputNumber min={0} style={{ width: '100%' }} placeholder="0" />
        </Form.Item>
        <Form.Item name="isActive" label="Đang bật" valuePropName="checked">
          <Switch />
        </Form.Item>
      </Form>
    </Modal>
  )
}
