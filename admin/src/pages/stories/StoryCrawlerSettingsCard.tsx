import { useState, type ReactNode } from 'react'
import {
  Alert,
  App,
  Badge,
  Button,
  Card,
  Form,
  Input,
  Segmented,
  Select,
  Space,
  Switch,
  Typography,
  theme,
} from 'antd'
import { DeleteOutlined, PlusOutlined, SaveOutlined } from '@ant-design/icons'
import { useSaveStoryCrawlerSetting } from './useStoryQueries'
import { ApiError, errorMessage } from '@/lib/apiError'
import { formatCount, formatDateTime } from '@/lib/format'
import type {
  StoryCookie,
  StoryCookieStatus,
  StoryCrawlerSetting,
  StoryCrawlerSource,
  StoryCrawlerStatus,
} from '@/types'
import { CRAWLER_SOURCES, INTERVAL_OPTIONS, NEW_COOKIE } from './constants'
import { cleanCookie, deadAtByCookie, sameSnapshot, settingKey } from './utils'
import type { ConfigSnapshot, CrawlerSourceInfo } from './types'

const COOKIE_STATUS_OPTIONS: { value: StoryCookieStatus; label: ReactNode }[] = [
  { value: 'active', label: <Badge status="success" text="Sống" /> },
  { value: 'dead', label: <Badge status="error" text="Die" /> },
]

function SettingRow({
  title,
  description,
  children,
  last,
}: {
  title: string
  description: ReactNode
  children: ReactNode
  last?: boolean
}) {
  const { token } = theme.useToken()
  return (
    <div
      style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        gap: 24,
        padding: '16px 0',
        borderBottom: last ? undefined : `1px solid ${token.colorSplit}`,
      }}
    >
      <div style={{ minWidth: 0 }}>
        <Typography.Text strong>{title}</Typography.Text>
        <div>
          <Typography.Text type="secondary" style={{ fontSize: 13 }}>
            {description}
          </Typography.Text>
        </div>
      </div>
      <div style={{ flexShrink: 0 }}>{children}</div>
    </div>
  )
}

function CookieRow({
  index,
  deadAt,
  placeholder,
  onRemove,
}: {
  index: number
  deadAt: Map<string, string>
  placeholder: string
  onRemove: () => void
}) {
  const form = Form.useFormInstance<StoryCrawlerSetting>()
  const item = Form.useWatch(['cookies', index], form) as Partial<StoryCookie> | undefined
  const diedAt = item?.status === 'dead' ? deadAt.get(cleanCookie(item.cookie)) : undefined

  function reviveIfDead() {
    if (form.getFieldValue(['cookies', index, 'status']) === 'dead') {
      form.setFieldValue(['cookies', index, 'status'], 'active')
    }
  }

  return (
    <div>
      <div style={{ display: 'flex', gap: 8, alignItems: 'flex-start', flexWrap: 'wrap' }}>
        <Form.Item name={[index, 'name']} style={{ marginBottom: 0, width: 160 }}>
          <Input placeholder="Tên tài khoản" maxLength={100} />
        </Form.Item>
        <Form.Item
          name={[index, 'cookie']}
          rules={[{ required: true, whitespace: true, message: 'Dán cookie của tài khoản' }]}
          style={{ marginBottom: 0, flex: '1 1 240px', minWidth: 0 }}
        >
          <Input.Password
            placeholder={placeholder}
            autoComplete="new-password"
            onChange={reviveIfDead}
          />
        </Form.Item>
        <Form.Item name={[index, 'status']} style={{ marginBottom: 0 }}>
          <Select options={COOKIE_STATUS_OPTIONS} style={{ width: 100 }} />
        </Form.Item>
        <Button type="text" danger icon={<DeleteOutlined />} onClick={onRemove} />
      </div>
      {diedAt && (
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          Die lúc {formatDateTime(diedAt)}, dán cookie mới để dùng lại
        </Typography.Text>
      )}
    </div>
  )
}

function CookieList({ cookies, source }: { cookies: StoryCookie[]; source: CrawlerSourceInfo }) {
  const deadAt = deadAtByCookie(cookies)
  return (
    <div style={{ paddingBottom: 16 }}>
      <Form.List name="cookies">
        {(fields, { add, remove }) => (
          <Space orientation="vertical" size={8} style={{ width: '100%' }}>
            {fields.map((field) => (
              <CookieRow
                key={field.key}
                index={field.name}
                deadAt={deadAt}
                placeholder={source.cookiePlaceholder}
                onRemove={() => remove(field.name)}
              />
            ))}
            <Button type="dashed" block icon={<PlusOutlined />} onClick={() => add(NEW_COOKIE)}>
              Thêm cookie
            </Button>
            <Typography.Text type="secondary" style={{ fontSize: 12 }}>
              {source.cookieHelp}
            </Typography.Text>
          </Space>
        )}
      </Form.List>
    </div>
  )
}

