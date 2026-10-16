import { useMemo, useState } from 'react'
import {
  App,
  Button,
  Card,
  Col,
  Input,
  Modal,
  Row,
  Select,
  Space,
  Statistic,
  Table,
  Tag,
  Tooltip,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { DollarOutlined, ReloadOutlined } from '@ant-design/icons'
import {
  Bar,
  CartesianGrid,
  ComposedChart,
  Legend,
  Line,
  ResponsiveContainer,
  Tooltip as RTooltip,
  XAxis,
  YAxis,
} from 'recharts'
import { UserCell } from '@/components/UserCell'
import { useManualCreditTopup, useTopupStats, useTopupTransactions } from '@/hooks/useTopup'
import { ApiError } from '@/lib/apiError'
import type { TopupTransaction, TopupTxStatus } from '@/types'

const PAGE_SIZE = 20

const DATE_INPUT_STYLE = {
  height: 32,
  border: '1px solid #d9d9d9',
  borderRadius: 6,
  padding: '0 8px',
}

const STATUS_META: Record<TopupTxStatus, { label: string; color: string }> = {
  PROCESSING: { label: 'Đang xử lý', color: 'blue' },
  CREDITED: { label: 'Đã cộng', color: 'green' },
  NO_MATCH: { label: 'Sai nội dung', color: 'orange' },
  BELOW_MIN: { label: 'Dưới mức tối thiểu', color: 'orange' },
  SKIPPED_OUT: { label: 'Tiền ra', color: 'default' },
  SKIPPED_DISABLED: { label: 'Đang tắt nạp', color: 'default' },
  FAILED: { label: 'Lỗi', color: 'red' },
}

const CREDITABLE_STATUSES: TopupTxStatus[] = [
  'PROCESSING',
  'NO_MATCH',
  'BELOW_MIN',
  'SKIPPED_DISABLED',
  'FAILED',
]

function vn(n: number) {
  return n.toLocaleString('vi-VN')
}

function formatTime(iso: string) {
  return new Date(iso).toLocaleString('vi-VN')
}

export function TopupTransactionsPage() {
  const { message } = App.useApp()
  const [status, setStatus] = useState<string>('')
  const [search, setSearch] = useState('')
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')
  const [page, setPage] = useState(1)
  const [creditTarget, setCreditTarget] = useState<TopupTransaction | null>(null)
  const [creditUsername, setCreditUsername] = useState('')

  const manualCredit = useManualCreditTopup()

  const range = useMemo(
    () => ({
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
    }),
    [from, to],
  )

  const params = useMemo(
    () => ({
      status: status || undefined,
      search: search || undefined,
      ...range,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [status, search, range, page],
  )
  const { data, isFetching, refetch } = useTopupTransactions(params)
  const { data: stats, refetch: refetchStats } = useTopupStats(range)

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
    }
  }

  function openCredit(row: TopupTransaction) {
    setCreditTarget(row)
    setCreditUsername(row.matchedUsername ?? '')
  }

  async function submitCredit() {
    if (!creditTarget) return
    const username = creditUsername.trim().replace(/^@/, '')
    if (!username) {
      message.error('Nhập username nhận KEN')
      return
    }
    try {
      const result = await manualCredit.mutateAsync({ id: creditTarget.id, username })
      const bonusNote =
        result.bonusKen > 0
          ? ` (gồm ${vn(result.bonusKen)} thưởng +${result.bonusPercent}%)`
          : ''
      message.success(
        `Đã cộng ${vn(result.kenAmount)} KEN${bonusNote} cho @${result.user.username}`,
      )
      setCreditTarget(null)
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Cộng KEN thất bại')
    }
  }

  const columns: ColumnsType<TopupTransaction> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 150,
      render: (value: string) => formatTime(value),
    },
    {
      title: 'Mã giao dịch',
      dataIndex: 'providerTxId',
      width: 150,
      ellipsis: true,
      render: (value: string) => <Typography.Text copyable>{value}</Typography.Text>,
    },
    {
      title: 'Nội dung',
      dataIndex: 'description',
      ellipsis: true,
      render: (value: string, row) => (
        <Tooltip title={value}>
          <Typography.Text>{value || '—'}</Typography.Text>
          {row.note ? (
            <Typography.Text type="danger" style={{ display: 'block', fontSize: 12 }}>
              {row.note}
            </Typography.Text>
          ) : null}
        </Tooltip>
      ),
    },
    {
      title: 'Số tiền (VNĐ)',
      dataIndex: 'amount',
      width: 130,
      align: 'right',
      render: (value: number, row) => (
        <Typography.Text strong type={row.type === 'IN' ? 'success' : 'secondary'}>
          {row.type === 'IN' ? '+' : '-'}
          {vn(value)}
        </Typography.Text>
      ),
    },
    {
      title: 'Trạng thái',
      dataIndex: 'status',
      width: 150,
      render: (value: TopupTxStatus) => {
        const meta = STATUS_META[value] ?? { label: value, color: 'default' }
        return <Tag color={meta.color}>{meta.label}</Tag>
      },
    },
    {
      title: 'Người nhận',
      key: 'user',
      width: 200,
      render: (_, row) => {
        if (row.user) return <UserCell user={row.user} />
        if (row.matchedUsername) {
          return (
            <Typography.Text type="secondary">@{row.matchedUsername} (?)</Typography.Text>
          )
        }
        return <Typography.Text type="secondary">—</Typography.Text>
      },
    },
    {
      title: 'KEN đã cộng',
      dataIndex: 'kenAmount',
      width: 120,
      align: 'right',
      render: (value: number) =>
        value > 0 ? (
          <Typography.Text strong>{vn(value)}</Typography.Text>
        ) : (
          <Typography.Text type="secondary">—</Typography.Text>
        ),
    },
    {
      title: 'KEN thưởng',
      key: 'bonusKen',
      width: 110,
      align: 'right',
      render: (_, row) =>
        row.status === 'CREDITED' && row.bonusKen > 0 ? (
          <Typography.Text type="success">+{vn(row.bonusKen)}</Typography.Text>
        ) : (
          <Typography.Text type="secondary">—</Typography.Text>
        ),
    },
    {
      title: '',
      key: 'actions',
      width: 110,
      render: (_, row) =>
        row.type === 'IN' && CREDITABLE_STATUSES.includes(row.status) ? (
          <Button size="small" icon={<DollarOutlined />} onClick={() => openCredit(row)}>
            Cộng KEN
          </Button>
        ) : null,
    },
  ]

  const bucketLabel = stats?.bucket === 'month' ? 'tháng' : 'ngày'

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Row gutter={[16, 16]}>
        <Col xs={12} lg={6}>
          <Card>
            <Statistic
              groupSeparator="."
              title="Nạp hôm nay"
              value={stats?.today.amount ?? 0}
              suffix="đ"
              valueStyle={{ color: '#3f8600' }}
            />
            <Typography.Text type="secondary">
              {vn(stats?.today.count ?? 0)} giao dịch
            </Typography.Text>
          </Card>
        </Col>
        <Col xs={12} lg={6}>
          <Card>
            <Statistic
              groupSeparator="."
              title="Nạp tháng này"
              value={stats?.thisMonth.amount ?? 0}
              suffix="đ"
              valueStyle={{ color: '#3f8600' }}
            />
            <Typography.Text type="secondary">
              {vn(stats?.thisMonth.count ?? 0)} giao dịch
            </Typography.Text>
          </Card>
        </Col>
        <Col xs={12} lg={6}>
          <Card>
            <Statistic
              groupSeparator="."
              title="Trong khoảng đã chọn"
              value={stats?.range.amount ?? 0}
              suffix="đ"
            />
            <Typography.Text type="secondary">
              {vn(stats?.range.count ?? 0)} giao dịch · {vn(stats?.range.ken ?? 0)} KEN
            </Typography.Text>
          </Card>
        </Col>
        <Col xs={12} lg={6}>
          <Card>
            <Statistic
              groupSeparator="."
              title="Chờ xử lý tay"
              value={stats?.pending.count ?? 0}
              valueStyle={{ color: (stats?.pending.count ?? 0) > 0 ? '#d46b08' : undefined }}
            />
            <Typography.Text type="secondary">
              {vn(stats?.pending.amount ?? 0)}đ chưa cộng
            </Typography.Text>
          </Card>
        </Col>
      </Row>

      <Card>
        <Space wrap>
          <Select
            allowClear
            placeholder="Trạng thái"
            value={status || undefined}
            onChange={(value) => resetPage(setStatus)(value ?? '')}
            style={{ width: 190 }}
            options={Object.entries(STATUS_META).map(([value, meta]) => ({
              value,
              label: meta.label,
            }))}
          />
          <Input.Search
            allowClear
            placeholder="Mã GD, nội dung, username"
            onSearch={(value) => resetPage(setSearch)(value.trim())}
            style={{ width: 260 }}
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
          <Button
            icon={<ReloadOutlined />}
            onClick={() => {
              void refetch()
              void refetchStats()
            }}
          >
            Tải lại
          </Button>
        </Space>
      </Card>

      <Card title={`Tiền nạp theo ${bucketLabel}`}>
        <ResponsiveContainer width="100%" height={280}>
          <ComposedChart data={stats?.series ?? []} margin={{ top: 8, right: 8, bottom: 8, left: 8 }}>
            <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
            <XAxis dataKey="date" fontSize={12} />
            <YAxis yAxisId="left" fontSize={12} />
            <YAxis yAxisId="right" orientation="right" fontSize={12} allowDecimals={false} />
            <RTooltip
              formatter={(value, name) =>
                name === 'Lượt nạp' ? [vn(Number(value)), name] : [`${vn(Number(value))}đ`, name]
              }
            />
            <Legend />
            <Bar yAxisId="left" dataKey="amount" name="Tiền nạp (VNĐ)" fill="#2563eb" radius={[4, 4, 0, 0]} />
            <Line yAxisId="right" type="monotone" dataKey="count" name="Lượt nạp" stroke="#5b8c2a" strokeWidth={2} />
          </ComposedChart>
        </ResponsiveContainer>
      </Card>

      <Table<TopupTransaction>
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
          showTotal: (total) => `${vn(total)} giao dịch`,
          onChange: setPage,
        }}
        locale={{ emptyText: 'Chưa có giao dịch nạp nào' }}
      />

      <Modal
        title="Cộng KEN thủ công"
        open={creditTarget != null}
        onOk={() => void submitCredit()}
        onCancel={() => setCreditTarget(null)}
        okText="Cộng KEN"
        cancelText="Huỷ"
        confirmLoading={manualCredit.isPending}
        destroyOnHidden
      >
        {creditTarget ? (
          <Space direction="vertical" size={12} style={{ width: '100%' }}>
            <Typography.Text>
              Giao dịch <Typography.Text code>{creditTarget.providerTxId}</Typography.Text> số tiền{' '}
              <Typography.Text strong>{vn(creditTarget.amount)} VNĐ</Typography.Text> sẽ cộng{' '}
              <Typography.Text strong>
                {vn(creditTarget.amount + creditTarget.bonusKen)} KEN
              </Typography.Text>
              {creditTarget.bonusKen > 0
                ? ` (gồm ${vn(creditTarget.bonusKen)} KEN thưởng +${creditTarget.bonusPercent}%, theo mốc lúc nhận giao dịch)`
                : ''}
              .
            </Typography.Text>
            <Typography.Text type="secondary" style={{ display: 'block' }}>
              Nội dung chuyển khoản: {creditTarget.description || '—'}
            </Typography.Text>
            <Input
              placeholder="Username nhận KEN"
              prefix="@"
              value={creditUsername}
              onChange={(e) => setCreditUsername(e.target.value)}
              onPressEnter={() => void submitCredit()}
            />
          </Space>
        ) : null}
      </Modal>
    </Space>
  )
}
