import { useState } from 'react'
import { Button, Empty, InputNumber, Slider, Space, Switch, Tag, Typography } from 'antd'
import {
  CloseOutlined,
  DeleteOutlined,
  EditOutlined,
  HolderOutlined,
  PlusOutlined,
} from '@ant-design/icons'
import {
  DndContext,
  DragOverlay,
  PointerSensor,
  closestCenter,
  useSensor,
  useSensors,
  type DragEndEvent,
  type DragStartEvent,
} from '@dnd-kit/core'
import { SortableContext, useSortable, verticalListSortingStrategy } from '@dnd-kit/sortable'
import { CSS } from '@dnd-kit/utilities'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import { EggOddsSunburst } from './EggOddsSunburst'
import {
  CATEGORY_COLORS,
  CATEGORY_TEMPLATES,
  categoryTemplate,
  formatPercent,
  percent,
  sumActiveWeight,
  type EggCategory,
  type EggCategoryType,
  type EggReward,
} from './egg/mockEgg'

interface EggPackBuilderProps {
  categories: EggCategory[]
  rewards: EggReward[]
  onAddCategory: (type: EggCategoryType) => void
  onUpdateCategory: (id: string, patch: Partial<EggCategory>) => void
  onRemoveCategory: (category: EggCategory) => void
  onAddItem: (categoryId: string) => void
  onEditItem: (reward: EggReward) => void
  onUpdateReward: (id: string, patch: Partial<EggReward>) => void
  onRemoveItem: (reward: EggReward) => void
  onReorderItems: (categoryId: string, activeId: string, overId: string) => void
  onRebalanceCategory: (categoryId: string, percent: number) => void
  onRebalanceItem: (categoryId: string, itemId: string, percent: number) => void
}

interface ItemDragData {
  categoryId: string
  label: string
}

function rewardDetail(category: EggCategory, reward: EggReward) {
  if (category.type === 'vip_icon' && reward.vipTypeId != null) {
    return (
      <Space>
        <img src={vipIconUrl(reward.vipTypeId)} alt="" width={28} height={28} style={{ objectFit: 'contain' }} />
        <Typography.Text strong>{reward.label || vipName(reward.vipTypeId)}</Typography.Text>
      </Space>
    )
  }
  const suffix =
    category.type === 'ken'
      ? `${(reward.kenAmount ?? 0).toLocaleString('vi-VN')} Ken`
      : `${reward.vipDays ?? 0} ngày VIP`
  return (
    <Space>
      <Typography.Text strong>{reward.label}</Typography.Text>
      <Typography.Text type="secondary">({suffix})</Typography.Text>
    </Space>
  )
}

function PaletteChip({
  type,
  label,
  disabled,
  onAdd,
}: {
  type: EggCategoryType
  label: string
  disabled: boolean
  onAdd: (type: EggCategoryType) => void
}) {
  const color = CATEGORY_COLORS[type]
  return (
    <button
      type="button"
      disabled={disabled}
      onClick={() => onAdd(type)}
      title={disabled ? 'Đã có trong gói' : 'Bấm để thêm vào gói'}
      style={{
        display: 'flex',
        alignItems: 'center',
        gap: 8,
        padding: '8px 14px',
        borderRadius: 999,
        border: `1.5px solid ${color}`,
        background: disabled ? '#f5f5f5' : '#fff',
        color: disabled ? '#bfbfbf' : color,
        cursor: disabled ? 'not-allowed' : 'pointer',
        fontWeight: 600,
        fontSize: 14,
        opacity: disabled ? 0.6 : 1,
        userSelect: 'none',
      }}
    >
      <span style={{ width: 10, height: 10, borderRadius: '50%', background: color, display: 'inline-block' }} />
      {label}
      {disabled ? ' ✓' : ' +'}
    </button>
  )
}

interface ItemRowProps {
  category: EggCategory
  reward: EggReward
  color: string
  itemPct: number
  totalPct: number
  onEdit: () => void
  onUpdate: (patch: Partial<EggReward>) => void
  onRebalance: (percent: number) => void
  onRemove: () => void
}

