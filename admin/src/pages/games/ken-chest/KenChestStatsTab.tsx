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
import type { ColumnsType } from 'antd/es/table'
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
import { formatCount, formatDateTime } from '@/lib/format'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { isoDaysAgo, toIsoRange } from '@/lib/dateRange'
import { USER_STATS_PAGE_SIZE, useUserStatsTable } from '@/hooks/useUserStatsTable'

const SOURCE_META: Record<KenChestSource, { label: string; color: string }> = {
  manual: { label: 'Thủ công', color: 'blue' },
  auto: { label: 'Tự động', color: 'purple' },
}

const SOURCE_OPTIONS = (Object.keys(SOURCE_META) as KenChestSource[]).map((source) => ({
  value: source,
  label: SOURCE_META[source].label,
}))

const USER_STATS_SORTS: KenChestUserStatsSortBy[] = ['kenTotal', 'claims', 'empty']

const sourceColumns: ColumnsType<KenChestStatsSourceRow> = [
  {
    title: 'Nguồn',
    dataIndex: 'source',
    render: (value: KenChestSource) => (
      <Tag color={SOURCE_META[value]?.color}>{SOURCE_META[value]?.label ?? value}</Tag>
    ),
  },
  { title: 'Rương', dataIndex: 'chests', align: 'right', render: (v: number) => formatCount(v) },
  { title: 'Lượt nhặt', dataIndex: 'claims', align: 'right', render: (v: number) => formatCount(v) },
  {
    title: 'Ken đã phát',
    dataIndex: 'kenGiven',
    align: 'right',
    render: (v: number) => <Typography.Text strong>{formatCount(v)}</Typography.Text>,
  },
]

export function KenChestStatsTab() {
  const [from, setFrom] = useState(() => isoDaysAgo(29))
  const [to, setTo] = useState(() => isoDaysAgo(0))
  const [source, setSource] = useState<KenChestSource | undefined>(undefined)
  const { userSort, userPage, setUserPage, setUserSearch, userQuery, onUserTableChange } =
    useUserStatsTable(USER_STATS_SORTS, 'kenTotal', (field) => (field === 'emptyClaims' ? 'empty' : field))

  const params = useMemo(
    () => ({
      source,
      ...toIsoRange(from, to),
    }),
    [source, from, to],
  )
  const { data, isFetching } = useKenChestStats(params)

  const userStatsParams = useMemo(() => ({ ...params, ...userQuery }), [params, userQuery])
  const { data: userStats, isFetching: userStatsFetching } = useKenChestUserStats(userStatsParams)

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
      render: (v: number) => formatCount(v),
    },
    {
      title: 'Số rương',
      dataIndex: 'chests',
      width: 100,
      align: 'right',
      render: (v: number) => formatCount(v),
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
        row.claims > 0 ? `${formatCount(row.emptyClaims)} (${row.emptyRate.toFixed(1)}%)` : '—',
    },
    {
      title: 'Ken nhận',
      dataIndex: 'kenTotal',
      width: 130,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'kenTotal' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => <Typography.Text strong>{formatCount(v)}</Typography.Text>,
    },
    {
      title: 'Nhặt gần nhất',
      dataIndex: 'lastClaimAt',
      width: 150,
      render: (v: string) => formatDateTime(v),
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
        <DateRangeFilter
          from={from}
          to={to}
          onFromChange={setFrom}
          onToChange={setTo}
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
                  value={`${formatCount(data.overview.manualChests)} / ${formatCount(data.overview.autoChests)}`}
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
                <RTooltip formatter={(value) => formatCount(Number(value))} />
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
                pageSize: USER_STATS_PAGE_SIZE,
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
