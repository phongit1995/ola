import { useState, type ReactNode } from 'react'
import { Alert, App, Button, Card, Input, Modal, Space, Switch, Tag, Tooltip, Typography } from 'antd'
import { SendOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import type { AppSetting, ReportAlertChannel, ReportAlertChannelStatus, ReportAlertSettingStatus } from '@/types'
import { useTestReportAlert } from './useReportQueries'
import {
  DISCORD_WEBHOOK_PLACEHOLDER,
  REPORT_ALERT_CHANNEL_LABEL,
  REPORT_ALERT_KEY,
  TELEGRAM_CHAT_ID_PLACEHOLDER,
  TELEGRAM_GET_UPDATES_URL,
  TELEGRAM_TOKEN_PLACEHOLDER,
} from './constants'

const MODAL_TITLE = 'Thông báo báo cáo vi phạm'

interface ReportAlertSettingsModalProps {
  onClose: () => void
}

export function ReportAlertSettingsModal({ onClose }: ReportAlertSettingsModalProps) {
  const { data: settings, isLoading, isError, refetch, isRefetching } = useAppSettings()

  if (isLoading) {
    return <Modal open loading title={MODAL_TITLE} onCancel={onClose} footer={null} />
  }
  if (isError || settings == null) {
    return (
      <Modal open title={MODAL_TITLE} onCancel={onClose} footer={null}>
        <Alert
          type="error"
          showIcon
          message="Không tải được cấu hình hiện tại"
          description="Không thể sửa khi chưa tải được cấu hình, vì lưu lúc này sẽ ghi đè kênh đang chạy."
          action={
            <Button size="small" loading={isRefetching} onClick={() => void refetch()}>
              Thử lại
            </Button>
          }
        />
      </Modal>
    )
  }
  const setting = settings.find((item) => item.key === REPORT_ALERT_KEY)
  return <ReportAlertSettingsForm key={setting?.updatedAt ?? 'empty'} setting={setting} onClose={onClose} />
}

interface ReportAlertSettingsFormProps {
  setting?: AppSetting
  onClose: () => void
}

function ReportAlertSettingsForm({ setting, onClose }: ReportAlertSettingsFormProps) {
  const { message } = App.useApp()
  const putSetting = usePutAppSetting()
  const testAlert = useTestReportAlert()
  const status = (setting?.value ?? {}) as ReportAlertSettingStatus
  const discordStatus = status.discord ?? {}
  const telegramStatus = status.telegram ?? {}
  const savedChatId = telegramStatus.chatId ?? ''
  const initialAdminUrl = status.adminUrl || window.location.origin

  const [discordEnabled, setDiscordEnabled] = useState(discordStatus.enabled === true)
  const [webhookUrl, setWebhookUrl] = useState('')
  const [telegramEnabled, setTelegramEnabled] = useState(telegramStatus.enabled === true)
  const [botToken, setBotToken] = useState('')
  const [chatId, setChatId] = useState(savedChatId)
  const [adminUrl, setAdminUrl] = useState(initialAdminUrl)
  const [testingChannel, setTestingChannel] = useState<ReportAlertChannel | null>(null)

  const dirty =
    discordEnabled !== (discordStatus.enabled === true) ||
    telegramEnabled !== (telegramStatus.enabled === true) ||
    webhookUrl.trim() !== '' ||
    botToken.trim() !== '' ||
    chatId.trim() !== savedChatId ||
    adminUrl.trim() !== initialAdminUrl
  const discordReady = discordStatus.configured === true || webhookUrl.trim() !== ''
  const telegramReady =
    (telegramStatus.configured === true || botToken.trim() !== '') && chatId.trim() !== ''
  const canSave = dirty && (!discordEnabled || discordReady) && (!telegramEnabled || telegramReady)

  async function save() {
    try {
      await putSetting.mutateAsync({
        key: REPORT_ALERT_KEY,
        expectedUpdatedAt: setting?.updatedAt,
        value: {
          adminUrl: adminUrl.trim(),
          discord: { enabled: discordEnabled, webhookUrl: webhookUrl.trim() },
          telegram: { enabled: telegramEnabled, botToken: botToken.trim(), chatId: chatId.trim() },
        },
      })
      message.success('Đã lưu cấu hình thông báo')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  async function sendTest(channel: ReportAlertChannel) {
    setTestingChannel(channel)
    try {
      await testAlert.mutateAsync(channel)
      message.success(`Đã gửi tin thử tới ${REPORT_ALERT_CHANNEL_LABEL[channel]}`)
    } catch (err) {
      message.error(errorMessage(err, 'Gửi thử thất bại'))
    } finally {
      setTestingChannel(null)
    }
  }

  function testButton(channel: ReportAlertChannel, channelStatus: ReportAlertChannelStatus) {
    const blockedReason =
      channelStatus.configured !== true
        ? 'Chưa cấu hình kênh này'
        : dirty
          ? 'Lưu thay đổi trước rồi gửi thử'
          : null
    return (
      <Tooltip title={blockedReason}>
        <Button
          icon={<SendOutlined />}
          loading={testingChannel === channel}
          disabled={blockedReason != null || (testingChannel != null && testingChannel !== channel)}
          onClick={() => void sendTest(channel)}
        >
          Gửi thử
        </Button>
      </Tooltip>
    )
  }

  const footer = (
    <Space>
      <Button onClick={onClose}>Đóng</Button>
      <Button type="primary" loading={putSetting.isPending} disabled={!canSave} onClick={() => void save()}>
        Lưu cấu hình
      </Button>
    </Space>
  )

  return (
    <Modal open title={MODAL_TITLE} onCancel={onClose} footer={footer} width={640} destroyOnHidden>
      <Space direction="vertical" size={16} style={{ width: '100%' }}>
        <Alert
          type="info"
          showIcon
          message="Mỗi báo cáo mới gửi 1 tin tới các kênh đang bật"
          description="Cùng một nội dung bị báo cáo nhiều lần trong 10 phút chỉ gửi 1 tin. Báo cáo tin nhắn 1-1 không gửi nội dung tin nhắn, chỉ báo có báo cáo mới."
        />

        <Space direction="vertical" size={4} style={{ width: '100%' }}>
          <Typography.Text strong>Link trang admin</Typography.Text>
          <Input
            value={adminUrl}
            onChange={(event) => setAdminUrl(event.target.value)}
            placeholder={window.location.origin}
            disabled={putSetting.isPending}
          />
          <Typography.Text type="secondary">
            Nút &quot;Mở trang báo cáo&quot; trong tin sẽ mở {adminUrl.trim() || '—'}/reports
          </Typography.Text>
        </Space>

        <ChannelCard
          label={REPORT_ALERT_CHANNEL_LABEL.discord}
          status={discordStatus}
          enabled={discordEnabled}
          onToggle={setDiscordEnabled}
          disabled={putSetting.isPending}
          action={testButton('discord', discordStatus)}
          help="Vào Cài đặt server → Integrations → Webhooks → New Webhook, chọn kênh nhận rồi bấm Copy Webhook URL."
        >
          <Typography.Text strong>Webhook URL</Typography.Text>
          <Input.Password
            value={webhookUrl}
            onChange={(event) => setWebhookUrl(event.target.value)}
            placeholder={discordStatus.configured ? 'Để trống nếu giữ webhook hiện tại' : DISCORD_WEBHOOK_PLACEHOLDER}
            autoComplete="new-password"
            disabled={putSetting.isPending}
          />
        </ChannelCard>

        <ChannelCard
          label={REPORT_ALERT_CHANNEL_LABEL.telegram}
          status={telegramStatus}
          enabled={telegramEnabled}
          onToggle={setTelegramEnabled}
          disabled={putSetting.isPending}
          action={testButton('telegram', telegramStatus)}
          help={
            <>
              Nhắn <Typography.Text code>@BotFather</Typography.Text> lệnh{' '}
              <Typography.Text code>/newbot</Typography.Text> để lấy bot token. Thêm bot vào nhóm, nhắn 1 câu
              trong nhóm rồi mở <Typography.Text code>{TELEGRAM_GET_UPDATES_URL}</Typography.Text> để xem{' '}
              <Typography.Text code>chat.id</Typography.Text> (nhóm thường là số âm).
            </>
          }
        >
          <Typography.Text strong>Bot token</Typography.Text>
          <Input.Password
            value={botToken}
            onChange={(event) => setBotToken(event.target.value)}
            placeholder={telegramStatus.configured ? 'Để trống nếu giữ token hiện tại' : TELEGRAM_TOKEN_PLACEHOLDER}
            autoComplete="new-password"
            disabled={putSetting.isPending}
          />
          <Typography.Text strong>Chat ID</Typography.Text>
          <Input
            value={chatId}
            onChange={(event) => setChatId(event.target.value)}
            placeholder={TELEGRAM_CHAT_ID_PLACEHOLDER}
            disabled={putSetting.isPending}
          />
        </ChannelCard>
      </Space>
    </Modal>
  )
}

interface ChannelCardProps {
  label: string
  status: ReportAlertChannelStatus
  enabled: boolean
  onToggle: (enabled: boolean) => void
  disabled: boolean
  action: ReactNode
  help: ReactNode
  children: ReactNode
}

function ChannelCard({ label, status, enabled, onToggle, disabled, action, help, children }: ChannelCardProps) {
  return (
    <Card
      size="small"
      title={
        <Space>
          {label}
          {status.configured ? (
            <Tag color="green">Đã cấu hình{status.hint ? ` ••••${status.hint}` : ''}</Tag>
          ) : (
            <Tag>Chưa cấu hình</Tag>
          )}
        </Space>
      }
      extra={
        <Space>
          <Typography.Text type="secondary">{enabled ? 'Đang bật' : 'Đang tắt'}</Typography.Text>
          <Switch checked={enabled} onChange={onToggle} disabled={disabled} />
        </Space>
      }
    >
      <Space direction="vertical" style={{ width: '100%' }}>
        <Typography.Paragraph type="secondary" style={{ marginBottom: 4 }}>
          {help}
        </Typography.Paragraph>
        {children}
        <div>{action}</div>
      </Space>
    </Card>
  )
}
