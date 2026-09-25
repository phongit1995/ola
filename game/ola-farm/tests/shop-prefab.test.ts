import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';

const root = path.resolve(__dirname, '..');
const read = (file: string): any => JSON.parse(fs.readFileSync(path.join(root, file), 'utf8'));
const { uiPrefabPath } = require('../tools/ui-prefab-paths.cjs');
const { componentTypeByName } = require('../tools/cocos-ids.cjs');
const script = (name: string): string => componentTypeByName(path.basename(name));
const frame = (key: string): string =>
  read(`assets/farm/bundles/golden-island-ui/images/${key}.png.meta`).subMetas.f9941.uuid;
const frames = new Set(Object.keys(read('assets/farm/bundles/golden-island-ui/manifest.json').images).map(frame));
const coinFrame = read('assets/resources/ported/files/309f7dbb66b8a5483ecc.png.meta').subMetas.f9941.uuid;
assert.equal(coinFrame, '944e84bc-66e4-4bde-b6ff-43975d0d8c07@f9941');
frames.add(coinFrame);
const font = read('assets/farm/fonts/hud/PoetsenOne-Regular.ttf.meta').uuid;

function prefab(name: string) {
  const file = 'assets/farm/' + uiPrefabPath(name),
    objects = read(file),
    meta = read(file + '.meta');
  const get = (ref: any): any => {
    assert.ok(ref && Number.isInteger(ref.__id__) && objects[ref.__id__], name + ': serialized reference resolves');
    return objects[ref.__id__];
  };
  const node = get(objects[0].data),
    nodes = new Set<any>();
  const visit = (value: any): void => {
    nodes.add(value);
    for (const ref of value._children ?? []) {
      const child = get(ref);
      assert.equal(get(child._parent), value, name + ': authored hierarchy is connected');
      visit(child);
    }
  };
  visit(node);
  const check = (value: any): void => {
    if (!value || typeof value !== 'object') return;
    if (Object.prototype.hasOwnProperty.call(value, '__id__')) get(value);
    for (const item of Object.values(value)) check(item);
  };
  objects.forEach(check);
  for (const entry of objects) {
    if (entry.__type__ === 'cc.Sprite')
      assert.ok(frames.has(entry._spriteFrame?.__uuid__), name + ': sprite resolves to a real imported UI asset');
    if (entry.__type__ === 'cc.Label')
      assert.equal(entry._font?.__uuid__, font, name + ': label resolves to the real Poetsen font asset');
  }
  for (const entry of objects.filter((o: any) => o.__type__ === 'cc.Node'))
    assert.ok(nodes.has(entry), name + ': serialized node is reachable from prefab root');
  const component = (name: string): any => {
    const matches = node._components.map(get).filter((c: any) => c.__type__ === script('ui/' + name));
    assert.equal(matches.length, 1, name + ': root has one linked custom component');
    return matches[0];
  };
  const linked = (ref: any, type: string): any => {
    const value = get(ref);
    assert.equal(value.__type__, type);
    if (type === 'cc.Node') assert.ok(nodes.has(value));
    else {
      const owner = get(value.node);
      assert.ok(nodes.has(owner));
      assert.ok(
        owner._components.some((r: any) => get(r) === value),
        'component is attached to its authored node'
      );
    }
    return value;
  };
  return { objects, meta, node, get, component, linked };
}

test('Shop is a serialized drawer with linked controls, scroll mask, card prefab and GameApp scene reference', () => {
  const p = prefab('Shop'),
    view = p.component('ShopView');
  assert.equal(p.node._name, 'Shop', 'Creator keeps the authored prefab name; PanelHost assigns the runtime alias');
  for (const key of ['drawer', 'rim', 'animalTab', 'buildingTab', 'dismiss', 'productionReturn', 'empty'])
    p.linked(view[key], 'cc.Node');
  const scroll = p.linked(view.scroll, 'cc.ScrollView'),
    content = p.linked(scroll._content, 'cc.Node');
  const mask = p.get(content._parent);
  assert.ok(
    mask._components.some((ref: any) => p.get(ref).__type__ === 'cc.Mask'),
    'serialized viewport clips the horizontal card row'
  );
  assert.equal(scroll.horizontal, true);
  assert.equal(scroll.vertical, false);
  const sprites = p.objects.filter((o: any) => o.__type__ === 'cc.Sprite');
  for (const key of ['shopRim', 'shopTab', 'shopTabOpen', 'shopAnimal', 'shopBuilding'])
    assert.ok(
      sprites.some((s: any) => s._spriteFrame?.__uuid__ === frame(key)),
      key + ': imported sprite is authored before runtime'
    );
  assert.equal(view.cardPrefab.__uuid__, read('assets/farm/prefabs/ui/ShopCard.prefab.meta').uuid);
  for (const key of ['cardGap', 'cardPadding', 'portraitCardWidth', 'compactCardWidth', 'compactCardHeight'])
    assert.ok(
      Number.isFinite(view[key]) && view[key] > 0,
      key + ': layout can be edited through serialized properties'
    );
  const scene = read('assets/farm/scenes/Farm.scene'),
    app = scene.find((o: any) => o.__type__ === script('app/bootstrap/GameApp'));
  assert.equal(app.shopPrefab.__uuid__, p.meta.uuid, 'GameApp references this real prefab as a scene dependency');
});

