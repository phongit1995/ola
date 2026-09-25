'use strict';
// Links the map components into the Farm prefabs so the runtime reads serialized references instead of
// searching nodes by name: FarmMapLayout and FacilityTrigger on scenes.prefab, CropPlotView on CropPlot.prefab,
// ItemParts on every pen, pond slot and animal. Idempotent: existing components are updated in place.
// Usage: node tools/link-prefab-components.cjs [--check]
const fs = require('node:fs');
const path = require('node:path');
const { mapComponentTypes, stableId } = require('./cocos-ids.cjs');

const root = path.resolve(__dirname, '..');
const prefabs = path.join(root, 'assets/farm/prefabs');
const check = process.argv.includes('--check');
const types = mapComponentTypes();
const FACILITIES = [['MainObject-kho', 'barn', 'inventory'], ['MainObject-nha', 'farm-house', 'pause']];
const FIELD_NAMES = Array.from({ length: 40 }, (_, i) => 'R' + String(i + 1).padStart(3, '0'));
const LIVESTOCK_NAMES = Array.from({ length: 10 }, (_, i) => 'Cell' + (i + 12));

const read = file => JSON.parse(fs.readFileSync(file, 'utf8'));
const serialize = data => JSON.stringify(data, null, 2) + '\n';
let changed = 0;
function save(file, data) {
  const next = serialize(data);
  if (fs.readFileSync(file, 'utf8').replace(/\r\n/g, '\n') === next) return;
  changed++;
  if (check) console.error('Chưa liên kết: ' + path.relative(root, file));
  else fs.writeFileSync(file, next);
}

const childId = (prefab, node, name) => {
  const id = node._children.map(r => r.__id__).find(id => prefab[id]._name === name);
  if (id === undefined) throw Error(`Prefab thiếu node ${name}`);
  return id;
};

/** Find or append a component of `type` on the node; new ones get a stable CompPrefabInfo. */
function ensureComponent(prefab, nodeId, type, key) {
  const node = prefab[nodeId];
  let id = node._components.map(r => r.__id__).find(id => prefab[id].__type__ === type);
  if (id === undefined) {
    id = prefab.length;
    prefab.push({ __type__: type, _name: '', _objFlags: 0, node: { __id__: nodeId }, _enabled: true, __prefab: { __id__: id + 1 }, _id: '' });
    prefab.push({ __type__: 'cc.CompPrefabInfo', fileId: stableId(key) });
    node._components.push({ __id__: id });
  }
  return prefab[id];
}

/** Remove obsolete editor cages while retaining every cell anchor and its save-compatible geometry. */
function removeLivestockPreviews(prefab, rootId, anchors) {
  const removed = new Set();
  const removeTree = id => { removed.add(id); for (const child of prefab[id]._children ?? []) removeTree(child.__id__); };
  for (const ref of anchors) {
    const anchor = prefab[ref.__id__];
    anchor._children = anchor._children.filter(child => {
      if (!/^(?:Pen|PondSlot)\d+$/.test(prefab[child.__id__]._name)) return true;
      removeTree(child.__id__); return false;
    });
  }
  const info = prefab[prefab[rootId]._prefab.__id__];
  info.nestedPrefabInstanceRoots = info.nestedPrefabInstanceRoots.filter(ref => !removed.has(ref.__id__));
}

/** Drop the removed nested prefab records and remap all serialized references deterministically. */
function compact(prefab) {
  const reachable = new Set(), pending = [0];
  const scan = value => {
    if (!value || typeof value !== 'object') return;
    if (Number.isInteger(value.__id__)) pending.push(value.__id__);
    for (const [key, child] of Object.entries(value)) if (key !== '__id__') scan(child);
  };
  while (pending.length) {
    const id = pending.pop(); if (reachable.has(id)) continue;
    if (!prefab[id]) throw Error('Dangling prefab reference: ' + id);
    reachable.add(id); scan(prefab[id]);
  }
  const order = [...reachable].sort((a, b) => a - b), ids = new Map(order.map((id, i) => [id, i]));
  const remap = value => {
    if (!value || typeof value !== 'object') return;
    if (Number.isInteger(value.__id__)) value.__id__ = ids.get(value.__id__);
    for (const [key, child] of Object.entries(value)) if (key !== '__id__') remap(child);
  };
  const output = order.map(id => prefab[id]); output.forEach(remap); return output;
}

