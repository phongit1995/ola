import { establishFarm } from './fixtures/established-farm';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import { withFarmGameplay } from '../assets/farm/scripts/core/FarmGameplay';
import { withFarmRuntime } from '../assets/farm/scripts/core/FarmRuntime';
import { loadFarmCatalog } from '../tools/load-farm-catalog';

const defaults = loadFarmCatalog();
const { gameplay, runtime, ...base } = defaults;
const copy = <T>(v: T): T => JSON.parse(JSON.stringify(v));
const ok = (r: { error?: string }) => assert.equal(r.error, undefined, r.error);
const configured = (g = gameplay!, r = runtime!) => withFarmRuntime(withFarmGameplay(base, g), r);
function storage() {
  const data = new Map<string, string>();
  return {
    getItem: (k: string) => data.get(k) ?? null,
    setItem: (k: string, v: string) => {
      data.set(k, v);
    },
  };
}

test('the five-file loader keeps the default fresh economy and owns immutable config copies', () => {
  assert.deepEqual(new FarmGame(defaults).state, new FarmGame(base).state);
  const config = copy(gameplay!),
    cat = configured(config);
  config.startingInventory['raw:1'] = 99;
  assert.equal(cat.gameplay!.startingInventory['raw:1'], undefined);
});

test('an unknown construction species returns a locked offer without changing the farm', () => {
  const game = new FarmGame(defaults),
    before = copy(game.state);
  const offer = game.penConstructionOffer('unknown');
  assert.equal(offer.unlocked, false);
  assert.equal(offer.price, null);
  assert.equal(offer.buildingId, null);
  assert.deepEqual(game.state, before);
});

test('configured starting stock, capacity, herd size and feed cost govern real purchases and jobs', () => {
  const config = copy(gameplay!);
  config.showWelcome = false;
  config.startingInventory = { 'raw:1': 10, 'farm40:chicken-feed': 3 };
  Object.assign(config.animals.layer, { startingCapacity: 3, startingAnimals: 2, feedPerAnimal: 2 });
  config.machines.bakery.startingCapacity = 3;
  const game = establishFarm(new FarmGame(configured(config)));
  assert.equal(game.state.guideDismissed, true);
  assert.equal(game.state.machines[0].capacity, 3);
  assert.deepEqual([game.state.plots[12].residents!.capacity, game.state.plots[12].residents!.animals.length], [3, 2]);
  const before = copy(game.state);
  assert.match(game.feedAnimals(12).error!, /cần 4/);
  assert.deepEqual(game.state, before);
  ok(game.feedAnimals(12, game.state.plots[12].residents!.animals[0].id));
  assert.equal(game.quantity('farm40:chicken-feed'), 1);
  const saved = copy(game.state);
  config.startingInventory = {};
  config.animals.layer.startingAnimals = 0;
  assert.deepEqual(new FarmGame(configured(config), saved).state, saved);
  game.state.coins = 100000;
  game.state.xp = 1e8;
  const siteFee = game.catalog.residentPens!.find(p => p.plotId === 50)!.purchasePrice!;
  const expectedPrice = siteFee + 2 * game.catalog.livestock![0].price;
  assert.equal(game.penPurchasePrice(50), expectedPrice);
  ok(game.buyPen(50));
  assert.equal(game.state.coins, 100000 - expectedPrice);
  assert.equal(game.state.plots.find(p => p.id === 50)!.residents!.animals.length, 2);
  ok(game.buyMachine(1));
  assert.equal(game.state.machines.at(-1)!.capacity, 3);
  game.validate();
});

