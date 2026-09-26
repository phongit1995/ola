import { isRecord } from './utils/TypeGuards';
import type { FarmCatalogSource } from './types/TimingTypes';
import type { FarmContentSource, FarmEconomyConfig, SlotPrice } from './types/EconomyTypes';

const fail = (field: string, reason: string): never => {
  throw Error(`economy.json · ${field}: ${reason}`);
};
function object(value: unknown, field: string, keys?: string[]): Record<string, any> {
  if (!isRecord(value)) return fail(field, 'thiếu mục cấu hình.');
  if (keys) {
    for (const key of keys) if (!(key in value)) fail(`${field}.${key}`, 'thiếu cấu hình.');
    for (const key of Object.keys(value)) if (!keys.includes(key)) fail(`${field}.${key}`, 'khóa không được hỗ trợ.');
  }
  return value;
}
function integer(value: unknown, field: string, min = 0, max = Number.MAX_SAFE_INTEGER): number {
  if (typeof value !== 'number' || !Number.isSafeInteger(value) || value < min || value > max)
    return fail(field, `cần số nguyên từ ${min} đến ${max}.`);
  return value;
}
function name(value: unknown, field: string): void {
  if (typeof value !== 'string' || !value.trim()) fail(field, 'cần tên để nhận diện.');
}
function noDuplicates(value: object, fields: string[], field: string): void {
  for (const key of fields)
    if (key in value) fail(`${field}.${key}`, 'bỏ giá trị trùng trong catalog.json; chỉ chỉnh economy.json.');
}

