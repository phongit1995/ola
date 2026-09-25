import assert from 'node:assert/strict';
import { test } from 'node:test';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import type { ActionResult } from '../assets/farm/scripts/core/types/ActionTypes';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import type { FarmState } from '../assets/farm/scripts/core/types/StateTypes';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import { xpForLevel } from './fixtures/established-farm';

const catalog = loadFarmCatalog();
const levels = [5, 10, 15, 20];
const settings = { speed: 1, sound: false, music: false };
const copy = <T>(value: T): T => JSON.parse(JSON.stringify(value));
const ok = (result: ActionResult) => assert.equal(result.error, undefined, result.error);

function bothHouses(source: FarmCatalog = catalog) {
  const game = new FarmGame(source);
  game.state.coins = 1000000;
  game.state.xp = xpForLevel(game, 20);
  for (const building of ['feed-1', 'feed-2']) ok(game.buyMachine(5, building));
  for (const plot of [12, 50]) ok(game.buyPen(plot));
  return game;
}

function memory(state: FarmState) {
  const data = new Map<string, string>();
  const saver = new FarmSave(
    {
      getItem: key => data.get(key) ?? null,
      setItem: (key, value) => {
        data.set(key, value);
      },
    },
    catalog
  );
  saver.save(farmPack(state, settings));
  return { data, saver };
}

test('only chicken pens and feed-mill queues use the wider starter slot levels', () => {
  assert.deepEqual(
    catalog.economy!.animals.layer.slots.map(slot => slot.requiredLevel),
    levels
  );
  assert.deepEqual(
    catalog.economy!.machines.feedmill.queueSlots.map(slot => slot.requiredLevel),
    levels
  );
  assert.deepEqual(
    catalog.economy!.animals['dairy-cow'].slots.map(slot => slot.requiredLevel),
    [2, 3, 4, 5]
  );
  for (const species of ['pig', 'sheep'])
    assert.deepEqual(
      catalog.economy!.animals[species].slots.map(slot => slot.requiredLevel),
      [1, 1, 1, 1]
    );
  for (const type of catalog.machineTypes!.filter(type => type.key !== 'feedmill')) {
    assert.deepEqual(
      catalog.economy!.machines[type.key].queueSlots.map(slot => slot.requiredLevel),
      [1, 1, 1, 1]
    );
  }
});

for (const plot of [12, 50]) {
  test(`chicken pen ${plot} buys each slot only at its level and full bundle price, in order and once`, () => {
    const game = bothHouses(),
      pen = game.residentPlot(plot)!.residents!;
    const animal = catalog.livestock!.find(type => type.key === 'layer')!;
    const initial = copy(game.state);
    assert.ok(game.expandPen(plot, 2).error, 'a later slot cannot be purchased even at a high level');
    assert.deepEqual(game.state, initial);
    for (const [index, level] of levels.entries()) {
      const slot = index + 1;
      game.state.xp = xpForLevel(game, level) - 1;
      game.state.coins = 1000000;
      const below = copy(game.state),
        offer = game.penSlotUnlockStatus(plot, slot);
      assert.equal(offer.unlocked, false);
      assert.equal(offer.requiredLevel, level);
      assert.match(offer.reason, new RegExp(`level ${level}$`));
      assert.equal(game.expandPen(plot, slot).error, offer.reason);
      assert.deepEqual(game.state, below);
      const stored = memory(below),
        bytes = [...stored.data],
        session = new GameSession(catalog, stored.saver, () => 0);
      assert.equal(session.dispatch({ type: 'expandPen', plot, slot }).ok, false);
      assert.deepEqual(session.game.state, below);
      assert.deepEqual([...stored.data], bytes);

      game.state.xp = xpForLevel(game, level);
      assert.equal(game.penSlotUnlockStatus(plot, slot).unlocked, true);
      assert.equal(pen.capacity, slot, 'reaching the level does not grant the slot');
      const price = catalog.economy!.animals.layer.slots[index].price + animal.price;
      assert.equal(game.penSlotPrice(plot, slot), price);
      game.state.coins = price - 1;
      const short = copy(game.state);
      assert.ok(game.expandPen(plot, slot).error);
      assert.deepEqual(game.state, short);
      game.state.coins = price;
      const expected = copy(game.state),
        expectedPen = expected.plots.find(candidate => candidate.id === plot)!.residents!;
      expected.coins = 0;
      expectedPen.capacity++;
      expectedPen.animals.push({ id: expected.nextId++, slot, job: null });
      ok(game.expandPen(plot, slot));
      assert.deepEqual(game.state, expected, 'the bundle changes only its wallet, slot, resident and ID allocation');
      game.state.coins = 1000000;
      const bought = copy(game.state);
      assert.ok(game.expandPen(plot, slot).error, 'a duplicate click must not buy the following slot');
      assert.deepEqual(game.state, bought);
    }
    assert.equal(pen.capacity, 5);
    assert.equal(pen.animals.length, 5);
    const full = copy(game.state);
    assert.ok(game.expandPen(plot).error);
    assert.deepEqual(game.state, full);
    game.validate();
  });
}