test('lower purchase limits preserve owned slots, buildings and paid batches across reload', () => {
  const game = establishFarm(new FarmGame(defaults));
  game.state.coins = 100000;
  game.state.xp = 1e8;
  ok(game.expandPen(12));
  ok(game.expandQueue(0));
  ok(game.expandQueue(0));
  ok(game.buyMachine(1));
  game.state.inventory['raw:1'] = 20;
  for (let i = 0; i < 3; i++) ok(game.produce(7, 0));
  game.tick(game.product(7)!.duration * 3);
  const saved = copy(game.state),
    config = copy(gameplay!);
  Object.assign(config.machines.bakery, { maxBuildings: 1, maxQueueCapacity: 1, trayCapacity: 1 });
  Object.assign(config.animals.layer, { maxPens: 1, maxCapacity: 1 });
  const resumed = new FarmGame(configured(config), saved);
  assert.deepEqual(resumed.state, saved);
  assert.equal(resumed.queueSlotUnlockStatus(0, 2).unlocked, true);
  assert.equal(resumed.penSlotUnlockStatus(12, 1).unlocked, true);
  assert.ok(resumed.expandQueue(0).error);
  assert.ok(resumed.expandPen(12).error);
  assert.match(resumed.buyPen(50).error!, /đủ 1 nhà/);
  assert.match(resumed.buyMachine(1).error!, /đủ 1 nhà/);
  ok(resumed.collectAll(0));
  assert.equal(resumed.quantity('goods:7'), 3);
  for (let i = 0; i < 3; i++) ok(resumed.produce(7, 0));
  resumed.tick(resumed.product(7)!.duration * 10);
  const machine = resumed.state.machines[0];
  assert.equal(machine.tray.length, 1);
  assert.equal(machine.waiting.length, 2);
  assert.equal(machine.job, null);
  ok(resumed.collectAll(0));
  assert.equal(machine.job!.ready - resumed.state.time, resumed.product(7)!.duration);
  resumed.validate();
});

test('collection gates count actual harvests, survive sale, support all/any and retain old one-time milestones', () => {
  const config = copy(gameplay!);
  config.gates.husbandry = { mode: 'all', requirements: [{ items: ['raw:1'], quantity: 2, label: 'thu lúa' }] };
  config.startingInventory = { 'raw:1': 100 };
  const game = new FarmGame(configured(config));
  game.state.xp = 1e8;
  assert.equal(game.penUnlockStatus(14).unlocked, false);
  ok(game.plant(0, 1));
  game.tick(game.farm(1)!.duration);
  ok(game.harvest(0));
  assert.equal(game.state.produced['raw:1'], game.farm(1)!.yields[0]);
  assert.equal(game.penUnlockStatus(14).unlocked, true);
  ok(game.sellItem('raw:1', game.quantity('raw:1')));
  assert.equal(new FarmGame(game.catalog, game.state).penUnlockStatus(14).unlocked, true);
  config.gates.husbandry.requirements.push({ items: ['town:burger'], quantity: 2, label: 'nhận burger' });
  assert.equal(new FarmGame(configured(config), game.state).penUnlockStatus(14).unlocked, false);
  config.gates.husbandry.mode = 'any';
  assert.equal(new FarmGame(configured(config), game.state).penUnlockStatus(14).unlocked, true);
  const old = new FarmGame(defaults);
  old.state.xp = 1e8;
  Object.assign(old.state.husbandry!, { feedReceived: true, eggsCollected: true, milkCollected: true });
  assert.equal(new FarmGame(defaults, old.state).penUnlockStatus(14).unlocked, true);
  config.gates.crafts.requirements = [];
  assert.equal(new FarmGame(configured(config)).machineUnlockStatus(1021).unlocked, true);
});

test('rescue, growth-stage timing and feed-mill requirement are configurable', () => {
  const config = copy(gameplay!);
  config.rescueEnabled = false;
  config.requireFeedMill = false;
  config.growthStageFraction = 0.2;
  const game = establishFarm(new FarmGame(configured(config)));
  ok(game.plant(0, 1));
  game.tick(60);
  assert.equal(game.growthStage(game.state.plots[0]), 2);
  game.state.machines = game.state.machines.filter(m => m.type !== 5);
  const animal = game.state.plots[12].residents!.animals[0];
  ok(game.sellAnimal(12, animal.id));
  ok(game.buyAnimal(12));
  game.state.coins = 0;
  game.state.plots[0].crop = null;
  game.state.plots[0].snapshot = null;
  assert.equal(game.canRescue(), false);
  const rescue = new FarmGame(defaults);
  rescue.state.coins = 0;
  assert.equal(rescue.canRescue(), true);
});

