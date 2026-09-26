import { establishFarm, xpForLevel } from './fixtures/established-farm';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { boostGems } from '../assets/farm/scripts/core/FarmTiming';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import type { ActionResult } from '../assets/farm/scripts/core/types/ActionTypes';
import type { BuildXP } from '../assets/farm/scripts/core/types/EconomyTypes';

const catalog: FarmCatalog = loadFarmCatalog();
const copy = <T>(value: T): T => JSON.parse(JSON.stringify(value));
const ok = (result: ActionResult) => assert.equal(result.error, undefined, result.error);
const reward = catalog.economy!.experience.levelUpDiamonds;

test('finish-now prices charge one diamond per started minute left for every crop, animal and recipe', () => {
  assert.equal(catalog.boostSecondsPerGem, 60);
  for (const [seconds, gems] of [
    [1, 1],
    [60, 1],
    [60.1, 2],
    [300, 5],
    [900, 15],
    [3600, 60],
    [43200, 720],
  ])
    assert.equal(boostGems(catalog, seconds), gems, `${seconds} giây`);
  assert.equal(boostGems(catalog, 0), 0);
  assert.equal(boostGems(catalog, -5), 0);
  const full = (duration: number) => boostGems(catalog, duration);
  assert.deepEqual(Object.fromEntries(catalog.farm.map(crop => [crop.key, full(crop.duration)])), {
    wheat: 5,
    corn: 15,
    cabbage: 45,
    beet: 120,
    potato: 240,
    strawberry: 360,
    pumpkin: 480,
    grapes: 720,
  });
  assert.deepEqual(Object.fromEntries(catalog.livestock!.map(animal => [animal.key, full(animal.duration)])), {
    layer: 30,
    'dairy-cow': 120,
    pig: 360,
    sheep: 720,
  });
  for (const recipe of catalog.products) assert.equal(full(recipe.duration), Math.ceil(recipe.duration / 60));
  // The rate is one number: 15 minutes per diamond makes 12 hours cost 48.
  assert.equal(boostGems({ ...copy(catalog), boostSecondsPerGem: 900 }, 43200), 48);
  const legacy = copy(catalog);
  delete legacy.boostSecondsPerGem;
  assert.equal(boostGems(legacy, 90), 2, 'catalogs without the setting also charge per minute');
});

test('crop boost price counts the minutes left as the crop grows', () => {
  const g = new FarmGame(catalog),
    grapes = g.farm(3)!;
  g.state.xp = xpForLevel(g, grapes.requiredLevel!);
  g.state.coins = 10000;
  ok(g.plant(0, grapes.id));
  const plot = g.state.plots[0];
  assert.equal(g.boostPrice(plot), 720);
  g.tick(4 * 3600);
  assert.equal(g.boostPrice(plot), 480, 'eight hours left');
  g.tick(1);
  assert.equal(g.boostPrice(plot), 480, 'a started minute counts as a whole minute');
  g.tick(8 * 3600 - 301);
  assert.equal(g.boostPrice(plot), 5, 'five minutes left');
  g.state.diamonds = 5;
  ok(g.boost(plot.id));
  assert.equal(g.state.diamonds, 0);
  assert.ok(g.isReady(plot));
  assert.equal(g.boostPrice(plot), 0);
});

