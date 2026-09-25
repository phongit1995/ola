import type { ForestBounds, Polygon, ForestConfig, ForestPlacement, RockPlacement } from './ForestLayout.types';

function random(seed: number, col: number, row: number, lane: number): number {
  let h = (seed ^ Math.imul(col, 374761393) ^ Math.imul(row, 668265263) ^ Math.imul(lane, 1274126177)) >>> 0;
  h = Math.imul(h ^ (h >>> 13), 1274126177);
  return ((h ^ (h >>> 16)) >>> 0) / 4294967296;
}

export function insideBounds(x: number, y: number, bounds: ForestBounds): boolean {
  return x >= bounds.left && x <= bounds.right && y >= bounds.bottom && y <= bounds.top;
}

export function insideClearing(x: number, y: number, config: ForestConfig): boolean {
  return clearingDistance(x, y, config) <= 0;
}

/**
 * How far the treeline bulges in or out at this point. Two sine waves of different periods around the clearing
 * centre give bays and headlands, so the edge never reads as the rounded rectangle underneath it.
 */
function wobble(x: number, y: number, config: ForestConfig): number {
  const w = config.wobble;
  if (!w || w.amount <= 0) return 0;
  const b = config.clearing;
  const angle = Math.atan2(y - (b.bottom + b.top) / 2, x - (b.left + b.right) / 2);
  // Only ever outward: a bay that cut inward would drop trees and stones onto ground the farm already uses.
  const shape = Math.sin(angle * w.frequency) * 0.6 + Math.sin(angle * (w.frequency * 1.7) + 1.9) * 0.4;
  return (w.amount * (shape + 1)) / 2;
}

const polygons = new WeakMap<ForestConfig['clearing'], Polygon>();
/** Clockwise clearing outline shared by the straight border and the forest exclusion area. */
export function clearingPolygon(config: ForestConfig): Polygon {
  const b = config.clearing;
  let poly = polygons.get(b);
  if (poly) return poly;
  const cx = (b.left + b.right) / 2,
    cy = (b.bottom + b.top) / 2;
  const hw = (b.right - b.left) / 2,
    hh = (b.top - b.bottom) / 2;
  if (b.shape === 'diamond')
    poly = [
      { x: cx, y: b.top },
      { x: b.right, y: cy },
      { x: cx, y: b.bottom },
      { x: b.left, y: cy },
    ];
  else if (!b.cut || b.cut.x <= 0 || b.cut.y <= 0)
    poly = [
      { x: b.left, y: b.top },
      { x: b.right, y: b.top },
      { x: b.right, y: b.bottom },
      { x: b.left, y: b.bottom },
    ];
  else {
    const ax = b.cut.x * (1 - hh / b.cut.y),
      ay = b.cut.y * (1 - hw / b.cut.x);
    if (ax <= 0 || ay <= 0) throw Error('Clearing diamond cuts away a whole side.');
    poly = [
      { x: cx - ax, y: b.top },
      { x: cx + ax, y: b.top },
      { x: b.right, y: cy + ay },
      { x: b.right, y: cy - ay },
      { x: cx + ax, y: b.bottom },
      { x: cx - ax, y: b.bottom },
      { x: b.left, y: cy - ay },
      { x: b.left, y: cy + ay },
    ];
  }
  polygons.set(b, poly);
  return poly;
}

/** Exact signed distance to a convex outline: negative inside, positive out. */
function polygonDistance(x: number, y: number, poly: Polygon): number {
  let nearest = Infinity,
    inside = true;
  for (let i = 0; i < poly.length; i++) {
    const p = poly[i],
      q = poly[(i + 1) % poly.length];
    const ex = q.x - p.x,
      ey = q.y - p.y,
      wx = x - p.x,
      wy = y - p.y;
    const t = Math.max(0, Math.min(1, (wx * ex + wy * ey) / (ex * ex + ey * ey)));
    nearest = Math.min(nearest, Math.hypot(wx - ex * t, wy - ey * t));
    // Clockwise winding puts the outward normal at (p.y - q.y, q.x - p.x).
    if ((p.y - q.y) * wx + (q.x - p.x) * wy > 0) inside = false;
  }
  return inside ? -nearest : nearest;
}

/** Signed distance to the clearing; positive values are on the forest side. */
export function clearingDistance(x: number, y: number, config: ForestConfig): number {
  return polygonDistance(x, y, clearingPolygon(config)) - wobble(x, y, config);
}

/** Low-frequency noise shared by whole groups of cells, so trees and rocks arrive in clumps with gaps between. */
function clump(x: number, y: number, config: ForestConfig, lane: number): number {
  const c = config.cluster;
  if (!c || c.size <= 0) return 0.5;
  const col = Math.floor(x / c.size),
    row = Math.floor(y / c.size);
  const fx = x / c.size - col,
    fy = y / c.size - row;
  const smooth = (t: number): number => t * t * (3 - 2 * t);
  const a = random(config.seed, col, row, lane),
    b = random(config.seed, col + 1, row, lane);
  const d = random(config.seed, col, row + 1, lane),
    e = random(config.seed, col + 1, row + 1, lane);
  const u = smooth(fx),
    v = smooth(fy);
  return (a + (b - a) * u) * (1 - v) + (d + (e - d) * u) * v;
}

