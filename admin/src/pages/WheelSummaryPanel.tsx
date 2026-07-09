import { Space, Tag, Typography } from 'antd'
import type { WheelSegment } from '@/types'
import { WheelOddsSunburst } from './WheelOddsSunburst'
import { formatPercent, kindBreakdown } from './wheel/wheelHelpers'

interface WheelSummaryPanelProps {
  segments: WheelSegment[]
}

export function WheelSummaryPanel({ segments }: WheelSummaryPanelProps) {
  const { stats, totalPct, balanced } = kindBreakdown(segments)
  return (
    <div
      style={{
        background: 'linear-gradient(135deg,#eef2ff,#faf5ff)',
        border: '1px solid #e5d9ff',
        borderRadius: 12,
        padding: 16,
      }}
    >
      <div
        style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          marginBottom: 12,
          flexWrap: 'wrap',
          gap: 8,
        }}
      >
        <Typography.Text strong style={{ fontSize: 15 }}>
          Tổng tỉ lệ theo loại
        </Typography.Text>
        <Space size={6} align="center">
          <Typography.Text strong style={{ fontSize: 16, color: balanced ? '#3f8600' : '#cf1322' }}>
            {formatPercent(totalPct)}
          </Typography.Text>
          {!balanced && (
            <Typography.Text type="danger" style={{ fontSize: 12 }}>
              (cần đủ 100%)
            </Typography.Text>
          )}
        </Space>
      </div>

      <WheelOddsSunburst segments={segments} />

      {stats.length > 0 && (
        <Space wrap size={[8, 8]} style={{ marginTop: 14 }}>
          {stats.map((row) => (
            <Tag key={row.meta.kind} style={{ margin: 0, paddingInline: 8, borderColor: row.meta.color }}>
              <span
                style={{
                  display: 'inline-block',
                  width: 8,
                  height: 8,
                  borderRadius: 999,
                  background: row.meta.color,
                  marginRight: 6,
                  verticalAlign: 'middle',
                }}
              />
              {row.meta.label} · <b>{formatPercent(row.pct)}</b>
              {row.count > 1 && (
                <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                  {' '}
                  · {row.count} ô
                </Typography.Text>
              )}
            </Tag>
          ))}
        </Space>
      )}
    </div>
  )
}
