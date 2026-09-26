import { establishFarm } from './fixtures/established-farm';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import { historicalState } from './fixtures/historical-state';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import type { FarmState } from '../assets/farm/scripts/core/types/StateTypes';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import { cropItemKey, recipeInputs, recipeOutputs } from '../assets/farm/scripts/core/FarmCatalog';
import { progression, xpToNext } from '../assets/farm/scripts/core/Progression';
const catalog: FarmCatalog = loadFarmCatalog();
const oldCatalog: FarmCatalog = JSON.parse(
  fs.readFileSync(path.join(__dirname, 'fixtures/single-building-v6.json'), 'utf8')
);
const copy = <T>(v: T): T => JSON.parse(JSON.stringify(v));
const xpFor = (level: number) =>
  Array.from({ length: level - 1 }, (_, i) => xpToNext(i + 1, catalog.economy!.experience.curve)).reduce(
    (a, b) => a + b,
    0
  );
function setup(state?: FarmState) {
  let clock = 1800000000000,
    fail = false;
  const data = new Map<string, string>();
  if (state) data.set(SIMPLE_FARM_KEY, JSON.stringify(farmPack(state, { speed: 12, sound: false, music: false })));
  const saver = new FarmSave(
    {
      getItem: k => data.get(k) ?? null,
      setItem: (k, v) => {
        if (fail && k === SIMPLE_FARM_KEY) throw Error('quota');
        data.set(k, v);
      },
    },
    catalog
  );
  const now = () => clock;
  return {
    data,
    saver,
    now,
    advance: (seconds: number) => {
      clock += seconds * 1000;
    },
    fail: (value: boolean) => {
      fail = value;
    },
    session: () => new GameSession(catalog, saver, now),
  };
}
const ok = (result: { error?: string }) => assert.equal(result.error, undefined, result.error);

test('crop unlocks use exact levels in core; failed or repeated attempts cannot spend coins or farm planting XP', () => {
  const expected = [
    [1, 1, 300, 20, 8, 2],
    [10, 1, 900, 30, 14, 3],
    [11, 4, 2700, 45, 23, 5],
    [1010, 7, 7200, 65, 35, 8],
    [1128, 10, 14400, 90, 52, 12],
    [4, 14, 21600, 120, 76, 16],
    [1129, 18, 28800, 160, 104, 20],
    [3, 24, 43200, 220, 150, 26],
  ];
  for (const [id, level, duration, price, sale, xp] of expected) {
    const g = new FarmGame(catalog),
      crop = g.farm(id)!;
    assert.deepEqual(
      [crop.requiredLevel, crop.duration, crop.price, g.item(cropItemKey(crop))!.sellPrice, crop.harvestXP],
      [level, duration, price, sale, xp]
    );
    if (level > 1) {
      g.state.xp = xpFor(level) - 1;
      const before = copy(g.state);
      assert.equal(g.plant(0, id).error, `Cần level ${level}`);
      assert.deepEqual(g.state, before);
    }
    g.state.xp = xpFor(level);
    const before = g.state.xp;
    ok(g.plant(0, id));
    assert.equal(g.state.xp, before);
    assert.equal(g.state.plots[0].ready, duration);
    g.tick(duration - 1);
    assert.ok(g.harvest(0).error);
    g.tick(1);
    ok(g.harvest(0));
    assert.equal(g.state.xp, before + xp);
    assert.equal(g.quantity(cropItemKey(crop)), 3);
    ok(g.plant(0, id));
    ok(g.cancel(0));
    assert.equal(g.state.xp, before + xp);
  }
  const curve = catalog.economy!.experience.curve;
  assert.equal(progression(xpFor(10), curve).level, 10);
  assert.equal(progression(xpFor(10) - 1, curve).level, 9);
  assert.equal(progression(xpFor(24), curve).level, 24);
});

