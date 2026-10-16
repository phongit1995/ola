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
import { useEggPacks, useEggStats, useEggUserStats, useEggVipStats } from './useEggQueries'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import type {
  EggCategoryType,
  EggStatsPack,
  EggStatsReward,
  EggUserStatsItem,
  EggVipStatsRow,
} from '@/types'
import { formatCount, formatDateTime } from '@/lib/format'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { isoDaysAgo, toIsoRange } from '@/lib/dateRange'
import { NetText } from '@/components/NetText'
import { USER_STATS_PAGE_SIZE, useUserStatsTable } from '../useUserStatsTable'
import { CATEGORY_META, USER_STATS_SORTS } from './constants'

const rewardColumns: ColumnsType<EggStatsReward> = [
  {
    title: 'Loại',
    dataIndex: 'categoryType',
    width: 110,
    render: (type: EggCategoryType) => (
      <Tag color={CATEGORY_META[type].color}>{CATEGORY_META[type].label}</Tag>
    ),
  },
  { title: 'Phần thưởng', dataIndex: 'rewardLabel' },
  {
    title: 'Số lần trúng',
    dataIndex: 'count',
    width: 120,
    align: 'right',
    render: (value: number) => formatCount(value),
  },
]

const packColumns: ColumnsType<EggStatsPack> = [
  { title: 'Gói', dataIndex: 'packName' },
  { title: 'Lượt', dataIndex: 'draws', width: 90, align: 'right', render: (v: number) => formatCount(v) },
  { title: 'Ken thu', dataIndex: 'kenIn', width: 120, align: 'right', render: (v: number) => formatCount(v) },
  { title: 'Ken trả', dataIndex: 'kenOut', width: 120, align: 'right', render: (v: number) => formatCount(v) },
  {
    title: 'RTP',
    dataIndex: 'rtp',
    width: 100,
    align: 'right',
    render: (value: number) => (
      <Tag color={value > 100 ? 'red' : value > 70 ? 'gold' : 'green'} style={{ margin: 0 }}>
        {value.toFixed(1)}%
      </Tag>
    ),
  },
]

const vipColumns: ColumnsType<EggVipStatsRow> = [
  {
    title: 'Loại VIP',
    key: 'vip',
    render: (_, row) =>
      row.vipTypeId > 0 ? (
        <Space>
          <Avatar shape="square" size="small" src={vipIconUrl(row.vipTypeId)} />
          <Typography.Text strong>{vipName(row.vipTypeId)}</Typography.Text>
          <Typography.Text type="secondary">#{row.vipTypeId}</Typography.Text>
        </Space>
      ) : (
        <Typography.Text type="secondary">Không gắn loại VIP</Typography.Text>
      ),
  },
  {
    title: 'Icon trúng',
    dataIndex: 'iconWins',
    width: 110,
    align: 'right',
    render: (v: number) => formatCount(v),
  },
  {
    title: 'Lượt trúng ngày VIP',
    dataIndex: 'dayWins',
    width: 150,
    align: 'right',
    render: (v: number) => formatCount(v),
  },
  {
    title: 'Tổng ngày VIP',
    dataIndex: 'vipDays',
    width: 130,
    align: 'right',
    render: (v: number) => formatCount(v),
  },
]

