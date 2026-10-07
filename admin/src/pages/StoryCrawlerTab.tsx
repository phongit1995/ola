import { useState, type ReactNode } from 'react'
import {
  Alert,
  App,
  Badge,
  Button,
  Card,
  Col,
  Drawer,
  Form,
  Input,
  Progress,
  Row,
  Segmented,
  Select,
  Space,
  Spin,
  Switch,
  Table,
  Tag,
  Typography,
  theme,
  type TableColumnsType,
} from 'antd'
import {
  CaretRightOutlined,
  DeleteOutlined,
  HistoryOutlined,
  PlusOutlined,
  ReloadOutlined,
  SaveOutlined,
} from '@ant-design/icons'
import {
  useRefreshStoriesAfterCrawl,
  useRunStoryCrawler,
  useSaveStoryCrawlerSetting,
  useStoryCrawler,
} from '@/hooks/useStories'
import { ApiError } from '@/lib/apiError'
import { formatDateTime } from '@/lib/format'
import type {
  StoryCrawlError,
  StoryCookie,
  StoryCookieStatus,
  StoryCrawlLog,
  StoryCrawlStatus,
  StoryCrawlTrigger,
  StoryCrawlerSetting,
  StoryCrawlerStatus,
} from '@/types'

const INTERVAL_OPTIONS = [1, 2, 3, 6, 12, 24].map((hours) => ({
  value: hours,
  label: `${hours} giờ`,
}))

const HISTORY_DRAWER_WIDTH = 1100

const STATUS_TAG: Record<StoryCrawlStatus, { label: string; color: string }> = {
  running: { label: 'Đang chạy', color: 'processing' },
  success: { label: 'Thành công', color: 'success' },
  partial: { label: 'Có lỗi', color: 'warning' },
  blocked: { label: 'Bị chặn', color: 'error' },
  failed: { label: 'Thất bại', color: 'error' },
}

const TRIGGER_LABEL: Record<StoryCrawlTrigger, string> = {
  schedule: 'Tự động',
  manual: 'Thủ công',
}

const COOKIE_STATUS_OPTIONS: { value: StoryCookieStatus; label: ReactNode }[] = [
  { value: 'active', label: <Badge status="success" text="Sống" /> },
  { value: 'dead', label: <Badge status="error" text="Die" /> },
]

const NEW_COOKIE: StoryCookie = { name: '', cookie: '', status: 'active', deadAt: null }

const formatCount = (value: number) => value.toLocaleString('vi-VN')

const cleanCookie = (value: string | undefined) => (value ?? '').trim().replace(/^cookie:\s*/i, '')

function formatDuration(ms: number): string {
  const seconds = Math.round(ms / 1000)
  if (seconds < 60) return `${seconds} giây`
  const minutes = Math.floor(seconds / 60)
  const rest = seconds % 60
  return rest === 0 ? `${minutes} phút` : `${minutes} phút ${rest} giây`
}

function changeParts(log: StoryCrawlLog): string[] {
  const parts = log.chaptersAdded > 0 ? [`+${formatCount(log.chaptersAdded)} chương`] : []
  if (log.storiesUpdated > 0) parts.push(`${formatCount(log.storiesUpdated)} truyện cập nhật`)
  if (log.storiesCreated > 0) parts.push(`${formatCount(log.storiesCreated)} truyện mới`)
  if (log.storiesFailed > 0) parts.push(`${formatCount(log.storiesFailed)} lỗi`)
  return parts
}

function runSummary(log: StoryCrawlLog): string {
  const parts = changeParts(log)
  return parts.length > 0 ? parts.join(' · ') : 'Không có gì mới'
}

function StatusTag({ status }: { status: StoryCrawlStatus }) {
  return <Tag color={STATUS_TAG[status].color}>{STATUS_TAG[status].label}</Tag>
}

function Count({ value, strong }: { value: number; strong?: boolean }) {
  if (value === 0) return <Typography.Text type="secondary">0</Typography.Text>
  return (
    <Typography.Text strong={strong} type={strong ? 'success' : undefined}>
      {formatCount(value)}
    </Typography.Text>
  )
}

