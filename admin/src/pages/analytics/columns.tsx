import { Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { formatCount } from '@/lib/format'
import type { AnalyticsNamedRow, AnalyticsPlatformRow, AnalyticsVersionRow } from '@/types'
import { eventLabel, formatShare, platformColor, platformLabel } from './utils'

const countColumn = (title: string, dataIndex: string, width = 110) => ({
  title,
  dataIndex,
  width,
  align: 'right' as const,
  render: (value: number) => formatCount(value),
})

const platformTag = (platform: string) => <Tag color={platformColor(platform)}>{platformLabel(platform)}</Tag>

const eventNameColumn = {
  title: 'Sự kiện',
  dataIndex: 'name',
  render: (name: string) => {
    const label = eventLabel(name)
    return label ? (
      <span>
        {label} <Typography.Text type="secondary">({name})</Typography.Text>
      </span>
    ) : (
      <Typography.Text code>{name}</Typography.Text>
    )
  },
}

export const platformColumns: ColumnsType<AnalyticsPlatformRow> = [
  { title: 'Nền tảng', dataIndex: 'platform', render: platformTag },
  countColumn('Người dùng', 'activeUsers'),
  countColumn('Mới', 'newUsers', 90),
  countColumn('Phiên', 'sessions', 90),
  countColumn('Lượt xem', 'views'),
]

export const screenColumns: ColumnsType<AnalyticsNamedRow> = [
  {
    title: 'Màn hình / trang',
    dataIndex: 'name',
    ellipsis: true,
    render: (name: string) => <Typography.Text code>{name}</Typography.Text>,
  },
  countColumn('Lượt xem', 'count'),
  countColumn('Người dùng', 'users'),
]

export const countryColumns: ColumnsType<AnalyticsNamedRow> = [
  { title: 'Quốc gia', dataIndex: 'name' },
  countColumn('Người dùng', 'count'),
]

export const versionColumns: ColumnsType<AnalyticsVersionRow> = [
  { title: 'Nền tảng', dataIndex: 'platform', width: 110, render: platformTag },
  { title: 'Phiên bản', dataIndex: 'version' },
  countColumn('Người dùng', 'users'),
]

export const eventColumns: ColumnsType<AnalyticsNamedRow> = [
  eventNameColumn,
  countColumn('Số lần', 'count'),
  countColumn('Người dùng', 'users'),
]

export function realtimeEventColumns(total: number): ColumnsType<AnalyticsNamedRow> {
  return [
    eventNameColumn,
    countColumn('Số lần', 'count'),
    {
      title: 'Tỷ lệ',
      dataIndex: 'count',
      key: 'share',
      width: 90,
      align: 'right',
      render: (value: number) => formatShare(value, total),
    },
  ]
}
