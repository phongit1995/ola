import { establishFarm } from './fixtures/established-farm';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import assert from 'node:assert/strict';
import { historicalState } from './fixtures/historical-state';
import { machineSites, penBuildingId } from '../assets/farm/scripts/core/FarmCatalog';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { createHash } from 'node:crypto';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import { EMPTY_LAYOUT } from '../assets/farm/scripts/core/constants/PlacementDefaults';
import { FARM_LAYOUT, buildingPosition, groundError, checkLayout } from '../assets/farm/scripts/core/BuildingPlacement';
import { PREVIOUS_PEN_LAYOUT } from '../assets/farm/scripts/core/legacy/PreviousPenLayout';
import { PREVIOUS_LARGE_PEN_LAYOUT } from '../assets/farm/scripts/core/legacy/PreviousLargePenLayout';
import { PREVIOUS_FOUR_FIELD_LAYOUT } from '../assets/farm/scripts/core/legacy/PreviousFourFieldLayout';
import { herdDisplayScale } from '../assets/farm/scripts/map/buildings/HerdPresentation';

const root = path.resolve(__dirname, '..');
const catalog: FarmCatalog = loadFarmCatalog();
const clone = <T>(v: T): T => JSON.parse(JSON.stringify(v));
const settings = { speed: 6, sound: false, music: false };
function previousGame(version: 2 | 3 | 4 = 2) {
  const game = establishFarm(new FarmGame(catalog));
  // The shipped schema required every crop field to be owned.
  for (const plot of game.state.plots) if (plot.group === 'crop') plot.unlocked = true;
  game.state.coins = 1000000;
  game.state.xp = 100000000;
  for (const item of game.items) game.state.inventory[item.key] = 20;
  game.state.husbandry = {
    version: 1,
    feedReceived: true,
    eggsCollected: true,
    milkCollected: true,
    burgerCollected: true,
  };
  for (const id of [14, 15]) assert.equal(game.buyPen(id).error, undefined);
  for (const id of [12, 13, 14, 15]) assert.equal(game.feedAnimals(id).error, undefined);
  assert.equal(game.plant(0, 1).error, undefined);
  assert.equal(game.expandQueue(0).error, undefined);
  assert.equal(game.produce(7, 0).error, undefined);
  assert.equal(game.produce(7, 0).error, undefined);
  game.state = historicalState(game.state);
  game.state.buildingLayout = { version, positions: {} };
  return game;
}

test('four-field yards match hashed floor/fence art while all forty fields and facilities stay intact', () => {
  const source = JSON.parse(
    fs.readFileSync(path.join(root, 'source-assets/farm-beautify/pen-footprints.json'), 'utf8')
  );
  const field = FARM_LAYOUT.obstacles.find(o => /^R\d/.test(o.id))!;
  const fieldWidth = Math.max(...field.polygon.map(p => p.x)) - Math.min(...field.polygon.map(p => p.x));
  assert.equal(source.fieldWidth, fieldWidth);
  assert.equal(source.targetFieldWidths, 4);
  assert.equal(source.sourceYardWidth, 190);
  assert.ok(Math.abs(source.displayScale * source.sourceYardWidth - 4 * fieldWidth) < 1e-9);
  assert.equal(groundError(EMPTY_LAYOUT), null);
  for (const pen of catalog.residentPens!) {
    const id = penBuildingId(pen),
      data = source.pens['pen:' + catalog.residentPens!.find(p => p.species === pen.species)!.cell],
      b = FARM_LAYOUT.buildings.find(b => b.id === id)!;
    assert.equal(herdDisplayScale(pen.species), source.displayScale, id + ' artwork and collision size must agree');
    assert.deepEqual(b.footprints, [data.polygon]);
    assert.ok(
      Math.max(...data.polygon.map((p: any) => p.x)) - Math.min(...data.polygon.map((p: any) => p.x)) >
        3.85 * fieldWidth,
      id + ' must reserve the whole enlarged yard width'
    );
    for (const [file, sha] of Object.entries(data.sources))
      assert.equal(
        createHash('sha256')
          .update(
            file.endsWith('.prefab')
              ? fs.readFileSync(path.join(root, file), 'utf8').replace(/\r\n/g, '\n')
              : fs.readFileSync(path.join(root, file))
          )
          .digest('hex'),
        sha,
        file
      );
  }
  const fields = (manifest: typeof FARM_LAYOUT) => manifest.obstacles.filter(o => /^R\d/.test(o.id));
  assert.deepEqual(fields(FARM_LAYOUT), fields(PREVIOUS_PEN_LAYOUT), 'all forty fields retain their exact coordinates');
  const shapes = (buildings: typeof FARM_LAYOUT.buildings) =>
    buildings.filter(b => b.kind === 'facility').map(({ position, ...building }) => building);
  assert.deepEqual(
    FARM_LAYOUT.buildings.filter(b => ['pen:12', 'pen:13', 'pen:14', 'pen:15'].includes(b.id)),
    PREVIOUS_FOUR_FIELD_LAYOUT.buildings.filter(b => b.kind === 'pen'),
    'machine enlargement keeps all four delivered yards exactly'
  );
  assert.deepEqual(
    shapes(FARM_LAYOUT.buildings),
    shapes(PREVIOUS_LARGE_PEN_LAYOUT.buildings),
    'house and barn footprints stay unchanged'
  );
});

