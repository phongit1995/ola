import assert from 'node:assert/strict';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { FarmGame, orderedCrops } from '../assets/farm/scripts/core/FarmGame';
import { FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave } from '../assets/farm/scripts/core/FarmSave';
import type { FarmPack } from '../assets/farm/scripts/core/types/SaveTypes';
import { FarmModel } from '../assets/farm/scripts/map/FarmModel';
import { sampleClip } from '../assets/farm/scripts/core/Clip';
const assets = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../assets/resources/ported/game.json'), 'utf8'));
const previous = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'fixtures/farm-before-cleanup.json'), 'utf8'));
const pack = (game = new FarmGame(assets.data)): FarmPack => ({
  version: 2,
  current: 'free',
  free: game.state,
  settings: { speed: 1, sound: false, music: false },
});
const clone = <T>(value: T): T => JSON.parse(JSON.stringify(value));
const emptyFarm = () => {
  const g = new FarmGame(assets.data);
  g.state.coins = 100000;
  for (const p of g.state.plots)
    Object.assign(p, {
      crop: null,
      unlocked: true,
      started: 0,
      ready: 0,
      boosted: false,
      snapshot: null,
      residents: null,
    });
  return g;
};

test('starter has 40 open fields, six pens, four pond slots, distinct stable IDs and the intended wallet', () => {
  const game = new FarmGame(assets.data),
    s = game.state;
  assert.equal(s.coins, 500);
  assert.equal(s.diamonds, 10);
  assert.deepEqual(
    ['crop', 'pen', 'pond'].map(group => s.plots.filter(p => p.group === group).length),
    [40, 6, 4]
  );
  assert.deepEqual(
    ['crop', 'pen', 'pond'].map(group => s.plots.filter(p => p.group === group && p.unlocked).length),
    [40, 3, 2]
  );
  assert.equal(new Set(s.plots.map(p => p.id)).size, 50);
  assert.deepEqual(new FarmGame(assets.data, s).state, s);
  assert.equal('orders' in s, false);
  assert.equal('mission' in s, false);
});

test('all 40 fields grow and harvest without changing persistent IDs', () => {
  const game = emptyFarm(),
    crops = orderedCrops(game.state.plots),
    ids = crops.map(p => p.id);
  for (const p of crops) assert.equal(game.plant(p.id, 1).error, undefined);
  game.tick(game.farm(1)!.duration);
  const raw = game.state.inventory['raw:1'] || 0;
  for (const p of crops) assert.equal(game.harvest(p.id).error, undefined);
  assert.equal(game.state.inventory['raw:1'] - raw, 40 * game.farm(1)!.yields[0]);
  assert.deepEqual(
    orderedCrops(new FarmGame(assets.data, game.state).state.plots).map(p => p.id),
    ids
  );
});

test('nine breeds at four plot levels charge, grow through three stages and yield once', () => {
  for (let level = 1; level <= 4; level++)
    for (const f of assets.data.farm) {
      const game = emptyFarm(),
        p = game.state.plots.find(p => p.group === f.group)!;
      p.level = level;
      const coins = game.state.coins,
        raw = game.state.inventory[`raw:${f.id}`] || 0,
        xp = game.state.xp;
      assert.equal(game.plant(p.id, f.id).error, undefined);
      assert.equal(game.state.coins, coins - f.price);
      const after = clone(game.state);
      assert.ok(game.plant(p.id, f.id).error);
      assert.deepEqual(game.state, after);
      assert.equal(game.growthStage(p), 1);
      game.tick(f.duration / 2);
      assert.equal(game.growthStage(p), 2);
      game.tick(f.duration / 2);
      assert.equal(game.growthStage(p), 3);
      assert.equal(game.harvest(p.id).amount, f.yields[level - 1]);
      assert.equal(game.state.inventory[`raw:${f.id}`], raw + f.yields[level - 1]);
      assert.equal(game.state.xp, xp + 2 + 3 * f.yields[level - 1]);
      const harvested = clone(game.state);
      assert.ok(game.harvest(p.id).error);
      assert.deepEqual(game.state, harvested);
    }
});

test('invalid placement, locked plots and insufficient funds never charge', () => {
  const game = emptyFarm(),
    p = game.state.plots[0];
  for (const [id, crop] of [
    [-1, 1],
    [0, 999],
    [0, 5],
  ]) {
    const before = clone(game.state);
    assert.ok(game.plant(id, crop).error);
    assert.deepEqual(game.state, before);
  }
  p.unlocked = false;
  assert.ok(game.plant(p.id, 1).error);
  p.unlocked = true;
  game.state.coins = 0;
  const before = clone(game.state);
  assert.ok(game.plant(p.id, 1).error);
  assert.deepEqual(game.state, before);
});

