import { establishFarm, xpForLevel } from './fixtures/established-farm';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import assert from 'node:assert/strict';
import { historicalState } from './fixtures/historical-state';
import { machineSites, penDefinition } from '../assets/farm/scripts/core/FarmCatalog';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import {
  FARM_LAYOUT,
  buildingPosition,
  canMoveBuilding,
  checkLayout,
  groundError,
  movedLayout,
  snapPosition,
} from '../assets/farm/scripts/core/BuildingPlacement';
import { EMPTY_LAYOUT, FIELD_CLEARANCE } from '../assets/farm/scripts/core/constants/PlacementDefaults';
import { farmRoadLayout, roadFootprints } from '../assets/farm/scripts/core/FarmRoadLayout';
import type { BuildingPosition } from '../assets/farm/scripts/core/types/BuildingTypes';
import { diamond, overlaps, tooClose, translated } from '../assets/farm/scripts/core/BuildingGeometry';
import { PREVIOUS_FARM_LAYOUT } from '../assets/farm/scripts/core/legacy/PreviousFarmLayout';
import { PREVIOUS_PEN_LAYOUT } from '../assets/farm/scripts/core/legacy/PreviousPenLayout';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import { BuildingMoveController } from '../assets/farm/scripts/map/buildings/BuildingMoveController';
import { FarmModel } from '../assets/farm/scripts/map/FarmModel';
const catalog: FarmCatalog = loadFarmCatalog();
const clone = <T>(v: T): T => JSON.parse(JSON.stringify(v));
const settings = { speed: 1, sound: false, music: false };
const unlockAll = (g: FarmGame) => {
  g.state.coins = 1000000;
  g.state.xp = 100000000;
  g.state.husbandry = {
    version: 1,
    feedReceived: true,
    eggsCollected: true,
    milkCollected: true,
    burgerCollected: true,
  };
};
const owned = () => {
  const g = establishFarm(new FarmGame(catalog));
  // Historical layout fixtures predate paid land and own every crop field.
  for (const plot of g.state.plots) if (plot.group === 'crop') plot.unlocked = true;
  unlockAll(g);
  for (const t of g.machineTypes)
    if (!g.state.machines.some(m => m.type === t.id)) assert.equal(g.buyMachine(t.id).error, undefined);
  for (const p of catalog.residentPens!.filter(p => p.cell !== null))
    if (!g.residentPlot(p.cell!)!.residents) assert.equal(g.buyPen(p.cell!).error, undefined);
  return g;
};
function prepareSecond(game: FarmGame, buildingId: string) {
  game.state.xp = 100000000;
  const type = game.machineTypes.find(t => machineSites(t)[1] === buildingId);
  if (type && !game.state.machines.some(m => m.type === type.id))
    assert.equal(game.buyMachine(type.id).error, undefined);
  const site = catalog.residentPens!.find(p => p.buildingId === buildingId && p.ordinal === 2);
  if (site) {
    const first = catalog.residentPens!.find(p => p.species === site.species && p.ordinal === 1)!;
    if (!game.residentPlot(first.plotId!)!.residents) assert.equal(game.buyPen(first.plotId!).error, undefined);
  }
}
function alternative(id: string): BuildingPosition {
  const p = buildingPosition(id);
  for (let radius = 2; radius <= 12; radius++)
    for (const [dx, dy] of [
      [0, 1],
      [1, 0],
      [-1, 0],
      [0, -1],
      [1, 1],
      [-1, 1],
      [1, -1],
      [-1, -1],
    ]) {
      const q = snapPosition({ x: p.x + dx * radius * 36, y: p.y + dy * radius * 18 });
      if (!checkLayout(movedLayout(EMPTY_LAYOUT, id, q)).error) return q;
    }
  throw Error('No alternative for ' + id);
}
const alternatives = new Map(FARM_LAYOUT.buildings.map(b => [b.id, alternative(b.id)]));
test('terminal road art is inset along the same lane while saved road reservations stay unchanged', () => {
  const fixture = clone(FARM_LAYOUT);
  fixture.roadPlan!.paths = [
    {
      id: 'test-lane',
      points: [
        [0, 0],
        [0, -4],
      ],
    },
  ];
  const original = clone(fixture);
  original.roadPlan!.endInset = 0;
  const reserved = (m: typeof FARM_LAYOUT) =>
    roadFootprints(m)
      .map(p => JSON.stringify(p))
      .sort();
  assert.deepEqual(reserved(fixture), reserved(original));
  const roads = farmRoadLayout(fixture),
    old = farmRoadLayout(original);
  const ends = roads.tiles.filter(t => [1, 2, 4, 8].includes(t.mask));
  assert.equal(ends.filter(t => t.asset === 'DecorRoad02').length, 1);
  for (const end of ends) {
    const grid = old.tiles.find(t => t.id === end.id)!;
    const neighbour = roads.tiles.find(t => Math.abs(t.u - end.u) + Math.abs(t.v - end.v) === 1)!;
    assert.equal(end.x, (grid.x + neighbour.x) / 2);
    assert.equal(end.y, (grid.y + neighbour.y) / 2);
  }
  for (const t of roads.tiles.filter(t => !ends.includes(t)))
    assert.deepEqual(
      t,
      old.tiles.find(o => o.id === t.id)
    );
});
function memory() {
  let fail = false;
  const data = new Map<string, string>();
  const saver = new FarmSave(
    {
      getItem: k => data.get(k) ?? null,
      setItem: (k, v) => {
        if (fail && k === SIMPLE_FARM_KEY) throw Error('quota');
        data.set(k, v);
      },
    },
    catalog
  );
  return {
    saver,
    data,
    fail: (value: boolean) => {
      fail = value;
    },
  };
}
test('roads and their reservations are removed, and all twenty-six buildings have another usable position', () => {
  assert.equal(FARM_LAYOUT.buildings.length, 26);
  assert.equal(FARM_LAYOUT.obstacles.filter(o => /^R\d/.test(o.id)).length, 40);
  assert.equal(checkLayout(EMPTY_LAYOUT).error, null);
  const roads = farmRoadLayout(FARM_LAYOUT);
  assert.deepEqual(roads.links, []);
  assert.deepEqual(roads.tiles, []);
  assert.deepEqual(roadFootprints(FARM_LAYOUT), []);
  assert.equal(
    owned().moveBuilding('barn', { x: -1400, y: 0 }).error,
    undefined,
    'open village ground outside the enlarged yards remains usable'
  );
  const authored = JSON.parse(
    fs.readFileSync(path.resolve(__dirname, '../source-assets/farm-beautify/placements.json'), 'utf8')
  );
  assert.deepEqual(
    roads.tiles,
    authored.placements.filter((p: any) => p.zone === 'roads').map(({ group, ...p }: any) => p)
  );
  for (const b of FARM_LAYOUT.buildings) {
    const g = owned();
    g.state.xp = 100000000;
    for (const t of g.machineTypes) assert.equal(g.buyMachine(t.id).error, undefined);
    for (const id of [50, 51, 52, 53]) assert.equal(g.buyPen(id).error, undefined);
    const before = clone(g.state),
      p = alternatives.get(b.id)!;
    assert.equal(g.moveBuilding(b.id, p).error, undefined, b.id);
    assert.notDeepEqual(p, b.position);
    assert.deepEqual({ ...g.state, buildingLayout: before.buildingLayout }, before);
    assert.deepEqual(new FarmGame(catalog, g.state).state, g.state);
    assert.equal(checkLayout(g.state.buildingLayout!).error, null);
  }
  console.log('Verified alternative placements:', Object.fromEntries(alternatives));
});
test('fixed fields, other buildings, borders and unknown IDs reject placement', () => {
  const g = establishFarm(new FarmGame(catalog)),
    before = clone(g.state);
  for (const id of ['R001', 'pen:16', 'MainObject-gieng', '__proto__'])
    assert.equal(canMoveBuilding(g.state, id), false);
  for (const p of [{ x: -13, y: -20 }, buildingPosition('feed-1'), { x: 9000, y: 0 }, { x: NaN, y: 0 }])
    assert.ok(g.moveBuilding('barn', p).error);
  assert.ok(
    g.moveBuilding('farm-house', { x: -432, y: 324 }).error,
    'house foundation cannot enter the pond even when its roof is above it'
  );
  assert.deepEqual(g.state, before);
  assert.deepEqual(snapPosition({ x: 37, y: 19 }), { x: 36, y: 18 });
  assert.deepEqual(snapPosition(snapPosition({ x: -79, y: 93 })), snapPosition({ x: -79, y: 93 }));
  const manifest = clone(FARM_LAYOUT);
  manifest.fieldEntrance = { x: -13, y: -20 };
  assert.equal(groundError(EMPTY_LAYOUT, manifest), null);
  assert.deepEqual(
    farmRoadLayout(manifest).tiles,
    farmRoadLayout(FARM_LAYOUT).tiles,
    'entrances never reroute authored roads'
  );
});

