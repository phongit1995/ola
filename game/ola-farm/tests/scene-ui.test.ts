import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';

const root = path.resolve(__dirname, '..');
const read = (file: string): any => JSON.parse(fs.readFileSync(path.join(root, file), 'utf8'));
// Same metadata format Creator uses when resolving serialized custom components.
const { componentType, componentTypeByName } = require('../tools/cocos-ids.cjs');

test('Farm scene contains an active linked map and a fully wired native HUD before gameplay starts', () => {
  const scene = read('assets/farm/scenes/Farm.scene');
  const get = (ref: any): any => {
    assert.ok(ref && Number.isInteger(ref.__id__) && scene[ref.__id__], 'serialized reference resolves');
    return scene[ref.__id__];
  };
  const type = (name: string): string => componentTypeByName(path.basename(name));
  const app = scene.find((o: any) => o.__type__ === type('app/bootstrap/GameApp'));
  const gameRoot = get(app.root),
    map = get(app.map);
  const sceneRoot = scene.find((o: any) => o.__type__ === 'cc.Scene');
  const override = get(sceneRoot._prefab)
    .targetOverrides.map(get)
    .find((o: any) => get(o.source) === app && o.propertyPath.join('.') === 'hud');
  assert.ok(override, 'GameApp.hud is a typed cross-prefab component binding');
  const hudInstance = get(override.target),
    hudInfo = get(hudInstance._prefab);
  assert.equal(hudInfo.asset.__uuid__, read('assets/farm/prefabs/ui/HUD.prefab.meta').uuid);
  const authoredHud = read('assets/farm/prefabs/ui/HUD.prefab');
  const hget = (ref: any): any => {
    assert.ok(ref && Number.isInteger(ref.__id__) && authoredHud[ref.__id__], 'HUD prefab reference resolves');
    return authoredHud[ref.__id__];
  };
  const hud = authoredHud.find((o: any) => o.__type__ === type('ui/hud/HudView'));
  assert.deepEqual(get(override.targetInfo).localID, [hget(hud.__prefab).fileId]);
  assert.ok(get(sceneRoot._prefab).nestedPrefabInstanceRoots.some((r: any) => get(r) === hudInstance));
  assert.equal(gameRoot._name, 'GameRoot');
  assert.equal(map.__type__, type('map/FarmMapView'));
  assert.equal(hud.__type__, type('ui/hud/HudView'));
  assert.equal(get(get(map.node)._parent), gameRoot);
  assert.equal(get(hudInstance._parent), gameRoot);
  assert.equal(gameRoot._active, true);
  assert.equal(get(map.node)._active, true);
  assert.equal(hget(hud.node)._active, true);

  const farm = get(map.authoredMap),
    info = get(farm._prefab);
  assert.ok(
    get(sceneRoot._prefab).nestedPrefabInstanceRoots.some((r: any) => get(r) === farm),
    'scene expands the linked map before activation'
  );
  assert.equal(get(farm._parent), get(map.world));
  assert.equal(info.asset.__uuid__, read('assets/farm/prefabs/map/scenes.prefab.meta').uuid);
  assert.equal(get(info.instance).__type__, 'cc.PrefabInstance');
  const prefab = read('assets/farm/prefabs/map/scenes.prefab');
  const prefabRoot = prefab[prefab[0].data.__id__];
  // Creator omits inherited fields when it saves a compact prefab instance.
  assert.equal(farm._active ?? prefabRoot._active, true);
  assert.equal(info.fileId, prefab[prefabRoot._prefab.__id__].fileId, 'map stays linked to the source prefab');
  assert.ok(
    get(map.node)._components.some((r: any) => get(r).__type__ === 'cc.Mask'),
    'map is clipped below the HUD'
  );

  assert.ok(!hget(hud.header)._children.some((c: any) => hget(c)._name === 'Day'), 'the day line is gone');
  for (const key of ['coins', 'diamonds', 'level', 'xp', 'hint', 'stock']) {
    const label = hget(hud[key]);
    assert.equal(label.__type__, 'cc.Label');
    assert.ok(label._string.length > 0, key + ' is visible without GameApp');
    assert.ok(label._font?.__uuid__, key + ' has an authored font');
  }
  // The XP fill is a nine-slice inside the track; HudView only changes its width, so the artwork must be authored.
  const fill = hget(hud.xpFill);
  assert.equal(fill.__type__, 'cc.Sprite');
  assert.equal(fill._type, 1);
  const hudImages = read('assets/farm/data/farm-hud/manifest.json').images.map((i: any) => i.spriteFrame);
  assert.ok(hudImages.includes(fill._spriteFrame.__uuid__), 'XP fill uses an imported HUD sprite');
  const clip = hget(hget(fill.node)._parent),
    track = hget(clip._parent);
  assert.ok(
    clip._components.some((r: any) => hget(r).__type__ === 'cc.Mask'),
    "the fill is clipped by a Mask like Unity's Slider"
  );
  assert.equal(track._name, 'XpTrack');
  assert.equal(hget(hget(hud.level).node)._name, 'LevelNumber');
  assert.equal(hget(hget(hud.xp).node)._name, 'XpText');
  const level = hget(hget(hget(hud.level).node)._parent),
    names = level._children.map((c: any) => hget(c)._name);
  for (const name of ['AvatarBacking', 'Avatar', 'AvatarFrame', 'Star', 'LevelNumber', 'XpTrack', 'XpText'])
    assert.ok(names.includes(name), name + ' is authored in the level group');
  assert.equal(hget(hget(hud.coinsPlusButton)._parent)._name, 'CoinWallet', 'the "+" sits on the coin wallet');
  assert.equal(hget(hget(hud.gemsPlusButton)._parent)._name, 'DiamondWallet', 'the gem "+" sits on the gem box');
  for (const key of [
    'pauseButton',
    'coinsPlusButton',
    'gemsPlusButton',
    'shopButton',
    'inventoryButton',
    'factoryButton',
  ]) {
    const button = hget(hud[key]);
    assert.equal(button._active, true);
    assert.equal(button._components.filter((r: any) => hget(r).__type__ === type('render/FarmButton')).length, 1);
    assert.ok(
      button._children.some((r: any) => hget(r)._components.some((c: any) => hget(c).__type__ === 'cc.Sprite')),
      key + ' has native artwork'
    );
  }
  const shop = hget(hud.shopButton);
  assert.equal(shop._name, 'shop');
  assert.equal(hud.farmButton, undefined, 'Shop replaces the old Farm navigation binding');
  const icon = hget(shop._children.find((r: any) => hget(r)._name === 'Icon'));
  const sprite = hget(icon._components.find((r: any) => hget(r).__type__ === 'cc.Sprite'));
  const imported = read('assets/farm/bundles/golden-island-ui/images/navShop.png.meta');
  assert.equal(
    sprite._spriteFrame.__uuid__,
    imported.uuid + '@f9941',
    'Shop navigation uses the original Golden Island building button'
  );
});

