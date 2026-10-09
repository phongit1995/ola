import { useSearchParams } from 'react-router-dom'
import { App, Button, Card, Form, Spin, Tabs, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { PlatformRulesTable } from '@/components/PlatformRulesTable'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettings'
import { ApiError } from '@/lib/apiError'
import { cleanPlatformRules } from '@/lib/platformRules'
import type { StorySetting } from '@/types'
import { STORY_SETTING_KEY, storySetting } from './storyMeta'
import { StoryCrawlerTab } from './StoryCrawlerTab'

const TAB_KEYS = ['display', 'crawler'] as const
type TabKey = (typeof TAB_KEYS)[number]

export function StorySettingsPage() {
  const [searchParams, setSearchParams] = useSearchParams()
  const tabParam = searchParams.get('tab')
  const activeKey: TabKey = TAB_KEYS.includes(tabParam as TabKey) ? (tabParam as TabKey) : 'display'

  function changeTab(key: string) {
    setSearchParams(key === 'display' ? {} : { tab: key }, { replace: true })
  }

  return (
    <Tabs
      activeKey={activeKey}
      onChange={changeTab}
      destroyOnHidden
      items={[
        { key: 'display', label: 'Hiển thị trên app', children: <StoryDisplaySettings /> },
        { key: 'crawler', label: 'Cập nhật tự động', children: <StoryCrawlerTab /> },
      ]}
    />
  )
}

function StoryDisplaySettings() {
  const { message, modal } = App.useApp()
  const { data: settings, isLoading, isError } = useAppSettings()
  const putSetting = usePutAppSetting()

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
        <Spin />
      </div>
    )
  }

  if (isError) {
    return (
      <Typography.Text type="danger">
        Không tải được cấu hình hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
      </Typography.Text>
    )
  }

  const current = storySetting(settings)

  async function persist(value: StorySetting) {
    try {
      await putSetting.mutateAsync({ key: STORY_SETTING_KEY, value: { ...value } })
      message.success('Đã lưu cài đặt truyện')
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu thất bại')
    }
  }

  function save(values: StorySetting) {
    const value = cleanPlatformRules(values)
    if (current.web.enabled && !value.web.enabled) {
      modal.confirm({
        title: 'Tắt Truyện trên web?',
        content: 'Tab Truyện sẽ biến mất khỏi web và bản desktop ở lần mở app tiếp theo.',
        okText: 'Tắt trên web',
        okButtonProps: { danger: true },
        cancelText: 'Huỷ',
        onOk: () => persist(value),
      })
      return
    }
    void persist(value)
  }

  return (
    <Card style={{ maxWidth: 680 }}>
      <Form<StorySetting> initialValues={current} onFinish={save}>
        <PlatformRulesTable />
        <div
          style={{
            marginTop: 12,
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            gap: 12,
          }}
        >
          <Typography.Text type="secondary" style={{ fontSize: 12 }}>
            So theo tên bản (1.0.0), không tính build. Có hiệu lực ở lần mở app sau.
          </Typography.Text>
          <Button
            type="primary"
            htmlType="submit"
            icon={<SaveOutlined />}
            loading={putSetting.isPending}
          >
            Lưu
          </Button>
        </div>
      </Form>
    </Card>
  )
}
