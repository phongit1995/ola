import { useState } from 'react'
import { Table, Tag, Typography, type TableColumnsType } from 'antd'
import { UserCell } from '@/components/UserCell'
import { formatCount, formatDateTime, formatKen } from '@/lib/format'
import type { AdminAvatarFramePurchase, AdminAvatarFrameTransfer } from '@/types'
import { AvatarFrameCell } from '@/pages/avatar-frames/AvatarFrameCell'
import { useAvatarFramePurchases, useAvatarFrameTransfers } from '@/pages/avatar-frames/useAvatarFrameQueries'
import {
  USER_FRAME_HISTORY_PAGE_SIZE,
  USER_FRAME_PURCHASE_ROLE_TAG,
  USER_FRAME_TRANSFER_DIRECTION_TAG,
} from './constants'
import { userFramePurchaseRole, userFrameTransferDirection } from './utils'

interface UserFrameHistoryProps {
  userId: string
}

function usePagedParams(userId: string) {
  const [page, setPage] = useState(1)
  const params = {
    userId,
    limit: USER_FRAME_HISTORY_PAGE_SIZE,
    offset: (page - 1) * USER_FRAME_HISTORY_PAGE_SIZE,
  }
  return { page, setPage, params }
}

export function UserFramePurchaseHistory({ userId }: UserFrameHistoryProps) {
  const { page, setPage, params } = usePagedParams(userId)
  const { data, isFetching } = useAvatarFramePurchases(params)

  const columns: TableColumnsType<AdminAvatarFramePurchase> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 150,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Khung',
      dataIndex: 'frameId',
      render: (frameId: string) => <AvatarFrameCell frameId={frameId} size={40} />,
    },
    {
      title: 'Loại',
      key: 'role',
      width: 110,
      render: (_, item) => {
        const tag = USER_FRAME_PURCHASE_ROLE_TAG[userFramePurchaseRole(item, userId)]
        return <Tag color={tag.color}>{tag.label}</Tag>
      },
    },
    {
      title: 'Người liên quan',
      key: 'counterpart',
      render: (_, item) => {
        const role = userFramePurchaseRole(item, userId)
        if (role === 'sent' && item.recipient) return <UserCell user={item.recipient} />
        if (role === 'received') return <UserCell user={item.buyer} />
        return <Typography.Text type="secondary">—</Typography.Text>
      },
    },
    {
      title: 'KEN',
      dataIndex: 'kenPrice',
      width: 110,
      align: 'right',
      render: (value: number) => formatKen(value),
    },
  ]

  return (
    <Table<AdminAvatarFramePurchase>
      rowKey="id"
      size="small"
      columns={columns}
      dataSource={data?.items ?? []}
      loading={isFetching}
      scroll={{ x: 640 }}
      pagination={{
        current: page,
        pageSize: USER_FRAME_HISTORY_PAGE_SIZE,
        total: data?.total ?? 0,
        onChange: setPage,
        showSizeChanger: false,
        showTotal: (total) => `${formatCount(total)} lượt`,
      }}
      locale={{ emptyText: 'Chưa mua hoặc tặng khung nào' }}
    />
  )
}

export function UserFrameTransferHistory({ userId }: UserFrameHistoryProps) {
  const { page, setPage, params } = usePagedParams(userId)
  const { data, isFetching } = useAvatarFrameTransfers(params)

  const columns: TableColumnsType<AdminAvatarFrameTransfer> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 150,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Khung',
      dataIndex: 'frameId',
      render: (frameId: string) => <AvatarFrameCell frameId={frameId} size={40} />,
    },
    {
      title: 'Chiều',
      key: 'direction',
      width: 120,
      render: (_, item) => {
        const tag = USER_FRAME_TRANSFER_DIRECTION_TAG[userFrameTransferDirection(item, userId)]
        return <Tag color={tag.color}>{tag.label}</Tag>
      },
    },
    {
      title: 'Người kia',
      key: 'counterpart',
      render: (_, item) => (
        <UserCell user={userFrameTransferDirection(item, userId) === 'in' ? item.from : item.to} />
      ),
    },
  ]

  return (
    <Table<AdminAvatarFrameTransfer>
      rowKey="id"
      size="small"
      columns={columns}
      dataSource={data?.items ?? []}
      loading={isFetching}
      scroll={{ x: 560 }}
      pagination={{
        current: page,
        pageSize: USER_FRAME_HISTORY_PAGE_SIZE,
        total: data?.total ?? 0,
        onChange: setPage,
        showSizeChanger: false,
        showTotal: (total) => `${formatCount(total)} lượt`,
      }}
      locale={{ emptyText: 'Chưa chuyển hoặc nhận chuyển khung nào' }}
    />
  )
}