export function StoryCrawlerSettingsCard({
  status,
  source,
}: {
  status: StoryCrawlerStatus
  source: StoryCrawlerSource
}) {
  const { message } = App.useApp()
  const [form] = Form.useForm<StoryCrawlerSetting>()
  const values = Form.useWatch([], form)
  const saveSetting = useSaveStoryCrawlerSetting(source)
  const info = CRAWLER_SOURCES[source]
  const latest: ConfigSnapshot = { config: status.config, updatedAt: status.configUpdatedAt }
  const [base, setBase] = useState<ConfigSnapshot>(latest)
  const { config } = base
  const dirty = values !== undefined && settingKey(config) !== settingKey(values)
  const changed = !sameSnapshot(base, latest)
  if (changed && (!dirty || settingKey(values) === settingKey(latest.config))) {
    setBase(latest)
  }

  async function save(next: StoryCrawlerSetting) {
    const deadAt = deadAtByCookie(config.cookies)
    const savedAt = new Date().toISOString()
    try {
      await saveSetting.mutateAsync({
        expectedUpdatedAt: base.updatedAt,
        value: {
          enabled: next.enabled === true,
          intervalHours: next.intervalHours,
          importNewStories: next.importNewStories === true,
          randomUserAgent: next.randomUserAgent === true,
          useCookies: next.useCookies === true,
          cookies: (next.cookies ?? []).map((item) => {
            const cookie = cleanCookie(item.cookie)
            const status: StoryCookieStatus = item.status === 'dead' ? 'dead' : 'active'
            return {
              name: (item.name ?? '').trim(),
              cookie,
              status,
              deadAt: status === 'dead' ? deadAt.get(cookie) ?? savedAt : null,
            }
          }),
        },
      })
      message.success('Đã lưu, có hiệu lực trong vòng 1 phút')
    } catch (err) {
      if (err instanceof ApiError && err.status === 409) {
        message.warning(err.message)
        return
      }
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Card
      title="Cài đặt"
      extra={
        <Button
          type="primary"
          icon={<SaveOutlined />}
          disabled={!dirty}
          loading={saveSetting.isPending}
          onClick={() => form.submit()}
        >
          Lưu
        </Button>
      }
      styles={{ body: { paddingTop: 0, paddingBottom: 0 } }}
    >
      {changed && (
        <Alert
          type="warning"
          showIcon
          style={{ marginTop: 16 }}
          title="Cấu hình trên server vừa thay đổi, ví dụ có cookie vừa bị chuyển sang Die."
          description="Lưu bây giờ sẽ bị từ chối để không ghi đè. Lấy bản mới thì các thay đổi chưa lưu sẽ mất."
          action={
            <Button size="small" onClick={() => setBase(latest)}>
              Lấy bản mới
            </Button>
          }
        />
      )}
      <Form<StoryCrawlerSetting>
        key={`${base.updatedAt ?? ''}:${settingKey(config)}`}
        form={form}
        initialValues={config}
        onFinish={save}
      >
        <SettingRow title="Tự động cập nhật" description={info.enabledHint(status)}>
          <Form.Item name="enabled" valuePropName="checked" noStyle>
            <Switch />
          </Form.Item>
        </SettingRow>
        <SettingRow title="Chu kỳ" description="Khoảng cách giữa 2 lượt chạy tự động.">
          <Form.Item name="intervalHours" noStyle>
            <Segmented options={INTERVAL_OPTIONS} disabled={values?.enabled === false} />
          </Form.Item>
        </SettingRow>
        <SettingRow title="Lấy cả truyện mới" description={info.newStoriesHint(status)}>
          <Form.Item name="importNewStories" valuePropName="checked" noStyle>
            <Switch />
          </Form.Item>
        </SettingRow>
        <SettingRow
          title="User-Agent ngẫu nhiên"
          description={`Mỗi lượt chọn ngẫu nhiên 1 trong ${formatCount(
            status.userAgents,
          )} trình duyệt, cả lượt dùng chung. Tắt thì dùng một User-Agent cố định.`}
        >
          <Form.Item name="randomUserAgent" valuePropName="checked" noStyle>
            <Switch />
          </Form.Item>
        </SettingRow>
        <SettingRow
          last
          title="Dùng cookie đăng nhập"
          description="Mỗi lượt chọn ngẫu nhiên 1 cookie còn sống, cả lượt dùng chung. Cookie bị đăng xuất tự chuyển sang Die và lượt chạy đổi sang cookie khác."
        >
          <Form.Item name="useCookies" valuePropName="checked" noStyle>
            <Switch />
          </Form.Item>
        </SettingRow>
        <CookieList cookies={config.cookies} source={info} />
      </Form>
    </Card>
  )
}
