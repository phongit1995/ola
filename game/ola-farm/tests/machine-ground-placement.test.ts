import assert from 'node:assert/strict';
import { test } from 'node:test';
import { FARM_LAYOUT, groundError } from '../assets/farm/scripts/core/BuildingPlacement';
import { diamond } from '../assets/farm/scripts/core/BuildingGeometry';
import { PREVIOUS_SINGLE_BUILDING_LAYOUT } from '../assets/farm/scripts/core/legacy/PreviousSingleBuildingLayout';

// These positions lie inside the former roof/clipped-silhouette reservation,
// but outside the visible foundation. Coordinates are relative to each anchor.
const aboveGround = [
  ['feed-1', 325, 225],
  ['bakery-1', 350, 175],
  ['dairy-1', -100, 550],
  ['grill-1', -350, 250],
  ['industry-sugar_processor', -300, 175],
  ['industry-popcorn_factory', -350, 225],
  ['industry-pie_bakery', -350, 125],
  ['industry-loom', 350, 200],
] as const;

test('production buildings reserve their foundation while allowing ground beside upper art', () => {
  for (const [id, x, y] of aboveGround) {
    const building = FARM_LAYOUT.buildings.find(b => b.id === id);
    assert.ok(building, id);
    const layout = { version: 6 as const, positions: { [id]: { x: 0, y: 0 } } };
    const manifest = {
      ...FARM_LAYOUT,
      bounds: { left: -1000, right: 1000, bottom: -1000, top: 1000, radius: 0 },
      buildings: [building],
      obstacles: [{ id: 'R0', polygon: diamond(x, y, 20, 10) }],
      decor: [],
    };
    assert.equal(groundError(layout, manifest), null, id + ' must not block ground under raised art');
    manifest.obstacles[0].polygon = diamond(0, 0, 20, 10);
    assert.match(groundError(layout, manifest)!, /ruộng/, id + ' must still block the actual foundation');
  }
});

test('every corrected ground vertex stays exactly inside the former saved-layout reservation', () => {
  for (const [id] of aboveGround) {
    const before = PREVIOUS_SINGLE_BUILDING_LAYOUT.buildings.find(b => b.id === id)!.footprints[0];
    const after = FARM_LAYOUT.buildings.find(b => b.id === id)!.footprints[0];
    // The serialized coordinates have three decimal places. Integer cross products
    // catch tiny outward rounding that could invalidate a save at a touching edge.
    const lattice = (p: { x: number; y: number }) => ({ x: Math.round(p.x * 1000), y: Math.round(p.y * 1000) });
    for (const point of after.map(lattice)) {
      for (let i = 0; i < before.length; i++) {
        const a = lattice(before[i]),
          b = lattice(before[(i + 1) % before.length]);
        const cross = (b.x - a.x) * (point.y - a.y) - (b.y - a.y) * (point.x - a.x);
        assert.ok(cross >= 0, `${id}: ground vertex ${JSON.stringify(point)} escaped former edge ${i}`);
      }
    }
  }
});
