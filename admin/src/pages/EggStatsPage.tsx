import { useMemo, useState } from 'react'
import { Avatar, Card, Col, Empty, Row, Select, Space, Spin, Statistic, Table, Tag, Typography } from 'antd'
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
import { useEggPacks, useEggStats } from '@/hooks/useEgg'
import type { EggCategoryType, EggStatsPack, EggStatsPlayer, EggStatsReward } from '@/types'

const CATEGORY_META: Record<EggCategoryType, { label: string; color: string }> = {
  nothing: { label: 'Không trúng', color: '#94a3b8' },
  vip_icon: { label: 'VIP icon', color: '#faad14' },
  ken: { label: 'Ken', color: '#2563eb' },
  vip_days: { label: 'Ngày VIP', color: '#5b8c2a' },
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
    render: (value: number) => vn(value),
  },
]

const packColumns: ColumnsType<EggStatsPack> = [
  { title: 'Gói', dataIndex: 'packName' },
  { title: 'Lượt', dataIndex: 'draws', width: 90, align: 'right', render: (v: number) => vn(v) },
  { title: 'Ken thu', dataIndex: 'kenIn', width: 120, align: 'right', render: (v: number) => vn(v) },
  { title: 'Ken trả', dataIndex: 'kenOut', width: 120, align: 'right', render: (v: number) => vn(v) },
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

const playerColumns: ColumnsType<EggStatsPlayer> = [
  {
    title: 'Người chơi',
    key: 'user',
    render: (_, row) => (
      <Space>
        <Avatar size="small" src={row.user.avatar || undefined}>
          {row.user.fullName?.[0] ?? row.user.username?.[0] ?? '?'}
        </Avatar>
        <div>
          <Typography.Text strong>{row.user.fullName || row.user.username}</Typography.Text>
          <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
            @{row.user.username}
          </Typography.Text>
        </div>
      </Space>
    ),
  },
  { title: 'Lượt', dataIndex: 'draws', width: 90, align: 'right', render: (v: number) => vn(v) },
  {
    title: 'Ken đã chi',
    dataIndex: 'kenSpent',
    width: 130,
    align: 'right',
    render: (v: number) => vn(v),
  },
]

export function EggStatsPage() {
  const [from, setFrom] = useState(() => isoDate(new Date(Date.now() - 29 * 24 * 60 * 60 * 1000)))
  const [to, setTo] = useState(() => isoDate(new Date()))
  const [packId, setPackId] = useState<string | undefined>(undefined)

  const { data: packs } = useEggPacks()
  const params = useMemo(
    () => ({
      packId,
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
    }),
    [packId, from, to],
  )
  const { data, isFetching } = useEggStats(params)

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
                <Statistic title="Lượt đập" value={data.overview.totalDraws} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic title="Người chơi" value={data.overview.uniquePlayers} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic title="Ken thu vào" value={data.overview.kenIn} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic title="Ken trả ra" value={data.overview.kenOut} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic
                  title="Lãi ròng (Ken)"
                  value={data.overview.netKen}
                  valueStyle={{ color: data.overview.netKen >= 0 ? '#3f8600' : '#cf1322' }}
                />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic title="Tỉ lệ trúng" value={data.overview.winRate} precision={1} suffix="%" />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic title="Ngày VIP trả ra" value={data.overview.vipDaysOut} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic title="VIP icon trao" value={data.overview.vipIconsOut} />
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
                <RTooltip formatter={(value) => vn(Number(value))} />
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
                    <RTooltip formatter={(value, name) => [`${vn(Number(value))} lượt`, name]} />
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

          <Card title="Top người chơi (theo Ken đã chi)">
            <Table<EggStatsPlayer>
              rowKey={(row) => row.user.id}
              size="small"
              columns={playerColumns}
              dataSource={data.topPlayers}
              pagination={false}
            />
          </Card>
        </>
      )}
    </Space>
  )
}
