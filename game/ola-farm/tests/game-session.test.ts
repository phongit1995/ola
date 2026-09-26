import { loadFarmCatalog } from '../tools/load-farm-catalog';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { AUTOSAVE_SECONDS } from '../assets/farm/scripts/core/constants/SessionDefaults';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import { applyAction } from '../assets/farm/scripts/core/FarmActions';
import type { FarmAction } from '../assets/farm/scripts/core/types/ActionTypes';

const catalog: FarmCatalog = loadFarmCatalog();

function memory(options: { failWrites?: () => boolean } = {}) {
  const data = new Map<string, string>();
  const port = {
    getItem: (k: string) => data.get(k) ?? null,
    setItem: (k: string, v: string) => {
      if (options.failWrites?.() && k === SIMPLE_FARM_KEY) throw Error('quota');
      data.set(k, v);
    },
  };
  return { data, port, saver: new FarmSave(port, catalog) };
}
const session = (store = memory()) => ({ store, session: new GameSession(catalog, store.saver, () => 0) });

test('a fresh session starts unpaused with the starter farm and persists after the first dispatch', () => {
  const { store, session: s } = session();
  assert.equal(s.recovered, false);
  assert.equal(s.paused, false);
  assert.equal(s.canAct, true);
  assert.equal(s.game.state.coins, 700);
  assert.equal(store.data.size, 0);
  const toasts: string[] = [],
    committed: FarmAction[] = [];
  s.on('toast', m => toasts.push(m));
  s.on('committed', a => committed.push(a));
  const result = s.dispatch({ type: 'plant', plot: 0, crop: 1 });
  assert.equal(result.ok, true);
  assert.equal(result.result.plot?.id, 0);
  assert.equal(s.game.state.plots[0].crop, 1);
  assert.equal(s.game.state.coins, 680);
  assert.deepEqual(committed, [{ type: 'plant', plot: 0, crop: 1 }]);
  assert.deepEqual(toasts, []);
  assert.equal(JSON.parse(store.data.get(SIMPLE_FARM_KEY)!).free.coins, 680);
});

test('a rejected action leaves the farm and the store untouched', () => {
  const { store, session: s } = session();
  const before = JSON.stringify(s.game.state);
  const result = s.dispatch({ type: 'harvest', plot: 0 });
  assert.equal(result.ok, false);
  assert.match(result.result.error!, /đang lớn/);
  assert.equal(JSON.stringify(s.game.state), before);
  assert.equal(store.data.size, 0);
});

test('accepted saves at statistic limits reject the action without becoming a storage failure', () => {
  const cases: { name: string; setup: (g: FarmGame) => void; action: FarmAction }[] = [
    {
      name: 'planted counter',
      setup: g => {
        g.state.planted['raw:1'] = Number.MAX_SAFE_INTEGER;
      },
      action: { type: 'plant', plot: 0, crop: 1 },
    },
    {
      name: 'sold product counter',
      setup: g => {
        g.state.inventory['goods:7'] = 1;
        g.state.soldProducts['goods:7'] = Number.MAX_SAFE_INTEGER;
      },
      action: { type: 'sellItem', item: 'goods:7', quantity: 1 },
    },
    {
      name: 'paid harvest XP snapshot',
      setup: g => {
        assert.equal(g.plant(0, 1).error, undefined);
        g.tick(g.farm(1)!.duration);
        g.state.xp = Number.MAX_VALUE;
        g.state.plots[0].snapshot!.harvestXP = Number.MAX_VALUE;
      },
      action: { type: 'harvest', plot: 0 },
    },
  ];
  for (const { name, setup, action } of cases) {
    const store = memory(),
      g = new FarmGame(catalog);
    setup(g);
    g.validate();
    store.saver.save(farmPack(g.state, { speed: 1, sound: false, music: false }));
    const s = new GameSession(catalog, store.saver, () => 0),
      before = JSON.stringify(s.game.state),
      bytes = [...store.data];
    const failed: string[] = [];
    s.on('saveFailed', () => failed.push('saveFailed'));
    const result = s.dispatch(action);
    assert.equal(result.ok, false, name);
    assert.match(result.result.error!, /Thống kê.*giới hạn/, name);
    assert.equal(JSON.stringify(s.game.state), before, 'the ready crop, goods, wallet and counters are unchanged');
    assert.deepEqual([...store.data], bytes, 'a rejected boundary writes neither primary nor backups');
    assert.equal(s.storageFailed, false);
    assert.equal(s.pendingPack, null);
    assert.equal(s.canAct, true);
    assert.deepEqual(failed, []);
    assert.equal(
      s.dispatch({ type: 'buyCoins', pack: 0 }).ok,
      true,
      'unrelated valid actions still work after the rejection'
    );
    assert.deepEqual(store.saver.load()!.free, s.game.state);
  }
  // Exact safe-integer boundaries remain reachable; the guard must not reject one action early.
  const g = new FarmGame(catalog);
  g.state.planted['raw:1'] = Number.MAX_SAFE_INTEGER - 1;
  assert.equal(g.plant(0, 1).error, undefined);
  assert.equal(g.state.planted['raw:1'], Number.MAX_SAFE_INTEGER);
  g.state.inventory['goods:7'] = 1;
  g.state.soldProducts['goods:7'] = Number.MAX_SAFE_INTEGER - 1;
  assert.equal(g.sellItem('goods:7', 1).error, undefined);
  assert.equal(g.state.soldProducts['goods:7'], Number.MAX_SAFE_INTEGER);
  g.validate();
});