/** A species or rock only shows up where its band of distances from the clearing says it belongs. */
const inBand = (distance: number, band: [number, number] | undefined): boolean =>
  !band || (distance >= band[0] && distance <= band[1]);

export function forestPlacements(bounds: ForestBounds, config: ForestConfig): ForestPlacement[] {
  const placements: ForestPlacement[] = [];
  const totalWeight = config.species.reduce((sum, s) => sum + s.weight, 0);
  if (config.stepX <= 0 || config.stepY <= 0 || totalWeight <= 0) throw Error('Invalid forest spacing or species.');
  const round = (n: number): number => Math.round(n * 1000) / 1000;
  // Extend the grid scan by the possible jitter so adjacent requests return the same edge trees.
  const padX = config.stepX + config.jitterX,
    padY = config.jitterY;
  for (
    let row = Math.floor((bounds.bottom - padY) / config.stepY);
    row <= Math.ceil((bounds.top + padY) / config.stepY);
    row++
  ) {
    for (
      let col = Math.floor((bounds.left - padX) / config.stepX);
      col <= Math.ceil((bounds.right + padX) / config.stepX);
      col++
    ) {
      const x = round(
        col * config.stepX +
          ((((row % 2) + 2) % 2) * config.stepX) / 2 +
          (random(config.seed, col, row, 1) - 0.5) * config.jitterX
      );
      const y = round(row * config.stepY + (random(config.seed, col, row, 2) - 0.5) * config.jitterY);
      if (!insideBounds(x, y, bounds)) continue;
      const distance = clearingDistance(x, y, config);
      if (distance <= 0) continue;
      // Clumps and gaps instead of an even mat: the noise decides, and the deep forest closes up again.
      const strength = config.cluster?.strength ?? 0;
      const density = Math.min(
        1,
        (0.5 + 0.5 * Math.min(1, distance / 900)) * (1 - strength + strength * 2 * clump(x, y, config, 7))
      );
      if (random(config.seed, col, row, 3) > density) continue;
      // Only the species whose band covers this distance can grow here: shrubs near the fields, giants far out.
      const allowed = config.species.filter(sp => inBand(distance, sp.band));
      if (!allowed.length) continue;
      const allowedWeight = allowed.reduce((sum, sp) => sum + sp.weight, 0);
      const roll = random(config.seed, col, row, 4) * allowedWeight;
      let index = 0,
        threshold = allowed[0].weight;
      while (index < allowed.length - 1 && roll >= threshold) threshold += allowed[++index].weight;
      const type = allowed[index],
        species = config.species.indexOf(type);
      const scale = round(type.scale * (0.85 + random(config.seed, col, row, 5) * 0.3));
      // Keep the canopy, including the tall part above a southern tree root, behind the rock edging.
      const c = type.canopy,
        half = (c.width * scale) / 2;
      const box: [number, number][] = [
        [x - half, y - c.height * c.anchorY * scale],
        [x + half, y - c.height * c.anchorY * scale],
        [x - half, y + c.height * (1 - c.anchorY) * scale],
        [x + half, y + c.height * (1 - c.anchorY) * scale],
      ];
      if (box.some(([bx, by]) => clearingDistance(bx, by, config) < config.rocks.treeClearance)) continue;
      placements.push({ id: `Forest-${col}-${row}`, species, x, y, scale });
    }
  }
  return placements;
}

/** Parallel offset lines meet at shared corners, so all four runs close without gaps or rounded bends. */
function offsetOutline(poly: Polygon, distance: number): Polygon {
  const normals = poly.map((p, i) => {
    const q = poly[(i + 1) % poly.length],
      length = Math.hypot(q.x - p.x, q.y - p.y);
    return { x: (p.y - q.y) / length, y: (q.x - p.x) / length };
  });
  return poly.map((p, i) => {
    const a = normals[(i + poly.length - 1) % poly.length],
      b = normals[i];
    const factor = distance / (1 + a.x * b.x + a.y * b.y);
    return { x: p.x + (a.x + b.x) * factor, y: p.y + (a.y + b.y) * factor };
  });
}