test('ShopCard contains real editable labels, sprites, button and linked yard preview before gameplay', () => {
  const p = prefab('ShopCard'),
    view = p.component('ShopCardView');
  assert.equal(p.node._name, 'ShopCard');
  for (const key of ['background', 'lockedBackground', 'priceBackground', 'coin']) p.linked(view[key], 'cc.Sprite');
  for (const key of ['title', 'quantity', 'description', 'priceLabel']) {
    const label = p.linked(view[key], 'cc.Label');
    assert.ok(label._string.length > 0, key + ': readable authored preview text');
    assert.ok(label._font?.__uuid__, key + ': font asset is serialized');
  }
  for (const key of ['model', 'priceButton', 'lock']) p.linked(view[key], 'cc.Node');
  assert.equal(p.get(view.background)._spriteFrame.__uuid__, frame('card'));
  assert.equal(p.get(view.lockedBackground)._spriteFrame.__uuid__, frame('shopCardLocked'));
  const background = p.get(p.get(view.background).node);
  assert.equal(background._name, 'CardBackground');
  assert.equal(p.get(background._parent), p.node);
  assert.equal(p.get(p.get(view.title).node)._name, 'ShopName');
  const price = p.get(view.priceButton),
    priceComponents = price._components.map(p.get);
  const priceBackground = p.get(view.priceBackground),
    priceBackgroundNode = p.get(priceBackground.node);
  assert.equal(priceBackground._spriteFrame.__uuid__, frame('shopPrice'));
  assert.equal(priceBackgroundNode._name, 'PriceBackground');
  assert.equal(p.get(priceBackgroundNode._parent), price);
  assert.equal(
    priceComponents.filter((c: any) => c.__type__ === 'cc.Sprite').length,
    0,
    'input area does not duplicate the authored price background'
  );
  assert.ok(
    priceComponents.some((c: any) => c.__type__ === script('render/FarmButton')),
    'price input component is authored'
  );
  const coin = p.get(view.coin),
    coinNode = p.get(coin.node);
  assert.equal(coin._spriteFrame.__uuid__, coinFrame);
  assert.equal(coinNode._name, 'PriceCoin');
  assert.equal(p.get(coinNode._parent), price);
  assert.equal(coinNode._active, true, 'numeric price has a visible currency before binding');
  const priceLabel = p.get(view.priceLabel),
    description = p.get(view.description);
  assert.match(priceLabel._string, /^\d+$/, 'authored price is numeric without an extra action/currency suffix');
  assert.ok(Number(priceLabel._string) > 0);
  assert.ok(
    priceLabel._fontSize > 0 && priceLabel._fontSize <= 16,
    'bottom text is smaller than the previous20-point label'
  );
  assert.ok(description._fontSize > 0 && description._fontSize <= 13, 'explanation uses compact authored typography');
  const yardUuid = read('assets/farm/bundles/farm-town/prefabs/yard-coop.prefab.meta').uuid;
  const linkedYard = p.objects.find((o: any) => o.__type__ === 'cc.PrefabInfo' && o.asset?.__uuid__ === yardUuid);
  assert.ok(linkedYard, 'the Editor card already previews an actual linked yard prefab');
  assert.equal(p.get(linkedYard.instance).__type__, 'cc.PrefabInstance');
  const rootInfo = p.get(p.node._prefab);
  assert.ok(
    rootInfo.nestedPrefabInstanceRoots.some((r: any) => p.get(p.get(r)._prefab) === linkedYard),
    'Creator can expand the nested yard without Shop render code'
  );
});
