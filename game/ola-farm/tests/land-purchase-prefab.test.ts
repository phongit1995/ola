import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';
const { componentType } = require('../tools/cocos-ids.cjs');
const { assertGraph } = require('../tools/prefab-graph.cjs');
const assets = path.resolve(__dirname, '../assets/farm');
const read = (file: string) => JSON.parse(fs.readFileSync(path.join(assets, file), 'utf8'));

test('land purchase is a complete editable prefab linked from the scene with existing artwork and controls', () => {
  const graph = read('prefabs/ui/LandPurchase.prefab');
  assertGraph(graph, { file: 'LandPurchase.prefab' });
  const root = graph[graph[0].data.__id__];
  const view = graph.find(
    (o: any) => o.__type__ === componentType(path.join(assets, 'scripts/ui/land/LandPurchaseView.ts'))
  );
  assert.ok(view);
  const get = (ref: any, type: string) => {
    assert.equal(graph[ref.__id__].__type__, type);
    return graph[ref.__id__];
  };
  const card = get(view.card, 'cc.Node');
  assert.equal(card._parent.__id__, graph[0].data.__id__);
  for (const key of ['title', 'ownership', 'offer', 'requirement', 'wallet', 'buyTitle']) {
    const label = get(view[key], 'cc.Label');
    assert.ok(label._string.length > 0 && label._font.__uuid__);
    assert.equal(label._isSystemFontUsed, false);
  }
  for (const key of ['lock', 'coin']) {
    const node = get(view[key], 'cc.Node');
    assert.ok(node._components.some((ref: any) => graph[ref.__id__]._spriteFrame?.__uuid__));
  }
  const buttonType = componentType(path.join(assets, 'scripts/render/FarmButton.ts'));
  for (const key of ['buyButton', 'closeButton', 'laterButton']) {
    const button = get(view[key], 'cc.Node');
    assert.ok(button._components.some((ref: any) => graph[ref.__id__].__type__ === buttonType));
    assert.ok(button._components.some((ref: any) => graph[ref.__id__].__type__ === 'cc.BlockInputEvents'));
  }
  assert.ok(root._components.some((ref: any) => graph[ref.__id__].__type__ === 'cc.BlockInputEvents'));
  const greenLand = graph.find(
    (o: any) => o.__type__ === componentType(path.join(assets, 'scripts/map/assets/AtlasSprite.ts'))
  );
  const originalSoil = read('prefabs/items/plots/Soil0.prefab').find((o: any) => o.region);
  assert.deepEqual(greenLand.texture, originalSoil.texture);
  assert.deepEqual(greenLand.region, originalSoil.region);
  const greenSprite = graph.find((o: any) => o.__type__ === 'cc.Sprite' && o.node.__id__ === greenLand.node.__id__);
  assert.equal(
    greenSprite._isTrimmedMode,
    true,
    'atlas region fills the preview instead of using the entire atlas size'
  );
  const scene = read('scenes/Farm.scene');
  const registry = scene.find(
    (o: any) => o.__type__ === componentType(path.join(assets, 'scripts/render/UiPrefabs.ts'))
  );
  assert.equal(registry.landPurchase.__uuid__, read('prefabs/ui/LandPurchase.prefab.meta').uuid);
});
