import { establishFarm } from './fixtures/established-farm';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import assert from 'node:assert/strict';
import { xpToNext } from '../assets/farm/scripts/core/Progression';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { FarmGame, orderedCrops } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import type { FarmState } from '../assets/farm/scripts/core/types/StateTypes';
import type { ActionResult } from '../assets/farm/scripts/core/types/ActionTypes';
import { penPlotId, penBuildingId, machineSites } from '../assets/farm/scripts/core/FarmCatalog';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import {
  FARM_LAYOUT,
  buildingPosition,
  canMoveBuilding,
  checkLayout,
  groundError,
  movedLayout,
  snapPosition,
} from '../assets/farm/scripts/core/BuildingPlacement';
import { EMPTY_LAYOUT } from '../assets/farm/scripts/core/constants/PlacementDefaults';
import { PREVIOUS_SINGLE_BUILDING_LAYOUT } from '../assets/farm/scripts/core/legacy/PreviousSingleBuildingLayout';
import { FarmModel } from '../assets/farm/scripts/map/FarmModel';
import { machineArtBounds } from '../assets/farm/scripts/map/buildings/MachinePresentation';
import { herdHitBox } from '../assets/farm/scripts/map/buildings/HerdPresentation';

const catalog: FarmCatalog = loadFarmCatalog();
const oldCatalog: FarmCatalog = JSON.parse(
  fs.readFileSync(path.join(__dirname, 'fixtures/single-building-v6.json'), 'utf8')
);
const copy = <T>(v: T): T => JSON.parse(JSON.stringify(v));
const ok = (r: ActionResult) => assert.equal(r.error, undefined, r.error);
const settings = { speed: 1, sound: false, music: false };
const xpFor = (level: number) =>
  Array.from({ length: level - 1 }, (_, i) => xpToNext(i + 1)).reduce((a, b) => a + b, 0);
function funded(xp = 100000000) {
  const g = establishFarm(new FarmGame(catalog));
  g.state.coins = 1000000;
  g.state.xp = xp;
  g.state.husbandry = {
    version: 1,
    feedReceived: true,
    eggsCollected: true,
    milkCollected: true,
    burgerCollected: true,
  };
  return g;
}
function memory(state?: FarmState) {
  const data = new Map<string, string>();
  let fail = false;
  if (state) data.set(SIMPLE_FARM_KEY, JSON.stringify(farmPack(state, settings)));
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
    data,
    saver,
    fail: (v: boolean) => {
      fail = v;
    },
  };
}

test('catalog has two sites per species/type, preserves all first sites and products, and fresh farm grants no production buildings', () => {
  assert.deepEqual(
    catalog.farm.map(f => f.id),
    oldCatalog.farm.map(f => f.id)
  );
  assert.deepEqual(
    catalog.products.map(r => r.id),
    oldCatalog.products.map(r => r.id)
  );
  assert.deepEqual(
    catalog.items!.map(i => i.key),
    oldCatalog.items!.map(i => i.key)
  );
  assert.deepEqual(
    catalog.livestock!.map(a => a.key),
    oldCatalog.livestock!.map(a => a.key)
  );
  for (const type of catalog.machineTypes!) {
    assert.equal(type.buildSites!.length, 2);
    assert.ok(type.buildSites![1].requiredLevel > type.buildSites![0].requiredLevel);
    assert.equal(type.buildSites![0].buildingId, oldCatalog.machineTypes!.find(t => t.id === type.id)!.buildingIds![0]);
  }
  for (const animal of catalog.livestock!) {
    const sites = catalog.residentPens!.filter(s => s.species === animal.key);
    assert.equal(sites.length, 2);
    assert.ok(sites[1].requiredLevel! > sites[0].requiredLevel!);
  }
  const g = new FarmGame(catalog);
  assert.equal(g.state.version, 7);
  assert.equal(g.state.buildingLayout!.version, 6);
  assert.equal(farmPack(g.state, settings).version, 6);
  assert.equal(g.state.plots.length, 54);
  assert.equal(orderedCrops(g.state.plots).length, 40);
  assert.deepEqual(
    g.state.plots.filter(p => p.residents),
    []
  );
  assert.deepEqual(g.state.machines, []);
  assert.deepEqual(new FarmGame(catalog, g.state).state, g.state);
  assert.deepEqual(
    g.state.plots.slice(50).map(p => [p.id, p.cell, p.group, p.unlocked, p.residents]),
    [50, 51, 52, 53].map(id => [id, null, 'pen', false, null])
  );
});