test('every processed batch and animal cycle adds value; later crops pay more per visit without dominating short-crop hourly income', () => {
  const g = new FarmGame(catalog),
    sorted = [...catalog.farm].sort((a, b) => a.requiredLevel! - b.requiredLevel!);
  let previousDuration = 0,
    previousProfit = 0;
  const sources = new Map(sorted.map(f => [cropItemKey(f), f.requiredLevel!]));
  for (const f of sorted) {
    const profit = g.item(cropItemKey(f))!.sellPrice * f.yields[0] - f.price;
    assert.ok(f.duration > previousDuration);
    assert.ok(profit > previousProfit);
    assert.ok(profit / f.duration <= 4 / 300 + 1e-10);
    previousDuration = f.duration;
    previousProfit = profit;
  }
  for (const a of catalog.livestock!) {
    const firstPen = catalog.residentPens!.find(site => site.species === a.key && site.ordinal === 1)!;
    const feed = catalog.products.find(recipe => recipeOutputs(recipe).some(output => output.key === a.feed))!;
    sources.set(a.output, Math.max(firstPen.requiredLevel!, feed.requiredLevel!));
  }
  for (const r of catalog.products) for (const o of recipeOutputs(r)) sources.set(o.key, r.requiredLevel!);
  for (const r of catalog.products) {
    const input = recipeInputs(r).reduce((sum, q) => sum + g.item(q.key)!.sellPrice * q.quantity, 0);
    const output = recipeOutputs(r).reduce((sum, q) => sum + g.item(q.key)!.sellPrice * q.quantity, 0);
    assert.ok(output >= input * 1.15, r.name);
    assert.ok(r.requiredLevel! >= catalog.machineTypes!.find(m => m.id === r.machine)!.buildSites![0].requiredLevel);
    for (const i of recipeInputs(r)) assert.ok(r.requiredLevel! >= sources.get(i.key)!, r.name + ' ingredient gate');
    assert.ok(r.xp! <= 42, r.name + ' XP outlier');
  }
  let demand = 0;
  for (const a of catalog.livestock!) {
    assert.ok(g.item(a.output)!.sellPrice > g.item(a.feed)!.sellPrice);
    const feed = catalog.products.find(r => recipeOutputs(r).some(o => o.key === a.feed))!;
    demand += (10 * feed.duration) / (recipeOutputs(feed)[0].quantity * a.duration);
  }
  assert.ok(demand < 2, 'both mills can continuously supply all 40 animals');
});

test('sales carry fractional XP across transactions, inventory types and reloads', () => {
  const state = new FarmGame(catalog).state;
  state.inventory = { 'raw:1': 30, 'farm40:egg': 7 };
  state.earned = 97;
  const bulk = new FarmGame(catalog, state);
  ok(bulk.sellItem('raw:1', 30));
  ok(bulk.sellItem('farm40:egg', 7));
  let single = new FarmGame(catalog, state);
  for (const [key, count] of [
    ['raw:1', 30],
    ['farm40:egg', 7],
  ] as const)
    for (let i = 0; i < count; i++) {
      ok(single.sellItem(key));
      single = new FarmGame(catalog, copy(single.state));
    }
  assert.deepEqual(single.state, bulk.state);
  assert.equal(single.state.xp, 5);
});

test('offline reload finishes only queued/paid work, and reloading or collecting twice cannot duplicate rewards', () => {
  const store = setup(),
    s = store.session();
  establishFarm(s.game);
  s.game.state.xp = xpFor(s.game.product(7)!.requiredLevel!);
  s.game.state.inventory = { 'raw:1': 10, 'farm40:chicken-feed': 1 };
  assert.equal(s.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, true);
  assert.equal(s.dispatch({ type: 'expandQueue', machine: 0 }).ok, true);
  for (let i = 0; i < 2; i++) assert.equal(s.dispatch({ type: 'produce', recipe: 7, machine: 0 }).ok, true);
  assert.equal(s.dispatch({ type: 'feedAnimals', plot: 12 }).ok, true);
  const before = copy(s.game.state),
    inventory = copy(before.inventory),
    diamonds = before.diamonds;
  store.advance(86400 * 7);
  const resumed = store.session(),
    r = resumed.game;
  assert.equal(resumed.speed, 1);
  assert.equal(r.state.time, 604800);
  assert.equal(r.isReady(r.state.plots[0]), true);
  assert.equal(r.state.machines[0].tray.length, 2);
  assert.equal(r.state.machines[0].job, null);
  assert.deepEqual(r.state.inventory, inventory);
  assert.equal(r.state.diamonds, diamonds);
  assert.equal(r.state.xp, before.xp);
  assert.equal(r.state.plots[12].residents!.animals.length, 1);
  const settled = copy(r.state);
  assert.deepEqual(store.session().game.state, settled);
  assert.equal(resumed.dispatch({ type: 'collectAll', machine: 0 }).ok, true);
  assert.equal(resumed.dispatch({ type: 'collectAnimals', plot: 12 }).ok, true);
  assert.equal(resumed.dispatch({ type: 'harvest', plot: 0 }).ok, true);
  const collected = copy(resumed.game.state);
  assert.equal(resumed.dispatch({ type: 'collectAll', machine: 0 }).ok, false);
  assert.equal(resumed.dispatch({ type: 'collectAnimals', plot: 12 }).ok, false);
  assert.equal(resumed.dispatch({ type: 'harvest', plot: 0 }).ok, false);
  assert.deepEqual(store.session().game.state, collected);
});

