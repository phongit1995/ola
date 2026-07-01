import { useEffect, useState } from 'react'
import { App, Divider, Input, InputNumber, Modal, Switch, Typography } from 'antd'
import {
  useCreateEggPack,
  useSaveEggConfig,
  useUpdateEggPack,
} from '@/hooks/useEgg'
import { ApiError } from '@/lib/apiError'
import type { EggPack as ApiEggPack, SaveEggConfigRequest } from '@/types'
import { EggPackBuilder } from './EggPackBuilder'
import { EggRewardFormModal, type EggItemFormValues } from './EggRewardFormModal'
import {
  categoryTemplate,
  newId,
  percent,
  rebalanceWeights,
  sumActiveWeight,
  type EggCategory,
  type EggCategoryType,
  type EggReward,
} from './egg/eggHelpers'

const EDITOR_PACK_ID = 'editor'

interface EggPackEditorModalProps {
  open: boolean
  pack: ApiEggPack | null
  nextSortOrder: number
  onClose: () => void
}

function loadPack(pack: ApiEggPack | null): {
  name: string
  kenCost: number
  isEnabled: boolean
  categories: EggCategory[]
  rewards: EggReward[]
} {
  if (!pack) {
    return { name: 'Gói mới', kenCost: 100, isEnabled: true, categories: [], rewards: [] }
  }
  const categories: EggCategory[] = []
  const rewards: EggReward[] = []
  for (const c of pack.categories ?? []) {
    categories.push({
      id: c.id,
      packId: EDITOR_PACK_ID,
      type: c.type,
      label: c.label,
      weight: c.weight,
      isActive: c.isActive,
    })
    for (const r of c.rewards ?? []) {
      rewards.push({
        id: r.id,
        categoryId: c.id,
        label: r.label,
        weight: r.weight,
        vipTypeId: r.vipTypeId,
        kenAmount: r.kenAmount,
        vipDays: r.vipDays,
        isSuperLucky: r.isSuperLucky,
        isActive: r.isActive,
        sortOrder: r.sortOrder,
      })
    }
  }
  return { name: pack.name, kenCost: pack.kenCost, isEnabled: pack.isEnabled, categories, rewards }
}

function validateConfig(name: string, categories: EggCategory[], rewards: EggReward[]): string | null {
  if (!name.trim()) return 'Vui lòng nhập tên gói.'
  const active = categories.filter((c) => c.isActive)
  if (active.length === 0) return 'Gói phải có ít nhất 1 nhóm đang bật.'
  if (active.reduce((sum, c) => sum + c.weight, 0) <= 0) return 'Hãy phân bổ % cho các nhóm.'
  for (const c of active) {
    if (c.type === 'nothing') continue
    const items = rewards.filter((r) => r.categoryId === c.id && r.isActive)
    if (items.length === 0) return `Nhóm "${c.label}" đang bật nhưng chưa có phần thưởng.`
    if (items.reduce((s, r) => s + r.weight, 0) <= 0) return `Hãy phân bổ % cho phần thưởng trong nhóm "${c.label}".`
  }
  return null
}

const round4 = (n: number) => Math.round(n * 10000) / 10000

function toConfigRequest(categories: EggCategory[], rewards: EggReward[]): SaveEggConfigRequest {
  const activeCatTotal = categories.filter((c) => c.isActive).reduce((s, c) => s + c.weight, 0) || 1
  return {
    categories: categories.map((c, index) => {
      const groupRewards = rewards.filter((r) => r.categoryId === c.id).sort((a, b) => a.sortOrder - b.sortOrder)
      const activeRewardTotal = groupRewards.filter((r) => r.isActive).reduce((s, r) => s + r.weight, 0) || 1
      return {
        type: c.type,
        label: c.label,
        weight: c.isActive ? round4((c.weight / activeCatTotal) * 100) : 0,
        isActive: c.isActive,
        sortOrder: index,
        rewards: groupRewards.map((r, ri) => ({
          label: r.label,
          weight: r.isActive ? round4((r.weight / activeRewardTotal) * 100) : 0,
          vipTypeId: r.vipTypeId,
          kenAmount: r.kenAmount,
          vipDays: r.vipDays,
          isSuperLucky: r.isSuperLucky,
          isActive: r.isActive,
          sortOrder: ri,
        })),
      }
    }),
  }
}