test('the session resumes a stored pack and reports a corrupt one as recovered', () => {
  const store = memory();
  const g = new FarmGame(catalog);
  g.state.coins = 777;
  store.saver.save(farmPack(g.state, { speed: 6, sound: true, music: false }));
  const resumed = new GameSession(catalog, store.saver, () => 0);
  assert.equal(resumed.game.state.coins, 777);
  assert.equal(resumed.speed, 1);
  assert.equal(resumed.settings.sound, true);
  store.data.set(SIMPLE_FARM_KEY, '{not json');
  const recovered = new GameSession(catalog, store.saver, () => 0);
  assert.equal(recovered.recovered, true);
  assert.equal(recovered.storageFailed, true);
  assert.equal(recovered.paused, true);
  assert.equal(recovered.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, false);
  assert.equal(store.data.get(SIMPLE_FARM_KEY), '{not json');
});

test('a failed write pauses, keeps the visible farm, and retry commits the pending pack once', () => {
  let fail = false;
  const store = memory({ failWrites: () => fail }),
    s = new GameSession(catalog, store.saver, () => 0);
  s.save();
  const stored = store.data.get(SIMPLE_FARM_KEY);
  const events: string[] = [];
  s.on('saveFailed', () => events.push('saveFailed'));
  s.on('toast', m => events.push(m.startsWith('Không lưu được') ? 'toast:save-failed' : 'toast:' + m));
  s.on('replaced', () => events.push('replaced'));
  fail = true;
  const result = s.dispatch({ type: 'plant', plot: 0, crop: 1 });
  assert.equal(result.ok, false);
  assert.equal(result.result.error, undefined);
  assert.equal(s.storageFailed, true);
  assert.equal(s.paused, true);
  assert.equal(s.pendingPack?.free.coins, 680);
  assert.equal(s.game.state.plots[0].crop, null, 'the visible farm is not advanced past the last persisted state');
  assert.equal(store.data.get(SIMPLE_FARM_KEY), stored);
  assert.deepEqual(events, ['saveFailed', 'toast:save-failed']);
  assert.equal(s.retrySave(), false);
  assert.equal(s.storageFailed, true);
  fail = false;
  assert.equal(s.retrySave(), true);
  assert.equal(s.storageFailed, false);
  assert.equal(s.paused, false);
  assert.equal(s.pendingPack, null);
  assert.equal(s.game.state.plots[0].crop, 1);
  assert.equal(JSON.parse(store.data.get(SIMPLE_FARM_KEY)!).free.coins, 680);
  assert.ok(events.includes('replaced'));
});

