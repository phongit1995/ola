import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import path from 'node:path';
import test from 'node:test';
import type { ForestConfig } from '../assets/farm/scripts/map/layout/ForestLayout.types';
import {
  clearingPolygon,
  forestPlacements,
  rockPlacements,
  clearingDistance,
  insideBounds,
  insideClearing,
} from '../assets/farm/scripts/map/layout/ForestLayout';
import { FARM_LAYOUT } from '../assets/farm/scripts/core/FarmLayoutData';
import { PREVIOUS_FARM_LAYOUT } from '../assets/farm/scripts/core/legacy/PreviousFarmLayout';
import { farmRoadLayout } from '../assets/farm/scripts/core/FarmRoadLayout';
import { insideClearing as buildable } from '../assets/farm/scripts/core/BuildingGeometry';

const config = JSON.parse(
  readFileSync(path.resolve(__dirname, '../assets/farm/data/farm-decor/forest.json'), 'utf8')
) as ForestConfig;
const whole = {
  left: config.clearing.left - 1200,
  right: config.clearing.right + 1200,
  bottom: config.clearing.bottom - 1200,
  top: config.clearing.top + 1200,
};
const ordered = (list: ReturnType<typeof forestPlacements>) => list.sort((a, b) => a.id.localeCompare(b.id));

test('camera extensions contain exactly the same trees as one larger authored map, including negative grid coordinates', () => {
  const b = config.clearing;
  const authored = { left: b.left - 400, right: b.right + 400, bottom: b.bottom - 400, top: b.top + 400 };
  const all = forestPlacements(whole, config);
  const center = forestPlacements(authored, config);
  const margin = all.filter(p => !insideBounds(p.x, p.y, authored));
  assert.deepEqual(ordered([...center, ...margin]), ordered(all));
  assert.equal(new Set([...center, ...margin].map(t => t.id)).size, all.length);
  assert.ok(center.length > 0 && margin.length > 0, 'both authored forest and camera extensions are exercised');
  assert.equal(new Set(center.map(t => t.species)).size, config.species.length);
});

test('panning and resizing do not change the species, scale or position of a tree shared by two viewports', () => {
  const a = forestPlacements({ left: -3600, right: 800, bottom: -2400, top: 1900 }, config);
  const bounds = { left: -1800, right: 3200, bottom: -2000, top: 2500 };
  const b = new Map(forestPlacements(bounds, config).map(t => [t.id, t]));
  const overlap = a.filter(t => insideBounds(t.x, t.y, bounds));
  assert.ok(overlap.length > 50);
  for (const tree of overlap) assert.deepEqual(b.get(tree.id), tree);
});

test('the clearing excludes all forest roots and generation does not depend on prior calls', () => {
  const first = forestPlacements(whole, config);
  forestPlacements({ left: 0, right: 800, bottom: 0, top: 800 }, config);
  assert.deepEqual(forestPlacements(whole, config), first);
  assert.ok(first.every(t => !insideClearing(t.x, t.y, config)));
  assert.ok(first.every(t => t.scale > 0 && Number.isFinite(t.x) && Number.isFinite(t.y)));
});

test('rocks match across authored bounds, overlapping camera margins and repeated requests', () => {
  const authored = { left: -1550, right: 2050, bottom: -1650, top: 1350 };
  const sort = (list: ReturnType<typeof rockPlacements>) => list.sort((a, b) => a.id.localeCompare(b.id));
  const all = rockPlacements(whole, config),
    center = rockPlacements(authored, config);
  assert.deepEqual(sort([...center, ...all.filter(p => !insideBounds(p.x, p.y, authored))]), sort([...all]));
  const bounds = { left: -1800, right: 3200, bottom: -2000, top: 2500 };
  assert.deepEqual(sort(rockPlacements(bounds, config)), sort(all.filter(p => insideBounds(p.x, p.y, bounds))));
  assert.deepEqual(rockPlacements(whole, config), all);
  assert.equal(new Set(all.map(p => p.id)).size, all.length);
  assert.ok(center.some(p => p.zone === 'forest-rocks'));
});

test('the clearing has four straight isometric sides and holds every authored building, field and road', () => {
  const c = config.clearing,
    poly = clearingPolygon(config);
  assert.equal(poly.length, 4);
  for (const [i, p] of poly.entries()) {
    const q: { x: number; y: number } = poly[(i + 1) % poly.length];
    assert.equal(Math.abs((q.y - p.y) / (q.x - p.x)), FARM_LAYOUT.roadPlan!.stepY / FARM_LAYOUT.roadPlan!.stepX);
  }
  for (const [x, y] of [
    [c.left, c.top],
    [c.right, c.top],
    [c.right, c.bottom],
    [c.left, c.bottom],
  ] as const)
    assert.ok(clearingDistance(x, y, config) > 150, 'the corner at ' + x + ',' + y + ' is cut away');
  for (const p of poly) assert.ok(p.x >= c.left - 1 && p.x <= c.right + 1 && p.y >= c.bottom - 1 && p.y <= c.top + 1);
  // Everything the player owns has to survive the cut, so nothing authored may fall outside.
  const inside = (x: number, y: number): boolean => insideClearing(x, y, config);
  for (const b of FARM_LAYOUT.buildings)
    for (const f of b.footprints)
      for (const p of f) assert.ok(inside(p.x + b.position.x, p.y + b.position.y), b.id + ' stays inside the clearing');
  for (const o of [...FARM_LAYOUT.obstacles, ...FARM_LAYOUT.decor])
    for (const p of o.polygon) assert.ok(inside(p.x, p.y), o.id + ' stays inside the clearing');
  for (const t of farmRoadLayout(FARM_LAYOUT).tiles)
    for (const [dx, dy] of [
      [0, 36],
      [72, 0],
      [0, -36],
      [-72, 0],
    ])
      assert.ok(inside(t.x + dx, t.y + dy), t.id + ' stays inside the clearing');
});

