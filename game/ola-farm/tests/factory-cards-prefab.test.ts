import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';
const { componentTypeByName } = require('../tools/cocos-ids.cjs');
const { assertGraph } = require('../tools/prefab-graph.cjs');
const { uiPrefabPath } = require('../tools/ui-prefab-paths.cjs');
const assets = path.resolve(__dirname, '../assets/farm');
const read = (file: string) => {
  const [name, suffix] = file.split('.prefab');
  return JSON.parse(fs.readFileSync(path.join(assets, uiPrefabPath(name) + suffix), 'utf8'));
};
const type = (name: string) => componentTypeByName(path.basename(name));
function baseline(data: any[], view: any): void {
  for (const key of ['referenceRects', 'referenceScales', 'referenceFonts', 'referenceColors', 'referenceFrames'])
    assert.equal(
      view[key].length,
      view.layoutNodes.length,
      key + ': all Inspector offsets/styles retain their baselines'
    );
  for (const [index, link] of view.layoutNodes.entries())
    assert.ok(
      link && data[link.__id__]?.__type__ === 'cc.Node',
      `layoutNodes[${index}] must resolve before AuthoredUiView.begin`
    );
  assert.equal(new Set(view.layoutNodes.map((r: any) => r.__id__)).size, view.layoutNodes.length);
  for (const r of view.layoutNodes) assert.equal(data[r.__id__].__type__, 'cc.Node');
}

test('factory cards own their editable artwork, typed display bindings and responsive baselines', () => {
  for (const [name, fields] of [
    ['RecipeChoice', { face: 'cc.Node', selected: 'cc.Node', product: 'cc.Sprite', recipeName: 'cc.Label' }],
    ['IngredientItem', { product: 'cc.Sprite', itemName: 'cc.Label', stock: 'cc.Label' }],
  ] as const) {
    const data = read(name + '.prefab');
    assertGraph(data);
    const root = data[data[0].data.__id__],
      view = data.find((o: any) => o.__type__ === type('ui/' + name + 'View'));
    assert.equal(data[view.node.__id__], root);
    baseline(data, view);
    assert.deepEqual([root._lpos.x, root._lpos.y], [0, 0]);
    assert.ok(root._components.some((r: any) => data[r.__id__].__type__ === type('render/FarmButton')));
    for (const [key, expected] of Object.entries(fields)) assert.equal(data[view[key].__id__].__type__, expected);
    for (const label of data.filter((o: any) => o.__type__ === 'cc.Label')) assert.ok(label._font?.__uuid__);
    for (const sprite of data.filter((o: any) => o.__type__ === 'cc.Sprite')) assert.ok(sprite._spriteFrame?.__uuid__);
  }
});

test('FactoryBody links reusable row sources and nested Editor samples without owning their internals', () => {
  const data = read('FactoryBody.prefab');
  assertGraph(data);
  const view = data.find((o: any) => o.__type__ === type('ui/production/FactoryBodyView'));
  baseline(data, view);
  const root = data[data[0].data.__id__];
  const back = root._children.map((r: any) => data[r.__id__]).find((node: any) => node._name === 'all-buildings');
  assert.ok(back, 'FactoryPanel binds the authored return-to-buildings button');
  assert.ok(back._components.some((r: any) => data[r.__id__].__type__ === type('render/FarmButton')));
  assert.deepEqual(
    back._children.map((r: any) => data[r.__id__]._name),
    ['ButtonFace', 'Title']
  );
  for (const node of [back, ...back._children.map((r: any) => data[r.__id__])])
    assert.ok(
      view.layoutNodes.some((r: any) => data[r.__id__] === node),
      'return button retains its responsive baselines'
    );
  assert.equal(view.choices, undefined);
  assert.equal(view.ingredients, undefined);
  for (const [property, previews, name] of [
    ['recipeChoicePrefab', 'choicePreviews', 'RecipeChoice'],
    ['ingredientItemPrefab', 'ingredientPreviews', 'IngredientItem'],
  ]) {
    const uuid = read(name + '.prefab.meta').uuid;
    assert.deepEqual(view[property], { __uuid__: uuid, __expectedType__: 'cc.Prefab' });
    assert.ok(view[previews].length > 0, 'Editor still previews real linked cards');
    for (const r of view[previews]) {
      const node = data[r.__id__],
        info = data[node._prefab.__id__];
      assert.equal(info.asset.__uuid__, uuid);
      assert.ok(info.instance);
      assert.equal((node._children ?? []).length, 0, 'source artwork is inherited from the child prefab');
      assert.ok(
        !view.layoutNodes.some((n: any) => n.__id__ === r.__id__),
        'parent baseline does not manage preview internals'
      );
    }
  }
  const names = data.filter((o: any) => o.__type__ === 'cc.Node').map((o: any) => o._name);
  for (const name of ['RecipeTile', 'SelectedRecipe', 'IngredientName', 'IngredientStock'])
    assert.ok(!names.includes(name));
});