export function EggStatsPage() {
  const [from, setFrom] = useState(() => isoDaysAgo(29))
  const [to, setTo] = useState(() => isoDaysAgo(0))
  const [packId, setPackId] = useState<string | undefined>(undefined)
  const { userSort, userPage, setUserPage, setUserSearch, userQuery, onUserTableChange } =
    useUserStatsTable(USER_STATS_SORTS, 'kenSpent')

  const { data: packs } = useEggPacks()
  const params = useMemo(
    () => ({
      packId,
      ...toIsoRange(from, to),
    }),
    [packId, from, to],
  )
  const { data, isFetching } = useEggStats(params)

  const userStatsParams = useMemo(() => ({ ...params, ...userQuery }), [params, userQuery])
  const { data: userStats, isFetching: userStatsFetching } = useEggUserStats(userStatsParams)
  const { data: vipStats, isFetching: vipStatsFetching } = useEggVipStats(params)

  const userColumns: ColumnsType<EggUserStatsItem> = [
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
      title: 'Lượt',
      dataIndex: 'draws',
      width: 90,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'draws' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => formatCount(v),
    },
    {
      title: 'Trúng',
      key: 'winRate',
      width: 130,
      align: 'right',
      render: (_, row) => `${formatCount(row.winDraws)} (${row.winRate.toFixed(1)}%)`,
    },
    {
      title: 'Ken chi',
      dataIndex: 'kenSpent',
      width: 120,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'kenSpent' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => formatCount(v),
    },
    {
      title: 'Ken trúng',
      dataIndex: 'kenWon',
      width: 120,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'kenWon' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => formatCount(v),
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
      title: 'Ngày VIP',
      dataIndex: 'vipDays',
      width: 100,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'vipDays' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => formatCount(v),
    },
    {
      title: 'Icon',
      dataIndex: 'vipIcons',
      width: 80,
      align: 'right',
      render: (v: number) => formatCount(v),
    },
    {
      title: 'Đập gần nhất',
      dataIndex: 'lastDrawAt',
      width: 150,
      render: (v: string) => formatDateTime(v),
    },
  ]

  const packOptions = (packs ?? []).map((pack) => ({ value: pack.id, label: pack.name }))
  const hasData = (data?.overview.totalDraws ?? 0) > 0

  const categoryPie = (data?.byCategory ?? []).map((row) => ({
    name: CATEGORY_META[row.categoryType].label,
    value: row.draws,
    color: CATEGORY_META[row.categoryType].color,
  }))

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <DateRangeFilter
            from={from}
            to={to}
            onFromChange={setFrom}
            onToChange={setTo}
          />
          <Select
            allowClear
            placeholder="Tất cả gói"
            value={packId}
            onChange={setPackId}
            options={packOptions}
            style={{ width: 220 }}
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
          <Empty description="Chưa có lượt đập nào trong khoảng đã chọn" />
        </Card>
      ) : (
        <>
          <Row gutter={[16, 16]}>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Lượt đập" value={data.overview.totalDraws} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Người chơi" value={data.overview.uniquePlayers} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Ken thu vào" value={data.overview.kenIn} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Ken trả ra" value={data.overview.kenOut} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="."
                  title="Lãi ròng (Ken)"
                  value={data.overview.netKen}
                  valueStyle={{ color: data.overview.netKen >= 0 ? '#3f8600' : '#cf1322' }}
                />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Tỉ lệ trúng" value={data.overview.winRate} precision={1} suffix="%" />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Ngày VIP trả ra" value={data.overview.vipDaysOut} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="VIP icon trao" value={data.overview.vipIconsOut} />
              </Card>
            </Col>
          </Row>

          <Card title={`Lượt đập & Ken theo ${data.bucket === 'month' ? 'tháng' : 'ngày'}`}>
            <ResponsiveContainer width="100%" height={320}>
              <ComposedChart data={data.timeseries} margin={{ top: 8, right: 8, bottom: 8, left: 8 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis dataKey="date" fontSize={12} />
                <YAxis yAxisId="left" fontSize={12} />
                <YAxis yAxisId="right" orientation="right" fontSize={12} />
                <RTooltip formatter={(value) => formatCount(Number(value))} />
                <Legend />
                <Bar yAxisId="left" dataKey="kenIn" name="Ken thu" fill="#2563eb" radius={[4, 4, 0, 0]} />
                <Bar yAxisId="left" dataKey="kenOut" name="Ken trả" fill="#faad14" radius={[4, 4, 0, 0]} />
                <Line yAxisId="right" type="monotone" dataKey="draws" name="Lượt đập" stroke="#5b8c2a" strokeWidth={2} />
              </ComposedChart>
            </ResponsiveContainer>
          </Card>

          <Row gutter={[16, 16]}>
            <Col xs={24} lg={10}>
              <Card title="Phân bố theo loại">
                <ResponsiveContainer width="100%" height={300}>
                  <PieChart>
                    <Pie
                      data={categoryPie}
                      dataKey="value"
                      nameKey="name"
                      innerRadius={60}
                      outerRadius={105}
                      paddingAngle={2}
                    >
                      {categoryPie.map((entry) => (
                        <Cell key={entry.name} fill={entry.color} />
                      ))}
                    </Pie>
                    <RTooltip formatter={(value, name) => [`${formatCount(Number(value))} lượt`, name]} />
                    <Legend />
                  </PieChart>
                </ResponsiveContainer>
              </Card>
            </Col>
            <Col xs={24} lg={14}>
              <Card title="Top phần thưởng trúng nhiều">
                <Table<EggStatsReward>
                  rowKey={(row) => `${row.categoryType}-${row.rewardLabel}`}
                  size="small"
                  columns={rewardColumns}
                  dataSource={data.topRewards}
                  pagination={false}
                  locale={{ emptyText: 'Chưa có phần thưởng nào được trúng' }}
                />
              </Card>
            </Col>
          </Row>

          <Card title="Hiệu quả theo gói">
            <Table<EggStatsPack>
              rowKey="packId"
              size="small"
              columns={packColumns}
              dataSource={data.byPack}
              pagination={false}
            />
          </Card>

          <Card title="Thống kê theo loại VIP">
            <Table<EggVipStatsRow>
              rowKey="vipTypeId"
              size="small"
              loading={vipStatsFetching}
              columns={vipColumns}
              dataSource={vipStats?.items ?? []}
              pagination={{ pageSize: 10, hideOnSinglePage: true, showSizeChanger: false }}
              locale={{ emptyText: 'Chưa có phần thưởng VIP nào được trúng' }}
            />
          </Card>

          <Card
            title="Thống kê theo người chơi"
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
            <Table<EggUserStatsItem>
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
              locale={{ emptyText: 'Chưa có người chơi nào' }}
            />
          </Card>
        </>
      )}
    </Space>
  )
}
