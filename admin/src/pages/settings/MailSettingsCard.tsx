import { useState } from 'react'
import { App, Button, Card, Descriptions, Divider, Input, Space, Tag, Typography } from 'antd'
import { SaveOutlined, SendOutlined } from '@ant-design/icons'
import { usePutAppSetting, useTestMail } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import { formatDateTime } from '@/lib/format'
import type { AppSetting, MailResendSettingStatus } from '@/types'
import { MAIL_DEFAULT_FROM, MAIL_KEY } from './constants'

export function MailSettingsCard({ setting }: { setting?: AppSetting }) {
  const { message } = App.useApp()
  const putSetting = usePutAppSetting()
  const testMail = useTestMail()
  const status = (setting?.value ?? null) as MailResendSettingStatus | null
  const configured = status?.configured === true
  const [apiKey, setApiKey] = useState('')
  const [from, setFrom] = useState(status?.from || MAIL_DEFAULT_FROM)
  const [testTo, setTestTo] = useState('')

  async function save() {
    try {
      await putSetting.mutateAsync({
        key: MAIL_KEY,
        value: { apiKey: apiKey.trim(), from: from.trim() },
      })
      setApiKey('')
      message.success('Đã lưu cấu hình email')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  async function sendTest() {
    const to = testTo.trim()
    try {
      await testMail.mutateAsync(to)
      message.success(`Đã gửi email thử tới ${to}`)
    } catch (err) {
      message.error(errorMessage(err, 'Gửi email thử thất bại'))
    }
  }

  return (
    <Card style={{ maxWidth: 680 }}>
      <Typography.Paragraph type="secondary">
        Dùng để gửi mã xác thực email và mã đặt lại mật khẩu. Lấy API key ở Resend → API Keys. Key
        được mã hoá trước khi lưu và không hiển thị lại sau khi lưu. Chưa cấu hình thì người dùng
        không nhận được email xác thực và mã đặt lại mật khẩu.
      </Typography.Paragraph>

      <Descriptions column={1} bordered size="small" style={{ marginBottom: 16 }}>
        <Descriptions.Item label="API key">
          {configured ? <Tag color="green">Đã cấu hình</Tag> : <Tag>Chưa cấu hình</Tag>}
          {configured && status?.keyHint && (
            <Typography.Text code>re_••••{status.keyHint}</Typography.Text>
          )}
        </Descriptions.Item>
        {configured && (
          <>
            <Descriptions.Item label="Người gửi">{status?.from || '—'}</Descriptions.Item>
            <Descriptions.Item label="Cập nhật lần cuối">
              {setting?.updatedAt ? formatDateTime(setting.updatedAt) : '—'}
            </Descriptions.Item>
          </>
        )}
      </Descriptions>

      <Space direction="vertical" style={{ width: '100%' }}>
        <Typography.Text strong>API key</Typography.Text>
        <Input.Password
          value={apiKey}
          onChange={(e) => setApiKey(e.target.value)}
          placeholder={configured ? 'Để trống nếu giữ key hiện tại' : 're_...'}
          autoComplete="new-password"
          disabled={putSetting.isPending}
        />
        <Typography.Text strong>Người gửi</Typography.Text>
        <Input
          value={from}
          onChange={(e) => setFrom(e.target.value)}
          placeholder={MAIL_DEFAULT_FROM}
          disabled={putSetting.isPending}
        />
        <Button
          type="primary"
          icon={<SaveOutlined />}
          loading={putSetting.isPending}
          disabled={from.trim() === '' || (!configured && apiKey.trim() === '')}
          onClick={() => void save()}
        >
          Lưu cấu hình email
        </Button>
      </Space>

      <Divider />

      <Typography.Paragraph type="secondary" style={{ marginBottom: 8 }}>
        Gửi thử bằng cấu hình đang dùng để kiểm tra key và địa chỉ người gửi:
      </Typography.Paragraph>
      <Space.Compact style={{ width: '100%' }}>
        <Input
          type="email"
          value={testTo}
          onChange={(e) => setTestTo(e.target.value)}
          placeholder="email nhận thử"
          disabled={testMail.isPending}
        />
        <Button
          icon={<SendOutlined />}
          loading={testMail.isPending}
          disabled={testTo.trim() === ''}
          onClick={() => void sendTest()}
        >
          Gửi email thử
        </Button>
      </Space.Compact>
    </Card>
  )
}
