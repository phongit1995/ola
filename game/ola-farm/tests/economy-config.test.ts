import { establishFarm } from './fixtures/established-farm';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import type { FarmContentSource, FarmEconomyConfig } from '../assets/farm/scripts/core/types/EconomyTypes';
import { withFarmEconomy } from '../assets/farm/scripts/core/FarmEconomy';
import { withFarmTiming } from '../assets/farm/scripts/core/FarmTiming';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave } from '../assets/farm/scripts/core/FarmSave';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import { xpToNext } from '../assets/farm/scripts/core/Progression';
const directory = path.join(__dirname, '../assets/farm/bundles/farm-town');
const read = (file: string) => JSON.parse(fs.readFileSync(path.join(directory, file), 'utf8'));
const source: FarmContentSource = read('catalog.json'),
  defaults: FarmEconomyConfig = read('economy.json'),
  timing = read('timing.json');
const copy = <T>(v: T): T => JSON.parse(JSON.stringify(v));
const catalog = (config = defaults) => withFarmTiming(withFarmEconomy(source, config), timing);
const xpFor = (level: number, config = defaults) =>
  Array.from({ length: level - 1 }, (_, i) => xpToNext(i + 1, config.experience.curve)).reduce((a, b) => a + b, 0);
const ok = (r: { error?: string }) => assert.equal(r.error, undefined, r.error);

test('JSON building prices and slot levels govern purchases; old purchases survive later price/level changes', () => {
  const config = copy(defaults);
  config.startingWallet.coins = 10000;
  config.machines.grill.sites[0] = { price: 333, requiredLevel: 2 };
  config.pens['pen:50'].sitePrice = 444;
  config.pens['pen:50'].requiredLevel = 2;
  config.animals.layer.purchasePrice = 31;
  config.animals.layer.slots[0] = { price: 17, requiredLevel: 3 };
  config.machines.bakery.queueSlots[0] = { price: 29, requiredLevel: 4 };
  const game = establishFarm(new FarmGame(catalog(config))),
    initial = copy(game.state);
  assert.match(game.buyMachine(2).error!, /level 2/);
  assert.deepEqual(game.state, initial);
  game.state.xp = xpFor(2);
  let coins = game.state.coins;
  ok(game.buyMachine(2));
  assert.equal(game.state.coins, coins - 333);
  coins = game.state.coins;
  ok(game.buyPen(50));
  assert.equal(game.state.coins, coins - 475);
  assert.equal(game.penSlotPrice(12, 1), 48);
  // The two builds paid construction XP; step back below level 3 to test the slot gate.
  assert.equal(game.state.xp, xpFor(2) + config.experience.buildXP.machine + config.experience.buildXP.pen);
  game.state.xp = xpFor(2);
  assert.match(game.expandPen(12).error!, /level 3/);
  game.state.xp = xpFor(3);
  coins = game.state.coins;
  ok(game.expandPen(12));
  assert.equal(game.state.coins, coins - 48);
  assert.match(game.expandQueue(0).error!, /level 4/);
  game.state.xp = xpFor(4);
  coins = game.state.coins;
  ok(game.expandQueue(0));
  assert.equal(game.state.coins, coins - 29);
  const saved = copy(game.state);
  config.startingWallet.coins = 1;
  config.animals.layer.slots[0] = { price: 999, requiredLevel: 99 };
  config.machines.bakery.queueSlots[0] = { price: 999, requiredLevel: 99 };
  config.pens['pen:50'].requiredLevel = 99;
  config.machines.grill.sites[0].requiredLevel = 99;
  const resumed = new FarmGame(catalog(config), saved);
  assert.deepEqual(resumed.state, saved);
  assert.equal(resumed.penSlotUnlockStatus(12, 1).unlocked, true);
  assert.equal(resumed.queueSlotUnlockStatus(0, 1).unlocked, true);
  assert.equal(resumed.penUnlockStatus(50).unlocked, true);
});

