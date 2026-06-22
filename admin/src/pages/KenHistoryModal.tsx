import { useState } from 'react'
import { Modal, Table, type TableColumnsType } from 'antd'
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
      width={760}
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
