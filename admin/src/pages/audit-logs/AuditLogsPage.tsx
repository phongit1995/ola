import { useMemo, useState } from 'react'
import { Card, Select, Space, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { useAuditLogs } from './useAuditLogQueries'
import { formatDateTime } from '@/lib/format'
import type { AdminAuditLog } from '@/types'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { toIsoRange } from '@/lib/dateRange'
import { PAGE_SIZE } from '@/lib/constants'
import { ACTION_OPTIONS, METHOD_META, METHOD_OPTIONS, RESOURCE_OPTIONS } from './constants'
import { actionLabel, hasDetail, resourceLabel } from './utils'

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
      ...toIsoRange(from, to),
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
          <DateRangeFilter
            from={from}
            to={to}
            onFromChange={(value) => {
              setFrom(value)
              setPage(1)
            }}
            onToChange={(value) => {
              setTo(value)
              setPage(1)
            }}
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