test('configured land can be locked, purchased with coins at its level, planted and reloaded without resetting ownership', () => {
  const config = copy(defaults);
  Object.assign(config.fields['1'], { initiallyUnlocked: false, initialLevel: 3, unlockPrice: 123, requiredLevel: 2 });
  config.startingWallet.coins = 100;
  const game = new FarmGame(catalog(config));
  assert.equal(game.state.plots[1].unlocked, false);
  const locked = copy(game.state);
  assert.ok(game.plant(1, 1).error);
  assert.match(game.improve(1).error!, /level 2/);
  assert.deepEqual(game.state, locked);
  game.state.xp = xpFor(2);
  assert.match(game.improve(1).error!, /123 xu/);
  game.state.coins = 143;
  ok(game.improve(1));
  assert.equal(game.state.coins, 20);
  assert.equal(game.state.diamonds, 10);
  assert.equal(game.state.plots[1].level, 3);
  assert.ok(game.improve(1).error);
  assert.equal(game.state.coins, 20);
  ok(game.plant(1, 1));
  const saved = copy(game.state);
  config.fields['1'].unlockPrice = 999;
  config.fields['1'].requiredLevel = 99;
  assert.deepEqual(new FarmGame(catalog(config), saved).state, saved);
  config.fields['1'].initiallyUnlocked = true;
  assert.equal(
    new FarmGame(catalog(config), locked).state.plots[1].unlocked,
    false,
    'fresh settings never grant land to existing saves'
  );
  assert.ok(game.improve(14).error);
  assert.ok(game.improve(18).error);
});

test('a failed land purchase save leaves the visible farm intact and retry charges only once', () => {
  const config = copy(defaults);
  config.startingWallet.xp = xpFor(2);
  Object.assign(config.fields['1'], { initiallyUnlocked: false, unlockPrice: 123, requiredLevel: 2 });
  const data = new Map<string, string>();
  let fail = false;
  const cat = catalog(config),
    saver = new FarmSave(
      {
        getItem: k => data.get(k) ?? null,
        setItem: (k, v) => {
          if (fail && k === SIMPLE_FARM_KEY) throw Error('quota');
          data.set(k, v);
        },
      },
      cat
    );
  const session = new GameSession(cat, saver, () => 0);
  session.save();
  const before = copy(session.game.state);
  fail = true;
  assert.equal(session.dispatch({ type: 'improve', plot: 1 }).ok, false);
  assert.deepEqual(session.game.state, before);
  fail = false;
  assert.equal(session.retrySave(), true);
  assert.equal(session.game.state.coins, 577);
  assert.equal(session.game.state.plots[1].unlocked, true);
  assert.equal(session.dispatch({ type: 'improve', plot: 1 }).ok, false);
  assert.equal(session.game.state.coins, 577);
  assert.deepEqual(new GameSession(cat, saver, () => 0).game.state, session.game.state);
});

test('seed/sale prices, yields, refunds, wallet, XP curve, level rewards, animal XP and coin packs are read from JSON', () => {
  const config = copy(defaults);
  config.startingWallet = { coins: 200, diamonds: 8, xp: 0 };
  Object.assign(config.crops.wheat, { seedPrice: 7, harvestXP: 11, yields: [5, 6, 7, 8] });
  config.items['raw:1'].sellPrice = 4;
  config.experience.plantingXP = 2;
  config.experience.saleCoinsPerXP = 20;
  config.experience.levelUpDiamonds = 3;
  config.experience.curve.baseXP = 10;
  config.refunds.cropCancelRate = 0.5;
  config.refunds.animalSaleRate = 0.25;
  config.coinPacks = [{ coins: 50, diamonds: 2 }];
  config.animals.layer.purchasePrice = 40;
  config.animals.layer.quantity = 2;
  config.animals.layer.xp = 10;
  const game = establishFarm(new FarmGame(catalog(config)));
  assert.deepEqual([game.state.coins, game.state.diamonds, game.progress.need], [200, 8, 10]);
  ok(game.plant(0, 1));
  assert.equal(game.state.coins, 193);
  assert.equal(game.state.xp, 2);
  assert.equal(game.state.plots[0].snapshot!.refundCoins, 3);
  game.tick(game.farm(1)!.duration);
  ok(game.harvest(0));
  assert.equal(game.quantity('raw:1'), 5);
  assert.equal(game.state.xp, 13);
  assert.equal(game.progress.level, 2);
  assert.equal(game.state.diamonds, 11, 'reaching level 2 pays the configured level reward once');
  ok(game.sellItem('raw:1', 5));
  assert.equal(game.state.coins, 213);
  assert.equal(game.state.xp, 14);
  ok(game.buyCoins(0));
  assert.equal(game.state.coins, 263);
  assert.equal(game.state.diamonds, 9);
  assert.equal(game.state.xp, 14);
  assert.ok(game.buyCoins(1).error);
  game.state.inventory['farm40:chicken-feed'] = 1;
  ok(game.feedAnimals(12));
  game.tick(game.catalog.livestock![0].duration);
  ok(game.collectAnimals(12));
  assert.equal(game.quantity('farm40:egg'), 2);
  assert.equal(game.state.xp, 24);
  ok(game.sellAnimal(12, game.state.plots[12].residents!.animals[0].id));
  assert.equal(game.state.coins, 273);
});

