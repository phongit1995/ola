'use strict';
const { uiPrefabPath } = require('./ui-prefab-paths.cjs');
// Reset the default PlotBubble artwork explicitly. Normal builds use the editable prefab as-is.
const path = require('node:path');
const { UiPrefabBuilder, assets, read, componentTypeByName } = require('./ui-prefab-builder.cjs');
const b = new UiPrefabBuilder('PlotBubble', 324, 180), r = b.root;
b.getComponent(r, 'cc.UITransform')._anchorPoint.y = 0;
const plot = (parent, name, key, x, y, w, h) => b.sprite(parent, name, `farm/bundles/farm-plot-ui/images/${key}.png`, x, y, w, h,
  { sliced: ['bubble', 'pill', 'button'].includes(key) });
const button = node => { b.component(node, componentTypeByName('FarmButton'), { _interactable: true, _transition: 0 }); b.component(node, 'cc.BlockInputEvents'); return node; };
const price = (parent, x, y) => {
  const label = b.label(parent, 'Price', '2', x, y, 80, 48, 36, [255, 255, 255], { outline: [29, 107, 18] });
  plot(parent, 'Gem', 'gem', x + 44, y, 50, 50 * 108 / 117);
  return label;
};
const locked = b.node(r, 'Locked', 0, 0, 82, 117);
plot(locked, 'Lock', 'locked', 0, 62.5, 82, 109);
b.getComponent(price(locked, 0, 28), 'cc.Label')._string = '1';
const unlock = button(b.node(locked, 'Unlock', 0, 62.5, 82, 109));
const ready = b.node(r, 'Ready', 0, 0, 88, 106);
plot(ready, 'ReadyFrame', 'ready', 0, 57, 88, 98);
const index = read(path.join(assets, 'resources/ported/asset-index.json'));
const crop = b.sprite(ready, 'CropIcon', `resources/${index['assets/sprites/1.wheat.png']}.png`, 0, 63, 46, 46);
const amount = b.label(ready, 'Amount', 'x3', 0, 29, 60, 36, 26, [208, 87, 18]);
const harvest = button(b.node(ready, 'Harvest', 0, 57, 88, 98));
const growing = b.node(r, 'Growing', 0, 0, 324, 180);
plot(growing, 'Panel', 'bubble', 0, 63, 200, 110);
const name = b.label(growing, 'Name', 'Lúa mì', 0, 94.4, 184, 46, 36, [155, 65, 47]);
plot(growing, 'Pill', 'pill', 0, 41.6, 177.3, 43.3);
plot(growing, 'Clock', 'clock', -54, 41.6, 44, 37);
const time = b.label(growing, 'Time', '01:42', 28.9, 41.6, 120, 40, 32, [208, 87, 18]);
const finish = button(plot(growing, 'Finish', 'button', 0, 152, 176, 56));
const finishPrice = price(finish, -18, 0);
const cancel = button(b.node(growing, 'Cancel', 132, 152, 60, 60));
const shovel = read(path.join(assets, `resources/${index['data/unity/resources-186.png']}.png.meta`));
const size = shovel.subMetas.f9941.userData;
b.sprite(cancel, 'Icon', `resources/${index['data/unity/resources-186.png']}.png`, 0, 0, 60 * size.width / Math.max(size.width, size.height), 60 * size.height / Math.max(size.width, size.height));
b.objects[locked]._active = false; b.objects[ready]._active = false;
b.write(uiPrefabPath('PlotBubble'), componentTypeByName('PlotBubbleView'), {
  locked: b.reference(locked), ready: b.reference(ready), growing: b.reference(growing), unlockButton: b.reference(unlock),
  harvestButton: b.reference(harvest), finishButton: b.reference(finish), cancelButton: b.reference(cancel),
  cropIcon: b.reference(crop, 'cc.Sprite'), amount: b.reference(amount, 'cc.Label'), cropName: b.reference(name, 'cc.Label'),
  time: b.reference(time, 'cc.Label'), price: b.reference(finishPrice, 'cc.Label'),
});
console.log('Authored PlotBubble: locked, ready and growing states.');
