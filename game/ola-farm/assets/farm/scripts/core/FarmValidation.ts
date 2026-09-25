import { legacyMachineTypes } from './legacy/LegacyMachineCatalog';
import { TRAY_CAPACITY } from './constants/ProductionDefaults';
import { PEN_CAPACITY_LIMIT } from './constants/HusbandryDefaults';
import { BUILDINGS_PER_TYPE } from './constants/BuildingLimits';
import type { FarmCatalog } from './types/CatalogTypes';
import type { FarmState } from './types/StateTypes';
import type { ItemAmount } from './types/ItemTypes';
import { isRecord } from './utils/TypeGuards';
import { cropItemKey, recipeKey, stockCatalog, machineSites, penPlotId, penDefinition } from './FarmCatalog';
import { assertBuildingLayout } from './BuildingPlacement';
import type { BuildingLayout } from './types/BuildingTypes';
import { assertPreviousFarmState } from './legacy/PreviousFarmValidation';

const nonnegative = (v: unknown): v is number => typeof v === 'number' && Number.isFinite(v) && v >= 0;
const integer = (v: unknown): v is number => typeof v === 'number' && Number.isSafeInteger(v) && v >= 0;
const finite = (v: unknown): v is number => typeof v === 'number' && Number.isFinite(v);
export function assertFarmState(
  value: unknown,
  catalog: FarmCatalog,
  simpleVersion: 5 | 6 | 7 = 7,
  layoutVersion: BuildingLayout['version'] = 6,
  beforeTown = false
): asserts value is FarmState {
  if (catalog.contentProfile === 'simple-1' && simpleVersion < 7) {
    assertPreviousFarmState(
      value,
      catalog,
      simpleVersion as 5 | 6,
      layoutVersion === 6 ? 5 : layoutVersion,
      beforeTown
    );
    return;
  }
  const simple = catalog.contentProfile === 'simple-1';
  if (
    !isRecord(value) ||
    value.version !== (simple ? simpleVersion : 3) ||
    value.mode !== 'free' ||
    typeof value.rulesVersion !== 'string' ||
    !value.rulesVersion
  )
    throw Error('Phiên bản bản lưu không được hỗ trợ.');
  if (
    'expansion' in value ||
    (simple && (value.contentProfile !== 'simple-1' || typeof value.guideDismissed !== 'boolean'))
  )
    throw Error('Bản lưu khác phạm vi nông trại.');
  const s = value,
    items = new Set(stockCatalog(catalog).map(i => i.key)),
    ids = new Set<number>();
  if (
    s.husbandry !== undefined &&
    (!isRecord(s.husbandry) ||
      s.husbandry.version !== 1 ||
      ['feedReceived', 'eggsCollected', 'milkCollected', 'burgerCollected'].some(
        k => typeof s.husbandry[k] !== 'boolean'
      ))
  )
    throw Error('Tiến độ chăn nuôi không hợp lệ.');
  if ('raw' in s || 'goods' in s) throw Error('Bản lưu mới phải dùng kho chung; không được có hai kho cũ song song.');
  const farm = (id: number) => catalog.farm.find(f => f.id === id),
    recipe = (id: number) => catalog.products.find(r => r.id === id);
  const types = catalog.machineTypes ?? legacyMachineTypes;
  for (const key of ['coins', 'xp', 'time', 'earned', 'harvested', 'sold'])
    if (!nonnegative(s[key])) throw Error('Ví/thống kê không hợp lệ.');
  if (!integer(s.diamonds) || !integer(s.nextId) || s.nextId < 1) throw Error('Bộ đếm không hợp lệ.');
  const unique = (id: unknown): void => {
    if (!integer(id) || id < 1 || id >= s.nextId || ids.has(id)) throw Error('ID giao dịch bị trùng/sai.');
    ids.add(id);
  };
  const amounts = (v: unknown): v is ItemAmount[] =>
    Array.isArray(v) &&
    v.length > 0 &&
    new Set(v.map(x => x?.key)).size === v.length &&
    v.every(x => isRecord(x) && items.has(x.key) && integer(x.quantity) && x.quantity > 0);
  for (const key of ['inventory', 'planted', 'produced', 'soldProducts'])
    if (!isRecord(s[key]) || Object.entries(s[key]).some(([k, n]) => !items.has(k) || !integer(n)))
      throw Error('Kho/thống kê vật phẩm không hợp lệ.');
  if (
    !isRecord(s.guide) ||
    ['plantedNew', 'harvestedNew', 'cookedTortilla', 'collectedTortilla', 'soldTortilla'].some(
      k => typeof s.guide[k] !== 'boolean'
    )
  )
    throw Error('Chỉ dẫn không hợp lệ.');
  const maxMachines = simple ? types.length * BUILDINGS_PER_TYPE : 33;
  const addedPens = new Set(simple ? catalog.residentPens?.filter(p => penPlotId(p) >= 50).map(penPlotId) : []);
  const plotCount = 50 + addedPens.size;
  if (
    !Array.isArray(s.plots) ||
    s.plots.length !== plotCount ||
    !Array.isArray(s.machines) ||
    s.machines.length > maxMachines
  )
    throw Error('Thiếu ô sản xuất hoặc quá nhiều máy.');
  let rescues = 0;
  for (const p of s.plots) {
    if (
      !isRecord(p) ||
      !integer(p.id) ||
      !['crop', 'pen', 'pond'].includes(p.group) ||
      !Number.isInteger(p.level) ||
      p.level < 1 ||
      p.level > 4 ||
      typeof p.unlocked !== 'boolean' ||
      typeof p.boosted !== 'boolean' ||
      !finite(p.started) ||
      !finite(p.ready) ||
      (p.group === 'crop' && !p.unlocked && !(simple && catalog.economy?.fields[p.id]))
    )
      throw Error('Ô sản xuất không hợp lệ.');
    if (simple) {
      const pen = penDefinition(catalog, { id: p.id });
      if (p.group !== 'crop') {
        const emptySite = pen?.purchasePrice !== undefined && !p.unlocked && p.residents === null && p.crop === null;
        const builtPen = pen && p.unlocked && p.residents?.species === pen.species;
        if (pen ? !emptySite && !builtPen : p.unlocked || p.residents !== null || p.crop !== null)
          throw Error('Vị trí hoặc loài nằm ngoài phạm vi nông trại.');
      }
    }
    if (p.crop !== null) {
      const f = farm(p.crop),
        snap = p.snapshot;
      if (
        !f ||
        f.group !== p.group ||
        !p.unlocked ||
        p.started > s.time ||
        p.ready < p.started ||
        !isRecord(snap) ||
        !amounts([snap.output]) ||
        snap.output.key !== cropItemKey(f) ||
        !nonnegative(snap.harvestXP) ||
        !nonnegative(snap.paidCoins) ||
        !nonnegative(snap.refundCoins) ||
        snap.refundCoins > snap.paidCoins ||
        !nonnegative(snap.duration) ||
        snap.duration === 0 ||
        typeof snap.rescue !== 'boolean'
      )
        throw Error('Lứa sản xuất không hợp lệ.');
      if (snap.rescue) {
        rescues++;
        if (p.crop !== 1 || snap.paidCoins !== 0 || snap.refundCoins !== 0) throw Error('Lứa hỗ trợ không hợp lệ.');
      }
    } else if (p.snapshot !== null || p.boosted) throw Error('Ô trống còn dữ liệu lứa.');
    if (p.residents !== null) {
      const pen = p.residents,
        type = (catalog.livestock ?? []).find(a => a.key === pen?.species);
      if (
        p.group !== 'pen' ||
        !p.unlocked ||
        p.crop !== null ||
        !isRecord(pen) ||
        !type ||
        !integer(pen.capacity) ||
        pen.capacity < 1 ||
        pen.capacity > PEN_CAPACITY_LIMIT ||
        !Array.isArray(pen.animals) ||
        pen.animals.length > pen.capacity
      )
        throw Error('Chuồng thường trú không hợp lệ.');
      const slots = new Set<number>();
      for (const a of pen.animals) {
        if (!isRecord(a) || !integer(a.slot) || a.slot >= pen.capacity || slots.has(a.slot))
          throw Error('Vị trí con vật trong chuồng không hợp lệ.');
        slots.add(a.slot);
        unique(a.id);
        if (
          a.job !== null &&
          (!isRecord(a.job) ||
            !finite(a.job.started) ||
            a.job.started > s.time ||
            !finite(a.job.ready) ||
            a.job.ready < a.job.started ||
            !amounts([a.job.output]) ||
            a.job.output.key !== type.output ||
            !nonnegative(a.job.xp))
        )
          throw Error('Lượt cho ăn không hợp lệ.');
      }
    }
  }
  if (rescues > 1) throw Error('Có nhiều lứa hỗ trợ cùng lúc.');
  const mapped = s.plots.filter((p: any) => p.cell !== null);
  if (
    mapped.length !== 22 ||
    new Set(mapped.map((p: any) => p.cell)).size !== 22 ||
    mapped.some(
      (p: any) => !integer(p.cell) || p.cell > 21 || p.group !== (p.cell < 12 ? 'crop' : p.cell < 18 ? 'pen' : 'pond')
    ) ||
    s.plots.some((p: any) => p.cell === null && p.group !== (addedPens.has(p.id) ? 'pen' : 'crop')) ||
    new Set(s.plots.map((p: any) => p.id)).size !== plotCount ||
    s.plots.some((p: any) => p.id >= 50 && !addedPens.has(p.id))
  )
    throw Error('ID/vị trí ô bị trùng hoặc sai.');
  if (
    simple &&
    (types.some(t => s.machines.filter((m: any) => m.type === t.id).length > BUILDINGS_PER_TYPE) ||
      (catalog.livestock ?? []).some(
        t => s.plots.filter((p: any) => p.residents?.species === t.key).length > BUILDINGS_PER_TYPE
      ))
  )
    throw Error('Too many buildings of one type.');
  const buildings = new Set<string>();
  if (s.machines.filter((m: any) => m.type < 5).length > 30) throw Error('Vượt số máy kế thừa.');
  if (s.machines.filter((m: any) => m.type === 5).length > 3) throw Error('Vượt ba vị trí máy thức ăn.');
  for (const m of s.machines) {
    if (
      !isRecord(m) ||
      !integer(m.id) ||
      !types.some(t => t.id === m.type) ||
      !integer(m.capacity) ||
      m.capacity < 1 ||
      m.capacity > 5 ||
      !Array.isArray(m.waiting) ||
      !Array.isArray(m.tray) ||
      m.waiting.length + (m.job ? 1 : 0) > m.capacity ||
      m.tray.length > TRAY_CAPACITY
    )
      throw Error('Máy/hàng đợi không hợp lệ.');
    if ((simple || m.type >= 5) && m.buildingId === null) throw Error('Máy đã mua thiếu vị trí.');
    if (m.buildingId !== null) {
      const allowed = machineSites(types.find(t => t.id === m.type)!);
      if (!allowed.includes(m.buildingId) || buildings.has(m.buildingId))
        throw Error('Vị trí công trình không hợp lệ.');
      buildings.add(m.buildingId);
    }
    const checkJob = (j: any, running: boolean): void => {
      const r = recipe(j?.product);
      if (
        !isRecord(j) ||
        !r ||
        r.machine !== m.type ||
        j.recipeKey !== recipeKey(r) ||
        !amounts(j.inputs) ||
        !amounts(j.outputs) ||
        !nonnegative(j.duration) ||
        j.duration === 0 ||
        !nonnegative(j.xp) ||
        !finite(j.started) ||
        !finite(j.ready) ||
        j.ready < j.started ||
        (running && j.started > s.time)
      )
        throw Error('Công việc máy không hợp lệ.');
      unique(j.id);
    };
    if (m.job !== null) checkJob(m.job, true);
    m.waiting.forEach((j: any) => checkJob(j, false));
    for (const b of m.tray) {
      if (!isRecord(b) || recipe(b.product)?.machine !== m.type || !amounts(b.outputs) || !nonnegative(b.xp))
        throw Error('Khay nhận không hợp lệ.');
      unique(b.id);
    }
  }
  if (simple && catalog.initialMachines!.some(type => !s.machines.some((m: any) => m.type === type)))
    throw Error('Bản lưu thiếu máy khởi đầu.');
  if (new Set(s.machines.map((m: any) => m.id)).size !== s.machines.length) throw Error('ID máy bị trùng.');
  if (simple && simpleVersion === 7) {
    if (layoutVersion !== 6) throw Error('Unsupported current layout.');
    assertBuildingLayout(s.buildingLayout, s as FarmState);
  }
  if (simple && simpleVersion === 5 && 'buildingLayout' in s) throw Error('Bản lưu v5 không được chứa bố cục v6.');
}