/** Same placements in authored scenery and camera extensions, regardless of viewport or request order. */
export function rockPlacements(bounds: ForestBounds, config: ForestConfig): RockPlacement[] {
  const c = config.rocks,
    b = config.clearing,
    result: RockPlacement[] = [];
  const totalWeight = c.types.reduce((sum, t) => sum + t.weight, 0);
  if (c.borderStep <= 0 || c.stepX <= 0 || c.stepY <= 0 || totalWeight <= 0 || b.radius <= 0)
    throw Error('Invalid rock spacing or clearing.');
  const round = (n: number): number => Math.round(n * 1000) / 1000;
  function variant(
    col: number,
    row: number,
    lane: number,
    distance: number
  ): { kind: number; scale: number; radius: number } | null {
    const allowed = c.types.filter(t => inBand(distance, t.band));
    if (!allowed.length) return null;
    const weight = allowed.reduce((sum, t) => sum + t.weight, 0);
    const roll = random(config.seed, col, row, lane) * weight;
    let index = 0,
      threshold = allowed[0].weight;
    while (index < allowed.length - 1 && roll >= threshold) threshold += allowed[++index].weight;
    const type = allowed[index],
      scale = round(type.scale * (0.84 + random(config.seed, col, row, lane + 1) * 0.32));
    return { kind: c.types.indexOf(type), scale, radius: type.radius * scale };
  }
  function place(
    id: string,
    x: number,
    y: number,
    v: NonNullable<ReturnType<typeof variant>>,
    zone: RockPlacement['zone']
  ): boolean {
    x = round(x);
    y = round(y);
    // The radius encloses the whole native sprite, so even its edge stays off playable ground.
    if (!insideBounds(x, y, bounds) || clearingDistance(x, y, config) < v.radius + 6) return false;
    result.push({ id, kind: v.kind, x, y, scale: v.scale, zone });
    return true;
  }
  const spread = c.clusterSpread ?? 0,
    group = Math.max(1, c.clusterSize ?? 1);
  const edging = c.types
    .filter(t => !c.edging || c.edging.kinds.includes(t.id))
    .map(t => {
      const scale = c.edging?.scale ?? t.scale;
      return { kind: c.types.indexOf(t), scale, radius: t.radius * scale, weight: t.weight };
    });
  if (!edging.length) throw Error('Missing border stones.');
  const variation = c.edging?.scaleVariation ?? 0,
    jitterAlong = c.edging?.jitterAlong ?? 0,
    jitterOut = c.edging?.jitterOut ?? 0;
  const weight = edging.reduce((sum, t) => sum + t.weight, 0);
  const outline = offsetOutline(
    clearingPolygon(config),
    Math.max(...edging.map(t => t.radius)) * (1 + variation) + jitterOut + 10
  );
  for (let edge = 0; edge < outline.length; edge++) {
    const p = outline[edge],
      q = outline[(edge + 1) % outline.length];
    const length = Math.hypot(q.x - p.x, q.y - p.y),
      count = Math.ceil(length / c.borderStep);
    const nx = (p.y - q.y) / length,
      ny = (q.x - p.x) / length;
    // Each corner is shared once. Randomness belongs to the edge/index, never to the camera's requested bounds.
    for (let i = 0; i < count; i++) {
      const roll = random(config.seed, edge, i, 20) * weight;
      let k = 0,
        threshold = edging[0].weight;
      while (k < edging.length - 1 && roll >= threshold) threshold += edging[++k].weight;
      const type = edging[k],
        scale = round(type.scale * (1 + (random(config.seed, edge, i, 21) * 2 - 1) * variation));
      const t = (i + (i === 0 ? 0 : (random(config.seed, edge, i, 22) * 2 - 1) * jitterAlong)) / count;
      const out = i === 0 ? 0 : (random(config.seed, edge, i, 23) * 2 - 1) * jitterOut;
      const v = { kind: type.kind, scale, radius: c.types[type.kind].radius * scale };
      place(
        `RockBorder-${edge}-${i}`,
        p.x + (q.x - p.x) * t + nx * out,
        p.y + (q.y - p.y) * t + ny * out,
        v,
        'rock-border'
      );
    }
  }
  for (let row = Math.floor(bounds.bottom / c.stepY) - 1; row <= Math.ceil(bounds.top / c.stepY) + 1; row++) {
    for (let col = Math.floor(bounds.left / c.stepX) - 1; col <= Math.ceil(bounds.right / c.stepX) + 1; col++) {
      const x0 = (col + 0.5 * (((row % 2) + 2) % 2) + (random(config.seed, col, row, 31) - 0.5) * 0.65) * c.stepX;
      const y0 = (row + (random(config.seed, col, row, 32) - 0.5) * 0.65) * c.stepY;
      const strength = config.cluster?.strength ?? 0;
      if (random(config.seed, col, row, 30) > c.density * (1 - strength + strength * 2 * clump(x0, y0, config, 11)))
        continue;
      const members = 1 + Math.floor(random(config.seed, col, row, 35) * group);
      for (let n = 0; n < members; n++) {
        const x = x0 + (random(config.seed, col, row, 36 + n) - 0.5) * spread;
        const y = y0 + (random(config.seed, col, row, 46 + n) - 0.5) * spread * 0.6;
        const distance = clearingDistance(x, y, config);
        const v = variant(col, row + n, 33, distance);
        if (!v || distance < 115 + v.radius) continue;
        place(`ForestRock-${col}-${row}-${n}`, x, y, v, 'forest-rocks');
      }
    }
  }
  return result;
}
