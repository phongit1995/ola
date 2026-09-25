import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';

const root = path.resolve(__dirname, '..');
const read = (file: string): any => JSON.parse(fs.readFileSync(path.join(root, file), 'utf8'));
const { assertGraph } = require('../tools/prefab-graph.cjs');
const { mapComponentTypes } = require('../tools/cocos-ids.cjs');
const map = read('assets/farm/prefabs/map/scenes.prefab');
const layout = map.find((object: any) => object.__type__ === mapComponentTypes().FarmMapLayout);
const source = read('source-assets/farm-beautify/placements.json');
const registry = new Map<string, any>(
  read('assets/farm/data/farm-decor/manifest.json').images.map((item: any) => [item.id, item])
);
const names = ['ForestNE', 'ForestNW', 'ForestSE', 'ForestSW', 'Border0', 'Border1', 'Border2', 'Border3'];

test('the editor map links eight complete region prefabs, with live nested source art and no copied sprites', () => {
  assertGraph(map);
  const owner = map[map[map[0].data.__id__]._prefab.__id__];
  const regions = layout.decorRegions.map((ref: any) => map[ref.__id__]);
  assert.deepEqual(
    regions.map((node: any) => node._name),
    names
  );
  const allIds = new Set<string>();
  for (const region of regions) {
    assert.equal(region._parent.__id__, layout.decor.__id__);
    assert.deepEqual(region._children, [], 'the Farm instance inherits the editable region source');
    assert.deepEqual(region._components, []);
    const info = map[region._prefab.__id__];
    const file = 'assets/farm/prefabs/map/' + region._name + '.prefab';
    const data = read(file),
      meta = read(file + '.meta');
    assertGraph(data, { file });
    assert.equal(info.asset.__uuid__, meta.uuid);
    assert.ok(owner.nestedPrefabInstanceRoots.some((ref: any) => map[ref.__id__] === region));
    const rootNode = data[data[0].data.__id__],
      rootInfo = data[rootNode._prefab.__id__];
    assert.equal(info.fileId, rootInfo.fileId);
    assert.equal(rootInfo.nestedPrefabInstanceRoots.length, rootNode._children.length);
    assert.ok(rootNode._children.length >= 173 && rootNode._children.length <= 477);
    for (const ref of rootNode._children) {
      const holder = data[ref.__id__];
      assert.ok(!allIds.has(holder._name), 'one owner for placement ' + holder._name);
      allIds.add(holder._name);
      assert.equal(holder._children.length, 1);
      const leaf = data[holder._children[0].__id__],
        leafInfo = data[leaf._prefab.__id__];
      assert.deepEqual(leaf._components, []);
      assert.deepEqual(leaf._children, [], 'native visuals remain linked, not serialized copies');
      const original = registry.get(leaf._name);
      assert.ok(original, 'known source art');
      assert.equal(leafInfo.asset.__uuid__, original.uuid);
      assert.equal(leafInfo.fileId, original.rootId);
      const instance = data[leafInfo.instance.__id__];
      assert.deepEqual(instance.propertyOverrides, [], 'edits to source art propagate without visual overrides');
      assert.ok(rootInfo.nestedPrefabInstanceRoots.some((r: any) => r.__id__ === holder._children[0].__id__));
    }
  }
  assert.equal(allIds.size, 2478);
});

test('region partitioning preserves every placement, all four border sides, and the globally sorted runtime ground order', () => {
  const holders: any[] = [];
  const regions = new Set(layout.decorRegions.map((ref: any) => ref.__id__));
  const props = map[layout.decor.__id__]._children.filter((ref: any) => !regions.has(ref.__id__));
  assert.equal(props.length, 18, 'gameplay props remain beside the anchors for layout export');
  for (const ref of props) holders.push(map[ref.__id__]);
  for (const name of names) {
    const data = read('assets/farm/prefabs/map/' + name + '.prefab');
    const rootNode = data[data[0].data.__id__];
    assert.deepEqual([rootNode._lpos.x, rootNode._lpos.y, rootNode._lscale.x, rootNode._lscale.y], [0, 0, 1, 1]);
    const children = rootNode._children.map((ref: any) => data[ref.__id__]);
    if (name.startsWith('Border')) {
      assert.equal(children.length, 173);
      assert.ok(children.every((node: any) => node._name.startsWith('RockBorder-' + name.slice(6) + '-')));
    }
    holders.push(...children);
  }
  const expected = source.placements.filter((item: any) => item.group === 'Decor');
  const coordinates = (items: any[]) => items.sort((a, b) => b.y - a.y || a.x - b.x);
  const actual = holders.map(node => ({ id: node._name, x: node._lpos.x, y: node._lpos.y, scale: node._lscale.x }));
  assert.deepEqual(
    coordinates(actual),
    coordinates(expected.map((item: any) => ({ id: item.id, x: item.x, y: item.y, scale: item.scale ?? 1 })))
  );
  assert.equal(layout.fields.length, 40);
  assert.equal(layout.livestock.length, 10);
  assert.equal(map[layout.buildings.__id__]._children.length, 16);
  assert.equal(map[layout.scenery.__id__]._children.length, 21);
  assert.equal(map[layout.groundDecor.__id__]._children.length, 25);
});
