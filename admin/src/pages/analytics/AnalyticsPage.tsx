import { useMemo, useState } from 'react'
import { Alert, Button, Card, Modal, Segmented, Space, Spin, Typography } from 'antd'
import { ReloadOutlined, SettingOutlined } from '@ant-design/icons'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { isoDaysAgo } from '@/lib/dateRange'
import { errorMessage } from '@/lib/apiError'
import { formatDateTime } from '@/lib/format'
import type { AnalyticsPlatform } from '@/types'
import { AnalyticsRealtimeCard } from './AnalyticsRealtimeCard'
import { AnalyticsReport } from './AnalyticsReport'
import { AnalyticsSetupCard } from './AnalyticsSetupCard'
import { ANALYTICS_DEFAULT_DAYS, PLATFORM_OPTIONS, SOURCE_LABEL } from './constants'
import { useAnalyticsOverview, useAnalyticsRealtime, useRefreshAnalytics } from './useAnalyticsQueries'
import { isAnalyticsReady } from './utils'

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
  const refresh = useRefreshAnalytics()
  const failedSources = (data?.sources ?? []).filter((source) => source.error)

  return (
    <Space orientation="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <DateRangeFilter from={from} to={to} onFromChange={setFrom} onToChange={setTo} />
          <Segmented<AnalyticsPlatform> options={PLATFORM_OPTIONS} value={platform} onChange={setPlatform} />
          <Button
            icon={<ReloadOutlined />}
            loading={refresh.isPending}
            disabled={!data}
            onClick={() => refresh.mutate(params)}
          >
            Làm mới
          </Button>
          <Button icon={<SettingOutlined />} disabled={!data} onClick={() => setSetupOpen(true)}>
            Cấu hình
          </Button>
          {overview.isFetching && <Spin size="small" />}
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
          <AnalyticsRealtimeCard realtime={realtime} />
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