test('every second factory and pen is blocked below its own level threshold and buys once at the threshold', () => {
  for (const type of catalog.machineTypes!) {
    const g = funded();
    if (!g.state.machines.some(m => m.type === type.id)) ok(g.buyMachine(type.id, machineSites(type)[0]));
    const required = type.buildSites![1].requiredLevel,
      threshold = xpFor(required);
    g.state.xp = threshold - 1;
    const offer = g.machineConstructionOffer(type.id),
      before = copy(g.state);
    assert.equal(offer.count, 1);
    assert.equal(offer.reason, `Cần level ${required}`);
    assert.equal(g.buyMachine(type.id, offer.buildingId!).error, `Cần level ${required}`);
    assert.deepEqual(g.state, before);
    g.state.xp = threshold;
    const expected = copy(g.state),
      id = Math.max(...g.state.machines.map(m => m.id)) + 1;
    expected.coins -= offer.price!;
    expected.machines.push({
      id,
      type: type.id,
      buildingId: offer.buildingId,
      capacity: 1,
      job: null,
      waiting: [],
      tray: [],
    });
    ok(g.buyMachine(type.id, offer.buildingId!));
    assert.deepEqual(g.state, expected);
    for (const site of [undefined, machineSites(type)[0], offer.buildingId!]) {
      assert.ok(g.buyMachine(type.id, site).error);
      assert.deepEqual(g.state, expected);
    }
    assert.equal(g.machineConstructionOffer(type.id).count, 2);
    assert.equal(g.machinePurchasePrice(type.id), null);
    g.validate();
  }
  for (const animal of catalog.livestock!) {
    const g = funded(),
      sites = catalog.residentPens!.filter(s => s.species === animal.key);
    if (!g.residentPlot(penPlotId(sites[0]))!.residents) ok(g.buyPen(penPlotId(sites[0])));
    const required = sites[1].requiredLevel!,
      threshold = xpFor(required);
    g.state.xp = threshold - 1;
    const offer = g.penConstructionOffer(animal.key),
      before = copy(g.state);
    assert.equal(offer.reason, `Cần level ${required}`);
    assert.equal(g.buyPen(offer.plotId!).error, offer.reason);
    assert.deepEqual(g.state, before);
    g.state.xp = threshold;
    const expected = copy(g.state),
      p = expected.plots.find(p => p.id === offer.plotId)!;
    expected.coins -= offer.price!;
    p.unlocked = true;
    p.residents = { species: animal.key, capacity: 1, animals: [{ id: expected.nextId++, slot: 0, job: null }] };
    ok(g.buyPen(offer.plotId!));
    assert.deepEqual(g.state, expected);
    assert.ok(g.buyPen(offer.plotId!).error);
    assert.deepEqual(g.state, expected);
    assert.equal(g.penConstructionOffer(animal.key).count, 2);
    assert.equal(g.penConstructionOffer(animal.key).price, null);
    g.validate();
  }
});

test('level never bypasses first-house order, content milestones or affordability', () => {
  const g = funded();
  g.state.husbandry!.milkCollected = false;
  let before = copy(g.state);
  assert.ok(g.buyPen(14).error);
  assert.ok(g.buyPen(52).error);
  assert.deepEqual(g.state, before);
  g.state.husbandry!.milkCollected = true;
  assert.ok(g.buyPen(52).error, 'first pig pen must be owned');
  assert.ok(g.buyMachine(2, 'grill-2').error, 'first grill must be owned');
  g.state.coins = 329;
  before = copy(g.state);
  assert.ok(g.buyPen(50).error);
  assert.deepEqual(g.state, before);
  g.state.coins = 499;
  before = copy(g.state);
  assert.ok(g.buyMachine(5, 'feed-2').error);
  assert.deepEqual(g.state, before);
});

