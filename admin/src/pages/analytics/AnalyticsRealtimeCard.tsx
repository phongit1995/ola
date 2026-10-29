import { useState } from 'react'
import type { UseQueryResult } from '@tanstack/react-query'
import { Alert, Badge, Card, Col, Row, Segmented, Space, Spin, Statistic, Table, Tag, Typography } from 'antd'
import { Bar, BarChart, CartesianGrid, ResponsiveContainer, Tooltip as RTooltip, XAxis, YAxis } from 'recharts'
import { errorMessage } from '@/lib/apiError'
import { formatCount, formatDateTime } from '@/lib/format'
import type { AnalyticsNamedRow, AnalyticsRealtime } from '@/types'
import { countryColumns, realtimeEventColumns } from './columns'
import {
  REALTIME_EVENT_ROWS,
  REALTIME_EVENTS_TRUNCATED_HINT,
  REALTIME_METRIC_META,
  REALTIME_METRIC_OPTIONS,
  SOURCE_LABEL,
  type RealtimeMetric,
} from './constants'
import { formatMinutesAgo, minutesAgoLabel, platformColor, platformLabel } from './utils'

const REALTIME_TITLE = 'Đang hoạt động trong 30 phút qua'

function RealtimeTitle({ complete }: { complete: boolean }) {
  return (
    <Space size={8}>
      {complete ? <Badge status="processing" color="#52c41a" /> : <Badge status="warning" />}
      {REALTIME_TITLE}
    </Space>
  )
}

interface AnalyticsRealtimeCardProps {
  realtime: UseQueryResult<AnalyticsRealtime>
}

export function AnalyticsRealtimeCard({ realtime }: AnalyticsRealtimeCardProps) {
  const [metric, setMetric] = useState<RealtimeMetric>('activeUsers')
  const { data } = realtime

  if (!data) {
    return (
      <Card title={REALTIME_TITLE}>
        {realtime.isError ? (
          <Alert type="error" showIcon title={errorMessage(realtime.error, 'Không gọi được server')} />
        ) : (
          <div style={{ textAlign: 'center', padding: 40 }}>
            <Spin />
          </div>
        )}
      </Card>
    )
  }

  const failed = data.sources.filter((source) => source.error)
  if (data.sources.length > 0 && failed.length === data.sources.length) {
    return (
      <Card title={<RealtimeTitle complete={false} />}>
        <Space orientation="vertical" style={{ width: '100%' }}>
          {failed.map((source) => (
            <Alert key={source.source} type="error" showIcon title={SOURCE_LABEL[source.source]} description={source.error} />
          ))}
        </Space>
      </Card>
    )
  }

  const stale = realtime.isError
  const meta = REALTIME_METRIC_META[metric]

  return (
    <Card
      title={<RealtimeTitle complete={failed.length === 0 && !stale} />}
      extra={
        data.fetchedAt && <Typography.Text type="secondary">Cập nhật {formatDateTime(data.fetchedAt)}</Typography.Text>
      }
    >
      <Space orientation="vertical" size={16} style={{ width: '100%' }}>
        {failed.map((source) => (
          <Alert
            key={source.source}
            type="warning"
            showIcon
            title={`Thiếu ${SOURCE_LABEL[source.source]}`}
            description={source.error}
          />
        ))}
        {stale && (
          <Alert
            type="warning"
            showIcon
            title={`Số cũ${data.fetchedAt ? ` lúc ${formatDateTime(data.fetchedAt)}` : ''}, lần tải lại gần nhất bị lỗi`}
          />
        )}
        {data.eventsTruncated && <Alert type="warning" showIcon title={REALTIME_EVENTS_TRUNCATED_HINT} />}

        <Row gutter={[24, 16]}>
          <Col xs={24} md={8}>
            <Space orientation="vertical" size={16}>
              <Statistic groupSeparator="." title="Người dùng" value={data.activeUsers} />
              {data.platforms.length > 0 && (
                <Space size={[4, 4]} wrap>
                  {data.platforms.map((row) => (
                    <Tag key={row.platform} color={platformColor(row.platform)}>
                      {platformLabel(row.platform)}: {formatCount(row.activeUsers)}
                    </Tag>
                  ))}
                </Space>
              )}
              <Statistic groupSeparator="." title="Số lượng sự kiện" value={data.eventCount} />
            </Space>
          </Col>
          <Col xs={24} md={16}>
            <Segmented<RealtimeMetric> size="small" options={REALTIME_METRIC_OPTIONS} value={metric} onChange={setMetric} />
            <ResponsiveContainer width="100%" height={200}>
              <BarChart data={data.minutes} margin={{ top: 12, right: 24, bottom: 0, left: 0 }}>
                <CartesianGrid vertical={false} strokeDasharray="3 3" stroke="#eee" />
                <XAxis
                  dataKey="minutesAgo"
                  tickFormatter={formatMinutesAgo}
                  fontSize={12}
                  interval="preserveStartEnd"
                  minTickGap={24}
                />
                <YAxis fontSize={12} allowDecimals={false} width={40} />
                <RTooltip
                  labelFormatter={(label) => minutesAgoLabel(Number(label))}
                  formatter={(value) => [formatCount(Number(value)), meta.label]}
                />
                <Bar dataKey={metric} fill={meta.color} radius={[2, 2, 0, 0]} isAnimationActive={false} />
              </BarChart>
            </ResponsiveContainer>
          </Col>
        </Row>
        {data.usersSummed && (
          <Typography.Text type="secondary">
            Cộng từ 2 property nên ai dùng cả app lẫn web được tính 2 lần.
          </Typography.Text>
        )}

        <Row gutter={[16, 16]}>
          <Col xs={24} lg={15}>
            <Card type="inner" size="small" title="Sự kiện theo loại" style={{ height: '100%' }}>
              <Table<AnalyticsNamedRow>
                rowKey="name"
                size="small"
                columns={realtimeEventColumns(data.eventCount)}
                dataSource={data.events}
                pagination={false}
                scroll={data.events.length > REALTIME_EVENT_ROWS ? { y: 360 } : undefined}
                locale={{ emptyText: 'Không có sự kiện nào trong 30 phút qua' }}
              />
            </Card>
          </Col>
          <Col xs={24} lg={9}>
            <Card type="inner" size="small" title="Quốc gia" style={{ height: '100%' }}>
              <Table<AnalyticsNamedRow>
                rowKey="name"
                size="small"
                columns={countryColumns}
                dataSource={data.countries}
                pagination={false}
                locale={{ emptyText: 'Không có ai trong 30 phút qua' }}
              />
            </Card>
          </Col>
        </Row>
      </Space>
    </Card>
  )
}