test('boost and cancellation settle once; refunds do not count as sales', () => {
  const g = emptyFarm(),
    p = g.state.plots[0];
  g.plant(p.id, 1);
  // One gem per started minute of waiting, and the plot is ripe at once, so a second boost is refused.
  assert.equal(g.boostPrice(p), 2);
  assert.equal(g.boost(p.id).error, undefined);
  assert.equal(g.state.diamonds, 8);
  assert.ok(g.isReady(p));
  assert.ok(g.boost(p.id).error);
  assert.equal(g.state.diamonds, 8);
  g.tick(0.5);
  assert.ok(g.isReady(p));
  assert.ok(g.cancel(p.id).error);
  g.harvest(p.id);
  g.plant(p.id, 1);
  const coins = g.state.coins,
    earned = g.state.earned;
  assert.equal(g.cancel(p.id).coins, Math.floor(g.farm(1)!.price * 0.3));
  assert.equal(g.state.coins, coins + 6);
  assert.equal(g.state.earned, earned);
  assert.ok(g.cancel(p.id).error);
});

test('unlocking existing pen/pond slots costs one diamond and cannot repeat', () => {
  const g = new FarmGame(assets.data),
    p = g.state.plots.find(p => !p.unlocked)!;
  assert.equal(g.improve(p.id).error, undefined);
  assert.equal(g.state.diamonds, 9);
  assert.ok(p.unlocked);
  assert.ok(g.improve(p.id).error);
  assert.equal(g.state.diamonds, 9);
  const next = g.state.plots.find(p => !p.unlocked)!;
  g.state.diamonds = 0;
  assert.ok(g.improve(next.id).error);
  assert.equal(next.unlocked, false);
});

test('all sixteen recipes consume exact inputs and complete, collect and sell once', () => {
  for (const r of assets.data.products) {
    const g = emptyFarm();
    for (const f of g.catalog.farm) g.state.inventory[`raw:${f.id}`] = 100;
    const before = clone(g.state.inventory);
    assert.equal(g.produce(r.id).error, undefined);
    for (const f of g.catalog.farm)
      assert.equal(
        g.state.inventory[`raw:${f.id}`],
        before[`raw:${f.id}`] - (r.ingredients.find((i: any) => i.id === f.id)?.quantity || 0)
      );
    const m = g.state.machines.find(m => m.job?.product === r.id)!;
    const busy = clone(g.state);
    assert.ok(g.produce(r.id).error);
    assert.ok(g.collect(m.id).error);
    assert.deepEqual(g.state, busy);
    g.tick(r.duration);
    const stock = g.state.inventory[`goods:${r.id}`] || 0;
    assert.equal(g.collect(m.id).error, undefined);
    assert.equal(g.state.inventory[`goods:${r.id}`], stock + 1);
    assert.ok(g.collect(m.id).error);
    const coins = g.state.coins;
    assert.equal(g.sellItem(`goods:${r.id}`, stock + 1).coins, r.price * (stock + 1));
    assert.equal(g.state.coins, coins + r.price * (stock + 1));
    const sold = clone(g.state);
    assert.ok(g.sellItem(`goods:${r.id}`, 1).error);
    assert.deepEqual(g.state, sold);
  }
});

test('failed production and malformed sale requests preserve the wallet and inventory', () => {
  const g = emptyFarm();
  g.state.inventory = { 'goods:7': 1 };
  const before = clone(g.state);
  assert.ok(g.produce(7).error);
  assert.ok(g.produce(999).error);
  for (const quantity of [0, -1, 0.5, NaN, Infinity]) assert.ok(g.sellItem('goods:7', quantity).error);
  assert.ok(g.sellItem('invalid:1', 1).error);
  assert.ok(g.sellItem('raw:999', 1).error);
  assert.deepEqual(g.state, before);
});

test('time has no campaign deadline and rejects invalid deltas', () => {
  const g = emptyFarm();
  g.tick(100000);
  assert.equal(g.state.time, 100000);
  for (const dt of [-1, 0, NaN, Infinity]) g.tick(dt);
  assert.equal(g.state.time, 100000);
});

test('pre-cleanup Farm save retains wallet, crops, IDs, inventory and pending production', () => {
  const original = clone(previous),
    g = new FarmGame(assets.data, previous.free);
  for (const key of ['coins', 'diamonds', 'xp', 'time', 'earned', 'harvested', 'sold'] as const)
    assert.deepEqual(g.state[key], previous.free[key], key);
  for (const tab of ['raw', 'goods'] as const)
    for (const [id, n] of Object.entries(previous.free[tab])) assert.equal(g.quantity(`${tab}:${id}`), n);
  for (const p of previous.free.plots)
    for (const [k, v] of Object.entries(p)) assert.deepEqual((g.state.plots.find(n => n.id === p.id) as any)[k], v);
  for (const m of previous.free.machines) {
    const next = g.state.machines.find(n => n.id === m.id)!;
    assert.equal(next.type, m.type);
    if (m.job) {
      assert.equal(next.job?.product, m.job.product);
      assert.equal(next.job?.ready, m.job.ready);
    }
  }
  assert.deepEqual(previous, original);
  assert.equal('mission' in g.state, false);
  const remaining = g.state.machines[0].job!.ready - g.state.time;
  g.tick(remaining);
  assert.equal(g.collect(0).error, undefined);
});