export function withFarmEconomy(source: FarmContentSource, input: unknown): FarmCatalogSource {
  const root = object(input, 'config', [
    'version',
    'startingWallet',
    'experience',
    'refunds',
    'coinPacks',
    'gemPacks',
    'crops',
    'items',
    'recipes',
    'animals',
    'machines',
    'pens',
    'fields',
  ]);
  if (root.version !== 1) fail('version', 'chỉ hỗ trợ phiên bản 1.');
  noDuplicates(source, ['economy', 'plantingXP', 'saleXpCoins'], 'config');
  const wallet = object(root.startingWallet, 'startingWallet', ['coins', 'diamonds', 'xp']);
  for (const key of Object.keys(wallet)) integer(wallet[key], `startingWallet.${key}`);
  const xp = object(root.experience, 'experience', [
    'plantingXP',
    'saleCoinsPerXP',
    'levelUpDiamonds',
    'buildXP',
    'curve',
  ]);
  integer(xp.plantingXP, 'experience.plantingXP');
  integer(xp.saleCoinsPerXP, 'experience.saleCoinsPerXP', 1);
  integer(xp.levelUpDiamonds, 'experience.levelUpDiamonds', 0, 100);
  const build = object(xp.buildXP, 'experience.buildXP', ['machine', 'pen', 'penSlot', 'queueSlot', 'field']);
  for (const key of Object.keys(build)) integer(build[key], `experience.buildXP.${key}`, 0, 10000);
  const curve = object(xp.curve, 'experience.curve', [
    'maxLevel',
    'baseXP',
    'linearXP',
    'quadraticAfterLevel',
    'quadraticXP',
  ]);
  integer(curve.maxLevel, 'experience.curve.maxLevel', 1, 99);
  for (const key of ['baseXP', 'linearXP', 'quadraticAfterLevel', 'quadraticXP'])
    integer(curve[key], `experience.curve.${key}`, ['baseXP', 'quadraticAfterLevel'].includes(key) ? 1 : 0);
  integer(
    curve.maxLevel * (curve.baseXP + curve.linearXP * curve.maxLevel + curve.quadraticXP * curve.maxLevel ** 2),
    'experience.curve: tổng XP'
  );
  const level = (value: unknown, field: string) => integer(value, field, 1, curve.maxLevel);
  const refunds = object(root.refunds, 'refunds', ['cropCancelRate', 'animalSaleRate']);
  for (const key of Object.keys(refunds))
    if (typeof refunds[key] !== 'number' || !Number.isFinite(refunds[key]) || refunds[key] < 0 || refunds[key] > 1)
      fail(`refunds.${key}`, 'tỷ lệ phải từ 0 đến 1.');
  if (!Array.isArray(root.coinPacks) || !root.coinPacks.length) fail('coinPacks', 'cần ít nhất một gói.');
  root.coinPacks.forEach((p: unknown, i: number) => {
    const v = object(p, `coinPacks.${i}`, ['coins', 'diamonds']);
    integer(v.coins, `coinPacks.${i}.coins`, 1);
    integer(v.diamonds, `coinPacks.${i}.diamonds`, 1);
  });
  if (!Array.isArray(root.gemPacks)) fail('gemPacks', 'cần danh sách gói hiển thị.');
  root.gemPacks.forEach((p: unknown, i: number) => {
    const v = object(p, `gemPacks.${i}`, ['gems', 'price']);
    integer(v.gems, `gemPacks.${i}.gems`, 1);
    name(v.price, `gemPacks.${i}.price`);
  });
  const crops = object(
    root.crops,
    'crops',
    source.farm.map(f => f.key)
  );
  const items = object(
    root.items,
    'items',
    source.items.map(i => i.key)
  );
  const recipes = object(
    root.recipes,
    'recipes',
    source.products.map(r => String(r.id))
  );
  const animals = object(
    root.animals,
    'animals',
    source.livestock.map(a => a.key)
  );
  const machines = object(
    root.machines,
    'machines',
    source.machineTypes.map(m => m.key)
  );
  const pens = object(
    root.pens,
    'pens',
    source.residentPens.map(p => p.buildingId!)
  );
  const fieldIds = Array.from({ length: 50 }, (_, id) => id)
    .filter(id => id < 12 || id >= 22)
    .map(String);
  const fields = object(root.fields, 'fields', fieldIds);
  let openFields = 0;
  for (const id of fieldIds) {
    const f = object(fields[id], `fields.${id}`, [
      'name',
      'initiallyUnlocked',
      'initialLevel',
      'unlockPrice',
      'requiredLevel',
    ]);
    name(f.name, `fields.${id}.name`);
    integer(f.initialLevel, `fields.${id}.initialLevel`, 1, 4);
    integer(f.unlockPrice, `fields.${id}.unlockPrice`);
    level(f.requiredLevel, `fields.${id}.requiredLevel`);
    if (typeof f.initiallyUnlocked !== 'boolean') fail(`fields.${id}.initiallyUnlocked`, 'cần true hoặc false.');
    if (f.initiallyUnlocked) openFields++;
  }
  if (!openFields) fail('fields', 'cần ít nhất một ruộng mở sẵn để có thể trồng và nhận hạt hỗ trợ.');
  function slots(value: unknown, field: string): void {
    if (!Array.isArray(value) || value.length !== 4) return fail(field, 'cần bốn mục cho ô 2, 3, 4, 5.');
    value.forEach((v, i) => {
      const p = object(v, `${field}.${i}`, ['price', 'requiredLevel']);
      integer(p.price, `${field}.${i}.price`);
      level(p.requiredLevel, `${field}.${i}.requiredLevel`);
    });
  }
  const result: FarmCatalogSource = {
    ...source,
    economy: root as unknown as FarmEconomyConfig,
    plantingXP: xp.plantingXP,
    saleXpCoins: xp.saleCoinsPerXP,
    items: source.items.map(i => {
      noDuplicates(i, ['sellPrice'], `items.${i.key}`);
      const p = object(items[i.key], `items.${i.key}`, ['name', 'sellPrice']);
      name(p.name, `items.${i.key}.name`);
      integer(p.sellPrice, `items.${i.key}.sellPrice`);
      return { ...i, sellPrice: p.sellPrice };
    }),
    farm: source.farm.map(f => {
      const field = `crops.${f.key}`;
      noDuplicates(f, ['price', 'sellPrice', 'requiredLevel', 'harvestXP', 'yields'], field);
      const p = object(crops[f.key], field, ['name', 'seedPrice', 'requiredLevel', 'harvestXP', 'yields']);
      name(p.name, field + '.name');
      integer(p.seedPrice, field + '.seedPrice', 1);
      level(p.requiredLevel, field + '.requiredLevel');
      integer(p.harvestXP, field + '.harvestXP');
      if (!Array.isArray(p.yields) || p.yields.length !== 4) fail(field + '.yields', 'cần sản lượng của bốn cấp đất.');
      p.yields.forEach((n: unknown, i: number) => integer(n, `${field}.yields.${i}`, 1));
      if (f.id === 1 && p.requiredLevel !== 1) fail(field + '.requiredLevel', 'lúa hỗ trợ phải mở ở level 1.');
      return {
        ...f,
        price: p.seedPrice,
        sellPrice: items[f.itemKey ?? `raw:${f.id}`].sellPrice,
        requiredLevel: p.requiredLevel,
        harvestXP: p.harvestXP,
        yields: [...p.yields],
      };
    }),
    livestock: source.livestock.map(a => {
      const field = `animals.${a.key}`;
      noDuplicates(a, ['price', 'quantity', 'xp'], field);
      const p = object(animals[a.key], field, ['name', 'purchasePrice', 'quantity', 'xp', 'slots']);
      name(p.name, field + '.name');
      integer(p.purchasePrice, field + '.purchasePrice');
      integer(p.quantity, field + '.quantity', 1);
      integer(p.xp, field + '.xp');
      slots(p.slots, field + '.slots');
      p.slots.forEach((s: SlotPrice) => integer(s.price + p.purchasePrice, field + '.slots: giá gộp'));
      return { ...a, price: p.purchasePrice, quantity: p.quantity, xp: p.xp };
    }),
    products: source.products.map(r => {
      const field = `recipes.${r.id}`;
      noDuplicates(r, ['price', 'requiredLevel', 'xp'], field);
      const p = object(recipes[r.id], field, ['name', 'requiredLevel', 'xp']);
      name(p.name, field + '.name');
      level(p.requiredLevel, field + '.requiredLevel');
      integer(p.xp, field + '.xp');
      return {
        ...r,
        price: items[r.outputs?.[0].key ?? `goods:${r.id}`].sellPrice,
        requiredLevel: p.requiredLevel,
        xp: p.xp,
      };
    }),
    machineTypes: source.machineTypes.map(m => {
      const field = `machines.${m.key}`,
        p = object(machines[m.key], field, ['name', 'sites', 'queueSlots']);
      name(p.name, field + '.name');
      slots(p.queueSlots, field + '.queueSlots');
      if (!Array.isArray(p.sites) || p.sites.length !== m.buildSites.length)
        fail(field + '.sites', 'cần giá của từng vị trí nhà đã có trong catalog.');
      return {
        ...m,
        buildSites: m.buildSites.map((site, i) => {
          noDuplicates(site, ['price', 'requiredLevel'], `${field}.sites.${i}`);
          const s = object(p.sites[i], `${field}.sites.${i}`, ['price', 'requiredLevel']);
          level(s.requiredLevel, `${field}.sites.${i}.requiredLevel`);
          if (site.initial) {
            if (s.price !== null) fail(`${field}.sites.${i}.price`, 'nhà khởi đầu dùng null.');
          } else integer(s.price, `${field}.sites.${i}.price`);
          return { ...site, price: s.price, requiredLevel: s.requiredLevel };
        }),
      };
    }),
    residentPens: source.residentPens.map(site => {
      const field = `pens.${site.buildingId}`;
      noDuplicates(site, ['purchasePrice', 'requiredLevel'], field);
      const p = object(pens[site.buildingId!], field, ['name', 'sitePrice', 'requiredLevel']);
      name(p.name, field + '.name');
      level(p.requiredLevel, field + '.requiredLevel');
      if (site.initial) {
        if (p.sitePrice !== null) fail(field + '.sitePrice', 'chuồng khởi đầu dùng null.');
      } else {
        integer(p.sitePrice, field + '.sitePrice');
        integer(p.sitePrice + animals[site.species].purchasePrice, field + ': giá gộp');
      }
      return { ...site, requiredLevel: p.requiredLevel, ...(site.initial ? {} : { purchasePrice: p.sitePrice }) };
    }),
  };
  return result;
}
