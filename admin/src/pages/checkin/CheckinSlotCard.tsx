import type { CSSProperties } from 'react'
import { Card, Space, Tag, Tooltip, Typography, theme } from 'antd'
import { GiftOutlined, LockOutlined, StarFilled } from '@ant-design/icons'
import { useDraggable, useDroppable } from '@dnd-kit/core'
import type { CheckinSlot } from '@/types'
import { CheckinRewardIcon } from './CheckinRewardIcon'
import { CHECKIN_BOX_LABEL, CHECKIN_RANDOM_TASK_LABEL } from './constants'
import { checkinTaskLabel, slotBox } from './utils'

const LOCKED_OPACITY = 0.6

interface CheckinSlotCardViewProps {
  slot: CheckinSlot
  locked: boolean
  lockHint?: string
  overlay?: boolean
}

export function CheckinSlotCardView({ slot, locked, lockHint, overlay }: CheckinSlotCardViewProps) {
  const box = slotBox(slot)
  const featured = box === 'big'
  return (
    <Card
      size="small"
      hoverable={!overlay}
      style={{
        height: '100%',
        borderColor: featured ? '#ffd666' : undefined,
        background: featured ? '#fffbe6' : box === 'none' ? '#fafafa' : undefined,
        minHeight: 112,
        boxShadow: overlay ? '0 8px 24px rgba(0, 0, 0, 0.18)' : undefined,
        cursor: overlay ? 'grabbing' : undefined,
      }}
      styles={{ body: { padding: 10 } }}
    >
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 6 }}>
        <Space size={6}>
          <Typography.Text strong>Ô {slot.slot}</Typography.Text>
          {locked ? (
            <Tooltip title={lockHint}>
              <LockOutlined style={{ color: '#8c8c8c', fontSize: 12 }} />
            </Tooltip>
          ) : null}
        </Space>
        {featured ? <StarFilled style={{ color: '#faad14' }} /> : null}
      </div>
      {box === 'none' ? (
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          {CHECKIN_BOX_LABEL.none}
        </Typography.Text>
      ) : (
        <Space orientation="vertical" size={6} style={{ width: '100%' }}>
          <Typography.Text style={{ fontSize: 12 }}>
            <GiftOutlined style={{ color: featured ? '#d48806' : '#cf1322' }} /> {CHECKIN_BOX_LABEL[box]} ·{' '}
            {slot.gifts.length} quà
          </Typography.Text>
          {slot.gifts.map((gift, giftIndex) => (
            <div key={giftIndex} style={{ display: 'flex', alignItems: 'center', gap: 4, flexWrap: 'wrap' }}>
              {slot.gifts.length > 1 ? (
                <Typography.Text type="secondary" style={{ fontSize: 11, width: 16 }}>
                  {giftIndex + 1}.
                </Typography.Text>
              ) : null}
              {gift.options.map((option, index) => (
                <CheckinRewardIcon key={index} item={option} />
              ))}
            </div>
          ))}
          <Space size={[4, 4]} wrap>
            {slot.requireVip ? <Tag color="orange">Có VIP để mở</Tag> : null}
            {slot.task ? (
              <Tag color="blue">NV: {slot.task === 'random' ? CHECKIN_RANDOM_TASK_LABEL : checkinTaskLabel(slot.task)}</Tag>
            ) : null}
          </Space>
        </Space>
      )}
    </Card>
  )
}

interface CheckinSlotCardProps {
  slot: CheckinSlot
  locked: boolean
  lockHint?: string
  dragging: boolean
  busy: boolean
  onOpen: (slot: number) => void
}

export function CheckinSlotCard({ slot, locked, lockHint, dragging, busy, onOpen }: CheckinSlotCardProps) {
  const { token } = theme.useToken()
  const draggable = useDraggable({ id: slot.slot, disabled: locked || busy })
  const droppable = useDroppable({ id: slot.slot, disabled: locked || busy })
  const isSource = draggable.isDragging
  const isTarget = droppable.isOver && !isSource

  const style: CSSProperties = {
    borderRadius: token.borderRadiusLG,
    outline: isTarget ? `2px dashed ${token.colorPrimary}` : undefined,
    outlineOffset: 2,
    opacity: isSource ? 0.35 : locked ? (dragging ? 0.35 : LOCKED_OPACITY) : 1,
    filter: locked ? 'grayscale(1)' : undefined,
    cursor: locked ? 'pointer' : busy ? 'progress' : 'grab',
    touchAction: locked ? undefined : 'none',
    transition: 'opacity 120ms',
  }

  return (
    <div
      ref={(node) => {
        draggable.setNodeRef(node)
        droppable.setNodeRef(node)
      }}
      style={style}
      onClick={() => onOpen(slot.slot)}
      {...draggable.attributes}
      {...draggable.listeners}
    >
      <CheckinSlotCardView slot={slot} locked={locked} lockHint={lockHint} />
    </div>
  )
}
