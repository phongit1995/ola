import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { test } from 'node:test';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { FARM_KEY, SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import type { FarmPack, StoragePort } from '../assets/farm/scripts/core/types/SaveTypes';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import { loadFarmCatalog } from '../tools/load-farm-catalog';

// Historical keys are intentional compatibility fixtures; no test writes them through FarmSave.
const OLD_FULL = 'happy-farm-cocos-40-v1',
  OLD_SIMPLE = 'happy-farm-cocos-simple-v1';
const full: FarmCatalog = JSON.parse(
  fs.readFileSync(path.resolve(__dirname, '../assets/resources/ported/game.json'), 'utf8')
).data;
const simple = loadFarmCatalog();
const profiles = [
  { name: 'full', catalog: full, key: FARM_KEY, old: OLD_FULL },
  { name: 'simple', catalog: simple, key: SIMPLE_FARM_KEY, old: OLD_SIMPLE },
];
const settings = { speed: 1, sound: false, music: true };
const stamp = 1_700_000_000_000;
const pack = (catalog: FarmCatalog, coins = 4321): FarmPack => {
  const game = new FarmGame(catalog);
  // This historical save predates paid land and already owns every crop field.
  for (const plot of game.state.plots) if (plot.group === 'crop') plot.unlocked = true;
  game.state.coins = coins;
  assert.equal(game.plant(8, 1).error, undefined);
  return { ...farmPack(game.state, settings), clock: { version: 1, savedAt: stamp, running: false } };
};
const raw = (value: FarmPack): string => JSON.stringify(value, null, 2) + '  \n';
const memory = (initial: Array<[string, string]> = [], failWrite: (key: string) => boolean = () => false) => {
  const data = new Map(initial),
    writes: string[] = [];
  const port: StoragePort = {
    getItem: key => data.get(key) ?? null,
    setItem: (key, value) => {
      writes.push(key);
      if (failWrite(key)) throw Error('quota');
      data.set(key, value);
    },
  };
  return { data, port, writes };
};
const unchanged = (data: Map<string, string>, entries: Array<[string, string]>): void => {
  for (const [key, value] of entries) assert.equal(data.get(key), value, 'preserve historical bytes: ' + key);
};

test('active Cocos save namespaces use Ola Farm', () => {
  assert.equal(FARM_KEY, 'ola-farm-cocos-40-v1');
  assert.equal(SIMPLE_FARM_KEY, 'ola-farm-cocos-simple-v1');
});

for (const { name, catalog, key, old } of profiles) {
  test(`${name}: loading a Happy save is read-only; saving migrates its exact previous bytes without changing history`, () => {
    const original = pack(catalog),
      source = raw(original),
      prior = raw(pack(catalog, 3000));
    const history: Array<[string, string]> = [
      [old, source],
      [old + '.backup', prior],
      [old + '.before-import', 'original import history\n'],
      [old + '.import-source', 'original source\n'],
      [old + '.before-layout-v6', 'original layout history\n'],
    ];
    const store = memory(history),
      saver = new FarmSave(store.port, catalog);
    assert.equal(saver.key, key);
    assert.deepEqual(saver.load(), original, 'wallet, crop timers/snapshot, settings and clock survive the rename');
    assert.equal(saver.source(), source);
    assert.equal(saver.backup(), prior);
    assert.equal(store.writes.length, 0);
    assert.deepEqual(store.data, new Map(history));
    const next = saver.load()!;
    next.free.coins -= 10;
    saver.save(next);
    assert.deepEqual(saver.load(), next);
    assert.equal(store.data.get(key), JSON.stringify(next));
    assert.equal(
      saver.backup(),
      source,
      'the first Ola backup contains the actual previous primary, including whitespace'
    );
    unchanged(store.data, history);
    const migrated = saver.source();
    next.free.coins -= 10;
    saver.save(next);
    assert.equal(saver.backup(), migrated);
    unchanged(store.data, history);
    assert.ok(
      store.writes.every(written => written.startsWith(key)),
      'the old namespace is never a write target'
    );
  });

  test(`${name}: Ola source and backup win over distinct Happy data`, () => {
    const oldPack = raw(pack(catalog, 1000)),
      current = raw(pack(catalog, 9000));
    const store = memory([
      [old, oldPack],
      [old + '.backup', 'old backup'],
      [key, current],
      [key + '.backup', 'Ola backup'],
    ]);
    const saver = new FarmSave(store.port, catalog);
    assert.equal(saver.source(), current);
    assert.equal(saver.backup(), 'Ola backup');
    assert.deepEqual(saver.load(), saver.parse(current));
    assert.equal(store.writes.length, 0);
    store.data.delete(key + '.backup');
    assert.equal(saver.backup(), null, 'an Ola primary does not silently pair with a different Happy backup');
  });

  test(`${name}: corrupt or empty Ola primary never falls back to a valid Happy save`, () => {
    for (const corrupt of [
      '',
      '{broken',
      JSON.stringify({ ...pack(catalog), free: { ...pack(catalog).free, coins: -1 } }),
    ]) {
      const history: Array<[string, string]> = [
        [old, raw(pack(catalog))],
        [old + '.backup', raw(pack(catalog, 2000))],
      ];
      const store = memory([...history, [key, corrupt], [key + '.backup', 'Ola recovery bytes']]);
      const saver = new FarmSave(store.port, catalog);
      assert.throws(() => saver.load());
      assert.throws(() => saver.save(pack(catalog)));
      assert.equal(saver.source(), corrupt);
      assert.equal(saver.backup(), 'Ola recovery bytes');
      assert.equal(store.writes.length, 0);
      const session = new GameSession(catalog, saver, () => stamp);
      assert.equal(session.recovered, true);
      assert.equal(session.storageFailed, true);
      assert.equal(session.canAct, false);
      assert.equal(session.exportSource('source'), corrupt);
      const imported = raw(pack(catalog, 8000));
      session.importText(imported);
      assert.equal(session.storageFailed, false);
      assert.deepEqual(session.game.state, saver.parse(imported).free);
      assert.equal(store.data.get(key + '.before-import'), corrupt);
      assert.equal(store.data.get(key + '.import-source'), imported);
      unchanged(store.data, history);
    }
  });

  test(`${name}: corrupt Happy primary stays recoverable and its backup can be explicitly imported into Ola`, () => {
    const backup = raw(pack(catalog, 6000)),
      history: Array<[string, string]> = [
        [old, '{old broken\n'],
        [old + '.backup', backup],
      ];
    const store = memory(history),
      saver = new FarmSave(store.port, catalog),
      session = new GameSession(catalog, saver, () => stamp);
    assert.equal(session.recovered, true);
    assert.equal(session.storageFailed, true);
    assert.equal(session.exportSource('source'), history[0][1]);
    assert.equal(session.exportSource('backup'), backup);
    assert.throws(() => saver.save(pack(catalog)));
    assert.equal(store.writes.length, 0);
    session.importText(backup);
    assert.equal(session.storageFailed, false);
    assert.deepEqual(session.game.state, saver.parse(backup).free);
    assert.equal(store.data.get(key + '.before-import'), history[0][1]);
    assert.equal(store.data.get(key + '.import-source'), backup);
    unchanged(store.data, history);
    assert.ok(store.writes.every(written => written.startsWith(key)));
  });

  test(`${name}: failed first Ola write keeps the loaded Happy farm and retries the pending state`, () => {
    let fail = true;
    const history: Array<[string, string]> = [
      [old, raw(pack(catalog))],
      [old + '.backup', raw(pack(catalog, 2000))],
    ];
    const store = memory(history, written => fail && written === key),
      saver = new FarmSave(store.port, catalog);
    const session = new GameSession(catalog, saver, () => stamp),
      before = structuredClone(session.game.state);
    const result = session.dispatch({ type: 'plant', plot: 9, crop: 1 });
    assert.equal(result.result.error, undefined);
    assert.equal(result.ok, false);
    assert.equal(session.storageFailed, true);
    assert.deepEqual(session.game.state, before);
    assert.equal(saver.source(), history[0][1]);
    assert.equal(saver.backup(), history[0][1], 'the Ola recovery copy survives a failed primary write');
    assert.equal(store.data.has(key), false);
    unchanged(store.data, history);
    assert.equal(session.retrySave(), false);
    fail = false;
    assert.equal(session.retrySave(), true);
    assert.equal(session.storageFailed, false);
    assert.equal(session.game.state.plots[9].crop, 1);
    assert.deepEqual(saver.load()!.free, session.game.state);
    assert.equal(saver.backup(), history[0][1]);
    unchanged(store.data, history);
  });

  test(`${name}: a backup without a primary remains exportable and is not silently loaded`, () => {
    const backup = raw(pack(catalog));
    const store = memory([[old + '.backup', backup]]),
      saver = new FarmSave(store.port, catalog);
    assert.equal(saver.load(), null);
    assert.equal(saver.source(), null);
    assert.equal(saver.backup(), backup);
    assert.equal(store.writes.length, 0);
    const currentBackup = raw(pack(catalog, 9000));
    store.data.set(key + '.backup', currentBackup);
    assert.equal(saver.load(), null);
    assert.equal(saver.backup(), currentBackup, 'an Ola backup without a primary remains recoverable');
    store.data.set(old, backup);
    assert.deepEqual(
      saver.load(),
      saver.parse(backup),
      'a backup alone does not suppress the historical primary fallback'
    );
    assert.equal(saver.source(), backup);
    assert.equal(saver.backup(), currentBackup);
  });
}

test('full/simple profiles remain isolated across both brand namespaces and legacy exports prefer Ola full data', () => {
  const oldFull = raw(pack(full)),
    oldFullBackup = raw(pack(full, 3000));
  const store = memory([
    [OLD_FULL, oldFull],
    [OLD_FULL + '.backup', oldFullBackup],
  ]);
  const saver = new FarmSave(store.port, simple);
  assert.equal(saver.load(), null);
  assert.equal(saver.source(), null);
  assert.equal(saver.backup(), null);
  assert.equal(saver.legacySource(), oldFull);
  assert.equal(saver.legacyBackup(), oldFullBackup);
  store.data.set(FARM_KEY + '.backup', 'Ola full backup without primary');
  assert.equal(saver.legacySource(), oldFull);
  assert.equal(saver.legacyBackup(), 'Ola full backup without primary');
  saver.save(pack(simple));
  assert.equal(store.data.has(FARM_KEY), false);
  assert.equal(store.data.get(OLD_FULL), oldFull);
  const before = new Map(store.data);
  assert.throws(() => saver.importText(oldFull));
  assert.deepEqual(store.data, before);
  store.data.set(FARM_KEY, '{broken Ola full');
  store.data.set(FARM_KEY + '.backup', 'Ola full backup');
  assert.equal(saver.legacySource(), '{broken Ola full');
  assert.equal(saver.legacyBackup(), 'Ola full backup');
  const onlySimple = memory([
    [OLD_SIMPLE, raw(pack(simple))],
    [SIMPLE_FARM_KEY, raw(pack(simple, 9000))],
  ]);
  const fullSaver = new FarmSave(onlySimple.port, full);
  assert.equal(fullSaver.load(), null);
  assert.equal(fullSaver.source(), null);
  assert.equal(fullSaver.backup(), null);
  assert.throws(() => fullSaver.importText(onlySimple.data.get(SIMPLE_FARM_KEY)!));
});
