import type { FarmCatalog } from './types/CatalogTypes';
import type { FarmState } from './types/StateTypes';
import type { CropSnapshot } from './types/PlotTypes';
import type { Machine, ProductionJob } from './types/ProductionTypes';
import { isRecord } from './utils/TypeGuards';
import { legacyCatalog } from './legacy/LegacyCatalog';
import { assertPreviousFarmState } from './legacy/PreviousFarmValidation';
import { cropItemKey, recipeInputs, recipeKey, recipeOutputs } from './FarmCatalog';
import { assertFarmState } from './FarmValidation';
import { migrateBuildingLayout, migrateEnlargedPenLayout } from './BuildingPlacement';
import { additionalPenPlots, freshLegacyFarm, freshSimpleFarm } from './FreshFarm';

const clone = <T>(v: T): T => JSON.parse(JSON.stringify(v));

/**
 * Turns whatever was stored (or nothing) into the current state shape. Each historical version is validated
 * against the exact rules it shipped with before its layout is translated, so a corrupt old save is rejected
 * instead of being silently repaired.
 */
export function loadFarmState(catalog: FarmCatalog, saved: unknown = null): FarmState {
  const simple = catalog.contentProfile === 'simple-1';
  const source = saved === null ? (simple ? freshSimpleFarm(catalog) : freshLegacyFarm()) : migrateResidentSlots(saved);
  if (!simple) return loadFullFarm(source, catalog);
  const state = upgradeSimpleFarm(source, catalog);
  if (state.version === 6) {
    state.version = 7;
    state.buildingLayout = { version: 6, positions: { ...state.buildingLayout!.positions } };
    state.plots.push(...additionalPenPlots(catalog));
  }
  if (!state.husbandry) migrateHusbandryProgress(state);
  return state;
}

function loadFullFarm(source: unknown, catalog: FarmCatalog): FarmState {
  if (isRecord(source) && source.version === 2) return migrateLegacy(source, catalog.rulesVersion ?? 'farm40-1');
  assertFarmState(source, catalog);
  return clone(source);
}

/** Simple-profile saves: v5 (no layout), then v6 with layout v1 to v5, each frozen when it shipped. */
function upgradeSimpleFarm(source: unknown, catalog: FarmCatalog): FarmState {
  if (isRecord(source) && source.version === 5) {
    assertPreviousFarmState(source, catalog, 5);
    return { ...clone(source), version: 6, buildingLayout: { version: 5, positions: {} } };
  }
  if (isRecord(source) && source.version === 6) {
    const layout = source.buildingLayout?.version;
    switch (layout) {
      case 1:
        assertPreviousFarmState(source, catalog, 6, 1);
        return { ...clone(source), buildingLayout: migrateBuildingLayout(source.buildingLayout!, !!source.husbandry) };
      case 2: {
        const beforeTown = !source.husbandry;
        assertPreviousFarmState(source, catalog, 6, 2, beforeTown);
        return { ...clone(source), buildingLayout: migrateEnlargedPenLayout(source.buildingLayout!, beforeTown) };
      }
      case 3:
      case 4:
        assertPreviousFarmState(source, catalog, 6, layout);
        return { ...clone(source), buildingLayout: migrateEnlargedPenLayout(source.buildingLayout!) };
      default:
        assertPreviousFarmState(source, catalog);
        return clone(source);
    }
  }
  assertFarmState(source, catalog);
  return clone(source);
}

/** Older saves did not count each animal output. Established feed makers receive equivalent pen access. */
export function migrateHusbandryProgress(s: FarmState): void {
  const received = (key: string) => (s.produced[key] ?? 0) > 0 || (s.inventory[key] ?? 0) > 0;
  const feedReceived = received('farm40:chicken-feed') || received('farm40:cow-feed');
  const established = feedReceived && s.harvested > 0;
  s.husbandry = {
    version: 1,
    feedReceived,
    eggsCollected: established || received('farm40:egg'),
    milkCollected: established || received('raw:7'),
    burgerCollected: received('town:burger'),
  };
}

