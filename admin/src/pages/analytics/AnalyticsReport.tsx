import { Card, Col, Empty, Row, Space, Statistic, Table, Tag, Tooltip, Typography } from 'antd'
import {
  CartesianGrid,
  Cell,
  Legend,
  Line,
  LineChart,
  Pie,
  PieChart,
  ResponsiveContainer,
  Tooltip as RTooltip,
  XAxis,
  YAxis,
} from 'recharts'
import { formatCount } from '@/lib/format'
import type {
  AnalyticsNamedRow,
  AnalyticsOverview,
  AnalyticsPlatform,
  AnalyticsPlatformRow,
  AnalyticsRanking,
  AnalyticsVersionRow,
} from '@/types'
import { countryColumns, eventColumns, platformColumns, screenColumns, versionColumns } from './columns'
import { APPROXIMATE_RANKING_HINT, PLATFORM_META } from './constants'
import { formatChartDate, formatEngagement, platformColor, platformLabel, visiblePlatforms } from './utils'

function KpiCard({ title, value }: { title: string; value: string | number }) {
  return (
    <Col xs={12} md={8} xl={{ flex: '20%' }}>
      <Card style={{ height: '100%' }}>
        <Statistic groupSeparator="." title={title} value={value} />
      </Card>
    </Col>
  )
}

function ApproximateTag({ data, ranking }: { data: AnalyticsOverview; ranking: AnalyticsRanking }) {
  if (!data.approximateRankings.includes(ranking)) return null
  return (
    <Tooltip title={APPROXIMATE_RANKING_HINT}>
      <Tag color="warning">Gần đúng</Tag>
    </Tooltip>
  )
}

interface AnalyticsReportProps {
  data: AnalyticsOverview
  platform: AnalyticsPlatform
}

export function AnalyticsReport({ data, platform }: AnalyticsReportProps) {
  const lines = visiblePlatforms(platform, data.sources)
  const pieData = data.platforms
    .filter((row) => row.activeUsers > 0)
    .map((row) => ({ name: platformLabel(row.platform), value: row.activeUsers, color: platformColor(row.platform) }))

  return (
    <Space orientation="vertical" size={16} style={{ width: '100%' }}>
      <Row gutter={[16, 16]}>
        <KpiCard title="Người dùng hoạt động" value={data.totals.activeUsers} />
        <KpiCard title="Người dùng mới" value={data.totals.newUsers} />
        <KpiCard title="Phiên" value={data.totals.sessions} />
        <KpiCard title="Lượt xem màn hình / trang" value={data.totals.views} />
        <KpiCard title="Tương tác TB / người" value={formatEngagement(data.totals.avgEngagementSeconds)} />
      </Row>
      {data.totals.usersSummed && (
        <Typography.Text type="secondary">
          Mobile và web là 2 property riêng nên số người dùng là cộng của 2 nguồn: ai dùng cả app lẫn web
          được tính 2 lần, tương tác trung bình cũng chia theo số đã cộng này.
        </Typography.Text>
      )}

      <Card title="Người dùng hoạt động theo ngày">
        <ResponsiveContainer width="100%" height={320}>
          <LineChart data={data.timeseries} margin={{ top: 8, right: 16, bottom: 8, left: 0 }}>
            <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
            <XAxis dataKey="date" tickFormatter={formatChartDate} fontSize={12} minTickGap={16} />
            <YAxis fontSize={12} allowDecimals={false} />
            <RTooltip
              labelFormatter={(label) => formatChartDate(String(label))}
              formatter={(value) => formatCount(Number(value))}
            />
            <Legend />
            {lines.map((key) => (
              <Line
                key={key}
                type="monotone"
                dataKey={key}
                name={PLATFORM_META[key].label}
                stroke={PLATFORM_META[key].color}
                strokeWidth={2}
                dot={false}
              />
            ))}
          </LineChart>
        </ResponsiveContainer>
      </Card>

      <Row gutter={[16, 16]}>
        <Col xs={24} lg={9}>
          <Card title="Tỷ lệ người dùng theo nền tảng" style={{ height: '100%' }}>
            {pieData.length === 0 ? (
              <Empty description="Chưa có dữ liệu" />
            ) : (
              <ResponsiveContainer width="100%" height={260}>
                <PieChart>
                  <Pie data={pieData} dataKey="value" nameKey="name" innerRadius={55} outerRadius={95} paddingAngle={2}>
                    {pieData.map((entry) => (
                      <Cell key={entry.name} fill={entry.color} />
                    ))}
                  </Pie>
                  <RTooltip formatter={(value, name) => [`${formatCount(Number(value))} người`, name]} />
                  <Legend />
                </PieChart>
              </ResponsiveContainer>
            )}
          </Card>
        </Col>
        <Col xs={24} lg={15}>
          <Card title="Chi tiết theo nền tảng" style={{ height: '100%' }}>
            <Table<AnalyticsPlatformRow>
              rowKey="platform"
              size="small"
              columns={platformColumns}
              dataSource={data.platforms}
              pagination={false}
              locale={{ emptyText: 'Chưa có dữ liệu' }}
            />
          </Card>
        </Col>
      </Row>

      <Row gutter={[16, 16]}>
        <Col xs={24} lg={14}>
          <Card
            title="Màn hình / trang xem nhiều"
            extra={<ApproximateTag data={data} ranking="screens" />}
            style={{ height: '100%' }}
          >
            <Table<AnalyticsNamedRow>
              rowKey="name"
              size="small"
              columns={screenColumns}
              dataSource={data.screens}
              pagination={false}
              locale={{ emptyText: 'Chưa có dữ liệu' }}
            />
          </Card>
        </Col>
        <Col xs={24} lg={10}>
          <Card title="Quốc gia" extra={<ApproximateTag data={data} ranking="countries" />} style={{ height: '100%' }}>
            <Table<AnalyticsNamedRow>
              rowKey="name"
              size="small"
              columns={countryColumns}
              dataSource={data.countries}
              pagination={false}
              locale={{ emptyText: 'Chưa có dữ liệu' }}
            />
          </Card>
        </Col>
      </Row>

      <Row gutter={[16, 16]}>
        <Col xs={24} lg={14}>
          <Card title="Sự kiện" extra={<ApproximateTag data={data} ranking="events" />} style={{ height: '100%' }}>
            <Table<AnalyticsNamedRow>
              rowKey="name"
              size="small"
              columns={eventColumns}
              dataSource={data.events}
              pagination={false}
              locale={{ emptyText: 'Chưa có dữ liệu' }}
            />
          </Card>
        </Col>
        <Col xs={24} lg={10}>
          <Card title="Phiên bản app" style={{ height: '100%' }}>
            <Table<AnalyticsVersionRow>
              rowKey={(row) => `${row.platform}:${row.version}`}
              size="small"
              columns={versionColumns}
              dataSource={data.appVersions}
              pagination={false}
              locale={{ emptyText: platform === 'web' ? 'Web không có phiên bản app' : 'Chưa có dữ liệu' }}
            />
          </Card>
        </Col>
      </Row>
    </Space>
  )
}
