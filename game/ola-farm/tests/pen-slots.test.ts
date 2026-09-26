import { addBuildXP, establishFarm, xpForLevel } from './fixtures/established-farm';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import type { ActionResult } from '../assets/farm/scripts/core/types/ActionTypes';
import type { FarmState } from '../assets/farm/scripts/core/types/StateTypes';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import { GameSession } from '../assets/farm/scripts/core/GameSession';

const catalog: FarmCatalog = loadFarmCatalog();
const clone = <T>(value: T): T => JSON.parse(JSON.stringify(value));
const ok = (result: ActionResult) => assert.equal(result.error, undefined, result.error);
const settings = { speed: 6, sound: true, music: false };
function funded() {
  const game = establishFarm(new FarmGame(catalog));
  game.state.coins = 1000000;
  game.state.xp = 100000000;
  game.state.husbandry = {
    version: 1,
    feedReceived: true,
    eggsCollected: true,
    milkCollected: true,
    burgerCollected: true,
  };
  return game;
}
function memory(initial?: FarmState) {
  const data = new Map<string, string>();
  let fail = false;
  if (initial) data.set(SIMPLE_FARM_KEY, JSON.stringify(farmPack(initial, settings)));
  const saver = new FarmSave(
    {
      getItem: key => data.get(key) ?? null,
      setItem: (key, value) => {
        if (fail && key === SIMPLE_FARM_KEY) throw Error('quota');
        data.set(key, value);
      },
    },
    catalog
  );
  return {
    data,
    saver,
    fail: (value: boolean) => {
      fail = value;
    },
  };
}

test('chicken and cow slots use their configured exact XP thresholds, with atomic purchases', () => {
  for (const id of [12, 13]) {
    const g = funded();
    const species = g.residentPlot(id)!.residents!.species;
    for (const [index, config] of catalog.economy!.animals[species].slots.entries()) {
      const slot = index + 1,
        level = config.requiredLevel,
        xp = xpForLevel(g, level);
      g.state.xp = xp - 1;
      assert.deepEqual(g.penSlotUnlockStatus(id, slot), {
        unlocked: false,
        requiredLevel: level,
        reason: `Cần level ${level}`,
      });
      const before = clone(g.state),
        mem = memory(before),
        session = new GameSession(catalog, mem.saver, () => 0),
        bytes = [...mem.data];
      assert.equal(g.expandPen(id, slot).error, `Cần level ${level}`);
      assert.deepEqual(g.state, before, 'blocked purchases preserve coins, capacity, animals and allocated IDs');
      assert.equal(session.dispatch({ type: 'expandPen', plot: id, slot }).ok, false);
      assert.deepEqual(session.game.state, before);
      assert.deepEqual([...mem.data], bytes);
      g.state.xp = xp;
      assert.equal(g.penSlotUnlockStatus(id, slot).unlocked, true);
      const expected = clone(g.state),
        pen = expected.plots.find(p => p.id === id)!.residents!;
      expected.coins -= g.penExpansionPrice(id)!;
      pen.animals.push({ id: expected.nextId++, slot: pen.capacity++, job: null });
      addBuildXP(g, expected, 'penSlot');
      ok(g.expandPen(id, slot));
      assert.deepEqual(g.state, expected);
      assert.ok(g.expandPen(id, slot).error);
      assert.deepEqual(g.state, expected, 'stale clicks never buy the next slot');
    }
  }
});

test('previously purchased chicken and cow slots remain usable at level one after save and import', () => {
  for (const id of [12, 13]) {
    const g = funded();
    while (g.residentPlot(id)!.residents!.capacity < 5) ok(g.expandPen(id));
    g.state.xp = 0;
    const mem = memory(g.state),
      imported = memory();
    const loaded = new FarmGame(catalog, imported.saver.importText(JSON.stringify(mem.saver.load()!)).free);
    assert.deepEqual(loaded.state, g.state);
    const pen = loaded.residentPlot(id)!.residents!,
      type = catalog.livestock!.find(a => a.key === pen.species)!;
    for (let slot = 0; slot < 5; slot++) assert.equal(loaded.penSlotUnlockStatus(id, slot).unlocked, true);
    ok(loaded.sellAnimal(id, pen.animals[4].id));
    ok(loaded.buyAnimal(id, 4));
    loaded.state.inventory[type.feed] = 5;
    ok(loaded.feedAnimals(id));
    loaded.tick(type.duration);
    ok(loaded.collectAnimals(id));
    assert.equal(loaded.quantity(type.output), 5);
    assert.equal(pen.capacity, 5);
    assert.equal(pen.animals.length, 5);
    loaded.validate();
  }
});

