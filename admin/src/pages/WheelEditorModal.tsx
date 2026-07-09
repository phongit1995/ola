import { useEffect, useState } from 'react'
import { App, Divider, Input, InputNumber, Modal, Switch, Typography } from 'antd'
import { useCreateWheel, useSaveWheelConfig, useUpdateWheel } from '@/hooks/useWheel'
import { ApiError } from '@/lib/apiError'
import { kenNumberInputProps } from '@/lib/format'
import type { SaveWheelConfigRequest, Wheel, WheelSegment } from '@/types'
import { WheelBuilder } from './WheelBuilder'
import { newId } from './wheel/wheelHelpers'

interface WheelEditorModalProps {
  open: boolean
  wheel: Wheel | null
  nextSortOrder: number
  onClose: () => void
}

interface LoadedWheel {
  name: string
  kenCost: number
  freeDailyEnabled: boolean
  isEnabled: boolean
  segments: WheelSegment[]
}

function loadWheel(wheel: Wheel | null): LoadedWheel {
  if (!wheel) {
    return { name: 'Vòng quay mới', kenCost: 5000, freeDailyEnabled: true, isEnabled: true, segments: [] }
  }
  const segments: WheelSegment[] = (wheel.segments ?? []).map((s) => ({
    id: s.id,
    kind: s.kind,
    label: s.label,
    weight: s.weight,
    kenAmount: s.kenAmount,
    kenMin: s.kenMin,
    kenMax: s.kenMax,
    vipDays: s.vipDays,
    vipTypeId: s.vipTypeId,
    isSuperLucky: s.isSuperLucky,
    isActive: s.isActive,
    sortOrder: s.sortOrder,
    options: (s.options ?? []).map((o) => ({
      id: o.id || newId('opt'),
      label: o.label,
      weight: o.weight,
      vipTypeId: o.vipTypeId,
      vipDays: o.vipDays,
      kenAmount: o.kenAmount,
      isActive: o.isActive,
      sortOrder: o.sortOrder,
    })),
  }))
  return {
    name: wheel.name,
    kenCost: wheel.kenCost,
    freeDailyEnabled: wheel.freeDailyEnabled,
    isEnabled: wheel.isEnabled,
    segments,
  }
}

function validate(name: string, segments: WheelSegment[]): string | null {
  if (!name.trim()) return 'Vui lòng nhập tên vòng quay.'
  const active = segments.filter((s) => s.isActive)
  if (active.length === 0) return 'Vòng quay phải có ít nhất 1 ô đang bật.'
  if (active.reduce((sum, s) => sum + s.weight, 0) <= 0) return 'Hãy phân bổ % cho các ô.'
  for (const s of active) {
    if (s.kind === 'ken_fixed' && (s.kenAmount == null || s.kenAmount < 1))
      return `Ô "${s.label}" cần số KEN >= 1.`
    if (s.kind === 'ken_random' && (s.kenMin == null || s.kenMax == null || s.kenMax < s.kenMin))
      return `Ô "${s.label}" cần KEN min/max hợp lệ.`
    if (s.kind === 'vip_days' && (s.vipDays == null || s.vipDays < 1))
      return `Ô "${s.label}" cần số ngày VIP >= 1.`
    if (s.kind === 'vip_item' && s.vipTypeId == null) return `Ô "${s.label}" cần chọn VIP.`
    if (s.kind === 'vip_random') {
      const opts = s.options.filter((o) => o.isActive)
      if (opts.length === 0) return `Ô "${s.label}" cần ít nhất 1 lựa chọn.`
      if (opts.some((o) => o.vipTypeId == null && o.vipDays == null && (o.kenAmount ?? 0) < 1))
        return `Ô "${s.label}" có lựa chọn chưa cấu hình phần thưởng.`
      if (opts.reduce((sum, o) => sum + o.weight, 0) <= 0)
        return `Hãy phân bổ % cho lựa chọn trong ô "${s.label}".`
    }
  }
  return null
}

const round4 = (n: number) => Math.round(n * 10000) / 10000

