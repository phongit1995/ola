import { useMemo, useState } from 'react'
import {
  Avatar,
  Button,
  Card,
  Input,
  InputNumber,
  Space,
  Table,
  Typography,
} from 'antd'
import type { ColumnsType, TablePaginationConfig } from 'antd/es/table'
import type { SorterResult } from 'antd/es/table/interface'
import { ArrowRightOutlined, ReloadOutlined } from '@ant-design/icons'
import { useKenTransfers, useKenTransferUserStats } from '@/hooks/useKen'
import type {
  KenCounterparty,
  KenTransferItem,
  KenTransferUserStatsItem,
  KenTransferUserStatsSortBy,
} from '@/types'

const PAGE_SIZE = 20
const USER_STATS_SORTS: KenTransferUserStatsSortBy[] = [
  'sentTotal',
  'receivedTotal',
  'netKen',
  'transfers',
]
const USER_PAGE_SIZE = 10

const DATE_INPUT_STYLE = {
  height: 32,
  border: '1px solid #d9d9d9',
  borderRadius: 6,
  padding: '0 8px',
}

function vn(n: number) {
  return n.toLocaleString('vi-VN')
}

function formatTime(iso: string) {
  return new Date(iso).toLocaleString('vi-VN')
}

function NetText({ value }: { value: number }) {
  if (value > 0) return <Typography.Text type="success">+{vn(value)}</Typography.Text>
  if (value < 0) return <Typography.Text type="danger">{vn(value)}</Typography.Text>
  return <Typography.Text>0</Typography.Text>
}

function UserCell({ user }: { user?: KenCounterparty }) {
  if (!user) return <Typography.Text type="secondary">—</Typography.Text>
  return (
    <Space>
      <Avatar size="small" src={user.avatar || undefined}>
        {user.fullName?.[0] ?? user.username?.[0] ?? '?'}
      </Avatar>
      <div>
        <Typography.Text strong>{user.fullName || user.username}</Typography.Text>
        <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
          @{user.username}
        </Typography.Text>
      </div>
    </Space>
  )
}

const transferColumns: ColumnsType<KenTransferItem> = [
  {
    title: 'Thời gian',
    dataIndex: 'createdAt',
    width: 160,
    render: (value: string) => formatTime(value),
  },
  {
    title: 'Người gửi',
    key: 'from',
    render: (_, row) => <UserCell user={row.from} />,
  },
  {
    title: '',
    key: 'arrow',
    width: 40,
    align: 'center',
    render: () => <ArrowRightOutlined style={{ color: '#8c8c8c' }} />,
  },
  {
    title: 'Người nhận',
    key: 'to',
    render: (_, row) => <UserCell user={row.to} />,
  },
  {
    title: 'Số Ken',
    dataIndex: 'amount',
    width: 130,
    align: 'right',
    render: (value: number) => <Typography.Text strong>{vn(value)}</Typography.Text>,
  },
  {
    title: 'Lời nhắn',
    dataIndex: 'description',
    ellipsis: true,
    render: (value?: string) =>
      value ? value : <Typography.Text type="secondary">—</Typography.Text>,
  },
]

