import { Space, Tag, Tooltip, Typography } from 'antd'
import { SoundOutlined } from '@ant-design/icons'
import { formatCount, formatDateTime } from '@/lib/format'
import type { AdminMegaphone, AdminMegaphoneTicketBrief } from '@/types'
import { ticketExpiryText, ticketSourceText } from './ticketUtils'

function TicketTooltip({ ticket }: { ticket: AdminMegaphoneTicketBrief }) {
  return (
    <Space orientation="vertical" size={0}>
      <span>Nguồn: {ticketSourceText(ticket)}</span>
      <span>Nhận lúc: {formatDateTime(ticket.createdAt)}</span>
      <span>Hạn: {ticketExpiryText(ticket)}</span>
    </Space>
  )
}

export function MegaphonePaidWithCell({ row }: { row: AdminMegaphone }) {
  if (row.paidWith === 'ticket') {
    return row.ticket ? (
      <Tooltip title={<TicketTooltip ticket={row.ticket} />} trigger={['hover', 'click']}>
        <Tag color="orange" icon={<SoundOutlined />} style={{ cursor: 'pointer', marginInlineEnd: 0 }}>
          Vé loa
        </Tag>
      </Tooltip>
    ) : (
      <Tag color="orange" icon={<SoundOutlined />} style={{ marginInlineEnd: 0 }}>
        Vé loa
      </Tag>
    )
  }
  if (row.paidWith === 'ken') {
    return <Typography.Text strong>{formatCount(row.kenPrice)} KEN</Typography.Text>
  }
  return <Typography.Text type="secondary">Miễn phí</Typography.Text>
}