test('each of four pens opens paid slots two through five with exactly one animal and preserves active jobs', () => {
  for (const id of [12, 13, 14, 15]) {
    const g = funded();
    if (id >= 14) ok(g.buyPen(id));
    const pen = g.residentPlot(id)!.residents!,
      type = catalog.livestock!.find(a => a.key === pen.species)!;
    assert.equal(pen.capacity, 1);
    assert.equal(pen.animals.length, 1);
    g.state.inventory[type.feed] = 1;
    ok(g.feedAnimals(id));
    const firstJob = clone(pen.animals[0].job);
    for (const fee of [45, 75, 120, 180]) {
      const price = fee + type.price;
      assert.equal(g.penExpansionPrice(id), price);
      g.state.coins = price - 1;
      const blocked = clone(g.state);
      assert.ok(g.expandPen(id).error);
      assert.deepEqual(g.state, blocked, 'insufficient coins never buys half a bundle');
      g.state.coins = price;
      const expected = clone(g.state),
        expectedPen = expected.plots.find(p => p.id === id)!.residents!;
      expected.coins = 0;
      expectedPen.animals.push({ id: expected.nextId++, slot: expectedPen.capacity++, job: null });
      addBuildXP(g, expected, 'penSlot');
      ok(g.expandPen(id));
      assert.deepEqual(
        g.state,
        expected,
        'only the slot, one fresh animal, ID counter, bundle price and build XP change'
      );
      assert.deepEqual(pen.animals[0].job, firstJob);
      assert.equal(g.quantity(type.feed), 0, 'opening a slot does not feed it');
    }
    assert.equal(pen.capacity, 5);
    assert.equal(pen.animals.length, 5);
    assert.equal(g.penExpansionPrice(id), null);
    const full = clone(g.state);
    assert.ok(g.expandPen(id).error);
    assert.ok(g.buyAnimal(id).error);
    assert.deepEqual(g.state, full);
    g.validate();
  }
});

test('old paid capacities one through three keep empty slots, animals, IDs and timers without grants on load', () => {
  for (const capacity of [1, 2, 3]) {
    const old = funded();
    old.state.time = 90;
    old.state.xp = 0;
    const pen = old.residentPlot(12)!.residents!;
    pen.capacity = capacity;
    pen.animals =
      capacity === 1
        ? []
        : [
            {
              id: pen.animals[0].id,
              slot: 0,
              job: { started: 0, ready: 120, output: { key: 'farm40:egg', quantity: 1 }, xp: 3 },
            },
          ];
    if (capacity === 3)
      pen.animals.push({
        id: old.state.nextId++,
        slot: 1,
        job: { started: 0, ready: 60, output: { key: 'farm40:egg', quantity: 1 }, xp: 3 },
      });
    old.validate();
    const before = clone(old.state),
      mem = memory();
    const historical: any = clone(farmPack(before, settings));
    for (const p of historical.free.plots) for (const a of p.residents?.animals ?? []) delete a.slot;
    const raw = JSON.stringify(historical, null, 2) + '  \n';
    mem.data.set(SIMPLE_FARM_KEY, raw);
    const g = new FarmGame(catalog, mem.saver.load()!.free);
    assert.deepEqual(g.state, before, 'a new capacity ceiling is not a reward or migration');
    mem.saver.save(farmPack(g.state, settings));
    assert.equal(mem.saver.backup(), raw);
    assert.equal(mem.data.get(SIMPLE_FARM_KEY + '.before-animal-slots-v1'), raw);
    mem.saver.save(farmPack(g.state, settings));
    assert.equal(mem.data.get(SIMPLE_FARM_KEY + '.before-animal-slots-v1'), raw, 'original bytes are retained once');
    assert.deepEqual(mem.saver.load()!.free, before);
    const nextId = g.state.nextId,
      coins = g.state.coins;
    ok(g.buyAnimal(12));
    const refilled = g.residentPlot(12)!.residents!;
    assert.equal(refilled.capacity, capacity, 'refilling a paid empty slot does not expand again');
    assert.equal(g.state.coins, coins - catalog.livestock!.find(a => a.key === 'layer')!.price);
    assert.deepEqual(refilled.animals.slice(0, -1), pen.animals);
    assert.deepEqual(refilled.animals.at(-1), { id: nextId, slot: capacity - 1, job: null });
    g.validate();
  }
});

