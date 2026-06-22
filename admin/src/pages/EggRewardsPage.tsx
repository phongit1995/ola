import { useState } from 'react'
import { App, Button, Card, Space, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { DeleteOutlined, EditOutlined, HistoryOutlined, PlusOutlined } from '@ant-design/icons'
import { useDeleteEggPack, useEggPacks } from '@/hooks/useEgg'
import { ApiError } from '@/lib/apiError'
import type { EggPack } from '@/types'
import { EggPackEditorModal } from './EggPackEditorModal'
import { EggHistoryModal } from './EggHistoryModal'

export function EggRewardsPage() {
  const { message, modal } = App.useApp()
  const { data: apiPacks, isFetching } = useEggPacks()
  const deletePack = useDeleteEggPack()

  const [editorOpen, setEditorOpen] = useState(false)
  const [editingPack, setEditingPack] = useState<EggPack | null>(null)
  const [historyOpen, setHistoryOpen] = useState(false)

  const packs = apiPacks ?? []

  function openCreate() {
    setEditingPack(null)
    setEditorOpen(true)
  }

  function openEdit(pack: EggPack) {
    setEditingPack(pack)
    setEditorOpen(true)
  }

  function removePack(pack: EggPack) {
    modal.confirm({
      title: 'Xoá gói đập trứng?',
      content: `${pack.name} — xoá cả loại thưởng và phần thưởng bên trong.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deletePack.mutateAsync(pack.id)
          message.success('Đã xoá gói')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  const columns: ColumnsType<EggPack> = [
    {
      title: 'Gói',
      dataIndex: 'name',
      render: (name: string) => (
        <Space>
          <span style={{ fontSize: 18 }}>🥚</span>
          <Typography.Text strong>{name}</Typography.Text>
        </Space>
      ),
    },
    {
      title: 'Giá/lượt',
      dataIndex: 'kenCost',
      width: 130,
      align: 'right',
      render: (value: number) => `${value.toLocaleString('vi-VN')} Ken`,
    },
    {
      title: 'Trạng thái',
      dataIndex: 'isEnabled',
      width: 120,
      align: 'center',
      render: (enabled: boolean) => (
        <Tag color={enabled ? 'green' : 'default'}>{enabled ? 'Đang bật' : 'Tắt'}</Tag>
      ),
    },
    {
      title: 'Nhóm',
      key: 'categories',
      width: 90,
      align: 'center',
      render: (_, pack) => pack.categories?.length ?? 0,
    },
    {
      title: 'Phần thưởng',
      key: 'rewards',
      width: 120,
      align: 'center',
      render: (_, pack) =>
        (pack.categories ?? []).reduce((sum, c) => sum + (c.rewards?.length ?? 0), 0),
    },
    {
      title: '',
      key: 'actions',
      width: 90,
      align: 'right',
      render: (_, pack) => (
        <Space size={2}>
          <Button
            size="small"
            type="text"
            icon={<EditOutlined />}
            onClick={(e) => {
              e.stopPropagation()
              openEdit(pack)
            }}
          />
          <Button
            size="small"
            type="text"
            danger
            icon={<DeleteOutlined />}
            onClick={(e) => {
              e.stopPropagation()
              removePack(pack)
            }}
          />
        </Space>
      ),
    },
  ]

  return (
    <Card
      title="Gói đập trứng"
      extra={
        <Space>
          <Button icon={<HistoryOutlined />} onClick={() => setHistoryOpen(true)}>
            Lịch sử đập
          </Button>
          <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
            Thêm gói
          </Button>
        </Space>
      }
    >
      <Table<EggPack>
        rowKey="id"
        loading={isFetching && packs.length === 0}
        columns={columns}
        dataSource={packs}
        pagination={false}
        locale={{ emptyText: 'Chưa có gói — bấm "Thêm gói" để tạo' }}
        onRow={(pack) => ({
          onClick: () => openEdit(pack),
          style: { cursor: 'pointer' },
        })}
      />

      <EggPackEditorModal
        open={editorOpen}
        pack={editingPack}
        nextSortOrder={packs.length}
        onClose={() => setEditorOpen(false)}
      />

      <EggHistoryModal open={historyOpen} onClose={() => setHistoryOpen(false)} />
    </Card>
  )
}
