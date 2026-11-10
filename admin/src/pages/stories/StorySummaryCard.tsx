import { Card, Col, Row, Statistic, Typography } from 'antd'
import { useStorySummary } from './useStoryQueries'
import { formatCount, formatDateTime } from '@/lib/format'
import { percent } from './utils'

export function StorySummaryCard() {
  const { data: summary } = useStorySummary()
  return (
    <Card>
      <Row gutter={[16, 16]}>
        <Col xs={12} md={6}>
          <Statistic
            groupSeparator="."
            title="Truyện"
            value={summary?.stories ?? 0}
            suffix={
              <Typography.Text type="secondary" style={{ fontSize: 13 }}>
                ({formatCount(summary?.longStories ?? 0)} dài ·{' '}
                {formatCount(summary?.shortStories ?? 0)} ngắn)
              </Typography.Text>
            }
          />
        </Col>
        <Col xs={12} md={4}>
          <Statistic groupSeparator="." title="Đang ẩn" value={summary?.hiddenStories ?? 0} />
        </Col>
        <Col xs={12} md={4}>
          <Statistic groupSeparator="." title="Chương" value={summary?.chapters ?? 0} />
        </Col>
        <Col xs={12} md={5}>
          <Statistic
            groupSeparator="."
            title="Chương đã có nội dung"
            value={summary?.contentChapters ?? 0}
            suffix={
              <Typography.Text type="secondary" style={{ fontSize: 13 }}>
                ({percent(summary?.contentChapters ?? 0, summary?.chapters ?? 0)}%)
              </Typography.Text>
            }
          />
        </Col>
        <Col xs={24} md={5}>
          <Statistic
            title="Lần nạp gần nhất"
            value={formatDateTime(summary?.lastCrawledAt)}
            styles={{ content: { fontSize: 18 } }}
          />
        </Col>
      </Row>
    </Card>
  )
}
