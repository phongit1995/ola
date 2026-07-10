import { useMemo, useState } from 'react'
import { Card, Input, Space, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { useVipTransfers } from '@/hooks/useVipTransfers'
import { useDebounce } from '@/hooks/useDebounce'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import type { AdminVipTransfer } from '@/types'

const PAGE_SIZE = 20

function UserCell({ fullName, username }: { fullName: string; username: string }) {
  return (
    <Space direction="vertical" size={0}>
      {fullName && <Typography.Text>{fullName}</Typography.Text>}
      <Typography.Text type="secondary" style={{ fontSize: 12 }}>
        @{username}
      </Typography.Text>
    </Space>
  )
}

export function VipTransfersPage() {
  const [page, setPage] = useState(1)
  const [search, setSearch] = useState('')
  const q = useDebounce(search.trim())

  const params = useMemo(
    () => ({
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
      ...(q ? { q } : {}),
    }),
    [page, q],
  )

  const { data, isFetching } = useVipTransfers(params)
  const items = data?.items ?? []
  const total = data?.total ?? 0

  const columns: TableColumnsType<AdminVipTransfer> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 170,
      render: (value: string) => new Date(value).toLocaleString('vi-VN'),
    },
    {
      title: 'Người chuyển',
      key: 'from',
      render: (_, item) => <UserCell fullName={item.fromFullName} username={item.fromUsername} />,
    },
    {
      title: 'Người nhận',
      key: 'to',
      render: (_, item) => <UserCell fullName={item.toFullName} username={item.toUsername} />,
    },
    {
      title: 'Loại VIP',
      dataIndex: 'vipIconId',
      width: 220,
      render: (typeId: number) => (
        <Space>
          <img
            src={vipIconUrl(typeId)}
            alt={vipName(typeId)}
            width={32}
            height={32}
            style={{ objectFit: 'contain' }}
          />
          <Tag>{typeId}</Tag>
          <Typography.Text strong>{vipName(typeId)}</Typography.Text>
        </Space>
      ),
    },
  ]

  return (
    <Card>
      <Space style={{ marginBottom: 16 }} wrap>
        <Input.Search
          allowClear
          style={{ width: 260 }}
          placeholder="Tìm theo @username người chuyển / nhận"
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
        />
      </Space>
      <Table<AdminVipTransfer>
        rowKey="id"
        columns={columns}
        dataSource={items}
        loading={isFetching}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total,
          onChange: setPage,
          showSizeChanger: false,
        }}
      />
    </Card>
  )
}
