import { useState } from 'react'
import {
  App,
  Button,
  Card,
  Image,
  Space,
  Switch,
  Table,
  Typography,
  type TableColumnsType,
} from 'antd'
import { DeleteOutlined, EditOutlined, PlusOutlined } from '@ant-design/icons'
import { GiftFormModal } from './GiftFormModal'
import { useDeleteGift, useGifts, useUpdateGift } from './useGiftQueries'
import { errorMessage } from '@/lib/apiError'
import { formatCount } from '@/lib/format'
import type { AdminGift } from '@/types'

const GIFT_THUMB_SIZE = 44

export function GiftsPage() {
  const { message, modal } = App.useApp()
  const [formOpen, setFormOpen] = useState(false)
  const [editing, setEditing] = useState<AdminGift | null>(null)
  const { data, isFetching } = useGifts()
  const updateGift = useUpdateGift()
  const deleteGift = useDeleteGift()
  const gifts = data ?? []

  function openCreate() {
    setEditing(null)
    setFormOpen(true)
  }

  function openEdit(gift: AdminGift) {
    setEditing(gift)
    setFormOpen(true)
  }

  function toggleActive(gift: AdminGift, isActive: boolean) {
    updateGift.mutate(
      { id: gift.id, payload: { isActive } },
      {
        onSuccess: () => message.success(isActive ? 'Đã bật bán' : 'Đã tắt bán'),
        onError: (err) => message.error(errorMessage(err, 'Thao tác thất bại')),
      },
    )
  }

  function removeGift(gift: AdminGift) {
    modal.confirm({
      title: 'Xoá quà?',
      content: `${gift.name} sẽ không còn bán. Tường quà và lịch sử của người dùng vẫn giữ nguyên.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteGift.mutateAsync(gift.id)
          message.success('Đã xoá quà')
        } catch (err) {
          message.error(errorMessage(err, 'Xoá thất bại'))
        }
      },
    })
  }

  const columns: TableColumnsType<AdminGift> = [
    {
      title: 'Quà',
      key: 'gift',
      render: (_, gift) => (
        <Space>
          <Image
            src={gift.imageUrl}
            width={GIFT_THUMB_SIZE}
            height={GIFT_THUMB_SIZE}
            style={{ objectFit: 'contain' }}
            preview={false}
          />
          <div>
            <Typography.Text strong>{gift.name}</Typography.Text>
            {gift.nameEn ? (
              <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
                {gift.nameEn}
              </Typography.Text>
            ) : null}
          </div>
        </Space>
      ),
    },
    {
      title: 'Giá (KEN)',
      dataIndex: 'kenPrice',
      width: 130,
      align: 'right',
      render: (value: number) => formatCount(value),
    },
    {
      title: 'Sức hút',
      dataIndex: 'charmPoints',
      width: 120,
      align: 'right',
      render: (value: number) => formatCount(value),
    },
    {
      title: 'Thứ tự',
      dataIndex: 'sortOrder',
      width: 90,
      align: 'right',
    },
    {
      title: 'Đang bán',
      dataIndex: 'isActive',
      width: 110,
      render: (isActive: boolean, gift) => (
        <Switch
          checked={isActive}
          loading={updateGift.isPending && updateGift.variables?.id === gift.id}
          onChange={(value) => toggleActive(gift, value)}
        />
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 150,
      render: (_, gift) => (
        <Space>
          <Button size="small" icon={<EditOutlined />} onClick={() => openEdit(gift)}>
            Sửa
          </Button>
          <Button size="small" danger icon={<DeleteOutlined />} onClick={() => removeGift(gift)} />
        </Space>
      ),
    },
  ]

  return (
    <Card>
      <div style={{ marginBottom: 16, display: 'flex', justifyContent: 'space-between', gap: 16 }}>
        <Typography.Text type="secondary">
          Quà người dùng tặng nhau trong chat 1-1 và trang cá nhân. Người tặng trả KEN, người nhận
          được sức hút và quà hiện trên tường quà (không nhận KEN).
        </Typography.Text>
        <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
          Thêm quà
        </Button>
      </div>
      <Table<AdminGift>
        rowKey="id"
        columns={columns}
        dataSource={gifts}
        loading={isFetching}
        scroll={{ x: 760 }}
        pagination={{ pageSize: 50, showTotal: (total) => `${total} món quà` }}
        locale={{ emptyText: 'Chưa có quà nào, bấm "Thêm quà" để tạo' }}
      />
      <GiftFormModal open={formOpen} gift={editing} onClose={() => setFormOpen(false)} />
    </Card>
  )
}
