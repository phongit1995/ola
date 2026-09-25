import { PEN_CAPACITY_LIMIT } from '../assets/farm/scripts/core/constants/HusbandryDefaults';
import { establishFarm } from './fixtures/established-farm';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import { PREVIOUS_SINGLE_BUILDING_LAYOUT } from '../assets/farm/scripts/core/legacy/PreviousSingleBuildingLayout';
import assert from 'node:assert/strict';
import { historicalState } from './fixtures/historical-state';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import type { ActionResult } from '../assets/farm/scripts/core/types/ActionTypes';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import {
  FARM_LAYOUT,
  assertBeforeTownBuildingLayout,
  groundError,
} from '../assets/farm/scripts/core/BuildingPlacement';
import { overlaps, translated } from '../assets/farm/scripts/core/BuildingGeometry';
import { recipeInputs, recipeOutputs } from '../assets/farm/scripts/core/FarmCatalog';
const catalog: FarmCatalog = loadFarmCatalog();
const baseline: FarmCatalog = JSON.parse(
  fs.readFileSync(path.join(__dirname, 'fixtures/simple-farm-catalog-v1.json'), 'utf8')
);
const clone = <T>(x: T): T => JSON.parse(JSON.stringify(x));
const ok = (x: ActionResult) => assert.equal(x.error, undefined, x.error);
const settings = { speed: 1, sound: false, music: false };
function funded() {
  const g = establishFarm(new FarmGame(catalog));
  g.state.coins = 1000000;
  g.state.xp = 100000000;
  for (const item of g.items) g.state.inventory[item.key] = 100;
  return g;
}

test('new pens require collected milestones, purchase one occupied slot, and keep their species and animal IDs for repeated harvests', () => {
  let g = funded();
  const original = clone(g.state);
  for (const run of [
    () => g.buyPen(14),
    () => g.buyPen(15),
    () => g.buyMachine(1021),
    () => g.produce(105003),
    () => g.produce(105004),
    () => g.produce(102101),
  ]) {
    assert.ok(run().error);
    assert.deepEqual(g.state, original);
  }
  // Stock alone never unlocks content in a new game. Collection, rather than production completion, is the milestone.
  assert.equal(g.penUnlockStatus(14).unlocked, false);
  ok(g.produce(24));
  g.tick(g.product(24)!.duration);
  assert.equal(g.state.husbandry!.feedReceived, false);
  ok(g.collectAll(g.state.machines.find(m => m.type === 5)!.id));
  ok(g.feedAnimals(12));
  ok(g.feedAnimals(13));
  g.tick(7200);
  ok(g.collectAnimals(12));
  assert.equal(g.penUnlockStatus(14).unlocked, false);
  ok(g.collectAnimals(13));
  assert.equal(g.penUnlockStatus(14).unlocked, true);
  for (const key of ['farm40:egg', 'raw:7', 'farm40:chicken-feed']) ok(g.sellItem(key, g.quantity(key)));
  g = new FarmGame(catalog, clone(g.state));
  assert.equal(g.penUnlockStatus(14).unlocked, true);
  const coins = g.state.coins,
    animalId = g.state.nextId;
  ok(g.buyPen(14));
  assert.equal(g.state.coins, coins - 4860);
  assert.deepEqual(clone(g.state.plots[14].residents), {
    species: 'pig',
    capacity: 1,
    animals: [{ id: animalId, slot: 0, job: null }],
  });
  const built = clone(g.state);
  assert.ok(g.buyPen(14).error);
  assert.deepEqual(g.state, built);
  assert.ok(g.buyAnimal(14).error);
  const id = g.state.plots[14].residents!.animals[0].id;
  for (let n = 0; n < 2; n++) {
    const before = g.quantity('town:beacon');
    ok(g.feedAnimals(14));
    g.tick(21600);
    g = new FarmGame(catalog, clone(g.state));
    ok(g.collectAnimals(14));
    assert.equal(g.quantity('town:beacon'), before + 1);
    assert.deepEqual(g.state.plots[14].residents!.animals, [{ id, slot: 0, job: null }]);
    assert.ok(g.collectAnimals(14).error);
  }
  ok(g.buyMachine(2));
  ok(g.produce(101604));
  g.tick(10800);
  assert.equal(g.penUnlockStatus(15).unlocked, false);
  ok(g.collectAll(g.state.machines.find(m => m.type === 2)!.id));
  assert.equal(g.penUnlockStatus(15).unlocked, true);
  assert.equal(g.machineUnlockStatus(1021).unlocked, true);
  ok(g.buyPen(15));
  assert.equal(g.state.plots[15].residents!.animals.length, 1);
  ok(g.buyMachine(1021));
  ok(g.feedAnimals(15));
  const sheep = clone(g.state.plots[15].residents!.animals[0]);
  g.tick(43200);
  ok(g.collectAnimals(15));
  assert.equal(g.state.plots[15].residents!.animals[0].id, sheep.id);
  assert.equal(g.state.plots[15].residents!.animals[0].job, null);
  g.validate();
  assert.deepEqual(new FarmGame(catalog, g.state).state, g.state);
});

