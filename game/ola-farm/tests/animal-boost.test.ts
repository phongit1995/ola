import { establishFarm, xpForLevel } from './fixtures/established-farm';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import { GameSession } from '../assets/farm/scripts/core/GameSession';

const catalog: FarmCatalog = loadFarmCatalog();
const copy = <T>(value: T): T => JSON.parse(JSON.stringify(value));
function feeding() {
  const game = establishFarm(new FarmGame(catalog));
  game.state.xp = xpForLevel(game, catalog.economy!.animals.layer.slots[0].requiredLevel);
  game.state.inventory['farm40:chicken-feed'] = 3;
  assert.equal(game.expandPen(12).error, undefined);
  assert.equal(game.feedAnimals(12).error, undefined);
  game.state.diamonds = 100;
  return { game, id: game.state.plots[12].residents!.animals[0].id };
}

test('animal boost charges by remaining game time; only the selected job becomes ready, eggs require collection', () => {
  const { game: g, id } = feeding();
  // One diamond per started minute left: a fresh 30-minute egg costs 30, 15 min 0.1 s costs 16, 15 min costs 15.
  assert.equal(g.animalBoostPrice(12, id), 30);
  g.tick(899.9);
  assert.equal(g.animalBoostPrice(12, id), 16);
  g.tick(0.1);
  assert.equal(g.animalBoostPrice(12, id), 15);
  const before = copy(g.state),
    expected = copy(before);
  expected.diamonds -= 15;
  expected.plots[12].residents!.animals[0].job!.ready = expected.time;
  assert.equal(g.boostAnimal(12, id).error, undefined);
  assert.deepEqual(g.state, expected);
  assert.equal(g.animalBoostPrice(12, id), 0);
  assert.equal(g.quantity('farm40:egg'), 0);
  const after = copy(g.state);
  assert.ok(g.boostAnimal(12, id).error);
  assert.deepEqual(g.state, after);
  const reloaded = new FarmGame(catalog, copy(g.state));
  reloaded.validate();
  assert.equal(reloaded.collectAnimals(12, id).error, undefined);
  assert.equal(reloaded.quantity('farm40:egg'), 1);
  assert.equal(reloaded.state.xp, before.xp + 3);
  assert.equal(reloaded.state.plots[12].residents!.animals.length, 2);
  assert.ok(reloaded.collectAnimals(12, id).error);
  assert.equal(reloaded.feedAnimals(12, id).error, undefined);
  assert.equal(reloaded.animalBoostPrice(12, id), 30);
});

test('insufficient diamonds, invalid targets, hungry and naturally ready animals never spend currency', () => {
  const { game: g, id } = feeding();
  g.state.diamonds = 1;
  for (const [plot, animal] of [
    [12, id],
    [0, id],
    [999, id],
    [13, id],
    [12, -1],
    [12, NaN],
  ]) {
    const before = copy(g.state);
    assert.ok(g.boostAnimal(plot, animal).error);
    assert.deepEqual(g.state, before);
  }
  g.tick(1800);
  let before = copy(g.state);
  assert.ok(g.boostAnimal(12, id).error);
  assert.deepEqual(g.state, before);
  assert.equal(g.collectAnimals(12, id).error, undefined);
  before = copy(g.state);
  assert.ok(g.boostAnimal(12, id).error);
  assert.deepEqual(g.state, before);
});

test('boost action persists once; a failed save keeps live diamonds/job intact and retry cannot double-charge', () => {
  const { game, id } = feeding(),
    storage = new Map<string, string>();
  const pack = farmPack(game.state, { speed: 1, sound: false, music: false });
  storage.set(SIMPLE_FARM_KEY, JSON.stringify(pack));
  let fail = false;
  const saver = new FarmSave(
    {
      getItem: key => storage.get(key) ?? null,
      setItem: (key, value) => {
        if (fail && key === SIMPLE_FARM_KEY) throw Error('quota');
        storage.set(key, value);
      },
    },
    catalog
  );
  const session = new GameSession(catalog, saver, () => 0);
  const before = copy(session.game.state),
    bytes = storage.get(SIMPLE_FARM_KEY);
  fail = true;
  assert.equal(session.dispatch({ type: 'boostAnimal', plot: 12, animal: id }).ok, false);
  assert.deepEqual(session.game.state, before);
  assert.equal(storage.get(SIMPLE_FARM_KEY), bytes);
  fail = false;
  assert.equal(session.retrySave(), true);
  assert.equal(session.game.state.diamonds, before.diamonds - 30);
  assert.equal(session.game.state.plots[12].residents!.animals[0].job!.ready, before.time);
  assert.equal(session.dispatch({ type: 'boostAnimal', plot: 12, animal: id }).ok, false);
  const restored = new GameSession(catalog, saver, () => 0);
  assert.equal(restored.game.state.diamonds, before.diamonds - 30);
  assert.equal(restored.game.collectAnimals(12, id).error, undefined);
  assert.equal(restored.game.quantity('farm40:egg'), 1);
});