test('second houses keep independent paid slots, residents, jobs, boosts and collections while sharing only the wallet and stock', () => {
  const g = funded();
  for (const item of g.items) g.state.inventory[item.key] = 50;
  ok(g.buyMachine(5, 'feed-2'));
  const second = g.state.machines.find(m => m.buildingId === 'feed-2')!;
  const first = g.state.machines.find(m => m.buildingId === 'feed-1')!,
    r = catalog.products.find(r => r.machine === 5)!;
  ok(g.produce(r.id, first.id));
  const untouched = copy(first);
  ok(g.expandQueue(second.id));
  ok(g.produce(r.id, second.id));
  ok(g.produce(r.id, second.id));
  ok(g.cancelQueued(second.id, second.waiting[0].id));
  assert.deepEqual(first, untouched);
  ok(g.buyPen(50));
  const firstPen = copy(g.state.plots[12].residents);
  ok(g.expandPen(50, 1));
  ok(g.feedAnimals(50));
  assert.deepEqual(g.state.plots[12].residents, firstPen);
  const pen = g.state.plots[50].residents!,
    otherAnimal = copy(pen.animals[1]);
  const eggs = g.quantity('farm40:egg');
  ok(g.boostAnimal(50, pen.animals[0].id));
  assert.deepEqual(pen.animals[1], otherAnimal);
  assert.equal(g.quantity('farm40:egg'), eggs);
  ok(g.collectAnimals(50, pen.animals[0].id));
  assert.equal(g.quantity('farm40:egg'), eggs + 1);
  assert.deepEqual(g.state.plots[12].residents, firstPen);
  g.validate();
});

test('new default buildings keep every house center clear of foreground artwork and expanded status badges', () => {
  const boxes = FARM_LAYOUT.buildings
    .filter(b => b.kind !== 'facility')
    .map(b => {
      const type = catalog.machineTypes!.find(t => machineSites(t).includes(b.id)),
        hit = herdHitBox('layer');
      const bounds = type
        ? machineArtBounds(type.prefab!, b.position)
        : {
            left: b.position.x - hit.w / 2,
            right: b.position.x + hit.w / 2,
            bottom: b.position.y + hit.y - hit.h / 2,
            top: b.position.y + hit.y + hit.h / 2,
          };
      return {
        id: b.id,
        ground: b.position.y,
        x: (bounds.left + bounds.right) / 2,
        y: (bounds.top + bounds.bottom) / 2,
        ...bounds,
      };
    });
  const old = new Set(PREVIOUS_SINGLE_BUILDING_LAYOUT.buildings.map(b => b.id));
  for (const front of boxes)
    for (const target of boxes) {
      if (front === target || (old.has(front.id) && old.has(target.id))) continue;
      const inArt =
        front.ground <= target.ground &&
        target.x >= front.left &&
        target.x <= front.right &&
        target.y >= front.bottom &&
        target.y <= front.top;
      const inBadge = Math.abs(front.x - target.x) <= 198 && target.y >= front.top && target.y <= front.top + 149;
      assert.equal(inArt || inBadge, false, front.id + ' obscures the tap center of ' + target.id);
    }
});

test('all 24 production buildings fit; second pens resolve separate map geometry and move without moving their first house', () => {
  const g = funded();
  for (const t of g.machineTypes) while (g.machinePurchasePrice(t.id) !== null) ok(g.buyMachine(t.id));
  for (const site of catalog.residentPens!)
    if (!g.residentPlot(penPlotId(site))!.residents) ok(g.buyPen(penPlotId(site)));
  assert.equal(g.state.machines.length, 16);
  assert.equal(g.state.plots.filter(p => p.residents).length, 8);
  assert.equal(FARM_LAYOUT.buildings.length, 26);
  assert.equal(groundError(EMPTY_LAYOUT), null);
  assert.equal(checkLayout(g.state.buildingLayout!, g.state).error, null);
  assert.deepEqual(FARM_LAYOUT.obstacles, PREVIOUS_SINGLE_BUILDING_LAYOUT.obstacles);
  const cell = {
    matrix: [1, 0, 0, 1, 0, 0],
    widget: { width: 386, height: 230 },
    collider: { center: [0, 0], size: [386, 230] },
  };
  const cells = Array.from({ length: 54 }, (_, i) => ({ ...copy(cell), plotId: i >= 50 ? i : undefined }));
  const model = new FarmModel(
    { cells } as any,
    {} as any,
    () => g,
    cells,
    FARM_LAYOUT.bounds,
    id => buildingPosition(id, g.state.buildingLayout)
  );
  for (const site of catalog.residentPens!) {
    const pos = model.plotPositions().find(p => p.plot.id === penPlotId(site))!;
    assert.deepEqual({ x: pos.x, y: pos.y }, buildingPosition(penBuildingId(site)));
    assert.equal(model.isVisiblePlot(pos.plot), true);
    assert.equal(canMoveBuilding(g.state, penBuildingId(site)), true);
  }
  const oldFirst = buildingPosition('pen:12', g.state.buildingLayout),
    from = buildingPosition('pen:50', g.state.buildingLayout);
  const choices = [-144, -72, 72, 144].flatMap(x =>
    [-72, -36, 36, 72].map(y => snapPosition({ x: from.x + x, y: from.y + y }))
  );
  const to = choices.find(p => !checkLayout(movedLayout(g.state.buildingLayout!, 'pen:50', p), g.state).error)!;
  assert.ok(to);
  ok(g.moveBuilding('pen:50', to));
  assert.deepEqual(buildingPosition('pen:12', g.state.buildingLayout), oldFirst);
  g.validate();
});