test('all five animal slots round-trip through save and import with mixed hungry, eating and ready animals', () => {
  const g = funded();
  g.state.time = 120;
  for (const id of [12, 13, 14, 15]) {
    if (id >= 14) ok(g.buyPen(id));
    const pen = g.residentPlot(id)!.residents!,
      type = catalog.livestock!.find(a => a.key === pen.species)!;
    while (pen.capacity < 5) ok(g.expandPen(id));
    g.state.inventory[type.feed] = 5;
    ok(g.feedAnimals(id, pen.animals[0].id));
    pen.animals[1].job = {
      started: 0,
      ready: 120,
      output: { key: type.output, quantity: type.quantity },
      xp: 3 * type.quantity,
    };
  }
  g.validate();
  const expected = clone(g.state),
    mem = memory();
  mem.saver.save(farmPack(g.state, settings));
  assert.deepEqual(mem.saver.load()!.free, expected);
  const exported = JSON.stringify(farmPack(g.state, settings)),
    imported = memory();
  assert.deepEqual(imported.saver.importText(exported).free, expected);
  const reloaded = new FarmGame(catalog, imported.saver.load()!.free);
  assert.deepEqual(reloaded.state, expected);
  for (const id of [12, 13, 14, 15]) {
    const pen = reloaded.residentPlot(id)!.residents!,
      readyId = pen.animals[1].id;
    const running = clone(pen.animals[0]);
    ok(reloaded.collectAnimals(id, readyId));
    assert.deepEqual(pen.animals[0], running);
    assert.ok(reloaded.collectAnimals(id, readyId).error);
    assert.equal(pen.animals.length, 5);
    assert.equal(pen.animals[1].id, readyId);
  }
  reloaded.validate();
});

test('capacity six, excess animals and duplicate IDs are rejected before an import changes stored bytes', () => {
  const g = funded();
  while (g.residentPlot(12)!.residents!.capacity < 5) ok(g.expandPen(12));
  const mem = memory(g.state);
  for (const mutate of [
    (s: FarmState) => {
      s.plots[12].residents!.capacity = 6;
    },
    (s: FarmState) => {
      s.plots[12].residents!.capacity = 4.5;
    },
    (s: FarmState) => {
      s.plots[12].residents!.animals.push({ id: s.nextId++, slot: 5, job: null });
    },
    (s: FarmState) => {
      s.plots[12].residents!.animals[4].id = s.plots[12].residents!.animals[0].id;
    },
    (s: FarmState) => {
      s.plots[12].residents!.animals[4].slot = 0;
    },
    (s: FarmState) => {
      s.plots[12].residents!.animals[4].slot = 5;
    },
    (s: FarmState) => {
      s.plots[12].residents!.animals[4].slot = -1;
    },
    (s: FarmState) => {
      delete (s.plots[12].residents!.animals[4] as any).slot;
    },
  ]) {
    const bad = clone(g.state);
    mutate(bad);
    const before = [...mem.data];
    assert.throws(() => mem.saver.importText(JSON.stringify(farmPack(bad, settings))));
    assert.deepEqual([...mem.data], before);
  }
});

