import { useMemo, useState } from 'react'
import {
  Avatar,
  Card,
  Col,
  Empty,
  Input,
  Row,
  Space,
  Spin,
  Statistic,
  Table,
  Typography,
} from 'antd'
import type { ColumnsType, TablePaginationConfig } from 'antd/es/table'
import type { SorterResult } from 'antd/es/table/interface'
import {
  Bar,
  CartesianGrid,
  Cell,
  ComposedChart,
  Legend,
  Line,
  Pie,
  PieChart,
  ResponsiveContainer,
  Tooltip as RTooltip,
  XAxis,
  YAxis,
} from 'recharts'
import { usePenSideStats, usePenStats, usePenUserStats } from '@/hooks/usePen'
import type { PenResult, PenUserStatsItem, PenUserStatsSortBy } from '@/types'

const USER_STATS_SORTS: PenUserStatsSortBy[] = ['staked', 'netKen', 'shots', 'catches']
const USER_PAGE_SIZE = 10

function NetText({ value }: { value: number }) {
  if (value > 0) return <Typography.Text type="success">+{value.toLocaleString('vi-VN')}</Typography.Text>
  if (value < 0) return <Typography.Text type="danger">{value.toLocaleString('vi-VN')}</Typography.Text>
  return <Typography.Text>0</Typography.Text>
}

const RESULT_COLOR: Record<PenResult, { label: string; color: string }> = {
  saved: { label: 'Cản phá (thủ môn thắng)', color: '#fa541c' },
  goal: { label: 'Vào gôn (người sút thắng)', color: '#52c41a' },
}

const DATE_INPUT_STYLE = {
  height: 32,
  border: '1px solid #d9d9d9',
  borderRadius: 6,
  padding: '0 8px',
}

function isoDate(d: Date) {
  return d.toISOString().slice(0, 10)
}

function vn(n: number) {
  return n.toLocaleString('vi-VN')
}

