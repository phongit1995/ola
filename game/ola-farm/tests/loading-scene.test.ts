import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';

const root = path.resolve(__dirname, '..');
const read = (file: string): any => JSON.parse(fs.readFileSync(path.join(root, file), 'utf8'));
const { componentTypeByName } = require('../tools/cocos-ids.cjs');
const type = (name: string): string => componentTypeByName(path.basename(name));

test('Loading is the build entry and loads Farm by name without pulling its map into the entry scene', () => {
  const loadingMeta = read('assets/farm/scenes/Loading.scene.meta'),
    farmMeta = read('assets/farm/scenes/Farm.scene.meta');
  const build = read('build-configs/farm-web-mobile.json');
  assert.equal(build.startScene, loadingMeta.uuid);
  assert.deepEqual(build.scenes, [
    { url: 'db://assets/farm/scenes/Loading.scene', uuid: loadingMeta.uuid },
    { url: 'db://assets/farm/scenes/Farm.scene', uuid: farmMeta.uuid },
  ]);

  const scene = read('assets/farm/scenes/Loading.scene'),
    get = (ref: any): any => scene[ref.__id__];
  const sceneRoot = get(scene[0].scene),
    controller = scene.find((object: any) => object.__type__ === type('app/bootstrap/LoadingSceneController'));
  assert.equal(scene[0]._name, 'Loading');
  assert.equal(sceneRoot._id, loadingMeta.uuid);
  assert.ok(controller && controller._enabled);
  assert.equal(controller.gameScene, 'Farm');
  const canvas = get(controller.node);
  assert.equal(canvas._name, 'LoadingCanvas');
  assert.equal(canvas._active, true);
  assert.equal(
    get(canvas._parent),
    sceneRoot,
    'the loading Canvas is a direct scene child so it can persist across handoff'
  );
  const canvasComponent = canvas._components.map(get).find((object: any) => object.__type__ === 'cc.Canvas');
  assert.ok(canvasComponent && canvasComponent._enabled);
  const camera = get(canvasComponent._cameraComponent);
  assert.equal(camera.__type__, 'cc.Camera');
  assert.equal(camera._enabled, true);
  assert.equal(get(get(camera.node)._parent), canvas, 'the loading camera survives with its Canvas');
  const farm = read('assets/farm/scenes/Farm.scene');
  assert.ok(
    camera._priority >
      Math.max(...farm.filter((object: any) => object.__type__ === 'cc.Camera').map((object: any) => object._priority)),
    'loading renders over Farm until boot completes'
  );
  for (const [key, file] of [
    ['plotFont', 'FarmLabel'],
    ['walletFont', 'WalletLabel'],
  ]) {
    assert.deepEqual(controller[key], {
      __uuid__: read(`assets/farm/fonts/farm/${file}.fnt.meta`).uuid,
      __expectedType__: 'cc.BitmapFont',
    });
  }

  const overrides = get(sceneRoot._prefab).targetOverrides.map(get);
  const screenBinding = overrides.find(
    (object: any) => get(object.source) === controller && object.propertyPath.join('.') === 'screen'
  );
  assert.ok(screenBinding, 'the controller links the component inside the authored loading prefab');
  const screenNode = get(screenBinding.target),
    screenInfo = get(screenNode._prefab);
  assert.equal(get(screenNode._parent), canvas);
  assert.equal(screenInfo.asset.__uuid__, read('assets/farm/prefabs/ui/LoadingScreen.prefab.meta').uuid);
  const prefab = read('assets/farm/prefabs/ui/LoadingScreen.prefab');
  const screen = prefab.find((object: any) => object.__type__ === type('ui/loading/LoadingScreenView'));
  assert.deepEqual(get(screenBinding.targetInfo).localID, [prefab[screen.__prefab.__id__].fileId]);
  assert.equal(screenInfo.fileId, prefab[prefab[prefab[0].data.__id__]._prefab.__id__].fileId);

  const dependencies = new Set<string>();
  const collect = (value: any): void => {
    if (!value || typeof value !== 'object') return;
    if (value.__uuid__) dependencies.add(value.__uuid__);
    Object.values(value).forEach(collect);
  };
  collect(scene);
  assert.deepEqual(
    [...dependencies].sort(),
    [screenInfo.asset.__uuid__, controller.plotFont.__uuid__, controller.walletFont.__uuid__].sort(),
    'the entry scene references only its loading UI and fonts'
  );
  assert.deepEqual(
    scene
      .filter((object: any) => object.node && !object.__type__.startsWith('cc.'))
      .map((object: any) => object.__type__),
    [type('app/bootstrap/LoadingSceneController')],
    'GameApp and map components belong to Farm, not Loading'
  );
});

test('LoadingScreen has visible native artwork and input blocking before any loading script runs', () => {
  const prefab = read('assets/farm/prefabs/ui/LoadingScreen.prefab'),
    get = (ref: any): any => prefab[ref.__id__];
  const screenRoot = get(prefab[0].data),
    view = prefab.find((object: any) => object.__type__ === type('ui/loading/LoadingScreenView'));
  assert.equal(get(view.title)._string, 'Ola Farm');
  assert.equal(screenRoot._active, true);
  assert.ok(
    screenRoot._components.map(get).some((object: any) => object.__type__ === 'cc.BlockInputEvents' && object._enabled)
  );
  assert.equal(
    prefab.some((object: any) => object.__type__ === 'cc.Graphics'),
    false,
    'artwork is editable native sprites rather than paths drawn during setup'
  );
  const sprites = prefab.filter((object: any) => object.__type__ === 'cc.Sprite');
  assert.ok(sprites.length >= 3, 'background, illustration and progress artwork are authored');
  for (const sprite of sprites)
    assert.ok(sprite._spriteFrame?.__uuid__, 'every authored sprite has its image before setup');
  for (const key of ['title', 'status']) {
    const label = get(view[key]);
    assert.equal(label.__type__, 'cc.Label');
    assert.ok(label._string.trim());
    assert.equal(label._enabled, true);
    assert.equal(get(label.node)._active, true);
  }
  const backdrop = get(view.backdrop);
  assert.equal(backdrop.__type__, 'cc.Sprite');
  assert.equal(backdrop._color.a, 255);
  assert.equal(backdrop._enabled, true);
  assert.equal(get(backdrop.node)._active, true);
  assert.deepEqual(
    prefab
      .filter((object: any) => object.node && !object.__type__.startsWith('cc.'))
      .map((object: any) => object.__type__),
    [type('ui/loading/LoadingScreenView')],
    'native loading artwork has no gameplay renderer dependency'
  );
});
