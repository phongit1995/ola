import { useState } from 'react'
import { App, Button, Descriptions, Image, Input, Modal, Space, Tag, Typography } from 'antd'
import { CommentOutlined, PlayCircleOutlined } from '@ant-design/icons'
import { UserBriefCell } from '@/components/UserBriefCell'
import { ConversationMessagesModal } from '@/pages/conversations/ConversationMessagesModal'
import { ReelDetailModal } from '@/pages/reels/ReelDetailModal'
import { errorMessage } from '@/lib/apiError'
import { formatDateTime } from '@/lib/format'
import type { AdminReport } from '@/types'
import { useHandleReport, type ReportHandling } from './useReportQueries'
import { contentActionLabel } from './utils'
import {
  REPORT_HANDLER_NOTE_MAX,
  REPORT_REASON_LABEL,
  REPORT_STATUS_TAG,
  REPORT_TARGET_LABEL,
} from './constants'

interface ReportDetailModalProps {
  report: AdminReport
  onClose: () => void
}

export function ReportDetailModal({ report, onClose }: ReportDetailModalProps) {
  const { message, modal } = App.useApp()
  const handleReport = useHandleReport()
  const [note, setNote] = useState(report.handlerNote ?? '')
  const [conversationOpen, setConversationOpen] = useState(false)
  const [reelOpen, setReelOpen] = useState(false)
  const conversationId = report.targetType === 'message' ? report.contextId : undefined
  const reelId = report.targetType === 'reel' ? report.targetId : undefined

  const snapshot = report.snapshot ?? {}
  const statusMeta = REPORT_STATUS_TAG[report.status]
  const actionLabel = contentActionLabel(report)
  const canLock = report.reportedUser != null && report.reportedUser.isActive
  const reportedName = report.reportedUser ? `@${report.reportedUser.username}` : 'người dùng này'

  async function run(handling: Omit<ReportHandling, 'report' | 'note'>, successText: string) {
    try {
      const result = await handleReport.mutateAsync({ ...handling, report, note })
      message.success(
        result.affected > 1 ? `${successText} (${result.affected} báo cáo cùng nội dung)` : successText,
      )
      onClose()
    } catch (err) {
      message.error(errorMessage(err, 'Thao tác thất bại'))
    }
  }

  function confirmRun(
    title: string,
    content: string,
    handling: Omit<ReportHandling, 'report' | 'note'>,
    successText: string,
  ) {
    modal.confirm({
      title,
      content,
      okText: 'Xác nhận',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: () => run(handling, successText),
    })
  }

  const footer = (
    <Space wrap style={{ justifyContent: 'flex-end', width: '100%' }}>
      <Button onClick={onClose}>Đóng</Button>
      <Button
        loading={handleReport.isPending}
        onClick={() => run({ status: 'dismissed' }, 'Đã bỏ qua báo cáo')}
      >
        Bỏ qua (không vi phạm)
      </Button>
      <Button
        loading={handleReport.isPending}
        onClick={() => run({ status: 'resolved' }, 'Đã đánh dấu đã xử lý')}
      >
        Đánh dấu đã xử lý
      </Button>
      {actionLabel != null && (
        <Button
          danger
          loading={handleReport.isPending}
          onClick={() =>
            confirmRun(
              `${actionLabel}?`,
              'Nội dung sẽ bị gỡ khỏi app và báo cáo được đánh dấu đã xử lý.',
              { status: 'resolved', removeContent: true },
              `Đã ${actionLabel.toLowerCase()}`,
            )
          }
        >
          {actionLabel}
        </Button>
      )}
      {canLock && (
        <Button
          type="primary"
          danger
          loading={handleReport.isPending}
          onClick={() =>
            confirmRun(
              `Khoá tài khoản ${reportedName}?`,
              'Tài khoản bị đăng xuất khỏi mọi thiết bị và không đăng nhập được. Mở khoá lại ở trang Người dùng.',
              { status: 'resolved', lockUser: true },
              'Đã khoá tài khoản',
            )
          }
        >
          Khoá tài khoản
        </Button>
      )}
    </Space>
  )

  return (
    <Modal open title="Chi tiết báo cáo" onCancel={onClose} footer={footer} width={720} destroyOnHidden>
      <Descriptions column={1} size="small" bordered>
        <Descriptions.Item label="Loại">{REPORT_TARGET_LABEL[report.targetType]}</Descriptions.Item>
        <Descriptions.Item label="Lý do">{REPORT_REASON_LABEL[report.reason]}</Descriptions.Item>
        {report.note && <Descriptions.Item label="Mô tả của người báo cáo">{report.note}</Descriptions.Item>}
        <Descriptions.Item label="Trạng thái">
          <Space>
            <Tag color={statusMeta.color}>{statusMeta.label}</Tag>
            {report.sameTargetPending > 1 && (
              <Typography.Text type="warning">
                {report.sameTargetPending} báo cáo đang chờ cho cùng nội dung
              </Typography.Text>
            )}
          </Space>
        </Descriptions.Item>
        <Descriptions.Item label="Người bị báo cáo">
          <UserBriefCell
            user={report.reportedUser}
            badge={report.reportedUser?.isActive === false ? <Tag color="red">Đã khoá</Tag> : null}
          />
        </Descriptions.Item>
        <Descriptions.Item label="Người báo cáo">
          <UserBriefCell user={report.reporter} />
        </Descriptions.Item>
        <Descriptions.Item label="Thời gian báo cáo">{formatDateTime(report.createdAt)}</Descriptions.Item>
        {snapshot.sentAt && (
          <Descriptions.Item label="Thời gian đăng / gửi">{formatDateTime(snapshot.sentAt)}</Descriptions.Item>
        )}
        <Descriptions.Item label="Nội dung lúc báo cáo">
          <Space direction="vertical" style={{ width: '100%' }}>
            {report.targetType === 'account' && (
              <UserBriefCell
                user={{
                  username: snapshot.username ?? '',
                  fullName: snapshot.fullName,
                  avatar: snapshot.avatar,
                }}
              />
            )}
            {snapshot.text && (
              <Typography.Paragraph style={{ whiteSpace: 'pre-wrap', marginBottom: 0 }}>
                {snapshot.text}
              </Typography.Paragraph>
            )}
            {snapshot.videoUrl && (
              <video
                controls
                preload="metadata"
                src={snapshot.videoUrl}
                poster={snapshot.imageUrls?.[0]}
                style={{ width: '100%', maxHeight: 420, background: '#000', borderRadius: 8 }}
              />
            )}
            {!snapshot.videoUrl && (snapshot.imageUrls?.length ?? 0) > 0 && (
              <Image.PreviewGroup>
                <Space wrap>
                  {snapshot.imageUrls?.map((url) => (
                    <Image key={url} src={url} width={96} height={96} style={{ objectFit: 'cover' }} />
                  ))}
                </Space>
              </Image.PreviewGroup>
            )}
            {snapshot.sticker && <Image src={snapshot.sticker} width={72} preview={false} />}
            {snapshot.audioUrl && <audio controls src={snapshot.audioUrl} style={{ width: '100%' }} />}
            {snapshot.fileUrl && (
              <Typography.Link href={snapshot.fileUrl} target="_blank" rel="noreferrer">
                Mở tệp đính kèm
              </Typography.Link>
            )}
            {conversationId && (
              <Button size="small" icon={<CommentOutlined />} onClick={() => setConversationOpen(true)}>
                Xem hội thoại
              </Button>
            )}
            {reelId && (
              <Button size="small" icon={<PlayCircleOutlined />} onClick={() => setReelOpen(true)}>
                Xem reel
              </Button>
            )}
          </Space>
        </Descriptions.Item>
        {report.handledBy && (
          <Descriptions.Item label="Người xử lý">
            {report.handledBy.fullName || report.handledBy.username} · {formatDateTime(report.handledAt)}
          </Descriptions.Item>
        )}
      </Descriptions>
      <Typography.Text strong style={{ display: 'block', marginTop: 16, marginBottom: 8 }}>
        Ghi chú xử lý
      </Typography.Text>
      <Input.TextArea
        rows={2}
        value={note}
        maxLength={REPORT_HANDLER_NOTE_MAX}
        onChange={(event) => setNote(event.target.value)}
        placeholder="Ghi chú nội bộ (không gửi cho người dùng)"
      />
      {conversationOpen && conversationId && (
        <ConversationMessagesModal
          conversationId={conversationId}
          around={report.targetId}
          onClose={() => setConversationOpen(false)}
        />
      )}
      <ReelDetailModal reelId={reelOpen && reelId ? reelId : null} onClose={() => setReelOpen(false)} />
    </Modal>
  )
}