export function PenStatsPage() {
  const [from, setFrom] = useState(() => isoDate(new Date(Date.now() - 29 * 24 * 60 * 60 * 1000)))
  const [to, setTo] = useState(() => isoDate(new Date()))
  const [userSort, setUserSort] = useState<PenUserStatsSortBy>('staked')
  const [userPage, setUserPage] = useState(1)
  const [userSearch, setUserSearch] = useState('')

  const params = useMemo(
    () => ({
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
    }),
    [from, to],
  )
  const { data, isFetching } = usePenStats(params)

  const userStatsParams = useMemo(
    () => ({
      ...params,
      userId: userSearch || undefined,
      sortBy: userSort,
      limit: USER_PAGE_SIZE,
      offset: (userPage - 1) * USER_PAGE_SIZE,
    }),
    [params, userSearch, userSort, userPage],
  )
  const { data: userStats, isFetching: userStatsFetching } = usePenUserStats(userStatsParams)
  const { data: sideStats, isFetching: sideStatsFetching } = usePenSideStats(params)

  function onUserTableChange(
    _pagination: TablePaginationConfig,
    _filters: unknown,
    sorter: SorterResult<PenUserStatsItem> | SorterResult<PenUserStatsItem>[],
  ) {
    const single = Array.isArray(sorter) ? sorter[0] : sorter
    const field = single?.order ? String(single.field) : 'staked'
    const next = USER_STATS_SORTS.find((key) => key === field) ?? 'staked'
    if (next !== userSort) {
      setUserSort(next)
      setUserPage(1)
    }
  }

  const userColumns: ColumnsType<PenUserStatsItem> = [
    {
      title: 'Người chơi',
      key: 'user',
      render: (_, row) => (
        <Space>
          <Avatar size="small" src={row.user.avatar || undefined}>
            {row.user.username?.[0] ?? '?'}
          </Avatar>
          <Typography.Text strong>@{row.user.username}</Typography.Text>
        </Space>
      ),
    },
    {
      title: 'Lượt sút',
      dataIndex: 'shots',
      width: 100,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'shots' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => vn(v),
    },
    {
      title: 'Thắng sút',
      key: 'shooterWins',
      width: 120,
      align: 'right',
      render: (_, row) =>
        row.shooterSettled > 0
          ? `${vn(row.shooterWins)} (${row.shooterWinRate.toFixed(1)}%)`
          : '—',
    },
    {
      title: 'Lượt chụp',
      dataIndex: 'catches',
      width: 100,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'catches' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => vn(v),
    },
    {
      title: 'Cản phá',
      key: 'keeperWins',
      width: 120,
      align: 'right',
      render: (_, row) =>
        row.catches > 0 ? `${vn(row.keeperWins)} (${row.keeperSaveRate.toFixed(1)}%)` : '—',
    },
    {
      title: 'Hủy kèo',
      key: 'cancelled',
      width: 110,
      align: 'right',
      render: (_, row) =>
        row.cancelled > 0 ? `${vn(row.cancelled)} (${row.cancelRate.toFixed(1)}%)` : '0',
    },
    {
      title: 'Tổng cược',
      dataIndex: 'staked',
      width: 120,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'staked' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => vn(v),
    },
    {
      title: 'Ròng (user)',
      dataIndex: 'netKen',
      width: 120,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'netKen' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => <NetText value={v} />,
    },
    {
      title: 'Chơi gần nhất',
      dataIndex: 'lastPlayAt',
      width: 150,
      render: (v: string) => new Date(v).toLocaleString('vi-VN'),
    },
  ]

  const sideRows = sideStats
    ? [
        {
          role: 'Người sút',
          left: sideStats.shooterLeft,
          right: sideStats.shooterRight,
        },
        {
          role: 'Thủ môn',
          left: sideStats.keeperLeft,
          right: sideStats.keeperRight,
        },
      ]
    : []

  const sideColumns: ColumnsType<(typeof sideRows)[number]> = [
    { title: 'Vai', dataIndex: 'role' },
    {
      title: 'Trái',
      key: 'left',
      align: 'right',
      render: (_, row) => {
        const total = row.left + row.right
        return total > 0 ? `${vn(row.left)} (${((row.left / total) * 100).toFixed(1)}%)` : '—'
      },
    },
    {
      title: 'Phải',
      key: 'right',
      align: 'right',
      render: (_, row) => {
        const total = row.left + row.right
        return total > 0 ? `${vn(row.right)} (${((row.right / total) * 100).toFixed(1)}%)` : '—'
      },
    },
  ]

  const hasData = (data?.overview.totalShots ?? 0) > 0

  const resultPie = (data?.byResult ?? []).map((row) => ({
    name: RESULT_COLOR[row.result].label,
    value: row.count,
    color: RESULT_COLOR[row.result].color,
  }))

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <input
            type="date"
            aria-label="Từ ngày"
            value={from}
            max={to || undefined}
            onChange={(e) => setFrom(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
          <span style={{ color: '#8c8c8c' }}>→</span>
          <input
            type="date"
            aria-label="Đến ngày"
            value={to}
            min={from || undefined}
            onChange={(e) => setTo(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
        </Space>
      </Card>

      {isFetching && !data ? (
        <Card>
          <div style={{ textAlign: 'center', padding: 60 }}>
            <Spin />
          </div>
        </Card>
      ) : !data || !hasData ? (
        <Card>
          <Empty description="Chưa có lượt PEN nào trong khoảng đã chọn" />
        </Card>
      ) : (
        <>
          <Row gutter={[16, 16]}>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Tổng lượt" value={data.overview.totalShots} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Đã xử lý" value={data.overview.settledShots} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="."
                  title="Doanh thu nhà cái (Ken)"
                  value={data.overview.houseTake}
                  valueStyle={{ color: '#3f8600' }}
                />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Tổng cược (Ken)" value={data.overview.totalVolume} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Tổng trả thưởng (Ken)" value={data.overview.totalPayout} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="."
                  title="Tỉ lệ thủ môn thắng"
                  value={data.overview.keeperWinRate}
                  precision={1}
                  suffix="%"
                />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Người sút" value={data.overview.uniqueShooters} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Người chụp" value={data.overview.uniqueKeepers} />
              </Card>
            </Col>
          </Row>

          <Card title={`Lượt & Ken theo ${data.bucket === 'month' ? 'tháng' : 'ngày'}`}>
            <ResponsiveContainer width="100%" height={320}>
              <ComposedChart data={data.timeseries} margin={{ top: 8, right: 8, bottom: 8, left: 8 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis dataKey="date" fontSize={12} />
                <YAxis yAxisId="left" fontSize={12} />
                <YAxis yAxisId="right" orientation="right" fontSize={12} />
                <RTooltip formatter={(value) => vn(Number(value))} />
                <Legend />
                <Bar yAxisId="left" dataKey="volume" name="Tổng cược" fill="#2563eb" radius={[4, 4, 0, 0]} />
                <Bar yAxisId="left" dataKey="houseTake" name="Doanh thu" fill="#52c41a" radius={[4, 4, 0, 0]} />
                <Line yAxisId="right" type="monotone" dataKey="shots" name="Lượt" stroke="#fa541c" strokeWidth={2} />
              </ComposedChart>
            </ResponsiveContainer>
          </Card>

          <Row gutter={[16, 16]}>
            <Col xs={24} lg={10}>
              <Card title="Phân bố kết quả">
                <ResponsiveContainer width="100%" height={300}>
                  <PieChart>
                    <Pie
                      data={resultPie}
                      dataKey="value"
                      nameKey="name"
                      innerRadius={60}
                      outerRadius={105}
                      paddingAngle={2}
                    >
                      {resultPie.map((entry) => (
                        <Cell key={entry.name} fill={entry.color} />
                      ))}
                    </Pie>
                    <RTooltip formatter={(value, name) => [`${vn(Number(value))} lượt`, name]} />
                    <Legend />
                  </PieChart>
                </ResponsiveContainer>
              </Card>
            </Col>
            <Col xs={24} lg={14}>
              <Card title="Phân bố hướng sút / chụp">
                <Table
                  rowKey="role"
                  size="small"
                  loading={sideStatsFetching}
                  columns={sideColumns}
                  dataSource={sideRows}
                  pagination={false}
                  locale={{ emptyText: 'Chưa có kèo nào được xử lý' }}
                />
              </Card>
            </Col>
          </Row>

          <Card
            title="Thống kê theo người chơi (cả vai sút và chụp)"
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
            <Table<PenUserStatsItem>
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
              locale={{ emptyText: 'Chưa có người chơi nào' }}
            />
          </Card>
        </>
      )}
    </Space>
  )
}
