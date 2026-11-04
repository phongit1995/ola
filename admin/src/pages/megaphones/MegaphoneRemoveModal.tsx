import { App, Form, Input, Modal, Select, Typography } from 'antd'
import { PenaltySeverityRadio } from '@/components/PenaltySeverityRadio'
import { errorMessage } from '@/lib/apiError'
import { DEFAULT_PENALTY_SEVERITY, REPORT_REASON_LABEL, withPenaltyOutcome } from '@/lib/moderation'
import { ME_HIDE_NOTE_MAX, ME_HIDE_REASON_OPTIONS } from '@/pages/me/constants'
import type { AdminMegaphone, PenaltySeverity, ReportReason } from '@/types'
import { useRemoveMegaphone } from './useMegaphoneQueries'

interface MegaphoneRemoveFormValues {
  reason: ReportReason
  severity: PenaltySeverity
  note?: string
}

interface MegaphoneRemoveModalProps {
  megaphone: AdminMegaphone
  onClose: () => void
}

export function MegaphoneRemoveModal({ megaphone, onClose }: MegaphoneRemoveModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<MegaphoneRemoveFormValues>()
  const remove = useRemoveMegaphone()

  async function submit(values: MegaphoneRemoveFormValues) {
    try {
      const result = await remove.mutateAsync({
        id: megaphone.id,
        payload: {
          reason: REPORT_REASON_LABEL[values.reason],
          penalty: {
            reason: values.reason,
            severity: values.severity,
            note: values.note?.trim() || undefined,
          },
        },
      })
      message.success(withPenaltyOutcome('Đã gỡ loa', result.penalty))
      onClose()
    } catch (err) {
      message.error(errorMessage(err, 'Gỡ loa thất bại'))
    }
  }

  return (
    <Modal
      open
      title="Gỡ loa"
      okText="Gỡ loa"
      okButtonProps={{ danger: true, loading: remove.isPending }}
      cancelText="Huỷ"
      onOk={() => form.submit()}
      onCancel={onClose}
      destroyOnHidden
    >
      <Typography.Paragraph type="secondary">
        Loa biến mất ngay trên mọi máy và khỏi màn Loa 24 giờ. Không hoàn KEN. Người phát nhận thông báo kèm lý do
        và số điểm vi phạm (nếu có).
      </Typography.Paragraph>
      <Typography.Paragraph style={{ whiteSpace: 'pre-wrap' }}>
        <Typography.Text strong>{megaphone.sender.fullName || megaphone.sender.username}: </Typography.Text>
        {megaphone.content}
      </Typography.Paragraph>
      <Form<MegaphoneRemoveFormValues>
        form={form}
        layout="vertical"
        initialValues={{ severity: DEFAULT_PENALTY_SEVERITY }}
        onFinish={submit}
        disabled={remove.isPending}
      >
        <Form.Item name="reason" label="Lý do" rules={[{ required: true, message: 'Chọn lý do gỡ loa' }]}>
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