test('failed saves keep slot bundles unpublished and retry charges and creates the animal exactly once', () => {
  for (const action of [
    { type: 'buyPen' as const, plot: 14 },
    { type: 'expandPen' as const, plot: 12 },
  ]) {
    const g = funded();
    if (action.type === 'expandPen') while (g.residentPlot(12)!.residents!.capacity < 4) ok(g.expandPen(12));
    const before = clone(g.state),
      price = action.type === 'buyPen' ? g.penPurchasePrice(action.plot)! : g.penExpansionPrice(action.plot)!;
    const mem = memory(before),
      session = new GameSession(catalog, mem.saver, () => 0),
      primary = mem.saver.source();
    mem.fail(true);
    assert.equal(session.dispatch(action).ok, false);
    assert.deepEqual(session.game.state, before);
    assert.equal(mem.saver.source(), primary);
    const pending = clone(session.pendingPack!.free),
      residents = pending.plots[action.plot].residents!;
    assert.equal(pending.coins, before.coins - price);
    assert.equal(pending.nextId, before.nextId + 1);
    assert.equal(residents.animals.length, action.type === 'buyPen' ? 1 : 5);
    assert.deepEqual(residents.animals.at(-1), {
      id: before.nextId,
      slot: action.type === 'buyPen' ? 0 : 4,
      job: null,
    });
    assert.equal(session.retrySave(), false);
    assert.deepEqual(session.game.state, before);
    mem.fail(false);
    assert.equal(session.retrySave(), true);
    assert.deepEqual(session.game.state, pending);
    assert.deepEqual(mem.saver.load()!.free, pending);
    assert.equal(session.dispatch(action).ok, false, 'a bought pen or fifth slot cannot be purchased again');
    assert.deepEqual(session.game.state, pending);
  }
});

test('slot-targeted actions reject repeated clicks and sales never shift surviving animals into another slot', () => {
  const mem = memory(funded().state),
    session = new GameSession(catalog, mem.saver, () => 0);
  assert.equal(session.dispatch({ type: 'expandPen', plot: 12, slot: 1 }).ok, true);
  const once = clone(session.game.state);
  assert.equal(
    session.dispatch({ type: 'expandPen', plot: 12, slot: 1 }).ok,
    false,
    'the same card cannot buy the next slot'
  );
  assert.equal(session.dispatch({ type: 'expandPen', plot: 12, slot: 3 }).ok, false, 'locked slots open sequentially');
  assert.deepEqual(session.game.state, once);
  const g = session.game;
  ok(g.expandPen(12, 2));
  ok(g.expandPen(12, 3));
  const pen = g.residentPlot(12)!.residents!,
    survivors = clone(pen.animals.filter(a => a.slot === 0 || a.slot === 2));
  for (const slot of [3, 1]) ok(g.sellAnimal(12, pen.animals.find(a => a.slot === slot)!.id));
  assert.deepEqual(pen.animals, survivors);
  const refilledId = g.state.nextId;
  ok(g.buyAnimal(12, 3));
  assert.deepEqual(
    pen.animals.at(-1),
    { id: refilledId, slot: 3, job: null },
    'an explicit higher empty slot can be bought before a lower gap'
  );
  const refilled = clone(g.state);
  assert.ok(g.buyAnimal(12, 3).error);
  assert.deepEqual(g.state, refilled, 'stale refill cannot spill into another empty slot');
  for (const slot of [-1, 1.5, 4, Number.NaN]) {
    assert.ok(g.buyAnimal(12, slot).error);
    assert.deepEqual(g.state, refilled);
  }
  ok(g.expandPen(12, 4));
  assert.equal(pen.animals.at(-1)!.slot, 4, 'expansion occupies the newly opened slot, leaving the old gap intact');
  assert.ok(!pen.animals.some(a => a.slot === 1));
  const saved = memory(g.state),
    loaded = new FarmGame(catalog, saved.saver.load()!.free);
  assert.deepEqual(loaded.state, g.state, 'non-array slot order and gaps persist on reload');
  const nextId = loaded.state.nextId;
  ok(loaded.buyAnimal(12));
  assert.deepEqual(loaded.residentPlot(12)!.residents!.animals.at(-1), { id: nextId, slot: 1, job: null });
  assert.deepEqual(
    loaded.residentPlot(12)!.residents!.animals.filter(a => a.slot === 0 || a.slot === 2),
    survivors
  );
  loaded.validate();
});