test('saved v2 placements near the old rounded corners keep their position and farm state while the layout version advances', () => {
  const game = owned();
  for (const item of game.items) game.state.inventory[item.key] = 100;
  assert.equal(game.plant(0, 10).error, undefined);
  assert.equal(game.feedAnimals(12).error, undefined);
  const saved = historicalState(game.state);
  saved.buildingLayout = { version: 2, positions: { barn: { x: -576, y: -936 } } };
  assert.equal(
    groundError(saved.buildingLayout, PREVIOUS_FARM_LAYOUT),
    null,
    'this position was valid in the shipped rounded clearing'
  );
  const before = clone(saved);
  const expected = new FarmGame(catalog, saved).state;
  assert.equal(expected.buildingLayout!.version, 6);
  assert.deepEqual(
    buildingPosition('barn', expected.buildingLayout),
    before.buildingLayout!.positions.barn,
    'a valid saved corner placement needs no relocation'
  );
  assert.deepEqual(
    Object.keys(expected.buildingLayout!.positions).sort(),
    ['barn', 'dairy-1'],
    'only the new dairy default yields to the saved barn'
  );
  assert.deepEqual(
    { ...historicalState(expected), buildingLayout: before.buildingLayout },
    before,
    'all farm assets and paid activity stay exact'
  );
  const pack = farmPack(saved, settings);
  assert.deepEqual(
    memory().saver.parse(JSON.stringify(pack)),
    farmPack(expected, settings),
    'the same save remains loadable through storage'
  );
  assert.deepEqual(saved, before, 'loading never changes the input state');
});