/** Old pens had at most three residents and stored their displayed order only in the array. */
export function needsResidentSlots(value: unknown): boolean {
  if (!isRecord(value) || !Array.isArray(value.plots)) return false;
  const pens = value.plots.filter(p => isRecord(p) && isRecord(p.residents)).map(p => p.residents);
  if (!pens.every(p => Number.isInteger(p.capacity) && p.capacity >= 1 && p.capacity <= 3 && Array.isArray(p.animals)))
    return false;
  const animals = pens.flatMap(p => p.animals);
  return animals.length > 0 && animals.every(a => isRecord(a) && !('slot' in a));
}
/** Copy only the additive slot field. Mixed or invalid slot data stays untouched for validation to reject. */
export function migrateResidentSlots(value: unknown): unknown {
  if (!needsResidentSlots(value) || !isRecord(value)) return value;
  return {
    ...value,
    plots: value.plots.map((p: any) =>
      isRecord(p) && isRecord(p.residents)
        ? {
            ...p,
            residents: { ...p.residents, animals: p.residents.animals.map((a: any, slot: number) => ({ ...a, slot })) },
          }
        : p
    ),
  };
}

export function cropSnapshot(catalog: FarmCatalog, id: number, level: number, rescue = false): CropSnapshot {
  const f = catalog.farm.find(f => f.id === id);
  if (!f || !Number.isInteger(level) || level < 1 || level > f.yields.length) throw Error('Giống/cấp ô không hợp lệ.');
  return {
    output: { key: cropItemKey(f), quantity: f.yields[level - 1] },
    harvestXP: rescue ? 0 : (f.harvestXP ?? 3 * f.yields[level - 1]),
    paidCoins: rescue ? 0 : f.price,
    refundCoins: rescue ? 0 : Math.floor(f.price * (catalog.economy?.refunds.cropCancelRate ?? 0.3)),
    duration: f.duration,
    rescue,
  };
}
export function productionSnapshot(catalog: FarmCatalog, id: number, sequence: number, started: number): ProductionJob {
  const r = catalog.products.find(r => r.id === id);
  if (!r) throw Error('Công thức không hợp lệ.');
  return {
    id: sequence,
    product: id,
    recipeKey: recipeKey(r),
    started,
    ready: started + r.duration,
    duration: r.duration,
    inputs: recipeInputs(r),
    outputs: recipeOutputs(r).map(x => ({ ...x })),
    xp: r.xp ?? 10,
  };
}
const finite = (v: unknown): v is number => typeof v === 'number' && Number.isFinite(v);
const count = (v: unknown): v is number => typeof v === 'number' && Number.isSafeInteger(v) && v >= 0;
/** Validate the original schema before translating; never silently discard malformed assets. */
export function migrateLegacy(value: unknown, rulesVersion: string): FarmState {
  if (!isRecord(value) || value.version !== 2 || value.mode !== 'free')
    throw Error('Không nhận phiên bản bản lưu này.');
  const s = value,
    farm = (id: number) => legacyCatalog.farm.find(f => f.id === id),
    product = (id: number) => legacyCatalog.products.find(r => r.id === id);
  if (!finite(s.coins) || s.coins < 0 || !count(s.diamonds) || !finite(s.time) || s.time < 0)
    throw Error('Ví hoặc thời gian không hợp lệ.');
  for (const key of ['xp', 'earned', 'harvested', 'sold'])
    if (!finite(s[key]) || s[key] < 0) throw Error('Tiến độ không hợp lệ.');
  for (const key of ['raw', 'goods', 'planted', 'produced', 'soldProducts']) {
    if (
      !isRecord(s[key]) ||
      Object.entries(s[key]).some(
        ([id, n]) =>
          !/^[1-9]\d*$/.test(id) || !count(n) || !(key === 'raw' || key === 'planted' ? farm(+id) : product(+id))
      )
    )
      throw Error('Kho cũ không hợp lệ.');
  }
  if (!Array.isArray(s.plots) || s.plots.length !== 50 || !Array.isArray(s.machines) || s.machines.length > 30)
    throw Error('Thiếu vị trí hoặc máy trong bản lưu cũ.');
  for (const p of s.plots) {
    if (
      !isRecord(p) ||
      !count(p.id) ||
      !['crop', 'pen', 'pond'].includes(p.group) ||
      !Number.isInteger(p.level) ||
      p.level < 1 ||
      p.level > 4 ||
      typeof p.unlocked !== 'boolean' ||
      typeof p.boosted !== 'boolean' ||
      !finite(p.started) ||
      !finite(p.ready) ||
      (p.crop !== null &&
        (!Number.isInteger(p.crop) ||
          farm(p.crop)?.group !== p.group ||
          !p.unlocked ||
          p.started > s.time ||
          p.ready < p.started)) ||
      (p.group === 'crop' && !p.unlocked)
    )
      throw Error('Ô cũ không hợp lệ.');
  }
  const mapped = s.plots.filter((p: any) => p.cell !== null);
  if (
    mapped.length !== 22 ||
    new Set(mapped.map((p: any) => p.cell)).size !== 22 ||
    mapped.some(
      (p: any) =>
        !Number.isInteger(p.cell) ||
        p.cell < 0 ||
        p.cell > 21 ||
        p.group !== (p.cell < 12 ? 'crop' : p.cell < 18 ? 'pen' : 'pond')
    ) ||
    s.plots.some((p: any) => p.cell === null && p.group !== 'crop') ||
    new Set(s.plots.map((p: any) => p.id)).size !== 50
  )
    throw Error('Vị trí cũ bị trùng hoặc sai.');
  for (const m of s.machines) {
    if (
      !isRecord(m) ||
      !count(m.id) ||
      !Number.isInteger(m.type) ||
      m.type < 1 ||
      m.type > 4 ||
      (m.job !== null &&
        (!isRecord(m.job) ||
          product(m.job.product)?.machine !== m.type ||
          !finite(m.job.started) ||
          !finite(m.job.ready) ||
          m.job.started > s.time ||
          m.job.ready < m.job.started))
    )
      throw Error('Máy cũ không hợp lệ.');
  }
  if (new Set(s.machines.map((m: any) => m.id)).size !== s.machines.length) throw Error('ID máy cũ bị trùng.');
  const namespace = (record: Record<string, number>, kind: string): Record<string, number> =>
    Object.fromEntries(Object.entries(record).map(([id, n]) => [`${kind}:${id}`, n]));
  let nextId = 1;
  const machines: Machine[] = s.machines.map((m: any) => {
    const job = m.job
      ? { ...productionSnapshot(legacyCatalog, m.job.product, nextId++, m.job.started), ready: m.job.ready }
      : null;
    return { id: m.id, type: m.type, job, capacity: 1, waiting: [], tray: [], buildingId: null };
  });
  // Stable one-to-one mapping; additional legacy instances remain in the machine selector.
  for (const [type, anchor] of [
    [1, 'bakery-1'],
    [4, 'dairy-1'],
  ] as const) {
    const m = machines.filter(m => m.type === type).sort((a, b) => a.id - b.id)[0];
    if (m) m.buildingId = anchor;
  }
  return {
    version: 3,
    rulesVersion,
    mode: 'free',
    coins: s.coins,
    diamonds: s.diamonds,
    xp: s.xp,
    time: s.time,
    earned: s.earned,
    harvested: s.harvested,
    sold: s.sold,
    planted: namespace(s.planted, 'raw'),
    produced: namespace(s.produced, 'goods'),
    soldProducts: namespace(s.soldProducts, 'goods'),
    inventory: { ...namespace(s.raw, 'raw'), ...namespace(s.goods, 'goods') },
    nextId,
    machines,
    plots: s.plots.map((p: any) => ({
      id: p.id,
      cell: p.cell,
      group: p.group,
      unlocked: p.unlocked,
      level: p.level,
      crop: p.crop,
      started: p.started,
      ready: p.ready,
      boosted: p.boosted,
      snapshot: p.crop === null ? null : cropSnapshot(legacyCatalog, p.crop, p.level),
      residents: null,
    })),
    guide: {
      plantedNew: false,
      harvestedNew: false,
      cookedTortilla: false,
      collectedTortilla: false,
      soldTortilla: false,
    },
  };
}