test('runtime autosave interval and new-player audio defaults do not override saved preferences', () => {
  const config = copy(runtime!);
  config.session.autosaveSeconds = 10;
  config.session.defaultMusic = true;
  config.session.defaultSound = true;
  const cat = configured(gameplay!, config),
    saver = new FarmSave(storage(), cat);
  let saves = 0;
  const save = saver.save.bind(saver);
  saver.save = p => {
    saves++;
    save(p);
  };
  const session = new GameSession(cat, saver, () => 0);
  assert.equal(session.settings.music, true);
  assert.equal(session.settings.sound, true);
  session.tick(9);
  assert.equal(saves, 0);
  session.tick(1);
  assert.equal(saves, 1);
  session.toggleAudio('music');
  assert.equal(new GameSession(cat, saver, () => 0).settings.music, false);
});

test('offline caps and disabling offline progress consume the gap once; active play remains uncapped', () => {
  for (const enabled of [true, false]) {
    const config = copy(runtime!);
    config.session.offlineProgressEnabled = enabled;
    config.session.maxOfflineSeconds = 60;
    const cat = configured(gameplay!, config),
      saver = new FarmSave(storage(), cat);
    let now = 100000;
    let session = new GameSession(cat, saver, () => now);
    assert.equal(session.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, true);
    session.suspend();
    now += 3600000;
    session.resume();
    assert.equal(session.game.state.time, enabled ? 60 : 0);
    session = new GameSession(cat, saver, () => now);
    assert.equal(session.game.state.time, enabled ? 60 : 0);
    now += 120000;
    session.tick(0.1);
    assert.equal(session.game.state.time, enabled ? 180 : 120);
    session.enterMenu();
    now += 500000;
    session.leaveMenu();
    assert.equal(session.game.state.time, enabled ? 180 : 120);
  }
  const config = copy(runtime!);
  config.session.maxOfflineSeconds = 30;
  const cat = configured(gameplay!, config),
    saver = new FarmSave(storage(), cat);
  const pack = {
    ...farmPack(new FarmGame(cat).state, { speed: 1, sound: false, music: false }),
    clock: { version: 1 as const, savedAt: 0, running: true },
  };
  saver.save(pack);
  const loaded = new GameSession(cat, saver, () => 100000);
  assert.equal(loaded.game.state.time, 30);
  loaded.importText(JSON.stringify(pack));
  assert.equal(loaded.game.state.time, 30);
  assert.equal(new GameSession(cat, saver, () => 100000).game.state.time, 30);
});

test('malformed gameplay/runtime JSON reports the offending file and preserves the source', () => {
  const before = copy(base);
  for (const mutate of [
    (c: any) => {
      c.version = 2;
    },
    (c: any) => {
      delete c.animals.pig;
    },
    (c: any) => {
      c.typo = true;
    },
    (c: any) => {
      c.startingInventory.unknown = 1;
    },
    (c: any) => {
      c.animals.layer.maxCapacity = 6;
    },
    (c: any) => {
      c.animals.layer.startingAnimals = 2;
    },
    (c: any) => {
      c.animals.layer.feedPerAnimal = 0;
    },
    (c: any) => {
      c.machines.bakery.trayCapacity = 6;
    },
    (c: any) => {
      c.gates.crafts.mode = 'and';
    },
    (c: any) => {
      c.gates.crafts.requirements[0].items = ['missing'];
    },
    (c: any) => {
      c.rescueEnabled = 'false';
    },
    (c: any) => {
      c.gates.crafts.requirements[0].quantity = 0;
    },
  ]) {
    const c = copy(gameplay!);
    mutate(c);
    assert.throws(() => configured(c), /gameplay\.json/);
  }
  for (const mutate of [
    (c: any) => {
      c.version = 2;
    },
    (c: any) => {
      c.audio.musicVolume = 2;
    },
    (c: any) => {
      c.session.autosaveSeconds = 0;
    },
    (c: any) => {
      c.session.maxOfflineSeconds = -1;
    },
    (c: any) => {
      c.input.wheelZoomStep = 1;
    },
    (c: any) => {
      c.assets.loadConcurrency = 1.5;
    },
    (c: any) => {
      c.ui.motionEnabled = 1;
    },
    (c: any) => {
      c.camera.maxZoom = NaN;
    },
    (c: any) => {
      delete c.input.seedDragSlop;
    },
    (c: any) => {
      c.ui.toastSecond = 1;
    },
  ]) {
    const c = copy(runtime!);
    mutate(c);
    assert.throws(() => configured(gameplay!, c), /runtime\.json/);
  }
  assert.deepEqual(base, before);
});
