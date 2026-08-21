import { useEffect } from 'react'
import { App, DatePicker, Form, Input, Modal, Switch } from 'antd'
import dayjs, { type Dayjs } from 'dayjs'
import { useCreateAnnouncement, useUpdateAnnouncement } from '@/hooks/useAnnouncements'
import { ApiError } from '@/lib/apiError'
import type { Announcement } from '@/types'

interface AnnouncementFormModalProps {
  open: boolean
  announcement: Announcement | null
  onClose: () => void
}

interface AnnouncementFormValues {
  title: string
  content?: string
  link?: string
  isActive: boolean
  startsAt?: Dayjs | null
  endsAt?: Dayjs | null
}

export function AnnouncementFormModal({ open, announcement, onClose }: AnnouncementFormModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<AnnouncementFormValues>()
  const createAnnouncement = useCreateAnnouncement()
  const updateAnnouncement = useUpdateAnnouncement()
  const isEdit = announcement != null

  useEffect(() => {
    if (open) {
      form.setFieldsValue({
        title: announcement?.title ?? '',
        content: announcement?.content ?? '',
        link: announcement?.link ?? '',
        isActive: announcement?.isActive ?? true,
        startsAt: announcement?.startsAt ? dayjs(announcement.startsAt) : null,
        endsAt: announcement?.endsAt ? dayjs(announcement.endsAt) : null,
      })
    }
  }, [open, announcement, form])

  async function onOk() {
    const values = await form.validateFields()
    const payload = {
      title: values.title,
      content: values.content ?? '',
      link: values.link ?? '',
      isActive: values.isActive,
      startsAt: values.startsAt ? values.startsAt.toISOString() : '',
      endsAt: values.endsAt ? values.endsAt.toISOString() : '',
    }
    try {
      if (isEdit && announcement) {
        await updateAnnouncement.mutateAsync({ id: announcement.id, payload })
        message.success('Đã cập nhật thông báo')
      } else {
        await createAnnouncement.mutateAsync(payload)
        message.success('Đã tạo thông báo')
      }
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu thông báo thất bại')
    }
  }

  return (
    <Modal
      title={isEdit ? 'Sửa thông báo' : 'Tạo thông báo'}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText={isEdit ? 'Lưu' : 'Tạo'}
      cancelText="Huỷ"
      confirmLoading={createAnnouncement.isPending || updateAnnouncement.isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false}>
        <Form.Item
          name="title"
          label="Tiêu đề (chữ chạy trên banner)"
          rules={[
            { required: true, whitespace: true, message: 'Vui lòng nhập tiêu đề' },
            { max: 200, message: 'Tối đa 200 ký tự' },
          ]}
        >
          <Input placeholder="Ví dụ: Update bộ icon mới — Cài đặt bộ icon mới tại: Ứng Dụng" />
        </Form.Item>
        <Form.Item
          name="content"
          label="Nội dung chi tiết (tuỳ chọn — để trống nếu chỉ cần hiển thị tiêu đề)"
        >
          <Input.TextArea rows={4} placeholder="Nội dung chi tiết khi người dùng bấm vào banner" />
        </Form.Item>
        <Form.Item
          name="link"
          label="Liên kết (tuỳ chọn)"
          rules={[
            { type: 'url', message: 'URL không hợp lệ' },
            { max: 500, message: 'Tối đa 500 ký tự' },
          ]}
        >
          <Input placeholder="https://..." />
        </Form.Item>
        <Form.Item
          name="startsAt"
          label="Thời gian bắt đầu (tuỳ chọn — để trống là hiển thị ngay)"
        >
          <DatePicker showTime format="DD/MM/YYYY HH:mm" style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="endsAt"
          label="Thời gian kết thúc (tuỳ chọn — để trống là không giới hạn)"
          dependencies={['startsAt']}
          rules={[
            ({ getFieldValue }) => ({
              validator(_, value: Dayjs | null | undefined) {
                const startsAt = getFieldValue('startsAt') as Dayjs | null | undefined
                if (value && startsAt && !value.isAfter(startsAt)) {
                  return Promise.reject(new Error('Kết thúc phải sau thời gian bắt đầu'))
                }
                return Promise.resolve()
              },
            }),
          ]}
        >
          <DatePicker showTime format="DD/MM/YYYY HH:mm" style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item name="isActive" label="Đang bật" valuePropName="checked">
          <Switch />
        </Form.Item>
      </Form>
    </Modal>
  )
}
