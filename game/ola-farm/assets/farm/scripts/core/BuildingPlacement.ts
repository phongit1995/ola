import type { BuildingLayout, BuildingPosition, FarmLayoutManifest } from './types/BuildingTypes';
import { insideClearing, overlaps, tooClose, translated } from './BuildingGeometry';
import { FARM_LAYOUT } from './FarmLayoutData';
import { PREVIOUS_SINGLE_BUILDING_LAYOUT } from './legacy/PreviousSingleBuildingLayout';
import { PREVIOUS_FARM_LAYOUT } from './legacy/PreviousFarmLayout';
import { PREVIOUS_PEN_LAYOUT } from './legacy/PreviousPenLayout';
import { PREVIOUS_LARGE_PEN_LAYOUT } from './legacy/PreviousLargePenLayout';
import { PREVIOUS_FOUR_FIELD_LAYOUT } from './legacy/PreviousFourFieldLayout';
import { roadFootprints } from './FarmRoadLayout';
import type { FarmState } from './types/StateTypes';
import { isRecord } from './utils/TypeGuards';
import { TOWN_SITES, EMPTY_LAYOUT, FIELD_CLEARANCE, ROAD_CLEARANCE } from './constants/PlacementDefaults';
import { t } from './i18n/I18n';
import { contentName } from './i18n/LocalizeContent';

export { FARM_LAYOUT } from './FarmLayoutData';

