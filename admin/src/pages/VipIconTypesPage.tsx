import { useMemo, useState } from 'react'
import {
  App,
  Card,
  Input,
  InputNumber,
  Modal,
  Space,
  Switch,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { useUpdateVipIconType, useVipIconTypes } from '@/hooks/useVipIconTypes'
import { ApiError } from '@/lib/apiError'
import type { VipIconType } from '@/types'

const PAGE_SIZE = 20

export function VipIconTypesPage() {
  const { message } = App.useApp()
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const [editing, setEditing] = useState<VipIconType | null>(null)
  const [price, setPrice] = useState<number | null>(null)

  const { data, isFetching } = useVipIconTypes()
  const updateIconType = useUpdateVipIconType()

  const filtered = useMemo(() => {
    const items = data ?? []
    const q = search.trim().toLowerCase()
    if (!q) return items
    return items.filter(
      (it) => it.name.toLowerCase().includes(q) || String(it.typeId) === q,
    )
  }, [data, search])

  function openEdit(item: VipIconType) {
    setEditing(item)
    setPrice(item.kenPrice)
  }

  function toggleActive(item: VipIconType, isActive: boolean) {
    updateIconType.mutate(
      { typeId: item.typeId, payload: { isActive } },
      {
        onSuccess: () => message.success(isActive ? 'Đã bật bán' : 'Đã tắt bán'),
        onError: (err) =>
          message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại'),
      },
    )
  }

  async function savePrice() {
    if (!editing || price == null) return
    try {
      await updateIconType.mutateAsync({ typeId: editing.typeId, payload: { kenPrice: price } })
      message.success('Đã cập nhật giá')
      setEditing(null)
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu giá thất bại')
    }
  }

  const columns: TableColumnsType<VipIconType> = [
    {
      title: 'ID',
      dataIndex: 'typeId',
      width: 80,
      render: (v: number) => <Tag>{v}</Tag>,
    },
    {
      title: 'Tên loại VIP',
      dataIndex: 'name',
      render: (v: string) => <Typography.Text strong>{v}</Typography.Text>,
    },
    {
      title: 'Giá (KEN)',
      dataIndex: 'kenPrice',
      width: 140,
      render: (v: number) => v.toLocaleString('vi-VN'),
    },
    {
      title: 'Đang bán',
      dataIndex: 'isActive',
      width: 110,
      render: (isActive: boolean, item) => (
        <Switch
          checked={isActive}
          loading={updateIconType.isPending}
          onChange={(value) => toggleActive(item, value)}
        />
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 130,
      render: (_, item) => (
        <Typography.Link onClick={() => openEdit(item)}>Sửa giá</Typography.Link>
      ),
    },
  ]

  return (
    <Card>
      <div style={{ marginBottom: 16 }}>
        <Input.Search
          allowClear
          placeholder="Tìm theo tên hoặc ID..."
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
          style={{ maxWidth: 360 }}
        />
      </div>
      <Table<VipIconType>
        rowKey="typeId"
        columns={columns}
        dataSource={filtered}
        loading={isFetching}
        scroll={{ x: 640 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: filtered.length,
          showTotal: (total) => `${total} loại`,
          onChange: setPage,
        }}
      />
      <Modal
        title={editing ? `Sửa giá: ${editing.name}` : 'Sửa giá'}
        open={editing != null}
        onOk={savePrice}
        onCancel={() => setEditing(null)}
        okText="Lưu"
        cancelText="Huỷ"
        confirmLoading={updateIconType.isPending}
        destroyOnHidden
      >
        <Space direction="vertical" style={{ width: '100%' }}>
          <Typography.Text type="secondary">Giá bán (KEN)</Typography.Text>
          <InputNumber
            min={0}
            value={price}
            onChange={(v) => setPrice(v)}
            style={{ width: '100%' }}
            autoFocus
          />
        </Space>
      </Modal>
    </Card>
  )
}
