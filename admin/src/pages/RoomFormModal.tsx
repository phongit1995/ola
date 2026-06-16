import { useEffect } from 'react'
import { App, Form, Input, InputNumber, Modal } from 'antd'
import { useCreateRoom, useUpdateRoom } from '@/hooks/useRooms'
import { ApiError } from '@/lib/apiError'
import type { CreateRoomRequest, Room } from '@/types'

interface RoomFormModalProps {
  open: boolean
  room: Room | null
  onClose: () => void
}

export function RoomFormModal({ open, room, onClose }: RoomFormModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<CreateRoomRequest>()
  const createRoom = useCreateRoom()
  const updateRoom = useUpdateRoom()
  const isEdit = room != null

  useEffect(() => {
    if (open) {
      form.setFieldsValue({
        name: room?.name ?? '',
        description: room?.description ?? '',
        imageUrl: room?.imageUrl ?? '',
        maxMembers: room?.maxMembers ?? undefined,
        index: room?.index ?? 0,
      })
    }
  }, [open, room, form])

  async function onOk() {
    const values = await form.validateFields()
    try {
      if (isEdit && room) {
        await updateRoom.mutateAsync({ id: room.id, payload: values })
        message.success('Đã cập nhật phòng')
      } else {
        await createRoom.mutateAsync(values)
        message.success('Đã tạo phòng')
      }
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu phòng thất bại')
    }
  }

  return (
    <Modal
      title={isEdit ? 'Sửa phòng' : 'Tạo phòng'}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText={isEdit ? 'Lưu' : 'Tạo'}
      cancelText="Huỷ"
      confirmLoading={createRoom.isPending || updateRoom.isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false}>
        <Form.Item
          name="name"
          label="Tên phòng"
          rules={[
            { required: true, message: 'Vui lòng nhập tên phòng' },
            { max: 150, message: 'Tối đa 150 ký tự' },
          ]}
        >
          <Input placeholder="Tên phòng" />
        </Form.Item>
        <Form.Item
          name="description"
          label="Mô tả"
          rules={[{ max: 2000, message: 'Tối đa 2000 ký tự' }]}
        >
          <Input.TextArea rows={3} placeholder="Mô tả phòng (tuỳ chọn)" />
        </Form.Item>
        <Form.Item
          name="imageUrl"
          label="Ảnh (URL)"
          rules={[{ type: 'url', message: 'URL không hợp lệ' }]}
        >
          <Input placeholder="https://..." />
        </Form.Item>
        <Form.Item name="maxMembers" label="Giới hạn thành viên (0 = không giới hạn)">
          <InputNumber min={0} style={{ width: '100%' }} placeholder="0" />
        </Form.Item>
        <Form.Item name="index" label="Thứ tự sắp xếp (nhỏ hơn hiển thị trước)">
          <InputNumber min={0} style={{ width: '100%' }} placeholder="0" />
        </Form.Item>
      </Form>
    </Modal>
  )
}