test('forest and placement boundaries agree, and the previous clearing remains buildable', () => {
  // Both shipped layout versions used these rounded bounds, without a diamond corner cut.
  const previous = PREVIOUS_FARM_LAYOUT.bounds;
  for (let y = -1700; y <= 1500; y += 25)
    for (let x = -2600; x <= 3300; x += 25) {
      assert.equal(insideClearing(x, y, config), buildable({ x, y }, FARM_LAYOUT.bounds));
      if (buildable({ x, y }, previous))
        assert.ok(buildable({ x, y }, FARM_LAYOUT.bounds), 'existing saved positions stay in the clearing');
    }
  // The four tangent points maximize each isometric half-plane over the old rounded rectangle.
  // Checking them also catches tiny excluded crescents between the grid samples above.
  for (const sx of [-1, 1])
    for (const sy of [-1, 1]) {
      const r = previous.radius;
      const x = (sx < 0 ? previous.left + r : previous.right - r) + (sx * r) / Math.sqrt(5);
      const y = (sy < 0 ? previous.bottom + r : previous.top - r) + (sy * 2 * r) / Math.sqrt(5);
      assert.ok(buildable({ x, y }, FARM_LAYOUT.bounds), 'the whole shipped clearing stays inside the new diamond');
    }
});

test('the border mixes rock species, sizes and spacing while staying near four closed sides', () => {
  const kerb = rockPlacements(whole, config).filter(p => p.zone === 'rock-border');
  const authored = JSON.parse(
    readFileSync(path.resolve(__dirname, '../source-assets/farm-beautify/placements.json'), 'utf8')
  ).placements.filter((p: { zone: string }) => p.zone === 'rock-border');
  assert.deepEqual(
    authored.map(({ asset, group, ...p }: any) => p),
    kerb,
    'all four complete sides exist in the editor prefab, including corners outside the forest rectangle'
  );
  const edging = config.rocks.edging!;
  assert.ok(
    kerb.every(p => edging.kinds.includes(config.rocks.types[p.kind].id)),
    'only kerb kinds are used'
  );
  assert.equal(new Set(kerb.map(p => p.kind)).size, edging.kinds.length);
  assert.ok(new Set(kerb.map(p => p.scale)).size > 30, 'sizes do not repeat as one uniform wall');
  const maxGap = Math.hypot(config.rocks.borderStep * (1 + 2 * edging.jitterAlong!), 2 * edging.jitterOut!) + 0.003;
  const gaps = [];
  for (const [i, a] of kerb.entries()) {
    const b = kerb[(i + 1) % kerb.length],
      gap = Math.hypot(a.x - b.x, a.y - b.y);
    assert.ok(gap <= maxGap, a.id + ' joins ' + b.id);
    gaps.push(Math.round(gap * 10));
  }
  assert.ok(new Set(gaps).size > 30, 'spacing varies along the border');
  assert.equal(new Set(kerb.map(p => p.id.split('-')[1])).size, 4);
  const poly = clearingPolygon(config);
  for (let edge = 0; edge < 4; edge++) {
    const run = kerb.filter(p => p.id.startsWith(`RockBorder-${edge}-`));
    assert.ok(run.length > 10);
    const dx = poly[(edge + 1) % 4].x - poly[edge].x,
      dy = poly[(edge + 1) % 4].y - poly[edge].y;
    assert.equal(new Set(run.map(p => p.kind)).size, edging.kinds.length, 'all kinds appear on each side');
    const offsets = run.map(p => Math.abs((p.x - run[0].x) * dy - (p.y - run[0].y) * dx) / Math.hypot(dx, dy));
    assert.ok(
      offsets.every(d => d < edging.jitterOut! + 0.002),
      'the outline remains four sides'
    );
    assert.ok(
      offsets.some(d => d > edging.jitterOut! * 0.75),
      'individual stones do not stand in one rigid line'
    );
  }
});

test('the entire rock sprite stays off playable ground', () => {
  const registry = JSON.parse(
    readFileSync(path.resolve(__dirname, '../assets/farm/data/farm-decor/manifest.json'), 'utf8')
  );
  for (const type of config.species) {
    const asset = registry.images.find((a: { id: string }) => a.id === type.id);
    assert.deepEqual(type.canopy, { width: asset.width, height: asset.height, anchorY: asset.anchor[1] });
    assert.equal(asset.anchor[0], 0.5);
  }
  for (const type of config.rocks.types) {
    const asset = registry.images.find((a: { id: string }) => a.id === type.id);
    const x = Math.max(asset.anchor[0], 1 - asset.anchor[0]) * asset.width;
    const y = Math.max(asset.anchor[1], 1 - asset.anchor[1]) * asset.height;
    assert.ok(type.radius >= Math.hypot(x, y), type.id + ' radius encloses native sprite');
  }
  const all = rockPlacements(whole, config);
  for (const p of all) assert.ok(clearingDistance(p.x, p.y, config) >= config.rocks.types[p.kind].radius * p.scale + 6);
});
