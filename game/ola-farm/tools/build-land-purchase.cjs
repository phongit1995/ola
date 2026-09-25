'use strict';
const { uiPrefabPath } = require('./ui-prefab-paths.cjs');
// Creates defaults once. Only --reset overwrites the designer's prefab edits.
const fs = require('node:fs'), path = require('node:path');
const { UiPrefabBuilder, assets, assetRef, color, componentTypeByName, read } = require('./ui-prefab-builder.cjs');
const { assertGraph } = require('./prefab-graph.cjs');
const destination = path.join(assets, uiPrefabPath('LandPurchase'));
if (!fs.existsSync(destination) || process.argv.includes('--reset')) {
  const b = new UiPrefabBuilder('LandPurchase', 720, 1280);
  b.component(b.root, 'cc.BlockInputEvents');
  b.component(b.root, 'cc.Graphics', { _lineWidth: 1, _strokeColor: color([27, 42, 21, 150]),
    _fillColor: color([27, 42, 21, 150]), _lineJoin: 0, _lineCap: 0, _miterLimit: 10 });
  const skin = key => 'farm/bundles/golden-island-ui/images/' + key + '.png';
  const font = assetRef('fonts/hud/PoetsenOne-Regular.ttf', 'cc.TTFFont');
  const ink = [110, 60, 32];
  const label = (parent, name, text, x, y, width, height, size, tint = ink, options = {}) =>
    b.label(parent, name, text, x, y, width, height, size, tint, { font, wrap: false, ...options });
  // Scale just the nine-slice artwork to keep its rounded border delicate at this compact size.
  const surface = (parent, name, key, x, y, width, height, scale) => {
    const n = b.sprite(parent, name, skin(key), x, y, width / scale, height / scale, { sliced: true });
    b.objects[n]._lscale.x = b.objects[n]._lscale.y = scale;
    return n;
  };
  const card = b.node(b.root, 'LandCard', 0, 0, 360, 452);
  surface(card, 'Frame', 'window', 0, 0, 360, 452, .3);
  surface(card, 'Paper', 'inset', 0, -10, 340, 410, .3);
  label(card, 'Eyebrow', 'MỞ RỘNG NÔNG TRẠI', 0, 201, 260, 20, 11, [147, 78, 38]);
  const title = label(card, 'Title', 'Mua ô đất #7', 0, 171, 290, 36, 25, [143, 65, 32]);
  const ownership = label(card, 'Ownership', '6 / 40 ô đã mở', 0, 143, 220, 22, 13, [141, 117, 81]);
  const atlasType = componentTypeByName('AtlasSprite');
  const soil = (name, level, x, y, width) => {
    const data = read(path.join(assets, `prefabs/items/plots/Soil${level}.prefab`));
    const region = data.find(o => o.__type__ === atlasType);
    const sprite = data.find(o => o.__type__ === 'cc.Sprite');
    const n = b.sprite(card, name, sprite._spriteFrame, x, y, width,
      width * (region ? region.region.height / region.region.width : 108 / 196));
    b.getComponent(n, 'cc.Sprite')._isTrimmedMode = true;
    if (region) b.component(n, atlasType, { texture: region.texture, region: region.region });
    return n;
  };
  soil('ExistingSoilLeft', 1, -63, 88, 106);
  soil('ExistingSoilRight', 1, 63, 88, 106);
  soil('NewGreenLand', 0, 0, 59, 186);
  surface(card, 'BenefitPill', 'material', 0, -9, 216, 26, .35);
  label(card, 'Benefit', '+1 Ô TRỒNG CÂY', 0, -8, 204, 24, 12, [103, 83, 47]);
  const offer = label(card, 'LandOffer', 'Cần level 2', 0, -45, 294, 38, 26, [87, 103, 43]);
  const requirement = label(card, 'LandRequirement', 'Bạn đang ở level 1', 0, -77, 310, 24, 13, [141, 117, 81]);
  const wallet = label(card, 'LandWallet', 'Số dư: 500 xu', 0, -106, 310, 26, 13, [141, 117, 81]);
  const lock = b.sprite(card, 'LandLock', skin('shopLock'), 0, 58, 31, 35);
  const coin = b.sprite(card, 'LandCoin', 'farm/bundles/farm-town-ui/images/coin.png', -117, -45, 28, 28);
  b.objects[coin]._active = false;
  const buttonType = componentTypeByName('FarmButton');
  const button = (name, x, y, width, height) => {
    const n = b.node(card, name, x, y, width, height);
    b.component(n, buttonType, { clickEvents: [], _interactable: true, _transition: 0, _target: b.reference(n) });
    b.component(n, 'cc.BlockInputEvents');
    return n;
  };
  const buy = button('confirm', 0, -151, 292, 58);
  const buyFace = surface(buy, 'ButtonFace', 'green', 0, 0, 292, 58, .42);
  b.getComponent(buyFace, 'cc.Sprite')._useGrayscale = true;
  const buyTitle = label(buy, 'Title', 'Đạt level 2 để mở', 0, 2, 268, 40, 18, [255,255,255],
    { outline: [73,105,35,255], outlineWidth: 1.2 });
  const later = button('cancel-confirm', 0, -198, 220, 38);
  label(later, 'Title', 'Để sau', 0, 0, 200, 28, 14, [140,104,70]);
  const close = button('close-panel', 158, 202, 44, 44);
  b.sprite(close, 'CloseFace', skin('close'), 0, 0, 32, 31);
  b.write(uiPrefabPath('LandPurchase'), componentTypeByName('LandPurchaseView'), {
    card: b.reference(card), title: b.reference(title, 'cc.Label'), ownership: b.reference(ownership, 'cc.Label'),
    offer: b.reference(offer, 'cc.Label'), requirement: b.reference(requirement, 'cc.Label'), wallet: b.reference(wallet, 'cc.Label'),
    lock: b.reference(lock), coin: b.reference(coin), buyButton: b.reference(buy), buyFace: b.reference(buyFace, 'cc.Sprite'),
    buyTitle: b.reference(buyTitle, 'cc.Label'), closeButton: b.reference(close), laterButton: b.reference(later),
    maxScreenWidth: 380, screenMargin: 16,
  });
}
const scenePath = path.join(assets, 'scenes/Farm.scene'), scene = read(scenePath);
const registry = scene.find(o => o.__type__ === componentTypeByName('UiPrefabs'));
const link = { __uuid__: read(destination + '.meta').uuid, __expectedType__: 'cc.Prefab' };
if (JSON.stringify(registry.landPurchase) !== JSON.stringify(link)) {
  registry.landPurchase = link;
  fs.writeFileSync(scenePath, JSON.stringify(scene, null, 2) + '\n');
}
assertGraph(read(destination), { file: destination });
console.log('LandPurchase.prefab: authored card, land artwork, locked/price states and three linked buttons.');
