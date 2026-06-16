import { useEffect, useState } from 'react'
import { App, Button, Form, Image, Input, InputNumber, Modal, Space, Upload } from 'antd'
import { DeleteOutlined, UploadOutlined } from '@ant-design/icons'
import { useCreateRoom, useUpdateRoom } from '@/hooks/useRooms'
import { AdminUploadService } from '@/services/adminUpload.service'
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
  const [uploading, setUploading] = useState(false)
  const isEdit = room != null
  const imageUrl = Form.useWatch('imageUrl', form)

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

  async function handleUpload(file: File) {
    setUploading(true)
    try {
      const url = await AdminUploadService.image(file)
      form.setFieldValue('imageUrl', url)
      message.success('Đã tải ảnh lên')
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Tải ảnh thất bại')
    } finally {
      setUploading(false)
    }
  }

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

        <Form.Item label="Ảnh phòng">
          <Space align="start" size={16}>
            {imageUrl && (
              <Image
                src={imageUrl}
                width={88}
                height={88}
                style={{ objectFit: 'cover', borderRadius: 8 }}
              />
            )}
            <Space direction="vertical">
              <Upload
                accept="image/*"
                showUploadList={false}
                beforeUpload={(file) => {
                  void handleUpload(file)
                  return false
                }}
              >
                <Button icon={<UploadOutlined />} loading={uploading}>
                  {imageUrl ? 'Đổi ảnh' : 'Tải ảnh lên'}
                </Button>
              </Upload>
              {imageUrl && (
                <Button
                  type="text"
                  danger
                  icon={<DeleteOutlined />}
                  onClick={() => form.setFieldValue('imageUrl', '')}
                >
                  Xoá ảnh
                </Button>
              )}
            </Space>
          </Space>
        </Form.Item>
        <Form.Item name="imageUrl" hidden>
          <Input />
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
