import { establishFarm, xpForLevel } from './fixtures/established-farm';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import assert from 'node:assert/strict';
import { historicalState } from './fixtures/historical-state';
import { machineSites, penBuildingId } from '../assets/farm/scripts/core/FarmCatalog';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { createHash } from 'node:crypto';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import { EMPTY_LAYOUT } from '../assets/farm/scripts/core/constants/PlacementDefaults';
import { FARM_LAYOUT, buildingPosition, groundError, checkLayout } from '../assets/farm/scripts/core/BuildingPlacement';
import { MACHINE_PRESENTATION } from '../assets/farm/scripts/map/generated/BuildingPresentationData';
import { PREVIOUS_FOUR_FIELD_LAYOUT } from '../assets/farm/scripts/core/legacy/PreviousFourFieldLayout';

const root = path.resolve(__dirname, '..');
const catalog: FarmCatalog = loadFarmCatalog();
const clone = <T>(value: T): T => JSON.parse(JSON.stringify(value));
function previous() {
  const game = establishFarm(new FarmGame(catalog));
  // The shipped schema required every crop field to be owned.
  for (const plot of game.state.plots) if (plot.group === 'crop') plot.unlocked = true;
  game.state.coins = 5000;
  game.state.xp = xpForLevel(game, game.product(7)!.requiredLevel!);
  for (const item of game.items) game.state.inventory[item.key] = 20;
  assert.equal(game.plant(0, 1).error, undefined);
  assert.equal(game.feedAnimals(12).error, undefined);
  assert.equal(game.expandQueue(0).error, undefined);
  assert.equal(game.produce(7, 0).error, undefined);
  assert.equal(game.produce(7, 0).error, undefined);
  game.state = historicalState(game.state);
  game.state.buildingLayout = { version: 4, positions: {} };
  return clone(game.state);
}

test('eight source-derived machine footprints and full art widths match the delivered four-field yards', () => {
  const source = JSON.parse(
    fs.readFileSync(path.join(root, 'source-assets/farm-beautify/machine-footprints.json'), 'utf8')
  );
  assert.equal(source.targetWidth, 784);
  assert.equal(source.fieldWidth, 196);
  assert.equal(source.targetFieldWidths, 4);
  assert.equal(Object.keys(MACHINE_PRESENTATION).length, 8);
  assert.equal(groundError(EMPTY_LAYOUT), null);
  for (const type of catalog.machineTypes!) {
    const data = source.machines[type.prefab!],
      presentation = MACHINE_PRESENTATION[type.prefab!];
    assert.ok(presentation, type.prefab);
    assert.ok(Math.abs(presentation.bounds.right - presentation.bounds.left - 784) < 1e-8);
    assert.ok(Math.abs(presentation.scale * presentation.sourceWidth - 784) < 1e-8);
    assert.deepEqual(presentation.bounds, data.bounds);
    const building = FARM_LAYOUT.buildings.find(b => machineSites(type).includes(b.id))!;
    assert.deepEqual(building.footprints, [data.polygon]);
    const groundWidth = Math.max(...data.polygon.map((p: any) => p.x)) - Math.min(...data.polygon.map((p: any) => p.x));
    assert.ok(
      groundWidth > 0 && groundWidth <= presentation.targetWidth + 0.001,
      building.id + ' foundation must fit within the full art width'
    );
    for (const [file, hash] of Object.entries(data.sources))
      assert.equal(
        createHash('sha256')
          .update(
            /\.(prefab|json)$/.test(file)
              ? fs.readFileSync(path.join(root, file), 'utf8').replace(/\r\n/g, '\n')
              : fs.readFileSync(path.join(root, file))
          )
          .digest('hex'),
        hash,
        file
      );
  }
  assert.deepEqual(
    FARM_LAYOUT.buildings.filter(b => ['pen:12', 'pen:13', 'pen:14', 'pen:15'].includes(b.id)),
    PREVIOUS_FOUR_FIELD_LAYOUT.buildings.filter(b => b.kind === 'pen')
  );
  assert.deepEqual(
    FARM_LAYOUT.obstacles.filter(o => /^R\d/.test(o.id)),
    PREVIOUS_FOUR_FIELD_LAYOUT.obstacles.filter(o => /^R\d/.test(o.id))
  );
});

