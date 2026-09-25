import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';
const { componentType } = require('../tools/cocos-ids.cjs');
const { assertGraph } = require('../tools/prefab-graph.cjs');
const root = path.resolve(__dirname, '..');
const read = (file: string): any => JSON.parse(fs.readFileSync(path.join(root, file), 'utf8'));

test('DialogShell owns real authored native chrome, input shield and independent panel body', () => {
  const objects = read('assets/farm/prefabs/ui/DialogShell.prefab');
  assertGraph(objects);
  const get = (r: any) => objects[r.__id__];
  const node = get(objects[0].data),
    type = componentType(path.join(root, 'assets/farm/scripts/ui/shared/DialogShellView.ts'));
  const shell = node._components.map(get).find((c: any) => c.__type__ === type);
  assert.ok(shell);
  assert.ok(node._components.some((r: any) => get(r).__type__ === 'cc.BlockInputEvents'));
  const shield = node._components.map(get).find((c: any) => c.__type__ === 'cc.Graphics');
  assert.deepEqual(
    [shield._fillColor.r, shield._fillColor.g, shield._fillColor.b, shield._fillColor.a],
    [20, 24, 18, 150]
  );
  const card = get(shell.card),
    body = get(shell.body);
  assert.equal(card._name, 'GoldenIslandDialog');
  assert.equal(get(body._parent), card);
  assert.equal(body._name, 'Body');
  const frame = (key: string) =>
    read('assets/farm/bundles/golden-island-ui/images/' + key + '.png.meta').subMetas.f9941.uuid;
  for (const [key, skin] of [
    ['window', 'window'],
    ['factoryFrame', 'buildingWindow'],
    ['livestockFrame', 'buildingWindow'],
  ]) {
    const sprite = get(shell[key]);
    assert.equal(sprite.__type__, 'cc.Sprite');
    assert.equal(sprite._spriteFrame.__uuid__, frame(skin));
    assert.equal(sprite._type, 1, key + ': native slice borders are used');
  }
  for (const r of [shell.inset, shell.closeIcon]) {
    const n = get(r);
    assert.ok(n._components.some((c: any) => get(c).__type__ === 'cc.Sprite'));
  }
  const title = get(shell.title);
  assert.equal(title.__type__, 'cc.Label');
  assert.ok(title._string && title._font.__uuid__);
  assert.ok(shell.buildingTitleFont.__uuid__, 'responsive title font is an editable prefab dependency');
  const close = get(shell.closeButton),
    button = componentType(path.join(root, 'assets/farm/scripts/render/FarmButton.ts'));
  assert.equal(close._name, 'close-panel');
  assert.equal(close._components.filter((r: any) => get(r).__type__ === button).length, 1);
  assert.equal(get(get(shell.closeIcon)._parent), close);
  assert.ok(body._children.length, 'standalone authored preview has visible content before gameplay binds a panel');
  assert.equal(shell.factoryDialogPrefab.__uuid__, read('assets/farm/prefabs/ui/FactoryDialogFrame.prefab.meta').uuid);
  assert.equal(
    shell.factoryDialogPrefab.__expectedType__,
    'cc.Prefab',
    'factory frame is linked directly to its source asset'
  );
});

test('FactoryDialogFrame preserves original UI artwork in a standalone prefab with an anchored close button', () => {
  const objects = read('assets/farm/prefabs/ui/FactoryDialogFrame.prefab');
  assertGraph(objects);
  const get = (r: any) => objects[r.__id__];
  const root = get(objects[0].data),
    type = componentType(path.join(__dirname, '../assets/farm/scripts/ui/production/FactoryDialogFrameView.ts'));
  const view = root._components.map(get).find((c: any) => c.__type__ === type);
  assert.ok(view);
  for (const [field, asset] of [
    ['background', 'buildingWindow'],
    ['closeFace', 'close'],
  ]) {
    const sprite = get(view[field]);
    assert.equal(sprite.__type__, 'cc.Sprite');
    assert.equal(
      sprite._spriteFrame.__uuid__,
      read(`assets/farm/bundles/golden-island-ui/images/${asset}.png.meta`).subMetas.f9941.uuid
    );
  }
  assert.equal(get(view.background)._type, 1, 'original frame keeps its nine-slice borders');
  const title = get(view.title);
  assert.equal(title.__type__, 'cc.Label');
  assert.ok(title._string && title._font.__uuid__);
  const close = get(view.closeButton),
    components = close._components.map(get);
  const size = components.find((c: any) => c.__type__ === 'cc.UITransform')._contentSize;
  assert.ok(size.width >= 44 && size.height >= 44, 'standalone close target is touch sized');
  const anchor = components.find((c: any) => c.__type__ === 'cc.Widget');
  assert.ok(anchor._alignFlags & 1 && anchor._alignFlags & 32, 'Inspector Widget anchors X to top and right');
  assert.ok(
    components.some(
      (c: any) => c.__type__ === componentType(path.join(__dirname, '../assets/farm/scripts/render/FarmButton.ts'))
    )
  );
});