test('unbuilt sites reject new movement while old saved reservations survive purchase and become movable', () => {
  const fresh = new FarmGame(catalog),
    future = FARM_LAYOUT.buildings.filter(b => !canMoveBuilding(fresh.state, b.id));
  assert.equal(future.length, 24, 'all sixteen factories and eight pens must be purchased');
  for (const b of future) {
    const g = new FarmGame(catalog);
    unlockAll(g);
    if (b.kind === 'pen') assert.equal(g.buyMachine(5).error, undefined);
    prepareSecond(g, b.id);
    const before = clone(g.state),
      p = alternatives.get(b.id)!;
    assert.equal(canMoveBuilding(g.state, b.id), false, b.id);
    assert.ok(g.moveBuilding(b.id, p).error);
    assert.deepEqual(g.state, before);
    const controller = new BuildingMoveController(() => g.state);
    controller.start();
    assert.equal(controller.select(b.id), false);
    assert.equal(controller.selected, null);
    assert.equal(controller.candidate, null);
    const visitor = new FarmGame(catalog);
    assert.equal(
      visitor.moveBuilding('barn', buildingPosition(b.id)).error,
      undefined,
      'a hidden site no longer blocks usable ground'
    );
    // Shipped saves allowed moving a ghost before buying it. Loading preserves those bytes' meaning.
    const saved = clone(before);
    saved.buildingLayout = movedLayout(saved.buildingLayout!, b.id, p);
    const pack = farmPack(saved, settings),
      reloaded = new FarmGame(catalog, memory().saver.parse(JSON.stringify(pack)).free);
    assert.deepEqual(reloaded.state, saved, 'loading keeps IDs, resources, jobs and the hidden custom position');
    if (b.kind === 'machine') {
      const type = reloaded.machineTypes.find(t => machineSites(t).includes(b.id))!;
      assert.equal(reloaded.buyMachine(type.id).error, undefined);
      assert.ok(reloaded.state.machines.some(m => m.buildingId === b.id));
    } else {
      const plot = reloaded.state.plots.find(plot => 'pen:' + plot.id === b.id)!;
      const animalId = reloaded.state.nextId;
      assert.equal(reloaded.buyPen(plot.id).error, undefined);
      assert.deepEqual(plot.residents!.animals, [{ id: animalId, slot: 0, job: null }]);
    }
    assert.deepEqual(buildingPosition(b.id, reloaded.state.buildingLayout), p);
    assert.equal(canMoveBuilding(reloaded.state, b.id), true);
    assert.equal(
      reloaded.moveBuilding(b.id, b.position).error,
      undefined,
      'a purchased site is movable like existing buildings'
    );
    assert.equal(checkLayout(reloaded.state.buildingLayout!).error, null);
    assert.deepEqual(new FarmGame(catalog, reloaded.state).state, reloaded.state);
  }
});

