import type { ReactNode } from 'react'
import { Alert, App, Badge, Button, Card, Progress, Tag, Typography } from 'antd'
import { CaretRightOutlined, HistoryOutlined } from '@ant-design/icons'
import { useRunStoryCrawler } from './useStoryQueries'
import { ApiError, errorMessage } from '@/lib/apiError'
import { formatCount, formatDateTime } from '@/lib/format'
import type { StoryCookie, StoryCrawlerSource, StoryCrawlerStatus, StoryCrawlStatus } from '@/types'
import { CRAWL_STATUS_TAG, CRAWLER_SOURCES } from './constants'
import { changeParts, runSummary } from './utils'

export function CrawlStatusTag({ status }: { status: StoryCrawlStatus }) {
  return <Tag color={CRAWL_STATUS_TAG[status].color}>{CRAWL_STATUS_TAG[status].label}</Tag>
}

function InfoRow({ label, children }: { label: string; children: ReactNode }) {
  return (
    <div style={{ display: 'flex', justifyContent: 'space-between', gap: 16, padding: '6px 0' }}>
      <Typography.Text type="secondary">{label}</Typography.Text>
      <Typography.Text style={{ textAlign: 'right' }}>{children}</Typography.Text>
    </div>
  )
}

function CookieSummary({ cookies }: { cookies: StoryCookie[] }) {
  const alive = cookies.filter((item) => item.status === 'active').length
  const dead = cookies.length - alive
  return (
    <InfoRow label="Cookie">
      {alive === 0 ? (
        <Typography.Text type="danger">Hết cookie sống, chạy không đăng nhập</Typography.Text>
      ) : (
        <>
          <Typography.Text type="success">{formatCount(alive)} sống</Typography.Text>
          {dead > 0 && <Typography.Text type="danger"> · {formatCount(dead)} die</Typography.Text>}
        </>
      )}
    </InfoRow>
  )
}

export function StoryCrawlerStatusCard({
  status,
  source,
  onOpenHistory,
}: {
  status: StoryCrawlerStatus
  source: StoryCrawlerSource
  onOpenHistory: () => void
}) {
  const { message } = App.useApp()
  const run = useRunStoryCrawler(source)
  const info = CRAWLER_SOURCES[source]
  const { config, progress } = status
  const lastRun = status.logs[0]
  const percent =
    progress && progress.postsFound > 0
      ? Math.round((progress.postsProcessed * 100) / progress.postsFound)
      : 0

  async function runNow() {
    try {
      await run.mutateAsync()
      message.success('Đã bắt đầu cập nhật ở nền')
    } catch (err) {
      if (err instanceof ApiError && err.status === 409) {
        message.warning('Đang có một lượt cập nhật chạy')
        return
      }
      message.error(errorMessage(err, 'Không chạy được'))
    }
  }

  let badge = <Badge status="default" text="Đang tắt tự động" />
  if (status.running) badge = <Badge status="processing" text="Đang chạy" />
  else if (config.enabled)
    badge = <Badge status="success" text={`Đang bật · mỗi ${config.intervalHours} giờ`} />

  return (
    <Card title="Trạng thái" extra={badge}>
      {status.running && progress && (
        <div style={{ marginBottom: 12 }}>
          <Progress percent={percent} size="small" status="active" />
          <Typography.Text type="secondary" style={{ fontSize: 13 }}>
            {[
              `${formatCount(progress.postsProcessed)}/${formatCount(progress.postsFound)} ${info.unit}`,
              ...changeParts(progress),
            ].join(' · ')}
          </Typography.Text>
        </div>
      )}
      <InfoRow label="Lần chạy gần nhất">{formatDateTime(status.lastRunAt)}</InfoRow>
      <InfoRow label="Lần chạy kế">
        {config.enabled ? formatDateTime(status.nextRunAt) : 'Không có lịch'}
      </InfoRow>
      <InfoRow label="Phạm vi quét">{info.scope(status)}</InfoRow>
      {status.retryPending > 0 && (
        <InfoRow label="Chờ thử lại">
          <Typography.Text type="warning">
            {formatCount(status.retryPending)} truyện lỗi
          </Typography.Text>
        </InfoRow>
      )}
      {config.useCookies && <CookieSummary cookies={config.cookies} />}
      {lastRun && !status.running && (
        <InfoRow label="Kết quả gần nhất">
          <CrawlStatusTag status={lastRun.status} />
          {runSummary(lastRun)}
        </InfoRow>
      )}
      {lastRun && !status.running && lastRun.truncated && info.truncatedWarning && (
        <Alert type="warning" showIcon style={{ marginTop: 8 }} title={info.truncatedWarning} />
      )}
      <div style={{ display: 'flex', gap: 8, marginTop: 16 }}>
        <Button
          type="primary"
          icon={<CaretRightOutlined />}
          loading={run.isPending}
          disabled={status.running}
          onClick={runNow}
          style={{ flex: 1 }}
        >
          {status.running ? 'Đang chạy' : 'Chạy ngay'}
        </Button>
        <Button icon={<HistoryOutlined />} onClick={onOpenHistory} style={{ flex: 1 }}>
          Xem log ({formatCount(status.logs.length)})
        </Button>
      </div>
    </Card>
  )
}
