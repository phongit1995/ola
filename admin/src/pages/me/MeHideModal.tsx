import { App, Form, Input, Modal, Select, Typography } from 'antd'
import { PenaltySeverityRadio } from '@/components/PenaltySeverityRadio'
import { useUpdateMeStatus } from '@/hooks/useMeQueries'
import { errorMessage } from '@/lib/apiError'
import { DEFAULT_PENALTY_SEVERITY, withPenaltyOutcome } from '@/lib/moderation'
import type { PenaltySeverity, ReportReason } from '@/types'
import { ME_HIDE_NOTE_MAX, ME_HIDE_REASON_OPTIONS } from './constants'

interface MeHideFormValues {
  reason: ReportReason
  severity: PenaltySeverity
  note?: string
}

interface MeHideModalProps {
  postId: string
  onClose: () => void
}

export function MeHideModal({ postId, onClose }: MeHideModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<MeHideFormValues>()
  const updateStatus = useUpdateMeStatus()

  async function submit(values: MeHideFormValues) {
    try {
      const result = await updateStatus.mutateAsync({
        id: postId,
        enabled: false,
        penalty: {
          reason: values.reason,
          severity: values.severity,
          note: values.note?.trim() || undefined,
        },
      })
      message.success(withPenaltyOutcome('Đã ẩn bài', result.penalty))
      onClose()
    } catch (err) {
      message.error(errorMessage(err, 'Ẩn bài thất bại'))
    }
  }

  return (
    <Modal
      open
      title="Ẩn bài đăng"
      okText="Ẩn bài"
      okButtonProps={{ danger: true, loading: updateStatus.isPending }}
      cancelText="Huỷ"
      onOk={() => form.submit()}
      onCancel={onClose}
      destroyOnHidden
    >
      <Typography.Paragraph type="secondary">
        Bài sẽ bị ẩn khỏi người dùng. Tác giả nhận thông báo bài bị ẩn kèm lý do và số điểm vi phạm (nếu có).
      </Typography.Paragraph>
      <Form<MeHideFormValues>
        form={form}
        layout="vertical"
        initialValues={{ severity: DEFAULT_PENALTY_SEVERITY }}
        onFinish={submit}
        disabled={updateStatus.isPending}
      >
        <Form.Item name="reason" label="Lý do" rules={[{ required: true, message: 'Chọn lý do ẩn bài' }]}>
          <Select options={ME_HIDE_REASON_OPTIONS} placeholder="Chọn lý do" />
        </Form.Item>
        <Form.Item name="severity" label="Mức xử lý">
          <PenaltySeverityRadio />
        </Form.Item>
        <Form.Item name="note" label="Ghi chú">
          <Input.TextArea
            rows={3}
            maxLength={ME_HIDE_NOTE_MAX}
            showCount
            placeholder="Ghi chú nội bộ cho admin, KHÔNG gửi cho người dùng"
          />
        </Form.Item>
      </Form>
    </Modal>
  )
}
