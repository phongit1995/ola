import { useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Avatar,
  Button,
  Card,
  Input,
  InputNumber,
  Select,
  Space,
  Table,
  Tag,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { BarChartOutlined, ReloadOutlined } from '@ant-design/icons'
import { usePenShots } from '@/hooks/usePen'
import type { AdminPenShot, PenResult, PenSide, PenStatus, PenUserBrief } from '@/types'
import { PEN_RESULT_META, PEN_SIDE_LABEL, PEN_STATUS_META } from './penMeta'

const PAGE_SIZE = 20

const STATUS_OPTIONS = [
  { value: 'open' as const, label: 'Đang chờ' },
  { value: 'settled' as const, label: 'Đã xử lý' },
  { value: 'cancelled' as const, label: 'Đã huỷ' },
]

const RESULT_OPTIONS = [
  { value: 'saved' as const, label: 'Cản phá' },
  { value: 'goal' as const, label: 'Vào gôn' },
]

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

function sideTag(side?: PenSide) {
  if (!side) return null
  return <Tag style={{ margin: 0 }}>{PEN_SIDE_LABEL[side]}</Tag>
}

function UserCell({ user }: { user?: PenUserBrief }) {
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

export function PenShotsPage() {
  const navigate = useNavigate()
  const [status, setStatus] = useState<PenStatus | undefined>(undefined)
  const [result, setResult] = useState<PenResult | undefined>(undefined)
  const [shooterId, setShooterId] = useState('')
  const [minBet, setMinBet] = useState<number | null>(null)
  const [maxBet, setMaxBet] = useState<number | null>(null)
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')
  const [page, setPage] = useState(1)

  const params = useMemo(
    () => ({
      status,
      result,
      shooterId: shooterId || undefined,
      minBet: minBet ?? undefined,
      maxBet: maxBet ?? undefined,
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [status, result, shooterId, minBet, maxBet, from, to, page],
  )

  const { data, isFetching, refetch } = usePenShots(params)

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
    }
  }

  const columns: ColumnsType<AdminPenShot> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 160,
      render: (value: string) => formatTime(value),
    },
    {
      title: 'Người sút',
      key: 'shooter',
      render: (_, row) => (
        <Space size={6}>
          <UserCell user={row.shooter} />
          {sideTag(row.shooterSide)}
        </Space>
      ),
    },
    {
      title: 'Người chụp',
      key: 'keeper',
      render: (_, row) => (
        <Space size={6}>
          <UserCell user={row.keeper} />
          {sideTag(row.keeperSide)}
        </Space>
      ),
    },
    {
      title: 'Cược',
      dataIndex: 'betAmount',
      width: 110,
      align: 'right',
      render: (value: number) => `${vn(value)} Ken`,
    },
    {
      title: 'Trạng thái',
      dataIndex: 'status',
      width: 120,
      render: (value: PenStatus) => (
        <Tag color={PEN_STATUS_META[value].color}>{PEN_STATUS_META[value].label}</Tag>
      ),
    },
    {
      title: 'Kết quả',
      key: 'result',
      width: 220,
      render: (_, row) => {
        if (!row.result) return <Typography.Text type="secondary">—</Typography.Text>
        return <Tag color={PEN_RESULT_META[row.result].color}>{PEN_RESULT_META[row.result].label}</Tag>
      },
    },
    {
      title: 'Pot / Trả / HH',
      key: 'money',
      width: 170,
      align: 'right',
      render: (_, row) =>
        row.status === 'settled' ? (
          <Typography.Text>
            {vn(row.pot ?? 0)} / {vn(row.payout ?? 0)} /{' '}
            <Typography.Text type="success">{vn(row.commission ?? 0)}</Typography.Text>
          </Typography.Text>
        ) : (
          <Typography.Text type="secondary">—</Typography.Text>
        ),
    },
  ]

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <Input.Search
            allowClear
            placeholder="Lọc theo Shooter ID"
            defaultValue={shooterId}
            onSearch={resetPage(setShooterId)}
            style={{ width: 240 }}
          />
          <Select
            allowClear
            placeholder="Trạng thái"
            value={status}
            onChange={resetPage(setStatus)}
            options={STATUS_OPTIONS}
            style={{ width: 130 }}
          />
          <Select
            allowClear
            placeholder="Kết quả"
            value={result}
            onChange={resetPage(setResult)}
            options={RESULT_OPTIONS}
            style={{ width: 130 }}
          />
          <InputNumber
            placeholder="Cược từ"
            min={0}
            value={minBet}
            onChange={resetPage(setMinBet)}
            style={{ width: 120 }}
          />
          <InputNumber
            placeholder="Cược đến"
            min={0}
            value={maxBet}
            onChange={resetPage(setMaxBet)}
            style={{ width: 120 }}
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
          <Button
            type="primary"
            icon={<BarChartOutlined />}
            onClick={() => navigate('/games/pen/stats')}
          >
            Thống kê
          </Button>
        </Space>
      </Card>

      <Table<AdminPenShot>
        rowKey="id"
        size="small"
        loading={isFetching}
        columns={columns}
        dataSource={data?.items ?? []}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showSizeChanger: false,
          onChange: setPage,
        }}
      />
    </Space>
  )
}
