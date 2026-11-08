import { useMemo, useState } from 'react'
import { Card, Input, Space, Table, type TableColumnsType } from 'antd'
import { UserCell } from '@/components/UserCell'
import { useDebounce } from '@/hooks/useDebounce'
import { formatCount, formatDateTime } from '@/lib/format'
import { PAGE_SIZE } from '@/lib/constants'
import type { AdminAvatarFrameTransfer } from '@/types'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { AVATAR_FRAME_SECTION_LINKS } from '@/pages/shop/sections'
import { AvatarFrameCell } from './AvatarFrameCell'
import { useAvatarFrameTransfers } from './useAvatarFrameQueries'

export function AvatarFrameTransfersPage() {
  const [page, setPage] = useState(1)
  const [search, setSearch] = useState('')
  const q = useDebounce(search.trim())

  const params = useMemo(
    () => ({
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
      ...(q ? { search: q } : {}),
    }),
    [page, q],
  )

  const { data, isFetching } = useAvatarFrameTransfers(params)

  const columns: TableColumnsType<AdminAvatarFrameTransfer> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 170,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Khung',
      dataIndex: 'frameId',
      width: 240,
      render: (frameId: string) => <AvatarFrameCell frameId={frameId} />,
    },
    {
      title: 'Người chuyển',
      key: 'from',
      render: (_, item) => <UserCell user={item.from} />,
    },
    {
      title: 'Người nhận',
      key: 'to',
      render: (_, item) => <UserCell user={item.to} />,
    },
  ]

  return (
    <Card title={<ShopSectionNav links={AVATAR_FRAME_SECTION_LINKS} />}>
      <Space style={{ marginBottom: 16 }} wrap>
        <Input.Search
          allowClear
          style={{ width: 300 }}
          placeholder="Username, tên hoặc mã khung (001)"
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
        />
      </Space>
      <Table<AdminAvatarFrameTransfer>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 760 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          onChange: setPage,
          showSizeChanger: false,
          showTotal: (total) => `${formatCount(total)} lượt chuyển`,
        }}
        locale={{ emptyText: 'Chưa có lượt chuyển khung nào' }}
      />
    </Card>
  )
}
