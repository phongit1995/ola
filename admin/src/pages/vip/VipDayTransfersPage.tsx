import { useMemo, useState } from 'react'
import { Card, Input, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { UserCell } from '@/components/UserCell'
import { useDebounce } from '@/hooks/useDebounce'
import { PAGE_SIZE } from '@/lib/constants'
import { formatCount, formatDateTime } from '@/lib/format'
import type { AdminVipDayTransfer } from '@/types'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { VIP_SECTION_LINKS } from '@/pages/shop/sections'
import { VIP_DAY_TRANSFER_SOURCE_META } from './constants'
import { useVipDayTransfers } from './useVipPurchaseQueries'

export function VipDayTransfersPage() {
  const [page, setPage] = useState(1)
  const [search, setSearch] = useState('')
  const debounced = useDebounce(search.trim())

  const params = useMemo(
    () => ({
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
      ...(debounced ? { search: debounced } : {}),
    }),
    [page, debounced],
  )
  const { data, isFetching } = useVipDayTransfers(params)

  const columns: TableColumnsType<AdminVipDayTransfer> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 170,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Tài khoản',
      key: 'user',
      width: 200,
      render: (_, row) =>
        row.user ? <UserCell user={row.user} /> : <Typography.Text type="secondary">—</Typography.Text>,
    },
    {
      title: 'Loại',
      dataIndex: 'source',
      width: 100,
      render: (value: string) => {
        const meta = VIP_DAY_TRANSFER_SOURCE_META[value]
        return meta ? <Tag color={meta.color}>{meta.label}</Tag> : <Tag>{value}</Tag>
      },
    },
    { title: 'Nội dung', dataIndex: 'name' },
    {
      title: 'Số ngày',
      dataIndex: 'days',
      width: 100,
      align: 'right',
      render: (value: number) => (
        <Typography.Text strong type={value < 0 ? 'danger' : 'success'}>
          {value > 0 ? '+' : ''}
          {formatCount(value)}
        </Typography.Text>
      ),
    },
    {
      title: 'Hạn VIP sau chuyển',
      dataIndex: 'vipEndTime',
      width: 170,
      render: (value: string) => formatDateTime(value),
    },
  ]

  return (
    <Card title={<ShopSectionNav links={VIP_SECTION_LINKS} />}>
      <Input.Search
        allowClear
        placeholder="Tìm theo nick, tên hoặc nội dung"
        value={search}
        onChange={(e) => {
          setSearch(e.target.value)
          setPage(1)
        }}
        style={{ maxWidth: 360, marginBottom: 16 }}
      />
      <Table<AdminVipDayTransfer>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 980 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showSizeChanger: false,
          onChange: setPage,
        }}
      />
    </Card>
  )
}
