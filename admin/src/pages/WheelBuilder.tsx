import {
  Button,
  Card,
  Input,
  InputNumber,
  Select,
  Slider,
  Space,
  Switch,
  Tag,
  Typography,
} from 'antd'
import { DeleteOutlined, PlusOutlined } from '@ant-design/icons'
import type { WheelSegment, WheelSegmentKind, WheelSegmentOption } from '@/types'
import { VIP_CATALOG, vipIconUrl, vipName } from '@/lib/vipCatalog'
import {
  WHEEL_KINDS,
  kindMeta,
  newId,
  percent,
  rebalanceWeights,
  sumActiveWeight,
} from './wheel/wheelHelpers'

interface WheelBuilderProps {
  segments: WheelSegment[]
  onChange: (segments: WheelSegment[]) => void
}

const vipOptions = VIP_CATALOG.map((entry) => ({
  value: entry.id,
  label: (
    <Space>
      <img src={vipIconUrl(entry.id)} alt="" style={{ width: 18, height: 18, borderRadius: 4 }} />
      <span>
        #{entry.id} {entry.name}
      </span>
    </Space>
  ),
}))

export function WheelBuilder({ segments, onChange }: WheelBuilderProps) {
  const activeTotal = sumActiveWeight(segments)

  function updateSeg(id: string, patch: Partial<WheelSegment>) {
    onChange(segments.map((s) => (s.id === id ? { ...s, ...patch } : s)))
  }

  function addSegment(kind: WheelSegmentKind) {
    const meta = kindMeta(kind)
    const sortOrder = segments.reduce((max, s) => Math.max(max, s.sortOrder), -1) + 1
    onChange([
      ...segments,
      {
        id: newId('seg'),
        kind,
        label: meta.label,
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
  }

  function updateOption(seg: WheelSegment, optId: string, patch: Partial<WheelSegmentOption>) {
    updateSeg(seg.id, {
      options: seg.options.map((o) => (o.id === optId ? { ...o, ...patch } : o)),
    })
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
    <div>
      <Space wrap style={{ marginBottom: 12 }}>
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

      <Space direction="vertical" size={10} style={{ width: '100%' }}>
        {segments.length === 0 && (
          <Typography.Text type="secondary">
            Bấm các nút trên để thêm ô vào vòng quay.
          </Typography.Text>
        )}
        {segments.map((seg) => {
          const meta = kindMeta(seg.kind)
          const segPercent = seg.isActive ? percent(seg.weight, activeTotal) : seg.weight
          const optionTotal = sumActiveWeight(seg.options)
          return (
            <Card
              key={seg.id}
              size="small"
              styles={{ body: { padding: 12 } }}
              style={{ borderLeft: `4px solid ${meta.color}` }}
            >
              <Space wrap align="center" style={{ width: '100%', justifyContent: 'space-between' }}>
                <Space wrap align="center">
                  <Select<WheelSegmentKind>
                    size="small"
                    style={{ width: 150 }}
                    value={seg.kind}
                    options={WHEEL_KINDS.map((k) => ({ value: k.kind, label: k.label }))}
                    onChange={(kind) =>
                      updateSeg(seg.id, { kind, options: kind === 'vip_random' ? seg.options : [] })
                    }
                  />
                  <Input
                    size="small"
                    style={{ width: 160 }}
                    value={seg.label}
                    maxLength={100}
                    placeholder="Nhãn hiển thị"
                    onChange={(e) => updateSeg(seg.id, { label: e.target.value })}
                  />
                </Space>
                <Space align="center">
                  <Switch
                    size="small"
                    checked={seg.isActive}
                    onChange={(checked) => updateSeg(seg.id, { isActive: checked })}
                  />
                  <Button
                    size="small"
                    type="text"
                    danger
                    icon={<DeleteOutlined />}
                    onClick={() => removeSegment(seg.id)}
                  />
                </Space>
              </Space>

              <div style={{ display: 'flex', gap: 12, alignItems: 'center', margin: '10px 0' }}>
                <Typography.Text type="secondary" style={{ width: 64 }}>
                  Tỉ lệ
                </Typography.Text>
                <Slider
                  style={{ flex: 1 }}
                  min={0}
                  max={100}
                  step={0.01}
                  value={Number(segPercent.toFixed(2))}
                  disabled={!seg.isActive}
                  onChange={(v) => rebalanceSeg(seg.id, v)}
                />
                <InputNumber
                  size="small"
                  min={0}
                  max={100}
                  step={0.01}
                  addonAfter="%"
                  style={{ width: 110 }}
                  value={Number(segPercent.toFixed(2))}
                  disabled={!seg.isActive}
                  onChange={(v) => rebalanceSeg(seg.id, v ?? 0)}
                />
              </div>

              <Space wrap align="center">
                {seg.kind === 'ken_fixed' && (
                  <InputNumber
                    size="small"
                    min={1}
                    addonAfter="Ken"
                    placeholder="1000"
                    value={seg.kenAmount}
                    onChange={(v) => updateSeg(seg.id, { kenAmount: v ?? undefined })}
                  />
                )}
                {seg.kind === 'ken_random' && (
                  <>
                    <InputNumber
                      size="small"
                      min={0}
                      step={1000}
                      addonBefore="Từ"
                      addonAfter="Ken"
                      value={seg.kenMin}
                      onChange={(v) => updateSeg(seg.id, { kenMin: v ?? undefined })}
                    />
                    <InputNumber
                      size="small"
                      min={0}
                      step={1000}
                      addonBefore="Đến"
                      addonAfter="Ken"
                      value={seg.kenMax}
                      onChange={(v) => updateSeg(seg.id, { kenMax: v ?? undefined })}
                    />
                    <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                      kết quả làm tròn nghìn
                    </Typography.Text>
                  </>
                )}
                {seg.kind === 'vip_days' && (
                  <InputNumber
                    size="small"
                    min={1}
                    max={3650}
                    addonAfter="ngày"
                    placeholder="7"
                    value={seg.vipDays}
                    onChange={(v) => updateSeg(seg.id, { vipDays: v ?? undefined })}
                  />
                )}
                {seg.kind === 'vip_item' && (
                  <Select
                    size="small"
                    showSearch
                    style={{ width: 240 }}
                    placeholder="Chọn VIP"
                    optionFilterProp="label"
                    value={seg.vipTypeId}
                    options={vipOptions}
                    filterOption={(input, option) =>
                      vipName(Number(option?.value)).toLowerCase().includes(input.toLowerCase())
                    }
                    onChange={(v) => updateSeg(seg.id, { vipTypeId: v, label: vipName(v) })}
                  />
                )}
                {seg.kind !== 'miss' && (
                  <Space align="center">
                    <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                      Siêu may mắn
                    </Typography.Text>
                    <Switch
                      size="small"
                      checked={seg.isSuperLucky}
                      onChange={(checked) => updateSeg(seg.id, { isSuperLucky: checked })}
                    />
                  </Space>
                )}
              </Space>

              {seg.kind === 'vip_random' && (
                <div style={{ marginTop: 12, borderTop: '1px dashed #eee', paddingTop: 10 }}>
                  <Space style={{ marginBottom: 8, justifyContent: 'space-between', width: '100%' }}>
                    <Typography.Text strong style={{ fontSize: 13 }}>
                      Danh sách VIP ngẫu nhiên
                    </Typography.Text>
                    <Button size="small" icon={<PlusOutlined />} onClick={() => addOption(seg)}>
                      Thêm lựa chọn
                    </Button>
                  </Space>
                  <Space direction="vertical" size={6} style={{ width: '100%' }}>
                    {seg.options.map((opt) => {
                      const optPercent = opt.isActive ? percent(opt.weight, optionTotal) : opt.weight
                      return (
                        <Space key={opt.id} wrap align="center" style={{ width: '100%' }}>
                          <Select
                            size="small"
                            showSearch
                            style={{ width: 210 }}
                            placeholder="Chọn VIP"
                            optionFilterProp="label"
                            value={opt.vipTypeId}
                            options={vipOptions}
                            filterOption={(input, option) =>
                              vipName(Number(option?.value)).toLowerCase().includes(input.toLowerCase())
                            }
                            onChange={(v) => updateOption(seg, opt.id, { vipTypeId: v, label: vipName(v) })}
                          />
                          <InputNumber
                            size="small"
                            min={0}
                            max={100}
                            step={0.01}
                            addonAfter="%"
                            style={{ width: 110 }}
                            value={Number(optPercent.toFixed(2))}
                            disabled={!opt.isActive}
                            onChange={(v) => rebalanceOption(seg, opt.id, v ?? 0)}
                          />
                          {opt.vipTypeId != null && (
                            <Tag color="gold">
                              <img
                                src={vipIconUrl(opt.vipTypeId)}
                                alt=""
                                style={{ width: 14, height: 14, verticalAlign: -2, marginRight: 4 }}
                              />
                              {vipName(opt.vipTypeId)}
                            </Tag>
                          )}
                          <Switch
                            size="small"
                            checked={opt.isActive}
                            onChange={(checked) => updateOption(seg, opt.id, { isActive: checked })}
                          />
                          <Button
                            size="small"
                            type="text"
                            danger
                            icon={<DeleteOutlined />}
                            onClick={() => removeOption(seg, opt.id)}
                          />
                        </Space>
                      )
                    })}
                    {seg.options.length === 0 && (
                      <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                        Chưa có lựa chọn — thêm ít nhất 1 VIP.
                      </Typography.Text>
                    )}
                  </Space>
                </div>
              )}
            </Card>
          )
        })}
      </Space>
    </div>
  )
}