export function EggPackEditorModal({ open, pack, nextSortOrder, onClose }: EggPackEditorModalProps) {
  const { message } = App.useApp()
  const createPack = useCreateEggPack()
  const updatePack = useUpdateEggPack()
  const saveConfig = useSaveEggConfig()

  const [name, setName] = useState('Gói mới')
  const [kenCost, setKenCost] = useState(100)
  const [isEnabled, setIsEnabled] = useState(true)
  const [categories, setCategories] = useState<EggCategory[]>([])
  const [rewards, setRewards] = useState<EggReward[]>([])

  const [itemModalOpen, setItemModalOpen] = useState(false)
  const [editingItem, setEditingItem] = useState<EggReward | null>(null)
  const [activeCategoryId, setActiveCategoryId] = useState<string>('')

  useEffect(() => {
    if (!open) return
    const applyPack = () => {
      const loaded = loadPack(pack)
      setName(loaded.name)
      setKenCost(loaded.kenCost)
      setIsEnabled(loaded.isEnabled)
      setCategories(loaded.categories)
      setRewards(loaded.rewards)
    }
    applyPack()
  }, [open, pack])

  const activeCategory = categories.find((c) => c.id === activeCategoryId) ?? null
  const editingItemPercent = editingItem
    ? editingItem.isActive
      ? percent(editingItem.weight, sumActiveWeight(rewards.filter((r) => r.categoryId === editingItem.categoryId)))
      : editingItem.weight
    : undefined
  const saving = createPack.isPending || updatePack.isPending || saveConfig.isPending

  function addCategory(type: EggCategoryType) {
    if (categories.some((c) => c.type === type)) {
      message.warning('Loại này đã có trong gói')
      return
    }
    const tpl = categoryTemplate(type)
    setCategories((prev) => [
      ...prev,
      { id: newId('c'), packId: EDITOR_PACK_ID, type, label: tpl.label, weight: 10, isActive: true },
    ])
  }

  function updateCategory(id: string, patch: Partial<EggCategory>) {
    setCategories((prev) => prev.map((c) => (c.id === id ? { ...c, ...patch } : c)))
  }

  function removeCategory(category: EggCategory) {
    setRewards((prev) => prev.filter((r) => r.categoryId !== category.id))
    setCategories((prev) => prev.filter((c) => c.id !== category.id))
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
  }

  function updateReward(id: string, patch: Partial<EggReward>) {
    setRewards((prev) => prev.map((r) => (r.id === id ? { ...r, ...patch } : r)))
  }

  function rebalanceCategory(_categoryId: string, targetPercent: number) {
    setCategories((prev) => {
      const next = rebalanceWeights(prev, _categoryId, targetPercent)
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
      const catItems = prev.filter((r) => r.categoryId === categoryId).sort((a, b) => a.sortOrder - b.sortOrder)
      const from = catItems.findIndex((r) => r.id === activeId)
      const to = catItems.findIndex((r) => r.id === overId)
      if (from < 0 || to < 0) return prev
      const ordered = catItems.map((r) => r.id)
      const [moved] = ordered.splice(from, 1)
      ordered.splice(to, 0, moved)
      const orderMap = new Map(ordered.map((rid, index) => [rid, index + 1]))
      return prev.map((r) => (orderMap.has(r.id) ? { ...r, sortOrder: orderMap.get(r.id) ?? r.sortOrder } : r))
    })
  }

  function removeItem(reward: EggReward) {
    setRewards((prev) => prev.filter((r) => r.id !== reward.id))
  }

  async function handleSave() {
    const error = validateConfig(name, categories, rewards)
    if (error) {
      message.error(error)
      return
    }
    const payload = toConfigRequest(categories, rewards)
    const meta = { name: name.trim(), kenCost, isEnabled }
    try {
      if (pack) {
        await updatePack.mutateAsync({ id: pack.id, payload: meta })
        await saveConfig.mutateAsync({ id: pack.id, payload })
        message.success('Đã lưu gói')
      } else {
        await createPack.mutateAsync({ ...meta, sortOrder: nextSortOrder, categories: payload.categories })
        message.success('Đã tạo gói')
      }
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu thất bại')
    }
  }

  return (
    <Modal
      title={pack ? `Sửa gói: ${pack.name}` : 'Tạo gói đập trứng'}
      open={open}
      onOk={handleSave}
      onCancel={onClose}
      okText={pack ? 'Lưu' : 'Tạo gói'}
      cancelText="Huỷ"
      confirmLoading={saving}
      width={920}
      style={{ top: 24 }}
      styles={{ body: { maxHeight: 'calc(100vh - 200px)', overflowY: 'auto' } }}
      destroyOnHidden
    >
      <div style={{ display: 'flex', gap: 16, flexWrap: 'wrap', alignItems: 'flex-end', marginBottom: 8 }}>
        <div style={{ flex: '1 1 240px', minWidth: 180 }}>
          <Typography.Text type="secondary" style={{ display: 'block', marginBottom: 4 }}>
            Tên gói
          </Typography.Text>
          <Input value={name} onChange={(e) => setName(e.target.value)} placeholder="Ví dụ: Trứng Vàng" />
        </div>
        <div style={{ width: 160 }}>
          <Typography.Text type="secondary" style={{ display: 'block', marginBottom: 4 }}>
            Giá (Ken/lượt)
          </Typography.Text>
          <InputNumber min={0} style={{ width: '100%' }} value={kenCost} onChange={(v) => setKenCost(v ?? 0)} />
        </div>
        <div>
          <Typography.Text type="secondary" style={{ display: 'block', marginBottom: 4 }}>
            Đang bật
          </Typography.Text>
          <Switch checked={isEnabled} onChange={setIsEnabled} />
        </div>
      </div>

      <Divider style={{ margin: '12px 0 16px' }} />

      <EggPackBuilder
        categories={categories}
        rewards={rewards}
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

      {activeCategory && (
        <EggRewardFormModal
          open={itemModalOpen}
          categoryType={activeCategory.type}
          categoryLabel={activeCategory.label}
          editing={editingItem}
          initialPercent={editingItemPercent}
          groupRewards={rewards.filter((r) => r.categoryId === activeCategory.id)}
          onClose={() => setItemModalOpen(false)}
          onSubmit={submitItem}
        />
      )}
    </Modal>
  )
}
