import { useState } from 'react'
import { Typography } from 'antd'
import {
  CATEGORY_COLORS,
  formatPercent,
  percent,
  sumActiveWeight,
  type EggCategory,
  type EggReward,
} from './egg/mockEgg'

interface EggOddsSunburstProps {
  categories: EggCategory[]
  rewards: EggReward[]
  size?: number
}

interface Segment {
  path: string
  color: string
  opacity: number
  label: string
  percentValue: number
  labelX: number
  labelY: number
  showLabel: boolean
}

function polar(cx: number, cy: number, r: number, angle: number): [number, number] {
  const rad = ((angle - 90) * Math.PI) / 180
  return [cx + r * Math.cos(rad), cy + r * Math.sin(rad)]
}

function ringSegment(
  cx: number,
  cy: number,
  rInner: number,
  rOuter: number,
  startAngle: number,
  endAngle: number,
): string {
  const sweep = Math.min(endAngle - startAngle, 359.999)
  const end = startAngle + sweep
  const [ox1, oy1] = polar(cx, cy, rOuter, startAngle)
  const [ox2, oy2] = polar(cx, cy, rOuter, end)
  const [ix2, iy2] = polar(cx, cy, rInner, end)
  const [ix1, iy1] = polar(cx, cy, rInner, startAngle)
  const large = sweep > 180 ? 1 : 0
  return [
    `M ${ox1} ${oy1}`,
    `A ${rOuter} ${rOuter} 0 ${large} 1 ${ox2} ${oy2}`,
    `L ${ix2} ${iy2}`,
    `A ${rInner} ${rInner} 0 ${large} 0 ${ix1} ${iy1}`,
    'Z',
  ].join(' ')
}

export function EggOddsSunburst({ categories, rewards, size = 340 }: EggOddsSunburstProps) {
  const [hover, setHover] = useState<{ label: string; percentText: string } | null>(null)

  const cx = size / 2
  const cy = size / 2
  const innerR = size * 0.16
  const midR = size * 0.29
  const ringGap = size * 0.012
  const outerR = size * 0.47
  const innerLabelR = (innerR + midR) / 2
  const outerLabelR = (midR + ringGap + outerR) / 2

  const activeCategories = categories.filter((c) => c.isActive && c.weight > 0)
  const totalCategoryWeight = sumActiveWeight(activeCategories)

  const inner: Segment[] = []
  const outer: Segment[] = []

  let angle = 0
  for (const category of activeCategories) {
    const categoryPct = percent(category.weight, totalCategoryWeight)
    const span = (category.weight / totalCategoryWeight) * 360
    const color = CATEGORY_COLORS[category.type]
    const innerMid = angle + span / 2
    const [ilx, ily] = polar(cx, cy, innerLabelR, innerMid)

    inner.push({
      path: ringSegment(cx, cy, innerR, midR, angle, angle + span),
      color,
      opacity: 1,
      label: category.label,
      percentValue: categoryPct,
      labelX: ilx,
      labelY: ily,
      showLabel: span >= 22,
    })

    const items = rewards
      .filter((r) => r.categoryId === category.id && r.isActive && r.weight > 0)
      .sort((a, b) => a.sortOrder - b.sortOrder)
    const totalItemWeight = sumActiveWeight(items)

    if (items.length === 0 || totalItemWeight === 0) {
      outer.push({
        path: ringSegment(cx, cy, midR + ringGap, outerR, angle, angle + span),
        color,
        opacity: 0.4,
        label: category.label,
        percentValue: categoryPct,
        labelX: 0,
        labelY: 0,
        showLabel: false,
      })
    } else {
      let itemAngle = angle
      items.forEach((item, index) => {
        const itemSpan = (item.weight / totalItemWeight) * span
        const totalPct = categoryPct * (item.weight / totalItemWeight)
        const mid = itemAngle + itemSpan / 2
        const [olx, oly] = polar(cx, cy, outerLabelR, mid)
        outer.push({
          path: ringSegment(cx, cy, midR + ringGap, outerR, itemAngle, itemAngle + itemSpan),
          color,
          opacity: 0.82 - (index % 4) * 0.16,
          label: `${category.label} ▸ ${item.label}`,
          percentValue: totalPct,
          labelX: olx,
          labelY: oly,
          showLabel: itemSpan >= 20,
        })
        itemAngle += itemSpan
      })
    }

    angle += span
  }

  const allSegments = [...inner, ...outer]

  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 28, flexWrap: 'wrap', justifyContent: 'center' }}>
      <div style={{ position: 'relative', width: size, height: size }}>
        <svg width={size} height={size} role="img" aria-label="Tỉ lệ phần thưởng">
          <defs>
            <filter id="eggShadow" x="-20%" y="-20%" width="140%" height="140%">
              <feDropShadow dx="0" dy="2" stdDeviation="3" floodColor="#000" floodOpacity="0.18" />
            </filter>
          </defs>
          <g filter="url(#eggShadow)">
            {allSegments.map((seg, i) => (
              <path
                key={i}
                d={seg.path}
                fill={seg.color}
                fillOpacity={seg.opacity}
                stroke="#fff"
                strokeWidth={2}
                style={{ cursor: 'pointer', transition: 'fill-opacity 0.15s' }}
                onMouseEnter={() =>
                  setHover({ label: seg.label, percentText: formatPercent(seg.percentValue) })
                }
                onMouseLeave={() => setHover(null)}
              />
            ))}
          </g>
          {allSegments
            .filter((seg) => seg.showLabel)
            .map((seg, i) => (
              <text
                key={`l-${i}`}
                x={seg.labelX}
                y={seg.labelY}
                textAnchor="middle"
                dominantBaseline="central"
                fontSize={12}
                fontWeight={700}
                fill="#fff"
                style={{ pointerEvents: 'none', paintOrder: 'stroke' }}
                stroke="rgba(0,0,0,0.25)"
                strokeWidth={0.6}
              >
                {formatPercent(seg.percentValue)}
              </text>
            ))}
          <circle cx={cx} cy={cy} r={innerR - 1} fill="#fff" />
        </svg>
        <div
          style={{
            position: 'absolute',
            inset: 0,
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
            textAlign: 'center',
            pointerEvents: 'none',
            padding: size * 0.3,
          }}
        >
          {hover ? (
            <>
              <Typography.Text strong style={{ fontSize: 20, lineHeight: 1.1 }}>
                {hover.percentText}
              </Typography.Text>
              <Typography.Text type="secondary" style={{ fontSize: 11, lineHeight: 1.2 }}>
                {hover.label}
              </Typography.Text>
            </>
          ) : (
            <>
              <span style={{ fontSize: 26 }}>🥚</span>
              <Typography.Text type="secondary" style={{ fontSize: 11 }}>
                Di chuột để xem %
              </Typography.Text>
            </>
          )}
        </div>
      </div>

      <div style={{ display: 'flex', flexDirection: 'column', gap: 10, minWidth: 180 }}>
        {activeCategories.map((category) => (
          <div key={category.id} style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
            <span
              style={{
                width: 14,
                height: 14,
                borderRadius: 4,
                background: CATEGORY_COLORS[category.type],
                display: 'inline-block',
                flex: '0 0 auto',
              }}
            />
            <Typography.Text style={{ flex: 1 }}>{category.label}</Typography.Text>
            <Typography.Text strong>
              {formatPercent(percent(category.weight, totalCategoryWeight))}
            </Typography.Text>
          </div>
        ))}
      </div>
    </div>
  )
}
