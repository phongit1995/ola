import { useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Avatar,
  Button,
  Card,
  Col,
  DatePicker,
  Input,
  Row,
  Select,
  Space,
  Statistic,
  Table,
  Tag,
  Typography,
} from 'antd'
import { ArrowLeftOutlined } from '@ant-design/icons'
import type { ColumnsType, TablePaginationConfig } from 'antd/es/table'
import type { SorterResult } from 'antd/es/table/interface'
import type { Dayjs } from 'dayjs'
import { useWheelStats, useWheelUserStats, useWheelVipStats, useWheels } from '@/hooks/useWheel'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import type {
  WheelStatsKind,
  WheelStatsReward,
  WheelStatsWheel,
  WheelUserStatsItem,
  WheelUserStatsSortBy,
  WheelVipStatsRow,
} from '@/types'
import { kindMeta } from './wheel/wheelHelpers'

const USER_STATS_SORTS: WheelUserStatsSortBy[] = ['kenSpent', 'kenWon', 'netKen', 'spins', 'vipDays']
const USER_PAGE_SIZE = 10

function vn(n: number) {
  return n.toLocaleString('vi-VN')
}

function NetText({ value }: { value: number }) {
  if (value > 0) return <Typography.Text type="success">+{vn(value)}</Typography.Text>
  if (value < 0) return <Typography.Text type="danger">{vn(value)}</Typography.Text>
  return <Typography.Text>0</Typography.Text>
}

const vipColumns: ColumnsType<WheelVipStatsRow> = [
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
    title: 'Item trúng',
    dataIndex: 'itemWins',
    width: 110,
    align: 'right',
    render: (v: number) => vn(v),
  },
  {
    title: 'Lượt trúng ngày VIP',
    dataIndex: 'dayWins',
    width: 150,
    align: 'right',
    render: (v: number) => vn(v),
  },
  {
    title: 'Tổng ngày VIP',
    dataIndex: 'vipDays',
    width: 130,
    align: 'right',
    render: (v: number) => vn(v),
  },
]