const COLUMNS: TableColumnsType<StoryCrawlLog> = [
  {
    title: 'Bắt đầu',
    key: 'startedAt',
    width: 150,
    render: (_, log) => (
      <Space orientation="vertical" size={0}>
        <Typography.Text>{formatDateTime(log.startedAt)}</Typography.Text>
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          {TRIGGER_LABEL[log.trigger]}
        </Typography.Text>
      </Space>
    ),
  },
  {
    title: 'Trạng thái',
    key: 'status',
    width: 110,
    render: (_, log) => (
      <Space orientation="vertical" size={0}>
        <StatusTag status={log.status} />
        {log.cookiesDied && log.cookiesDied.length > 0 && (
          <Typography.Text type="warning" style={{ fontSize: 12 }}>
            {formatCount(log.cookiesDied.length)} cookie die
          </Typography.Text>
        )}
      </Space>
    ),
  },
  {
    title: 'Truyện',
    children: [
      {
        title: 'Kiểm tra',
        dataIndex: 'storiesChecked',
        align: 'right',
        render: (value: number) => <Count value={value} />,
      },
      {
        title: 'Không đổi',
        dataIndex: 'storiesUnchanged',
        align: 'right',
        render: (value: number) => <Count value={value} />,
      },
      {
        title: 'Cập nhật',
        dataIndex: 'storiesUpdated',
        align: 'right',
        render: (value: number) => <Count value={value} strong />,
      },
      {
        title: 'Mới',
        dataIndex: 'storiesCreated',
        align: 'right',
        render: (value: number) => <Count value={value} strong />,
      },
      {
        title: 'Bỏ qua mới',
        dataIndex: 'storiesSkippedNew',
        align: 'right',
        render: (value: number) => <Count value={value} />,
      },
    ],
  },
  {
    title: 'Chương',
    children: [
      {
        title: 'Mới',
        dataIndex: 'chaptersAdded',
        align: 'right',
        render: (value: number) => <Count value={value} strong />,
      },
      {
        title: 'Sửa / xoá',
        key: 'chaptersChanged',
        align: 'right',
        render: (_, log) => (
          <Typography.Text
            type={log.chaptersUpdated + log.chaptersRemoved === 0 ? 'secondary' : undefined}
          >
            {formatCount(log.chaptersUpdated)} / {formatCount(log.chaptersRemoved)}
          </Typography.Text>
        ),
      },
    ],
  },
  {
    title: 'Lỗi',
    dataIndex: 'storiesFailed',
    align: 'right',
    render: (value: number) =>
      value === 0 ? (
        <Typography.Text type="secondary">0</Typography.Text>
      ) : (
        <Typography.Text type="danger">{formatCount(value)}</Typography.Text>
      ),
  },
  {
    title: 'Thời gian',
    key: 'duration',
    width: 120,
    render: (_, log) => (
      <Space orientation="vertical" size={0}>
        <Typography.Text>{log.finishedAt ? formatDuration(log.durationMs) : '—'}</Typography.Text>
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          {formatCount(log.requests)} request
        </Typography.Text>
      </Space>
    ),
  },
]

function retryNote(error: StoryCrawlError): string {
  return error.willRetry
    ? `sẽ thử lại ở lượt sau (đã thử ${error.attempts} lần)`
    : `đã thử ${error.attempts} lần, bỏ qua đến khi truyện được sửa lại`
}

function LogDetail({ log }: { log: StoryCrawlLog }) {
  const hiddenErrors = log.storiesFailed - log.errors.length
  return (
    <Space orientation="vertical" size={4}>
      <Typography.Text type="secondary">
        Lấy {formatCount(log.postsFound)} bài sửa gần nhất sau {formatDateTime(log.since)}, đã
        xử lý {formatCount(log.postsProcessed)}
        {log.truncated ? ' (khoảng này còn bài sửa cũ hơn, không lấy)' : ''}
        {log.storiesUnchanged > 0 ? ` · ${formatCount(log.storiesUnchanged)} truyện không đổi` : ''}
        {log.retried > 0 ? ` · thử lại ${formatCount(log.retried)} truyện lỗi lượt trước` : ''} ·{' '}
        {log.importNewStories ? 'có lấy truyện mới' : 'chỉ cập nhật truyện đã có'}
        {log.storiesEmpty > 0
          ? ` · ${formatCount(log.storiesEmpty)} truyện mới chưa có chương`
          : ''}
      </Typography.Text>
      {log.userAgent && (
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          User-Agent: <Typography.Text code>{log.userAgent}</Typography.Text>
        </Typography.Text>
      )}
      {log.useCookies && (
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          Cookie:{' '}
          {log.cookie ? (
            <Typography.Text code>{log.cookie}</Typography.Text>
          ) : (
            'không còn cookie sống, chạy không đăng nhập'
          )}
        </Typography.Text>
      )}
      {log.cookiesDied && log.cookiesDied.length > 0 && (
        <Typography.Text type="warning">
          Cookie bị đăng xuất, đã chuyển sang Die: {log.cookiesDied.join(', ')}
        </Typography.Text>
      )}
      {log.message && <Typography.Text type="danger">{log.message}</Typography.Text>}
      {log.errors.map((error) => (
        <Typography.Text key={error.sourceStoryId}>
          <Typography.Text type="secondary">#{error.sourceStoryId}</Typography.Text> {error.title}:{' '}
          <Typography.Text type="danger">{error.message}</Typography.Text>
          {error.attempts > 0 && (
            <Typography.Text type="secondary"> · {retryNote(error)}</Typography.Text>
          )}
        </Typography.Text>
      ))}
      {hiddenErrors > 0 && (
        <Typography.Text type="secondary">
          … và {formatCount(hiddenErrors)} truyện lỗi khác
        </Typography.Text>
      )}
    </Space>
  )
}

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

