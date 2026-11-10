import { useState } from 'react'
import { Button, Col, Drawer, Row, Space, Spin, Table, Typography, type TableColumnsType } from 'antd'
import { ReloadOutlined } from '@ant-design/icons'
import { useRefreshStoriesAfterCrawl, useStoryCrawler } from './useStoryQueries'
import { formatCount, formatDateTime, formatDuration } from '@/lib/format'
import type { StoryCrawlerSource, StoryCrawlLog } from '@/types'
import { CRAWLER_SOURCES, HISTORY_DRAWER_WIDTH, TRIGGER_LABEL } from './constants'
import { retryNote } from './utils'
import type { CrawlerSourceInfo } from './types'
import { CrawlStatusTag, StoryCrawlerStatusCard } from './StoryCrawlerStatusCard'
import { StoryCrawlerSettingsCard } from './StoryCrawlerSettingsCard'

function Count({ value, strong }: { value: number; strong?: boolean }) {
  if (value === 0) return <Typography.Text type="secondary">0</Typography.Text>
  return (
    <Typography.Text strong={strong} type={strong ? 'success' : undefined}>
      {formatCount(value)}
    </Typography.Text>
  )
}

const COLUMNS: TableColumnsType<StoryCrawlLog> = [
  {
    title: 'Bắt đầu',
    key: 'startedAt',
    width: 150,
    render: (_, log) => (
      <Space orientation="vertical" size={0}>
        <Typography.Text>{formatDateTime(log.startedAt)}</Typography.Text>
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          {TRIGGER_LABEL[log.trigger]}
        </Typography.Text>
      </Space>
    ),
  },
  {
    title: 'Trạng thái',
    key: 'status',
    width: 110,
    render: (_, log) => (
      <Space orientation="vertical" size={0}>
        <CrawlStatusTag status={log.status} />
        {log.cookiesDied && log.cookiesDied.length > 0 && (
          <Typography.Text type="warning" style={{ fontSize: 12 }}>
            {formatCount(log.cookiesDied.length)} cookie die
          </Typography.Text>
        )}
      </Space>
    ),
  },
  {
    title: 'Truyện',
    children: [
      {
        title: 'Kiểm tra',
        dataIndex: 'storiesChecked',
        align: 'right',
        render: (value: number) => <Count value={value} />,
      },
      {
        title: 'Không đổi',
        dataIndex: 'storiesUnchanged',
        align: 'right',
        render: (value: number) => <Count value={value} />,
      },
      {
        title: 'Cập nhật',
        dataIndex: 'storiesUpdated',
        align: 'right',
        render: (value: number) => <Count value={value} strong />,
      },
      {
        title: 'Mới',
        dataIndex: 'storiesCreated',
        align: 'right',
        render: (value: number) => <Count value={value} strong />,
      },
      {
        title: 'Bỏ qua mới',
        dataIndex: 'storiesSkippedNew',
        align: 'right',
        render: (value: number) => <Count value={value} />,
      },
    ],
  },
  {
    title: 'Chương',
    children: [
      {
        title: 'Mới',
        dataIndex: 'chaptersAdded',
        align: 'right',
        render: (value: number) => <Count value={value} strong />,
      },
      {
        title: 'Sửa / xoá',
        key: 'chaptersChanged',
        align: 'right',
        render: (_, log) => (
          <Typography.Text
            type={log.chaptersUpdated + log.chaptersRemoved === 0 ? 'secondary' : undefined}
          >
            {formatCount(log.chaptersUpdated)} / {formatCount(log.chaptersRemoved)}
          </Typography.Text>
        ),
      },
    ],
  },
  {
    title: 'Lỗi',
    dataIndex: 'storiesFailed',
    align: 'right',
    render: (value: number) =>
      value === 0 ? (
        <Typography.Text type="secondary">0</Typography.Text>
      ) : (
        <Typography.Text type="danger">{formatCount(value)}</Typography.Text>
      ),
  },
  {
    title: 'Thời gian',
    key: 'duration',
    width: 120,
    render: (_, log) => (
      <Space orientation="vertical" size={0}>
        <Typography.Text>{log.finishedAt ? formatDuration(log.durationMs) : '—'}</Typography.Text>
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          {formatCount(log.requests)} request
        </Typography.Text>
      </Space>
    ),
  },
]

