import { useState } from 'react'
import { Button, Space, Typography } from 'antd'
import { PlusOutlined } from '@ant-design/icons'
import type { WheelSegment, WheelSegmentKind, WheelSegmentOption } from '@/types'
import { VIP_CATALOG } from '@/lib/vipCatalog'
import { WheelSummaryPanel } from './WheelSummaryPanel'
import { WheelSegmentCard } from './WheelSegmentCard'
import { WHEEL_KINDS, kindMeta, newId, rebalanceWeights, sumActiveWeight } from './wheel/wheelHelpers'

interface WheelBuilderProps {
  segments: WheelSegment[]
  onChange: (segments: WheelSegment[]) => void
}

export function WheelBuilder({ segments, onChange }: WheelBuilderProps) {
  const [expandedOptions, setExpandedOptions] = useState<Record<string, boolean>>({})
  const activeTotal = sumActiveWeight(segments)

  function toggleOptions(id: string) {
    setExpandedOptions((prev) => ({ ...prev, [id]: !prev[id] }))
  }

  function updateSeg(id: string, patch: Partial<WheelSegment>) {
    onChange(segments.map((s) => (s.id === id ? { ...s, ...patch } : s)))
  }

  function addSegment(kind: WheelSegmentKind) {
    const sortOrder = segments.reduce((max, s) => Math.max(max, s.sortOrder), -1) + 1
    onChange([
      ...segments,
      {
        id: newId('seg'),
        kind,
        label: kindMeta(kind).label,
        weight: 10,
        isSuperLucky: false,
        isActive: true,
        sortOrder,
        options: [],
      },
    ])
  }

  function removeSegment(id: string) {
    onChange(segments.filter((s) => s.id !== id))
  }

  function rebalanceSeg(id: string, target: number) {
    const next = rebalanceWeights(segments, id, target)
    onChange(segments.map((s) => (next.has(s.id) ? { ...s, weight: next.get(s.id) ?? s.weight } : s)))
  }

  function addOption(seg: WheelSegment) {
    const sortOrder = seg.options.reduce((max, o) => Math.max(max, o.sortOrder), -1) + 1
    const firstVip = VIP_CATALOG[0]
    const option: WheelSegmentOption = {
      id: newId('opt'),
      label: firstVip ? firstVip.name : 'VIP',
      weight: seg.options.length === 0 ? 100 : 10,
      vipTypeId: firstVip?.id,
      isActive: true,
      sortOrder,
    }
    updateSeg(seg.id, { options: [...seg.options, option] })
    setExpandedOptions((prev) => ({ ...prev, [seg.id]: true }))
  }

  function updateOption(seg: WheelSegment, optId: string, patch: Partial<WheelSegmentOption>) {
    updateSeg(seg.id, { options: seg.options.map((o) => (o.id === optId ? { ...o, ...patch } : o)) })
  }

  function removeOption(seg: WheelSegment, optId: string) {
    updateSeg(seg.id, { options: seg.options.filter((o) => o.id !== optId) })
  }

  function rebalanceOption(seg: WheelSegment, optId: string, target: number) {
    const next = rebalanceWeights(seg.options, optId, target)
    updateSeg(seg.id, {
      options: seg.options.map((o) => (next.has(o.id) ? { ...o, weight: next.get(o.id) ?? o.weight } : o)),
    })
  }

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
      {segments.length > 0 && <WheelSummaryPanel segments={segments} />}

      <div>
        <Typography.Text type="secondary">Bấm loại phần thưởng để thêm ô:</Typography.Text>
        <Space wrap style={{ marginTop: 8 }}>
          {WHEEL_KINDS.map((meta) => (
            <Button
              key={meta.kind}
              size="small"
              icon={<PlusOutlined />}
              onClick={() => addSegment(meta.kind)}
              style={{ borderColor: meta.color, color: meta.color }}
            >
              {meta.label}
            </Button>
          ))}
        </Space>
      </div>

      <Space direction="vertical" size={10} style={{ width: '100%' }}>
        {segments.length === 0 && (
          <Typography.Text type="secondary">Bấm các nút trên để thêm ô vào vòng quay.</Typography.Text>
        )}
        {segments.map((seg) => (
          <WheelSegmentCard
            key={seg.id}
            seg={seg}
            activeTotal={activeTotal}
            optionsExpanded={expandedOptions[seg.id] ?? false}
            onToggleOptions={() => toggleOptions(seg.id)}
            onUpdate={(patch) => updateSeg(seg.id, patch)}
            onRemove={() => removeSegment(seg.id)}
            onRebalance={(target) => rebalanceSeg(seg.id, target)}
            onAddOption={() => addOption(seg)}
            onUpdateOption={(optId, patch) => updateOption(seg, optId, patch)}
            onRemoveOption={(optId) => removeOption(seg, optId)}
            onRebalanceOption={(optId, target) => rebalanceOption(seg, optId, target)}
          />
        ))}
      </Space>
    </div>
  )
}