function SortableItemRow({
  category,
  reward,
  color,
  itemPct,
  totalPct,
  onEdit,
  onUpdate,
  onRebalance,
  onRemove,
}: ItemRowProps) {
  const data: ItemDragData = { categoryId: reward.categoryId, label: reward.label }
  const { attributes, listeners, setNodeRef, transform, transition, isDragging } = useSortable({
    id: reward.id,
    data,
  })
  return (
    <div
      ref={setNodeRef}
      style={{
        transform: CSS.Transform.toString(transform),
        transition,
        display: 'flex',
        alignItems: 'center',
        gap: 12,
        padding: '8px 10px',
        borderRadius: 8,
        background: '#fafafa',
        flexWrap: 'wrap',
        opacity: isDragging ? 0.5 : 1,
      }}
    >
      <span
        {...listeners}
        {...attributes}
        style={{ cursor: 'grab', color: '#bfbfbf', touchAction: 'none', display: 'flex' }}
      >
        <HolderOutlined />
      </span>
      <div style={{ flex: '1 1 180px', minWidth: 140, display: 'flex', alignItems: 'center', gap: 6, flexWrap: 'wrap' }}>
        {rewardDetail(category, reward)}
        {reward.isSuperLucky && (
          <Tag color="magenta" style={{ margin: 0 }}>
            ⭐ Siêu may mắn
          </Tag>
        )}
      </div>
      <div style={{ flex: '1 1 150px', minWidth: 130, display: 'flex', alignItems: 'center' }}>
        <Slider
          min={0}
          max={100}
          value={Math.round(itemPct)}
          disabled={!reward.isActive}
          onChange={(value) => onRebalance(value)}
          tooltip={{ formatter: (v) => `${v}%` }}
          style={{ flex: 1 }}
        />
      </div>
      <Tag color={color} style={{ margin: 0 }}>{formatPercent(itemPct)} trong nhóm</Tag>
      <Tag color="gold" style={{ margin: 0 }}>{formatPercent(totalPct)} tổng</Tag>
      <Switch size="small" checked={reward.isActive} onChange={(value) => onUpdate({ isActive: value })} />
      <Button size="small" type="text" icon={<EditOutlined />} onClick={onEdit} />
      <Button size="small" type="text" danger icon={<DeleteOutlined />} onClick={onRemove} />
    </div>
  )
}