function InfoRow({ label, children }: { label: string; children: ReactNode }) {
  return (
    <div style={{ display: 'flex', justifyContent: 'space-between', gap: 16, padding: '6px 0' }}>
      <Typography.Text type="secondary">{label}</Typography.Text>
      <Typography.Text style={{ textAlign: 'right' }}>{children}</Typography.Text>
    </div>
  )
}

function settingKey(value: Partial<StoryCrawlerSetting>): string {
  return JSON.stringify([
    value.enabled === true,
    value.intervalHours,
    value.importNewStories === true,
    value.randomUserAgent === true,
    value.useCookies === true,
    (value.cookies ?? []).map((item) => [
      (item?.name ?? '').trim(),
      cleanCookie(item?.cookie),
      item?.status ?? 'active',
    ]),
  ])
}

function deadAtByCookie(cookies: StoryCookie[]): Map<string, string> {
  const result = new Map<string, string>()
  for (const item of cookies) {
    if (item.status === 'dead' && item.deadAt) result.set(cleanCookie(item.cookie), item.deadAt)
  }
  return result
}

function CookieRow({
  index,
  deadAt,
  onRemove,
}: {
  index: number
  deadAt: Map<string, string>
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
            placeholder="wordpress_logged_in_…=…"
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

function CookieList({ cookies }: { cookies: StoryCookie[] }) {
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
                onRemove={() => remove(field.name)}
              />
            ))}
            <Button type="dashed" block icon={<PlusOutlined />} onClick={() => add(NEW_COOKIE)}>
              Thêm cookie
            </Button>
            <Typography.Text type="secondary" style={{ fontSize: 12 }}>
              Đăng nhập vnkings.com trên trình duyệt, mở F12 → Network, chọn một request tới
              vnkings.com và copy nguyên giá trị header Cookie.
            </Typography.Text>
          </Space>
        )}
      </Form.List>
    </div>
  )
}

interface ConfigSnapshot {
  config: StoryCrawlerSetting
  updatedAt: string | null
}

function sameSnapshot(a: ConfigSnapshot, b: ConfigSnapshot): boolean {
  return a.updatedAt === b.updatedAt && settingKey(a.config) === settingKey(b.config)
}

function SettingsCard({ status }: { status: StoryCrawlerStatus }) {
  const { message } = App.useApp()
  const [form] = Form.useForm<StoryCrawlerSetting>()
  const values = Form.useWatch([], form)
  const saveSetting = useSaveStoryCrawlerSetting()
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
      message.error(err instanceof ApiError ? err.message : 'Lưu thất bại')
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
        <SettingRow
          title="Tự động cập nhật"
          description={`Mỗi lượt lấy ${status.scanLimit} truyện sửa gần nhất trong ${status.scanDays} ngày trên vnkings, chỉ tải lại truyện có giờ sửa mới hơn bản đã lưu để thêm chương mới.`}
        >
          <Form.Item name="enabled" valuePropName="checked" noStyle>
            <Switch />
          </Form.Item>
        </SettingRow>
        <SettingRow title="Chu kỳ" description="Khoảng cách giữa 2 lượt chạy tự động.">
          <Form.Item name="intervalHours" noStyle>
            <Segmented options={INTERVAL_OPTIONS} disabled={values?.enabled === false} />
          </Form.Item>
        </SettingRow>
        <SettingRow
          title="Lấy cả truyện mới"
          description={`Tắt: chỉ thêm chương cho truyện đã có. Bật: truyện mới nằm trong ${status.scanLimit} truyện sửa gần nhất (${status.scanDays} ngày) được thêm và hiện ngay trong app.`}
        >
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
        <CookieList cookies={config.cookies} />
      </Form>
    </Card>
  )
}

function CookieSummary({ cookies }: { cookies: StoryCookie[] }) {
  const alive = cookies.filter((item) => item.status === 'active').length
  const dead = cookies.length - alive
  return (
    <InfoRow label="Cookie">
      {alive === 0 ? (
        <Typography.Text type="danger">Hết cookie sống, chạy không đăng nhập</Typography.Text>
      ) : (
        <>
          <Typography.Text type="success">{formatCount(alive)} sống</Typography.Text>
          {dead > 0 && <Typography.Text type="danger"> · {formatCount(dead)} die</Typography.Text>}
        </>
      )}
    </InfoRow>
  )
}