test('buying on occupied former sites finds nearby free ground and preserves existing jobs, assets and positions', () => {
  const fresh = establishFarm(new FarmGame(catalog)),
    future = FARM_LAYOUT.buildings.filter(b => !canMoveBuilding(fresh.state, b.id));
  for (const b of future) {
    const g = establishFarm(new FarmGame(catalog));
    unlockAll(g);
    prepareSecond(g, b.id);
    for (const item of g.items) g.state.inventory[item.key] = 100;
    assert.equal(g.plant(0, g.catalog.farm[0].id).error, undefined);
    assert.equal(g.feedAnimals(12).error, undefined);
    const machine = g.state.machines[0],
      recipe = g.catalog.products.find(p => p.machine === machine.type)!;
    assert.equal(g.produce(recipe.id, machine.id).error, undefined);
    assert.equal(g.moveBuilding('barn', b.position).error, undefined);
    assert.equal(checkLayout(g.state.buildingLayout!, g.state).error, null);
    assert.ok(
      checkLayout(g.state.buildingLayout!).error,
      'the former full-reservation check detects the occupied hidden preference'
    );
    const before = clone(g.state),
      loaded = new FarmGame(catalog, before);
    assert.deepEqual(
      loaded.state,
      before,
      'new saves with occupied hidden preferences reload without migration or relocation'
    );
    const type = g.machineTypes.find(t => machineSites(t).includes(b.id)),
      plot = g.state.plots.find(p => 'pen:' + p.id === b.id);
    const price = type ? g.machinePurchasePrice(type.id)! : g.penPurchasePrice(plot!.id)!;
    const buy = (game: FarmGame) => (type ? game.buyMachine(type.id) : game.buyPen(plot!.id));
    assert.equal(buy(g).error, undefined);
    assert.equal(buy(loaded).error, undefined);
    assert.deepEqual(g.state, loaded.state, 'nearest placement is deterministic');
    const position = buildingPosition(b.id, g.state.buildingLayout);
    assert.notDeepEqual(position, b.position);
    assert.deepEqual(position, snapPosition(position));
    assert.equal(checkLayout(g.state.buildingLayout!, g.state).error, null);
    assert.deepEqual(
      buildingPosition('barn', g.state.buildingLayout),
      b.position,
      'the existing building never moves to make room'
    );
    const expected = clone(before);
    expected.coins -= price;
    expected.buildingLayout = movedLayout(before.buildingLayout!, b.id, position);
    if (type)
      expected.machines.push({
        id: Math.max(...before.machines.map(m => m.id)) + 1,
        type: type.id,
        capacity: 1,
        job: null,
        waiting: [],
        tray: [],
        buildingId: b.id,
      });
    else {
      const p = expected.plots.find(p => p.id === plot!.id)!;
      p.unlocked = true;
      p.residents = {
        species: penDefinition(catalog, p)!.species,
        capacity: 1,
        animals: [{ id: expected.nextId++, slot: 0, job: null }],
      };
    }
    assert.deepEqual(g.state, expected, 'only purchase ownership, its included animal, price and new position change');
    assert.deepEqual(memory().saver.parse(JSON.stringify(farmPack(g.state, settings))).free, expected);
  }
});

