import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';
import vm from 'node:vm';
import ts from 'typescript';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import { FarmGame, orderedCrops } from '../assets/farm/scripts/core/FarmGame';
import { FarmModel } from '../assets/farm/scripts/map/FarmModel';
import { xpForLevel } from './fixtures/established-farm';

const catalog = loadFarmCatalog();
const assets = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../assets/resources/ported/game.json'), 'utf8'));
const cells = Array.from({ length: 40 }, (_, index) => ({
  ...assets.scene.cells[0],
  matrix: [1, 0, 0, 1, index * 190, -index * 100],
})).concat(assets.scene.cells.slice(12));
const modelFor = (game: FarmGame) =>
  new FarmModel(assets.scene, assets.runtime, () => game, cells, {
    left: -1700,
    right: 8000,
    bottom: -5000,
    top: 1150,
  });

test('map and hit visibility expose six owned fields and only the green next purchase', () => {
  const game = new FarmGame(catalog),
    model = modelFor(game),
    crops = orderedCrops(game.state.plots);
  const visible = () => model.plotPositions().filter(p => model.isVisiblePlot(p.plot));
  assert.deepEqual(
    visible().map(p => p.plot.id),
    crops.slice(0, 7).map(p => p.id)
  );
  assert.deepEqual(
    visible().map(p => model.plotWidgets(p)[0].sprite),
    ['dat1', 'dat1', 'dat1', 'dat1', 'dat1', 'dat1', 'dat0']
  );
  game.state.xp = xpForLevel(game, 2);
  game.state.coins = 2000;
  assert.equal(game.improve(crops[6].id).error, undefined);
  assert.deepEqual(
    visible().map(p => p.plot.id),
    crops.slice(0, 8).map(p => p.id)
  );
  assert.equal(model.plotWidgets(visible()[6])[0].sprite, 'dat1');
  assert.equal(model.plotWidgets(visible()[7])[0].sprite, 'dat0');
  assert.ok(
    crops.slice(8).every(p => !model.isVisiblePlot(p)),
    'later cells have no map hit target'
  );
});

test('legacy maps retain all locked crop targets for diamond improvements', () => {
  const game = new FarmGame(assets.data),
    model = modelFor(game),
    crops = orderedCrops(game.state.plots);
  crops.forEach(plot => {
    plot.unlocked = false;
  });
  assert.equal(game.simple, false);
  assert.ok(crops.length > 1);
  assert.ok(crops.every(plot => model.isVisiblePlot(plot)));
  assert.equal(game.improve(crops[crops.length - 1].id).error, undefined);
});

test('map respects an existing four-field farm, ownership gaps and fully purchased farms', () => {
  const game = new FarmGame(catalog),
    model = modelFor(game),
    crops = orderedCrops(game.state.plots);
  crops.forEach((p, index) => {
    p.unlocked = index < 4;
  });
  assert.deepEqual(
    crops.filter(p => model.isVisiblePlot(p)).map(p => p.id),
    crops.slice(0, 5).map(p => p.id)
  );
  crops[12].unlocked = true;
  assert.equal(model.isVisiblePlot(crops[12]), true, 'pre-owned later fields are preserved');
  assert.equal(model.isVisiblePlot(crops[5]), false, 'a gap does not reveal multiple purchases');
  const laterPosition = model.plotPositions().find(p => p.plot === crops[12])!;
  assert.equal(laterPosition.x, cells[12].matrix[4], 'hidden fields do not collapse layout positions');
  crops.forEach(p => {
    p.unlocked = true;
  });
  assert.equal(crops.filter(p => model.isVisiblePlot(p)).length, 40);
  assert.equal(game.nextLockedCrop(), undefined);
  assert.ok(
    model
      .plotPositions()
      .filter(p => p.plot.group === 'crop')
      .every(p => model.plotWidgets(p)[0].sprite === 'dat1')
  );
});

