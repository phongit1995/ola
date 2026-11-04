import { useMemo, useState } from 'react'
import { Button, Card, Col, Input, Row, Select, Space, Statistic, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { DeleteOutlined, ReloadOutlined } from '@ant-design/icons'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { UserBriefCell } from '@/components/UserBriefCell'
import { PAGE_SIZE } from '@/lib/constants'
import { toIsoRange } from '@/lib/dateRange'
import { formatCount, formatDateTime } from '@/lib/format'
import type { AdminMegaphone, MegaphoneStatus } from '@/types'
import { MegaphoneRemoveModal } from './MegaphoneRemoveModal'
import { MEGAPHONE_STATUS_OPTIONS, MEGAPHONE_STATUS_TAG } from './constants'
import { useMegaphones } from './useMegaphoneQueries'

export function MegaphonesPage() {
  const [senderId, setSenderId] = useState('')
  const [query, setQuery] = useState('')
  const [status, setStatus] = useState<'all' | MegaphoneStatus>('all')
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')
  const [page, setPage] = useState(1)
  const [removing, setRemoving] = useState<AdminMegaphone | null>(null)

  const range = useMemo(() => toIsoRange(from, to), [from, to])
  const params = useMemo(
    () => ({
      senderId: senderId || undefined,
      q: query || undefined,
      status: status === 'all' ? undefined : status,
      ...range,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [senderId, query, status, range, page],
  )
  const { data, isFetching, refetch } = useMegaphones(params)

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
    }
  }

  const columns: ColumnsType<AdminMegaphone> = [
    {
      title: 'Giờ phát',
      dataIndex: 'showAt',
      width: 160,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Người phát',
      key: 'sender',
      width: 220,
      render: (_, row) => <UserBriefCell user={row.sender} />,
    },
    {
      title: 'Nội dung',
      dataIndex: 'content',
      render: (value: string) => <Typography.Text style={{ whiteSpace: 'pre-wrap' }}>{value}</Typography.Text>,
    },
    {
      title: 'KEN',
      dataIndex: 'kenPrice',
      width: 100,
      align: 'right',
      render: (value: number) => <Typography.Text strong>{formatCount(value)}</Typography.Text>,
    },
    {
      title: 'Trạng thái',
      key: 'status',
      width: 200,
      render: (_, row) => (
        <Space orientation="vertical" size={0}>
          <Tag color={MEGAPHONE_STATUS_TAG[row.status].color}>{MEGAPHONE_STATUS_TAG[row.status].label}</Tag>
          {row.status === 'removed' && (
            <Typography.Text type="secondary" style={{ fontSize: 12 }}>
              {row.removedReason || '—'} · {formatDateTime(row.removedAt)}
            </Typography.Text>
          )}
        </Space>
      ),
    },
    {
      title: '',
      key: 'actions',
      width: 90,
      align: 'right',
      render: (_, row) =>
        row.status === 'active' ? (
          <Button size="small" danger icon={<DeleteOutlined />} onClick={() => setRemoving(row)}>
            Gỡ
          </Button>
        ) : null,
    },
  ]

  return (
    <Space orientation="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <Input.Search
            allowClear
            placeholder="Tìm trong nội dung"
            onSearch={(value) => resetPage(setQuery)(value.trim())}
            style={{ width: 240 }}
          />
          <Input.Search
            allowClear
            placeholder="Người phát ID"
            onSearch={(value) => resetPage(setSenderId)(value.trim())}
            style={{ width: 240 }}
          />
          <Select
            value={status}
            onChange={resetPage(setStatus)}
            style={{ width: 170 }}
            options={MEGAPHONE_STATUS_OPTIONS}
          />
          <DateRangeFilter from={from} to={to} onFromChange={resetPage(setFrom)} onToChange={resetPage(setTo)} />
          <Button icon={<ReloadOutlined />} onClick={() => void refetch()}>
            Tải lại
          </Button>
        </Space>
      </Card>

      <Row gutter={16}>
        <Col xs={24} sm={12}>
          <Card>
            <Statistic title="Lượt phát loa" value={data?.total ?? 0} formatter={(v) => formatCount(Number(v))} />
          </Card>
        </Col>
        <Col xs={24} sm={12}>
          <Card>
            <Statistic title="KEN thu về" value={data?.totalKen ?? 0} formatter={(v) => formatCount(Number(v))} />
          </Card>
        </Col>
      </Row>

      <Table<AdminMegaphone>
        rowKey="id"
        size="small"
        loading={isFetching}
        columns={columns}
        dataSource={data?.items ?? []}
        scroll={{ x: 1000 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showSizeChanger: false,
          showTotal: (total) => `${formatCount(total)} loa`,
          onChange: setPage,
        }}
        locale={{ emptyText: 'Chưa có ai phát loa' }}
      />

      {removing && <MegaphoneRemoveModal megaphone={removing} onClose={() => setRemoving(null)} />}
    </Space>
  )
}
