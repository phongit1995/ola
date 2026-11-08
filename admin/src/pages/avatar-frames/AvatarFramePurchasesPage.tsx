import { useMemo, useState } from 'react'
import {
  Button,
  Card,
  Col,
  Empty,
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
import { ReloadOutlined } from '@ant-design/icons'
import { UserCell } from '@/components/UserCell'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { toIsoRange } from '@/lib/dateRange'
import { formatCount, formatDateTime, formatKen } from '@/lib/format'
import { PAGE_SIZE } from '@/lib/constants'
import type {
  AdminAvatarFramePurchase,
  AvatarFramePurchaseSource,
  AvatarFramePurchaseTotals,
  AvatarFrameSalesRow,
} from '@/types'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { AVATAR_FRAME_SECTION_LINKS } from '@/pages/shop/sections'
import { AvatarFrameCell, AvatarFrameImage } from './AvatarFrameCell'
import { avatarFrameName } from './utils'
import { useAvatarFramePurchases, useAvatarFramePurchaseStats } from './useAvatarFrameQueries'
import { AVATAR_FRAME_SOURCE_META, AVATAR_FRAME_STATS_DEFAULT_DAYS } from './constants'

function TotalsCard({
  title,
  totals,
  highlight,
}: {
  title: string
  totals?: AvatarFramePurchaseTotals
  highlight?: boolean
}) {
  return (
    <Card>
      <Statistic
        groupSeparator="."
        title={title}
        value={totals?.ken ?? 0}
        suffix="KEN"
        styles={highlight ? { content: { color: '#3f8600' } } : undefined}
      />
      <Typography.Text type="secondary">
        {formatCount(totals?.count ?? 0)} lượt · {formatCount(totals?.giftCount ?? 0)} tặng ·{' '}
        {formatCount(totals?.buyers ?? 0)} người mua
      </Typography.Text>
    </Card>
  )
}

function TopFrameTile({ row, rank }: { row: AvatarFrameSalesRow; rank: number }) {
  return (
    <div
      style={{
        display: 'flex',
        alignItems: 'center',
        gap: 10,
        padding: 8,
        border: '1px solid #f0f0f0',
        borderRadius: 8,
      }}
    >
      <Typography.Text type="secondary" style={{ width: 20, textAlign: 'center' }}>
        {rank}
      </Typography.Text>
      <AvatarFrameImage frameId={row.frameId} size={56} />
      <div style={{ minWidth: 0, flex: 1 }}>
        <Typography.Text strong ellipsis style={{ display: 'block' }}>
          {avatarFrameName(row.frameId)}
        </Typography.Text>
        <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
          #{row.frameId} · {formatCount(row.count)} lượt
          {row.giftCount > 0 ? ` (${formatCount(row.giftCount)} tặng)` : ''}
        </Typography.Text>
        <Typography.Text strong style={{ fontSize: 13 }}>
          {formatKen(row.ken)}
        </Typography.Text>
      </div>
    </div>
  )
}

export function AvatarFramePurchasesPage() {
  const [mode, setMode] = useState<AvatarFramePurchaseSource | ''>('')
  const [search, setSearch] = useState('')
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')
  const [page, setPage] = useState(1)

  const range = useMemo(() => toIsoRange(from, to), [from, to])
  const hasRange = Boolean(from || to)
  const rangeLabel = hasRange
    ? 'Trong khoảng đã chọn'
    : `${AVATAR_FRAME_STATS_DEFAULT_DAYS} ngày gần nhất`

  const params = useMemo(
    () => ({
      mode: mode || undefined,
      search: search || undefined,
      ...range,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [mode, search, range, page],
  )
  const { data, isFetching, refetch } = useAvatarFramePurchases(params)
  const {
    data: stats,
    isFetching: statsFetching,
    refetch: refetchStats,
  } = useAvatarFramePurchaseStats(range)

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
    }
  }

  const columns: TableColumnsType<AdminAvatarFramePurchase> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 135,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Khung',
      dataIndex: 'frameId',
      width: 220,
      render: (frameId: string) => <AvatarFrameCell frameId={frameId} />,
    },
    {
      title: 'Người mua / tặng',
      key: 'buyer',
      width: 180,
      render: (_, row) => <UserCell user={row.buyer} />,
    },
    {
      title: 'Hình thức',
      dataIndex: 'source',
      width: 100,
      render: (value: AvatarFramePurchaseSource) => {
        const meta = AVATAR_FRAME_SOURCE_META[value] ?? { label: value, color: 'default' }
        return <Tag color={meta.color}>{meta.label}</Tag>
      },
    },
    {
      title: 'Người nhận',
      key: 'recipient',
      width: 180,
      render: (_, row) =>
        row.recipient ? (
          <UserCell user={row.recipient} />
        ) : (
          <Typography.Text type="secondary">—</Typography.Text>
        ),
    },
    {
      title: 'KEN',
      dataIndex: 'kenPrice',
      width: 100,
      align: 'right',
      render: (value: number) => <Typography.Text strong>{formatCount(value)}</Typography.Text>,
    },
  ]

  return (
    <Space orientation="vertical" size={16} style={{ width: '100%' }}>
      <ShopSectionNav links={AVATAR_FRAME_SECTION_LINKS} />
      <Row gutter={[16, 16]}>
        <Col xs={24} md={8}>
          <TotalsCard title="Hôm nay" totals={stats?.today} highlight />
        </Col>
        <Col xs={24} md={8}>
          <TotalsCard title="Tháng này" totals={stats?.thisMonth} highlight />
        </Col>
        <Col xs={24} md={8}>
          <TotalsCard title={rangeLabel} totals={stats?.range} />
        </Col>
      </Row>

      <Card>
        <Space wrap>
          <Select
            allowClear
            placeholder="Hình thức"
            value={mode || undefined}
            onChange={(value) => resetPage(setMode)(value ?? '')}
            style={{ width: 150 }}
            options={Object.entries(AVATAR_FRAME_SOURCE_META).map(([value, meta]) => ({
              value,
              label: meta.label,
            }))}
          />
          <Input.Search
            allowClear
            placeholder="Username, tên hoặc mã khung (001)"
            onSearch={(value) => resetPage(setSearch)(value.trim())}
            style={{ width: 300 }}
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

      <Card
        title={`Khung bán chạy · ${rangeLabel.toLowerCase()}`}
        extra={<Typography.Text type="secondary">Tối đa 20 khung</Typography.Text>}
        loading={statsFetching && !stats}
      >
        {stats?.topFrames.length ? (
          <div
            style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fill, minmax(220px, 1fr))',
              gap: 12,
            }}
          >
            {stats.topFrames.map((row, index) => (
              <TopFrameTile key={row.frameId} row={row} rank={index + 1} />
            ))}
          </div>
        ) : (
          <Empty description="Chưa có lượt mua nào trong khoảng này" />
        )}
      </Card>

      <Card title="Lịch sử mua" styles={{ body: { paddingTop: 0 } }}>
        <Table<AdminAvatarFramePurchase>
          rowKey="id"
          size="small"
          loading={isFetching}
          columns={columns}
          dataSource={data?.items ?? []}
          scroll={{ x: 915 }}
          pagination={{
            current: page,
            pageSize: PAGE_SIZE,
            total: data?.total ?? 0,
            showSizeChanger: false,
            showTotal: (total) => `${formatCount(total)} lượt mua`,
            onChange: setPage,
          }}
          locale={{ emptyText: 'Chưa có lượt mua khung nào' }}
        />
      </Card>
    </Space>
  )
}