test('two valid v4 custom factories that now overlap reserve in stable order and repair only the conflicting site', () => {
  const old = previous();
  const bakery = { x: -1600, y: -200 },
    grill = { x: -1312, y: -92 };
  old.buildingLayout!.positions = { 'bakery-1': bakery, 'grill-1': grill };
  assert.equal(groundError(old.buildingLayout!, PREVIOUS_FOUR_FIELD_LAYOUT), null);
  const machines = FARM_LAYOUT.buildings.filter(b => ['bakery-1', 'grill-1'].includes(b.id));
  for (const b of machines)
    assert.equal(
      groundError(old.buildingLayout!, { ...FARM_LAYOUT, buildings: [b] }),
      null,
      'each enlarged factory individually clears static ground'
    );
  assert.ok(
    groundError(old.buildingLayout!, { ...FARM_LAYOUT, buildings: machines }),
    'their enlarged grounds conflict with each other'
  );
  const game = new FarmGame(catalog, old);
  assert.deepEqual(buildingPosition('bakery-1', game.state.buildingLayout), bakery);
  assert.notDeepEqual(buildingPosition('grill-1', game.state.buildingLayout), grill);
  assert.equal(checkLayout(game.state.buildingLayout!, game.state).error, null);
  assert.deepEqual({ ...historicalState(game.state), buildingLayout: old.buildingLayout }, old);
  assert.deepEqual(new FarmGame(catalog, old).state, game.state);
  assert.deepEqual(new FarmGame(catalog, game.state).state, game.state);
});

test('a saved factory newly covering a crop moves while the unchanged saved barn and paid jobs survive', () => {
  const old = previous(),
    bakery = { x: -900, y: -370 },
    barn = { x: -576, y: -936 };
  old.buildingLayout!.positions = { 'bakery-1': bakery, barn };
  assert.equal(groundError(old.buildingLayout!, PREVIOUS_FOUR_FIELD_LAYOUT), null);
  assert.match(
    groundError(old.buildingLayout!, {
      ...FARM_LAYOUT,
      buildings: FARM_LAYOUT.buildings.filter(b => b.id === 'bakery-1'),
    })!,
    /ruộng/
  );
  const game = new FarmGame(catalog, old);
  assert.notDeepEqual(buildingPosition('bakery-1', game.state.buildingLayout), bakery);
  assert.deepEqual(buildingPosition('barn', game.state.buildingLayout), barn);
  assert.equal(checkLayout(game.state.buildingLayout!, game.state).error, null);
  assert.deepEqual({ ...historicalState(game.state), buildingLayout: old.buildingLayout }, old);
});

test('enlarged custom machinery yields to an unchanged custom yard instead of silently retaining an overlap', () => {
  const old = previous(),
    pen = { x: -1500, y: -200 },
    bakery = { x: -1100, y: -450 };
  old.buildingLayout!.positions = { 'pen:12': pen, 'bakery-1': bakery };
  assert.equal(groundError(old.buildingLayout!, PREVIOUS_FOUR_FIELD_LAYOUT), null);
  const game = new FarmGame(catalog, old);
  assert.deepEqual(buildingPosition('pen:12', game.state.buildingLayout), pen);
  assert.notDeepEqual(buildingPosition('bakery-1', game.state.buildingLayout), bakery);
  assert.equal(checkLayout(game.state.buildingLayout!, game.state).error, null);
  assert.deepEqual({ ...historicalState(game.state), buildingLayout: old.buildingLayout }, old);
});