test('placement cache includes ownership and still rejects collisions between constructed buildings', () => {
  const g = new FarmGame(catalog),
    id = 'grill-1',
    type = g.machineTypes.find(t => machineSites(t).includes(id))!;
  const layout = movedLayout(g.state.buildingLayout!, 'barn', buildingPosition(id));
  assert.equal(checkLayout(layout, g.state).error, null);
  const constructed = clone(g.state);
  constructed.buildingLayout = layout;
  constructed.machines.push({ id: 3, type: type.id, buildingId: id, capacity: 1, job: null, waiting: [], tray: [] });
  assert.match(checkLayout(layout, constructed).error!, /vướng/);
  assert.throws(() => new FarmGame(catalog, constructed), /vướng/);
  assert.equal(
    checkLayout(layout, g.state).error,
    null,
    'a result for the same coordinates with different ownership cannot leak from cache'
  );
});

test('no available ground rejects machine and pen purchases without charging or allocating anything', () => {
  const g = establishFarm(new FarmGame(catalog));
  unlockAll(g);
  const before = clone(g.state);
  // A closed buildable area exercises the exhaustion branch without adding a production-only test hook.
  const blocked = {
    id: 'closed-area-test',
    polygon: [
      { x: -10000, y: -10000 },
      { x: 10000, y: -10000 },
      { x: 10000, y: 10000 },
      { x: -10000, y: 10000 },
    ],
  };
  FARM_LAYOUT.obstacles.unshift(blocked);
  try {
    assert.match(g.buyMachine(g.machineTypes.find(t => machineSites(t).includes('grill-1'))!.id).error!, /chỗ trống/);
    assert.deepEqual(g.state, before);
    assert.match(g.buyPen(14).error!, /chỗ trống/);
    assert.deepEqual(g.state, before);
  } finally {
    assert.equal(FARM_LAYOUT.obstacles.shift(), blocked);
  }
});

test('a failed purchase save keeps the old farm and retry publishes the same relocated building once', () => {
  for (const id of ['grill-1', 'pen:14']) {
    const mem = memory(),
      session = new GameSession(catalog, mem.saver, () => 0),
      g = establishFarm(session.game);
    unlockAll(g);
    assert.equal(g.moveBuilding('barn', buildingPosition(id)).error, undefined);
    session.save();
    const before = clone(g.state),
      stored = mem.data.get(SIMPLE_FARM_KEY),
      type = g.machineTypes.find(t => machineSites(t).includes(id));
    const action = type
      ? { type: 'buyMachine' as const, machineType: type.id, building: id }
      : { type: 'buyPen' as const, plot: 14 };
    mem.fail(true);
    assert.equal(session.dispatch(action).ok, false);
    assert.deepEqual(session.game.state, before);
    assert.equal(mem.data.get(SIMPLE_FARM_KEY), stored);
    const pending = clone(session.pendingPack!.free);
    assert.notDeepEqual(buildingPosition(id, pending.buildingLayout), buildingPosition(id));
    assert.equal(checkLayout(pending.buildingLayout!, pending).error, null);
    mem.fail(false);
    assert.equal(session.retrySave(), true);
    assert.deepEqual(session.game.state, pending);
    assert.deepEqual(mem.saver.load()!.free, pending);
    assert.equal(session.dispatch(action).ok, false, 'repeat purchase does not charge twice');
    assert.deepEqual(session.game.state, pending);
  }
});

