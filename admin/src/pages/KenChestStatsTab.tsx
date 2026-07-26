import { useMemo, useState } from 'react'
import {
  Avatar,
  Card,
  Col,
  Empty,
  Input,
  Row,
  Select,
  Space,
  Spin,
  Statistic,
  Table,
  Tag,
  Typography,
} from 'antd'
import type { ColumnsType, TablePaginationConfig } from 'antd/es/table'
import type { SorterResult } from 'antd/es/table/interface'
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
import { useKenChestStats, useKenChestUserStats } from '@/hooks/useKenChests'
import type {
  KenChestSource,
  KenChestStatsSourceRow,
  KenChestUserStatsItem,
  KenChestUserStatsSortBy,
} from '@/types'

const SOURCE_META: Record<KenChestSource, { label: string; color: string }> = {
  manual: { label: 'Thủ công', color: 'blue' },
  auto: { label: 'Tự động', color: 'purple' },
}

const SOURCE_OPTIONS = (Object.keys(SOURCE_META) as KenChestSource[]).map((source) => ({
  value: source,
  label: SOURCE_META[source].label,
}))

const USER_STATS_SORTS: KenChestUserStatsSortBy[] = ['kenTotal', 'claims', 'empty']
const USER_PAGE_SIZE = 10

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

const sourceColumns: ColumnsType<KenChestStatsSourceRow> = [
  {
    title: 'Nguồn',
    dataIndex: 'source',
    render: (value: KenChestSource) => (
      <Tag color={SOURCE_META[value]?.color}>{SOURCE_META[value]?.label ?? value}</Tag>
    ),
  },
  { title: 'Rương', dataIndex: 'chests', align: 'right', render: (v: number) => vn(v) },
  { title: 'Lượt nhặt', dataIndex: 'claims', align: 'right', render: (v: number) => vn(v) },
  {
    title: 'Ken đã phát',
    dataIndex: 'kenGiven',
    align: 'right',
    render: (v: number) => <Typography.Text strong>{vn(v)}</Typography.Text>,
  },
]

