import { Button, Card, Empty, Space, Spin, Tag, Tooltip, Typography } from 'antd'
import { CloseOutlined, GiftOutlined } from '@ant-design/icons'
import dayjs from 'dayjs'
import { UserCell } from '@/components/UserCell'
import type { CheckinHistoryItem, CheckinHistoryUser, CheckinMonthDetail } from '@/types'
import { CheckinRewardIcon } from './CheckinRewardIcon'
import { CHECKIN_GRID_COLUMNS, CHECKIN_HISTORY_STATUS_META, CHECKIN_MISS_REASON_LABEL } from './constants'
import { useCheckinUserMonth } from './useCheckinQueries'
import { daysInMonth, monthKey, monthLabel, slotBox, vnNow } from './utils'

const STATUS_BORDER: Record<CheckinHistoryItem['status'], string> = {
  claimed: '#b7eb8f',
  pending: '#91caff',
  missed: '#ffa39e',
  none: '#d9d9d9',
}

function EntryCell({ entry }: { entry: CheckinHistoryItem }) {
  const meta = CHECKIN_HISTORY_STATUS_META[entry.status]
  return (
    <div style={{ border: `1px solid ${STATUS_BORDER[entry.status]}`, borderRadius: 8, padding: 8, minHeight: 92, background: '#fff' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'baseline', marginBottom: 6 }}>
        <Typography.Text strong>Ô {entry.slot}</Typography.Text>
        <Typography.Text type="secondary" style={{ fontSize: 11 }}>
          {dayjs(entry.day).format('DD/MM')}
        </Typography.Text>
      </div>
      {entry.status === 'none' ? (
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          ✓ Đã điểm danh
        </Typography.Text>
      ) : (
        <Space orientation="vertical" size={4}>
          <Tag color={meta.color} style={{ marginInlineEnd: 0 }}>
            {meta.label}
          </Tag>
          {entry.status === 'missed' && entry.missReason ? (
            <Typography.Text type="secondary" style={{ fontSize: 11 }}>
              {CHECKIN_MISS_REASON_LABEL[entry.missReason]}
            </Typography.Text>
          ) : null}
          {entry.rewards.length > 0 ? (
            <Space size={4} wrap>
              {entry.rewards.map((reward, index) => (
                <CheckinRewardIcon key={index} item={reward} size={18} />
              ))}
            </Space>
          ) : null}
        </Space>
      )}
    </div>
  )
}

function EmptyCell({ slot, hasGift, featured, label }: { slot: number; hasGift: boolean; featured: boolean; label: string }) {
  return (
    <div style={{ border: '1px dashed #d9d9d9', borderRadius: 8, padding: 8, minHeight: 92, background: '#fafafa' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 6 }}>
        <Typography.Text type="secondary">Ô {slot}</Typography.Text>
        {hasGift ? (
          <Tooltip title={featured ? 'Hộp đặc biệt' : 'Hộp thường'}>
            <GiftOutlined style={{ color: featured ? '#d48806' : '#bfbfbf' }} />
          </Tooltip>
        ) : null}
      </div>
      <Typography.Text type="secondary" style={{ fontSize: 12 }}>
        {label}
      </Typography.Text>
    </div>
  )
}

interface CheckinUserCalendarProps {
  user: CheckinHistoryUser
  month: string
  detail: CheckinMonthDetail | undefined
  onClose: () => void
}

export function CheckinUserCalendar({ user, month, detail, onClose }: CheckinUserCalendarProps) {
  const { data, isLoading } = useCheckinUserMonth(user.id, month)
  const today = vnNow()
  const isCurrent = month === monthKey(today)
  const entries = data?.entries ?? []
  const slotCount = data?.slotCount ?? detail?.slotCount ?? 0
  const bySlot = new Map(entries.map((entry) => [entry.slot, entry]))
  const checkedToday = entries.some((entry) => entry.day === today.format('YYYY-MM-DD'))
  const reachable = isCurrent ? entries.length + daysInMonth(month) - today.date() + (checkedToday ? 0 : 1) : entries.length
  const counts = entries.reduce<Record<CheckinHistoryItem['status'], number>>(
    (acc, entry) => ({ ...acc, [entry.status]: acc[entry.status] + 1 }),
    { claimed: 0, pending: 0, missed: 0, none: 0 },
  )

  function emptyLabel(slot: number): string {
    if (slot <= reachable) return 'Chưa tới'
    return isCurrent ? 'Không kịp' : 'Không tới'
  }

  return (
    <Card
      size="small"
      style={{ marginBottom: 16 }}
      title={
        <Space size={12} wrap>
          <UserCell user={user} />
          <Typography.Text type="secondary" style={{ fontWeight: 400 }}>
            {monthLabel(month)}
          </Typography.Text>
        </Space>
      }
      extra={
        <Button type="text" icon={<CloseOutlined />} onClick={onClose}>
          Đóng
        </Button>
      }
    >
      {isLoading ? (
        <div style={{ display: 'flex', justifyContent: 'center', padding: 24 }}>
          <Spin />
        </div>
      ) : slotCount === 0 ? (
        <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="Tháng này chưa có lịch" />
      ) : (
        <>
          <Space size={[16, 4]} wrap style={{ marginBottom: 12 }}>
            <Typography.Text>
              Đã điểm danh <b>{entries.length}</b>/{slotCount}
              {entries.length >= slotCount ? ' · đã đi hết lịch' : ''}
            </Typography.Text>
            <Typography.Text type="success">Đã mở {counts.claimed} hộp</Typography.Text>
            {counts.pending > 0 ? <Typography.Text style={{ color: '#1677ff' }}>Chờ mở {counts.pending}</Typography.Text> : null}
            <Typography.Text type="danger">Mất {counts.missed} hộp</Typography.Text>
            {isCurrent && entries.length < slotCount ? (
              <Typography.Text type="secondary">
                {reachable >= slotCount ? `Còn nghỉ được ${reachable - slotCount} ngày` : `Không kịp tới ô ${slotCount}`}
              </Typography.Text>
            ) : null}
          </Space>
          <div style={{ overflowX: 'auto' }}>
            <div
              style={{
                display: 'grid',
                gridTemplateColumns: `repeat(${CHECKIN_GRID_COLUMNS}, minmax(110px, 1fr))`,
                gap: 8,
                minWidth: CHECKIN_GRID_COLUMNS * 118,
              }}
            >
              {Array.from({ length: slotCount }, (_, index) => {
                const slot = index + 1
                const entry = bySlot.get(slot)
                if (entry) return <EntryCell key={slot} entry={entry} />
                const config = detail?.slots[index]
                return (
                  <EmptyCell
                    key={slot}
                    slot={slot}
                    hasGift={config ? slotBox(config) !== 'none' : false}
                    featured={config ? slotBox(config) === 'big' : false}
                    label={emptyLabel(slot)}
                  />
                )
              })}
            </div>
          </div>
        </>
      )}
    </Card>
  )
}