test('map visibility follows constructed pens and reveals only the next crop purchase', () => {
  const data = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../assets/resources/ported/game.json'), 'utf8'));
  const game = new FarmGame(catalog),
    model = new FarmModel(data.scene, data.runtime, () => game, [], FARM_LAYOUT.bounds);
  const visible = () => game.state.plots.filter(p => model.isVisiblePlot(p));
  const crops = game.state.plots.filter(p => p.group === 'crop');
  assert.equal(visible().length, 7);
  assert.equal(crops.length, 40);
  assert.deepEqual(
    visible().filter(p => p.group === 'pen'),
    []
  );
  for (const p of catalog.residentPens!.map(site => game.residentPlot(site.plotId!)!)) {
    assert.equal(game.isActivePlot(p), true, 'available to shop catalog and buyPen');
    assert.equal(model.isVisiblePlot(p), false, 'no invisible map hit target before building');
  }
  unlockAll(game);
  assert.equal(visible().length, 7, 'progression alone does not construct a yard or buy a field');
  assert.equal(game.buyMachine(5).error, undefined);
  for (const id of [12, 13, 14, 15]) {
    assert.equal(game.buyPen(id).error, undefined);
    assert.equal(
      model.isVisiblePlot(game.residentPlot(id)!),
      true,
      'the purchased yard and its first animal become visible together'
    );
  }
  assert.equal(visible().length, 11);
  const before = clone(crops);
  crops[0].unlocked = false;
  assert.equal(model.isVisiblePlot(crops[0]), true, 'locked crop plots retain their map purchase affordance');
  crops[0].unlocked = before[0].unlocked;
  assert.deepEqual(crops, before);
});
test('state v5 migration validates before normalizing, preserves raw bytes once and imports reject malformed layout before writes', () => {
  const g = owned();
  g.state.xp = xpForLevel(g, g.product(7)!.requiredLevel!);
  for (const item of g.items) g.state.inventory[item.key] = 100;
  g.expandQueue(0);
  g.produce(7, 0);
  g.produce(7, 0);
  g.expandPen(12);
  g.feedAnimals(12);
  const old: any = farmPack(historicalState(g.state), settings);
  old.version = 4;
  old.free.version = 5;
  delete old.free.buildingLayout;
  const raw = JSON.stringify(old, null, 3) + '  \n',
    mem = memory();
  mem.data.set(SIMPLE_FARM_KEY, raw);
  const parsed = mem.saver.parse(raw);
  assert.equal(mem.data.size, 1);
  assert.equal(parsed.version, 6);
  assert.equal(parsed.free.version, 7);
  assert.deepEqual(parsed.free, g.state);
  mem.saver.save(parsed);
  assert.equal(mem.data.get(SIMPLE_FARM_KEY + '.before-layout-v6'), raw);
  mem.saver.save(parsed);
  assert.equal(mem.data.get(SIMPLE_FARM_KEY + '.before-layout-v6'), raw);
  const malformed = clone(old);
  malformed.free.inventory['bad:item'] = 1;
  assert.throws(() => new FarmGame(catalog, malformed.free));
  for (const layout of [
    null,
    { version: 7, positions: {} },
    { version: 2, positions: { R001: { x: 0, y: 0 } } },
    { version: 2, positions: { barn: { x: '0', y: 0 } } },
    { version: 2, positions: { barn: { x: -13, y: -20 } } },
  ]) {
    const pack = clone(parsed);
    (pack.free as any).buildingLayout = layout;
    const before = [...mem.data];
    assert.throws(() => mem.saver.importText(JSON.stringify(pack)));
    assert.deepEqual([...mem.data], before);
  }
  for (const corrupt of ['null', 'false', '{broken', '{"contentProfile":"simple-1","free":"corrupt"}']) {
    mem.data.set(SIMPLE_FARM_KEY, corrupt);
    mem.saver.importText(JSON.stringify(parsed));
    assert.equal(mem.data.get(SIMPLE_FARM_KEY + '.before-import'), corrupt);
    assert.deepEqual(mem.saver.load(), parsed);
  }
});

