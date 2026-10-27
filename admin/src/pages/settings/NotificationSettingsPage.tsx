import { useState } from 'react'
import { useSearchParams } from 'react-router-dom'
import {
  App,
  Button,
  Card,
  Descriptions,
  Input,
  Spin,
  Switch,
  Tabs,
  Tag,
  Typography,
  Upload,
} from 'antd'
import { InboxOutlined, SaveOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import type { AppSetting, PushFirebaseSettingStatus, PushNotificationSetting } from '@/types'
import { formatDateTime } from '@/lib/format'
import {
  CREDENTIAL_KEY,
  MAIL_KEY,
  NOTIFICATION_DEFAULT_TAB,
  NOTIFICATION_TAB_KEYS,
  TOGGLE_KEY,
} from './constants'
import { MailSettingsCard } from './MailSettingsCard'
import { parseServiceAccount } from './utils'

type TabKey = (typeof NOTIFICATION_TAB_KEYS)[number]

export function NotificationSettingsPage() {
  const [searchParams, setSearchParams] = useSearchParams()
  const tabParam = searchParams.get('tab')
  const activeKey: TabKey = NOTIFICATION_TAB_KEYS.includes(tabParam as TabKey)
    ? (tabParam as TabKey)
    : NOTIFICATION_DEFAULT_TAB
  const { data: settings, isLoading, isError } = useAppSettings()

  function changeTab(key: string) {
    setSearchParams(key === NOTIFICATION_DEFAULT_TAB ? {} : { tab: key }, { replace: true })
  }

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 64 }}>
        <Spin />
      </div>
    )
  }

  if (isError) {
    return (
      <Card title="Cài đặt thông báo" style={{ maxWidth: 680 }}>
        <Typography.Text type="danger">
          Không tải được cấu hình hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
        </Typography.Text>
      </Card>
    )
  }

  return (
    <Tabs
      activeKey={activeKey}
      onChange={changeTab}
      destroyOnHidden
      items={[
        {
          key: 'push',
          label: 'Thông báo đẩy (FCM)',
          children: <PushSettingsCard settings={settings} />,
        },
        {
          key: 'email',
          label: 'Email (Resend)',
          children: <MailSettingsCard setting={settings?.find((item) => item.key === MAIL_KEY)} />,
        },
      ]}
    />
  )
}

function PushSettingsCard({ settings }: { settings?: AppSetting[] }) {
  const { message } = App.useApp()
  const putSetting = usePutAppSetting()
  const [pasted, setPasted] = useState('')

  const credential = settings?.find((item) => item.key === CREDENTIAL_KEY)
  const status = (credential?.value ?? null) as PushFirebaseSettingStatus | null
  const toggle = settings?.find((item) => item.key === TOGGLE_KEY)
  const enabled = (toggle?.value as PushNotificationSetting | undefined)?.enabled === true

  async function setEnabled(next: boolean) {
    try {
      await putSetting.mutateAsync({ key: TOGGLE_KEY, value: { enabled: next } })
      message.success(next ? 'Đã bật gửi thông báo đẩy' : 'Đã tắt gửi thông báo đẩy')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  async function saveCredential(text: string) {
    let value: Record<string, unknown>
    try {
      value = parseServiceAccount(text)
    } catch (err) {
      message.error(err instanceof Error ? err.message : 'JSON không hợp lệ')
      return
    }
    try {
      await putSetting.mutateAsync({ key: CREDENTIAL_KEY, value })
      setPasted('')
      message.success('Đã lưu Firebase service account. Server áp dụng trong tối đa 1 phút.')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Card style={{ maxWidth: 680 }}>
      <Typography.Paragraph type="secondary">
        Push chỉ được gửi khi công tắc bên dưới đang bật VÀ đã upload service account JSON của
        Firebase (Project settings → Service accounts → Generate new private key). Key được mã hoá
        trước khi lưu và không hiển thị lại sau khi lưu.
      </Typography.Paragraph>

      <Descriptions column={1} bordered size="small" style={{ marginBottom: 16 }}>
        <Descriptions.Item label="Gửi thông báo đẩy">
          <Switch
            checked={enabled}
            loading={putSetting.isPending}
            onChange={(next) => void setEnabled(next)}
          />
        </Descriptions.Item>
        <Descriptions.Item label="Service account">
          {status?.configured ? <Tag color="green">Đã cấu hình</Tag> : <Tag>Chưa cấu hình</Tag>}
        </Descriptions.Item>
        {status?.configured && (
          <>
            <Descriptions.Item label="Project">{status.projectId || '—'}</Descriptions.Item>
            <Descriptions.Item label="Email">{status.clientEmail || '—'}</Descriptions.Item>
            <Descriptions.Item label="Cập nhật lần cuối">
              {credential?.updatedAt
                ? formatDateTime(credential.updatedAt)
                : '—'}
            </Descriptions.Item>
          </>
        )}
      </Descriptions>

      <Upload.Dragger
        accept=".json,application/json"
        maxCount={1}
        showUploadList={false}
        disabled={putSetting.isPending}
        beforeUpload={(file) => {
          void file.text().then(saveCredential)
          return false
        }}
      >
        <p className="ant-upload-drag-icon">
          <InboxOutlined />
        </p>
        <p className="ant-upload-text">Kéo thả hoặc bấm để chọn file service account .json</p>
      </Upload.Dragger>

      <Typography.Paragraph type="secondary" style={{ marginTop: 16, marginBottom: 8 }}>
        Hoặc dán nội dung JSON:
      </Typography.Paragraph>
      <Input.TextArea
        rows={5}
        value={pasted}
        onChange={(e) => setPasted(e.target.value)}
        placeholder='{"type": "service_account", "project_id": "...", ...}'
        disabled={putSetting.isPending}
      />
      <Button
        type="primary"
        icon={<SaveOutlined />}
        loading={putSetting.isPending}
        disabled={pasted.trim() === ''}
        onClick={() => void saveCredential(pasted)}
        style={{ marginTop: 12 }}
      >
        Lưu service account
      </Button>
    </Card>
  )
}
