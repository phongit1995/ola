import { establishFarm } from './fixtures/established-farm';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import { progression, xpToNext } from '../assets/farm/scripts/core/Progression';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { FarmGame, orderedCrops } from '../assets/farm/scripts/core/FarmGame';
import { FARM_KEY, SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import type { ActionResult } from '../assets/farm/scripts/core/types/ActionTypes';
import { stockCatalog, cropItemKey, recipeInputs, recipeOutputs } from '../assets/farm/scripts/core/FarmCatalog';
const read = (name: string) => JSON.parse(fs.readFileSync(path.resolve(__dirname, name), 'utf8'));
const catalog: FarmCatalog = loadFarmCatalog();
const plan = read('fixtures/simple-first-scope-v1.json');
const baseline: FarmCatalog = read('fixtures/simple-farm-catalog-v1.json');
const scope = read('fixtures/farm-town-husbandry-scope.json');
const clone = <T>(v: T): T => JSON.parse(JSON.stringify(v));
const ok = (r: ActionResult) => assert.equal(r.error, undefined);
const settings = { speed: 1, sound: false, music: false };
const reload = (g: FarmGame) => new FarmGame(catalog, clone(g.state));
const xpFor = (level: number) =>
  Array.from({ length: level - 1 }, (_, i) => xpToNext(i + 1)).reduce((a, b) => a + b, 0);
const identity = ({ price, sellPrice, duration, xp, harvestXP, requiredLevel, yields, quantity, ...rest }: any) => rest;
const fixture = () => {
  const g = establishFarm(new FarmGame(catalog));
  g.state.coins = 200000000;
  g.state.xp = 100000000;
  for (const p of orderedCrops(g.state.plots)) if (!p.unlocked) ok(g.improve(p.id));
  g.state.coins = 1000000;
  g.state.husbandry = {
    version: 1,
    feedReceived: true,
    eggsCollected: true,
    milkCollected: true,
    burgerCollected: true,
  };
  for (const item of g.items) g.state.inventory[item.key] = 100;
  return g;
};
const memory = () => {
  const data = new Map<string, string>();
  return {
    data,
    port: {
      getItem: (k: string) => data.get(k) ?? null,
      setItem: (k: string, v: string) => {
        data.set(k, v);
      },
    },
  };
};

test('Farm Town has four species, eight machines and a closed 23-recipe chain while crop identities and ingredient chains remain compatible', () => {
  assert.equal(catalog.contentProfile, 'simple-1');
  assert.deepEqual(catalog.farm.map(identity), baseline.farm.map(identity));
  assert.deepEqual(
    catalog.farm.map(f => f.id),
    plan.fields.map((f: any) => f.id)
  );
  assert.equal(catalog.machineTypes!.length, 8);
  assert.equal(catalog.livestock!.length, 4);
  assert.equal(catalog.products.length, 23);
  const items = stockCatalog(catalog);
  assert.equal(items.length, 35);
  assert.equal(new Set(items.map(i => i.key)).size, 35);
  assert.deepEqual(catalog.items!.map(identity), scope.items.map(identity));
  assert.deepEqual(catalog.products.map(identity), scope.recipes.map(identity));
  assert.deepEqual(
    catalog.machineTypes!.map(({ buildSites, buildingIds, purchasePrices, ...type }) => type),
    scope.machines.map(({ buildingIds, purchasePrices, ...type }: any) => type)
  );
  assert.deepEqual(catalog.livestock!.map(identity), scope.livestock.map(identity));
  for (const crop of baseline.farm) {
    const key = cropItemKey(crop);
    assert.deepEqual(
      identity(catalog.items!.find(i => i.key === key)),
      identity(baseline.items!.find(i => i.key === key))
    );
  }
  for (const r of baseline.products) {
    const current = catalog.products.find(x => x.id === r.id)!;
    assert.deepEqual(recipeInputs(current), recipeInputs(r));
    assert.deepEqual(recipeOutputs(current), recipeOutputs(r));
  }
  for (const a of baseline.livestock!)
    assert.deepEqual(identity(catalog.livestock!.find(x => x.key === a.key)), identity(a));
  assert.equal(items.filter(i => i.tab === 'raw').length, 12);
  assert.equal(items.filter(i => i.tab === 'goods').length, 23);
  const allowed = new Set(items.map(i => i.key)),
    reachable = new Set(catalog.farm.map(cropItemKey));
  const edges = [
    ...catalog.products.map(r => ({ inputs: recipeInputs(r), outputs: recipeOutputs(r) })),
    ...catalog.livestock!.map(a => ({
      inputs: [{ key: a.feed, quantity: 1 }],
      outputs: [{ key: a.output, quantity: a.quantity }],
    })),
  ];
  for (const e of edges) for (const q of [...e.inputs, ...e.outputs]) assert.ok(allowed.has(q.key));
  for (let n = 0; n < 35; n++)
    for (const e of edges) if (e.inputs.every(q => reachable.has(q.key))) e.outputs.forEach(q => reachable.add(q.key));
  assert.deepEqual([...reachable].sort(), [...allowed].sort());
  for (const f of catalog.farm) assert.ok(edges.some(e => e.inputs.some(q => q.key === cropItemKey(f))));
  for (const type of catalog.machineTypes!) assert.ok(catalog.products.some(r => r.machine === type.id));
});

test('fresh state has six open fields of 40 and no constructed pens or machines; reload never grants buildings', () => {
  const g = new FarmGame(catalog),
    s = g.state;
  assert.equal(s.version, 7);
  assert.equal(s.contentProfile, 'simple-1');
  assert.equal(s.coins, 500);
  assert.equal(s.diamonds, 10);
  assert.equal(s.xp, 0);
  assert.deepEqual(s.inventory, {});
  assert.equal(s.plots.length, 54);
  assert.equal(orderedCrops(s.plots).length, 40);
  assert.ok(orderedCrops(s.plots).every(p => p.crop === null));
  assert.equal(orderedCrops(s.plots).filter(p => p.unlocked).length, 6);
  assert.equal(s.plots.filter(p => g.isActivePlot(p)).length, 48);
  assert.deepEqual(
    s.plots.filter(p => p.residents),
    []
  );
  assert.deepEqual(s.machines, []);
  assert.equal('expansion' in s, false);
  assert.deepEqual(reload(g).state, g.state);
  g.state.xp = xpFor(g.machineConstructionOffer(2).requiredLevel);
  g.state.coins = 2000;
  ok(g.buyMachine(2));
  ok(g.dismissGuide());
  assert.deepEqual(reload(g).state, g.state);
  assert.equal(reload(g).state.plots[12].residents, null);
});

test('every selected crop works across all 40 stable field positions and three growth stages', () => {
  for (const f of catalog.farm) {
    let g = fixture();
    const ids = orderedCrops(g.state.plots).map(p => p.id),
      before = g.quantity(cropItemKey(f));
    for (const id of ids) ok(g.plant(id, f.id));
    g = reload(g);
    assert.ok(orderedCrops(g.state.plots).every(p => g.growthStage(p) === 1));
    g.tick(f.duration / 2);
    g = reload(g);
    assert.ok(orderedCrops(g.state.plots).every(p => g.growthStage(p) === 2));
    g.tick(f.duration / 2);
    g = reload(g);
    for (const id of ids) ok(g.harvest(id));
    assert.equal(g.quantity(cropItemKey(f)), before + 120);
    assert.deepEqual(
      orderedCrops(g.state.plots).map(p => p.id),
      ids
    );
    g.validate();
  }
});

test('off-scope crops, legacy batch animals, inactive plots, extra mills and species changes fail without spending', () => {
  const g = fixture();
  const before = clone(g.state);
  for (const run of [
    () => g.plant(0, 2),
    () => g.plant(0, 1029),
    () => g.plant(14, 5),
    () => g.improve(14),
    () => g.improve(18),
    () => g.produce(23),
    () => g.produce(100400),
    () => g.buyMachine(3),
    () => g.buyMachine(5, 'feed-3'),
    () => g.buyMachine(1004),
    () => g.setPenSpecies(12, 'dairy-cow'),
    () => g.setPenSpecies(12, null),
    () => g.buyAnimal(14),
    () => g.feedAnimals(18),
    () => g.sellItem('town:diamond'),
  ]) {
    assert.ok(run().error);
    assert.deepEqual(g.state, before);
  }
  for (const method of ['plantGarden', 'buyTool', 'buyResource', 'buyApiary', 'deliver', 'claimQuest'])
    assert.equal(typeof (g as any)[method], 'undefined');
});

test('first factories require their levels and prices, bind once to selected sites and survive reload', () => {
  let g = fixture();
  const before = g.state.coins;
  for (const type of [2, 1071, 1020, 1019]) {
    const offer = g.machineConstructionOffer(type);
    g.state.xp = xpFor(offer.requiredLevel) - 1;
    const blocked = clone(g.state);
    assert.ok(g.buyMachine(type).error);
    assert.deepEqual(g.state, blocked);
    g.state.xp = xpFor(offer.requiredLevel);
    ok(g.buyMachine(type));
    g = reload(g);
    const bought = clone(g.state);
    assert.ok(g.buyMachine(type).error);
    assert.deepEqual(g.state, bought);
  }
  assert.equal(before - g.state.coins, 30800);
  assert.equal(g.state.machines.length, 7);
  assert.equal(new Set(g.state.machines.map(m => m.buildingId)).size, 7);
  const poor = new FarmGame(catalog);
  poor.state.xp = xpFor(poor.machineConstructionOffer(2).requiredLevel);
  poor.state.coins = 1799;
  const untouched = clone(poor.state);
  assert.ok(poor.buyMachine(2).error);
  assert.deepEqual(poor.state, untouched);
});

test('all twenty-three recipes pay once, use their own machine, then collect and sell once', () => {
  for (const r of catalog.products) {
    let g = fixture();
    if (!g.state.machines.some(m => m.type === r.machine)) ok(g.buyMachine(r.machine));
    const machine = g.state.machines.find(m => m.type === r.machine)!;
    const before = clone(g.state.inventory);
    ok(g.produce(r.id, machine.id));
    for (const input of recipeInputs(r)) assert.equal(g.quantity(input.key), before[input.key] - input.quantity);
    const busy = clone(g.state);
    assert.ok(g.produce(r.id, machine.id).error);
    assert.ok(g.collect(machine.id).error);
    assert.deepEqual(g.state, busy);
    g.tick(r.duration);
    g = reload(g);
    const out = recipeOutputs(r)[0],
      count = g.quantity(out.key);
    ok(g.collect(machine.id));
    assert.equal(g.quantity(out.key), count + out.quantity);
    assert.ok(g.collect(machine.id).error);
    const coins = g.state.coins;
    ok(g.sellItem(out.key, out.quantity));
    assert.equal(g.state.coins, coins + g.item(out.key)!.sellPrice * out.quantity);
    g.validate();
  }
});

test('queue expansion, cancellation and full tray keep exact paid snapshots through reload and later balance changes', () => {
  let g = fixture();
  ok(g.expandQueue(0));
  ok(g.produce(26, 0));
  ok(g.produce(26, 0));
  const pending = g.state.machines[0].waiting[0].id;
  const changed = clone(catalog),
    r = changed.products.find(r => r.id === 26)!;
  r.ingredients = [{ key: 'farm40:corn', quantity: 99 }];
  r.outputs = [{ key: 'farm40:corn-bread', quantity: 99 }];
  r.duration = 999;
  r.xp = 999;
  g = new FarmGame(changed, g.state);
  const corn = g.quantity('farm40:corn');
  ok(g.cancelQueued(0, pending));
  assert.equal(g.quantity('farm40:corn'), corn + 2);
  assert.ok(g.cancelQueued(0, pending).error);
  const out = g.quantity('farm40:corn-bread');
  g.tick(catalog.products.find(r => r.id === 26)!.duration);
  ok(g.collect(0));
  assert.equal(g.quantity('farm40:corn-bread'), out + 1);
  g = fixture();
  while (g.state.machines[0].capacity < 5) ok(g.expandQueue(0));
  for (let i = 0; i < 5; i++) ok(g.produce(7, 0));
  g.tick(g.product(7)!.duration * 5);
  assert.equal(g.state.machines[0].tray.length, 5);
  ok(g.produce(7, 0));
  g.tick(999);
  g = reload(g);
  assert.equal(g.state.machines[0].job, null);
  const time = g.state.time;
  ok(g.collect(0));
  assert.equal(g.state.machines[0].job!.started, time);
  assert.equal(g.state.machines[0].job!.ready, time + g.product(7)!.duration);
  const batch = g.state.machines[0].tray[0].id;
  ok(g.collect(0, batch));
  const after = clone(g.state);
  assert.ok(g.collect(0, batch).error);
  assert.deepEqual(g.state, after);
});

test('all four species have individual timers, one feed each, persistent animals and five paid animal slots', () => {
  for (const id of [12, 13, 14, 15]) {
    let g = fixture();
    g.state.xp = 100000000;
    if (id >= 14) ok(g.buyPen(id));
    const pen = g.state.plots[id].residents!,
      type = catalog.livestock!.find(a => a.key === pen.species)!;
    const start = g.state.coins;
    for (let slot = 2; slot <= 5; slot++) ok(g.expandPen(id));
    assert.equal(g.state.coins, start - 45 - 75 - 120 - 180 - type.price * 4);
    assert.ok(g.expandPen(id).error);
    assert.ok(g.buyAnimal(id).error);
    const feed = g.quantity(type.feed),
      output = g.quantity(type.output),
      first = pen.animals[0].id;
    ok(g.feedAnimals(id, first));
    assert.equal(g.quantity(type.feed), feed - 1);
    g.tick(type.duration / 2);
    ok(g.feedAnimals(id));
    assert.equal(g.quantity(type.feed), feed - 5);
    g.tick(type.duration / 2);
    g = reload(g);
    ok(g.collectAnimals(id, first));
    assert.equal(g.quantity(type.output), output + 1);
    assert.ok(g.collectAnimals(id, first).error);
    g.tick(type.duration / 2);
    ok(g.collectAnimals(id));
    assert.equal(g.quantity(type.output), output + 5);
    assert.equal(g.state.plots[id].residents!.animals.length, 5);
    g.validate();
  }
});

test('crop refunds and boost settle once, and zero-capital rescue works with hungry resident animals', () => {
  let g = new FarmGame(catalog);
  ok(g.plant(0, 1));
  const coins = g.state.coins;
  ok(g.cancel(0));
  assert.equal(g.state.coins, coins + 6);
  assert.ok(g.cancel(0).error);
  g.state.xp = xpFor(g.farm(10)!.requiredLevel!);
  ok(g.plant(0, 10));
  ok(g.boost(0));
  assert.equal(g.state.diamonds, 9);
  assert.ok(g.boost(0).error);
  g.tick(0.5);
  ok(g.harvest(0));
  g = new FarmGame(catalog);
  g.state.coins = 0;
  const xp = g.state.xp;
  assert.equal(g.canRescue(), true);
  ok(g.rescue());
  assert.equal(g.state.xp, xp);
  assert.equal(g.canRescue(), false);
  ok(g.cancel(0));
  assert.equal(g.state.coins, 0);
  ok(g.rescue());
  g = reload(g);
  g.tick(g.farm(1)!.duration);
  ok(g.harvest(0));
  ok(g.sellItem('raw:1', 3));
  assert.equal(g.state.coins, 24);
  ok(g.plant(0, 1));
  const full = fixture();
  for (const type of [2, 1071, 1020, 1019]) ok(full.buyMachine(type));
  full.state.coins = 0;
  full.state.inventory = {};
  assert.equal(full.state.machines.length, 7);
  assert.equal(full.canRescue(), true);
  ok(full.rescue());
  full.tick(full.farm(1)!.duration);
  ok(full.harvest(0));
  assert.equal(full.quantity('raw:1'), 3);
  full.validate();
});

test('new saves, restart and import leave old v2/v3/v4 source and every recovery key byte-for-byte intact', () => {
  for (const version of [2, 3, 4]) {
    const m = memory();
    for (const suffix of ['', '.backup', '.before-import', '.import-source'])
      m.data.set(
        FARM_KEY + suffix,
        JSON.stringify({ version: version - 1, free: { version, inventory: { 'town:diamond': 77 } } }) + '  \n'
      );
    const before = new Map(m.data),
      saver = new FarmSave(m.port, catalog);
    assert.equal(saver.load(), null);
    assert.equal(saver.legacySource(), before.get(FARM_KEY));
    assert.equal(saver.legacyBackup(), before.get(FARM_KEY + '.backup'));
    const g = new FarmGame(catalog);
    saver.save(farmPack(g.state, settings));
    ok(g.dismissGuide());
    ok(g.plant(0, 1));
    saver.save(farmPack(g.state, settings));
    const exported = JSON.stringify(farmPack(g.state, settings));
    saver.importText(exported);
    assert.deepEqual(saver.load(), farmPack(g.state, settings));
    saver.save(farmPack(new FarmGame(catalog).state, settings));
    for (const [key, value] of before) assert.equal(m.data.get(key), value);
    assert.ok(m.data.has(SIMPLE_FARM_KEY));
    const unchanged = new Map(m.data);
    assert.throws(() => saver.importText(before.get(FARM_KEY)!));
    assert.deepEqual(m.data, unchanged);
  }
});

test('wrong profiles, invalid ownership, slots/species, unknown stock/jobs and future saves fail before writes', () => {
  const m = memory(),
    saver = new FarmSave(m.port, catalog);
  saver.save(farmPack(fixture().state, settings));
  const mutations = [
    (p: any) => (p.version = 99),
    (p: any) => (p.contentProfile = 'full'),
    (p: any) => (p.free.contentProfile = 'full'),
    (p: any) => (p.free.guideDismissed = 1),
    (p: any) => (p.free.expansion = {}),
    (p: any) => (p.free.inventory['raw:2'] = 1),
    (p: any) => (p.free.produced['town:diamond'] = 1),
    (p: any) => (p.free.plots[14].unlocked = true),
    (p: any) => (p.free.plots[12].residents.species = 'dairy-cow'),
    (p: any) => (p.free.plots[13].residents = null),
    (p: any) => (p.free.machines[0].buildingId = null),
    (p: any) => (p.free.machines[0].type = 3),
    (p: any) => p.free.machines.push({ ...p.free.machines[0], id: 55 }),
    (p: any) => (p.free.plots[12].residents.animals[0].id = p.free.plots[13].residents.animals[0].id),
  ];
  for (const change of mutations) {
    const pack = clone(farmPack(fixture().state, settings));
    change(pack);
    const before = new Map(m.data);
    assert.throws(() => saver.importText(JSON.stringify(pack)));
    assert.deepEqual(m.data, before);
  }
  const g = fixture();
  ok(g.produce(7));
  const bad = farmPack(g.state, settings);
  bad.free.machines[0].job!.inputs[0].key = 'town:apple';
  assert.throws(() => saver.importText(JSON.stringify(bad)));
  m.data.set(SIMPLE_FARM_KEY, '{broken');
  assert.throws(() => saver.load());
  assert.throws(() => saver.save(farmPack(fixture().state, settings)));
  assert.equal(saver.source(), '{broken');
  saver.importText(JSON.stringify(farmPack(fixture().state, settings)));
  assert.equal(m.data.get(SIMPLE_FARM_KEY + '.before-import'), '{broken');
});

test('quota failure preserves simple primary and old source, then retry commits exactly once', () => {
  const m = memory();
  m.data.set(FARM_KEY, 'old farm bytes');
  let fail = false;
  const saver = new FarmSave(
    {
      getItem: m.port.getItem,
      setItem: (key, value) => {
        if (fail && key === SIMPLE_FARM_KEY) throw Error('quota');
        m.port.setItem(key, value);
      },
    },
    catalog
  );
  const g = new FarmGame(catalog);
  g.state.xp = xpFor(g.machineConstructionOffer(2).requiredLevel);
  g.state.coins = 2000;
  saver.save(farmPack(g.state, settings));
  const before = saver.source();
  ok(g.buyMachine(2));
  fail = true;
  assert.throws(() => saver.save(farmPack(g.state, settings)));
  assert.equal(saver.source(), before);
  assert.equal(saver.legacySource(), 'old farm bytes');
  fail = false;
  saver.save(farmPack(g.state, settings));
  assert.deepEqual(saver.load()!.free, g.state);
});

test('fresh 500-coin farm earns every crop level and opens all 23 recipes using only its production', () => {
  let g = new FarmGame(catalog);
  const seen = new Set<number>(),
    harvested = new Set<string>();
  function earn() {
    const available = catalog.farm
      .filter(crop => (crop.requiredLevel ?? 1) <= g.progress.level)
      .sort((a, b) => b.harvestXP! - a.harvestXP!);
    let planted = 0,
      duration = 0;
    const sales = new Set<string>();
    for (const p of orderedCrops(g.state.plots))
      if (p.unlocked && p.crop === null) {
        const crop = available.find(crop => crop.price <= g.state.coins);
        if (!crop) continue;
        ok(g.plant(p.id, crop.id));
        planted++;
        duration = Math.max(duration, crop.duration);
        sales.add(cropItemKey(crop));
      }
    assert.ok(planted);
    g.tick(duration);
    for (const p of orderedCrops(g.state.plots))
      if (g.isReady(p)) {
        const key = cropItemKey(g.farm(p.crop!)!);
        ok(g.harvest(p.id));
        harvested.add(key);
      }
    for (const key of sales) if (g.quantity(key)) ok(g.sellItem(key, g.quantity(key)));
  }
  function reach(level: number) {
    let guard = 0;
    while (progression(g.state.xp).level < level) {
      assert.ok(++guard < 10000);
      earn();
    }
  }
  function fund(price: number) {
    let guard = 0;
    while (g.state.coins < price + 20) {
      assert.ok(++guard < 10000);
      earn();
    }
  }
  function grow(id: number) {
    const f = g.farm(id)!;
    reach(f.requiredLevel ?? 1);
    fund(f.price);
    ok(g.plant(0, id));
    g.tick(f.duration);
    ok(g.harvest(0));
    harvested.add(cropItemKey(f));
  }
  function unlock(gate: string | undefined, depth: number) {
    if (gate === 'husbandry' && !g.penUnlockStatus(14).unlocked) {
      reach(catalog.residentPens!.find(site => site.plotId === 14)!.requiredLevel!);
      ensure('farm40:chicken-feed', 1, depth + 1);
      ensure('farm40:egg', 1, depth + 1);
      ensure('raw:7', 1, depth + 1);
    }
    if (gate === 'crafts' && !g.state.husbandry!.burgerCollected) ensure('town:burger', 1, depth + 1);
  }
  function ensure(key: string, quantity: number, depth = 0): void {
    assert.ok(depth < 20, key);
    let guard = 0;
    while (g.quantity(key) < quantity) {
      assert.ok(++guard < 100, key);
      const f = catalog.farm.find(f => cropItemKey(f) === key),
        animal = catalog.livestock!.find(a => a.output === key);
      if (f) grow(f.id);
      else if (animal) {
        const site = catalog.residentPens!.find(d => d.species === animal.key)!;
        reach(site.requiredLevel ?? 1);
        unlock(site.unlock, depth);
        ensure(animal.feed, 1, depth + 1);
        const pen = g.residentPlot(site.plotId!)!;
        if (!pen.residents) {
          fund(g.penPurchasePrice(pen.id)!);
          ok(g.buyPen(pen.id));
        }
        ok(g.feedAnimals(pen.id));
        g.tick(animal.duration);
        ok(g.collectAnimals(pen.id));
      } else {
        const r = catalog.products.find(r => recipeOutputs(r).some(o => o.key === key))!;
        assert.ok(r, key);
        prepare(r, depth + 1);
        const m = g.state.machines.find(m => m.type === r.machine)!;
        ok(g.produce(r.id, m.id));
        g.tick(r.duration);
        ok(g.collect(m.id));
        seen.add(r.id);
      }
    }
  }
  function prepare(r: FarmCatalog['products'][number], depth = 0) {
    reach(r.requiredLevel ?? 1);
    unlock(r.unlock, depth);
    if (!g.state.machines.some(m => m.type === r.machine)) {
      fund(g.machinePurchasePrice(r.machine)!);
      ok(g.buyMachine(r.machine));
    }
    let guard = 0;
    while (!g.has(recipeInputs(r))) {
      assert.ok(++guard < 20, r.name);
      for (const q of recipeInputs(r)) ensure(q.key, q.quantity, depth);
    }
  }
  for (const r of catalog.products) {
    prepare(r);
    const m = g.state.machines.find(m => m.type === r.machine)!;
    ok(g.produce(r.id, m.id));
    g.tick(r.duration);
    ok(g.collect(m.id));
    seen.add(r.id);
    for (const q of recipeOutputs(r)) ok(g.sellItem(q.key, q.quantity));
    g = reload(g);
  }
  assert.equal(seen.size, 23);
  assert.equal(harvested.size, 8);
  assert.equal(g.state.machines.length, 8);
  assert.equal(g.state.plots.filter(p => p.residents).length, 4);
  assert.equal(g.state.diamonds, 10);
  assert.ok(g.state.coins >= 20);
  g.validate();
});
