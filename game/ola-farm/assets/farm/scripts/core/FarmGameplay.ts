import { BUILDINGS_PER_TYPE } from './constants/BuildingLimits';
import { PEN_CAPACITY_LIMIT } from './constants/HusbandryDefaults';
import { TRAY_CAPACITY } from './constants/ProductionDefaults';
import type { FarmCatalog } from './types/CatalogTypes';
import { ConfigReader } from './ConfigReader';
import type { FarmGameplayConfig } from './types/GameplayTypes';

/** Tune supported content without changing persisted IDs, geometry, or paid job snapshots. */
export function withFarmGameplay(source: FarmCatalog, input: unknown): FarmCatalog {
  const v = new ConfigReader('gameplay.json');
  if ('gameplay' in source) v.fail('config', 'cấu hình gameplay bị trùng.');
  const c = v.object(input, 'config', [
    'version',
    'startingInventory',
    'showWelcome',
    'rescueEnabled',
    'growthStageFraction',
    'requireFeedMill',
    'animals',
    'machines',
    'gates',
  ]);
  if (c.version !== 1) v.fail('version', 'chỉ hỗ trợ phiên bản 1.');
  for (const key of ['showWelcome', 'rescueEnabled', 'requireFeedMill']) v.bool(c[key], key);
  v.number(c.growthStageFraction, 'growthStageFraction', 0.01, 0.99);
  const items = new Set(source.items!.map(i => i.key));
  const inventory = v.object(c.startingInventory, 'startingInventory');
  for (const [key, quantity] of Object.entries(inventory)) {
    if (!items.has(key)) v.fail(`startingInventory.${key}`, 'vật phẩm không có trong catalog.');
    v.number(quantity, `startingInventory.${key}`, 0, Number.MAX_SAFE_INTEGER, true);
  }
  const animals = v.object(
    c.animals,
    'animals',
    source.livestock!.map(a => a.key)
  );
  for (const [key, value] of Object.entries(animals)) {
    const path = `animals.${key}`,
      a = v.object(value, path, [
        'name',
        'maxPens',
        'maxCapacity',
        'startingCapacity',
        'startingAnimals',
        'feedPerAnimal',
      ]);
    v.text(a.name, path + '.name');
    v.number(a.maxPens, path + '.maxPens', 1, BUILDINGS_PER_TYPE, true);
    v.number(a.maxCapacity, path + '.maxCapacity', 1, PEN_CAPACITY_LIMIT, true);
    v.number(a.startingCapacity, path + '.startingCapacity', 1, a.maxCapacity, true);
    v.number(a.startingAnimals, path + '.startingAnimals', 0, a.startingCapacity, true);
    v.number(
      a.feedPerAnimal,
      path + '.feedPerAnimal',
      1,
      Math.floor(Number.MAX_SAFE_INTEGER / PEN_CAPACITY_LIMIT),
      true
    );
    const sites = source.residentPens!.filter(p => p.species === key);
    const animalPrice = source.livestock!.find(t => t.key === key)!.price;
    for (const site of sites)
      v.number(
        (site.purchasePrice ?? 0) + a.startingAnimals * animalPrice,
        path + ': giá xây chuồng kèm con',
        0,
        Number.MAX_SAFE_INTEGER,
        true
      );
    if (a.maxPens > sites.length || sites.filter(p => p.initial).length > a.maxPens)
      v.fail(path + '.maxPens', 'phải chứa đủ chuồng khởi đầu và nằm trong số vị trí đã tạo.');
  }
  const machines = v.object(
    c.machines,
    'machines',
    source.machineTypes!.map(m => m.key)
  );
  for (const [key, value] of Object.entries(machines)) {
    const path = `machines.${key}`,
      m = v.object(value, path, ['name', 'maxBuildings', 'maxQueueCapacity', 'startingCapacity', 'trayCapacity']);
    v.text(m.name, path + '.name');
    v.number(m.maxBuildings, path + '.maxBuildings', 1, BUILDINGS_PER_TYPE, true);
    v.number(m.maxQueueCapacity, path + '.maxQueueCapacity', 1, 5, true);
    v.number(m.startingCapacity, path + '.startingCapacity', 1, m.maxQueueCapacity, true);
    v.number(m.trayCapacity, path + '.trayCapacity', 1, TRAY_CAPACITY, true);
    const type = source.machineTypes!.find(t => t.key === key)!;
    if (m.maxBuildings > type.buildSites!.length) v.fail(path + '.maxBuildings', 'vượt số vị trí đã tạo.');
  }
  const gates = v.object(c.gates, 'gates', ['husbandry', 'crafts']);
  for (const [key, value] of Object.entries(gates)) {
    const path = `gates.${key}`,
      gate = v.object(value, path, ['mode', 'requirements']);
    if (!['all', 'any'].includes(gate.mode)) v.fail(path + '.mode', 'cần all hoặc any.');
    if (!Array.isArray(gate.requirements)) v.fail(path + '.requirements', 'cần danh sách điều kiện; [] để bỏ khóa.');
    gate.requirements.forEach((entry: unknown, i: number) => {
      const p = `${path}.requirements.${i}`,
        r = v.object(entry, p, ['items', 'quantity', 'label']);
      v.text(r.label, p + '.label');
      v.number(r.quantity, p + '.quantity', 1, Number.MAX_SAFE_INTEGER, true);
      if (
        !Array.isArray(r.items) ||
        !r.items.length ||
        new Set(r.items).size !== r.items.length ||
        r.items.some((item: unknown) => typeof item !== 'string' || !items.has(item))
      )
        v.fail(p + '.items', 'cần các mã vật phẩm có thật, không trùng.');
    });
  }
  return { ...source, gameplay: JSON.parse(JSON.stringify(c)) as FarmGameplayConfig };
}