test('v2, v3 and v4 migrations update authored defaults and preserve paid work, animals, IDs and wallet through reload', () => {
  for (const version of [2, 3, 4] as const) {
    const old = clone(previousGame(version).state),
      before = clone(old);
    assert.equal(
      groundError(
        old.buildingLayout!,
        version === 2 ? PREVIOUS_PEN_LAYOUT : version === 3 ? PREVIOUS_LARGE_PEN_LAYOUT : PREVIOUS_FOUR_FIELD_LAYOUT
      ),
      null
    );
    const game = new FarmGame(catalog, old);
    assert.deepEqual(game.state.buildingLayout, EMPTY_LAYOUT);
    assert.deepEqual({ ...historicalState(game.state), buildingLayout: before.buildingLayout }, before);
    assert.deepEqual(old, before, 'loading does not mutate the input');
    assert.deepEqual(new FarmGame(catalog, game.state).state, game.state, 'v5 reload is idempotent');
    for (const id of [12, 13, 14, 15]) assert.ok(game.state.plots[id].residents!.animals[0].job);
    assert.equal(game.state.machines[0].waiting.length, 1);
  }
});

test('valid custom pens remain exact, while a newly overlapping pen moves without moving any other saved building', () => {
  for (const version of [2, 3] as const)
    for (const [position, keep] of [
      [{ x: -1600, y: -300 }, true],
      [{ x: 270, y: 30 }, false],
    ] as const) {
      const old = clone(previousGame(version).state);
      old.buildingLayout!.positions = { 'pen:12': position, barn: { x: -576, y: -936 } };
      assert.equal(
        groundError(
          old.buildingLayout!,
          version === 2 ? PREVIOUS_PEN_LAYOUT : version === 3 ? PREVIOUS_LARGE_PEN_LAYOUT : PREVIOUS_FOUR_FIELD_LAYOUT
        ),
        null
      );
      const game = new FarmGame(catalog, old),
        newPosition = buildingPosition('pen:12', game.state.buildingLayout);
      if (keep) assert.deepEqual(newPosition, position);
      else assert.notDeepEqual(newPosition, position);
      assert.deepEqual(buildingPosition('barn', game.state.buildingLayout), old.buildingLayout!.positions.barn);
      assert.equal(checkLayout(game.state.buildingLayout!, game.state).error, null);
      assert.deepEqual({ ...historicalState(game.state), buildingLayout: old.buildingLayout }, old);
      assert.deepEqual(
        new FarmGame(catalog, old).state,
        game.state,
        'migration chooses the same destination every time'
      );
    }
});

test('relocated default factories and house yield to valid custom v3 buildings without changing their saved coordinates', () => {
  for (const id of ['farm-house', 'feed-1', 'industry-loom']) {
    const old = clone(previousGame(3).state),
      target = clone(FARM_LAYOUT.buildings.find(b => b.id === id)!.position);
    old.buildingLayout!.positions.barn = target;
    assert.equal(
      groundError(old.buildingLayout!, PREVIOUS_LARGE_PEN_LAYOUT),
      null,
      id + ' fixture was valid before the defaults moved'
    );
    const game = new FarmGame(catalog, old);
    assert.deepEqual(
      buildingPosition('barn', game.state.buildingLayout),
      target,
      'the saved custom barn wins over a new default'
    );
    assert.notDeepEqual(buildingPosition(id, game.state.buildingLayout), target);
    assert.equal(checkLayout(game.state.buildingLayout!, game.state).error, null);
    assert.deepEqual({ ...historicalState(game.state), buildingLayout: old.buildingLayout }, old);
  }
});

