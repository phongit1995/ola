import assert from 'node:assert/strict';
import { test } from 'node:test';
import { FarmGame, orderedCrops } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave } from '../assets/farm/scripts/core/FarmSave';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import { xpForLevel } from './fixtures/established-farm';

const catalog = loadFarmCatalog();
const copy = <T>(value: T): T => JSON.parse(JSON.stringify(value));
const prices = [
  500, 1000, 1500, 2500, 4000, 6000, 8100, 22000, 44000, 73000, 110000, 160000, 210000, 270000, 340000, 410000, 500000,
  590000, 680000, 790000, 900000, 1030000, 1150000, 1290000, 1440000, 1590000, 1750000, 1910000, 2090000, 2270000,
  2460000, 2660000, 2870000, 3080000,
];

test('new farm grants six empty fields and applies every approved land price at two-level intervals', () => {
  const game = new FarmGame(catalog),
    fields = orderedCrops(game.state.plots);
  assert.deepEqual(
    fields.map(p => p.id),
    [...Array.from({ length: 12 }, (_, i) => i), ...Array.from({ length: 28 }, (_, i) => i + 22)]
  );
  assert.deepEqual(
    fields.filter(p => p.unlocked).map(p => p.id),
    [0, 1, 2, 3, 4, 5]
  );
  assert.ok(fields.every(p => p.level === 1 && p.crop === null));
  assert.deepEqual([game.state.coins, game.state.diamonds, game.progress.level], [700, 10, 1]);
  assert.equal(game.nextLockedCrop()?.id, 6);
  fields.forEach((plot, index) => {
    const config = catalog.economy!.fields[plot.id];
    assert.equal(config.initiallyUnlocked, index < 6);
    assert.equal(config.requiredLevel, index < 6 ? 1 : (index - 5) * 2);
    assert.equal(config.unlockPrice, index < 6 ? 0 : prices[index - 6]);
  });
  assert.equal(
    prices.reduce((sum, price) => sum + price, 0),
    30712600
  );
});

test('each next field rejects early/poor/repeated purchases and unlocks exactly once at its required level', () => {
  let game = new FarmGame(catalog);
  for (let index = 0; index < prices.length; index++) {
    const field = game.nextLockedCrop()!,
      level = (index + 1) * 2,
      price = prices[index];
    game.state.xp = xpForLevel(game, level) - 1;
    game.state.coins = price;
    const beforeLevel = copy(game.state);
    assert.equal(game.fieldUnlockOffer(field.id).unlocked, false);
    assert.match(game.improve(field.id).error!, new RegExp(`level ${level}`));
    assert.ok(game.plant(field.id, 1).error);
    assert.deepEqual(game.state, beforeLevel);

    game.state.xp++;
    game.state.coins = price - 1;
    const beforeCoins = copy(game.state);
    assert.equal(game.fieldUnlockOffer(field.id).unlocked, true);
    assert.match(game.improve(field.id).error!, new RegExp(`${price} xu`));
    assert.deepEqual(game.state, beforeCoins);

    game.state.coins = price;
    assert.equal(game.improve(field.id).error, undefined);
    assert.equal(game.state.coins, 0);
    assert.equal(game.state.diamonds, 10);
    assert.equal(game.state.xp, beforeCoins.xp + catalog.economy!.experience.buildXP.field, 'land pays build XP');
    assert.equal(field.unlocked, true);
    assert.equal(orderedCrops(game.state.plots).filter(p => p.unlocked).length, 7 + index);
    const purchased = copy(game.state);
    assert.match(game.improve(field.id).error!, /đã mở/);
    assert.deepEqual(game.state, purchased);
    game = new FarmGame(catalog, purchased);
    assert.deepEqual(game.state, purchased);
  }
  assert.equal(game.nextLockedCrop(), undefined);
  assert.equal(game.progress.level, 68);
});

test('land must be purchased in order even with sufficient level and coins', () => {
  const game = new FarmGame(catalog);
  game.state.coins = 200000000;
  game.state.xp = xpForLevel(game, 68);
  const before = copy(game.state);
  for (const plot of orderedCrops(game.state.plots).slice(7)) {
    assert.equal(game.fieldUnlockOffer(plot.id).unlocked, false);
    assert.match(game.improve(plot.id).error!, /trước/);
  }
  assert.deepEqual(game.state, before);
  assert.equal(game.improve(6).error, undefined);
  assert.equal(game.nextLockedCrop()?.id, 7);
  assert.equal(game.fieldUnlockOffer(7).unlocked, true);
});

test('existing full and noncontiguous land ownership survives reload without changing crops or granting land', () => {
  const oldCatalog = copy(catalog);
  Object.values(oldCatalog.economy!.fields).forEach(field => (field.initiallyUnlocked = true));
  const old = new FarmGame(oldCatalog);
  assert.equal(old.plant(49, 1).error, undefined);
  const saved = copy(old.state),
    resumed = new FarmGame(catalog, saved);
  assert.deepEqual(resumed.state, saved);
  assert.equal(resumed.nextLockedCrop(), undefined);

  const partial = new FarmGame(catalog);
  partial.state.plots.find(p => p.id === 7)!.unlocked = true;
  assert.equal(partial.plant(7, 1).error, undefined);
  const partialSave = copy(partial.state),
    reloaded = new FarmGame(catalog, partialSave);
  assert.deepEqual(reloaded.state, partialSave);
  assert.equal(reloaded.nextLockedCrop()?.id, 6);
  reloaded.state.xp = xpForLevel(reloaded, 6);
  reloaded.state.coins = 2000;
  assert.equal(reloaded.improve(6).error, undefined);
  assert.equal(reloaded.nextLockedCrop()?.id, 8, 'already owned fields are skipped');
  assert.equal(reloaded.state.plots.find(p => p.id === 7)!.crop, 1);
});

test('the first land purchase persists atomically and retry after a save failure charges only once', () => {
  const data = new Map<string, string>();
  let fail = false;
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
  const session = new GameSession(catalog, saver, () => 0);
  session.game.state.xp = xpForLevel(session.game, 2);
  session.game.state.coins = prices[0] + 100;
  session.save();
  const before = copy(session.game.state);
  fail = true;
  assert.equal(session.dispatch({ type: 'improve', plot: 6 }).ok, false);
  assert.deepEqual(session.game.state, before);
  assert.deepEqual(new GameSession(catalog, saver, () => 0).game.state, before);
  fail = false;
  assert.equal(session.retrySave(), true);
  assert.equal(session.game.state.coins, 100);
  assert.equal(session.game.nextLockedCrop()?.id, 7);
  assert.equal(session.dispatch({ type: 'improve', plot: 6 }).ok, false);
  assert.equal(session.game.state.coins, 100);
  assert.deepEqual(new GameSession(catalog, saver, () => 0).game.state, session.game.state);
});