test('FactoryBody accepts native containing-prefab ownership and rejects unrelated instance roots', () => {
  const data = read('FactoryBody.prefab'),
    root = data[0].data.__id__;
  const instances = data.filter((record: any) => record.__type__ === 'cc.PrefabInstance');
  assert.equal(instances.length, 14, 'five queue slots, five recipes and four ingredient samples remain linked');
  for (const instance of instances) assert.deepEqual(instance.prefabRootNode, { __id__: root });
  assertGraph(data);
  const wrong = structuredClone(data);
  const sibling = wrong[root]._children.find((link: any) => wrong[link.__id__]._name === 'MachineStatus');
  wrong.find((record: any) => record.__type__ === 'cc.PrefabInstance').prefabRootNode = sibling;
  assert.throws(() => assertGraph(wrong), /nested root mismatch/, 'only the actual containing prefab root is accepted');
  const cyclic = structuredClone(data),
    queue = cyclic.find((node: any) => node._name === 'Queue');
  cyclic[queue._children[0].__id__]._children = [{ __id__: cyclic.indexOf(queue) }];
  assert.throws(
    () => assertGraph(cyclic),
    /parent\/child mismatch|cycle/,
    'containing-root support does not allow hierarchy cycles'
  );
});

test('LivestockBody removes obsolete controls while retaining care, slot links and the unopened preview', () => {
  const data = read('LivestockBody.prefab');
  assertGraph(data);
  const view = data.find((o: any) => o.__type__ === type('ui/livestock/LivestockBodyView'));
  baseline(data, view);
  const nodes = data.filter((o: any) => o.__type__ === 'cc.Node'),
    names = nodes.map((n: any) => n._name);
  for (const name of [
    'HerdCount',
    'SellActions',
    'manage-herd',
    'care-herd',
    'herd-production-return',
    'FeedStockFace',
    'FeedSourceArrow',
    'HerdSummary',
  ])
    assert.ok(!names.includes(name), name + ' is removed from the serialized graph');
  assert.equal(view.sellActions, undefined);
  assert.equal(view.productionReturn, undefined);
  const feed = nodes.find((n: any) => n._name === 'FeedStockDisplay');
  assert.deepEqual(
    feed._children.map((r: any) => data[r.__id__]._name),
    ['FeedIcon', 'FeedStock']
  );
  assert.deepEqual(
    feed._components.map((r: any) => data[r.__id__].__type__),
    ['cc.UITransform']
  );
  const care = data[view.careActions.__id__];
  assert.deepEqual(
    care._children.map((r: any) => data[r.__id__]._name),
    ['feed-all', 'collect-all-animals']
  );
  assert.ok(names.includes('NewPenPortrait'));
  assert.ok(names.includes('purchase-pen'));
  const slots = data.filter(
    (o: any) => o.__type__ === 'cc.PrefabInfo' && o.asset?.__uuid__ === read('HerdSlot.prefab.meta').uuid
  );
  assert.equal(slots.length, 5);
});