test('all buildings still clear all forty fields after roads are removed', () => {
  const game = owned(),
    before = clone(game.state),
    fields = FARM_LAYOUT.obstacles.filter(o => /^R\d/.test(o.id));
  for (const b of FARM_LAYOUT.buildings) {
    for (const footprint of b.footprints.map(f => translated(f, b.position))) {
      for (const field of fields)
        assert.equal(tooClose(footprint, field.polygon, FIELD_CLEARANCE), false, b.id + '/' + field.id);
    }
    const center = b.footprints[0].reduce(
      (p, q) => ({ x: p.x + q.x / b.footprints[0].length, y: p.y + q.y / b.footprints[0].length }),
      { x: 0, y: 0 }
    );
    for (const field of fields) {
      const p = field.polygon.reduce(
        (p, q) => ({ x: p.x + q.x / field.polygon.length, y: p.y + q.y / field.polygon.length }),
        { x: 0, y: 0 }
      );
      assert.ok(game.moveBuilding(b.id, { x: p.x - center.x, y: p.y - center.y }).error, b.id + '/' + field.id);
    }
  }
  assert.deepEqual(game.state, before, 'all forbidden field placements leave assets and positions unchanged');
  const a = diamond(0, 0, 100, 50),
    near = diamond(0, 70, 100, 50),
    far = diamond(0, 100, 100, 50);
  assert.equal(overlaps(a, near), false);
  assert.equal(tooClose(a, near, FIELD_CLEARANCE), true, 'near misses still need a gap');
  assert.equal(tooClose(a, far, FIELD_CLEARANCE), false);
});

