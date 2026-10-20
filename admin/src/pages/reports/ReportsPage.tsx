import { useState } from 'react'
import { Badge, Button, Card, Input, Select, Space, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { EyeOutlined } from '@ant-design/icons'
import { useDebounce } from '@/hooks/useDebounce'
import { UserBriefCell } from '@/components/UserBriefCell'
import { formatDateTime } from '@/lib/format'
import { PAGE_SIZE } from '@/lib/constants'
import type { AdminReport, ReportStatus, ReportTargetType } from '@/types'
import { useReports } from './useReportQueries'
import { ReportDetailModal } from './ReportDetailModal'
import { reportExcerpt } from './utils'
import {
  REPORT_REASON_LABEL,
  REPORT_STATUS_OPTIONS,
  REPORT_STATUS_TAG,
  REPORT_TARGET_LABEL,
  REPORT_TARGET_OPTIONS,
} from './constants'

type StatusFilter = ReportStatus | 'all'
type TargetFilter = ReportTargetType | 'all'

export function ReportsPage() {
  const [status, setStatus] = useState<StatusFilter>('pending')
  const [targetType, setTargetType] = useState<TargetFilter>('all')
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const [selected, setSelected] = useState<AdminReport | null>(null)
  const q = useDebounce(search.trim())

  const { data, isFetching } = useReports({
    status: status === 'all' ? undefined : status,
    targetType: targetType === 'all' ? undefined : targetType,
    q: q || undefined,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
    }
  }

  const columns: TableColumnsType<AdminReport> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 150,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Loại',
      dataIndex: 'targetType',
      width: 150,
      render: (_, report) => (
        <Space size={4}>
          <Tag>{REPORT_TARGET_LABEL[report.targetType]}</Tag>
          {report.sameTargetPending > 1 && (
            <Badge
              count={report.sameTargetPending}
              title={`${report.sameTargetPending} báo cáo đang chờ cho cùng nội dung`}
            />
          )}
        </Space>
      ),
    },
    {
      title: 'Lý do',
      dataIndex: 'reason',
      width: 160,
      render: (_, report) => REPORT_REASON_LABEL[report.reason],
    },
    {
      title: 'Nội dung',
      key: 'content',
      render: (_, report) => (
        <Typography.Text ellipsis style={{ maxWidth: 280 }}>
          {reportExcerpt(report)}
        </Typography.Text>
      ),
    },
    {
      title: 'Người bị báo cáo',
      key: 'reportedUser',
      width: 200,
      render: (_, report) => (
        <UserBriefCell
          user={report.reportedUser}
          badge={report.reportedUser?.isActive === false ? <Tag color="red">Đã khoá</Tag> : null}
        />
      ),
    },
    {
      title: 'Người báo cáo',
      key: 'reporter',
      width: 200,
      render: (_, report) => <UserBriefCell user={report.reporter} />,
    },
    {
      title: 'Trạng thái',
      dataIndex: 'status',
      width: 110,
      render: (_, report) => {
        const meta = REPORT_STATUS_TAG[report.status]
        return <Tag color={meta.color}>{meta.label}</Tag>
      },
    },
    {
      title: '',
      key: 'actions',
      width: 90,
      render: (_, report) => (
        <Button size="small" icon={<EyeOutlined />} onClick={() => setSelected(report)}>
          Xem
        </Button>
      ),
    },
  ]

  return (
    <Card>
      <div style={{ marginBottom: 16, display: 'flex', gap: 12, flexWrap: 'wrap' }}>
        <Select
          value={status}
          onChange={resetPage(setStatus)}
          style={{ width: 170 }}
          options={REPORT_STATUS_OPTIONS}
        />
        <Select
          value={targetType}
          onChange={resetPage(setTargetType)}
          style={{ width: 170 }}
          options={REPORT_TARGET_OPTIONS}
        />
        <Input.Search
          allowClear
          placeholder="Tìm theo username người báo cáo / bị báo cáo..."
          value={search}
          onChange={(event) => resetPage(setSearch)(event.target.value)}
          style={{ maxWidth: 360 }}
        />
      </div>
      <Table<AdminReport>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 1200 }}
        onRow={(report) => ({ onDoubleClick: () => setSelected(report) })}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} báo cáo`,
          onChange: setPage,
        }}
      />
      {selected != null && (
        <ReportDetailModal key={selected.id} report={selected} onClose={() => setSelected(null)} />
      )}
    </Card>
  )
}
