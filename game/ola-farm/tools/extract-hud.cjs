'use strict';
const { uiPrefabPath, uiPrefabUuid } = require('./ui-prefab-paths.cjs');
// One-time migration of the scene-authored HUD to its own editable nested prefab.
// Running again only validates the existing link; it never overwrites Inspector edits.
const fs = require('node:fs'), path = require('node:path');
const { componentTypeByName } = require('./cocos-ids.cjs');
const { ref, compact, assertGraph, extractSubtree, appendNested } = require('./prefab-graph.cjs');
const assets = path.resolve(__dirname, '../assets/farm');
const file = path.join(assets, 'scenes/Farm.scene'), destination = path.join(assets, uiPrefabPath('HUD'));
const read = file => JSON.parse(fs.readFileSync(file, 'utf8'));
const write = (file, value) => fs.writeFileSync(file, JSON.stringify(value, null, 2) + '\n');
const scene = read(file), appId = scene.findIndex(o => o.__type__ === componentTypeByName('GameApp'));
if (!scene[appId].hud) {
  assertGraph(scene, { file });
  if (!fs.existsSync(destination)) throw Error('Scene has no HUD component and HUD.prefab is missing.');
  console.log('HUD is already linked; authored prefab preserved.');
  return;
}
const hudComponentId = scene[appId].hud.__id__, hudId = scene[hudComponentId].node.__id__;
const parentId = scene[hudId]._parent.__id__, ownerRootId = scene[0].scene.__id__;
const extracted = extractSubtree(scene, hudId, { name: 'HUD', namespace: 'ui/HUD' });
if (fs.existsSync(destination)) throw Error('Refusing to overwrite existing HUD.prefab.');
const uuid = uiPrefabUuid('HUD');
fs.mkdirSync(path.dirname(destination), { recursive: true });
write(destination, extracted.objects);
write(destination + '.meta', { ver: '1.1.50', importer: 'prefab', imported: true, uuid, files: ['.json'], subMetas: {}, userData: { syncNodeName: 'HUD' } });
const order = scene[parentId]._children.findIndex(r => r.__id__ === hudId);
scene[parentId]._children.splice(order, 1);
scene[appId].hud = null;
const instance = appendNested(scene, { parentId, ownerRootId, prefabUuid: uuid, sourceRootFileId: extracted.sourceRootFileId,
  instanceKey: 'Farm.scene/HUD', name: 'HUD' });
scene[parentId]._children.splice(order, 0, scene[parentId]._children.pop());
const component = extracted.objects[extracted.oldToNew.get(hudComponentId)];
const fileId = extracted.objects[component.__prefab.__id__].fileId;
const index = scene.length;
scene.push({ __type__: 'cc.TargetOverrideInfo', source: ref(appId), sourceInfo: null, propertyPath: ['hud'], target: ref(instance), targetInfo: ref(index + 1) });
scene.push({ __type__: 'cc.TargetInfo', localID: [fileId] });
(scene[scene[ownerRootId]._prefab.__id__].targetOverrides ??= []).push(ref(index));
const output = compact(scene); assertGraph(output, { file }); write(file, output);
console.log(`HUD extracted: ${extracted.objects.length} prefab records; scene now ${output.length} records.`);
