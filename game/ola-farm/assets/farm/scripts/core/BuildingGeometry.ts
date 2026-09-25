import type { Polygon, BuildingPosition, FarmLayoutManifest } from './types/BuildingTypes';

export const translated = (polygon: Polygon, p: BuildingPosition): Polygon =>
  polygon.map(q => ({ x: q.x + p.x, y: q.y + p.y }));
export const diamond = (x: number, y: number, w: number, h: number): Polygon => [
  { x, y: y + h / 2 },
  { x: x + w / 2, y },
  { x, y: y - h / 2 },
  { x: x - w / 2, y },
];
const boundsCache = new WeakMap<Polygon, number[]>();
function bounds(p: Polygon): number[] {
  let b = boundsCache.get(p);
  if (!b) {
    b = [
      Math.min(...p.map(v => v.x)),
      Math.max(...p.map(v => v.x)),
      Math.min(...p.map(v => v.y)),
      Math.max(...p.map(v => v.y)),
    ];
    boundsCache.set(p, b);
  }
  return b;
}
/** Separating-axis test for convex ground footprints. Touching edges are allowed. */
export function overlaps(a: Polygon, b: Polygon): boolean {
  const aaBounds = bounds(a),
    bbBounds = bounds(b);
  if (
    aaBounds[1] <= bbBounds[0] ||
    bbBounds[1] <= aaBounds[0] ||
    aaBounds[3] <= bbBounds[2] ||
    bbBounds[3] <= aaBounds[2]
  )
    return false;
  for (const poly of [a, b])
    for (let i = 0; i < poly.length; i++) {
      const p = poly[i],
        q = poly[(i + 1) % poly.length],
        nx = p.y - q.y,
        ny = q.x - p.x;
      let amin = Infinity,
        amax = -Infinity,
        bmin = Infinity,
        bmax = -Infinity;
      for (let j = 0; j < a.length; j++) {
        const d = a[j].x * nx + a[j].y * ny;
        amin = Math.min(amin, d);
        amax = Math.max(amax, d);
      }
      for (let j = 0; j < b.length; j++) {
        const d = b[j].x * nx + b[j].y * ny;
        bmin = Math.min(bmin, d);
        bmax = Math.max(bmax, d);
      }
      if (amax <= bmin + 0.001 || bmax <= amin + 0.001) return false;
    }
  return true;
}
export function insideClearing(p: BuildingPosition, b: FarmLayoutManifest['bounds']): boolean {
  if (p.x < b.left || p.x > b.right || p.y < b.bottom || p.y > b.top) return false;
  if (b.shape === 'diamond')
    return (
      Math.abs(p.x - (b.left + b.right) / 2) / ((b.right - b.left) / 2) +
        Math.abs(p.y - (b.bottom + b.top) / 2) / ((b.top - b.bottom) / 2) <=
      1
    );
  // `cut` chamfers the four corners with a diamond, matching the treeline that now closes over them.
  if (b.cut && Math.abs(p.x - (b.left + b.right) / 2) / b.cut.x + Math.abs(p.y - (b.bottom + b.top) / 2) / b.cut.y > 1)
    return false;
  const x = Math.max(b.left + b.radius, Math.min(b.right - b.radius, p.x));
  const y = Math.max(b.bottom + b.radius, Math.min(b.top - b.radius, p.y));
  return Math.hypot(p.x - x, p.y - y) <= b.radius;
}

/** Ground separation in map units, including edge/corner near misses. */
export function tooClose(a: Polygon, b: Polygon, clearance: number): boolean {
  if (overlaps(a, b)) return true;
  if (!clearance) return false;
  const aa = bounds(a),
    bb = bounds(b);
  if (
    aa[1] + clearance <= bb[0] ||
    bb[1] + clearance <= aa[0] ||
    aa[3] + clearance <= bb[2] ||
    bb[3] + clearance <= aa[2]
  )
    return false;
  const limit = clearance * clearance;
  const near = (p: BuildingPosition, q: BuildingPosition, r: BuildingPosition): boolean => {
    const x = r.x - q.x,
      y = r.y - q.y,
      length = x * x + y * y;
    const t = length ? Math.max(0, Math.min(1, ((p.x - q.x) * x + (p.y - q.y) * y) / length)) : 0;
    return (p.x - q.x - t * x) ** 2 + (p.y - q.y - t * y) ** 2 < limit - 0.001;
  };
  return (
    a.some(p => b.some((q, i) => near(p, q, b[(i + 1) % b.length]))) ||
    b.some(p => a.some((q, i) => near(p, q, a[(i + 1) % a.length])))
  );
}

/** Compatibility type used by frozen historical layout snapshots. */
export type { FarmLayoutManifest } from './types/BuildingTypes';
