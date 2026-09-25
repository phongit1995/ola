'use strict';
// Validate the committed native UI bundle without requiring the reference APK or UnityPy.
const assert = require('node:assert/strict');
const fs = require('node:fs'), path = require('node:path'), crypto = require('node:crypto');
const root = path.resolve(__dirname, '../assets/farm/bundles/golden-island-ui');
const read = file => JSON.parse(fs.readFileSync(file, 'utf8'));
const manifest = read(path.join(root, 'manifest.json'));
const keys = ['window', 'buildingWindow', 'close', 'card', 'inset', 'panelInfo', 'green',
  'slot', 'recipe', 'selected', 'material', 'info', 'tab', 'tabInactive', 'progress', 'progressFill',
  'shopTab', 'shopTabOpen', 'shopRim', 'shopBuilding', 'shopAnimal', 'shopCardLocked',
  'shopPrice', 'shopLock', 'shopQuantity', 'navShop'];
// These are the construction shop, animal shop and HUD button, not ShopPanel's IAP packs.
const shopSources = {
  shopTab: ['BuildingUI/All/Btn/BtnBuilding', '-3689956493084992207'],
  shopTabOpen: ['BuildingUI/All/HeadingIcon/Building/HeaderBuilding/Open', '7592237874239859551'],
  shopRim: ['BuildingUI/All/HeadingIcon/Building/HeaderBuilding/Open/Left', '-40091456154239596'],
  shopBuilding: ['BuildingUI/All/HeadingIcon/Building/IconBuilding', '4411972411148896896'],
  shopAnimal: ['BuildingUI/All/HeadingIcon/Animal/IconAnimal', '1524583117652309725'],
  shopCardLocked: ['HouseBuildingUI', '-1109556530181115338'],
  shopPrice: ['AnimalBuildingUI/Price', '-5077226847215697857'],
  shopLock: ['AnimalBuildingUI/Lock/Icon', '4887603948703973654'],
  shopQuantity: ['AnimalBuildingUI/BgUnlock/QuantityBG', '6209954408127948357'],
  navShop: ['GameplayMainUI/SafeArea/PanelBot/GroupLeft/Building', '7746233789321162327'],
};
assert.deepEqual(Object.keys(manifest.images).sort(), [...keys].sort());
assert.match(manifest.source, /^Golden Island 1\.0\.24/);
assert.match(manifest.sourceBundleSHA256, /^[a-f0-9]{64}$/);
const bundle = read(root + '.meta');
assert.equal(bundle.userData.isBundle, true);
assert.equal(bundle.userData.bundleName, 'golden-island-ui');
const ids = new Set();
for (const [key, info] of Object.entries(manifest.images)) {
  assert.equal(info.resource, 'images/' + key);
  assert.equal(typeof info.sourcePathId, 'string', key + ': preserve the full 64-bit Unity path ID');
  assert.match(info.sourcePathId, /^-?\d+$/);
  assert.ok(info.sourceNode.includes('/') || key === 'shopCardLocked', key + ': source prefab path');
  if (shopSources[key]) assert.deepEqual([info.sourceNode, info.sourcePathId], shopSources[key], key + ': exact native shop Image reference');
  assert.ok(info.sourceName && info.sourceAssetFile);
  const file = path.join(root, info.resource + '.png'), bytes = fs.readFileSync(file);
  assert.equal(bytes.subarray(0, 8).toString('hex'), '89504e470d0a1a0a', key + ': PNG signature');
  assert.equal(crypto.createHash('sha256').update(bytes).digest('hex'), info.sha256, key + ': native PNG bytes');
  const size = [bytes.readUInt32BE(16), bytes.readUInt32BE(20)];
  assert.deepEqual(size, info.size, key + ': untrimmed source dimensions');
  const [left, bottom, right, top] = info.border;
  assert.equal(info.border.length, 4);
  assert.ok(info.border.every(v => Number.isFinite(v) && v >= 0));
  assert.ok(left + right < size[0] && bottom + top < size[1], key + ': positive center slice');
  if (info.borderAdjustment) assert.equal(key, 'panelInfo');
  else assert.deepEqual(info.border, info.sourceBorder, key + ': original slice borders');
  const meta = read(file + '.meta');
  assert.ok(!ids.has(meta.uuid), key + ': unique image UUID');
  ids.add(meta.uuid);
  const texture = meta.subMetas['6c48a'], sprite = meta.subMetas.f9941;
  assert.equal(texture.uuid, meta.uuid + '@6c48a');
  assert.equal(sprite.uuid, meta.uuid + '@f9941');
  const f = sprite.userData;
  assert.deepEqual([f.rawWidth, f.rawHeight, f.width, f.height], [...size, ...size]);
  assert.deepEqual([f.trimX, f.trimY, f.offsetX, f.offsetY], [0, 0, 0, 0]);
  assert.equal(f.trimType, 'none');
  assert.deepEqual([f.borderLeft, f.borderBottom, f.borderRight, f.borderTop], info.border);
}
const actual = fs.readdirSync(path.join(root, 'images')).filter(n => n.endsWith('.png')).sort();
assert.deepEqual(actual, keys.map(k => k + '.png').sort(), 'no unused images in the native UI bundle');
const metas = fs.readdirSync(path.join(root, 'images')).filter(n => n.endsWith('.png.meta')).sort();
assert.deepEqual(metas, keys.map(k => k + '.png.meta').sort(), 'no orphaned image metadata');
assert.equal(manifest.images.card.sourcePathId, '1527293709264809525', 'unlocked shop card reuses the existing native card sprite');
console.log(`Verified ${keys.length} Golden Island UI sprites: native bytes, exact prefab references, positive slice centers, complete Cocos metadata.`);
