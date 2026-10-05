import { App, Button, Card, Form, Select, Spin, Switch, Table, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettings'
import { ApiError } from '@/lib/apiError'
import type { StoryPlatform, StoryPlatformRule, StorySetting } from '@/types'
import {
  STORY_DISABLE_VERSIONS_MAX,
  STORY_PLATFORMS,
  STORY_SETTING_KEY,
  STORY_VERSION_PATTERN,
  storySetting,
} from './storyMeta'

type PlatformRow = (typeof STORY_PLATFORMS)[number]

function cleanVersions(versions: string[] | undefined): string[] {
  const seen = new Set<string>()
  return (versions ?? [])
    .map((version) => version.trim())
    .filter((version) => {
      if (version === '' || seen.has(version)) return false
      seen.add(version)
      return true
    })
}

function cleanRule(rule: Partial<StoryPlatformRule> | undefined, versioned: boolean): StoryPlatformRule {
  return {
    enabled: rule?.enabled === true,
    disableVersions: versioned ? cleanVersions(rule?.disableVersions) : [],
  }
}

function validateVersions(_: unknown, versions: string[] | undefined) {
  const cleaned = cleanVersions(versions)
  const invalid = cleaned.find((version) => !STORY_VERSION_PATTERN.test(version))
  if (invalid) return Promise.reject(new Error(`"${invalid}" không đúng dạng 1.0.0`))
  if (cleaned.length > STORY_DISABLE_VERSIONS_MAX) {
    return Promise.reject(new Error(`Tối đa ${STORY_DISABLE_VERSIONS_MAX} bản`))
  }
  return Promise.resolve()
}

function DisableVersionsCell({ platform }: { platform: StoryPlatform }) {
  const form = Form.useFormInstance<StorySetting>()
  const enabled = Form.useWatch<boolean | undefined>([platform, 'enabled'], form)
  return (
    <Form.Item
      name={[platform, 'disableVersions']}
      rules={[{ validator: validateVersions }]}
      style={{ marginBottom: 0 }}
    >
      <Select
        mode="tags"
        tokenSeparators={[',', ' ']}
        open={false}
        suffixIcon={null}
        placeholder="Nhập bản rồi Enter, VD 1.0.1"
        disabled={!enabled}
      />
    </Form.Item>
  )
}

const COLUMNS = [
  { title: 'Nền tảng', dataIndex: 'label', width: 110 },
  {
    title: 'Hiện',
    key: 'enabled',
    width: 80,
    render: (_: unknown, row: PlatformRow) => (
      <Form.Item name={[row.key, 'enabled']} valuePropName="checked" noStyle>
        <Switch />
      </Form.Item>
    ),
  },
  {
    title: 'Tắt riêng các bản',
    key: 'disableVersions',
    render: (_: unknown, row: PlatformRow) =>
      row.versioned ? (
        <DisableVersionsCell platform={row.key} />
      ) : (
        <Typography.Text type="secondary">Không áp dụng</Typography.Text>
      ),
  },
]

export function StorySettingsPage() {
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
    const value: StorySetting = {
      web: cleanRule(values.web, false),
      android: cleanRule(values.android, true),
      ios: cleanRule(values.ios, true),
    }
    if (current.web.enabled && !value.web.enabled) {
      modal.confirm({
        title: 'Tắt Truyện trên web?',
        content: 'Tab RSS (Truyện) sẽ biến mất khỏi web và bản desktop ở lần mở app tiếp theo.',
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
        <Table<PlatformRow>
          rowKey="key"
          size="small"
          pagination={false}
          columns={COLUMNS}
          dataSource={STORY_PLATFORMS}
        />
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
