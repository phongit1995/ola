import { useEffect, useState } from 'react'
import { App, Divider, Input, InputNumber, Modal, Switch, Typography } from 'antd'
import { useCreateWheel, useSaveWheelConfig, useUpdateWheel } from './useWheelQueries'
import { errorMessage } from '@/lib/apiError'
import { kenNumberInputProps } from '@/lib/format'
import type { Wheel, WheelSegment } from '@/types'
import { WheelBuilder } from './WheelBuilder'
import { loadWheel, toConfigRequest, validate } from './utils'

interface WheelEditorModalProps {
  open: boolean
  wheel: Wheel | null
  nextSortOrder: number
  onClose: () => void
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
      message.error(errorMessage(err, 'Lưu thất bại'))
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
