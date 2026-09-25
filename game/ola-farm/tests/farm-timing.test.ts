import { establishFarm, xpForLevel } from './fixtures/established-farm';
import type { FarmContentSource } from '../assets/farm/scripts/core/types/EconomyTypes';
import { withFarmEconomy } from '../assets/farm/scripts/core/FarmEconomy';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import type { FarmCatalogSource, FarmTimingConfig } from '../assets/farm/scripts/core/types/TimingTypes';
import { withFarmTiming } from '../assets/farm/scripts/core/FarmTiming';
import { loadFarmCatalog } from '../tools/load-farm-catalog';

const directory = path.join(__dirname, '../assets/farm/bundles/farm-town');
const source: FarmCatalogSource = withFarmEconomy(
  JSON.parse(fs.readFileSync(path.join(directory, 'catalog.json'), 'utf8')) as FarmContentSource,
  JSON.parse(fs.readFileSync(path.join(directory, 'economy.json'), 'utf8'))
);
const timing: FarmTimingConfig = JSON.parse(fs.readFileSync(path.join(directory, 'timing.json'), 'utf8'));
const copy = <T>(value: T): T => JSON.parse(JSON.stringify(value));
const ok = (result: { error?: string }) => assert.equal(result.error, undefined, result.error);

test('the authored timing file supplies every crop, animal and recipe without duplicated catalog durations', () => {
  const catalog = loadFarmCatalog();
  const { gameplay, runtime, ...timedCatalog } = catalog;
  assert.deepEqual(withFarmTiming(source, timing), timedCatalog);
  for (const crop of catalog.farm) assert.equal(crop.duration, timing.crops[crop.key].durationSeconds);
  for (const animal of catalog.livestock!) assert.equal(animal.duration, timing.animals[animal.key].durationSeconds);
  for (const recipe of catalog.products) assert.equal(recipe.duration, timing.recipes[recipe.id].durationSeconds);
  assert.equal(catalog.boostSecondsPerGem, timing.boostSecondsPerGem);
  assert.deepEqual(
    [Object.keys(timing.crops).length, Object.keys(timing.animals).length, Object.keys(timing.recipes).length],
    [8, 4, 23]
  );
  assert.ok([...source.farm, ...source.livestock, ...source.products].every(entry => !('duration' in entry)));
  assert.ok(!('boostSecondsPerGem' in source));
});

test('editing timing changes future paid work and boost prices while existing saved jobs retain their timers', () => {
  const catalog = loadFarmCatalog(),
    original = establishFarm(new FarmGame(catalog));
  original.state.xp = xpForLevel(original, original.product(7)!.requiredLevel!);
  original.state.inventory = { 'raw:1': 20, 'farm40:chicken-feed': 2 };
  ok(original.plant(0, 1));
  ok(original.produce(7, 0));
  ok(original.feedAnimals(12));
  const saved = copy(original.state),
    config = copy(timing),
    untouched = copy(source);
  config.crops.wheat.durationSeconds = 123;
  config.animals.layer.durationSeconds = 321;
  config.recipes['7'].durationSeconds = 456;
  config.boostSecondsPerGem = 60;
  const changed = withFarmTiming(source, config),
    game = new FarmGame(changed, saved);
  assert.deepEqual(source, untouched);
  assert.deepEqual(game.state, saved);
  assert.equal(game.state.plots[0].snapshot!.duration, catalog.farm[0].duration);
  assert.equal(game.state.machines[0].job!.duration, catalog.products.find(recipe => recipe.id === 7)!.duration);
  assert.equal(game.state.plots[12].residents!.animals[0].job!.ready, catalog.livestock![0].duration);
  ok(game.plant(1, 1));
  assert.equal(game.state.plots[1].ready, 123);
  assert.equal(game.boostPrice(game.state.plots[1]), 3);
  game.tick(122);
  assert.ok(game.harvest(1).error);
  game.tick(1);
  ok(game.harvest(1));
  game.tick(1800);
  ok(game.collectAll(0));
  ok(game.collectAnimals(12));
  ok(game.produce(7, 0));
  ok(game.feedAnimals(12));
  assert.equal(game.state.machines[0].job!.ready - game.state.time, 456);
  assert.equal(game.state.plots[12].residents!.animals[0].job!.ready - game.state.time, 321);
  assert.equal(game.animalBoostPrice(12, game.state.plots[12].residents!.animals[0].id), 6);
  game.validate();
});

test('invalid timing reports the exact field instead of silently falling back to old values', () => {
  for (const value of [0, -1, null, '300', NaN, Infinity, Number.MAX_VALUE]) {
    const config = copy(timing);
    (config.crops.wheat as { durationSeconds: unknown }).durationSeconds = value;
    assert.throws(() => withFarmTiming(source, config), /timing\.json · crops\.wheat\.durationSeconds/);
  }
  for (const mutate of [
    (config: any) => {
      config.version = 2;
    },
    (config: any) => {
      delete config.crops.wheat;
    },
    (config: any) => {
      config.crops.wheet = config.crops.wheat;
    },
    (config: any) => {
      config.recipes['999'] = { name: 'unknown', durationSeconds: 60 };
    },
    (config: any) => {
      delete config.animals;
    },
    (config: any) => {
      config.animals.layer.durationSecond = 60;
    },
    (config: any) => {
      config.crops.wheat.name = '';
    },
    (config: any) => {
      config.boostSecondsPerGem = 0;
    },
  ]) {
    const config = copy(timing);
    mutate(config);
    assert.throws(() => withFarmTiming(source, config), /timing\.json/);
  }
  const duplicate = copy(source);
  Object.assign(duplicate.farm[0], { duration: 100 });
  assert.throws(() => withFarmTiming(duplicate, timing), /duration trùng trong catalog\.json/);
  assert.throws(
    () => withFarmTiming(Object.assign(copy(source), { boostSecondsPerGem: 100 }), timing),
    /trùng trong catalog\.json/
  );
});