test('a machine boost finishes only the running job; the next job starts and XP waits for collection', () => {
  const g = establishFarm(new FarmGame(catalog)),
    bread = g.product(7)!;
  g.state.xp = xpForLevel(g, bread.requiredLevel!);
  g.state.coins = 10000;
  g.state.inventory['raw:1'] = 10;
  const bakery = g.state.machines.find(m => m.type === bread.machine)!;
  ok(g.expandQueue(bakery.id));
  ok(g.produce(bread.id, bakery.id));
  ok(g.produce(bread.id, bakery.id));
  assert.equal(g.machineBoostPrice(bakery.id), 10, 'ten minutes left');
  g.tick(bread.duration - 300);
  assert.equal(g.machineBoostPrice(bakery.id), 5, 'five minutes left');
  const xp = g.state.xp,
    diamonds = g.state.diamonds;
  const result = g.boostMachine(bakery.id);
  ok(result);
  assert.equal(result.message, 'Xong ngay · −5 kim cương');
  assert.equal(g.state.diamonds, diamonds - 5);
  assert.equal(bakery.tray.length, 1);
  assert.equal(bakery.waiting.length, 0);
  assert.equal(bakery.job!.started, g.state.time, 'the waiting bread starts at once');
  assert.equal(bakery.job!.ready, g.state.time + bread.duration);
  assert.equal(g.state.xp, xp, 'XP arrives on collection, not on boost');
  assert.equal(g.machineBoostPrice(bakery.id), 10);
  ok(g.collectAll(bakery.id));
  assert.equal(g.quantity('goods:7'), 1);
  assert.equal(g.state.xp, xp + bread.xp!);
  g.validate();

  const idle = g.state.machines.find(m => m.type !== bread.machine && !m.job)!;
  for (const id of [idle.id, 999, -1]) {
    const before = copy(g.state);
    assert.ok(g.boostMachine(id).error);
    assert.deepEqual(g.state, before);
  }
  g.state.diamonds = 1;
  const poor = copy(g.state);
  assert.equal(g.boostMachine(bakery.id).error, 'Cần 10 kim cương.');
  assert.deepEqual(g.state, poor);
  g.tick(bread.duration);
  assert.equal(g.machineBoostPrice(bakery.id), 0);
  const done = copy(g.state);
  assert.ok(g.boostMachine(bakery.id).error, 'a naturally finished job cannot be bought again');
  assert.deepEqual(g.state, done);
});

test('each queued job can be finished on its own for its whole duration, straight into the tray', () => {
  const g = establishFarm(new FarmGame(catalog)),
    bread = g.product(7)!;
  g.state.xp = xpForLevel(g, bread.requiredLevel!);
  g.state.coins = 10000;
  g.state.diamonds = 1000;
  g.state.inventory['raw:1'] = 20;
  const bakery = g.state.machines.find(m => m.type === bread.machine)!;
  ok(g.expandQueue(bakery.id));
  ok(g.expandQueue(bakery.id));
  for (let i = 0; i < 3; i++) ok(g.produce(bread.id, bakery.id));
  const running = bakery.job!,
    [second, third] = bakery.waiting;
  g.tick(bread.duration - 120);
  assert.equal(g.machineBoostPrice(bakery.id), 2, 'the running job pays for its two minutes left');
  assert.equal(g.machineBoostPrice(bakery.id, running.id), 2);
  assert.equal(
    g.machineBoostPrice(bakery.id, third.id),
    Math.ceil(bread.duration / 60),
    'a queued job pays for all of it'
  );
  assert.equal(g.machineBoostPrice(bakery.id, 424242), 0);

  const xp = g.state.xp,
    diamonds = g.state.diamonds,
    result = g.boostMachine(bakery.id, third.id);
  ok(result);
  assert.equal(result.message, `Xong ngay · −${Math.ceil(bread.duration / 60)} kim cương`);
  assert.equal(g.state.diamonds, diamonds - Math.ceil(bread.duration / 60));
  assert.deepEqual(
    bakery.tray.map(b => b.id),
    [third.id]
  );
  assert.equal(bakery.job, running, 'the running job keeps going');
  assert.deepEqual(
    bakery.waiting.map(j => j.id),
    [second.id]
  );
  assert.equal(g.state.xp, xp, 'XP still waits for collection');
  g.validate();

  ok(g.boostMachine(bakery.id, running.id));
  assert.deepEqual(
    bakery.tray.map(b => b.id),
    [third.id, running.id]
  );
  assert.equal(bakery.job!.id, second.id, 'the next queued job starts');
  ok(g.collectAll(bakery.id));
  assert.equal(g.state.xp, xp + 2 * bread.xp!);
  g.validate();

  // The tray must keep room for the running job: queued boosts stop one short of a full tray.
  g.state.inventory['raw:1'] = 20;
  for (let i = 0; i < 2; i++) ok(g.produce(bread.id, bakery.id));
  for (const job of [...bakery.waiting]) ok(g.boostMachine(bakery.id, job.id));
  for (let i = 0; i < 2; i++) ok(g.produce(bread.id, bakery.id));
  for (const job of [...bakery.waiting]) ok(g.boostMachine(bakery.id, job.id));
  assert.equal(bakery.tray.length, 4);
  ok(g.produce(bread.id, bakery.id));
  const full = copy(g.state);
  assert.equal(g.boostMachine(bakery.id, bakery.waiting[0].id).error, 'Khay nhận đã đầy. Nhận hàng trước.');
  assert.deepEqual(g.state, full);
  g.state.diamonds = 0;
  const poor = copy(g.state);
  assert.match(g.boostMachine(bakery.id).error!, /kim cương/);
  assert.deepEqual(g.state, poor);
  g.validate();
});

