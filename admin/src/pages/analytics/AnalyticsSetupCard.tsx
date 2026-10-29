import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Alert, App, Button, Input, Space, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { errorMessage } from '@/lib/apiError'
import type { AnalyticsSetup } from '@/types'
import { GA_DATA_API_URL, GA_HOME_URL, PUSH_SETTINGS_PATH } from './constants'
import { useSaveAnalyticsSetting } from './useAnalyticsQueries'
import { serviceAccountProject } from './utils'

interface AnalyticsSetupCardProps {
  setup: AnalyticsSetup
  onSaved?: () => void
}

export function AnalyticsSetupCard({ setup, onSaved }: AnalyticsSetupCardProps) {
  const { message } = App.useApp()
  const navigate = useNavigate()
  const save = useSaveAnalyticsSetting()
  const [mobilePropertyId, setMobilePropertyId] = useState(setup.mobilePropertyId)
  const [webPropertyId, setWebPropertyId] = useState(setup.webPropertyId)
  const project = serviceAccountProject(setup.clientEmail)

  async function submit() {
    try {
      await save.mutateAsync({
        mobilePropertyId: mobilePropertyId.trim(),
        webPropertyId: webPropertyId.trim(),
      })
      message.success('Đã lưu cấu hình Analytics')
      onSaved?.()
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  if (!setup.credentialConfigured) {
    return (
      <Alert
        type="warning"
        showIcon
        title="Chưa có file service account Firebase"
        description="Analytics dùng chung file service account đã tải lên cho thông báo đẩy. Tải file đó lên trước rồi quay lại đây."
        action={
          <Button size="small" onClick={() => navigate(PUSH_SETTINGS_PATH)}>
            Mở cài đặt thông báo
          </Button>
        }
      />
    )
  }

  return (
    <Space orientation="vertical" size={16} style={{ width: '100%' }}>
      <ol style={{ paddingLeft: 20, margin: 0, lineHeight: 1.9 }}>
        <li>
          Bật{' '}
          <Typography.Link href={`${GA_DATA_API_URL}?project=${project}`} target="_blank">
            Google Analytics Data API
          </Typography.Link>{' '}
          trong Google Cloud project <Typography.Text code>{project}</Typography.Text>.
        </li>
        <li>
          Trong{' '}
          <Typography.Link href={GA_HOME_URL} target="_blank">
            Google Analytics
          </Typography.Link>
          , mở property của mobile và của web, vào Admin → Property access management, thêm email
          dưới đây với quyền <Typography.Text strong>Viewer</Typography.Text>:
          <div>
            <Typography.Text code copyable>
              {setup.clientEmail}
            </Typography.Text>
          </div>
        </li>
        <li>
          Lấy Property ID ở Admin → Property details (một dãy số, không phải mã G-XXXX) và nhập vào
          bên dưới. Để trống nền tảng nào chưa dùng. Nếu app và web chung một property thì nhập cùng
          một ID vào cả hai ô.
        </li>
      </ol>

      <Space orientation="vertical" style={{ width: '100%' }}>
        <Typography.Text strong>Property ID mobile (Android + iOS)</Typography.Text>
        <Input
          value={mobilePropertyId}
          onChange={(e) => setMobilePropertyId(e.target.value)}
          placeholder="ví dụ 412345678"
          inputMode="numeric"
          disabled={save.isPending}
        />
        <Typography.Text strong>Property ID web</Typography.Text>
        <Input
          value={webPropertyId}
          onChange={(e) => setWebPropertyId(e.target.value)}
          placeholder="ví dụ 498765432"
          inputMode="numeric"
          disabled={save.isPending}
        />
        <Button
          type="primary"
          icon={<SaveOutlined />}
          loading={save.isPending}
          disabled={mobilePropertyId.trim() === '' && webPropertyId.trim() === ''}
          onClick={() => void submit()}
        >
          Lưu cấu hình
        </Button>
      </Space>
    </Space>
  )
}