test('Canvas explicitly links every UI module to a populated editable prefab', () => {
  const scene = read('assets/farm/scenes/Farm.scene');
  const app = scene.find(
    (o: any) => o.__type__ === componentType(path.join(root, 'assets/farm/scripts/app/bootstrap/GameApp.ts'))
  );
  const library = scene[app.uiPrefabs.__id__];
  assert.equal(library.__type__, componentType(path.join(root, 'assets/farm/scripts/render/UiPrefabs.ts')));
  assert.equal(library.node.__id__, app.node.__id__, 'one scene-owned registry is wired before GameApp loads');
  const script = fs.readFileSync(path.join(root, 'assets/farm/scripts/render/UiPrefabs.ts'), 'utf8');
  const properties = [...script.matchAll(/@property\(Prefab\)\s+(\w+)/g)].map(match => match[1]);
  assert.equal(properties.length, 8);
  assert.equal(new Set(properties.map(key => library[key].__uuid__)).size, properties.length);
  const files = fs
    .readdirSync(path.join(root, 'assets/farm/prefabs/ui'), { recursive: true })
    .map(String)
    .filter(file => file.endsWith('.prefab'));
  for (const key of properties) {
    const file = files.find(file => read('assets/farm/prefabs/ui/' + file + '.meta').uuid === library[key].__uuid__);
    assert.ok(file, key + ' resolves to a checked-in prefab');
    const graph = read('assets/farm/prefabs/ui/' + file),
      node = graph[graph[0].data.__id__];
    assert.ok(
      node._children.length > 0 && graph.filter((o: any) => o.__type__ === 'cc.Node').length >= 3,
      key + ' contains an authored hierarchy'
    );
    assert.ok(
      graph.some((o: any) => o.__type__ === 'cc.Sprite' && o._spriteFrame?.__uuid__),
      key + ' has visible imported artwork'
    );
    assert.ok(
      node._components.some((r: any) => !graph[r.__id__].__type__.startsWith('cc.')),
      key + ' binds through an authored View component'
    );
  }
});