test('machine boost is saved once through the session and survives reload', () => {
  const game = establishFarm(new FarmGame(catalog)),
    bread = game.product(7)!;
  game.state.xp = xpForLevel(game, bread.requiredLevel!);
  game.state.inventory['raw:1'] = 2;
  const bakery = game.state.machines.find(m => m.type === bread.machine)!;
  ok(game.produce(bread.id, bakery.id));
  const storage = new Map<string, string>();
  storage.set(SIMPLE_FARM_KEY, JSON.stringify(farmPack(game.state, { speed: 1, sound: false, music: false })));
  const saver = new FarmSave(
    { getItem: key => storage.get(key) ?? null, setItem: (key, value) => void storage.set(key, value) },
    catalog
  );
  const session = new GameSession(catalog, saver, () => 0),
    diamonds = session.game.state.diamonds,
    price = session.game.machineBoostPrice(bakery.id);
  assert.equal(price, 10);
  assert.equal(session.dispatch({ type: 'boostMachine', machine: bakery.id }).ok, true);
  assert.equal(session.dispatch({ type: 'boostMachine', machine: bakery.id }).ok, false);
  const restored = new GameSession(catalog, saver, () => 0);
  assert.equal(restored.game.state.diamonds, diamonds - price);
  assert.equal(restored.game.state.machines.find(m => m.id === bakery.id)!.tray.length, 1);
});

test('each new level pays its diamonds once, also when one action crosses several levels', () => {
  const g = new FarmGame(catalog),
    start = g.state.diamonds;
  g.state.xp = xpForLevel(g, 2) - 1;
  ok(g.plant(0, 1));
  g.tick(g.farm(1)!.duration);
  const harvest = g.harvest(0);
  ok(harvest);
  assert.equal(g.progress.level, 2);
  assert.equal(g.state.diamonds, start + reward);
  assert.equal(g.state.rewardedLevel, 2);
  assert.ok(harvest.message!.endsWith(` · Lên level 2 · +${reward} kim cương`), harvest.message);

  // 2.000 wheat sell for 16.000 coins = 160 XP: levels 3, 4 and 5 at once.
  g.state.inventory['raw:1'] = 2000;
  const sale = g.sellItem('raw:1', 2000);
  ok(sale);
  assert.equal(g.progress.level, 5);
  assert.equal(g.state.diamonds, start + 4 * reward);
  assert.equal(g.state.rewardedLevel, 5);
  assert.ok(sale.message!.endsWith(` · Lên level 5 · +${3 * reward} kim cương`), sale.message);

  // A steeper curve later drops the farm to level 3; climbing back to 4 and 5 pays nothing, level 6 pays once.
  const steep = copy(catalog);
  steep.economy!.experience.curve.baseXP = 60;
  const again = new FarmGame(steep, copy(g.state));
  assert.equal(again.progress.level, 3);
  again.state.inventory['raw:1'] = 1700;
  const back = again.sellItem('raw:1', 1700);
  ok(back);
  assert.equal(again.progress.level, 5);
  assert.equal(again.state.diamonds, start + 4 * reward);
  assert.ok(back.message!.endsWith(' · Lên level 5'), back.message);
  again.state.inventory['raw:1'] = 1350;
  ok(again.sellItem('raw:1', 1350));
  assert.equal(again.progress.level, 6);
  assert.equal(again.state.diamonds, start + 5 * reward);
  assert.equal(again.state.rewardedLevel, 6);
  again.validate();
});

