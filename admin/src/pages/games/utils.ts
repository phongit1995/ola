export function polar(cx: number, cy: number, r: number, angle: number): [number, number] {
  const rad = ((angle - 90) * Math.PI) / 180
  return [cx + r * Math.cos(rad), cy + r * Math.sin(rad)]
}

export function ringSegment(
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

export function sumWeight(rows: { weight: number }[]): number {
  return rows.reduce((acc, row) => acc + row.weight, 0)
}
