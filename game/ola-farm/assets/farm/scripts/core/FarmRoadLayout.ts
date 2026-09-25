import type { BuildingPosition, FarmLayoutManifest, Polygon } from './types/BuildingTypes';
import { diamond } from './BuildingGeometry';
import type { RoadNetwork } from './types/RoadTypes';

const DIRECTIONS = [
  [1, 0, 1],
  [0, 1, 2],
  [-1, 0, 4],
  [0, -1, 8],
];
const key = (u: number, v: number): string => `${u},${v}`;
const cache = new WeakMap<FarmLayoutManifest, RoadNetwork>();
/** Compile the authored polylines. There is no routing from current building positions. */
export function farmRoadLayout(manifest: FarmLayoutManifest): RoadNetwork {
  const cached = cache.get(manifest);
  if (cached) return cached;
  const plan = manifest.roadPlan;
  if (!plan || plan.version !== 2 || plan.stepX <= 0 || plan.stepY <= 0) throw Error('Thiếu bản vẽ đường cố định.');
  const endInset = plan.endInset ?? 0;
  if (!Number.isFinite(endInset) || endInset < 0 || endInset > 0.5)
    throw Error('Độ lùi đầu đường phải từ 0 đến nửa ô.');
  const point = (u: number, v: number): BuildingPosition => ({
    x: plan.origin.x + (u - v) * plan.stepX,
    y: plan.origin.y + (u + v) * plan.stepY,
  });
  const nodes = new Map<string, { u: number; v: number }>();
  for (const path of plan.paths) {
    if (path.points.length < 2) throw Error('Đường thiếu điểm: ' + path.id);
    for (let i = 1; i < path.points.length; i++) {
      const [u, v] = path.points[i - 1],
        [x, y] = path.points[i];
      if (![u, v, x, y].every(Number.isInteger) || (u !== x && v !== y) || Math.abs(x - u) + Math.abs(y - v) > 100)
        throw Error('Đoạn đường không nằm trên lưới: ' + path.id);
      const du = Math.sign(x - u),
        dv = Math.sign(y - v),
        steps = Math.abs(x - u) + Math.abs(y - v);
      for (let j = 0; j <= steps; j++) {
        const a = u + du * j,
          b = v + dv * j;
        nodes.set(key(a, b), { u: a, v: b });
      }
    }
  }
  const tiles = Array.from(nodes.values(), ({ u, v }) => {
    const mask = DIRECTIONS.reduce((m, [du, dv, bit]) => m | (nodes.has(key(u + du, v + dv)) ? bit : 0), 0);
    const end = DIRECTIONS.find(([, , bit]) => mask === bit);
    const position = end ? point(u + end[0] * endInset, v + end[1] * endInset) : point(u, v);
    return {
      id: `Road-${u}-${v}`,
      asset: 'DecorRoad' + String(mask).padStart(2, '0'),
      ...position,
      u,
      v,
      mask,
      scale: plan.scale,
      zone: 'roads',
    };
  }).sort((a, b) => b.y - a.y || a.x - b.x);
  const destinations = [
    { id: 'fields', ...manifest.fieldEntrance },
    ...manifest.buildings.map(b => ({ id: b.id, x: b.position.x + b.entrance.x, y: b.position.y + b.entrance.y })),
  ];
  const links = tiles.length
    ? destinations.map(d => {
        const tile = tiles.reduce((a, b) =>
          Math.hypot(a.x - d.x, a.y - d.y) <= Math.hypot(b.x - d.x, b.y - d.y) ? a : b
        );
        return { id: d.id, x: tile.x, y: tile.y, distance: Math.hypot(tile.x - d.x, tile.y - d.y) };
      })
    : [];
  const network = { tiles, links, stepX: plan.stepX, stepY: plan.stepY, origin: plan.origin };
  cache.set(manifest, network);
  return network;
}
const footprints = new WeakMap<FarmLayoutManifest, Polygon[]>();
export function roadFootprints(manifest: FarmLayoutManifest): Polygon[] {
  let value = footprints.get(manifest);
  if (!value) {
    const roads = farmRoadLayout(manifest);
    // Keep the reserved grid footprint stable when only the drawn terminal is shortened.
    value = roads.tiles.map(t =>
      diamond(
        roads.origin.x + (t.u - t.v) * roads.stepX,
        roads.origin.y + (t.u + t.v) * roads.stepY,
        roads.stepX * 2,
        roads.stepY * 2
      )
    );
    footprints.set(manifest, value);
  }
  return value;
}
