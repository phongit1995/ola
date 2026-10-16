import { useState } from 'react'
import { Modal, Table, Tag, type TableColumnsType } from 'antd'
import { useVipHistory } from '@/hooks/useVipTransferQueries'
import { formatDateTime } from '@/lib/format'
import type { VipPurchaseHistory } from '@/types'
import { MODAL_PAGE_SIZE, VIP_HISTORY_SOURCE_META } from './constants'

interface UserVipHistoryModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

export function UserVipHistoryModal({ open, userId, username, onClose }: UserVipHistoryModalProps) {
  const [page, setPage] = useState(1)
  const { data, isFetching } = useVipHistory(open ? userId : null, {
    limit: MODAL_PAGE_SIZE,
    offset: (page - 1) * MODAL_PAGE_SIZE,
  })

  const columns: TableColumnsType<VipPurchaseHistory> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 160,
      render: (v: string) => formatDateTime(v),
    },
    {
      title: 'Gói',
      dataIndex: 'packageName',
      render: (v?: string) => v || '—',
    },
    {
      title: 'Số ngày',
      dataIndex: 'days',
      width: 90,
      align: 'right',
      render: (v: number) => v.toLocaleString('vi-VN'),
    },
    {
      title: 'Giá (Ken)',
      dataIndex: 'kenPrice',
      width: 110,
      align: 'right',
      render: (v: number) => v.toLocaleString('vi-VN'),
    },
    {
      title: 'Nguồn',
      dataIndex: 'source',
      width: 110,
      render: (v: string) => {
        const meta = VIP_HISTORY_SOURCE_META[v]
        return <Tag color={meta?.color}>{meta?.label ?? v}</Tag>
      },
    },
    {
      title: 'Hết hạn sau',
      dataIndex: 'vipEndTime',
      width: 160,
      render: (v: string) => formatDateTime(v),
    },
  ]

  return (
    <Modal
      title={`Lịch sử VIP${username ? ` — @${username}` : ''}`}
      open={open}
      onCancel={onClose}
      footer={null}
      width={820}
      destroyOnHidden
    >
      <Table<VipPurchaseHistory>
        rowKey="id"
        size="small"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        locale={{ emptyText: 'Chưa có lịch sử mua/cấp VIP' }}
        pagination={{
          current: page,
          pageSize: MODAL_PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} lượt`,
          onChange: setPage,
        }}
      />
    </Modal>
  )
}
