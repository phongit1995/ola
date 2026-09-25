import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';
const { componentTypeByName } = require('../tools/cocos-ids.cjs');
const { assertGraph } = require('../tools/prefab-graph.cjs');
const root = path.resolve(__dirname, '..');
const read = (file: string): any => JSON.parse(fs.readFileSync(path.join(root, file), 'utf8'));
const type = (name: string) => componentTypeByName(path.basename(name));

test('inventory prefab owns its shelf, native category controls, scroll mask and linked stock card previews', () => {
  const objects = read('assets/farm/prefabs/ui/InventoryBody.prefab');
  assertGraph(objects);
  const get = (ref: any) => objects[ref.__id__],
    node = get(objects[0].data);
  const body = node._components.map(get).find((o: any) => o.__type__ === type('ui/inventory/InventoryBodyView'));
  assert.ok(body);
  assert.equal(body.stockCardPrefab.__uuid__, read('assets/farm/prefabs/ui/StockCard.prefab.meta').uuid);
  for (const key of ['count', 'hint', 'quickSaleTitle']) {
    const label = get(body[key]);
    assert.equal(label.__type__, 'cc.Label');
    assert.ok(label._string && label._font.__uuid__);
  }
  assert.equal(body.tabs.length, 2);
  assert.equal(body.tabTitles.length, 2);
  for (const [index, tab] of body.tabs.map(get).entries()) {
    assert.equal(tab._name, ['tab-raw', 'tab-goods'][index]);
    assert.equal(tab._components.map(get).filter((o: any) => o.__type__ === type('render/FarmButton')).length, 1);
    assert.ok(tab._components.map(get).some((o: any) => o.__type__ === 'cc.Sprite' && o._spriteFrame.__uuid__));
  }
  const scroll = get(body.scroll);
  assert.equal(scroll.__type__, 'cc.ScrollView');
  assert.equal(scroll.vertical, true);
  assert.equal(scroll.horizontal, false);
  assert.equal(scroll.cancelInnerEvents, true);
  assert.equal(scroll._horizontal, undefined, 'Creator serializes the public axis property');
  const content = get(scroll._content),
    viewport = get(content._parent);
  assert.ok(viewport._components.map(get).some((o: any) => o.__type__ === 'cc.Mask'));
  const transform = content._components.map(get).find((o: any) => o.__type__ === 'cc.UITransform');
  assert.deepEqual([transform._anchorPoint.x, transform._anchorPoint.y], [0, 1]);
  const preview = get(body.preview);
  assert.equal(get(preview._parent), content);
  assert.equal(preview._children.length, 6);
  const positions = preview._children.map((r: any) => {
    const instance = get(get(get(r)._prefab).instance);
    const position = instance.propertyOverrides.map(get).find((o: any) => o.propertyPath[0] === '_lpos');
    assert.ok(position, 'Creator receives a real nested position override');
    return position.value.x;
  });
  assert.equal(new Set(positions).size, 6, 'standalone cards occupy six distinct columns');
  assert.equal(get(body.quickSale)._name, 'inventory-sales');
  assert.equal(body.layoutNodes.length, body.referenceRects.length, 'Inspector offsets have a complete baseline');
});

test('StockCard has a real imported item sprite, editable labels and a whole-cell button', () => {
  const objects = read('assets/farm/prefabs/ui/StockCard.prefab');
  assertGraph(objects);
  const get = (ref: any) => objects[ref.__id__],
    node = get(objects[0].data);
  const card = node._components.map(get).find((o: any) => o.__type__ === type('ui/inventory/StockCardView'));
  assert.ok(card);
  assert.equal(node._components.map(get).filter((o: any) => o.__type__ === type('render/FarmButton')).length, 1);
  const product = get(card.product);
  assert.equal(product.__type__, 'cc.Sprite');
  assert.ok(product._spriteFrame.__uuid__);
  const badge = get(card.badge);
  assert.ok(badge._components.map(get).some((o: any) => o.__type__ === 'cc.Sprite'));
  for (const key of ['count', 'itemName']) {
    const label = get(card[key]);
    assert.equal(label.__type__, 'cc.Label');
    assert.ok(label._string && label._font.__uuid__);
  }
  assert.equal(card.layoutNodes.length, card.referenceRects.length);
});