export function EggPackBuilder({
  categories,
  rewards,
  onAddCategory,
  onUpdateCategory,
  onRemoveCategory,
  onAddItem,
  onEditItem,
  onUpdateReward,
  onRemoveItem,
  onReorderItems,
  onRebalanceCategory,
  onRebalanceItem,
}: EggPackBuilderProps) {
  const [activeLabel, setActiveLabel] = useState<string | null>(null)
  const sensors = useSensors(useSensor(PointerSensor, { activationConstraint: { distance: 5 } }))

  const totalCategoryWeight = sumActiveWeight(categories)
  const usedTypes = new Set(categories.map((c) => c.type))

  function categoryPercent(category: EggCategory): number {
    return category.isActive ? percent(category.weight, totalCategoryWeight) : 0
  }

  function onDragStart(event: DragStartEvent) {
    const data = event.active.data.current as ItemDragData | undefined
    setActiveLabel(data?.label ?? null)
  }

  function onDragEnd(event: DragEndEvent) {
    const data = event.active.data.current as ItemDragData | undefined
    const over = event.over
    setActiveLabel(null)
    if (data == null || over == null || event.active.id === over.id) return
    onReorderItems(data.categoryId, String(event.active.id), String(over.id))
  }

  return (
    <DndContext
      sensors={sensors}
      collisionDetection={closestCenter}
      onDragStart={onDragStart}
      onDragEnd={onDragEnd}
      onDragCancel={() => setActiveLabel(null)}
    >
      <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
        <div
          style={{
            background: 'linear-gradient(135deg,#fff7e6,#fffbe6)',
            border: '1px solid #ffe7ba',
            borderRadius: 12,
            padding: 16,
          }}
        >
          <EggOddsSunburst categories={categories} rewards={rewards} />
        </div>

        <div>
          <Typography.Text type="secondary">Bấm loại thưởng để thêm vào gói:</Typography.Text>
          <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap', marginTop: 8 }}>
            {CATEGORY_TEMPLATES.map((tpl) => (
              <PaletteChip
                key={tpl.type}
                type={tpl.type}
                label={tpl.label}
                disabled={usedTypes.has(tpl.type)}
                onAdd={onAddCategory}
              />
            ))}
          </div>
        </div>

        <div
          style={{
            border: '2px dashed #d9d9d9',
            borderRadius: 12,
            padding: 16,
            minHeight: 120,
            display: 'flex',
            flexDirection: 'column',
            gap: 14,
          }}
        >
          {categories.length === 0 && (
            <Empty description="Chưa có loại thưởng — bấm Không trúng / VIP / Ken / Ngày VIP ở trên để thêm" />
          )}

          {categories.map((category) => {
            const tpl = categoryTemplate(category.type)
            const color = CATEGORY_COLORS[category.type]
            const items = rewards
              .filter((r) => r.categoryId === category.id)
              .sort((a, b) => a.sortOrder - b.sortOrder)
            const sumItems = sumActiveWeight(items)
            const catPct = categoryPercent(category)

            return (
              <div
                key={category.id}
                style={{
                  borderLeft: `5px solid ${color}`,
                  borderRadius: 10,
                  background: '#fff',
                  boxShadow: '0 1px 4px rgba(0,0,0,0.08)',
                  padding: 14,
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', gap: 12, flexWrap: 'wrap' }}>
                  <Tag color={color} style={{ fontSize: 14, padding: '2px 10px', margin: 0 }}>
                    {category.label}
                  </Tag>
                  <div style={{ flex: 1, minWidth: 200, display: 'flex', alignItems: 'center', gap: 10 }}>
                    <Slider
                      min={0}
                      max={100}
                      value={Math.round(catPct)}
                      disabled={!category.isActive}
                      onChange={(value) => onRebalanceCategory(category.id, value)}
                      tooltip={{ formatter: (v) => `${v}%` }}
                      style={{ flex: 1 }}
                    />
                    <InputNumber
                      size="small"
                      min={0}
                      max={100}
                      step={0.01}
                      addonAfter="%"
                      value={Math.round(catPct * 100) / 100}
                      disabled={!category.isActive}
                      onChange={(value) => onRebalanceCategory(category.id, value ?? 0)}
                      style={{ width: 110 }}
                    />
                  </div>
                  <Switch
                    checked={category.isActive}
                    onChange={(value) => onUpdateCategory(category.id, { isActive: value })}
                  />
                  <Button size="small" type="text" danger icon={<CloseOutlined />} onClick={() => onRemoveCategory(category)} />
                </div>

                {tpl.hasItems ? (
                  <div style={{ marginTop: 12 }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 }}>
                      <Typography.Text type="secondary">Phần thưởng trong nhóm (kéo ⠿ để sắp xếp)</Typography.Text>
                      <Button size="small" type="primary" ghost icon={<PlusOutlined />} onClick={() => onAddItem(category.id)}>
                        Thêm phần thưởng
                      </Button>
                    </div>

                    {items.length === 0 ? (
                      <Typography.Text type="secondary" italic>
                        Chưa có phần thưởng — bấm "Thêm phần thưởng".
                      </Typography.Text>
                    ) : (
                      <SortableContext items={items.map((i) => i.id)} strategy={verticalListSortingStrategy}>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
                          {items.map((reward) => {
                            const itemPct = reward.isActive ? percent(reward.weight, sumItems) : 0
                            const totalPct = reward.isActive && sumItems > 0 ? catPct * (reward.weight / sumItems) : 0
                            return (
                              <SortableItemRow
                                key={reward.id}
                                category={category}
                                reward={reward}
                                color={color}
                                itemPct={itemPct}
                                totalPct={totalPct}
                                onEdit={() => onEditItem(reward)}
                                onUpdate={(patch) => onUpdateReward(reward.id, patch)}
                                onRebalance={(pct) => onRebalanceItem(category.id, reward.id, pct)}
                                onRemove={() => onRemoveItem(reward)}
                              />
                            )
                          })}
                        </div>
                      </SortableContext>
                    )}
                  </div>
                ) : (
                  <Typography.Text type="secondary" style={{ display: 'block', marginTop: 10 }}>
                    Nhóm này không trao thưởng (trúng = mất lượt).
                  </Typography.Text>
                )}
              </div>
            )
          })}
        </div>
      </div>

      <DragOverlay>
        {activeLabel ? (
          <div
            style={{
              display: 'inline-flex',
              alignItems: 'center',
              gap: 8,
              padding: '8px 14px',
              borderRadius: 8,
              border: '1.5px solid #faad14',
              background: '#fff',
              fontWeight: 600,
              boxShadow: '0 4px 12px rgba(0,0,0,0.18)',
            }}
          >
            {activeLabel}
          </div>
        ) : null}
      </DragOverlay>
    </DndContext>
  )
}