test('full output trays stop offline queues until a collection creates room', () => {
  const g = establishFarm(new FarmGame(catalog));
  g.state.coins = 10000;
  g.state.xp = xpFor(g.product(7)!.requiredLevel!);
  g.state.inventory = { 'raw:1': 30 };
  while (g.state.machines[0].capacity < 5) ok(g.expandQueue(0));
  for (let i = 0; i < 5; i++) ok(g.produce(7, 0));
  g.tick(3000);
  for (let i = 0; i < 5; i++) ok(g.produce(7, 0));
  const store = setup(g.state),
    s = store.session();
  s.save();
  store.advance(86400);
  const resumed = store.session();
  assert.equal(resumed.game.state.machines[0].tray.length, 5);
  assert.equal(resumed.game.state.machines[0].waiting.length, 5);
  assert.equal(resumed.game.state.machines[0].job, null);
  assert.equal(resumed.dispatch({ type: 'collectAll', machine: 0 }).ok, true);
  assert.equal(resumed.game.state.machines[0].job!.started, resumed.game.state.time);
  store.advance(600);
  resumed.tick(600);
  assert.equal(resumed.game.state.machines[0].tray.length, 1);
});

test('hide/show, explicit pause and backwards clocks settle each interval once', () => {
  const store = setup(),
    s = store.session();
  assert.equal(s.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, true);
  store.advance(60);
  s.tick(60);
  assert.equal(s.game.state.time, 60);
  s.suspend();
  store.advance(120);
  s.tick(120);
  assert.equal(s.game.state.time, 60);
  s.resume();
  assert.equal(s.game.state.time, 180);
  s.resume();
  assert.equal(s.game.state.time, 180);
  s.togglePause();
  s.suspend();
  store.advance(60);
  s.resume();
  assert.equal(s.game.state.time, 240, 'a pause never stops real time, like Hay Day');
  s.togglePause();
  store.advance(-300);
  s.tick(1);
  assert.equal(s.game.state.time, 240, 'a clock moved backwards replays nothing');
  store.advance(330);
  s.tick(1);
  assert.equal(s.game.state.time, 270);
  store.advance(30);
  s.tick(30);
  assert.equal(s.game.isReady(s.game.state.plots[0]), true);
});

test('input between frames starts a paid job at the current wall clock', () => {
  const store = setup(),
    s = store.session();
  store.advance(1200);
  assert.equal(s.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, true);
  assert.equal(s.game.state.time, 1200);
  assert.equal(s.game.state.plots[0].ready, 1500);
  const resumed = store.session();
  assert.equal(resumed.game.isReady(resumed.game.state.plots[0]), false);
  store.advance(299);
  resumed.tick(299);
  assert.equal(resumed.game.isReady(resumed.game.state.plots[0]), false);
  store.advance(1);
  resumed.tick(1);
  assert.equal(resumed.game.isReady(resumed.game.state.plots[0]), true);
});

test('pause, menu and layout block input but keep the clock running, also across a reload', () => {
  for (const mode of ['pause', 'menu', 'layout'] as const) {
    const store = setup(),
      s = store.session();
    assert.equal(s.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, true);
    store.advance(60);
    if (mode === 'pause') s.togglePause();
    else if (mode === 'menu') s.enterMenu();
    else assert.equal(s.beginLayout(), true);
    assert.equal(s.canAct, false, mode);
    assert.equal(s.dispatch({ type: 'harvest', plot: 0 }).result.error, s.blockedMessage, mode);
    assert.equal(store.saver.load()!.clock!.running, true, mode);
    store.advance(240);
    s.tick(1);
    assert.equal(s.game.isReady(s.game.state.plots[0]), true, mode);
    assert.equal(store.session().game.isReady(s.game.state.plots[0]), true, mode);
    if (mode === 'pause') s.togglePause();
    else if (mode === 'menu') s.leaveMenu();
    else s.endLayout();
    assert.equal(store.saver.load()!.clock!.running, true);
    assert.equal(s.dispatch({ type: 'harvest', plot: 0 }).ok, true, mode);
  }
});

