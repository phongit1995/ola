import { useState } from 'react'
import { Alert, App, Button, Card, Empty, Space, Tag, Typography } from 'antd'
import { DeleteOutlined, EditOutlined, PlusOutlined } from '@ant-design/icons'
import { arrayMove } from '@dnd-kit/sortable'
import { EggPackBuilder } from './EggPackBuilder'
import { EggPackFormModal, type EggPackFormValues } from './EggPackFormModal'
import { EggRewardFormModal, type EggItemFormValues } from './EggRewardFormModal'
import {
  MOCK_CATEGORIES,
  MOCK_PACKS,
  MOCK_REWARDS,
  categoryTemplate,
  newId,
  percent,
  rebalanceWeights,
  sumActiveWeight,
  type EggCategory,
  type EggCategoryType,
  type EggPack,
  type EggReward,
} from './egg/mockEgg'

export function EggRewardsPage() {
  const { message, modal } = App.useApp()
  const [packs, setPacks] = useState<EggPack[]>(MOCK_PACKS)
  const [categories, setCategories] = useState<EggCategory[]>(MOCK_CATEGORIES)
  const [rewards, setRewards] = useState<EggReward[]>(MOCK_REWARDS)
  const [selectedPackId, setSelectedPackId] = useState<string>(MOCK_PACKS[0]?.id ?? '')

  const [packModalOpen, setPackModalOpen] = useState(false)
  const [editingPack, setEditingPack] = useState<EggPack | null>(null)

  const [itemModalOpen, setItemModalOpen] = useState(false)
  const [editingItem, setEditingItem] = useState<EggReward | null>(null)
  const [activeCategoryId, setActiveCategoryId] = useState<string>('')

  const selectedPack = packs.find((p) => p.id === selectedPackId) ?? null
  const packCategories = categories.filter((c) => c.packId === selectedPackId)
  const packCategoryIds = new Set(packCategories.map((c) => c.id))
  const packRewards = rewards.filter((r) => packCategoryIds.has(r.categoryId))
  const activeCategory = categories.find((c) => c.id === activeCategoryId) ?? null
  const editingItemPercent = editingItem
    ? editingItem.isActive
      ? percent(editingItem.weight, sumActiveWeight(rewards.filter((r) => r.categoryId === editingItem.categoryId)))
      : editingItem.weight
    : undefined

  function openCreatePack() {
    setEditingPack(null)
    setPackModalOpen(true)
  }

  function openEditPack(pack: EggPack) {
    setEditingPack(pack)
    setPackModalOpen(true)
  }

  function submitPack(values: EggPackFormValues) {
    if (editingPack) {
      setPacks((prev) => prev.map((p) => (p.id === editingPack.id ? { ...p, ...values } : p)))
      message.success('Đã cập nhật gói (mock)')
      return
    }
    const id = newId('pk')
    setPacks((prev) => [...prev, { id, ...values }])
    setSelectedPackId(id)
    message.success('Đã thêm gói (mock)')
  }

  function removePack(pack: EggPack) {
    modal.confirm({
      title: 'Xoá gói đập trứng?',
      content: `${pack.name} — xoá cả loại thưởng và phần thưởng bên trong.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: () => {
        const removedCategoryIds = new Set(
          categories.filter((c) => c.packId === pack.id).map((c) => c.id),
        )
        setRewards((prev) => prev.filter((r) => !removedCategoryIds.has(r.categoryId)))
        setCategories((prev) => prev.filter((c) => c.packId !== pack.id))
        setPacks((prev) => {
          const next = prev.filter((p) => p.id !== pack.id)
          if (selectedPackId === pack.id) setSelectedPackId(next[0]?.id ?? '')
          return next
        })
        message.success('Đã xoá gói (mock)')
      },
    })
  }

  function addCategory(type: EggCategoryType) {
    if (packCategories.some((c) => c.type === type)) {
      message.warning('Loại này đã có trong gói')
      return
    }
    const tpl = categoryTemplate(type)
    setCategories((prev) => [
      ...prev,
      { id: newId('c'), packId: selectedPackId, type, label: tpl.label, weight: 10, isActive: true },
    ])
    message.success(`Đã thêm loại "${tpl.label}"`)
  }

  function updateCategory(id: string, patch: Partial<EggCategory>) {
    setCategories((prev) => prev.map((c) => (c.id === id ? { ...c, ...patch } : c)))
  }

  function removeCategory(category: EggCategory) {
    modal.confirm({
      title: 'Gỡ loại thưởng?',
      content: `${category.label} — gỡ cả phần thưởng bên trong.`,
      okText: 'Gỡ',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: () => {
        setRewards((prev) => prev.filter((r) => r.categoryId !== category.id))
        setCategories((prev) => prev.filter((c) => c.id !== category.id))
      },
    })
  }

  function addItem(categoryId: string) {
    setActiveCategoryId(categoryId)
    setEditingItem(null)
    setItemModalOpen(true)
  }

  function editItem(reward: EggReward) {
    setActiveCategoryId(reward.categoryId)
    setEditingItem(reward)
    setItemModalOpen(true)
  }

  function submitItem(values: EggItemFormValues) {
    const targetPercent = values.weight
    if (editingItem) {
      const categoryId = editingItem.categoryId
      setRewards((prev) => {
        const updated = prev.map((r) => (r.id === editingItem.id ? { ...r, ...values } : r))
        const catItems = updated.filter((r) => r.categoryId === categoryId)
        const next = rebalanceWeights(catItems, editingItem.id, targetPercent)
        return updated.map((r) => (next.has(r.id) ? { ...r, weight: next.get(r.id) ?? r.weight } : r))
      })
      message.success('Đã cập nhật phần thưởng (mock)')
      return
    }
    const id = newId('r')
    setRewards((prev) => {
      const siblings = prev.filter((r) => r.categoryId === activeCategoryId)
      const sortOrder = siblings.reduce((max, r) => Math.max(max, r.sortOrder), 0) + 1
      const added = [...prev, { id, categoryId: activeCategoryId, sortOrder, ...values }]
      const catItems = added.filter((r) => r.categoryId === activeCategoryId)
      const next = rebalanceWeights(catItems, id, targetPercent)
      return added.map((r) => (next.has(r.id) ? { ...r, weight: next.get(r.id) ?? r.weight } : r))
    })
    message.success('Đã thêm phần thưởng (mock)')
  }

  function updateReward(id: string, patch: Partial<EggReward>) {
    setRewards((prev) => prev.map((r) => (r.id === id ? { ...r, ...patch } : r)))
  }

  function rebalanceCategory(categoryId: string, targetPercent: number) {
    setCategories((prev) => {
      const inPack = prev.filter((c) => c.packId === selectedPackId)
      const next = rebalanceWeights(inPack, categoryId, targetPercent)
      return prev.map((c) => (next.has(c.id) ? { ...c, weight: next.get(c.id) ?? c.weight } : c))
    })
  }

  function rebalanceItem(categoryId: string, itemId: string, targetPercent: number) {
    setRewards((prev) => {
      const catItems = prev.filter((r) => r.categoryId === categoryId)
      const next = rebalanceWeights(catItems, itemId, targetPercent)
      return prev.map((r) => (next.has(r.id) ? { ...r, weight: next.get(r.id) ?? r.weight } : r))
    })
  }

  function reorderItems(categoryId: string, activeId: string, overId: string) {
    setRewards((prev) => {
      const catItems = prev
        .filter((r) => r.categoryId === categoryId)
        .sort((a, b) => a.sortOrder - b.sortOrder)
      const from = catItems.findIndex((r) => r.id === activeId)
      const to = catItems.findIndex((r) => r.id === overId)
      if (from < 0 || to < 0) return prev
      const ordered = arrayMove(catItems, from, to).map((r, index) => ({ ...r, sortOrder: index + 1 }))
      const byId = new Map(ordered.map((r) => [r.id, r]))
      return prev.map((r) => byId.get(r.id) ?? r)
    })
  }

  function removeItem(reward: EggReward) {
    modal.confirm({
      title: 'Xoá phần thưởng?',
      content: `${reward.label} — hành động này không thể hoàn tác.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: () => {
        setRewards((prev) => prev.filter((r) => r.id !== reward.id))
        message.success('Đã xoá phần thưởng (mock)')
      },
    })
  }

  return (
    <Space direction="vertical" size={16} style={{ display: 'flex' }}>
      <Alert
        type="warning"
        showIcon
        message="Dữ liệu giả (mock) trong bộ nhớ"
        description="Mọi thao tác chỉ chạy trên giao diện, chưa lưu xuống server. Tải lại trang sẽ về dữ liệu mặc định."
      />

      <div style={{ display: 'flex', gap: 16, alignItems: 'flex-start', flexWrap: 'wrap' }}>
        <Card
          title="Gói đập trứng"
          style={{ width: 300, flex: '0 0 300px' }}
          extra={
            <Button type="primary" size="small" icon={<PlusOutlined />} onClick={openCreatePack}>
              Thêm gói
            </Button>
          }
        >
          {packs.length === 0 ? (
            <Empty description="Chưa có gói nào" />
          ) : (
            <Space direction="vertical" size={10} style={{ display: 'flex' }}>
              {packs.map((pack) => {
                const selected = pack.id === selectedPackId
                return (
                  <div
                    key={pack.id}
                    onClick={() => setSelectedPackId(pack.id)}
                    style={{
                      cursor: 'pointer',
                      borderRadius: 10,
                      padding: 12,
                      border: `1.5px solid ${selected ? '#faad14' : '#f0f0f0'}`,
                      background: selected ? '#fffbe6' : '#fff',
                    }}
                  >
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                      <Space>
                        <span style={{ fontSize: 18 }}>🥚</span>
                        <Typography.Text strong>{pack.name}</Typography.Text>
                      </Space>
                      <Space size={2}>
                        <Button
                          size="small"
                          type="text"
                          icon={<EditOutlined />}
                          onClick={(e) => {
                            e.stopPropagation()
                            openEditPack(pack)
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
                    <Space size={6} style={{ marginTop: 6 }}>
                      <Tag color="blue">{pack.kenCost.toLocaleString('vi-VN')} Ken/lượt</Tag>
                      <Tag color={pack.isEnabled ? 'green' : 'default'}>
                        {pack.isEnabled ? 'Đang bật' : 'Tắt'}
                      </Tag>
                    </Space>
                  </div>
                )
              })}
            </Space>
          )}
        </Card>

        <Card style={{ flex: 1, minWidth: 360 }} title={selectedPack ? `Cấu hình: ${selectedPack.name}` : 'Cấu hình gói'}>
          {selectedPack ? (
            <EggPackBuilder
              categories={packCategories}
              rewards={packRewards}
              onAddCategory={addCategory}
              onUpdateCategory={updateCategory}
              onRemoveCategory={removeCategory}
              onAddItem={addItem}
              onEditItem={editItem}
              onUpdateReward={updateReward}
              onRemoveItem={removeItem}
              onReorderItems={reorderItems}
              onRebalanceCategory={rebalanceCategory}
              onRebalanceItem={rebalanceItem}
            />
          ) : (
            <Empty description="Chọn hoặc thêm một gói đập trứng" />
          )}
        </Card>
      </div>

      <EggPackFormModal
        open={packModalOpen}
        editing={editingPack}
        onClose={() => setPackModalOpen(false)}
        onSubmit={submitPack}
      />

      {activeCategory && (
        <EggRewardFormModal
          open={itemModalOpen}
          categoryType={activeCategory.type}
          categoryLabel={activeCategory.label}
          editing={editingItem}
          initialPercent={editingItemPercent}
          onClose={() => setItemModalOpen(false)}
          onSubmit={submitItem}
        />
      )}
    </Space>
  )
}
