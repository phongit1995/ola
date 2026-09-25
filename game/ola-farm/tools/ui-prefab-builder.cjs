'use strict';
const { uiPrefabPath, uiPrefabUuid } = require('./ui-prefab-paths.cjs');
// Shared serialization primitives for authored UI modules. Run a module generator only to reset its defaults;
// normal builds read the editable .prefab files directly.
const fs = require('node:fs'), path = require('node:path');
const { stableId, componentType, componentScript, componentTypeByName } = require('./cocos-ids.cjs');
const { assertGraph } = require('./prefab-graph.cjs');
const assets = path.resolve(__dirname, '../assets/farm');
const read = file => JSON.parse(fs.readFileSync(file, 'utf8'));
const templates = read(path.join(assets, uiPrefabPath('ShopCard')));
const clone = value => JSON.parse(JSON.stringify(value));
const ref = id => ({ __id__: id });
const color = value => ({ __type__: 'cc.Color', r: value[0], g: value[1], b: value[2], a: value[3] ?? 255 });
const assetRef = (file, expectedType = 'cc.SpriteFrame') => ({
  __uuid__: read(path.join(assets, file + '.meta')).uuid + (expectedType === 'cc.SpriteFrame' ? '@f9941' : ''),
  __expectedType__: expectedType,
});

class UiPrefabBuilder {
  constructor(name, width = 1, height = 1) {
    this.name = name;
    this.objects = [{ __type__: 'cc.Prefab', _name: name, _objFlags: 0, _native: '', data: ref(1), optimizationPolicy: 0, persistent: false }];
    this.paths = new Map();
    this.root = this.node(null, name, 0, 0, width, height);
  }
  node(parent, name, x = 0, y = 0, width = 1, height = 1) {
    const id = this.objects.length, key = parent === null ? name : this.paths.get(parent) + '/' + name;
    if ([...this.paths.values()].includes(key)) throw Error('Duplicate authored node path: ' + key);
    this.paths.set(id, key);
    this.objects.push({ __type__: 'cc.Node', _name: name, _objFlags: 0, _parent: parent === null ? null : ref(parent),
      _children: [], _active: true, _components: [], _prefab: ref(id + 1),
      _lpos: { __type__: 'cc.Vec3', x, y, z: 0 }, _lscale: { __type__: 'cc.Vec3', x: 1, y: 1, z: 1 },
      _lrot: { __type__: 'cc.Quat', x: 0, y: 0, z: 0, w: 1 }, _euler: { __type__: 'cc.Vec3', x: 0, y: 0, z: 0 },
      _layer: 33554432, _id: '' });
    this.objects.push({ __type__: 'cc.PrefabInfo', root: ref(1), asset: ref(0), fileId: stableId('ui/' + key) });
    if (parent !== null) this.objects[parent]._children.push(ref(id));
    this.component(id, 'cc.UITransform', { _contentSize: { __type__: 'cc.Size', width, height }, _anchorPoint: { __type__: 'cc.Vec2', x: .5, y: .5 } });
    return id;
  }
  component(node, type, properties = {}) {
    const id = this.objects.length;
    this.objects.push({ __type__: type, _name: '', _objFlags: 0, node: ref(node), _enabled: true, __prefab: ref(id + 1), _id: '', ...clone(properties) });
    const count = this.objects[node]._components.filter(r => this.objects[r.__id__].__type__ === type).length;
    this.objects.push({ __type__: 'cc.CompPrefabInfo', fileId: stableId('ui/' + this.paths.get(node) + '/' + type + '/' + count) });
    this.objects[node]._components.push(ref(id));
    return id;
  }
  getComponent(node, type) { return this.objects[this.objects[node]._components.find(r => this.objects[r.__id__].__type__ === type).__id__]; }
  sprite(parent, name, asset, x, y, width, height, options = {}) {
    const node = this.node(parent, name, x, y, width, height);
    const properties = clone(templates.find(o => o.__type__ === 'cc.Sprite'));
    for (const key of ['__type__', 'node', '__prefab', '_id']) delete properties[key];
    properties._spriteFrame = typeof asset === 'string' ? assetRef(asset) : asset;
    properties._type = options.sliced ? 1 : 0;
    properties._color = color(options.color ?? [255, 255, 255]);
    this.component(node, 'cc.Sprite', properties);
    return node;
  }
  label(parent, name, value, x, y, width, height, fontSize = 26, tint = [157, 64, 49], options = {}) {
    const node = this.node(parent, name, x, y, width, height);
    const properties = clone(templates.find(o => o.__type__ === 'cc.Label'));
    for (const key of ['__type__', 'node', '__prefab', '_id']) delete properties[key];
    Object.assign(properties, { _string: value, _fontSize: fontSize, _actualFontSize: fontSize, _lineHeight: options.lineHeight ?? Math.ceil(fontSize * 1.15),
      _color: color(tint), _enableWrapText: options.wrap ?? true, _enableOutline: !!options.outline });
    if (options.font) properties._font = typeof options.font === 'string' ? assetRef(options.font, 'cc.TTFFont') : options.font;
    if (options.outline) { properties._outlineColor = color(options.outline); properties._outlineWidth = options.outlineWidth ?? 2; }
    this.component(node, 'cc.Label', properties);
    return node;
  }
  reference(node, type) { return ref(type ? this.objects[node]._components.find(r => this.objects[r.__id__].__type__ === type).__id__ : node); }
  finish(type, bindings = {}) { if (type) this.component(this.root, type, bindings); return this.objects; }
  write(relative, type, bindings = {}) {
    const file = path.join(assets, relative), data = this.finish(type, bindings);
    assertGraph(data, { file: relative });
    fs.mkdirSync(path.dirname(file), { recursive: true });
    fs.writeFileSync(file, JSON.stringify(data, null, 2) + '\n');
    if (!fs.existsSync(file + '.meta')) fs.writeFileSync(file + '.meta', JSON.stringify({ ver: '1.1.50', importer: 'prefab', imported: true,
      uuid: uiPrefabUuid(path.basename(relative, '.prefab')), files: ['.json'], subMetas: {}, userData: { syncNodeName: this.name } }, null, 2) + '\n');
    return data;
  }
}
module.exports = { UiPrefabBuilder, assets, ref, color, assetRef, componentType, componentScript, componentTypeByName, read, clone };
