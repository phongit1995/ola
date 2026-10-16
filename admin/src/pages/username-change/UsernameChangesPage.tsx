import { useMemo, useState } from 'react'
import { Button, Card, Input, Select, Space, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { ArrowRightOutlined, ReloadOutlined } from '@ant-design/icons'
import { useUsernameChanges } from '@/hooks/useUserQueries'
import { UserCell } from '@/components/UserCell'
import { formatCount, formatDateTime } from '@/lib/format'
import type { UsernameChangeItem } from '@/types'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { toIsoRange } from '@/lib/dateRange'

const PAGE_SIZE = 20

const ACTOR_OPTIONS = [
  { value: 'user', label: 'User tự đổi' },
  { value: 'admin', label: 'Admin đổi hộ' },
]

function ActorCell({ row }: { row: UsernameChangeItem }) {
  if (row.actorType === 'admin') {
    return (
      <Space size={6}>
        <Tag color="orange" style={{ margin: 0 }}>
          Admin
        </Tag>
        <Typography.Text>
          {row.actorUsername ? `@${row.actorUsername}` : (row.actorId ?? '—')}
        </Typography.Text>
      </Space>
    )
  }
  return (
    <Tag color="blue" style={{ margin: 0 }}>
      User tự đổi
    </Tag>
  )
}

const columns: ColumnsType<UsernameChangeItem> = [
  {
    title: 'Thời gian',
    dataIndex: 'createdAt',
    width: 165,
    render: (v: string) => formatDateTime(v),
  },
  {
    title: 'Người dùng',
    key: 'user',
    render: (_, row) => <UserCell user={row.user} />,
  },
  {
    title: 'Nickname cũ',
    dataIndex: 'oldUsername',
    render: (v: string) => <Typography.Text delete>@{v}</Typography.Text>,
  },
  {
    title: '',
    key: 'arrow',
    width: 40,
    align: 'center',
    render: () => <ArrowRightOutlined style={{ color: '#8c8c8c' }} />,
  },
  {
    title: 'Nickname mới',
    dataIndex: 'newUsername',
    render: (v: string) => <Typography.Text strong>@{v}</Typography.Text>,
  },
  {
    title: 'Phí (Ken)',
    dataIndex: 'cost',
    width: 120,
    align: 'right',
    render: (v: number) =>
      v > 0 ? (
        <Typography.Text strong>{formatCount(v)}</Typography.Text>
      ) : (
        <Typography.Text type="secondary">Miễn phí</Typography.Text>
      ),
  },
  {
    title: 'Người thực hiện',
    key: 'actor',
    width: 200,
    render: (_, row) => <ActorCell row={row} />,
  },
]

export function UsernameChangesPage() {
  const [page, setPage] = useState(1)
  const [q, setQ] = useState('')
  const [actorType, setActorType] = useState<'user' | 'admin' | undefined>(undefined)
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')

  const params = useMemo(
    () => ({
      q: q || undefined,
      actorType,
      ...toIsoRange(from, to),
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [q, actorType, from, to, page],
  )
  const { data, isFetching, refetch } = useUsernameChanges(params)

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <Input.Search
            allowClear
            placeholder="Tìm username (cũ, mới hoặc hiện tại)"
            onSearch={(value) => {
              setQ(value.trim())
              setPage(1)
            }}
            style={{ width: 280 }}
          />
          <Select
            allowClear
            placeholder="Người thực hiện"
            value={actorType}
            onChange={(v) => {
              setActorType(v)
              setPage(1)
            }}
            options={ACTOR_OPTIONS}
            style={{ width: 170 }}
          />
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
          <Button icon={<ReloadOutlined />} onClick={() => void refetch()}>
            Tải lại
          </Button>
        </Space>
      </Card>

      <Card>
        <Table<UsernameChangeItem>
          rowKey="id"
          size="small"
          loading={isFetching}
          columns={columns}
          dataSource={data?.items ?? []}
          locale={{ emptyText: 'Chưa có lần đổi nickname nào' }}
          pagination={{
            current: page,
            pageSize: PAGE_SIZE,
            total: data?.total ?? 0,
            showSizeChanger: false,
            showTotal: (total) => `${formatCount(total)} lần đổi`,
            onChange: setPage,
          }}
        />
      </Card>
    </Space>
  )
}
