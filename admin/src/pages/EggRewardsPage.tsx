import { useState } from 'react'
import { App, Button, Card, Empty, Space, Spin, Tag, Typography } from 'antd'
import { DeleteOutlined, EditOutlined, PlusOutlined } from '@ant-design/icons'
import { useDeleteEggPack, useEggPacks } from '@/hooks/useEgg'
import { ApiError } from '@/lib/apiError'
import type { EggPack } from '@/types'
import { EggPackEditorModal } from './EggPackEditorModal'

export function EggRewardsPage() {
  const { message, modal } = App.useApp()
  const { data: apiPacks, isFetching } = useEggPacks()
  const deletePack = useDeleteEggPack()

  const [editorOpen, setEditorOpen] = useState(false)
  const [editingPack, setEditingPack] = useState<EggPack | null>(null)

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

  return (
    <Card
      title="Gói đập trứng"
      extra={
        <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
          Thêm gói
        </Button>
      }
    >
      {isFetching && packs.length === 0 ? (
        <div style={{ textAlign: 'center', padding: 48 }}>
          <Spin />
        </div>
      ) : packs.length === 0 ? (
        <Empty description='Chưa có gói — bấm "Thêm gói" để tạo' />
      ) : (
        <div style={{ display: 'flex', gap: 16, flexWrap: 'wrap' }}>
          {packs.map((pack) => {
            const catCount = pack.categories?.length ?? 0
            const rewardCount = (pack.categories ?? []).reduce((sum, c) => sum + (c.rewards?.length ?? 0), 0)
            return (
              <div
                key={pack.id}
                onClick={() => openEdit(pack)}
                style={{
                  cursor: 'pointer',
                  width: 280,
                  borderRadius: 12,
                  padding: 16,
                  border: '1.5px solid #f0f0f0',
                  background: '#fff',
                  boxShadow: '0 1px 4px rgba(0,0,0,0.06)',
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <Space>
                    <span style={{ fontSize: 22 }}>🥚</span>
                    <Typography.Text strong style={{ fontSize: 16 }}>
                      {pack.name}
                    </Typography.Text>
                  </Space>
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
                </div>
                <Space size={6} wrap style={{ marginTop: 10 }}>
                  <Tag color="blue">{pack.kenCost.toLocaleString('vi-VN')} Ken/lượt</Tag>
                  <Tag color={pack.isEnabled ? 'green' : 'default'}>{pack.isEnabled ? 'Đang bật' : 'Tắt'}</Tag>
                </Space>
                <Typography.Text type="secondary" style={{ display: 'block', marginTop: 10, fontSize: 13 }}>
                  {catCount} nhóm · {rewardCount} phần thưởng
                </Typography.Text>
              </div>
            )
          })}
        </div>
      )}

      <EggPackEditorModal
        open={editorOpen}
        pack={editingPack}
        nextSortOrder={packs.length}
        onClose={() => setEditorOpen(false)}
      />
    </Card>
  )
}
