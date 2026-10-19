import { useMemo, useState } from 'react'
import {
  Button,
  Card,
  Col,
  Input,
  Row,
  Select,
  Space,
  Statistic,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { CrownOutlined, ReloadOutlined } from '@ant-design/icons'
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
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { toIsoRange } from '@/lib/dateRange'
import { formatCount, formatDateTime } from '@/lib/format'
import { PAGE_SIZE } from '@/lib/constants'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import type {
  AdminVipPurchase,
  VipPurchaseBreakdownItem,
  VipPurchaseKind,
  VipPurchaseMode,
} from '@/types'
import { useVipPurchases, useVipPurchaseStats } from './useVipPurchaseQueries'
import { PURCHASE_KIND_META, PURCHASE_MODE_META } from './constants'

function VipItemCell({
  kind,
  name,
  vipIconId,
  days,
}: {
  kind: VipPurchaseKind
  name: string
  vipIconId?: number
  days?: number
}) {
  if (kind === 'icon' && vipIconId) {
    return (
      <Space>
        <img
          src={vipIconUrl(vipIconId)}
          alt={vipName(vipIconId)}
          width={28}
          height={28}
          style={{ objectFit: 'contain' }}
        />
        <Typography.Text strong>{vipName(vipIconId)}</Typography.Text>
        <Tag>#{vipIconId}</Tag>
      </Space>
    )
  }
  return (
    <Space>
      <CrownOutlined style={{ color: '#faad14', fontSize: 18 }} />
      <Typography.Text strong>{name}</Typography.Text>
      {days ? <Tag>+{formatCount(days)} ngày</Tag> : null}
    </Space>
  )
}

export function VipPurchasesPage() {
  const [kind, setKind] = useState<VipPurchaseKind | ''>('')
  const [mode, setMode] = useState<VipPurchaseMode | ''>('')
  const [search, setSearch] = useState('')
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')
  const [page, setPage] = useState(1)

  const range = useMemo(() => toIsoRange(from, to), [from, to])

  const params = useMemo(
    () => ({
      kind: kind || undefined,
      mode: mode || undefined,
      search: search || undefined,
      ...range,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [kind, mode, search, range, page],
  )
  const { data, isFetching, refetch } = useVipPurchases(params)
  const { data: stats, isFetching: statsFetching, refetch: refetchStats } = useVipPurchaseStats(range)

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
    }
  }

  const columns: TableColumnsType<AdminVipPurchase> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 135,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Người nhận',
      key: 'user',
      width: 170,
      render: (_, row) =>
        row.user ? <UserCell user={row.user} /> : <Typography.Text type="secondary">—</Typography.Text>,
    },
    {
      title: 'Loại',
      dataIndex: 'kind',
      width: 105,
      render: (value: VipPurchaseKind) => (
        <Tag color={PURCHASE_KIND_META[value].color}>{PURCHASE_KIND_META[value].label}</Tag>
      ),
    },
    {
      title: 'VIP đã mua',
      key: 'item',
      width: 240,
      render: (_, row) => (
        <VipItemCell kind={row.kind} name={row.name} vipIconId={row.vipIconId} days={row.days} />
      ),
    },
    {
      title: 'Hình thức',
      key: 'mode',
      width: 110,
      render: (_, row) => {
        const meta = PURCHASE_MODE_META[row.source === 'gift' ? 'gift' : 'self']
        return <Tag color={meta.color}>{meta.label}</Tag>
      },
    },
    {
      title: 'Người tặng',
      key: 'giver',
      width: 170,
      render: (_, row) =>
        row.giver ? <UserCell user={row.giver} /> : <Typography.Text type="secondary">—</Typography.Text>,
    },
    {
      title: 'KEN',
      dataIndex: 'kenPaid',
      width: 90,
      align: 'right',
      render: (value: number) => <Typography.Text strong>{formatCount(value)}</Typography.Text>,
    },
    {
      title: 'Hạn VIP sau mua',
      dataIndex: 'vipEndTime',
      width: 135,
      render: (value?: string) => formatDateTime(value),
    },
  ]

  const breakdownColumns: TableColumnsType<VipPurchaseBreakdownItem> = [
    {
      title: 'Gói / icon',
      key: 'name',
      render: (_, row) => <VipItemCell kind={row.kind} name={row.name} vipIconId={row.vipIconId} />,
    },
    {
      title: 'Lượt',
      dataIndex: 'count',
      width: 110,
      align: 'right',
      render: (value: number, row) => (
        <Space direction="vertical" size={0} style={{ alignItems: 'flex-end' }}>
          <Typography.Text>{formatCount(value)}</Typography.Text>
          {row.giftCount > 0 ? (
            <Typography.Text type="secondary" style={{ fontSize: 12 }}>
              {formatCount(row.giftCount)} tặng
            </Typography.Text>
          ) : null}
        </Space>
      ),
    },
    {
      title: 'KEN',
      dataIndex: 'ken',
      width: 120,
      align: 'right',
      render: (value: number) => <Typography.Text strong>{formatCount(value)}</Typography.Text>,
    },
  ]

  const bucketLabel = stats?.bucket === 'month' ? 'tháng' : 'ngày'

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Row gutter={[16, 16]}>
        <Col xs={12} md={8} xxl={4}>
          <Card>
            <Statistic
              groupSeparator="."
              title="Hôm nay"
              value={stats?.today.ken ?? 0}
              suffix="KEN"
              valueStyle={{ color: '#3f8600' }}
            />
            <Typography.Text type="secondary">{formatCount(stats?.today.count ?? 0)} lượt mua</Typography.Text>
          </Card>
        </Col>
        <Col xs={12} md={8} xxl={4}>
          <Card>
            <Statistic
              groupSeparator="."
              title="Tháng này"
              value={stats?.thisMonth.ken ?? 0}
              suffix="KEN"
              valueStyle={{ color: '#3f8600' }}
            />
            <Typography.Text type="secondary">
              {formatCount(stats?.thisMonth.count ?? 0)} lượt mua
            </Typography.Text>
          </Card>
        </Col>
        <Col xs={12} md={8} xxl={4}>
          <Card>
            <Statistic groupSeparator="." title="Trong khoảng đã chọn" value={stats?.range.ken ?? 0} suffix="KEN" />
            <Typography.Text type="secondary">
              {formatCount(stats?.range.count ?? 0)} lượt · {formatCount(stats?.range.buyers ?? 0)} người mua
            </Typography.Text>
          </Card>
        </Col>
        <Col xs={12} md={8} xxl={4}>
          <Card>
            <Statistic groupSeparator="." title="Gói ngày VIP" value={stats?.range.packageKen ?? 0} suffix="KEN" />
            <Typography.Text type="secondary">
              {formatCount(stats?.range.packageCount ?? 0)} lượt trong khoảng
            </Typography.Text>
          </Card>
        </Col>
        <Col xs={12} md={8} xxl={4}>
          <Card>
            <Statistic groupSeparator="." title="Icon VIP" value={stats?.range.iconKen ?? 0} suffix="KEN" />
            <Typography.Text type="secondary">
              {formatCount(stats?.range.iconCount ?? 0)} lượt trong khoảng
            </Typography.Text>
          </Card>
        </Col>
        <Col xs={12} md={8} xxl={4}>
          <Card>
            <Statistic
              groupSeparator="."
              title="Đang còn VIP"
              value={stats?.activeVipUsers ?? 0}
              suffix="người"
            />
            <Typography.Text type="secondary">Hạn gói ngày chưa hết</Typography.Text>
          </Card>
        </Col>
      </Row>

      <Card>
        <Space wrap>
          <Select
            allowClear
            placeholder="Loại"
            value={kind || undefined}
            onChange={(value) => resetPage(setKind)(value ?? '')}
            style={{ width: 160 }}
            options={Object.entries(PURCHASE_KIND_META).map(([value, meta]) => ({
              value,
              label: meta.label,
            }))}
          />
          <Select
            allowClear
            placeholder="Hình thức"
            value={mode || undefined}
            onChange={(value) => resetPage(setMode)(value ?? '')}
            style={{ width: 150 }}
            options={Object.entries(PURCHASE_MODE_META).map(([value, meta]) => ({
              value,
              label: meta.label,
            }))}
          />
          <Input.Search
            allowClear
            placeholder="Username, tên người nhận / người tặng"
            onSearch={(value) => resetPage(setSearch)(value.trim())}
            style={{ width: 280 }}
          />
          <DateRangeFilter
            from={from}
            to={to}
            onFromChange={resetPage(setFrom)}
            onToChange={resetPage(setTo)}
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

      <Row gutter={[16, 16]}>
        <Col xs={24} lg={14}>
          <Card title={`Doanh thu VIP theo ${bucketLabel}`}>
            <ResponsiveContainer width="100%" height={300}>
              <ComposedChart data={stats?.series ?? []} margin={{ top: 8, right: 8, bottom: 8, left: 8 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis dataKey="date" fontSize={12} />
                <YAxis yAxisId="left" fontSize={12} />
                <YAxis yAxisId="right" orientation="right" fontSize={12} allowDecimals={false} />
                <RTooltip
                  formatter={(value, name) =>
                    name === 'Lượt mua'
                      ? [formatCount(Number(value)), name]
                      : [`${formatCount(Number(value))} KEN`, name]
                  }
                />
                <Legend />
                <Bar yAxisId="left" stackId="ken" dataKey="packageKen" name="Gói ngày VIP" fill="#faad14" />
                <Bar
                  yAxisId="left"
                  stackId="ken"
                  dataKey="iconKen"
                  name="Icon VIP"
                  fill="#722ed1"
                  radius={[4, 4, 0, 0]}
                />
                <Line yAxisId="right" type="monotone" dataKey="count" name="Lượt mua" stroke="#5b8c2a" strokeWidth={2} />
              </ComposedChart>
            </ResponsiveContainer>
          </Card>
        </Col>
        <Col xs={24} lg={10}>
          <Card
            title="Theo gói / icon"
            extra={
              <Typography.Text type="secondary">
                {formatCount(stats?.range.giftCount ?? 0)} lượt tặng
              </Typography.Text>
            }
          >
            <Table<VipPurchaseBreakdownItem>
              rowKey={(row) => `${row.kind}:${row.name}`}
              size="small"
              columns={breakdownColumns}
              dataSource={stats?.breakdown ?? []}
              loading={statsFetching}
              pagination={false}
              scroll={{ y: 252 }}
              locale={{ emptyText: 'Chưa có lượt mua nào trong khoảng đã chọn' }}
            />
          </Card>
        </Col>
      </Row>

      <Table<AdminVipPurchase>
        rowKey="id"
        size="small"
        loading={isFetching}
        columns={columns}
        dataSource={data?.items ?? []}
        scroll={{ x: 1145 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showSizeChanger: false,
          showTotal: (total) => `${formatCount(total)} lượt mua`,
          onChange: setPage,
        }}
        locale={{ emptyText: 'Chưa có lượt mua VIP nào' }}
      />
    </Space>
  )
}