function toConfigRequest(segments: WheelSegment[]): SaveWheelConfigRequest {
  const activeTotal = segments.filter((s) => s.isActive).reduce((s, seg) => s + seg.weight, 0) || 1
  return {
    segments: segments.map((seg, index) => {
      const optionTotal = seg.options.filter((o) => o.isActive).reduce((s, o) => s + o.weight, 0) || 1
      return {
        kind: seg.kind,
        label: seg.label,
        weight: seg.isActive ? round4((seg.weight / activeTotal) * 100) : 0,
        kenAmount: seg.kenAmount,
        kenMin: seg.kenMin,
        kenMax: seg.kenMax,
        vipDays: seg.vipDays,
        vipTypeId: seg.vipTypeId,
        isSuperLucky: seg.isSuperLucky,
        isActive: seg.isActive,
        sortOrder: index,
        options:
          seg.kind === 'vip_random'
            ? seg.options.map((o, oi) => ({
                label: o.label,
                weight: o.isActive ? round4((o.weight / optionTotal) * 100) : 0,
                vipTypeId: o.vipTypeId,
                vipDays: o.vipDays,
                kenAmount: o.kenAmount,
                isActive: o.isActive,
                sortOrder: oi,
              }))
            : [],
      }
    }),
  }
}

export function WheelEditorModal({ open, wheel, nextSortOrder, onClose }: WheelEditorModalProps) {
  const { message } = App.useApp()
  const createWheel = useCreateWheel()
  const updateWheel = useUpdateWheel()
  const saveConfig = useSaveWheelConfig()

  const [name, setName] = useState('Vòng quay mới')
  const [kenCost, setKenCost] = useState(5000)
  const [freeDailyEnabled, setFreeDailyEnabled] = useState(true)
  const [isEnabled, setIsEnabled] = useState(true)
  const [segments, setSegments] = useState<WheelSegment[]>([])

  useEffect(() => {
    if (!open) return
    const loaded = loadWheel(wheel)
    setName(loaded.name)
    setKenCost(loaded.kenCost)
    setFreeDailyEnabled(loaded.freeDailyEnabled)
    setIsEnabled(loaded.isEnabled)
    setSegments(loaded.segments)
  }, [open, wheel])

  const saving = createWheel.isPending || updateWheel.isPending || saveConfig.isPending

  async function handleSave() {
    const error = validate(name, segments)
    if (error) {
      message.error(error)
      return
    }
    const payload = toConfigRequest(segments)
    const meta = { name: name.trim(), kenCost, freeDailyEnabled, isEnabled }
    try {
      if (wheel) {
        await updateWheel.mutateAsync({ id: wheel.id, payload: meta })
        await saveConfig.mutateAsync({ id: wheel.id, payload })
        message.success('Đã lưu vòng quay')
      } else {
        await createWheel.mutateAsync({ ...meta, sortOrder: nextSortOrder, segments: payload.segments })
        message.success('Đã tạo vòng quay')
      }
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu thất bại')
    }
  }

  return (
    <Modal
      title={wheel ? `Sửa vòng quay: ${wheel.name}` : 'Tạo vòng quay may mắn'}
      open={open}
      onOk={handleSave}
      onCancel={onClose}
      okText={wheel ? 'Lưu' : 'Tạo vòng quay'}
      cancelText="Huỷ"
      confirmLoading={saving}
      width={920}
      style={{ top: 24 }}
      styles={{ body: { maxHeight: 'calc(100vh - 200px)', overflowY: 'auto' } }}
      destroyOnHidden
    >
      <div style={{ display: 'flex', gap: 16, flexWrap: 'wrap', alignItems: 'flex-end', marginBottom: 8 }}>
        <div style={{ flex: '1 1 220px', minWidth: 180 }}>
          <Typography.Text type="secondary" style={{ display: 'block', marginBottom: 4 }}>
            Tên vòng quay
          </Typography.Text>
          <Input value={name} onChange={(e) => setName(e.target.value)} placeholder="Ví dụ: Vòng Quay Vàng" />
        </div>
        <div style={{ width: 170 }}>
          <Typography.Text type="secondary" style={{ display: 'block', marginBottom: 4 }}>
            Giá (Ken/lượt)
          </Typography.Text>
          <InputNumber min={0} style={{ width: '100%' }} value={kenCost} onChange={(v) => setKenCost(v ?? 0)} {...kenNumberInputProps} />
        </div>
        <div>
          <Typography.Text type="secondary" style={{ display: 'block', marginBottom: 4 }}>
            Free mỗi ngày
          </Typography.Text>
          <Switch checked={freeDailyEnabled} onChange={setFreeDailyEnabled} />
        </div>
        <div>
          <Typography.Text type="secondary" style={{ display: 'block', marginBottom: 4 }}>
            Đang bật
          </Typography.Text>
          <Switch checked={isEnabled} onChange={setIsEnabled} />
        </div>
      </div>

      <Divider style={{ margin: '12px 0 16px' }} />

      <WheelBuilder segments={segments} onChange={setSegments} />
    </Modal>
  )
}