test('recipe price, XP and unlock level share the configured source and paid snapshots keep their original refund', () => {
  const old = establishFarm(new FarmGame(catalog()));
  ok(old.plant(0, 1));
  const paid = copy(old.state);
  const config = copy(defaults);
  config.crops.wheat.seedPrice = 99;
  config.refunds.cropCancelRate = 0.9;
  config.recipes['7'] = { name: 'Bánh mì', requiredLevel: 2, xp: 17 };
  config.items['goods:7'].sellPrice = 77;
  const game = new FarmGame(catalog(config), paid);
  ok(game.cancel(0));
  assert.equal(game.state.coins, 686);
  game.state.inventory['raw:1'] = 2;
  assert.match(game.produce(7, 0).error!, /level 2/);
  game.state.xp = xpFor(2);
  ok(game.produce(7, 0));
  game.tick(game.product(7)!.duration);
  ok(game.collectAll(0));
  assert.equal(game.state.xp, xpFor(2) + 17);
  const coins = game.state.coins;
  ok(game.sellItem('goods:7', 1));
  assert.equal(game.state.coins, coins + 77);
});

test('malformed economy config fails at its field before a game or save is changed', () => {
  const before = copy(source);
  for (const mutate of [
    (c: any) => {
      c.version = 2;
    },
    (c: any) => {
      delete c.fields['1'];
    },
    (c: any) => {
      c.fields['999'] = c.fields['1'];
    },
    (c: any) => {
      c.fields['1'].initiallyUnlocked = 'false';
    },
    (c: any) => {
      Object.values(c.fields).forEach((f: any) => (f.initiallyUnlocked = false));
    },
    (c: any) => {
      c.fields['1'].unlockPrice = -1;
    },
    (c: any) => {
      c.fields['1'].initialLevel = 5;
    },
    (c: any) => {
      c.machines.grill.sites[0].price = '300';
    },
    (c: any) => {
      c.animals.layer.slots.pop();
    },
    (c: any) => {
      c.machines.bakery.queueSlots[0].requiredLevel = 100;
    },
    (c: any) => {
      c.experience.saleCoinsPerXP = 0;
    },
    (c: any) => {
      c.experience.curve.baseXP = 0;
    },
    (c: any) => {
      c.refunds.cropCancelRate = 1.5;
    },
    (c: any) => {
      c.items['raw:1'].sellPrice = NaN;
    },
    (c: any) => {
      c.crops.wheat.requiredLevel = 2;
    },
    (c: any) => {
      c.coinPacks[0].diamonds = 0;
    },
    (c: any) => {
      c.experience.animalXPPerUnit = 3;
    },
    (c: any) => {
      c.experience.levelUpDiamonds = -1;
    },
    (c: any) => {
      delete c.experience.levelUpDiamonds;
    },
    (c: any) => {
      delete c.experience.buildXP.field;
    },
    (c: any) => {
      c.experience.buildXP.machine = -1;
    },
    (c: any) => {
      c.experience.buildXP.animal = 2;
    },
    (c: any) => {
      c.animals.layer.xp = 1.5;
    },
    (c: any) => {
      delete c.animals.sheep.xp;
    },
  ]) {
    const config = copy(defaults);
    mutate(config);
    assert.throws(() => catalog(config), /economy\.json/);
    assert.deepEqual(source, before);
  }
  const duplicated = copy(source);
  Object.assign(duplicated.farm[0], { price: 1 });
  assert.throws(() => withFarmEconomy(duplicated, defaults), /trùng trong catalog\.json/);
});