test('a delayed save retry commits once and skips the interval spent paused by the failure', () => {
  const store = setup(),
    s = store.session();
  assert.equal(s.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, true);
  store.advance(60);
  store.fail(true);
  s.suspend();
  assert.equal(s.storageFailed, true);
  assert.equal(s.pendingPack!.free.time, 60);
  store.advance(1200);
  store.fail(false);
  assert.equal(s.retrySave(), true);
  const resumed = store.session();
  assert.equal(resumed.game.state.time, 60);
  assert.equal(resumed.game.isReady(resumed.game.state.plots[0]), false);
  store.advance(240);
  resumed.tick(240);
  assert.equal(resumed.game.isReady(resumed.game.state.plots[0]), true);
});

test('old saves do not invent offline elapsed time or replace paid snapshots; old speed becomes real time', () => {
  const old = new FarmGame(oldCatalog);
  old.state.coins = 10000;
  ok(old.plant(0, 3));
  old.state.inventory = { 'raw:1': 4 };
  ok(old.produce(7, 0));
  const snapshot = copy(old.state.plots[0].snapshot),
    job = copy(old.state.machines[0].job);
  const historical = historicalState(old.state);
  const store = setup(historical),
    s = store.session();
  assert.equal(s.speed, 1);
  assert.equal(s.recovered, false);
  assert.deepEqual(historicalState(s.game.state), historical);
  assert.deepEqual(s.game.state.plots[0].snapshot, snapshot);
  assert.deepEqual(s.game.state.machines[0].job, job);
  s.save();
  store.advance(102);
  const resumed = store.session();
  assert.equal(resumed.game.isReady(resumed.game.state.plots[0]), true);
  assert.equal(resumed.dispatch({ type: 'harvest', plot: 0 }).ok, true);
  assert.equal(resumed.game.quantity('raw:3'), snapshot!.output.quantity);
  assert.equal(
    resumed.dispatch({ type: 'plant', plot: 0, crop: 3 }).ok,
    false,
    'future planting follows the new level gate'
  );
});

test('import preserves the supplied source and settles its paid work only once', () => {
  const store = setup(),
    s = store.session();
  assert.equal(s.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, true);
  const source = s.exportText();
  store.advance(120);
  s.importText(source);
  assert.equal(store.data.get(SIMPLE_FARM_KEY + '.import-source'), source);
  assert.equal(s.game.state.time, 120);
  assert.equal(s.game.state.plots[0].ready, 300);
  assert.deepEqual(store.session().game.state, s.game.state);
  store.advance(180);
  s.tick(180);
  assert.equal(s.game.isReady(s.game.state.plots[0]), true);
  assert.equal(s.game.quantity('raw:1'), 0);
});

test('offline save failures keep visible jobs and source intact; retry publishes once and imports reject malformed clocks', () => {
  const store = setup(),
    s = store.session();
  assert.equal(s.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, true);
  const before = copy(s.game.state),
    source = store.saver.source();
  store.advance(600);
  store.fail(true);
  const resumed = store.session();
  assert.equal(resumed.storageFailed, true);
  assert.deepEqual(resumed.game.state, before);
  assert.equal(store.saver.source(), source);
  const pending = copy(resumed.pendingPack!);
  assert.equal(pending.free.time, 600);
  assert.equal(resumed.retrySave(), false);
  store.fail(false);
  assert.equal(resumed.retrySave(), true);
  assert.deepEqual(resumed.game.state, pending.free);
  assert.deepEqual(store.session().game.state, pending.free);
  for (const clock of [
    { version: 2, savedAt: 1, running: true },
    { version: 1, savedAt: -1, running: true },
    { version: 1, savedAt: 1.5, running: true },
    { version: 1, savedAt: 1, running: 'yes' },
  ]) {
    const bad = { ...pending, clock },
      bytes = [...store.data];
    assert.throws(() => store.saver.importText(JSON.stringify(bad)), /Đồng hồ/);
    assert.deepEqual([...store.data], bytes);
  }
});
