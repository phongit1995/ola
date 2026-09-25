'use strict';
const { uiPrefabPath } = require('./ui-prefab-paths.cjs');
// Explicit authoring reset only. The editable prefab, not this generator, is used by normal builds.
const { UiPrefabBuilder, componentTypeByName } = require('./ui-prefab-builder.cjs');
const b = new UiPrefabBuilder('LoadingScreen', 1280, 720);
b.component(b.root, 'cc.BlockInputEvents');
const widget = (node, flags, edge = 0) => b.component(node, 'cc.Widget', {
  _alignFlags: flags, _target: null, _left: edge, _right: edge, _top: edge, _bottom: edge,
  _horizontalCenter: 0, _verticalCenter: 0, _isAbsLeft: true, _isAbsRight: true, _isAbsTop: true, _isAbsBottom: true,
  _isAbsHorizontalCenter: true, _isAbsVerticalCenter: true, _originalWidth: 0, _originalHeight: 0, _alignMode: 2, _lockFlags: 0,
});
// Existing built-in white SpriteFrames are Editor assets, not textures created by game code.
const builtin = uuid => ({ __uuid__: uuid + '@f9941', __expectedType__: 'cc.SpriteFrame' });
const flat = builtin('7d8f9b89-4fd1-4c9f-a3ab-38ec7cded7ca');
const bar = builtin('24a704da-2867-446d-8d1a-5e920c75e09d');
widget(b.root, 45);
const backdrop = b.sprite(b.root, 'Backdrop', flat, 0, 0, 1280, 720, { sliced: true, color: [255, 249, 226] });
widget(backdrop, 45);
const landscape = b.sprite(b.root, 'Landscape', flat, 0, -324, 1280, 72, { sliced: true, color: [224, 234, 194] });
widget(landscape, 44);
const content = b.node(b.root, 'Content', 0, 0, 620, 560);
widget(content, 18);
const farm = b.sprite(content, 'FarmMark', 'resources/ported/files/684d324c0017980a5e67.png', 0, 165, 200, 212);
const font = 'fonts/hud/PoetsenOne-Regular.ttf';
const title = b.label(content, 'Title', 'Ola Farm', 0, 17, 600, 80, 62, [82, 119, 49], { font, lineHeight: 74 });
const status = b.label(content, 'Status', 'Đang chuẩn bị nông trại…', 0, -66, 600, 64, 26, [115, 92, 64], { lineHeight: 32 });
const track = b.sprite(content, 'ProgressTrack', bar, 0, -124, 432, 24, { sliced: true, color: [230, 225, 193] });
const fill = b.sprite(track, 'ProgressFill', flat, 0, 0, 424, 16, { color: [116, 157, 63] });
Object.assign(b.getComponent(fill, 'cc.Sprite'), { _type: 3, _fillType: 0, _fillStart: 0, _fillRange: .24 });
widget(fill, 45, 4);
const progressText = b.label(content, 'ProgressText', '', 0, -170, 600, 60, 22, [115, 92, 64], { lineHeight: 28 });
const bindings = {
  content: b.reference(content), backdrop: b.reference(backdrop, 'cc.Sprite'), landscape: b.reference(landscape, 'cc.Sprite'),
  farmMark: b.reference(farm, 'cc.Sprite'), title: b.reference(title, 'cc.Label'), status: b.reference(status, 'cc.Label'),
  progressText: b.reference(progressText, 'cc.Label'), progressTrack: b.reference(track, 'cc.Sprite'), progressFill: b.reference(fill, 'cc.Sprite'),
};
const data = b.write(uiPrefabPath('LoadingScreen'), componentTypeByName('LoadingScreenView'), bindings);
console.log(`Authored LoadingScreen: ${data.length} native Sprite/Label/Widget records; no runtime artwork generation.`);
