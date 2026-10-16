import { useId, useState } from 'react'
import { Typography } from 'antd'
import { formatPercent, percent } from './egg/eggHelpers'

export interface OddsGroup {
  id: string
  label: string
  weight: number
  color: string
  children: { label: string; weight: number }[]
}

interface OddsSunburstProps {
  groups: OddsGroup[]
  size: number
  icon: string
  ariaLabel: string
  emptyText?: string
}

interface Slice {
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

function sumWeight(rows: { weight: number }[]): number {
  return rows.reduce((acc, row) => acc + row.weight, 0)
}

export function OddsSunburst({ groups, size, icon, ariaLabel, emptyText }: OddsSunburstProps) {
  const [hover, setHover] = useState<{ label: string; percentText: string } | null>(null)
  const shadowId = useId()

  if (groups.length === 0 && emptyText) {
    return <Typography.Text type="secondary">{emptyText}</Typography.Text>
  }

  const cx = size / 2
  const cy = size / 2
  const innerR = size * 0.16
  const midR = size * 0.29
  const ringGap = size * 0.012
  const outerR = size * 0.47
  const innerLabelR = (innerR + midR) / 2
  const outerLabelR = (midR + ringGap + outerR) / 2
  const totalWeight = sumWeight(groups)

  const inner: Slice[] = []
  const outer: Slice[] = []

  let angle = 0
  for (const group of groups) {
    const groupPct = percent(group.weight, totalWeight)
    const span = (group.weight / totalWeight) * 360
    const [ilx, ily] = polar(cx, cy, innerLabelR, angle + span / 2)

    inner.push({
      path: ringSegment(cx, cy, innerR, midR, angle, angle + span),
      color: group.color,
      opacity: 1,
      label: group.label,
      percentValue: groupPct,
      labelX: ilx,
      labelY: ily,
      showLabel: span >= 22,
    })

    const childTotal = sumWeight(group.children)
    if (group.children.length === 0 || childTotal === 0) {
      outer.push({
        path: ringSegment(cx, cy, midR + ringGap, outerR, angle, angle + span),
        color: group.color,
        opacity: 0.4,
        label: group.label,
        percentValue: groupPct,
        labelX: 0,
        labelY: 0,
        showLabel: false,
      })
    } else {
      let childAngle = angle
      group.children.forEach((child, index) => {
        const childSpan = (child.weight / childTotal) * span
        const [olx, oly] = polar(cx, cy, outerLabelR, childAngle + childSpan / 2)
        outer.push({
          path: ringSegment(cx, cy, midR + ringGap, outerR, childAngle, childAngle + childSpan),
          color: group.color,
          opacity: 0.82 - (index % 4) * 0.16,
          label: `${group.label} ▸ ${child.label}`,
          percentValue: groupPct * (child.weight / childTotal),
          labelX: olx,
          labelY: oly,
          showLabel: childSpan >= 20,
        })
        childAngle += childSpan
      })
    }

    angle += span
  }

  const allSlices = [...inner, ...outer]

  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 28, flexWrap: 'wrap', justifyContent: 'center' }}>
      <div style={{ position: 'relative', width: size, height: size }}>
        <svg width={size} height={size} role="img" aria-label={ariaLabel}>
          <defs>
            <filter id={shadowId} x="-20%" y="-20%" width="140%" height="140%">
              <feDropShadow dx="0" dy="2" stdDeviation="3" floodColor="#000" floodOpacity="0.18" />
            </filter>
          </defs>
          <g filter={`url(#${shadowId})`}>
            {allSlices.map((slice, i) => (
              <path
                key={i}
                d={slice.path}
                fill={slice.color}
                fillOpacity={slice.opacity}
                stroke="#fff"
                strokeWidth={2}
                style={{ cursor: 'pointer', transition: 'fill-opacity 0.15s' }}
                onMouseEnter={() =>
                  setHover({ label: slice.label, percentText: formatPercent(slice.percentValue) })
                }
                onMouseLeave={() => setHover(null)}
              />
            ))}
          </g>
          {allSlices
            .filter((slice) => slice.showLabel)
            .map((slice, i) => (
              <text
                key={`l-${i}`}
                x={slice.labelX}
                y={slice.labelY}
                textAnchor="middle"
                dominantBaseline="central"
                fontSize={12}
                fontWeight={700}
                fill="#fff"
                style={{ pointerEvents: 'none', paintOrder: 'stroke' }}
                stroke="rgba(0,0,0,0.25)"
                strokeWidth={0.6}
              >
                {formatPercent(slice.percentValue)}
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
              <span style={{ fontSize: 26 }}>{icon}</span>
              <Typography.Text type="secondary" style={{ fontSize: 11 }}>
                Di chuột để xem %
              </Typography.Text>
            </>
          )}
        </div>
      </div>

      <div style={{ display: 'flex', flexDirection: 'column', gap: 10, minWidth: 180 }}>
        {groups.map((group) => (
          <div key={group.id} style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
            <span
              style={{
                width: 14,
                height: 14,
                borderRadius: 4,
                background: group.color,
                display: 'inline-block',
                flex: '0 0 auto',
              }}
            />
            <Typography.Text style={{ flex: 1 }} ellipsis>
              {group.label}
            </Typography.Text>
            <Typography.Text strong>{formatPercent(percent(group.weight, totalWeight))}</Typography.Text>
          </div>
        ))}
      </div>
    </div>
  )
}
