'use strict';
const { uiPrefabPath } = require('./ui-prefab-paths.cjs');
// Author the original UI as an independent frame. Only --reset overwrites Inspector edits.
const fs = require('node:fs'), path = require('node:path');
const { UiPrefabBuilder, assets, assetRef, componentTypeByName, read } = require('./ui-prefab-builder.cjs');
const { assertGraph, ref } = require('./prefab-graph.cjs');
const destination = path.join(assets, uiPrefabPath('FactoryDialogFrame'));
if (!fs.existsSync(destination) || process.argv.includes('--reset')) {
  const b = new UiPrefabBuilder('FactoryDialogFrame', 560, 450);
  const widget = (node, flags, offsets = {}) => b.component(node, 'cc.Widget', {
    _alignFlags: flags, _target: null, _left: 0, _right: 0, _top: 0, _bottom: 0,
    _horizontalCenter: 0, _verticalCenter: 0, _isAbsLeft: true, _isAbsRight: true,
    _isAbsTop: true, _isAbsBottom: true, _isAbsHorizontalCenter: true, _isAbsVerticalCenter: true,
    _originalWidth: 0, _originalHeight: 0, _alignMode: 2, _lockFlags: 0, ...offsets,
  });
  const skin = key => 'farm/bundles/golden-island-ui/images/' + key + '.png';
  const artScale = .42, titleTop = 17.2347, titleHeight = 26.775;
  const background = b.sprite(b.root, 'Background', skin('buildingWindow'), 0, 0, 560 / artScale, 450 / artScale, { sliced: true });
  b.objects[background]._lscale.x = b.objects[background]._lscale.y = artScale;
  widget(background, 45);
  const title = b.label(b.root, 'Title', 'Lò bánh 1', 0, 225 - titleTop, 376, titleHeight, 20.16, [188, 66, 47], {
    lineHeight: 22.176, font: assetRef('fonts/hud/PoetsenOne-Regular.ttf', 'cc.TTFFont'), wrap: false,
  });
  widget(title, 41, { _left: 92, _right: 92, _top: titleTop - titleHeight / 2 });
  const close = b.node(b.root, 'close-panel', 258, 185, 44, 44);
  // Center X on the original title/body junction; its hit box clears collection below.
  widget(close, 33, { _top: 18, _right: 0 });
  b.component(close, componentTypeByName('FarmButton'), {
    clickEvents: [], _interactable: true, _transition: 0, _target: ref(close),
  });
  const closeFace = b.sprite(close, 'CloseFace', skin('close'), 0, 0, 38.64, 36.96);
  const fields = { background: b.reference(background, 'cc.Sprite'), title: b.reference(title, 'cc.Label'),
    closeButton: b.reference(close), closeFace: b.reference(closeFace, 'cc.Sprite') };
  b.write(uiPrefabPath('FactoryDialogFrame'), componentTypeByName('FactoryDialogFrameView'), fields);
}

const file = path.join(assets, uiPrefabPath('DialogShell')), objects = read(file);
const shell = objects.find(o => o.__type__ === componentTypeByName('DialogShellView'));
if (!shell.factoryDialogPrefab) {
  // Instantiate from the source asset once per dialog, then reuse it on content refresh.
  shell.factoryDialogPrefab = { __uuid__: read(destination + '.meta').uuid, __expectedType__: 'cc.Prefab' };
  assertGraph(objects, { file });
  fs.writeFileSync(file, JSON.stringify(objects, null, 2) + '\n');
}
assertGraph(read(destination), { file: destination });
assertGraph(read(file), { file });
console.log('FactoryDialogFrame: original artwork, authored Widgets and linked DialogShell source ready.');