for (const building of ['feed-1', 'feed-2']) {
  test(`${building} buys queue slots sequentially at the exact levels and prices and stops at five`, () => {
    const game = bothHouses(),
      machine = game.state.machines.find(candidate => candidate.buildingId === building)!;
    for (const [index, level] of levels.entries()) {
      const slot = index + 1;
      game.state.xp = xpForLevel(game, level) - 1;
      game.state.coins = 1000000;
      const below = copy(game.state),
        offer = game.queueSlotUnlockStatus(machine.id, slot);
      assert.equal(offer.unlocked, false);
      assert.equal(offer.requiredLevel, level);
      assert.match(offer.reason, new RegExp(`level ${level}$`));
      assert.equal(game.expandQueue(machine.id).error, offer.reason);
      assert.deepEqual(game.state, below);
      const stored = memory(below),
        bytes = [...stored.data],
        session = new GameSession(catalog, stored.saver, () => 0);
      assert.equal(session.dispatch({ type: 'expandQueue', machine: machine.id }).ok, false);
      assert.deepEqual(session.game.state, below);
      assert.deepEqual([...stored.data], bytes);

      game.state.xp = xpForLevel(game, level);
      assert.equal(game.queueSlotUnlockStatus(machine.id, slot).unlocked, true);
      assert.equal(machine.capacity, slot, 'reaching the level does not grant the queue slot');
      const price = catalog.economy!.machines.feedmill.queueSlots[index].price;
      assert.equal(game.queueSlotPrice(machine.id, slot), price);
      game.state.coins = price - 1;
      const short = copy(game.state);
      assert.ok(game.expandQueue(machine.id).error);
      assert.deepEqual(game.state, short);
      game.state.coins = price;
      const expected = copy(game.state);
      expected.coins = 0;
      expected.machines.find(candidate => candidate.id === machine.id)!.capacity++;
      ok(game.expandQueue(machine.id));
      assert.deepEqual(game.state, expected, 'only the selected machine capacity and wallet change');
      game.state.coins = 1000000;
      const bought = copy(game.state);
      assert.ok(game.expandQueue(machine.id).error, 'the next queue slot remains locked at this exact threshold');
      assert.deepEqual(game.state, bought);
    }
    assert.equal(machine.capacity, 5);
    game.state.xp = xpForLevel(game, 54);
    const full = copy(game.state);
    assert.ok(game.expandQueue(machine.id).error);
    assert.deepEqual(game.state, full);
    game.validate();
  });
}

test('level gains, status reads, ticks and reload do not open slots in either starter house', () => {
  const game = bothHouses();
  for (const level of [1, 4, 5, 9, 10, 14, 15, 19, 20]) {
    game.state.xp = xpForLevel(game, level);
    for (let slot = 1; slot < 5; slot++) {
      for (const plot of [12, 50]) game.penSlotUnlockStatus(plot, slot);
      for (const machine of game.state.machines) game.queueSlotUnlockStatus(machine.id, slot);
    }
    game.tick(86400);
    const stored = memory(game.state),
      reloaded = new GameSession(catalog, stored.saver, () => 0).game;
    assert.deepEqual(reloaded.state, game.state);
    assert.deepEqual(
      reloaded.state.machines.map(machine => machine.capacity),
      [1, 1]
    );
    for (const plot of [12, 50]) {
      assert.equal(reloaded.residentPlot(plot)!.residents!.capacity, 1);
      assert.equal(reloaded.residentPlot(plot)!.residents!.animals.length, 1);
    }
  }
});

test('slots paid under the old levels survive save/import at zero XP and remain usable', () => {
  const previous = copy(catalog);
  previous.economy!.animals.layer.slots.forEach((slot, index) => {
    slot.requiredLevel = index + 2;
  });
  previous.economy!.machines.feedmill.queueSlots.forEach(slot => {
    slot.requiredLevel = 1;
  });
  const historical = bothHouses(previous);
  historical.state.xp = xpForLevel(historical, 5);
  for (const plot of [12, 50])
    while (historical.residentPlot(plot)!.residents!.capacity < 5) ok(historical.expandPen(plot));
  for (const machine of historical.state.machines) while (machine.capacity < 5) ok(historical.expandQueue(machine.id));
  historical.state.xp = 0;
  historical.state.inventory = { 'raw:1': 20, 'farm40:corn': 10, 'farm40:chicken-feed': 10 };
  const expected = copy(historical.state),
    stored = memory(expected);
  assert.deepEqual(new GameSession(catalog, stored.saver, () => 0).game.state, expected);
  const imported = memory(new FarmGame(catalog).state);
  imported.saver.importText(stored.data.get(SIMPLE_FARM_KEY)!);
  const game = new GameSession(catalog, imported.saver, () => 0).game;
  assert.deepEqual(game.state, expected);
  for (const plot of [12, 50]) {
    for (let slot = 0; slot < 5; slot++) assert.equal(game.penSlotUnlockStatus(plot, slot).unlocked, true);
    const pen = game.residentPlot(plot)!.residents!;
    ok(game.sellAnimal(plot, pen.animals[4].id));
    ok(game.buyAnimal(plot, 4));
    ok(game.feedAnimals(plot));
    assert.equal(pen.animals.filter(animal => animal.job).length, 5);
  }
  for (const machine of game.state.machines) {
    for (let slot = 0; slot < 5; slot++) assert.equal(game.queueSlotUnlockStatus(machine.id, slot).unlocked, true);
    for (let batch = 0; batch < 5; batch++) ok(game.produce(24, machine.id));
    assert.equal(machine.waiting.length + Number(!!machine.job), 5);
    const full = copy(game.state);
    assert.ok(game.produce(24, machine.id).error);
    assert.deepEqual(game.state, full);
  }
  assert.equal(game.state.xp, 0);
  game.validate();
});
