import { useState } from 'react'
import { Input, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { useKenAllClaims } from '@/hooks/useKenChests'
import { useDebounce } from '@/hooks/useDebounce'
import { formatDateTime } from '@/lib/format'
import { UserCell } from '@/components/UserCell'
import { KenSourceTag } from '@/components/KenSourceTag'
import type { KenClaimHistoryItem } from '@/types'

const PAGE_SIZE = 20

export function KenClaimsHistory() {
  const [page, setPage] = useState(1)
  const [search, setSearch] = useState('')
  const q = useDebounce(search.trim())

  const { data, isFetching } = useKenAllClaims({
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
    ...(q ? { q } : {}),
  })

  const columns: TableColumnsType<KenClaimHistoryItem> = [
    {
      title: 'Người dùng',
      key: 'user',
      render: (_, claim) => <UserCell user={claim.user} />,
    },
    {
      title: 'Nhận',
      key: 'amount',
      width: 140,
      render: (_, claim) =>
        claim.isEmpty ? (
          <Tag color="default">Rỗng</Tag>
        ) : (
          <Typography.Text strong style={{ color: '#d48806' }}>
            {claim.kenAmount.toLocaleString('vi-VN')} KEN
          </Typography.Text>
        ),
    },
    {
      title: 'Nguồn rương',
      dataIndex: 'chestSource',
      width: 120,
      render: (source: string) => <KenSourceTag source={source} />,
    },
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 180,
      render: (v: string) => formatDateTime(v),
    },
  ]

  return (
    <>
      <div style={{ marginBottom: 12, display: 'flex', justifyContent: 'flex-end' }}>
        <Input.Search
          allowClear
          style={{ width: 260 }}
          placeholder="Tìm theo tên / @username"
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
        />
      </div>
      <Table<KenClaimHistoryItem>
        rowKey="id"
        size="small"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} lượt nhận`,
          onChange: setPage,
        }}
      />
    </>
  )
}
