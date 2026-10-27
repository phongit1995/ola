import { useEffect, useRef, useState } from 'react'
import {
  App,
  Button,
  Card,
  Col,
  Row,
  Space,
  Spin,
  Statistic,
  Table,
  Tag,
  Tooltip,
  Typography,
  type TableColumnsType,
} from 'antd'
import { ReloadOutlined, ThunderboltOutlined } from '@ant-design/icons'
import { useQueryClient } from '@tanstack/react-query'
import { formatBytes, formatCount, formatDateTime, formatDuration } from '@/lib/format'
import type { MomentMediaPurgeLog, MomentMediaPurgeTotals } from '@/types'
import {
  MOMENT_EXCERPT_SEPARATOR,
  MOMENT_PURGE_LOG_RETENTION_DAYS,
  MOMENT_PURGE_LOGS_PAGE_SIZE,
  MOMENT_PURGE_STATUS_TAG,
  MOMENT_PURGE_TRIGGER_TAG,
} from './constants'
import { MOMENTS_QUERY_KEY, useMomentPurgeLogs, useRunMomentPurge } from './useMomentQueries'
import { hoursInDays, momentPurgeResult } from './utils'

const MUTED = { fontSize: 12, color: '#6b7785' }

function PurgeTag({ meta }: { meta: { label: string; color: string } }) {
  return <Tag color={meta.color}>{meta.label}</Tag>
}

function PurgeTotals({ totals }: { totals: MomentMediaPurgeTotals }) {
  const tiles = [
    { title: 'Khoảnh khắc đã xoá file', value: formatCount(totals.moments) },
    { title: 'Số file đã xoá', value: formatCount(totals.files) },
    { title: 'Dung lượng đã giải phóng', value: formatBytes(totals.bytes) },
  ]
  return (
    <Row gutter={[12, 12]} style={{ marginBottom: 16 }}>
      {tiles.map((tile) => (
        <Col key={tile.title} xs={24} sm={8}>
          <Card size="small">
            <Statistic
              title={`${tile.title} (${MOMENT_PURGE_LOG_RETENTION_DAYS} ngày qua)`}
              value={tile.value}
            />
          </Card>
        </Col>
      ))}
    </Row>
  )
}

const COLUMNS: TableColumnsType<MomentMediaPurgeLog> = [
  {
    title: 'Bắt đầu',
    key: 'startedAt',
    width: 150,
    render: (_, log) => formatDateTime(log.startedAt),
  },
  {
    title: 'Cách chạy',
    key: 'trigger',
    width: 100,
    render: (_, log) => <PurgeTag meta={MOMENT_PURGE_TRIGGER_TAG[log.trigger]} />,
  },
  {
    title: 'Trạng thái',
    key: 'status',
    width: 110,
    render: (_, log) => <PurgeTag meta={MOMENT_PURGE_STATUS_TAG[log.status]} />,
  },
  {
    title: 'Xoá file đăng trước',
    key: 'cutoff',
    width: 190,
    render: (_, log) => (
      <div style={{ lineHeight: 1.3 }}>
        <div>{formatDateTime(log.cutoff)}</div>
        <div style={MUTED}>
          sau {log.afterHours} giờ ({hoursInDays(log.afterHours)})
        </div>
      </div>
    ),
  },
  {
    title: 'Đã xoá',
    children: [
      {
        title: 'Khoảnh khắc',
        key: 'purged',
        width: 100,
        align: 'center',
        render: (_, log) => formatCount(log.purged),
      },
      {
        title: 'File',
        key: 'files',
        width: 70,
        align: 'center',
        render: (_, log) => formatCount(log.files),
      },
      {
        title: 'Dung lượng',
        key: 'bytes',
        width: 100,
        align: 'right',
        render: (_, log) => formatBytes(log.bytes),
      },
    ],
  },
  {
    title: 'Lỗi',
    key: 'failed',
    width: 60,
    align: 'center',
    render: (_, log) =>
      log.failed > 0 ? <Typography.Text type="danger">{log.failed}</Typography.Text> : '—',
  },
  {
    title: 'Thời gian chạy',
    key: 'duration',
    width: 110,
    render: (_, log) => formatDuration(log.durationMs),
  },
  {
    title: 'Ghi chú',
    key: 'message',
    render: (_, log) => {
      if (log.message) return <Typography.Text type="danger">{log.message}</Typography.Text>
      const notes = []
      if (log.hasMore) notes.push('Còn file, lượt sau chạy tiếp')
      if (log.failed > 0) notes.push('Phần lỗi được thử lại ở lượt sau')
      return notes.length > 0 ? notes.join(MOMENT_EXCERPT_SEPARATOR) : '—'
    },
  },
]