test('collect-all aggregates mixed outputs atomically and leaves a running job and other machines untouched', () => {
  let g = funded();
  const bakery = g.state.machines.find(m => m.type === 1)!;
  while (bakery.capacity < 5) ok(g.expandQueue(bakery.id));
  ok(g.produce(7, bakery.id));
  ok(g.produce(9, bakery.id));
  ok(g.produce(10, bakery.id));
  g.tick(g.product(7)!.duration + g.product(9)!.duration);
  ok(g.produce(20));
  const job = clone(bakery.job),
    other = clone(g.state.machines.find(m => m.type === 4));
  const xp = g.state.xp,
    before = clone(g.state.inventory),
    tray = clone(bakery.tray);
  ok(g.collectAll(bakery.id));
  assert.deepEqual(bakery.job, job);
  assert.deepEqual(
    g.state.machines.find(m => m.type === 4),
    other
  );
  assert.equal(g.state.xp, xp + tray.reduce((n, b) => n + b.xp, 0));
  for (const b of tray) for (const o of b.outputs) assert.equal(g.quantity(o.key), before[o.key] + o.quantity);
  const collected = clone(g.state);
  assert.ok(g.collectAll(bakery.id).error);
  assert.deepEqual(g.state, collected);
  g = new FarmGame(catalog, clone(g.state));
  assert.deepEqual(g.state, collected);
});

test('collect-all respects aggregate inventory limits and restarts a tray-blocked paid queue at collection time', () => {
  const g = funded(),
    m = g.state.machines[0];
  while (m.capacity < 5) ok(g.expandQueue(m.id));
  for (let n = 0; n < 5; n++) ok(g.produce(7, m.id));
  g.tick(g.product(7)!.duration * 5);
  ok(g.produce(9, m.id));
  const queued = clone(m.waiting[0]);
  g.tick(999);
  assert.equal(m.job, null);
  g.state.inventory['goods:7'] = Number.MAX_SAFE_INTEGER - 4;
  const blocked = clone(g.state);
  assert.ok(g.collectAll(m.id).error);
  assert.deepEqual(g.state, blocked);
  g.state.inventory['goods:7'] = 0;
  g.state.produced['goods:7'] = Number.MAX_SAFE_INTEGER - 4;
  const statsBlocked = clone(g.state);
  assert.ok(g.collectAll(m.id).error);
  assert.deepEqual(g.state, statsBlocked);
  g.state.produced['goods:7'] = 0;
  const now = g.state.time;
  ok(g.collectAll(m.id));
  assert.equal(g.quantity('goods:7'), 5);
  assert.equal(m.job!.id, queued.id);
  assert.deepEqual(m.job!.inputs, queued.inputs);
  assert.deepEqual(m.job!.outputs, queued.outputs);
  assert.equal(m.job!.started, now);
  assert.equal(m.job!.ready, now + queued.duration);
  assert.equal(m.waiting.length, 0);
});

