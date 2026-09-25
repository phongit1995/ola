'use strict';
const { uiPrefabPath } = require('./ui-prefab-paths.cjs');
// Explicit default-art reset for the editable care bar; not part of the build pipeline.
const path = require('node:path');
const { UiPrefabBuilder, assets, read, componentTypeByName } = require('./ui-prefab-builder.cjs');
const b = new UiPrefabBuilder('LivestockQuickBar', 560, 112), r = b.root;
// Creator synchronizes root names with filenames. Keep the existing semantic fileIds on regeneration.
b.name = b.objects[0]._name = b.objects[r]._name = 'HerdQuickBar';
b.component(r, 'cc.BlockInputEvents');
const skin = (parent, name, key, x, y, w, h) => {
  const node = b.sprite(parent, name, `farm/bundles/golden-island-ui/images/${key}.png`, x, y, w / .45, h / .45, { sliced: true });
  Object.assign(b.objects[node]._lscale, { x: .45, y: .45 }); return node;
};
const brown = [113, 69, 40], muted = [154, 112, 76];
const text = (parent, name, value, x, y, w, h, size, tint = brown, left = false) => {
  const node = b.label(parent, name, value, x, y, w, h, size, tint, { lineHeight: size * 1.15 });
  if (left) b.getComponent(node, 'cc.Label')._horizontalAlign = 0;
  return node;
};
const frame = skin(r, 'HerdBarFrame', 'info', 0, 0, 560, 112);
const summary = text(r, 'HerdSummary', 'Chuồng gà', -57, 33, 418, 24, 16, [188, 66, 47], true);
const count = text(r, 'HerdCount', '1/1 con · 1 chờ ăn', -57, 8, 418, 18, 11, muted, true);
const unlock = text(r, 'HerdUnlock', 'Mở chuồng kèm một con', 0, 8, 532, 20, 11, muted);
b.objects[unlock]._active = false;
const feedStock = b.node(r, 'FeedStock', 218, 29, 96, 38);
skin(feedStock, 'FeedStockFace', 'material', 0, 0, 96, 38);
const manifest = read(path.join(assets, 'farm/bundles/farm-town/manifest.json'));
const feedIcon = b.sprite(feedStock, 'FeedIcon', `farm/bundles/farm-town/${manifest.images.feed_chicken.resource}.png`, -29, 0, 26, 26);
const feedQuantity = text(feedStock, 'FeedQuantity', '3', 13, 8, 52, 19, 15);
text(feedStock, 'FeedLabel', 'Cám', 13, -10, 52, 14, 10, muted);
const owned = b.node(r, 'OwnedActions', 0, 0, 560, 112), build = b.node(r, 'BuildActions', 0, 0, 560, 112);
b.objects[build]._active = false;
const buttons = [], titles = [], details = [], faces = [], activeFaces = [];
const definitions = [['herd-feed', 'Cho ăn', '1 con · 1 cám'], ['herd-collect', 'Nhận hàng', '0 con sẵn thu'], ['herd-manage', 'Quản lý', 'Mua · mở chỗ'], ['herd-build', 'Xây chuồng', '390 xu'], ['herd-manage', 'Điều kiện', 'Xem chuồng']];
for (let i = 0; i < definitions.length; i++) {
  const [id, title, detail] = definitions[i], w = i < 3 ? 172 : 262;
  const x = i < 3 ? (i - 1) * 180 : (i === 3 ? -1 : 1) * 135;
  const node = b.node(i < 3 ? owned : build, id, x, -27, w, 44);
  b.component(node, componentTypeByName('FarmButton'), { _interactable: true, _transition: 0 });
  const face = skin(node, 'ButtonFace', 'info', 0, 0, w, 44), activeFace = skin(node, 'ActiveFace', 'green', 0, 0, w, 44);
  b.objects[activeFace]._active = false;
  buttons.push(b.reference(node)); faces.push(b.reference(face, 'cc.Sprite')); activeFaces.push(b.reference(activeFace, 'cc.Sprite'));
  titles.push(b.reference(text(node, 'Title', title, 0, 8, w - 12, 19, 13), 'cc.Label'));
  details.push(b.reference(text(node, 'ActionDetail', detail, 0, -10, w - 10, 15, 10, muted), 'cc.Label'));
}
b.write(uiPrefabPath('HerdQuickBar'), componentTypeByName('HerdQuickBarView'), {
  frame: b.reference(frame, 'cc.Sprite'), summary: b.reference(summary, 'cc.Label'), count: b.reference(count, 'cc.Label'), unlock: b.reference(unlock, 'cc.Label'),
  feedStock: b.reference(feedStock), feedIcon: b.reference(feedIcon, 'cc.Sprite'), feedQuantity: b.reference(feedQuantity, 'cc.Label'),
  ownedActions: b.reference(owned), buildActions: b.reference(build), buttons, titles, details, faces, activeFaces,
});
console.log('Authored HerdQuickBar: care and unbuilt-pen states.');
