import { useState } from 'react'
import { Alert, App, Button, Empty, InputNumber, Modal, Space, Statistic, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { GiftOutlined, ReloadOutlined, StopOutlined } from '@ant-design/icons'
import { errorMessage } from '@/lib/apiError'
import { formatDateTime } from '@/lib/format'
import type { AdminUserMegaphoneTicket } from '@/types'
import {
  MEGAPHONE_TICKET_DAYS_MAX,
  MEGAPHONE_TICKET_GRANT_MAX,
  MEGAPHONE_TICKET_STATUS_TAG,
} from '@/pages/megaphones/constants'
import { ticketSourceText, ticketTimeLeft } from '@/pages/megaphones/ticketUtils'
import {
  useGrantMegaphoneTickets,
  useRevokeMegaphoneTicket,
  useUserMegaphoneTickets,
} from '@/pages/megaphones/useMegaphoneQueries'

interface UserMegaphoneTicketsModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

function ExpiryCell({ ticket }: { ticket: AdminUserMegaphoneTicket }) {
  if (!ticket.expiresAt) return <Typography.Text type="secondary">Không hạn</Typography.Text>
  const left = ticketTimeLeft(ticket.expiresAt)
  return (
    <Space orientation="vertical" size={0}>
      <span>{formatDateTime(ticket.expiresAt)}</span>
      {ticket.status === 'usable' && left != null && (
        <Typography.Text type={left.soon ? 'danger' : 'secondary'} style={{ fontSize: 12 }}>
          {left.text}
        </Typography.Text>
      )}
    </Space>
  )
}

function StatusCell({ ticket }: { ticket: AdminUserMegaphoneTicket }) {
  const meta = MEGAPHONE_TICKET_STATUS_TAG[ticket.status]
  return (
    <Space orientation="vertical" size={0}>
      <Tag color={meta.color} style={{ marginInlineEnd: 0 }}>
        {meta.label}
      </Tag>
      {ticket.status === 'used' && ticket.usedAt && (
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          {formatDateTime(ticket.usedAt)}
          {ticket.megaphoneId && (
            <>
              {' · loa '}
              <Typography.Text copyable={{ text: ticket.megaphoneId }} style={{ fontSize: 12 }} type="secondary">
                {ticket.megaphoneId.slice(0, 8)}
              </Typography.Text>
            </>
          )}
        </Typography.Text>
      )}
      {ticket.status === 'revoked' && ticket.revokedAt && (
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          {ticket.revokedByName ?? 'Admin'} · {formatDateTime(ticket.revokedAt)}
        </Typography.Text>
      )}
    </Space>
  )
}

export function UserMegaphoneTicketsModal({ open, userId, username, onClose }: UserMegaphoneTicketsModalProps) {
  const { message, modal } = App.useApp()
  const { data, isLoading, isError, error, refetch, isFetching } = useUserMegaphoneTickets(open ? userId : null)
  const ready = data != null && !isError
  const grant = useGrantMegaphoneTickets(userId)
  const revoke = useRevokeMegaphoneTicket(userId)
  const [count, setCount] = useState<number | null>(1)
  const [days, setDays] = useState<number | null>(7)

  async function handleGrant() {
    const amount = count ?? 0
    if (amount < 1) return
    try {
      await grant.mutateAsync({ count: amount, expiresInDays: days ?? 0 })
      message.success(`Đã tặng ${amount} vé loa${days ? ` (hạn ${days} ngày)` : ' (không hạn)'}`)
    } catch (err) {
      message.error(errorMessage(err, 'Tặng vé loa thất bại'))
    }
  }

  function confirmRevoke(ticket: AdminUserMegaphoneTicket) {
    modal.confirm({
      title: 'Thu hồi vé loa này?',
      content: `${ticketSourceText(ticket)} · nhận lúc ${formatDateTime(ticket.createdAt)}. Vé bị thu hồi không dùng được nữa.`,
      okText: 'Thu hồi',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await revoke.mutateAsync(ticket.id)
          message.success('Đã thu hồi vé loa')
        } catch (err) {
          message.error(errorMessage(err, 'Thu hồi vé loa thất bại'))
        }
      },
    })
  }

  const columns: ColumnsType<AdminUserMegaphoneTicket> = [
    {
      title: 'Nguồn',
      key: 'source',
      render: (_, ticket) => ticketSourceText(ticket),
    },
    {
      title: 'Nhận lúc',
      dataIndex: 'createdAt',
      width: 150,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Hạn',
      key: 'expiresAt',
      width: 160,
      render: (_, ticket) => <ExpiryCell ticket={ticket} />,
    },
    {
      title: 'Trạng thái',
      key: 'status',
      width: 190,
      render: (_, ticket) => <StatusCell ticket={ticket} />,
    },
    {
      title: '',
      key: 'actions',
      width: 90,
      align: 'right',
      render: (_, ticket) =>
        ticket.status === 'usable' ? (
          <Button size="small" danger icon={<StopOutlined />} onClick={() => confirmRevoke(ticket)}>
            Thu hồi
          </Button>
        ) : null,
    },
  ]

  return (
    <Modal
      title={`Vé loa${username ? ` · @${username}` : ''}`}
      open={open}
      onCancel={onClose}
      footer={<Button onClick={onClose}>Đóng</Button>}
      width={820}
      centered
      destroyOnHidden
    >
      <Space orientation="vertical" size={16} style={{ width: '100%' }}>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: 16, alignItems: 'flex-end', justifyContent: 'space-between' }}>
          <Statistic title="Còn dùng được" loading={isLoading} value={ready ? data.usableCount : '—'} suffix={ready ? 'vé' : undefined} />
          <Space wrap align="end">
            <Space orientation="vertical" size={2}>
              <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                Số vé
              </Typography.Text>
              <InputNumber min={1} max={MEGAPHONE_TICKET_GRANT_MAX} precision={0} value={count} onChange={setCount} addonAfter="vé" style={{ width: 120 }} />
            </Space>
            <Space orientation="vertical" size={2}>
              <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                Hạn dùng
              </Typography.Text>
              <InputNumber
                min={1}
                max={MEGAPHONE_TICKET_DAYS_MAX}
                precision={0}
                value={days}
                onChange={setDays}
                placeholder="Không hạn"
                addonAfter="ngày"
                style={{ width: 150 }}
              />
            </Space>
            <Button type="primary" icon={<GiftOutlined />} loading={grant.isPending} disabled={!count || !ready} onClick={() => void handleGrant()}>
              Tặng vé loa
            </Button>
          </Space>
        </div>
        <Alert
          type="info"
          showIcon
          message="Mỗi vé phát được 1 loa thường miễn phí, không chuyển được. User dùng vé gần hết hạn trước, vé không hạn sau cùng. Để trống ô hạn dùng là vé không hạn."
        />
        {isError ? (
          <Alert
            type="error"
            showIcon
            message={`Không tải được danh sách vé loa · ${errorMessage(error, 'lỗi kết nối')}`}
            description="Bấm Thử lại để xem user đang có bao nhiêu vé trước khi tặng thêm."
            action={
              <Button size="small" icon={<ReloadOutlined />} loading={isFetching} onClick={() => void refetch()}>
                Thử lại
              </Button>
            }
          />
        ) : (
          <Table<AdminUserMegaphoneTicket>
            rowKey="id"
            size="small"
            loading={isLoading}
            columns={columns}
            dataSource={data?.items ?? []}
            pagination={{ pageSize: 10, hideOnSinglePage: true }}
            locale={{ emptyText: <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="Chưa có vé loa nào" /> }}
            scroll={{ x: 720 }}
          />
        )}
      </Space>
    </Modal>
  )
}