test('save roundtrip, source/backup retention and separate storage keys', () => {
  const store = new Map<string, string>([['happy-farm-cocos-js-v1', 'untouched']]);
  const saver = new FarmSave(
    {
      getItem: k => store.get(k) ?? null,
      setItem: (k, v) => {
        store.set(k, v);
      },
    },
    assets.data
  );
  const source = JSON.stringify(previous);
  saver.importText(source);
  assert.equal(store.get(FARM_KEY + '.import-source'), source);
  assert.equal(store.get('happy-farm-cocos-js-v1'), 'untouched');
  const loaded = saver.load()!,
    before = store.get(FARM_KEY);
  saver.save(loaded);
  assert.equal(store.get(FARM_KEY + '.backup'), before);
  assert.deepEqual(saver.load(), loaded);
  assert.deepEqual(saver.parse(JSON.stringify(pack())), pack());
});

test('corrupt, incompatible and unmappable saves are rejected before any writes', () => {
  const store = new Map<string, string>(),
    saver = new FarmSave(
      {
        getItem: k => store.get(k) ?? null,
        setItem: (k, v) => {
          store.set(k, v);
        },
      },
      assets.data
    );
  saver.save(pack());
  const mutations = [
    (p: any) => (p.current = 'mission'),
    (p: any) => (p.free.version = 1),
    (p: any) => p.free.plots.pop(),
    (p: any) => p.free.plots.push({ ...p.free.plots[0], id: 900, cell: null }),
    (p: any) => (p.free.plots[49].group = 'pond'),
    (p: any) => (p.free.plots[49].id = 0),
    (p: any) => (p.free.inventory = []),
    (p: any) => (p.free.coins = -1),
    (p: any) => (p.free.plots[0].crop = 999),
    (p: any) => (p.free.machines[0].job = { product: 7, ready: 30 }),
    (p: any) => (p.free.machines[0].job = { product: 12, started: 0, ready: 30 }),
    (p: any) => (p.free.machines[0].id = -1),
    (p: any) => (p.settings.speed = 99),
  ];
  for (const mutate of mutations) {
    const value: any = pack();
    mutate(value);
    const before = new Map(store);
    assert.throws(() => saver.importText(JSON.stringify(value)));
    assert.deepEqual(store, before);
  }
  store.set(FARM_KEY, '{broken');
  assert.throws(() => saver.load());
  assert.throws(() => saver.save(pack()));
  assert.equal(store.get(FARM_KEY), '{broken');
  saver.importText(JSON.stringify(pack()));
  assert.equal(store.get(FARM_KEY + '.before-import'), '{broken');
});

test('failed storage writes preserve the good primary save', () => {
  const store = new Map<string, string>();
  let fail = false;
  const saver = new FarmSave(
    {
      getItem: k => store.get(k) ?? null,
      setItem: (k, v) => {
        if (fail && k === FARM_KEY) throw Error('quota');
        store.set(k, v);
      },
    },
    assets.data
  );
  saver.save(pack());
  const before = store.get(FARM_KEY),
    next = pack();
  next.free.coins = 999;
  fail = true;
  assert.throws(() => saver.save(next));
  assert.equal(store.get(FARM_KEY), before);
});

test('authored bed positions reach the runtime geometry', () => {
  const prefab = JSON.parse(
    fs.readFileSync(path.resolve(__dirname, '../assets/farm/prefabs/map/scenes.prefab'), 'utf8')
  );
  const fields = prefab
    .find((o: any) => o.__type__ === 'cc.Node' && o._name === 'Fields')
    ._children.map((r: any) => prefab[r.__id__]);
  assert.equal(fields.length, 40);
  assert.equal(new Set(fields.map((n: any) => n._name)).size, 40);
  const cells = fields
    .map((n: any) => ({ ...assets.scene.cells[0], matrix: [1, 0, 0, 1, n._lpos.x, n._lpos.y] }))
    .concat(assets.scene.cells.slice(12));
  cells[39].matrix[4] += 27;
  const g = new FarmGame(assets.data),
    model = new FarmModel(assets.scene, assets.runtime, () => g, cells, {
      left: -1700,
      right: 1800,
      bottom: -1200,
      top: 1150,
    });
  const last = model.plotPositions().find(p => p.plot.id === orderedCrops(g.state.plots)[39].id)!;
  assert.equal(last.x, fields[39]._lpos.x + 27);
  assert.equal(model.plotWidgets(last)[0].matrix[4], last.x);
});

test('UI cubic clips preserve their authored keyframes and closing poses', () => {
  for (const clip of [...Object.values(assets.ui.menuMotion), ...Object.values(assets.panels.storageMotion)] as any[]) {
    for (const frame of clip.frames)
      for (const [id, , , , value] of frame.keys) assert.equal(sampleClip(clip, frame.time, [])[id], value);
    assert.deepEqual(sampleClip(clip, clip.duration + 100, []), sampleClip(clip, clip.duration, []));
  }
});
