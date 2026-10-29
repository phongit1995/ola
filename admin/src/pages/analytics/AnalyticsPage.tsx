import { useMemo, useState } from 'react'
import { Alert, Badge, Button, Card, Modal, Segmented, Space, Spin, Tooltip, Typography } from 'antd'
import { ReloadOutlined, SettingOutlined } from '@ant-design/icons'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { isoDaysAgo } from '@/lib/dateRange'
import { errorMessage } from '@/lib/apiError'
import { formatCount, formatDateTime } from '@/lib/format'
import type { AnalyticsPlatform, AnalyticsRealtime } from '@/types'
import { AnalyticsReport } from './AnalyticsReport'
import { AnalyticsSetupCard } from './AnalyticsSetupCard'
import { ANALYTICS_DEFAULT_DAYS, PLATFORM_OPTIONS, SOURCE_LABEL } from './constants'
import { useAnalyticsOverview, useAnalyticsRealtime, useRefreshAnalytics } from './useAnalyticsQueries'
import { isAnalyticsReady, platformLabel } from './utils'

function RealtimeBadge({ realtime }: { realtime?: AnalyticsRealtime }) {
  if (!realtime) return null
  const breakdown = realtime.platforms
    .map((row) => `${platformLabel(row.platform)}: ${formatCount(row.activeUsers)}`)
    .join(' · ')
  return (
    <Tooltip title={breakdown || 'Không có ai trong 30 phút gần nhất'}>
      <Space size={6}>
        <Badge status="processing" color="#52c41a" />
        <Typography.Text strong>{formatCount(realtime.activeUsers)}</Typography.Text>
        <Typography.Text type="secondary">người dùng trong 30 phút qua</Typography.Text>
      </Space>
    </Tooltip>
  )
}

export function AnalyticsPage() {
  const [from, setFrom] = useState(() => isoDaysAgo(ANALYTICS_DEFAULT_DAYS))
  const [to, setTo] = useState(() => isoDaysAgo(0))
  const [platform, setPlatform] = useState<AnalyticsPlatform>('all')
  const [setupOpen, setSetupOpen] = useState(false)

  const params = useMemo(() => ({ from, to, platform }), [from, to, platform])
  const overview = useAnalyticsOverview(params)
  const data = overview.data
  const ready = isAnalyticsReady(data?.setup)
  const realtime = useAnalyticsRealtime(platform, ready)
  const refresh = useRefreshAnalytics(params)
  const failedSources = (data?.sources ?? []).filter((source) => source.error)

  return (
    <Space orientation="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap style={{ width: '100%', justifyContent: 'space-between' }}>
          <Space wrap>
            <DateRangeFilter from={from} to={to} onFromChange={setFrom} onToChange={setTo} />
            <Segmented<AnalyticsPlatform> options={PLATFORM_OPTIONS} value={platform} onChange={setPlatform} />
            <Button
              icon={<ReloadOutlined />}
              loading={refresh.isPending}
              disabled={!ready}
              onClick={() => refresh.mutate()}
            >
              Làm mới
            </Button>
            <Button icon={<SettingOutlined />} disabled={!data} onClick={() => setSetupOpen(true)}>
              Cấu hình
            </Button>
            {overview.isFetching && <Spin size="small" />}
          </Space>
          {ready && <RealtimeBadge realtime={realtime.data} />}
        </Space>
        {ready && data?.fetchedAt && (
          <Typography.Paragraph type="secondary" style={{ margin: '12px 0 0' }}>
            Số liệu lấy từ Google Analytics lúc {formatDateTime(data.fetchedAt)}. Google thường cập nhật
            chậm vài giờ nên số của hôm nay chưa đầy đủ.
          </Typography.Paragraph>
        )}
      </Card>

      {overview.isError && (
        <Alert type="error" showIcon title={errorMessage(overview.error, 'Không tải được số liệu Analytics')} />
      )}
      {refresh.isError && (
        <Alert type="error" showIcon title={errorMessage(refresh.error, 'Làm mới thất bại')} />
      )}

      {!data ? (
        !overview.isError && (
          <Card>
            <div style={{ textAlign: 'center', padding: 60 }}>
              <Spin />
            </div>
          </Card>
        )
      ) : !ready ? (
        <Card title="Kết nối Google Analytics" style={{ maxWidth: 760 }}>
          <AnalyticsSetupCard setup={data.setup} />
        </Card>
      ) : (
        <Space orientation="vertical" size={16} style={{ width: '100%' }}>
          {failedSources.map((source) => (
            <Alert
              key={source.source}
              type="warning"
              showIcon
              title={`${SOURCE_LABEL[source.source]} (property ${source.propertyId})`}
              description={source.error}
            />
          ))}
          <AnalyticsReport data={data} platform={platform} />
        </Space>
      )}

      <Modal
        title="Cấu hình Google Analytics"
        open={setupOpen}
        onCancel={() => setSetupOpen(false)}
        footer={null}
        width={720}
        destroyOnHidden
      >
        {data && <AnalyticsSetupCard setup={data.setup} onSaved={() => setSetupOpen(false)} />}
      </Modal>
    </Space>
  )
}