function LogDetail({ log, source }: { log: StoryCrawlLog; source: CrawlerSourceInfo }) {
  const hiddenErrors = log.storiesFailed - log.errors.length
  return (
    <Space orientation="vertical" size={4}>
      <Typography.Text type="secondary">
        {source.logScope(log)}
        {log.storiesUnchanged > 0 ? ` · ${formatCount(log.storiesUnchanged)} truyện không đổi` : ''}
        {log.retried > 0 ? ` · thử lại ${formatCount(log.retried)} truyện lỗi lượt trước` : ''} ·{' '}
        {log.importNewStories ? 'có lấy truyện mới' : 'chỉ cập nhật truyện đã có'}
        {log.storiesEmpty > 0 ? ` · ${formatCount(log.storiesEmpty)} ${source.emptyNote}` : ''}
      </Typography.Text>
      {log.truncated && source.truncatedWarning && (
        <Typography.Text type="warning">{source.truncatedWarning}</Typography.Text>
      )}
      {log.userAgent && (
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          User-Agent: <Typography.Text code>{log.userAgent}</Typography.Text>
        </Typography.Text>
      )}
      {log.useCookies && (
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          Cookie:{' '}
          {log.cookie ? (
            <Typography.Text code>{log.cookie}</Typography.Text>
          ) : (
            'không còn cookie sống, chạy không đăng nhập'
          )}
        </Typography.Text>
      )}
      {log.cookiesDied && log.cookiesDied.length > 0 && (
        <Typography.Text type="warning">
          Cookie bị đăng xuất, đã chuyển sang Die: {log.cookiesDied.join(', ')}
        </Typography.Text>
      )}
      {log.message && <Typography.Text type="danger">{log.message}</Typography.Text>}
      {log.errors.map((error) => (
        <Typography.Text key={error.sourceStoryId}>
          <Typography.Text type="secondary">#{error.sourceStoryId}</Typography.Text> {error.title}:{' '}
          <Typography.Text type="danger">{error.message}</Typography.Text>
          {error.attempts > 0 && (
            <Typography.Text type="secondary"> · {retryNote(error)}</Typography.Text>
          )}
        </Typography.Text>
      ))}
      {hiddenErrors > 0 && (
        <Typography.Text type="secondary">
          … và {formatCount(hiddenErrors)} truyện lỗi khác
        </Typography.Text>
      )}
    </Space>
  )
}

export function StoryCrawlerTab({ source }: { source: StoryCrawlerSource }) {
  const { data: status, isLoading, isError, isFetching, refetch } = useStoryCrawler(source)
  const info = CRAWLER_SOURCES[source]
  const [historyOpen, setHistoryOpen] = useState(false)
  useRefreshStoriesAfterCrawl(status ? status.logs[0]?.id ?? '' : undefined)

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
        <Spin />
      </div>
    )
  }

  if (isError || !status) {
    return (
      <Typography.Text type="danger">
        Không tải được cấu hình tự động cập nhật. Tải lại trang trước khi chỉnh sửa.
      </Typography.Text>
    )
  }

  const rows = status.running && status.progress ? [status.progress, ...status.logs] : status.logs

  return (
    <>
      <Row gutter={[16, 16]} align="top">
        <Col xs={24} xl={15}>
          <StoryCrawlerSettingsCard status={status} source={source} />
        </Col>
        <Col xs={24} xl={9}>
          <StoryCrawlerStatusCard status={status} source={source} onOpenHistory={() => setHistoryOpen(true)} />
        </Col>
      </Row>
      <Drawer
        open={historyOpen}
        onClose={() => setHistoryOpen(false)}
        size={HISTORY_DRAWER_WIDTH}
        title={`Log các lượt cập nhật ${info.label}`}
        extra={
          <Button icon={<ReloadOutlined />} loading={isFetching} onClick={() => void refetch()}>
            Tải lại
          </Button>
        }
      >
        <Table<StoryCrawlLog>
          rowKey="id"
          size="small"
          columns={COLUMNS}
          dataSource={rows}
          pagination={false}
          scroll={{ x: 960 }}
          expandable={{ expandedRowRender: (log) => <LogDetail log={log} source={info} /> }}
          locale={{ emptyText: 'Chưa có lượt cập nhật nào' }}
        />
      </Drawer>
    </>
  )
}