test('real-time sessions use wall time, normalize old speed settings and autosave', () => {
  let now = 0;
  const store = memory(),
    s = new GameSession(catalog, store.saver, () => now);
  assert.equal(s.setSpeed(6), false);
  assert.equal(s.speed, 1);
  now += 1000;
  s.tick(1);
  assert.equal(s.game.state.time, 1);
  now += 100000;
  s.tick(100);
  assert.equal(s.game.state.time, 101, 'elapsed real time is not clamped to a frame');
  s.togglePause();
  now += 1000;
  s.tick(1);
  assert.equal(s.game.state.time, 102, 'like Hay Day, a pause blocks input but never stops real time');
  assert.equal(s.canAct, false);
  s.togglePause();
  s.suspend();
  now += 1000;
  s.tick(1);
  assert.equal(s.game.state.time, 102);
  s.resume();
  assert.equal(s.game.state.time, 103);
  store.data.clear();
  now += AUTOSAVE_SECONDS * 1000;
  s.tick(AUTOSAVE_SECONDS);
  assert.ok(store.data.has(SIMPLE_FARM_KEY));
  assert.equal(JSON.parse(store.data.get(SIMPLE_FARM_KEY)!).settings.speed, 1);
  assert.equal(s.setSpeed(7), false);
});

test('menus pause and restore, import replaces the farm, restart starts over', () => {
  const { store, session: s } = session();
  s.enterMenu();
  assert.equal(s.paused, true);
  s.enterMenu();
  s.leaveMenu();
  assert.equal(s.paused, false);
  s.togglePause();
  s.enterMenu();
  s.leaveMenu();
  assert.equal(s.paused, true, 'the pause before the menu is restored');
  s.togglePause();
  const other = new FarmGame(catalog);
  other.state.coins = 4242;
  const text = JSON.stringify(farmPack(other.state, { speed: 12, sound: false, music: true }));
  let replaced = 0;
  s.on('replaced', () => replaced++);
  s.importText(text);
  assert.equal(s.game.state.coins, 4242);
  assert.equal(s.speed, 1);
  assert.equal(replaced, 1);
  assert.equal(store.data.get(SIMPLE_FARM_KEY + '.import-source'), text);
  assert.throws(() => s.importText('{"version":4}'), /không được hỗ trợ/);
  assert.equal(s.game.state.coins, 4242, 'a rejected import changes nothing');
  assert.equal(s.restart(), true);
  assert.equal(s.game.state.coins, 700);
  assert.equal(replaced, 2);
  assert.equal(s.toggleAudio('music'), false);
  assert.equal(s.settings.music, false);
  assert.equal(JSON.parse(s.exportText()).settings.music, false);
});

test('every action type maps to a game method and unknown types are rejected at compile time', () => {
  const g = new FarmGame(catalog);
  g.state.coins = 10000;
  const actions: FarmAction[] = [
    { type: 'plant', plot: 0, crop: 1 },
    { type: 'boost', plot: 0 },
    { type: 'harvest', plot: 0 },
    { type: 'cancel', plot: 0 },
    { type: 'improve', plot: 0 },
    { type: 'rescue' },
    { type: 'dismissGuide' },
    { type: 'produce', recipe: 7, machine: 0 },
    { type: 'collect', machine: 0 },
    { type: 'cancelQueued', machine: 0, job: 1 },
    { type: 'expandQueue', machine: 0 },
    { type: 'buyMachine', machineType: 2 },
    { type: 'sellItem', item: 'raw:1', quantity: 1 },
    { type: 'setPenSpecies', plot: 12, species: null },
    { type: 'buyAnimal', plot: 12 },
    { type: 'expandPen', plot: 12 },
    { type: 'sellAnimal', plot: 12, animal: 1 },
    { type: 'feedAnimals', plot: 12 },
    { type: 'collectAnimals', plot: 12 },
  ];
  for (const action of actions) {
    const result = applyAction(g, action);
    assert.ok(typeof result === 'object' && ('error' in result || 'message' in result), action.type);
  }
  assert.throws(() => applyAction(g, { type: 'teleport' } as unknown as FarmAction), /không được hỗ trợ/);
});