const beforeTownManifest = (): FarmLayoutManifest => ({
  ...PREVIOUS_PEN_LAYOUT,
  buildings: PREVIOUS_PEN_LAYOUT.buildings.filter(b => !TOWN_SITES.has(b.id)),
});
export function buildingPosition(id: string, layout: BuildingLayout = EMPTY_LAYOUT): BuildingPosition {
  const b = FARM_LAYOUT.buildings.find(b => b.id === id);
  if (!b) throw Error('Công trình không hợp lệ.');
  return layout.positions[id] ?? b.position;
}
export function snapPosition(p: BuildingPosition): BuildingPosition {
  const { x, y } = FARM_LAYOUT.snap,
    u = Math.round((p.x / x + p.y / y) / 2),
    v = Math.round((p.y / y - p.x / x) / 2);
  return { x: (u - v) * x, y: (u + v) * y };
}
export function canMoveBuilding(state: FarmState, id: string): boolean {
  const b = FARM_LAYOUT.buildings.find(b => b.id === id);
  if (state.contentProfile !== 'simple-1' || !b) return false;
  if (b.kind === 'machine') return state.machines.some(machine => machine.buildingId === id);
  if (b.kind === 'pen') return state.plots.some(plot => 'pen:' + plot.id === id && plot.unlocked && !!plot.residents);
  return true;
}
export function layoutKey(layout: BuildingLayout): string {
  return JSON.stringify(
    FARM_LAYOUT.buildings.map(b => [
      b.id,
      layout.positions[b.id]?.x ?? b.position.x,
      layout.positions[b.id]?.y ?? b.position.y,
    ])
  );
}
/** Validate every untrusted field before it can form a cache key. */
export function assertLayoutShape(
  value: unknown,
  version: BuildingLayout['version'] = 6
): asserts value is BuildingLayout {
  if (
    !isRecord(value) ||
    value.version !== version ||
    !isRecord(value.positions) ||
    Object.keys(value).some(k => !['version', 'positions'].includes(k))
  )
    throw Error('Bố cục công trình không hợp lệ.');
  for (const [id, p] of Object.entries(value.positions)) {
    if (
      !(version < 6 ? PREVIOUS_SINGLE_BUILDING_LAYOUT : FARM_LAYOUT).buildings.some(b => b.id === id) ||
      !isRecord(p) ||
      Object.keys(p).length !== 2 ||
      !Number.isFinite(p.x) ||
      !Number.isFinite(p.y) ||
      Math.abs(p.x) > 10000 ||
      Math.abs(p.y) > 10000
    )
      throw Error('ID hoặc tọa độ công trình không hợp lệ.');
  }
}
export function groundError(
  layout: BuildingLayout,
  manifest: FarmLayoutManifest = FARM_LAYOUT,
  only?: string
): string | null {
  const groups = manifest.buildings.map(b => ({
    b,
    polygons: b.footprints.map(f => translated(f, layout.positions[b.id] ?? b.position)),
  }));
  for (let i = 0; i < groups.length; i++) {
    const { b, polygons } = groups[i];
    if (only && b.id !== only) continue;
    if (polygons.some(poly => !poly.every(p => insideClearing(p, manifest.bounds))))
      return t('place.outsideClearing', { name: contentName(b.name) });
    const obstacle = manifest.obstacles.find(o =>
      polygons.some(p => tooClose(p, o.polygon, manifest.roadPlan && /^R\d/.test(o.id) ? FIELD_CLEARANCE : 0))
    );
    if (obstacle)
      return t(/^R\d/.test(obstacle.id) ? 'place.tooCloseToField' : 'place.blockedByDecor', {
        name: contentName(b.name),
      });
    if (
      manifest.roadPlan &&
      roadFootprints(manifest).some(road => polygons.some(p => tooClose(p, road, ROAD_CLEARANCE)))
    )
      return t('place.onRoad', { name: contentName(b.name) });
    for (let j = 0; j < groups.length; j++)
      if (j !== i && polygons.some(p => groups[j].polygons.some(q => overlaps(p, q))))
        return t('place.overlaps', { name: contentName(b.name), other: contentName(groups[j].b.name) });
  }
  return null;
}
const cache = new Map<string, { error: string | null }>();
/** With live state, only constructed buildings occupy ground; source/migration checks retain all sites. */
export function checkLayout(layout: BuildingLayout, state?: FarmState): { error: string | null } {
  assertLayoutShape(layout);
  const manifest = state
    ? { ...FARM_LAYOUT, buildings: FARM_LAYOUT.buildings.filter(b => canMoveBuilding(state, b.id)) }
    : FARM_LAYOUT;
  const key = layoutKey(layout) + ':' + manifest.buildings.map(b => b.id).join(','),
    cached = cache.get(key);
  if (cached) return cached;
  const result = { error: groundError(layout, manifest) };
  if (cache.size >= 64) cache.delete(cache.keys().next().value!);
  cache.set(key, result);
  return result;
}
export function assertBuildingLayout(value: unknown, state: FarmState): void {
  assertLayoutShape(value);
  // Future-site coordinates remain purchase preferences in old saves, with no invisible obstacle.
  // Buying checks that position again against the current buildings and finds another if occupied.
  if (state.contentProfile !== 'simple-1') throw Error('Công trình không có trong nông trại này.');
  const result = checkLayout(value, state);
  if (result.error) throw Error(result.error);
}
/** Validate layout v5 against the exact sites and footprints that were shipped. */
export function assertSingleBuildingLayout(value: unknown, state: FarmState): void {
  assertLayoutShape(value, 5);
  if (Object.keys(value.positions).some(id => !PREVIOUS_SINGLE_BUILDING_LAYOUT.buildings.some(b => b.id === id)))
    throw Error('Unknown historical building.');
  const manifest = {
    ...PREVIOUS_SINGLE_BUILDING_LAYOUT,
    buildings: PREVIOUS_SINGLE_BUILDING_LAYOUT.buildings.filter(b => canMoveBuilding(state, b.id)),
  };
  const error = groundError(value, manifest);
  if (error) throw Error(error);
}

export function assertPreviousBuildingLayout(value: unknown): asserts value is BuildingLayout {
  assertLayoutShape(value, 1);
  if (Object.keys(value.positions).some(id => !PREVIOUS_FARM_LAYOUT.buildings.some(b => b.id === id)))
    throw Error('Bản lưu bố cục v1 không có vị trí này.');
  const error = groundError(value, PREVIOUS_FARM_LAYOUT);
  if (error) throw Error(error);
}

/** The new sites must never invalidate an otherwise valid layout saved by the two-species game. */
export function assertBeforeTownBuildingLayout(value: unknown): asserts value is BuildingLayout {
  assertLayoutShape(value, 2);
  if (Object.keys(value.positions).some(id => TOWN_SITES.has(id)))
    throw Error('Bản lưu cũ không có vị trí chuồng mới.');
  const error = groundError(value, beforeTownManifest());
  if (error) throw Error(error);
}