function StatusCard({
  status,
  onOpenHistory,
}: {
  status: StoryCrawlerStatus
  onOpenHistory: () => void
}) {
  const { message } = App.useApp()
  const run = useRunStoryCrawler()
  const { config, progress } = status
  const lastRun = status.logs[0]
  const percent =
    progress && progress.postsFound > 0
      ? Math.round((progress.postsProcessed * 100) / progress.postsFound)
      : 0

  async function runNow() {
    try {
      await run.mutateAsync()
      message.success('Đã bắt đầu cập nhật ở nền')
    } catch (err) {
      if (err instanceof ApiError && err.status === 409) {
        message.warning('Đang có một lượt cập nhật chạy')
        return
      }
      message.error(err instanceof ApiError ? err.message : 'Không chạy được')
    }
  }

  let badge = <Badge status="default" text="Đang tắt tự động" />
  if (status.running) badge = <Badge status="processing" text="Đang chạy" />
  else if (config.enabled)
    badge = <Badge status="success" text={`Đang bật · mỗi ${config.intervalHours} giờ`} />

  return (
    <Card title="Trạng thái" extra={badge}>
      {status.running && progress && (
        <div style={{ marginBottom: 12 }}>
          <Progress percent={percent} size="small" status="active" />
          <Typography.Text type="secondary" style={{ fontSize: 13 }}>
            {[
              `${formatCount(progress.postsProcessed)}/${formatCount(progress.postsFound)} bài`,
              ...changeParts(progress),
            ].join(' · ')}
          </Typography.Text>
        </div>
      )}
      <InfoRow label="Lần chạy gần nhất">{formatDateTime(status.lastRunAt)}</InfoRow>
      <InfoRow label="Lần chạy kế">
        {config.enabled ? formatDateTime(status.nextRunAt) : 'Không có lịch'}
      </InfoRow>
      <InfoRow label="Phạm vi quét">
        {status.scanLimit} truyện sửa gần nhất trong {status.scanDays} ngày
      </InfoRow>
      {status.retryPending > 0 && (
        <InfoRow label="Chờ thử lại">
          <Typography.Text type="warning">
            {formatCount(status.retryPending)} truyện lỗi
          </Typography.Text>
        </InfoRow>
      )}
      {config.useCookies && <CookieSummary cookies={config.cookies} />}
      {lastRun && !status.running && (
        <InfoRow label="Kết quả gần nhất">
          <StatusTag status={lastRun.status} />
          {runSummary(lastRun)}
        </InfoRow>
      )}
      <div style={{ display: 'flex', gap: 8, marginTop: 16 }}>
        <Button
          type="primary"
          icon={<CaretRightOutlined />}
          loading={run.isPending}
          disabled={status.running}
          onClick={runNow}
          style={{ flex: 1 }}
        >
          {status.running ? 'Đang chạy' : 'Chạy ngay'}
        </Button>
        <Button icon={<HistoryOutlined />} onClick={onOpenHistory} style={{ flex: 1 }}>
          Xem log ({formatCount(status.logs.length)})
        </Button>
      </div>
    </Card>
  )
}

export function StoryCrawlerTab() {
  const { data: status, isLoading, isError, isFetching, refetch } = useStoryCrawler()
  const [historyOpen, setHistoryOpen] = useState(false)
  useRefreshStoriesAfterCrawl(status ? status.logs[0]?.id ?? '' : undefined)

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
        <Spin />
      </div>
    )
  }

  if (isError || !status) {
    return (
      <Typography.Text type="danger">
        Không tải được cấu hình tự động cập nhật. Tải lại trang trước khi chỉnh sửa.
      </Typography.Text>
    )
  }

  const rows = status.running && status.progress ? [status.progress, ...status.logs] : status.logs

  return (
    <>
      <Row gutter={[16, 16]} align="top">
        <Col xs={24} xl={15}>
          <SettingsCard status={status} />
        </Col>
        <Col xs={24} xl={9}>
          <StatusCard status={status} onOpenHistory={() => setHistoryOpen(true)} />
        </Col>
      </Row>
      <Drawer
        open={historyOpen}
        onClose={() => setHistoryOpen(false)}
        size={HISTORY_DRAWER_WIDTH}
        title="Log các lượt cập nhật"
        extra={
          <Button icon={<ReloadOutlined />} loading={isFetching} onClick={() => void refetch()}>
            Tải lại
          </Button>
        }
      >
        <Table<StoryCrawlLog>
          rowKey="id"
          size="small"
          columns={COLUMNS}
          dataSource={rows}
          pagination={false}
          scroll={{ x: 960 }}
          expandable={{ expandedRowRender: (log) => <LogDetail log={log} /> }}
          locale={{ emptyText: 'Chưa có lượt cập nhật nào' }}
        />
      </Drawer>
    </>
  )
}