test('saved placements on removed roads survive migration and import without losing farm assets', () => {
  const game = owned();
  for (const item of game.items) game.state.inventory[item.key] = 100;
  game.plant(0, 10);
  game.expandQueue(0);
  game.produce(9, 0);
  game.produce(10, 0);
  game.feedAnimals(12);
  const old = farmPack(historicalState(game.state), settings);
  old.free.buildingLayout = { version: 1, positions: {} };
  // This saved open-ground position remains clear after the three new sites are added.
  old.free.buildingLayout.positions.barn = { x: 347, y: 290 };
  old.free.buildingLayout.positions['bakery-1'] = { x: 684, y: 162 };
  assert.equal(groundError(old.free.buildingLayout, PREVIOUS_FARM_LAYOUT), null);
  assert.equal(groundError({ ...old.free.buildingLayout, version: 2 }, PREVIOUS_PEN_LAYOUT), null);
  assert.ok(groundError(old.free.buildingLayout), 'the new yard intersects this otherwise valid old barn placement');
  const raw = JSON.stringify(old, null, 2) + '  \n',
    mem = memory();
  mem.data.set(SIMPLE_FARM_KEY, raw);
  const migrated = mem.saver.parse(raw);
  assert.equal(mem.data.size, 1, 'parsing never writes');
  assert.equal(migrated.free.buildingLayout!.version, 6);
  assert.equal(checkLayout(migrated.free.buildingLayout!, migrated.free).error, null);
  assert.deepEqual(
    { ...historicalState(migrated.free), buildingLayout: old.free.buildingLayout },
    old.free,
    'wallet, crops, jobs, queues and residents survive'
  );
  assert.deepEqual(mem.saver.parse(raw), migrated, 'repair is deterministic');
  assert.notDeepEqual(
    buildingPosition('bakery-1', migrated.free.buildingLayout),
    { x: 684, y: 162 },
    'the enlarged factory now yields to the unchanged saved barn'
  );
  assert.deepEqual(
    migrated.free.buildingLayout!.positions.barn,
    { x: 347, y: 290 },
    'an enlarged pen yields to the saved barn'
  );
  assert.deepEqual(
    new FarmGame(catalog, { ...old.free, buildingLayout: { version: 1, positions: {} } }).state.buildingLayout,
    EMPTY_LAYOUT,
    'untouched sites follow the newly authored map'
  );
  for (const b of PREVIOUS_FARM_LAYOUT.buildings) {
    const p = buildingPosition(b.id, migrated.free.buildingLayout);
    assert.ok(Number.isFinite(p.x) && Number.isFinite(p.y));
    const oldPositions = Object.fromEntries(
      PREVIOUS_FARM_LAYOUT.buildings.map(b => [b.id, old.free.buildingLayout!.positions[b.id] ?? b.position])
    );
    if (
      Object.prototype.hasOwnProperty.call(old.free.buildingLayout!.positions, b.id) &&
      !groundError({ version: 2, positions: oldPositions }, FARM_LAYOUT, b.id)
    )
      assert.deepEqual(p, oldPositions[b.id], 'keep valid old placement ' + b.id);
  }
  mem.saver.save(migrated);
  assert.equal(mem.data.get(SIMPLE_FARM_KEY + '.before-fixed-roads-v2'), raw);
  mem.saver.save(migrated);
  assert.equal(mem.data.get(SIMPLE_FARM_KEY + '.before-fixed-roads-v2'), raw);
  assert.deepEqual(mem.saver.load(), migrated);
  const malformed = clone(old);
  malformed.free.inventory['invalid:item'] = 1;
  const bytes = [...mem.data];
  assert.throws(() => mem.saver.importText(JSON.stringify(malformed)));
  assert.deepEqual([...mem.data], bytes);
  const onRoad = clone(migrated);
  onRoad.free.buildingLayout = movedLayout(migrated.free.buildingLayout!, 'barn', { x: 347, y: 290 });
  mem.saver.importText(JSON.stringify(onRoad));
  assert.deepEqual(
    mem.saver.load()!.free.buildingLayout!.positions.barn,
    { x: 347, y: 290 },
    'no invisible road restriction remains during import'
  );
});
test('arranging freezes production, keeps draft out of autosave, restores pause and commits failed writes only after retry', () => {
  const mem = memory(),
    s = new GameSession(catalog, mem.saver, () => 0);
  s.save();
  s.paused = true;
  s.enterMenu();
  s.beginLayout();
  assert.equal(s.paused, true);
  assert.equal(s.layoutEditing, true);
  const start = s.game.state.time;
  s.tick(3);
  assert.equal(s.game.state.time, start);
  assert.equal(s.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, false);
  const move = new BuildingMoveController(() => s.game.state);
  move.start();
  move.select('barn');
  move.grab(buildingPosition('barn'));
  move.drag(alternatives.get('barn')!);
  assert.equal(move.canPlace, true, 'ready immediately, even before the next frame');
  s.tick(3);
  assert.deepEqual(mem.saver.load()!.free.buildingLayout, EMPTY_LAYOUT);
  const action = { type: 'moveBuilding' as const, building: 'barn', position: move.candidate! };
  mem.fail(true);
  assert.equal(s.dispatch(action).ok, false);
  assert.deepEqual(s.game.state.buildingLayout, EMPTY_LAYOUT);
  assert.equal(s.storageFailed, true);
  assert.deepEqual(s.pendingPack!.free.buildingLayout!.positions.barn, action.position);
  mem.fail(false);
  assert.equal(s.retrySave(), true);
  assert.deepEqual(s.game.state.buildingLayout!.positions.barn, action.position);
  assert.equal(s.layoutEditing, false);
  s.paused = true;
  s.beginLayout();
  s.endLayout();
  assert.equal(s.paused, true);
  s.paused = false;
  s.beginLayout();
  s.endLayout();
  assert.equal(s.canAct, true);
  s.beginLayout();
  assert.equal(s.restart(), true);
  assert.deepEqual(s.game.state.buildingLayout, EMPTY_LAYOUT);
});