export function KenTransfersPage() {
  const [senderId, setSenderId] = useState('')
  const [receiverId, setReceiverId] = useState('')
  const [minAmount, setMinAmount] = useState<number | null>(null)
  const [maxAmount, setMaxAmount] = useState<number | null>(null)
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')
  const [page, setPage] = useState(1)

  const [userSort, setUserSort] = useState<KenTransferUserStatsSortBy>('sentTotal')
  const [userPage, setUserPage] = useState(1)
  const [userSearch, setUserSearch] = useState('')

  const range = useMemo(
    () => ({
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
    }),
    [from, to],
  )

  const params = useMemo(
    () => ({
      senderId: senderId || undefined,
      receiverId: receiverId || undefined,
      minAmount: minAmount ?? undefined,
      maxAmount: maxAmount ?? undefined,
      ...range,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [senderId, receiverId, minAmount, maxAmount, range, page],
  )
  const { data, isFetching, refetch } = useKenTransfers(params)

  const userStatsParams = useMemo(
    () => ({
      userId: userSearch || undefined,
      minAmount: minAmount ?? undefined,
      maxAmount: maxAmount ?? undefined,
      ...range,
      sortBy: userSort,
      limit: USER_PAGE_SIZE,
      offset: (userPage - 1) * USER_PAGE_SIZE,
    }),
    [userSearch, minAmount, maxAmount, range, userSort, userPage],
  )
  const { data: userStats, isFetching: userStatsFetching } =
    useKenTransferUserStats(userStatsParams)

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
      setUserPage(1)
    }
  }

  function onUserTableChange(
    _pagination: TablePaginationConfig,
    _filters: unknown,
    sorter: SorterResult<KenTransferUserStatsItem> | SorterResult<KenTransferUserStatsItem>[],
  ) {
    const single = Array.isArray(sorter) ? sorter[0] : sorter
    const field = single?.order ? String(single.field) : 'sentTotal'
    const next = USER_STATS_SORTS.find((key) => key === field) ?? 'sentTotal'
    if (next !== userSort) {
      setUserSort(next)
      setUserPage(1)
    }
  }

  const userColumns: ColumnsType<KenTransferUserStatsItem> = [
    {
      title: 'Người chơi',
      key: 'user',
      render: (_, row) => <UserCell user={row.user} />,
    },
    {
      title: 'Đã chuyển',
      dataIndex: 'sentTotal',
      width: 150,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'sentTotal' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (_: number, row) => `${vn(row.sentTotal)} (${vn(row.sentCount)} lần)`,
    },
    {
      title: 'Đã nhận',
      dataIndex: 'receivedTotal',
      width: 150,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'receivedTotal' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (_: number, row) => `${vn(row.receivedTotal)} (${vn(row.receivedCount)} lần)`,
    },
    {
      title: 'Ròng',
      dataIndex: 'netKen',
      width: 130,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'netKen' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => <NetText value={v} />,
    },
    {
      title: 'Số đối tác',
      dataIndex: 'partners',
      width: 110,
      align: 'right',
      render: (v: number) => vn(v),
    },
    {
      title: 'Gần nhất',
      dataIndex: 'lastTransferAt',
      width: 150,
      render: (v: string) => formatTime(v),
    },
  ]

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <Input.Search
            allowClear
            placeholder="Người gửi ID"
            defaultValue={senderId}
            onSearch={resetPage(setSenderId)}
            style={{ width: 220 }}
          />
          <Input.Search
            allowClear
            placeholder="Người nhận ID"
            defaultValue={receiverId}
            onSearch={resetPage(setReceiverId)}
            style={{ width: 220 }}
          />
          <InputNumber
            placeholder="Ken từ"
            min={0}
            value={minAmount}
            onChange={resetPage(setMinAmount)}
            style={{ width: 110 }}
          />
          <InputNumber
            placeholder="Ken đến"
            min={0}
            value={maxAmount}
            onChange={resetPage(setMaxAmount)}
            style={{ width: 110 }}
          />
          <input
            type="date"
            aria-label="Từ ngày"
            value={from}
            max={to || undefined}
            onChange={(e) => resetPage(setFrom)(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
          <span style={{ color: '#8c8c8c' }}>→</span>
          <input
            type="date"
            aria-label="Đến ngày"
            value={to}
            min={from || undefined}
            onChange={(e) => resetPage(setTo)(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
          <Button icon={<ReloadOutlined />} onClick={() => void refetch()}>
            Tải lại
          </Button>
        </Space>
      </Card>

      <Table<KenTransferItem>
        rowKey="id"
        size="small"
        loading={isFetching}
        columns={transferColumns}
        dataSource={data?.items ?? []}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showSizeChanger: false,
          showTotal: (total) => `${vn(total)} giao dịch`,
          onChange: setPage,
        }}
        locale={{ emptyText: 'Chưa có giao dịch chuyển Ken nào' }}
      />

      <Card
        title="Thống kê chuyển / nhận theo user"
        extra={
          <Input.Search
            allowClear
            placeholder="Lọc theo User ID"
            onSearch={(value) => {
              setUserSearch(value.trim())
              setUserPage(1)
            }}
            style={{ width: 260 }}
          />
        }
      >
        <Table<KenTransferUserStatsItem>
          rowKey={(row) => row.user.id}
          size="small"
          loading={userStatsFetching}
          columns={userColumns}
          dataSource={userStats?.items ?? []}
          onChange={onUserTableChange}
          pagination={{
            current: userPage,
            pageSize: USER_PAGE_SIZE,
            total: userStats?.total ?? 0,
            showSizeChanger: false,
            onChange: setUserPage,
          }}
          locale={{ emptyText: 'Chưa có user nào chuyển/nhận Ken' }}
        />
      </Card>
    </Space>
  )
}