/** Validate v2 against its frozen geometry, before enlarged yards can change its meaning. */
export function assertSmallPenBuildingLayout(value: unknown, beforeTown = false): asserts value is BuildingLayout {
  if (beforeTown) {
    assertBeforeTownBuildingLayout(value);
    return;
  }
  assertLayoutShape(value, 2);
  const error = groundError(value, PREVIOUS_PEN_LAYOUT);
  if (error) throw Error(error);
}

/** Layout v3 shipped with 2.2-scale yards; their saved positions use that exact frozen footprint. */
export function assertLargePenBuildingLayout(value: unknown): asserts value is BuildingLayout {
  assertLayoutShape(value, 3);
  const error = groundError(value, PREVIOUS_LARGE_PEN_LAYOUT);
  if (error) throw Error(error);
}

/** Layout v4 already has four-field yards, but still uses the original small machine footprints. */
export function assertFourFieldBuildingLayout(value: unknown): asserts value is BuildingLayout {
  assertLayoutShape(value, 4);
  const error = groundError(value, PREVIOUS_FOUR_FIELD_LAYOUT);
  if (error) throw Error(error);
}

function placementChoices(manifest: FarmLayoutManifest): BuildingPosition[] {
  const choices: BuildingPosition[] = [];
  for (let u = -80; u <= 80; u++)
    for (let v = -80; v <= 80; v++) {
      const p = { x: (u - v) * manifest.snap.x, y: (u + v) * manifest.snap.y };
      if (insideClearing(p, manifest.bounds)) choices.push(p);
    }
  return choices;
}
function place(layout: BuildingLayout, id: string, p: BuildingPosition, manifest: FarmLayoutManifest): BuildingLayout {
  const positions = { ...layout.positions, [id]: { x: p.x, y: p.y } },
    original = manifest.buildings.find(b => b.id === id)!.position;
  if (p.x === original.x && p.y === original.y) delete positions[id];
  return { version: layout.version, positions };
}

/** Compute the complete purchase layout before charging coins or adding ownership. */
export function purchaseBuildingLayout(state: FarmState, id: string): BuildingLayout | null {
  const building = FARM_LAYOUT.buildings.find(b => b.id === id);
  if (!building || state.contentProfile !== 'simple-1' || canMoveBuilding(state, id)) return null;
  const layout = state.buildingLayout ?? EMPTY_LAYOUT,
    from = buildingPosition(id, layout);
  const manifest = {
    ...FARM_LAYOUT,
    buildings: FARM_LAYOUT.buildings.filter(b => b.id === id || canMoveBuilding(state, b.id)),
  };
  // Preserve an exact saved/default position, including one that predates grid snapping.
  if (!groundError(layout, manifest, id)) return layout;
  const choices = [...placementChoices(FARM_LAYOUT), building.position].sort(
    (a, b) => Math.hypot(a.x - from.x, a.y - from.y) - Math.hypot(b.x - from.x, b.y - from.y) || b.y - a.y || a.x - b.x
  );
  const destination = choices.find(p => !groundError(place(layout, id, p, FARM_LAYOUT), manifest, id));
  return destination ? place(layout, id, destination, FARM_LAYOUT) : null;
}

