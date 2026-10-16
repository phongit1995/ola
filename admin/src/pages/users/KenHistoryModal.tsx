import { useState } from 'react'
import { Avatar, Modal, Table, type TableColumnsType } from 'antd'
import { UserOutlined } from '@ant-design/icons'
import { useKenTransactions } from '@/hooks/useKen'
import { formatDateTime } from '@/lib/format'
import { kenTypeLabel } from './kenMeta'
import type { KenTransaction } from '@/types'

const PAGE_SIZE = 10

interface KenHistoryModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

export function KenHistoryModal({ open, userId, username, onClose }: KenHistoryModalProps) {
  const [page, setPage] = useState(1)
  const { data, isFetching } = useKenTransactions(open ? userId : null, {
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })

  const columns: TableColumnsType<KenTransaction> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 160,
      render: (v: string) => formatDateTime(v),
    },
    {
      title: 'Loại',
      dataIndex: 'type',
      render: (t: string) => kenTypeLabel(t),
    },
    {
      title: 'Số ken',
      dataIndex: 'amount',
      width: 110,
      align: 'right',
      render: (amount: number, r) => (
        <span style={{ color: r.direction === 'credit' ? '#389e0d' : '#cf1322', fontWeight: 600 }}>
          {r.direction === 'credit' ? '+' : '−'}
          {amount.toLocaleString('vi-VN')}
        </span>
      ),
    },
    {
      title: 'Số dư sau',
      dataIndex: 'balanceAfter',
      width: 110,
      align: 'right',
      render: (v: number) => v.toLocaleString('vi-VN'),
    },
    {
      title: 'Đối tác',
      dataIndex: 'counterparty',
      width: 180,
      render: (_v, r) => {
        if (!r.counterparty) return '—'
        const inbound = r.direction === 'credit'
        return (
          <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
            <span style={{ color: inbound ? '#389e0d' : '#cf1322', fontWeight: 600 }}>
              {inbound ? 'Từ' : 'Đến'}
            </span>
            <Avatar size={22} src={r.counterparty.avatar} icon={<UserOutlined />} />
            <span style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
              {r.counterparty.fullName || r.counterparty.username}
              <span style={{ color: '#8c98a4' }}> @{r.counterparty.username}</span>
            </span>
          </div>
        )
      },
    },
    {
      title: 'Mô tả',
      dataIndex: 'description',
      render: (v?: string) => v || '—',
    },
  ]

  return (
    <Modal
      title={`Lịch sử Ken${username ? ` — @${username}` : ''}`}
      open={open}
      onCancel={onClose}
      footer={null}
      width={900}
      destroyOnHidden
    >
      <Table<KenTransaction>
        rowKey="id"
        size="small"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} giao dịch`,
          onChange: setPage,
        }}
      />
    </Modal>
  )
}