// Run the real prefab instance/cache manager, replacing only the Cocos node/component boundary.
class Transform {
  width = 196;
  height = 108;
}
class CropShell {
  soil = { children: [{ name: 'Soil1', active: true }] };
  currentPlant = null;
  replaceSoil(prefab: { name: string }): void {
    this.soil.children = [{ name: prefab.name, active: true }];
  }
}
class FakeNode {
  name = '';
  active = true;
  destroyed = false;
  scale = { x: 1, y: 1 };
  shell = new CropShell();
  children: FakeNode[] = [];
  get activeInHierarchy() {
    return this.active && !this.destroyed;
  }
  getComponent(type: unknown) {
    return type === CropShell ? this.shell : new Transform();
  }
  addChild(node: FakeNode) {
    this.children.push(node);
  }
  setPosition() {}
  setScale(x: number, y: number) {
    this.scale = { x, y };
  }
  setSiblingIndex() {}
  destroy() {
    this.destroyed = true;
  }
}
const compiled = ts.transpileModule(
  fs.readFileSync(path.resolve(__dirname, '../assets/farm/scripts/map/FarmItems.ts'), 'utf8'),
  { compilerOptions: { target: ts.ScriptTarget.ES2020, module: ts.ModuleKind.CommonJS } }
).outputText;
const itemModule: Record<string, any> = {};
vm.runInNewContext(compiled, {
  exports: itemModule,
  require: (name: string) => {
    if (name === 'cc') return { Node: FakeNode, UITransform: Transform, instantiate: () => new FakeNode() };
    if (name === './crops/CropPlotView') return { CropPlotView: CropShell };
    if (name === './buildings/FarmTownMotion') return { FarmTownMotion: class {} };
    if (name === './assets/ItemParts') return { ItemParts: class {} };
    throw Error(`Unexpected runtime import: ${name}`);
  },
});

test('buying replaces the live green soil immediately and creates exactly one new green preview', () => {
  const game = new FarmGame(catalog),
    model = modelFor(game),
    parent = new FakeNode(),
    renderer = new itemModule.FarmItems(
      parent,
      {},
      { soils: Array.from({ length: 5 }, (_, n) => ({ name: `Soil${n}` })) },
      new Map()
    );
  const render = () => renderer.update(model.plotPositions(), model, [], () => true);
  render();
  let diagnostics = renderer.diagnostics();
  assert.equal(diagnostics.cropInstances, 7);
  const next = game.nextLockedCrop()!;
  assert.equal(diagnostics.stages.find((p: any) => p.id === next.id).soil, 'Soil0');
  const previousRoot = parent.children.find(n => n.name === `Crop-${next.id}`)!;
  game.state.xp = xpForLevel(game, 2);
  game.state.coins = 2000;
  assert.equal(game.improve(next.id).error, undefined);
  render();
  diagnostics = renderer.diagnostics();
  assert.equal(previousRoot.destroyed, true, 'unlocked status invalidates the cached green prefab');
  assert.equal(previousRoot.active, false, 'old green node is hidden before deferred destruction');
  assert.equal(diagnostics.cropInstances, 8);
  assert.equal(diagnostics.stages.find((p: any) => p.id === next.id).soil, 'Soil1');
  assert.equal(diagnostics.stages.find((p: any) => p.id === next.id).unlocked, true);
  assert.equal(diagnostics.stages.filter((p: any) => p.soil === 'Soil0').length, 1);
  assert.equal(diagnostics.stages.find((p: any) => p.soil === 'Soil0').id, game.nextLockedCrop()!.id);
  orderedCrops(game.state.plots).forEach(p => {
    p.unlocked = true;
  });
  render();
  diagnostics = renderer.diagnostics();
  assert.equal(diagnostics.cropInstances, 40);
  assert.ok(diagnostics.stages.every((p: any) => p.soil === 'Soil1'));
  game.state.plots
    .filter(p => p.group === 'crop')
    .forEach((p, index) => {
      p.unlocked = index < 6;
    });
  render();
  assert.equal(renderer.diagnostics().cropInstances, 7, 'reload/reset clears stale owned instances and future targets');
});
