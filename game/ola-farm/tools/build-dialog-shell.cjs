'use strict';
const { uiPrefabPath } = require('./ui-prefab-paths.cjs');
// Explicit authoring reset, never part of normal builds. Inspector edits remain the source of truth.
const path = require('node:path');
const { UiPrefabBuilder, assets, assetRef, color, componentTypeByName, read } = require('./ui-prefab-builder.cjs');
const { assertGraph } = require('./prefab-graph.cjs');
const b = new UiPrefabBuilder('DialogShell', 1920, 1080);
b.component(b.root, 'cc.BlockInputEvents');
b.component(b.root, 'cc.Graphics', { _lineWidth: 1, _strokeColor: color([20, 24, 18, 150]), _fillColor: color([20, 24, 18, 150]), _lineJoin: 0, _lineCap: 0, _miterLimit: 10 });
const skin = key => 'farm/bundles/golden-island-ui/images/' + key + '.png';
const card = b.sprite(b.root, 'GoldenIslandDialog', skin('window'), 0, 0, 1000, 900, { sliced: true });
const factory = b.sprite(card, 'FactoryFrame', skin('buildingWindow'), 0, 0, 1000, 900, { sliced: true });
const livestock = b.sprite(card, 'LivestockFrame', skin('buildingWindow'), 0, 0, 1000, 900, { sliced: true });
b.objects[factory]._active = false; b.objects[livestock]._active = false;
const inset = b.sprite(card, 'DialogBody', skin('inset'), 0, -30, 966, 790, { sliced: true });
const index = read(path.join(assets, 'resources/ported/asset-index.json'));
const fontResource = Object.entries(index).find(([source]) => source.endsWith('.ttf'))[1];
const title = b.label(card, 'Title', 'Nông trại', 0, 402, 780, 62, 36, [188, 66, 47], { lineHeight: 43, font: assetRef('resources/' + fontResource + '.ttf', 'cc.TTFFont') });
const body = b.node(card, 'Body', 0, 0, 1000, 900);
b.label(body, 'EditorPreview', 'Chọn một hoạt động trong nông trại', 0, 0, 740, 60, 28, [113, 69, 40]);
const close = b.node(card, 'close-panel', 464, 402, 88, 88);
const buttonType = componentTypeByName('FarmButton');
const button = read(path.join(assets, uiPrefabPath('ShopCard'))).find(o => o.__type__ === buttonType);
const buttonData = { ...button }; for (const key of ['__type__', 'node', '__prefab', '_id']) delete buttonData[key];
buttonData._target = null; buttonData.clickEvents = []; b.component(close, buttonType, buttonData);
const icon = b.sprite(close, 'close', skin('close'), 0, 0, 70, 67);
const bindings = { card: b.reference(card), body: b.reference(body), window: b.reference(card, 'cc.Sprite'),
  factoryFrame: b.reference(factory, 'cc.Sprite'), livestockFrame: b.reference(livestock, 'cc.Sprite'),
  inset: b.reference(inset), title: b.reference(title, 'cc.Label'), closeButton: b.reference(close), closeIcon: b.reference(icon),
  buildingTitleFont: assetRef('fonts/hud/PoetsenOne-Regular.ttf', 'cc.TTFFont'), marginX: 56, marginY: 64, buildingMaxWidth: 1080, buildingMaxHeight: 1000 };
const data = b.write(uiPrefabPath('DialogShell'), componentTypeByName('DialogShellView'), bindings);
assertGraph(data, { file: 'DialogShell.prefab' });
console.log('Authored DialogShell: ' + data.length + ' records; linked frame, inset, title, close and body.');