export function KenChestStatsTab() {
  const [from, setFrom] = useState(() => isoDate(new Date(Date.now() - 29 * 24 * 60 * 60 * 1000)))
  const [to, setTo] = useState(() => isoDate(new Date()))
  const [source, setSource] = useState<KenChestSource | undefined>(undefined)
  const [userSort, setUserSort] = useState<KenChestUserStatsSortBy>('kenTotal')
  const [userPage, setUserPage] = useState(1)
  const [userSearch, setUserSearch] = useState('')

  const params = useMemo(
    () => ({
      source,
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
    }),
    [source, from, to],
  )
  const { data, isFetching } = useKenChestStats(params)

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
  const { data: userStats, isFetching: userStatsFetching } = useKenChestUserStats(userStatsParams)

  function onUserTableChange(
    _pagination: TablePaginationConfig,
    _filters: unknown,
    sorter: SorterResult<KenChestUserStatsItem> | SorterResult<KenChestUserStatsItem>[],
  ) {
    const single = Array.isArray(sorter) ? sorter[0] : sorter
    const fallback: KenChestUserStatsSortBy = 'kenTotal'
    const field = single?.order ? String(single.field) : fallback
    const mapped = field === 'emptyClaims' ? 'empty' : field
    const next = USER_STATS_SORTS.find((key) => key === mapped) ?? fallback
    if (next !== userSort) {
      setUserSort(next)
      setUserPage(1)
    }
  }

  const userColumns: ColumnsType<KenChestUserStatsItem> = [
    {
      title: 'Người nhặt',
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
      title: 'Lượt nhặt',
      dataIndex: 'claims',
      width: 110,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'claims' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => vn(v),
    },
    {
      title: 'Số rương',
      dataIndex: 'chests',
      width: 100,
      align: 'right',
      render: (v: number) => vn(v),
    },
    {
      title: 'Nhặt rỗng',
      dataIndex: 'emptyClaims',
      width: 130,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'empty' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (_: number, row) =>
        row.claims > 0 ? `${vn(row.emptyClaims)} (${row.emptyRate.toFixed(1)}%)` : '—',
    },
    {
      title: 'Ken nhận',
      dataIndex: 'kenTotal',
      width: 130,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'kenTotal' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => <Typography.Text strong>{vn(v)}</Typography.Text>,
    },
    {
      title: 'Nhặt gần nhất',
      dataIndex: 'lastClaimAt',
      width: 150,
      render: (v: string) => new Date(v).toLocaleString('vi-VN'),
    },
  ]

  const hasData = (data?.overview.totalChests ?? 0) > 0 || (data?.overview.totalClaims ?? 0) > 0

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Space wrap>
        <Select
          allowClear
          placeholder="Tất cả nguồn"
          value={source}
          onChange={(value) => {
            setSource(value)
            setUserPage(1)
          }}
          options={SOURCE_OPTIONS}
          style={{ width: 140 }}
        />
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

      {isFetching && !data ? (
        <div style={{ textAlign: 'center', padding: 60 }}>
          <Spin />
        </div>
      ) : !data || !hasData ? (
        <Empty description="Chưa có rương nào trong khoảng đã chọn" />
      ) : (
        <>
          <Row gutter={[16, 16]}>
            <Col xs={12} sm={8} lg={6}>
              <Card size="small">
                <Statistic groupSeparator="." title="Tổng rương" value={data.overview.totalChests} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card size="small">
                <Statistic groupSeparator="."
                  title="Thủ công / Tự động"
                  value={`${vn(data.overview.manualChests)} / ${vn(data.overview.autoChests)}`}
                />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card size="small">
                <Statistic groupSeparator="." title="Đang mở" value={data.overview.activeChests} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card size="small">
                <Statistic groupSeparator="." title="Hết hạn" value={data.overview.expiredChests} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card size="small">
                <Statistic groupSeparator="."
                  title="Ken đã phát"
                  value={data.overview.totalKenGiven}
                  valueStyle={{ color: '#3f8600' }}
                />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card size="small">
                <Statistic groupSeparator="." title="Lượt nhặt" value={data.overview.totalClaims} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card size="small">
                <Statistic groupSeparator="."
                  title="Nhặt rỗng"
                  value={data.overview.emptyRate}
                  precision={1}
                  suffix="%"
                />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card size="small">
                <Statistic groupSeparator="." title="Người nhặt" value={data.overview.uniqueUsers} />
              </Card>
            </Col>
          </Row>

          <Card
            size="small"
            title={`Ken phát & lượt nhặt theo ${data.bucket === 'month' ? 'tháng' : 'ngày'}`}
          >
            <ResponsiveContainer width="100%" height={300}>
              <ComposedChart data={data.timeseries} margin={{ top: 8, right: 8, bottom: 8, left: 8 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis dataKey="date" fontSize={12} />
                <YAxis yAxisId="left" fontSize={12} />
                <YAxis yAxisId="right" orientation="right" fontSize={12} />
                <RTooltip formatter={(value) => vn(Number(value))} />
                <Legend />
                <Bar yAxisId="left" dataKey="kenGiven" name="Ken phát" fill="#2563eb" radius={[4, 4, 0, 0]} />
                <Line yAxisId="right" type="monotone" dataKey="claims" name="Lượt nhặt" stroke="#fa541c" strokeWidth={2} />
              </ComposedChart>
            </ResponsiveContainer>
          </Card>

          <Card size="small" title="Theo nguồn rương">
            <Table<KenChestStatsSourceRow>
              rowKey="source"
              size="small"
              columns={sourceColumns}
              dataSource={data.bySource}
              pagination={false}
            />
          </Card>

          <Card
            size="small"
            title="Thống kê theo người nhặt"
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
            <Table<KenChestUserStatsItem>
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
              locale={{ emptyText: 'Chưa có ai nhặt rương' }}
            />
          </Card>
        </>
      )}
    </Space>
  )
}