test('a relocated fixed mill moves only a newly blocked v3 custom building and preserves every paid activity', () => {
  const old = clone(previousGame(3).state),
    mill = FARM_LAYOUT.obstacles.find(o => o.id === 'MainObject-xay gio')!;
  const center = mill.polygon.reduce(
    (p, q) => ({ x: p.x + q.x / mill.polygon.length, y: p.y + q.y / mill.polygon.length }),
    { x: 0, y: 0 }
  );
  const position = { x: center.x, y: center.y + 40 }; // The barn's ground center is 40 below its anchor.
  const other = { x: -1400, y: -200 };
  old.buildingLayout!.positions = { barn: position, 'bakery-1': other };
  assert.equal(
    groundError(old.buildingLayout!, PREVIOUS_LARGE_PEN_LAYOUT),
    null,
    'both customs were valid before the fixed mill moved'
  );
  assert.ok(groundError(old.buildingLayout!, FARM_LAYOUT, 'barn'));
  const game = new FarmGame(catalog, old);
  assert.notDeepEqual(buildingPosition('barn', game.state.buildingLayout), position);
  assert.deepEqual(buildingPosition('bakery-1', game.state.buildingLayout), other);
  assert.equal(checkLayout(game.state.buildingLayout!, game.state).error, null);
  assert.deepEqual({ ...historicalState(game.state), buildingLayout: old.buildingLayout }, old);
  assert.deepEqual(new FarmGame(catalog, old).state, game.state, 'the repair is deterministic');
});

test('each new default yard yields to a pre-existing moved barn instead of relocating the barn', () => {
  for (const id of ['pen:12', 'pen:13', 'pen:14', 'pen:15']) {
    const old = clone(previousGame().state),
      target = clone(FARM_LAYOUT.buildings.find(b => b.id === id)!.position);
    old.buildingLayout!.positions.barn = target;
    if (id === 'pen:12') old.buildingLayout!.positions['pen:12'] = { x: -500, y: 500 };
    if (id === 'pen:13') old.buildingLayout!.positions['pen:14'] = { x: -500, y: 500 };
    assert.equal(
      groundError(old.buildingLayout!, PREVIOUS_PEN_LAYOUT),
      null,
      id + ' fixture must be a valid shipped save'
    );
    const game = new FarmGame(catalog, old);
    assert.deepEqual(buildingPosition('barn', game.state.buildingLayout), target);
    assert.notDeepEqual(buildingPosition(id, game.state.buildingLayout), target);
    assert.equal(checkLayout(game.state.buildingLayout!, game.state).error, null);
    assert.deepEqual({ ...historicalState(game.state), buildingLayout: old.buildingLayout }, old);
  }
});

test('migration backup preserves exact v2/v3/v4 bytes across failed writes, retry and import; corrupt old saves never write', () => {
  for (const version of [2, 3, 4] as const) {
    const before = farmPack(clone(previousGame(version).state), settings),
      raw = JSON.stringify(before, null, 2) + '  \n';
    const data = new Map([[SIMPLE_FARM_KEY, raw]]);
    let fail = true;
    const save = new FarmSave(
      {
        getItem: k => data.get(k) ?? null,
        setItem: (k, v) => {
          if (fail && k === SIMPLE_FARM_KEY) throw Error('quota');
          data.set(k, v);
        },
      },
      catalog
    );
    const migrated = save.load()!;
    assert.equal(data.size, 1, 'read-only parsing never writes');
    assert.throws(() => save.save(migrated), /quota/);
    assert.equal(data.get(SIMPLE_FARM_KEY), raw);
    assert.equal(data.get(SIMPLE_FARM_KEY + '.before-large-machines-v5'), raw);
    if (version < 4) assert.equal(data.get(SIMPLE_FARM_KEY + '.before-four-field-pens-v4'), raw);
    if (version === 2) assert.equal(data.get(SIMPLE_FARM_KEY + '.before-large-pens-v3'), raw);
    fail = false;
    save.save(migrated);
    save.save(migrated);
    assert.equal(data.get(SIMPLE_FARM_KEY + '.before-large-machines-v5'), raw);
    if (version < 4) assert.equal(data.get(SIMPLE_FARM_KEY + '.before-four-field-pens-v4'), raw);
    assert.deepEqual(save.load(), migrated);
    assert.deepEqual(save.importText(raw), migrated);
    assert.equal(data.get(SIMPLE_FARM_KEY + '.import-source'), raw);
    for (const corrupt of [
      { ...before, free: { ...before.free, inventory: { 'bad:item': 1 } } },
      { ...before, free: { ...before.free, buildingLayout: { version: 2, positions: { barn: { x: -13, y: -20 } } } } },
      { ...before, free: { ...before.free, buildingLayout: { version: 7, positions: {} } } },
    ]) {
      const prior = [...data];
      assert.throws(() => save.importText(JSON.stringify(corrupt)));
      assert.deepEqual([...data], prior);
    }
  }
});