test('older saves get no back pay; a zero reward pays nothing and never writes the marker', () => {
  const old = new FarmGame(catalog);
  old.state.xp = xpForLevel(old, 10) + 5;
  const saved = copy(old.state);
  assert.equal(saved.rewardedLevel, undefined);
  const loaded = new FarmGame(catalog, saved);
  assert.deepEqual(loaded.state, saved);
  loaded.state.inventory['raw:1'] = 1500;
  ok(loaded.sellItem('raw:1', 1500));
  assert.equal(loaded.progress.level, 11);
  assert.equal(loaded.state.diamonds, saved.diamonds + reward, 'only level 11 is new');
  assert.equal(loaded.state.rewardedLevel, 11);

  const none = copy(catalog);
  none.economy!.experience.levelUpDiamonds = 0;
  const g = new FarmGame(none);
  g.state.xp = xpForLevel(g, 2) - 1;
  ok(g.plant(0, 1));
  g.tick(g.farm(1)!.duration);
  const result = g.harvest(0);
  ok(result);
  assert.equal(g.progress.level, 2);
  assert.equal(g.state.diamonds, none.economy!.startingWallet.diamonds);
  assert.equal(g.state.rewardedLevel, undefined);
  assert.ok(result.message!.endsWith(' · Lên level 2'), result.message);

  for (const bad of [0, -1, 1.5, 100, '3', null]) {
    const state = copy(loaded.state) as unknown as Record<string, unknown>;
    state.rewardedLevel = bad;
    assert.throws(() => new FarmGame(catalog, state), /Mốc thưởng level không hợp lệ/);
  }
});

test('animals pay their own configured XP for every collected cycle', () => {
  assert.deepEqual(Object.fromEntries(catalog.livestock!.map(animal => [animal.key, animal.xp])), {
    layer: 3,
    'dairy-cow': 6,
    pig: 12,
    sheep: 20,
  });
  const g = establishFarm(new FarmGame(catalog));
  g.state.xp = xpForLevel(g, 60);
  g.state.inventory['farm40:chicken-feed'] = 1;
  g.state.inventory['farm40:cow-feed'] = 1;
  for (const [plot, key] of [
    [12, 'layer'],
    [13, 'dairy-cow'],
  ] as const) {
    const type = catalog.livestock!.find(animal => animal.key === key)!;
    ok(g.feedAnimals(plot));
    assert.equal(g.state.plots[plot].residents!.animals[0].job!.xp, type.xp);
    g.tick(type.duration);
    const xp = g.state.xp;
    ok(g.collectAnimals(plot));
    assert.equal(g.state.xp, xp + type.xp!);
  }
  g.validate();
});

test('construction pays its configured one-time XP; restocking a sold animal pays none', () => {
  const build = catalog.economy!.experience.buildXP,
    feedmill = catalog.machineTypes!.find(type => type.key === 'feedmill')!;
  assert.deepEqual(build, { machine: 20, pen: 15, penSlot: 5, queueSlot: 3, field: 10 });
  const g = new FarmGame(catalog),
    machine = g.buyMachine(feedmill.id, 'feed-1');
  ok(machine);
  assert.equal(g.state.xp, build.machine);
  assert.equal(machine.message, `Đã mua máy thức ăn · −200 xu · +20 EXP · Lên level 2 · +${reward} kim cương`);
  const pen = g.buyPen(12);
  ok(pen);
  assert.equal(pen.message, 'Đã xây chuồng kèm 1 con · −220 xu · +15 EXP');
  g.state.coins = 100000;
  g.state.xp = xpForLevel(g, 20);
  let xp = g.state.xp;
  ok(g.expandPen(12));
  assert.equal(g.state.xp, (xp += build.penSlot));
  ok(g.expandQueue(g.state.machines[0].id));
  assert.equal(g.state.xp, (xp += build.queueSlot));
  ok(g.improve(g.nextLockedCrop()!.id));
  assert.equal(g.state.xp, (xp += build.field));
  const animals = g.residentPlot(12)!.residents!.animals;
  ok(g.sellAnimal(12, animals[1].id));
  ok(g.buyAnimal(12));
  assert.equal(g.state.xp, xp, 'buying back a sold animal is not construction');
  g.validate();

  const none = copy(catalog);
  for (const key of Object.keys(build) as (keyof BuildXP)[]) none.economy!.experience.buildXP[key] = 0;
  const free = new FarmGame(none),
    result = free.buyMachine(feedmill.id, 'feed-1');
  ok(result);
  assert.equal(free.state.xp, 0);
  assert.equal(result.message, 'Đã mua máy thức ăn · −200 xu');
});