/** Keep valid custom sites; reserve enlarged footprints before repairing only newly blocked sites. */
export function migrateEnlargedPenLayout(value: BuildingLayout, beforeTown = false): BuildingLayout {
  if (value.version === 4) {
    assertFourFieldBuildingLayout(value);
    beforeTown = false;
  } else if (value.version === 3) {
    assertLargePenBuildingLayout(value);
    beforeTown = false;
  } else assertSmallPenBuildingLayout(value, beforeTown);
  const previous =
    value.version === 4
      ? PREVIOUS_FOUR_FIELD_LAYOUT
      : value.version === 3
        ? PREVIOUS_LARGE_PEN_LAYOUT
        : beforeTown
          ? beforeTownManifest()
          : PREVIOUS_PEN_LAYOUT;
  let layout: BuildingLayout = { version: 5, positions: { ...value.positions } };
  const customized = (id: string): boolean => Object.prototype.hasOwnProperty.call(value.positions, id);
  const placed: typeof PREVIOUS_SINGLE_BUILDING_LAYOUT.buildings = [],
    pending: typeof PREVIOUS_SINGLE_BUILDING_LAYOUT.buildings = [];
  const changed = (b: (typeof placed)[number]): boolean =>
    JSON.stringify(previous.buildings.find(old => old.id === b.id)?.footprints) !== JSON.stringify(b.footprints);
  // An unchanged saved site wins over a grown site; all customs win over authored defaults.
  // Every reservation is checked against earlier reservations, including grown custom machines.
  const priority = (b: (typeof placed)[number]): number => (customized(b.id) ? 0 : 2) + Number(changed(b));
  const ordered = [...PREVIOUS_SINGLE_BUILDING_LAYOUT.buildings].sort((a, b) => priority(a) - priority(b));
  for (const b of ordered) {
    const manifest = { ...PREVIOUS_SINGLE_BUILDING_LAYOUT, buildings: [...placed, b] };
    if (groundError(layout, manifest, b.id)) pending.push(b);
    else placed.push(b);
  }
  const choices = pending.length ? placementChoices(PREVIOUS_SINGLE_BUILDING_LAYOUT) : [];
  for (const b of pending) {
    const from = value.positions[b.id] ?? b.position,
      manifest = { ...PREVIOUS_SINGLE_BUILDING_LAYOUT, buildings: [...placed, b] };
    const ranked = [...choices, from, b.position].sort(
      (a, c) =>
        Math.hypot(a.x - from.x, a.y - from.y) - Math.hypot(c.x - from.x, c.y - from.y) || c.y - a.y || a.x - c.x
    );
    const destination = ranked.find(
      p => !groundError(place(layout, b.id, p, PREVIOUS_SINGLE_BUILDING_LAYOUT), manifest, b.id)
    );
    if (!destination) throw Error('Không tìm được chỗ trống cho ' + b.name + '.');
    layout = place(layout, b.id, destination, PREVIOUS_SINGLE_BUILDING_LAYOUT);
    placed.push(b);
  }
  const error = groundError(layout, PREVIOUS_SINGLE_BUILDING_LAYOUT);
  if (error) throw Error(error);
  return layout;
}

/** Repair only placements invalidated by fixed roads/field spacing; keep all farm assets untouched. */
export function migrateBuildingLayout(value: BuildingLayout, includeTownSites = true): BuildingLayout {
  assertPreviousBuildingLayout(value);
  const manifest = includeTownSites ? PREVIOUS_PEN_LAYOUT : beforeTownManifest();
  let layout: BuildingLayout = { version: 2, positions: {} };
  // Missing keys were never customized: use the newly authored village layout for those sites.
  for (const [id, p] of Object.entries(value.positions)) layout = place(layout, id, p, manifest);
  const choices = placementChoices(manifest);
  for (const b of manifest.buildings) {
    if (!groundError(layout, manifest, b.id)) continue;
    const from = layout.positions[b.id] ?? b.position;
    const ranked = [...choices, b.position].sort(
      (a, c) =>
        Math.hypot(a.x - from.x, a.y - from.y) - Math.hypot(c.x - from.x, c.y - from.y) || c.y - a.y || a.x - c.x
    );
    const destination = ranked.find(p => !groundError(place(layout, b.id, p, manifest), manifest, b.id));
    if (!destination) throw Error('Không tìm được chỗ trống cho ' + b.name + '.');
    layout = place(layout, b.id, destination, manifest);
  }
  const error = groundError(layout, manifest);
  if (error) throw Error(error);
  return migrateEnlargedPenLayout(layout, !includeTownSites);
}
export function movedLayout(layout: BuildingLayout, id: string, p: BuildingPosition): BuildingLayout {
  return place({ ...layout, version: 6 }, id, p, FARM_LAYOUT);
}