export function WheelStatsPage() {
  const navigate = useNavigate()
  const { data: wheels } = useWheels()
  const [wheelId, setWheelId] = useState<string | undefined>(undefined)
  const [range, setRange] = useState<[Dayjs, Dayjs] | null>(null)

  const params = useMemo(
    () => ({
      ...(wheelId ? { wheelId } : {}),
      ...(range ? { from: range[0].startOf('day').toISOString(), to: range[1].endOf('day').toISOString() } : {}),
    }),
    [wheelId, range]
  )

  const { data, isFetching } = useWheelStats(params)
  const overview = data?.overview

  const [userSort, setUserSort] = useState<WheelUserStatsSortBy>('kenSpent')
  const [userPage, setUserPage] = useState(1)
  const [userSearch, setUserSearch] = useState('')

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
  const { data: userStats, isFetching: userStatsFetching } = useWheelUserStats(userStatsParams)
  const { data: vipStats, isFetching: vipStatsFetching } = useWheelVipStats(params)

  function onUserTableChange(
    _pagination: TablePaginationConfig,
    _filters: unknown,
    sorter: SorterResult<WheelUserStatsItem> | SorterResult<WheelUserStatsItem>[],
  ) {
    const single = Array.isArray(sorter) ? sorter[0] : sorter
    const field = single?.order ? String(single.field) : 'kenSpent'
    const next = USER_STATS_SORTS.find((key) => key === field) ?? 'kenSpent'
    if (next !== userSort) {
      setUserSort(next)
      setUserPage(1)
    }
  }

  const userColumns: ColumnsType<WheelUserStatsItem> = [
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
      dataIndex: 'spins',
      width: 90,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'spins' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => vn(v),
    },
    {
      title: 'Trúng',
      key: 'winRate',
      width: 130,
      align: 'right',
      render: (_, row) => `${vn(row.winSpins)} (${row.winRate.toFixed(1)}%)`,
    },
    {
      title: 'Lượt free',
      dataIndex: 'freeSpins',
      width: 100,
      align: 'right',
      render: (v: number) => vn(v),
    },
    {
      title: 'Ken chi',
      dataIndex: 'kenSpent',
      width: 120,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'kenSpent' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => vn(v),
    },
    {
      title: 'Ken trúng',
      dataIndex: 'kenWon',
      width: 120,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'kenWon' ? 'descend' : null,
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
      title: 'Ngày VIP',
      dataIndex: 'vipDays',
      width: 100,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'vipDays' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => vn(v),
    },
    {
      title: 'Item VIP',
      dataIndex: 'vipItems',
      width: 90,
      align: 'right',
      render: (v: number) => vn(v),
    },
    {
      title: 'Quay gần nhất',
      dataIndex: 'lastSpinAt',
      width: 150,
      render: (v: string) => new Date(v).toLocaleString('vi-VN'),
    },
  ]

  const kindColumns: ColumnsType<WheelStatsKind> = [
    {
      title: 'Loại ô',
      dataIndex: 'segmentKind',
      render: (value) => <Tag color={kindMeta(value).color}>{kindMeta(value).label}</Tag>,
    },
    { title: 'Lượt', dataIndex: 'spins', align: 'right' },
    { title: '%', dataIndex: 'percent', align: 'right', render: (v: number) => `${v.toFixed(1)}%` },
  ]

  const rewardColumns: ColumnsType<WheelStatsReward> = [
    { title: 'Phần thưởng', dataIndex: 'rewardLabel' },
    {
      title: 'Loại',
      dataIndex: 'segmentKind',
      render: (value) => <Tag color={kindMeta(value).color}>{kindMeta(value).label}</Tag>,
    },
    { title: 'Số lần', dataIndex: 'count', align: 'right' },
  ]

  const wheelColumns: ColumnsType<WheelStatsWheel> = [
    { title: 'Vòng quay', dataIndex: 'wheelName' },
    { title: 'Lượt', dataIndex: 'spins', align: 'right' },
    { title: 'Ken thu', dataIndex: 'kenIn', align: 'right', render: (v: number) => v.toLocaleString('vi-VN') },
    { title: 'Ken trả', dataIndex: 'kenOut', align: 'right', render: (v: number) => v.toLocaleString('vi-VN') },
    {
      title: 'RTP',
      dataIndex: 'rtp',
      align: 'right',
      render: (v: number) => {
        const color = v > 100 ? '#c0392b' : v > 70 ? '#d4a017' : '#1f8a3b'
        return <span style={{ color }}>{v.toFixed(1)}%</span>
      },
    },
  ]

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card
        title={
          <Space>
            <Button type="text" icon={<ArrowLeftOutlined />} onClick={() => navigate('/games/wheel')} />
            Thống kê vòng quay
          </Space>
        }
        extra={
          <Space>
            <Select
              allowClear
              placeholder="Tất cả vòng quay"
              style={{ width: 200 }}
              value={wheelId}
              onChange={setWheelId}
              options={(wheels ?? []).map((w) => ({ value: w.id, label: w.name }))}
            />
            <DatePicker.RangePicker value={range} onChange={(v) => setRange(v as [Dayjs, Dayjs] | null)} />
          </Space>
        }
        loading={isFetching && !data}
      >
        <Row gutter={16}>
          <Col span={6}>
            <Statistic groupSeparator="." title="Tổng lượt quay" value={overview?.totalSpins ?? 0} />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="." title="Người chơi" value={overview?.uniquePlayers ?? 0} />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="." title="Tỉ lệ trúng" value={overview?.winRate ?? 0} precision={1} suffix="%" />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="." title="Lượt miễn phí" value={overview?.freeSpins ?? 0} />
          </Col>
        </Row>
        <Row gutter={16} style={{ marginTop: 16 }}>
          <Col span={6}>
            <Statistic groupSeparator="." title="Ken thu" value={overview?.kenIn ?? 0} />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="." title="Ken trả thưởng" value={overview?.kenOut ?? 0} />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="."
              title="Ken ròng"
              value={overview?.netKen ?? 0}
              valueStyle={{ color: (overview?.netKen ?? 0) >= 0 ? '#1f8a3b' : '#c0392b' }}
            />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="." title="Ngày VIP trao" value={overview?.vipDaysOut ?? 0} />
          </Col>
        </Row>
      </Card>

      <Row gutter={16}>
        <Col span={12}>
          <Card title="Theo loại ô" size="small">
            <Table<WheelStatsKind>
              rowKey="segmentKind"
              size="small"
              columns={kindColumns}
              dataSource={data?.byKind ?? []}
              pagination={false}
            />
          </Card>
        </Col>
        <Col span={12}>
          <Card title="Phần thưởng phổ biến" size="small">
            <Table<WheelStatsReward>
              rowKey={(r) => `${r.segmentKind}-${r.rewardLabel}`}
              size="small"
              columns={rewardColumns}
              dataSource={data?.topRewards ?? []}
              pagination={false}
            />
          </Card>
        </Col>
      </Row>

      <Row gutter={16}>
        <Col span={12}>
          <Card title="Theo vòng quay (RTP)" size="small">
            <Table<WheelStatsWheel>
              rowKey="wheelId"
              size="small"
              columns={wheelColumns}
              dataSource={data?.byWheel ?? []}
              pagination={false}
            />
          </Card>
        </Col>
        <Col span={12}>
          <Card title="Thống kê theo loại VIP" size="small">
            <Table<WheelVipStatsRow>
              rowKey="vipTypeId"
              size="small"
              loading={vipStatsFetching}
              columns={vipColumns}
              dataSource={vipStats?.items ?? []}
              pagination={{ pageSize: 10, hideOnSinglePage: true, showSizeChanger: false }}
              locale={{ emptyText: 'Chưa có phần thưởng VIP nào được trúng' }}
            />
          </Card>
        </Col>
      </Row>

      <Card
        title="Thống kê theo người chơi"
        size="small"
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
        <Table<WheelUserStatsItem>
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
    </Space>
  )
}
