import { useState } from 'react'
import { Card, Col, Empty, Progress, Row, Select, Space, Spin, Statistic, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import dayjs from 'dayjs'
import { Bar, BarChart, CartesianGrid, ResponsiveContainer, Tooltip as RTooltip, XAxis, YAxis } from 'recharts'
import { formatCount } from '@/lib/format'
import { rewardItemText, rewardItemTypeLabel } from '@/lib/rewardItem'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { CHECKIN_SECTION_LINKS } from '@/pages/shop/sections'
import type { CheckinMonthDetail, CheckinRewardItem, CheckinStatsSlot, CheckinStatsTask } from '@/types'
import { CheckinLoadError } from './CheckinLoadError'
import { CHECKIN_BOX_LABEL } from './constants'
import { useCheckinMonth, useCheckinMonths, useCheckinStats } from './useCheckinQueries'
import { checkinTaskLabel, monthKey, monthLabel, vnNow } from './utils'

const taskColumns: ColumnsType<CheckinStatsTask> = [
  { title: 'Nhiệm vụ', dataIndex: 'task', render: (task: CheckinStatsTask['task']) => checkinTaskLabel(task) },
  { title: 'Lượt gán', dataIndex: 'assigned', align: 'right', render: (v: number) => formatCount(v) },
  { title: 'Làm xong', dataIndex: 'done', align: 'right', render: (v: number) => formatCount(v) },
  { title: 'Không làm', dataIndex: 'notDone', align: 'right', render: (v: number) => formatCount(v) },
  { title: 'Làm rồi chưa mở', dataIndex: 'doneNotOpened', align: 'right', render: (v: number) => formatCount(v) },
  {
    title: 'Tỉ lệ làm xong',
    key: 'rate',
    width: 160,
    render: (_, row) => <Progress percent={row.assigned ? Math.round((row.done / row.assigned) * 100) : 0} size="small" />,
  },
]

function slotColumns(detail: CheckinMonthDetail | undefined): ColumnsType<CheckinStatsSlot> {
  return [
    { title: 'Ô', dataIndex: 'slot', width: 60 },
    {
      title: 'Hộp',
      dataIndex: 'box',
      width: 120,
      render: (box: CheckinStatsSlot['box']) =>
        box === 'none' ? <Typography.Text type="secondary">{CHECKIN_BOX_LABEL.none}</Typography.Text> : <Tag color={box === 'big' ? 'gold' : 'red'}>{CHECKIN_BOX_LABEL[box]}</Tag>,
    },
    { title: 'Điểm danh', dataIndex: 'checkedIn', width: 100, align: 'right', render: (v: number) => formatCount(v) },
    { title: 'Đã mở', dataIndex: 'opened', width: 90, align: 'right', render: (v: number) => formatCount(v) },
    { title: 'Mất hộp', dataIndex: 'lost', width: 90, align: 'right', render: (v: number) => formatCount(v) },
    {
      title: 'Kết quả bốc (thực tế / đặt)',
      key: 'gifts',
      render: (_, row) => {
        const gifts = detail?.slots[row.slot - 1]?.gifts ?? []
        if (row.opened === 0 || gifts.length === 0) return <Typography.Text type="secondary">—</Typography.Text>
        return (
          <Space orientation="vertical" size={6} style={{ width: '100%' }}>
            {gifts.map((gift, giftIndex) => (
              <div key={giftIndex}>
                {gifts.length > 1 ? (
                  <Typography.Text type="secondary" style={{ fontSize: 12, display: 'block' }}>
                    Quà {giftIndex + 1}
                  </Typography.Text>
                ) : null}
                {gift.options.map((option, index) => {
                  const count = row.gifts[giftIndex]?.counts[index] ?? 0
                  const actual = Math.round((count / row.opened) * 1000) / 10
                  return (
                    <Typography.Text key={index} style={{ fontSize: 12, display: 'block' }}>
                      <b>{actual}%</b> / {option.weight}% · {rewardItemText(option)}
                    </Typography.Text>
                  )
                })}
              </div>
            ))}
          </Space>
        )
      },
    },
  ]
}

export function CheckinStatsPage() {
  const currentMonth = monthKey(vnNow())
  const months = useCheckinMonths()
  const monthOptions = [...(months.data ?? [])]
    .filter((item) => item.month <= currentMonth && item.publishedAt != null)
    .sort((a, b) => b.month.localeCompare(a.month))
  const [picked, setPicked] = useState<string | undefined>()
  const selected = picked ?? monthOptions[0]?.month
  const stats = useCheckinStats(selected)
  const detail = useCheckinMonth(selected)
  const title = <ShopSectionNav links={CHECKIN_SECTION_LINKS} />
  const data = stats.data

  return (
    <Card
      title={title}
      extra={
        monthOptions.length > 0 ? (
          <Select
            value={selected}
            onChange={setPicked}
            style={{ width: 200 }}
            options={monthOptions.map((item) => ({ value: item.month, label: monthLabel(item.month) }))}
          />
        ) : null
      }
    >
      {months.isError || stats.isError ? (
        <CheckinLoadError
          onRetry={() => {
            void months.refetch()
            if (selected) void stats.refetch()
          }}
        />
      ) : months.isLoading || stats.isLoading ? (
        <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
          <Spin />
        </div>
      ) : !data ? (
        <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="Chưa có tháng nào để thống kê" />
      ) : (
        <Space orientation="vertical" size={16} style={{ width: '100%' }}>
          <Row gutter={[12, 12]}>
            <Col xs={12} md={6}>
              <Card size="small">
                <Statistic title="Điểm danh hôm nay" value={data.checkedInToday} formatter={(v) => formatCount(Number(v))} />
                <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                  cả tháng: {formatCount(data.checkedInUsers)} người
                </Typography.Text>
              </Card>
            </Col>
            <Col xs={12} md={6}>
              <Card size="small">
                <Statistic title="Đi hết lịch (tới ô cuối)" value={data.completedUsers} formatter={(v) => formatCount(Number(v))} />
                <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                  {detail.data ? `lịch ${detail.data.slotCount} ô` : ' '}
                </Typography.Text>
              </Card>
            </Col>
            <Col xs={12} md={6}>
              <Card size="small">
                <Statistic title="Hộp đã mở" value={data.boxesOpened} formatter={(v) => formatCount(Number(v))} />
                <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                  {(Object.keys(data.openedByType) as CheckinRewardItem['type'][])
                    .map((type) => `${rewardItemTypeLabel(type).toLowerCase()} ${formatCount(data.openedByType[type])}`)
                    .join(' · ')}
                </Typography.Text>
              </Card>
            </Col>
            <Col xs={12} md={6}>
              <Card size="small">
                <Statistic title="Hộp mất vì chưa có VIP" value={data.lostNoVip} formatter={(v) => formatCount(Number(v))} />
                <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                  đã làm nhiệm vụ, tới 0h vẫn chưa có VIP
                </Typography.Text>
              </Card>
            </Col>
            <Col xs={12} md={6}>
              <Card size="small">
                <Statistic title="Mua VIP để mở hộp" value={data.boughtVipToOpen} formatter={(v) => formatCount(Number(v))} />
                <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                  có giao dịch mua VIP giữa lúc điểm danh và lúc mở
                </Typography.Text>
              </Card>
            </Col>
            <Col xs={12} md={6}>
              <Card size="small">
                <Statistic title="Vé loa phát ra" value={data.ticketsGranted} formatter={(v) => formatCount(Number(v))} />
                <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                  đã dùng {formatCount(data.ticketsUsed)} · hết hạn {formatCount(data.ticketsExpired)}
                </Typography.Text>
              </Card>
            </Col>
          </Row>

          <Card size="small" title="Số người điểm danh theo ngày">
            <ResponsiveContainer width="100%" height={240}>
              <BarChart data={data.daily.map((item) => ({ ...item, label: dayjs(item.day).format('DD/MM') }))} margin={{ top: 8, right: 8, bottom: 8, left: 8 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis dataKey="label" fontSize={12} />
                <YAxis fontSize={12} allowDecimals={false} />
                <RTooltip formatter={(value) => [formatCount(Number(value)), 'Người điểm danh']} />
                <Bar dataKey="users" fill="#5b8c2a" radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </Card>

          <Card size="small" title="Theo ô">
            <Table<CheckinStatsSlot>
              rowKey="slot"
              size="small"
              pagination={false}
              columns={slotColumns(detail.data)}
              dataSource={data.slots}
              scroll={{ x: 900 }}
            />
          </Card>

          <Card size="small" title="Nhiệm vụ">
            <Table<CheckinStatsTask> rowKey="task" size="small" pagination={false} columns={taskColumns} dataSource={data.tasks} />
          </Card>
        </Space>
      )}
    </Card>
  )
}
