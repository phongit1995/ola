import { useState } from 'react'
import { Card, Empty, Input, Select, Space, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { UserCell } from '@/components/UserCell'
import { PAGE_SIZE } from '@/lib/constants'
import { formatCount } from '@/lib/format'
import { rewardItemText } from '@/lib/rewardItem'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { CHECKIN_SECTION_LINKS } from '@/pages/shop/sections'
import type { CheckinHistoryItem, CheckinHistoryStatus, CheckinHistoryUser } from '@/types'
import { CheckinLoadError } from './CheckinLoadError'
import { CheckinRewardIcon } from './CheckinRewardIcon'
import { CheckinUserCalendar } from './CheckinUserCalendar'
import {
  CHECKIN_BOX_LABEL,
  CHECKIN_HISTORY_STATUS_META,
  CHECKIN_HISTORY_STATUS_OPTIONS,
  CHECKIN_MISS_REASON_LABEL,
} from './constants'
import { useCheckinHistory, useCheckinMonth, useCheckinMonths } from './useCheckinQueries'
import { checkinTaskLabel, monthKey, monthLabel, vnNow, vnTime } from './utils'

function buildColumns(onSelectUser: (user: CheckinHistoryUser) => void): ColumnsType<CheckinHistoryItem> {
  return [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 110,
      render: (value: string) => vnTime(value).format('DD/MM HH:mm'),
    },
    {
      title: 'Người dùng',
      key: 'user',
      width: 200,
      render: (_, row) => (
        <Typography.Link onClick={() => onSelectUser(row.user)}>
          <UserCell user={row.user} />
        </Typography.Link>
      ),
    },
    {
      title: 'Ô',
      key: 'slot',
      width: 150,
      render: (_, row) => (
        <Space size={6}>
          <Typography.Text strong>Ô {row.slot}</Typography.Text>
          {row.box === 'none' ? null : (
            <Tag color={row.box === 'big' ? 'gold' : 'red'} style={{ marginInlineEnd: 0 }}>
              {CHECKIN_BOX_LABEL[row.box]}
            </Tag>
          )}
        </Space>
      ),
    },
    {
      title: 'Nhiệm vụ',
      key: 'task',
      width: 220,
      render: (_, row) =>
        row.task ? (
          <Space orientation="vertical" size={0}>
            <Typography.Text>{checkinTaskLabel(row.task)}</Typography.Text>
            {row.taskDoneAt ? (
              <Typography.Text type="success" style={{ fontSize: 12 }}>
                ✓ làm xong {vnTime(row.taskDoneAt).format('HH:mm')}
              </Typography.Text>
            ) : (
              <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                chưa làm
              </Typography.Text>
            )}
          </Space>
        ) : (
          <Typography.Text type="secondary">—</Typography.Text>
        ),
    },
    {
      title: 'Trạng thái',
      key: 'status',
      width: 150,
      render: (_, row) => (
        <Space orientation="vertical" size={2}>
          <Tag color={CHECKIN_HISTORY_STATUS_META[row.status].color} style={{ marginInlineEnd: 0 }}>
            {CHECKIN_HISTORY_STATUS_META[row.status].label}
          </Tag>
          {row.status === 'missed' && row.missReason ? (
            <Typography.Text type="secondary" style={{ fontSize: 12 }}>
              {CHECKIN_MISS_REASON_LABEL[row.missReason]}
            </Typography.Text>
          ) : null}
          {row.status === 'claimed' && row.claimedAt ? (
            <Typography.Text type="secondary" style={{ fontSize: 12 }}>
              mở lúc {vnTime(row.claimedAt).format('HH:mm')}
            </Typography.Text>
          ) : null}
        </Space>
      ),
    },
    {
      title: 'Quà nhận',
      key: 'rewards',
      render: (_, row) =>
        row.rewards.length === 0 ? (
          <Typography.Text type="secondary">—</Typography.Text>
        ) : (
          <Space orientation="vertical" size={4}>
            {row.rewards.map((reward, index) => (
              <Space key={index} size={6}>
                <CheckinRewardIcon item={reward} size={20} />
                <Typography.Text style={{ fontSize: 12 }}>{rewardItemText(reward)}</Typography.Text>
              </Space>
            ))}
          </Space>
        ),
    },
    {
      title: 'VIP lúc điểm danh',
      dataIndex: 'vipAtCheckin',
      width: 90,
      align: 'center',
      render: (value: boolean) => (value ? <Tag color="gold">VIP</Tag> : <Typography.Text type="secondary">—</Typography.Text>),
    },
  ]
}