test('v6 source bytes and every old asset survive migration; unknown sites, extra houses and future save versions never replace stored data', () => {
  const g = funded();
  // This v6 source predates paid land; keep its original forty owned fields.
  for (const plot of g.state.plots) if (plot.group === 'crop') plot.unlocked = true;
  for (const item of g.items) g.state.inventory[item.key] = 4;
  ok(g.feedAnimals(12));
  ok(g.produce(7, 0));
  ok(g.expandPen(12, 1));
  const old = copy(g.state);
  old.version = 6;
  old.buildingLayout = { version: 5, positions: {} };
  old.plots = old.plots.slice(0, 50);
  const raw = JSON.stringify(farmPack(old, settings), null, 2) + '  \n';
  const mem = memory();
  mem.data.set(SIMPLE_FARM_KEY, raw);
  const pack = mem.saver.load()!,
    expected = copy(g.state);
  assert.deepEqual(pack.free, expected);
  assert.equal(pack.version, 6);
  mem.saver.save(pack);
  assert.equal(mem.data.get(SIMPLE_FARM_KEY + '.before-two-buildings-v7'), raw);
  assert.deepEqual(mem.saver.load()!.free, expected);
  for (const mutate of [
    (s: FarmState) => {
      s.plots.push({ ...copy(s.plots[50]), id: 54 });
    },
    (s: FarmState) => {
      s.machines.push({ ...copy(s.machines[0]), id: 99, buildingId: 'bakery-3' });
    },
    (s: FarmState) => {
      s.plots[50].residents = copy(s.plots[12].residents);
      s.plots[50].unlocked = true;
    },
    (s: FarmState) => {
      s.buildingLayout!.positions['unknown'] = { x: 0, y: 0 };
    },
    (s: FarmState) => {
      s.version = 99 as any;
    },
  ]) {
    const bad = copy(pack),
      before = [...mem.data];
    mutate(bad.free);
    assert.throws(() => mem.saver.importText(JSON.stringify(bad)));
    assert.deepEqual([...mem.data], before);
  }
});

test('failed second-house saves publish no money or house; retry commits once and both instances survive reload/import at low XP', () => {
  for (const action of [
    { type: 'buyMachine' as const, machineType: 5, building: 'feed-2' },
    { type: 'buyPen' as const, plot: 50 },
  ]) {
    const mem = memory(funded().state),
      session = new GameSession(catalog, mem.saver, () => 0),
      before = copy(session.game.state),
      bytes = mem.data.get(SIMPLE_FARM_KEY);
    mem.fail(true);
    assert.equal(session.dispatch(action).ok, false);
    assert.deepEqual(session.game.state, before);
    assert.equal(mem.data.get(SIMPLE_FARM_KEY), bytes);
    const pending = copy(session.pendingPack!.free);
    assert.equal(session.retrySave(), false);
    assert.deepEqual(session.game.state, before);
    mem.fail(false);
    assert.equal(session.retrySave(), true);
    assert.deepEqual(session.game.state, pending);
    assert.equal(session.dispatch(action).ok, false);
    assert.deepEqual(session.game.state, pending);
    pending.xp = 0;
    const imported = memory();
    imported.saver.importText(JSON.stringify(farmPack(pending, settings)));
    assert.deepEqual(new GameSession(catalog, imported.saver, () => 0).game.state, pending);
  }
});