test('failed collect-all save publishes no rewards and retry commits milestones, inventory and XP once', () => {
  const map = new Map<string, string>();
  let fail = false;
  const saver = new FarmSave(
    {
      getItem: key => map.get(key) ?? null,
      setItem: (key, value) => {
        if (fail && key === SIMPLE_FARM_KEY) throw Error('quota');
        map.set(key, value);
      },
    },
    catalog
  );
  const session = new GameSession(catalog, saver, () => 0);
  session.game.state = funded().state;
  const g = session.game,
    m = g.state.machines.find(m => m.type === 5)!;
  ok(g.expandQueue(m.id));
  ok(g.produce(24));
  ok(g.produce(25));
  g.tick(1200);
  assert.equal(m.tray.length, 2);
  assert.equal(session.save(), true);
  const before = clone(g.state),
    primary = saver.source();
  fail = true;
  assert.equal(session.dispatch({ type: 'collectAll', machine: m.id }).ok, false);
  assert.deepEqual(session.game.state, before);
  assert.equal(saver.source(), primary);
  fail = false;
  assert.equal(session.retrySave(), true);
  assert.equal(session.game.state.husbandry!.feedReceived, true);
  assert.equal(session.game.quantity('farm40:chicken-feed'), before.inventory['farm40:chicken-feed'] + 3);
  assert.equal(session.game.quantity('farm40:cow-feed'), before.inventory['farm40:cow-feed'] + 3);
  const once = clone(session.game.state);
  assert.equal(session.dispatch({ type: 'collectAll', machine: m.id }).ok, false);
  assert.deepEqual(session.game.state, once);
});

test('pre-upgrade v6 saves preserve jobs, IDs, crops, wallet and old moved buildings while new sites move around them', () => {
  for (const newSite of ['pen:14', 'pen:15', 'industry-loom']) {
    const old = new FarmGame(baseline);
    old.state.coins = 1000;
    old.state.inventory = { 'raw:1': 10, 'farm40:chicken-feed': 1 };
    ok(old.plant(0, 1));
    ok(old.produce(7));
    ok(old.feedAnimals(12));
    delete old.state.husbandry;
    old.state.harvested = 3;
    old.state.produced['farm40:chicken-feed'] = 3;
    old.state = historicalState(old.state);
    old.state.buildingLayout = {
      version: 2,
      positions: { 'bakery-1': clone(FARM_LAYOUT.buildings.find(b => b.id === newSite)!.position) },
    };
    assertBeforeTownBuildingLayout(old.state.buildingLayout);
    const before = clone(old.state),
      source = JSON.stringify(farmPack(before, settings)) + '  \n';
    const data = new Map([[SIMPLE_FARM_KEY, source]]),
      saver = new FarmSave(
        {
          getItem: k => data.get(k) ?? null,
          setItem: (k, v) => {
            data.set(k, v);
          },
        },
        catalog
      );
    const migrated = saver.load()!;
    const game = new FarmGame(catalog, migrated.free);
    assert.equal(
      game.penUnlockStatus(14).reason,
      `Cần level ${catalog.residentPens!.find(site => site.plotId === 14)!.requiredLevel}`
    );
    assert.ok(
      game.state.husbandry!.feedReceived && game.state.husbandry!.eggsCollected && game.state.husbandry!.milkCollected
    );
    for (const key of [
      'coins',
      'diamonds',
      'inventory',
      'plots',
      'machines',
      'nextId',
      'xp',
      'time',
      'produced',
    ] as const)
      assert.deepEqual(historicalState(game.state)[key], before[key], key);
    assert.deepEqual(game.state.buildingLayout!.positions['bakery-1'], before.buildingLayout!.positions['bakery-1']);
    assert.ok(game.state.buildingLayout!.positions[newSite]);
    assert.equal(groundError(game.state.buildingLayout!, PREVIOUS_SINGLE_BUILDING_LAYOUT), null);
    assert.equal(game.state.plots[14].residents, null);
    assert.equal(game.state.plots[15].residents, null);
    assert.equal(game.state.machines[0].job!.duration, 19);
    assert.equal(game.state.plots[0].snapshot!.duration, 102);
    saver.save(farmPack(game.state, settings));
    assert.equal(data.get(SIMPLE_FARM_KEY + '.before-town-husbandry'), source);
    assert.deepEqual(saver.load()!.free, game.state);
    assert.deepEqual(new FarmGame(catalog, game.state).state, game.state);
  }
});

