import { useMemo, useState } from 'react'
import { Card, Select, Space, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { useAuditLogs } from '@/hooks/useAuditLogs'
import { formatDateTime } from '@/lib/format'
import type { AdminAuditLog } from '@/types'

const PAGE_SIZE = 20

const METHOD_META: Record<string, { label: string; color: string }> = {
  POST: { label: 'Tạo', color: 'green' },
  PUT: { label: 'Cập nhật', color: 'blue' },
  PATCH: { label: 'Cập nhật', color: 'blue' },
  DELETE: { label: 'Xoá', color: 'red' },
}

const RESOURCE_LABELS: Record<string, string> = {
  users: 'Người dùng',
  rooms: 'Phòng chat',
  vip: 'VIP',
  egg: 'Đập trứng',
  wheel: 'Vòng quay',
  pen: 'Sút Pen',
  ken: 'Ken / Rương',
  me: 'Me',
  settings: 'Cài đặt',
  upload: 'Tải lên',
}

const DATE_INPUT_STYLE = {
  height: 32,
  border: '1px solid #d9d9d9',
  borderRadius: 6,
  padding: '0 8px',
}

const RESOURCE_OPTIONS = Object.entries(RESOURCE_LABELS).map(([value, label]) => ({ value, label }))
const METHOD_OPTIONS = [
  { value: 'POST', label: 'Tạo' },
  { value: 'PATCH', label: 'Cập nhật' },
  { value: 'DELETE', label: 'Xoá' },
]

const KEN_ADJUST_ROUTE = '/ken/users/:userId/adjust'

const ACTION_OPTIONS = [
  { value: KEN_ADJUST_ROUTE, label: 'Tặng / Trừ Ken' },
  { value: '/users/:id/vips', label: 'Tặng VIP' },
  { value: '/users/:id/username', label: 'Đổi username' },
  { value: '/users/:id/password', label: 'Reset mật khẩu' },
  { value: '/users/:id/status', label: 'Đổi trạng thái tài khoản' },
  { value: '/users/:id', label: 'Xoá người dùng' },
]

function resourceLabel(resource: string) {
  return RESOURCE_LABELS[resource] ?? resource
}

function detailBody(log: AdminAuditLog): Record<string, unknown> | undefined {
  const body = log.detail?.body
  return typeof body === 'object' && body != null ? (body as Record<string, unknown>) : undefined
}

function actionLabel(log: AdminAuditLog): string | undefined {
  const route = log.route ?? ''
  if (route.endsWith(KEN_ADJUST_ROUTE)) {
    const body = detailBody(log)
    const verb = body?.action === 'deduct' ? 'Trừ Ken' : 'Tặng Ken'
    const amount = body?.amount
    return typeof amount === 'number' ? `${verb} (${amount.toLocaleString('vi-VN')})` : verb
  }
  if (route.endsWith('/users/:id/vips')) return 'Tặng VIP'
  if (route.endsWith('/users/:id/username')) return 'Đổi username'
  if (route.endsWith('/users/:id/password')) return 'Reset mật khẩu'
  if (route.endsWith('/users/:id/status')) return 'Đổi trạng thái tài khoản'
  if (log.method === 'DELETE' && route.endsWith('/users/:id')) return 'Xoá người dùng'
  return undefined
}

function hasDetail(detail?: Record<string, unknown>) {
  return detail != null && Object.keys(detail).length > 0
}

export function AuditLogsPage() {
  const [page, setPage] = useState(1)
  const [resource, setResource] = useState<string | undefined>(undefined)
  const [method, setMethod] = useState<string | undefined>(undefined)
  const [route, setRoute] = useState<string | undefined>(undefined)
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')

  const params = useMemo(
    () => ({
      resource,
      method,
      route,
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [resource, method, route, from, to, page],
  )
  const { data, isFetching } = useAuditLogs(params)

  const columns: TableColumnsType<AdminAuditLog> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 165,
      render: (v: string) => formatDateTime(v),
    },
    {
      title: 'Admin',
      key: 'admin',
      width: 160,
      render: (_, r) => (
        <Typography.Text strong>{r.adminUsername ? `@${r.adminUsername}` : r.adminId}</Typography.Text>
      ),
    },
    {
      title: 'Thao tác',
      key: 'action',
      width: 130,
      render: (_, r) => {
        const meta = METHOD_META[r.method]
        return (
          <Space size={6}>
            <Tag color={meta?.color} style={{ margin: 0 }}>
              {meta?.label ?? r.method}
            </Tag>
            <span>{actionLabel(r) ?? resourceLabel(r.resource)}</span>
          </Space>
        )
      },
    },
    {
      title: 'Đường dẫn',
      dataIndex: 'path',
      render: (v: string, r) => (
        <Typography.Text code style={{ fontSize: 12 }}>
          {r.method} {v}
        </Typography.Text>
      ),
    },
    {
      title: 'Kết quả',
      dataIndex: 'status',
      width: 90,
      align: 'center',
      render: (v: number) => <Tag color={v < 300 ? 'green' : 'red'}>{v}</Tag>,
    },
    {
      title: 'IP',
      dataIndex: 'ip',
      width: 130,
      render: (v?: string) => v || '—',
    },
  ]

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <input
            type="date"
            aria-label="Từ ngày"
            value={from}
            max={to || undefined}
            onChange={(e) => {
              setFrom(e.target.value)
              setPage(1)
            }}
            style={DATE_INPUT_STYLE}
          />
          <span style={{ color: '#8c8c8c' }}>→</span>
          <input
            type="date"
            aria-label="Đến ngày"
            value={to}
            min={from || undefined}
            onChange={(e) => {
              setTo(e.target.value)
              setPage(1)
            }}
            style={DATE_INPUT_STYLE}
          />
          <Select
            allowClear
            placeholder="Tất cả chức năng"
            value={resource}
            onChange={(v) => {
              setResource(v)
              setPage(1)
            }}
            options={RESOURCE_OPTIONS}
            style={{ width: 200 }}
          />
          <Select
            allowClear
            placeholder="Tất cả thao tác"
            value={method}
            onChange={(v) => {
              setMethod(v)
              setPage(1)
            }}
            options={METHOD_OPTIONS}
            style={{ width: 170 }}
          />
          <Select
            allowClear
            placeholder="Tất cả hành động"
            value={route}
            onChange={(v) => {
              setRoute(v)
              setPage(1)
            }}
            options={ACTION_OPTIONS}
            style={{ width: 220 }}
          />
        </Space>
      </Card>

      <Card>
        <Table<AdminAuditLog>
          rowKey="id"
          size="small"
          loading={isFetching}
          columns={columns}
          dataSource={data?.items ?? []}
          locale={{ emptyText: 'Chưa có nhật ký nào' }}
          expandable={{
            rowExpandable: (r) => hasDetail(r.detail),
            expandedRowRender: (r) => (
              <pre style={{ margin: 0, fontSize: 12, whiteSpace: 'pre-wrap', wordBreak: 'break-word' }}>
                {JSON.stringify(r.detail, null, 2)}
              </pre>
            ),
          }}
          pagination={{
            current: page,
            pageSize: PAGE_SIZE,
            total: data?.total ?? 0,
            showTotal: (total) => `${total} thao tác`,
            onChange: setPage,
          }}
        />
      </Card>
    </Space>
  )
}
