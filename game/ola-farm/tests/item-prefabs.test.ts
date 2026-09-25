import assert from 'node:assert/strict';
import { test } from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { FarmModel } from '../assets/farm/scripts/map/FarmModel';
const resource = path.resolve(__dirname, '../assets/resources'),
  prefabRoot = path.resolve(__dirname, '../assets/farm/prefabs');
const read = (file: string): any => JSON.parse(fs.readFileSync(file, 'utf8'));
const catalog = read(path.join(prefabRoot, 'items/catalog.json'));
const gameData = read(path.join(resource, 'ported/game.json'));

test('35 small assets have unique stable metadata; map links live prefab roots rather than visual copies', () => {
  assert.equal(catalog.items.length, 35);
  const prefabs = new Map<string, any>();
  for (const item of catalog.items) {
    const file = path.join(prefabRoot, item.resource + '.prefab'),
      asset = read(file),
      meta = read(file + '.meta');
    assert.equal(meta.uuid, item.uuid);
    assert.ok(!prefabs.has(item.uuid));
    prefabs.set(item.uuid, asset);
    assert.equal(asset[asset[asset[0].data.__id__]._prefab.__id__].fileId, item.rootId);
  }
  const map = read(path.join(prefabRoot, 'map/scenes.prefab'));
  const scenery = map.find((o: any) => o.__type__ === 'cc.Node' && o._name === 'Scenery');
  assert.equal(scenery._children.length, catalog.sceneryInstances);
  const checkLinked = (linked: any) => {
    const info = map[linked._prefab.__id__],
      instance = map[info.instance.__id__];
    const original = prefabs.get(info.asset.__uuid__);
    assert.ok(original, 'linked item asset exists');
    assert.equal(instance.__type__, 'cc.PrefabInstance');
    assert.equal(linked._components.length, 0);
    assert.ok(
      instance.propertyOverrides.every((r: any) => map[r.__id__].propertyPath[0] === '_lscale'),
      'visual edits inherit from source'
    );
    assert.equal(info.fileId, original[original[original[0].data.__id__]._prefab.__id__].fileId);
  };
  for (const r of scenery._children) {
    const placement = map[r.__id__];
    assert.ok(!placement._components.some((r: any) => map[r.__id__].__type__ === 'cc.Sprite'));
    if (placement._name === 'MainObject-xay gio') {
      assert.deepEqual(
        placement._children.map((r: any) => map[r.__id__]._name),
        ['WindmillBody', 'xay gio-canh']
      );
      const blades = map[placement._children[1].__id__];
      assert.equal(blades._parent.__id__, r.__id__, 'the blades move with the windmill body');
      assert.deepEqual([blades._lpos.x, blades._lpos.y], [20, -28]);
      assert.equal(blades._children.length, 1);
      assert.equal(map[blades._children[0].__id__]._name, 'WindmillBlades');
      checkLinked(map[blades._children[0].__id__]);
    } else assert.equal(placement._children.length, 1);
    checkLinked(map[placement._children[0].__id__]);
  }
});

test('all animal species and plot levels select actual prefab parts without changing animation/depth commands', () => {
  const cells = Array.from({ length: 40 }, (_, i) => ({
    ...gameData.scene.cells[0],
    matrix: [1, 0, 0, 1, i * 5, -i * 5],
  })).concat(gameData.scene.cells.slice(12));
  const game = new FarmGame(gameData.data),
    model = new FarmModel(gameData.scene, gameData.runtime, () => game, cells, {
      left: -1700,
      right: 1800,
      bottom: -1200,
      top: 1150,
    });
  const groups: Record<string, string[]> = { pens: [], ponds: [], animals: [] };
  for (const item of catalog.items) {
    if (item.name.startsWith('Pen')) groups.pens.push(item.resource);
    if (item.name.startsWith('PondSlot')) groups.ponds.push(item.resource);
  }
  groups.animals = ['Chicken', 'Pig', 'Cow', 'Fish', 'Shrimp'].map(
    n => catalog.items.find((i: any) => i.name === n).resource
  );
  groups.pens.sort();
  groups.ponds.sort();
  for (let level = 1; level <= 4; level++)
    for (const crop of [5, 6, 7, 8, 9]) {
      const p = game.state.plots.find((p: any) => p.group === game.farm(crop)!.group)!;
      Object.assign(p, { crop, level, unlocked: true, started: 0, ready: 100 });
      for (const time of [0, 50, 101]) {
        game.state.time = time;
        const position = model.plotPositions().find(x => x.plot.id === p.id)!;
        const commands = model.plotWidgets(position);
        const parts = gameData.runtime.animals[game.farm(crop)!.key].widgets.length;
        const animals = Math.floor(game.farm(crop)!.yields[level - 1] / 2);
        assert.equal(commands.length, animals * parts + (p.group === 'pen' ? 2 : 1));
        assert.ok(commands.every((w: any) => Number.isFinite(w.depth) && w.matrix.every(Number.isFinite)));
        for (const w of commands) {
          const prefab = read(path.join(prefabRoot, groups[w.itemType!][w.itemIndex!] + '.prefab'));
          assert.ok(prefab.some((o: any) => o.__type__ === 'cc.Node' && o._name === 'Part' + w.itemPart));
          assert.equal(w.matrix.length, 6);
          assert.ok(Number.isFinite(w.depth));
        }
      }
    }
});

test('livestock anchors keep save geometry without obsolete pen and pond preview instances', () => {
  const map = read(path.join(prefabRoot, 'map/scenes.prefab'));
  const group = map.find((n: any) => n.__type__ === 'cc.Node' && n._name === 'Livestock');
  const anchors = group._children.map((r: any) => map[r.__id__]);
  assert.deepEqual(
    anchors.map((n: any) => n._name),
    [
      ...Array.from({ length: 10 }, (_, i) => 'Cell' + (i + 12)),
      ...Array.from({ length: 4 }, (_, i) => 'Cell' + (i + 50)),
    ]
  );
  for (const anchor of anchors) {
    assert.deepEqual(anchor._children, [], 'anchors contain no legacy render instances');
    const size = anchor._components
      .map((r: any) => map[r.__id__])
      .find((c: any) => c.__type__ === 'cc.UITransform')._contentSize;
    assert.ok(size.width > 0 && size.height > 0);
  }
  assert.deepEqual(
    anchors.slice(0, 4).map((n: any) => [n._lpos.x, n._lpos.y]),
    [
      [270, 180],
      [-280, 470],
      [270, 760],
      [820, 470],
    ]
  );
  const nested = map[map[map[0].data.__id__]._prefab.__id__].nestedPrefabInstanceRoots.map((r: any) => map[r.__id__]);
  assert.ok(
    nested.every((n: any) => !/^Pen\d+$|^PondSlot\d+$/.test(n._name)),
    'preview asset links are removed, not merely hidden'
  );
  assert.equal(new Set(nested).size, nested.length);
});