export function CheckinHistoryPage() {
  const currentMonth = monthKey(vnNow())
  const months = useCheckinMonths()
  const monthOptions = [...(months.data ?? [])]
    .filter((item) => item.month <= currentMonth && item.publishedAt != null)
    .sort((a, b) => b.month.localeCompare(a.month))
  const [picked, setPicked] = useState<string | undefined>()
  const month = picked ?? monthOptions[0]?.month
  const detail = useCheckinMonth(month)
  const [query, setQuery] = useState('')
  const [status, setStatus] = useState<CheckinHistoryStatus | undefined>()
  const [slot, setSlot] = useState<number | undefined>()
  const [page, setPage] = useState(1)
  const [selectedUser, setSelectedUser] = useState<CheckinHistoryUser | null>(null)
  const history = useCheckinHistory(
    month
      ? {
          month,
          q: query || undefined,
          status,
          slot,
          userId: selectedUser?.id,
          limit: PAGE_SIZE,
          offset: (page - 1) * PAGE_SIZE,
        }
      : undefined,
  )
  const title = <ShopSectionNav links={CHECKIN_SECTION_LINKS} />
  const slotOptions = Array.from({ length: detail.data?.slotCount ?? 0 }, (_, index) => ({ value: index + 1, label: `Ô ${index + 1}` }))

  function selectUser(user: CheckinHistoryUser) {
    setSelectedUser(user)
    setPage(1)
  }

  return (
    <Card
      title={title}
      extra={
        monthOptions.length > 0 ? (
          <Select
            value={month}
            onChange={(value) => {
              setPicked(value)
              setPage(1)
              setSlot(undefined)
            }}
            style={{ width: 200 }}
            options={monthOptions.map((item) => ({ value: item.month, label: monthLabel(item.month) }))}
          />
        ) : null
      }
    >
      {months.isError ? (
        <CheckinLoadError onRetry={() => void months.refetch()} />
      ) : months.isSuccess && monthOptions.length === 0 ? (
        <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="Chưa có tháng nào có lịch" />
      ) : (
        <>
          {selectedUser && month ? (
            <CheckinUserCalendar user={selectedUser} month={month} detail={detail.data} onClose={() => setSelectedUser(null)} />
          ) : null}
          <Space size={8} wrap style={{ marginBottom: 12 }}>
            <Input.Search
              allowClear
              placeholder="Tìm theo tên đăng nhập, tên hoặc ID"
              onSearch={(value) => {
                setQuery(value.trim())
                setPage(1)
              }}
              style={{ width: 300 }}
            />
            <Select<CheckinHistoryStatus>
              allowClear
              placeholder="Mọi trạng thái"
              value={status}
              onChange={(value) => {
                setStatus(value)
                setPage(1)
              }}
              options={CHECKIN_HISTORY_STATUS_OPTIONS}
              style={{ width: 170 }}
            />
            <Select<number>
              allowClear
              showSearch
              placeholder="Mọi ô"
              value={slot}
              onChange={(value) => {
                setSlot(value)
                setPage(1)
              }}
              options={slotOptions}
              style={{ width: 120 }}
            />
            {selectedUser ? (
              <Tag closable onClose={() => setSelectedUser(null)} color="blue" style={{ paddingBlock: 4 }}>
                Chỉ xem @{selectedUser.username}
              </Tag>
            ) : (
              <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                Bấm vào tên người dùng để xem lịch điểm danh của người đó.
              </Typography.Text>
            )}
          </Space>
          {history.isError ? <CheckinLoadError onRetry={() => void history.refetch()} /> : null}
          <Table<CheckinHistoryItem>
            rowKey="id"
            size="small"
            loading={history.isFetching}
            columns={buildColumns(selectUser)}
            dataSource={history.data?.items ?? []}
            scroll={{ x: 1100 }}
            pagination={{
              current: page,
              pageSize: PAGE_SIZE,
              total: history.data?.total ?? 0,
              showSizeChanger: false,
              showTotal: (total) => `${formatCount(total)} lượt điểm danh`,
              onChange: setPage,
            }}
            locale={{ emptyText: 'Chưa có lượt điểm danh nào' }}
          />
        </>
      )}
    </Card>
  )
}