export function MomentPurgeLogs({ enabled, afterHours }: { enabled: boolean; afterHours: number }) {
  const { modal } = App.useApp()
  const queryClient = useQueryClient()
  const [page, setPage] = useState(1)
  const { data, isLoading, isError, isFetching, refetch } = useMomentPurgeLogs(page)
  const purge = useRunMomentPurge()
  const running = data?.running ?? false
  const last = data?.last
  const lastRunId = data ? (last?.id ?? null) : undefined
  const seenRunId = useRef(lastRunId)

  useEffect(() => {
    const seen = seenRunId.current
    seenRunId.current = lastRunId
    if (seen === undefined || lastRunId === undefined || lastRunId === seen) return
    if (last && (last.purged > 0 || last.files > 0)) {
      void queryClient.invalidateQueries({ queryKey: [MOMENTS_QUERY_KEY] })
    }
  }, [lastRunId, last, queryClient])

  function confirmRun() {
    modal.confirm({
      title: 'Xoá file ngay bây giờ?',
      content: `Xoá vĩnh viễn file ảnh/video của khoảnh khắc đăng quá ${afterHours} giờ (${hoursInDays(afterHours)}), trừ khoảnh khắc đang có báo cáo chờ xử lý. File đã xoá không khôi phục được.`,
      okText: 'Xoá file',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: () => purge.run(),
    })
  }

  return (
    <Card
      title={`Nhật ký chạy ${MOMENT_PURGE_LOG_RETENTION_DAYS} ngày gần nhất`}
      extra={
        <Space>
          <Button
            icon={<ReloadOutlined />}
            loading={isFetching && !isLoading}
            onClick={() => void refetch()}
          >
            Tải lại
          </Button>
          <Tooltip title={enabled ? null : 'Bật và lưu cài đặt tự động xoá trước'}>
            <Button
              type="primary"
              danger
              icon={<ThunderboltOutlined />}
              disabled={!enabled || running}
              loading={purge.pending}
              onClick={confirmRun}
            >
              Chạy ngay
            </Button>
          </Tooltip>
        </Space>
      }
    >
      {isError ? (
        <Typography.Text type="danger">Không tải được nhật ký chạy</Typography.Text>
      ) : (
        <>
          {data && <PurgeTotals totals={data.totals} />}
          <div style={{ marginBottom: 12 }}>
            {running ? (
              <Space>
                <Spin size="small" />
                <Typography.Text>Đang xoá file…</Typography.Text>
              </Space>
            ) : last ? (
              <Space size={6} wrap>
                <Typography.Text strong>Lần chạy gần nhất:</Typography.Text>
                <Typography.Text>{formatDateTime(last.startedAt)}</Typography.Text>
                <PurgeTag meta={MOMENT_PURGE_TRIGGER_TAG[last.trigger]} />
                <PurgeTag meta={MOMENT_PURGE_STATUS_TAG[last.status]} />
                <Typography.Text type="secondary">{momentPurgeResult(last)}</Typography.Text>
              </Space>
            ) : (
              <Typography.Text type="secondary">
                Chưa chạy lần nào{enabled ? '' : ', tự động xoá đang tắt'}
              </Typography.Text>
            )}
          </div>
          <Table<MomentMediaPurgeLog>
            rowKey="id"
            size="small"
            loading={isLoading}
            columns={COLUMNS}
            dataSource={data?.items ?? []}
            scroll={{ x: 1140 }}
            locale={{
              emptyText:
                `Chưa có lượt nào xoá file trong ${MOMENT_PURGE_LOG_RETENTION_DAYS} ngày qua. Lượt tự động không có gì để xoá chỉ cập nhật dòng "Lần chạy gần nhất".`,
            }}
            pagination={{
              current: page,
              pageSize: MOMENT_PURGE_LOGS_PAGE_SIZE,
              total: data?.total ?? 0,
              hideOnSinglePage: true,
              showSizeChanger: false,
              showTotal: (total) =>
                `${formatCount(total)} lượt trong ${MOMENT_PURGE_LOG_RETENTION_DAYS} ngày qua`,
              onChange: setPage,
            }}
          />
        </>
      )}
    </Card>
  )
}