test('the historical twelve-animal feed budget and current twenty-animal demand remain explicit while manufacturing retains a positive margin', () => {
  const g = new FarmGame(catalog);
  let perSpeciesAnimalUtilization = 0;
  for (const a of catalog.livestock!) {
    const r = catalog.products.find(r => recipeOutputs(r).some(o => o.key === a.feed))!;
    perSpeciesAnimalUtilization += r.duration / (recipeOutputs(r)[0].quantity * a.duration);
    assert.ok(g.item(a.output)!.sellPrice > g.item(a.feed)!.sellPrice, a.key);
  }
  assert.ok(3 * perSpeciesAnimalUtilization < 0.85, 'the historical three animals per species fit one feed mill');
  assert.equal(PEN_CAPACITY_LIMIT * catalog.livestock!.length, 20);
  const fullHerdUtilization = PEN_CAPACITY_LIMIT * perSpeciesAnimalUtilization;
  assert.ok(
    fullHerdUtilization > 0.76 && fullHerdUtilization < 0.77,
    'one mill can sustain twenty animals; two mills cover forty'
  );
  for (const r of catalog.products) {
    const cost = recipeInputs(r).reduce((n, q) => n + g.item(q.key)!.sellPrice * q.quantity, 0);
    const revenue = recipeOutputs(r).reduce((n, q) => n + g.item(q.key)!.sellPrice * q.quantity, 0);
    assert.ok(revenue > cost, r.name);
    assert.ok((revenue - cost) / cost >= 0.15, r.name + ' must reward processing its inputs');
  }
});

test('migration reserves three old custom factories and repairs newly enlarged conflicts while adding the new sites', () => {
  const old = new FarmGame(baseline);
  delete old.state.husbandry;
  const pairs = [
    ['bakery-1', 'pen:14'],
    ['dairy-1', 'pen:15'],
    ['feed-1', 'industry-loom'],
  ];
  const positions = Object.fromEntries(
    pairs.map(([machine, site]) => [machine, clone(FARM_LAYOUT.buildings.find(b => b.id === site)!.position)])
  );
  old.state = historicalState(old.state);
  old.state.buildingLayout = { version: 2, positions };
  assertBeforeTownBuildingLayout(old.state.buildingLayout);
  const migrated = new FarmGame(catalog, old.state);
  for (const [machine, site] of pairs) {
    if (machine === 'dairy-1') {
      assert.notDeepEqual(
        migrated.state.buildingLayout!.positions[machine],
        positions[machine],
        'dairy now overlaps the enlarged saved bakery and must move'
      );
      assert.equal(
        migrated.state.buildingLayout!.positions[site],
        undefined,
        'the freed sheep default can stay where authored'
      );
    } else {
      assert.deepEqual(migrated.state.buildingLayout!.positions[machine], positions[machine]);
      assert.ok(migrated.state.buildingLayout!.positions[site]);
    }
  }
  assert.equal(groundError(migrated.state.buildingLayout!, PREVIOUS_SINGLE_BUILDING_LAYOUT), null);
  assert.equal(migrated.state.coins, 500);
  assert.deepEqual(migrated.state.inventory, {});
  assert.deepEqual(historicalState(migrated.state).plots, old.state.plots);
  assert.deepEqual(migrated.state.machines, old.state.machines);
});

test('new pen and loom defaults do not intersect fixed decoration ground contacts', () => {
  for (const building of FARM_LAYOUT.buildings.filter(b => ['pen:14', 'pen:15', 'industry-loom'].includes(b.id))) {
    for (const footprint of building.footprints.map(p => translated(p, building.position))) {
      for (const prop of FARM_LAYOUT.decor)
        assert.equal(overlaps(footprint, prop.polygon), false, building.id + ' overlaps ' + prop.id);
    }
  }
});
