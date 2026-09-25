import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';

const root = path.resolve(__dirname, '..');
const read = (file: string): any => JSON.parse(fs.readFileSync(path.join(root, file), 'utf8'));
const { assertGraph } = require('../tools/prefab-graph.cjs');
const { uiPrefabPath } = require('../tools/ui-prefab-paths.cjs');
const { componentTypeByName } = require('../tools/cocos-ids.cjs');
const type = (name: string) => componentTypeByName(path.basename(name));
const buttonType = type('render/FarmButton');
const assets = new Set<string>();
function metadata(dir: string): void {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const file = path.join(dir, entry.name);
    if (entry.isDirectory()) metadata(file);
    else if (entry.name.endsWith('.meta')) {
      const add = (value: any): void => {
        if (!value || typeof value !== 'object') return;
        if (typeof value.uuid === 'string') assets.add(value.uuid);
        Object.values(value).forEach(add);
      };
      add(JSON.parse(fs.readFileSync(file, 'utf8')));
    }
  }
}
metadata(path.join(root, 'assets'));
function prefab(
  name: string,
  script: string
): { data: any[]; view: any; node: any; get: (ref: any, expected?: string) => any } {
  const data = read('assets/farm/' + uiPrefabPath(name));
  assertGraph(data, { file: name });
  const get = (ref: any, expected?: string): any => {
    assert.ok(Number.isInteger(ref?.__id__) && data[ref.__id__], name + ': linked Inspector property');
    const result = data[ref.__id__];
    if (expected) assert.equal(result.__type__, expected);
    return result;
  };
  const node = get(data[0].data),
    view = data.find((entry: any) => entry.__type__ === type(script));
  assert.ok(view);
  assert.equal(get(view.node), node);
  for (const sprite of data.filter((entry: any) => entry.__type__ === 'cc.Sprite'))
    assert.ok(assets.has(sprite._spriteFrame?.__uuid__), name + ': actual imported artwork');
  for (const label of data.filter((entry: any) => entry.__type__ === 'cc.Label')) {
    assert.ok(assets.has(label._font?.__uuid__), name + ': actual authored font');
    assert.equal(label._isSystemFontUsed, false);
  }
  return { data, node, view, get };
}

test('the scene preloads map UI through typed Inspector prefab properties', () => {
  const scene = read('assets/farm/scenes/Farm.scene');
  const app = scene.find((entry: any) => entry.__type__ === type('app/bootstrap/GameApp'));
  const registry = scene[app.uiPrefabs.__id__];
  assert.equal(registry.__type__, type('render/UiPrefabs'));
  for (const [key, name] of [
    ['plotBubble', 'PlotBubble'],
    ['herdQuickBar', 'HerdQuickBar'],
  ]) {
    assert.deepEqual(registry[key], {
      __uuid__: read('assets/farm/' + uiPrefabPath(name) + '.meta').uuid,
      __expectedType__: 'cc.Prefab',
    });
  }
});

test('plot bubbles author all three states without a map-blocking parent hit region', () => {
  const { data, node, view, get } = prefab('PlotBubble', 'map/crops/PlotBubbleView');
  for (const parent of [node, ...['locked', 'ready', 'growing'].map(key => get(view[key], 'cc.Node'))]) {
    assert.ok(
      !parent._components.some((ref: any) => get(ref).__type__ === 'cc.BlockInputEvents'),
      'only explicit bubble buttons intercept map input'
    );
  }
  assert.equal(get(view.growing)._active, true, 'Editor preview shows a complete authored growing state');
  assert.equal(get(view.locked)._active, false);
  assert.equal(get(view.ready)._active, false);
  const owners = ['locked', 'ready', 'growing', 'growing'];
  for (const [index, key] of ['unlockButton', 'harvestButton', 'finishButton', 'cancelButton'].entries()) {
    const button = get(view[key], 'cc.Node');
    assert.equal(get(button._parent), get(view[owners[index]]));
    assert.equal(button._components.filter((ref: any) => get(ref).__type__ === buttonType).length, 1);
    assert.ok(button._components.some((ref: any) => get(ref).__type__ === 'cc.BlockInputEvents'));
  }
  get(view.cropIcon, 'cc.Sprite');
  for (const key of ['amount', 'cropName', 'time', 'price']) get(view[key], 'cc.Label');
  assert.ok(
    data.filter((entry: any) => entry.__type__ === 'cc.Sprite').length >= 8,
    'all branches have real artwork before gameplay'
  );
});

test('the care bar keeps complete owned and unbuilt branches with five independently wired controls', () => {
  const { node, view, get } = prefab('HerdQuickBar', 'ui/livestock/HerdQuickBarView');
  const size = node._components
    .map((ref: any) => get(ref))
    .find((entry: any) => entry.__type__ === 'cc.UITransform')._contentSize;
  assert.equal(size.height, 112);
  assert.equal(get(view.ownedActions)._active, true);
  assert.equal(get(view.buildActions)._active, false);
  for (const key of ['buttons', 'titles', 'details', 'faces', 'activeFaces']) assert.equal(view[key].length, 5);
  assert.deepEqual(
    view.buttons.map((ref: any) => get(ref)._name),
    ['herd-feed', 'herd-collect', 'herd-manage', 'herd-build', 'herd-manage']
  );
  for (let i = 0; i < 5; i++) {
    const button = get(view.buttons[i], 'cc.Node');
    assert.equal(get(button._parent), get(i < 3 ? view.ownedActions : view.buildActions));
    assert.equal(button._components.filter((ref: any) => get(ref).__type__ === buttonType).length, 1);
    const transform = button._components
      .map((ref: any) => get(ref))
      .find((entry: any) => entry.__type__ === 'cc.UITransform');
    assert.ok(transform._contentSize.height >= 44 && transform._contentSize.width >= 44);
    for (const key of ['titles', 'details'])
      assert.equal(get(get(view[key][i], 'cc.Label').node)._parent.__id__, view.buttons[i].__id__);
    for (const key of ['faces', 'activeFaces']) {
      const sprite = get(view[key][i], 'cc.Sprite');
      assert.equal(sprite._type, 1, 'source buttons use nine-slice artwork');
      assert.equal(get(get(sprite.node)._parent), button);
    }
  }
  get(view.frame, 'cc.Sprite');
  get(view.feedIcon, 'cc.Sprite');
  for (const key of ['summary', 'count', 'unlock', 'feedQuantity']) get(view[key], 'cc.Label');
});