function linkMap() {
  const file = path.join(prefabs, 'map/scenes.prefab'), map = read(file), rootId = map[0].data.__id__, mapRoot = map[rootId];
  const groups = Object.fromEntries(['Fields', 'Livestock', 'Buildings', 'Scenery', 'Grass', 'Decor', 'GroundDecor'].map(name => [name, childId(map, mapRoot, name)]));
  const layout = ensureComponent(map, rootId, types.FarmMapLayout, 'FarmMapLayout');
  layout.fields = FIELD_NAMES.map(name => ({ __id__: childId(map, map[groups.Fields], name) }));
  layout.livestock = LIVESTOCK_NAMES.map(name => ({ __id__: childId(map, map[groups.Livestock], name) }));
  layout.additionalPens = [50, 51, 52, 53].map(id => ({ __id__: childId(map, map[groups.Livestock], 'Cell' + id) }));
  removeLivestockPreviews(map, rootId, layout.livestock);
  layout.buildings = { __id__: groups.Buildings }; layout.scenery = { __id__: groups.Scenery }; layout.grass = { __id__: groups.Grass };
  layout.decor = { __id__: groups.Decor }; layout.groundDecor = { __id__: groups.GroundDecor };
  const regionDir = path.join(prefabs, 'map');
  const regionUuids = new Set(fs.existsSync(regionDir) ? fs.readdirSync(regionDir).filter(name => /^(Border|Forest).*\.prefab\.meta$/.test(name)).map(name => read(path.join(regionDir, name)).uuid) : []);
  layout.decorRegions = map[groups.Decor]._children.filter(ref => regionUuids.has(map[map[ref.__id__]._prefab.__id__].asset?.__uuid__));
  for (const [name, id, view] of FACILITIES) {
    const trigger = ensureComponent(map, childId(map, map[groups.Scenery], name), types.FacilityTrigger, 'FacilityTrigger/' + id);
    Object.assign(trigger, { id, view, hitWidth: 200, hitHeight: 170, offsetY: 45 });
  }
  save(file, compact(map));
}

function linkCropPlot() {
  const file = path.join(prefabs, 'map/CropPlot.prefab'), prefab = read(file), rootId = prefab[0].data.__id__, node = prefab[rootId];
  const view = ensureComponent(prefab, rootId, types.CropPlotView, 'CropPlotView');
  view.soil = { __id__: childId(prefab, node, 'Soil') }; view.plant = { __id__: childId(prefab, node, 'Plant') };
  save(file, prefab);
}

function linkParts() {
  const files = ['plots', 'animals'].flatMap(dir => fs.readdirSync(path.join(prefabs, 'items', dir)).filter(n => n.endsWith('.prefab')).map(n => path.join(prefabs, 'items', dir, n)));
  for (const file of files) {
    const prefab = read(file), rootId = prefab[0].data.__id__, node = prefab[rootId];
    const parts = node._children.map(r => r.__id__).filter(id => /^Part\d+$/.test(prefab[id]._name)).sort((a, b) => Number(prefab[a]._name.slice(4)) - Number(prefab[b]._name.slice(4)));
    if (!parts.length) continue;
    parts.forEach((id, index) => { if (prefab[id]._name !== 'Part' + index) throw Error(`${path.basename(file)}: PartN phải liên tục từ Part0`); });
    ensureComponent(prefab, rootId, types.ItemParts, 'ItemParts').parts = parts.map(id => ({ __id__: id }));
    save(file, prefab);
  }
}

linkMap(); linkCropPlot(); linkParts();
if (check && changed) process.exit(1);
console.log(changed ? `Đã cập nhật ${changed} prefab.` : 'Mọi prefab đã liên kết đủ component.');
