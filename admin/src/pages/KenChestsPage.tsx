import { useEffect, useState } from 'react'
import { App, Button, Card, Space, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { DeleteOutlined, EyeOutlined, GiftOutlined, PlusOutlined } from '@ant-design/icons'
import { useDeleteKenChest, useKenChests } from '@/hooks/useKenChests'
import { ApiError } from '@/lib/apiError'
import { formatDateTime } from '@/lib/format'
import { kenChestRewardText } from '@/lib/kenChest'
import { KenChestFormModal } from './KenChestFormModal'
import { KenChestDetailDrawer } from './KenChestDetailDrawer'
import type { KenChest } from '@/types'

const PAGE_SIZE = 20

function StatusTag({ chest, now }: { chest: KenChest; now: number }) {
  const active = chest.status === 'active' && new Date(chest.expiresAt).getTime() > now
  if (active) return <Tag color="green">Đang phát</Tag>
  if (chest.status === 'deleted') return <Tag color="red">Đã huỷ</Tag>
  return <Tag color="default">Kết thúc</Tag>
}

export function KenChestsPage() {
  const { message, modal } = App.useApp()
  const [page, setPage] = useState(1)
  const [formOpen, setFormOpen] = useState(false)
  const [detailChest, setDetailChest] = useState<KenChest | null>(null)
  const [now, setNow] = useState(0)

  useEffect(() => {
    const update = () => setNow(Date.now())
    update()
    const id = setInterval(update, 15000)
    return () => clearInterval(id)
  }, [])

  const { data, isFetching } = useKenChests({
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })
  const deleteChest = useDeleteKenChest()

  function removeChest(chest: KenChest) {
    modal.confirm({
      title: 'Huỷ rương Ken?',
      content: 'Rương sẽ bị đóng với tất cả người dùng đang xem.',
      okText: 'Huỷ rương',
      okButtonProps: { danger: true },
      cancelText: 'Đóng',
      onOk: async () => {
        try {
          await deleteChest.mutateAsync(chest.id)
          message.success('Đã huỷ rương Ken')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Huỷ thất bại')
        }
      },
    })
  }

  const columns: TableColumnsType<KenChest> = [
    {
      title: 'Rương Ken',
      dataIndex: 'rewardMode',
      render: (_, chest) => (
        <Space>
          <GiftOutlined style={{ color: '#faad14', fontSize: 18 }} />
          <div>
            <Typography.Text strong>{kenChestRewardText(chest)}</Typography.Text>
            <div style={{ fontSize: 12, color: '#6b7785' }}>
              {chest.rewardMode === 'fixed' ? 'Cố định' : 'Ngẫu nhiên'}
            </div>
          </div>
        </Space>
      ),
    },
    {
      title: 'Người nhận',
      key: 'recipients',
      width: 130,
      render: (_, chest) => `${chest.claimedRecipients}/${chest.maxRecipients}`,
    },
    {
      title: 'Thời hạn',
      dataIndex: 'durationSeconds',
      width: 100,
      render: (v: number) => `${v}s`,
    },
    {
      title: 'Tổng KEN đã phát',
      dataIndex: 'totalKenGiven',
      width: 150,
      render: (v: number) => v.toLocaleString('vi-VN'),
    },
    {
      title: 'Trạng thái',
      key: 'status',
      width: 120,
      render: (_, chest) => <StatusTag chest={chest} now={now} />,
    },
    {
      title: 'Tạo lúc',
      dataIndex: 'createdAt',
      width: 170,
      render: (v: string) => formatDateTime(v),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 150,
      render: (_, chest) => (
        <Space>
          <Button size="small" icon={<EyeOutlined />} onClick={() => setDetailChest(chest)}>
            Chi tiết
          </Button>
          <Button
            size="small"
            danger
            icon={<DeleteOutlined />}
            disabled={chest.status !== 'active'}
            onClick={() => removeChest(chest)}
          />
        </Space>
      ),
    },
  ]

  return (
    <Card>
      <div style={{ marginBottom: 16, display: 'flex', justifyContent: 'flex-end' }}>
        <Button type="primary" icon={<PlusOutlined />} onClick={() => setFormOpen(true)}>
          Tạo & Phát rương
        </Button>
      </div>
      <Table<KenChest>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 820 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} rương`,
          onChange: setPage,
        }}
      />
      <KenChestFormModal open={formOpen} onClose={() => setFormOpen(false)} />
      <KenChestDetailDrawer
        chest={detailChest}
        open={detailChest !== null}
        onClose={() => setDetailChest(null)}
      />
    </Card>
  )
}
