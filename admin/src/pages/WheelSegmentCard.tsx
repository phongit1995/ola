import { Button, Card, Input, InputNumber, Select, Slider, Space, Switch, Tag, Typography } from 'antd'
import { DeleteOutlined, DownOutlined, PlusOutlined } from '@ant-design/icons'
import type { WheelSegment, WheelSegmentKind, WheelSegmentOption } from '@/types'
import { VIP_CATALOG, vipIconUrl, vipName } from '@/lib/vipCatalog'
import {
  WHEEL_KINDS,
  formatPercent,
  kindMeta,
  optionStats,
  percent,
  segmentPercent,
} from './wheel/wheelHelpers'

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

interface WheelSegmentCardProps {
  seg: WheelSegment
  activeTotal: number
  optionsExpanded: boolean
  onToggleOptions: () => void
  onUpdate: (patch: Partial<WheelSegment>) => void
  onRemove: () => void
  onRebalance: (target: number) => void
  onAddOption: () => void
  onUpdateOption: (optId: string, patch: Partial<WheelSegmentOption>) => void
  onRemoveOption: (optId: string) => void
  onRebalanceOption: (optId: string, target: number) => void
}

export function WheelSegmentCard({
  seg,
  activeTotal,
  optionsExpanded,
  onToggleOptions,
  onUpdate,
  onRemove,
  onRebalance,
  onAddOption,
  onUpdateOption,
  onRemoveOption,
  onRebalanceOption,
}: WheelSegmentCardProps) {
  const meta = kindMeta(seg.kind)
  const segPercent = segmentPercent(seg, activeTotal)
  const { total: optionTotal, activePct: optionActivePct, balanced: optionBalanced } = optionStats(seg.options)

  return (
    <Card size="small" styles={{ body: { padding: 12 } }} style={{ borderLeft: `4px solid ${meta.color}` }}>
      <Space wrap align="center" style={{ width: '100%', justifyContent: 'space-between' }}>
        <Space wrap align="center">
          <Select<WheelSegmentKind>
            size="small"
            style={{ width: 150 }}
            value={seg.kind}
            options={WHEEL_KINDS.map((k) => ({ value: k.kind, label: k.label }))}
            onChange={(kind) => onUpdate({ kind, options: kind === 'vip_random' ? seg.options : [] })}
          />
          <Input
            size="small"
            style={{ width: 160 }}
            value={seg.label}
            maxLength={100}
            placeholder="Nhãn hiển thị"
            onChange={(e) => onUpdate({ label: e.target.value })}
          />
        </Space>
        <Space align="center">
          <Switch size="small" checked={seg.isActive} onChange={(checked) => onUpdate({ isActive: checked })} />
          <Button size="small" type="text" danger icon={<DeleteOutlined />} onClick={onRemove} />
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
          onChange={(v) => onRebalance(v)}
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
          onChange={(v) => onRebalance(v ?? 0)}
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
            onChange={(v) => onUpdate({ kenAmount: v ?? undefined })}
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
              onChange={(v) => onUpdate({ kenMin: v ?? undefined })}
            />
            <InputNumber
              size="small"
              min={0}
              step={1000}
              addonBefore="Đến"
              addonAfter="Ken"
              value={seg.kenMax}
              onChange={(v) => onUpdate({ kenMax: v ?? undefined })}
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
            onChange={(v) => onUpdate({ vipDays: v ?? undefined })}
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
            onChange={(v) => onUpdate({ vipTypeId: v, label: vipName(v) })}
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
              onChange={(checked) => onUpdate({ isSuperLucky: checked })}
            />
          </Space>
        )}
      </Space>

      {seg.kind === 'vip_random' && (
        <div style={{ marginTop: 12, borderTop: '1px dashed #eee', paddingTop: 10 }}>
          <div
            style={{
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
              gap: 8,
              marginBottom: 8,
              flexWrap: 'wrap',
            }}
          >
            <button
              type="button"
              onClick={onToggleOptions}
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: 8,
                background: 'none',
                border: 'none',
                padding: 0,
                cursor: 'pointer',
              }}
            >
              <DownOutlined
                style={{
                  fontSize: 12,
                  color: '#8c8c8c',
                  transition: 'transform 0.2s',
                  transform: optionsExpanded ? 'rotate(0deg)' : 'rotate(-90deg)',
                }}
              />
              <Typography.Text strong style={{ fontSize: 13 }}>
                Danh sách VIP ngẫu nhiên
              </Typography.Text>
              <Tag style={{ margin: 0 }}>{seg.options.length} lựa chọn</Tag>
              {seg.isActive && (
                <Tag color="purple" style={{ margin: 0 }}>
                  Chiếm {formatPercent(segPercent)} vòng quay
                </Tag>
              )}
              {seg.options.length > 0 && (
                <Tag color={optionBalanced ? 'green' : 'red'} style={{ margin: 0 }}>
                  Nội bộ {formatPercent(optionActivePct)}
                </Tag>
              )}
            </button>
            <Button size="small" icon={<PlusOutlined />} onClick={onAddOption}>
              Thêm lựa chọn
            </Button>
          </div>
          {optionsExpanded && (
            <Space direction="vertical" size={6} style={{ width: '100%' }}>
              {seg.options.map((opt) => {
                const optPercent = opt.isActive ? percent(opt.weight, optionTotal) : opt.weight
                const optOfWheel =
                  seg.isActive && opt.isActive && optionTotal > 0
                    ? segPercent * (opt.weight / optionTotal)
                    : 0
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
                      onChange={(v) => onUpdateOption(opt.id, { vipTypeId: v, label: vipName(v) })}
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
                      onChange={(v) => onRebalanceOption(opt.id, v ?? 0)}
                    />
                    <Tag style={{ margin: 0 }}>{formatPercent(optPercent)} trong nhóm</Tag>
                    <Tag color="blue" style={{ margin: 0 }}>
                      {formatPercent(optOfWheel)} tổng
                    </Tag>
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
                      onChange={(checked) => onUpdateOption(opt.id, { isActive: checked })}
                    />
                    <Button
                      size="small"
                      type="text"
                      danger
                      icon={<DeleteOutlined />}
                      onClick={() => onRemoveOption(opt.id)}
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
          )}
        </div>
      )}
    </Card>
  )
}
