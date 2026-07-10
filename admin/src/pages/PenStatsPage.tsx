import { useMemo, useState } from 'react'
import { Avatar, Card, Col, Empty, Row, Space, Spin, Statistic, Table, Typography } from 'antd'
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
import { usePenStats } from '@/hooks/usePen'
import type { PenResult, PenStatsPlayer } from '@/types'

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

const playerColumns: ColumnsType<PenStatsPlayer> = [
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
  { title: 'Lượt sút', dataIndex: 'shots', width: 100, align: 'right', render: (v: number) => vn(v) },
  {
    title: 'Tổng cược',
    dataIndex: 'staked',
    width: 130,
    align: 'right',
    render: (v: number) => vn(v),
  },
  {
    title: 'Tổng thắng',
    dataIndex: 'won',
    width: 130,
    align: 'right',
    render: (v: number) => vn(v),
  },
]

export function PenStatsPage() {
  const [from, setFrom] = useState(() => isoDate(new Date(Date.now() - 29 * 24 * 60 * 60 * 1000)))
  const [to, setTo] = useState(() => isoDate(new Date()))

  const params = useMemo(
    () => ({
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
    }),
    [from, to],
  )
  const { data, isFetching } = usePenStats(params)

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
              <Card title="Top người chơi (theo tổng cược)">
                <Table<PenStatsPlayer>
                  rowKey={(row) => row.user.id}
                  size="small"
                  columns={playerColumns}
                  dataSource={data.topPlayers}
                  pagination={false}
                  locale={{ emptyText: 'Chưa có người chơi nào' }}
                />
              </Card>
            </Col>
          </Row>
        </>
      )}
    </Space>
  )
}
