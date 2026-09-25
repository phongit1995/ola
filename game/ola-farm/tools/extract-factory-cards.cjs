'use strict';
const { uiPrefabPath, uiPrefabUuid } = require('./ui-prefab-paths.cjs');
// One-time extraction from the authored FactoryBody. Re-running preserves Editor edits.
const fs = require('node:fs'), path = require('node:path');
const { componentTypeByName, stableId } = require('./cocos-ids.cjs');
const { ref, clone, compact, assertGraph, extractSubtree, appendNested } = require('./prefab-graph.cjs');
const assets = path.resolve(__dirname, '../assets/farm'), file = path.join(assets, uiPrefabPath('FactoryBody'));
const read = file => JSON.parse(fs.readFileSync(file, 'utf8'));
const write = (file, value) => fs.writeFileSync(file, JSON.stringify(value, null, 2) + '\n');
const objects = read(file), owner = objects[0].data.__id__;
const view = objects.find(o => o.__type__ === componentTypeByName('FactoryBodyView'));
if (view.recipeChoicePrefab && view.ingredientItemPrefab) {
  assertGraph(objects, { file });
  for (const [property, name] of [['recipeChoicePrefab', 'RecipeChoice'], ['ingredientItemPrefab', 'IngredientItem']]) {
    const target = path.join(assets, uiPrefabPath(name));
    if (view[property].__uuid__ !== read(target + '.meta').uuid) throw Error('Factory card link does not match ' + name);
    assertGraph(read(target), { file: target });
  }
  console.log('Factory cards already extracted; authored prefabs preserved.');
  return;
}
const baselineKeys = ['referenceRects', 'referenceScales', 'referenceFonts', 'referenceColors', 'referenceFrames'];
const removed = new Set(), outputs = [];
function subtree(id) { removed.add(id); for (const r of objects[id]._children ?? []) subtree(r.__id__); }
function component(data, nodeId, type) { return data[nodeId]._components.find(r => data[r.__id__].__type__ === type); }
function addComponent(data, nodeId, type, fields, key) {
  const id = data.length;
  data.push({ __type__: type, _name: '', _objFlags: 0, node: ref(nodeId), _enabled: true, __prefab: ref(id + 1), _id: '', ...fields });
  data.push({ __type__: 'cc.CompPrefabInfo', fileId: stableId('ui/' + key) });
  data[nodeId]._components.push(ref(id));
}
for (const [list, name, property, previews] of [
  ['choices', 'RecipeChoice', 'recipeChoicePrefab', 'choicePreviews'],
  ['ingredients', 'IngredientItem', 'ingredientItemPrefab', 'ingredientPreviews'],
]) {
  const destination = path.join(assets, uiPrefabPath(name));
  if (fs.existsSync(destination) || fs.existsSync(destination + '.meta')) throw Error('Refusing to overwrite ' + destination);
  const sourceIds = view[list].map(r => r.__id__), first = sourceIds[0];
  const extracted = extractSubtree(objects, first, { name, namespace: 'ui/' + name });
  const data = extracted.objects, rootId = data[0].data.__id__, root = data[rootId];
  const indices = view.layoutNodes.flatMap((r, i) => extracted.oldToNew.has(r.__id__) ? [i] : []);
  const fields = { layoutNodes: indices.map(i => ref(extracted.oldToNew.get(view.layoutNodes[i].__id__))) };
  for (const key of baselineKeys) fields[key] = indices.map(i => clone(view[key][i]));
  const rootIndex = indices.indexOf(view.layoutNodes.findIndex(r => r.__id__ === first));
  // Runtime rows start at the origin; keep any deliberate Inspector offset from the old baseline.
  root._lpos.x -= fields.referenceRects[rootIndex].x; root._lpos.y -= fields.referenceRects[rootIndex].y;
  fields.referenceRects[rootIndex].x = fields.referenceRects[rootIndex].y = 0;
  root._active = true;
  const child = nodeName => root._children.find(r => data[r.__id__]._name === nodeName).__id__;
  const link = (nodeName, type) => type ? component(data, child(nodeName), type) : ref(child(nodeName));
  if (name === 'RecipeChoice') {
    Object.assign(fields, { face: link('RecipeTile'), selected: link('SelectedRecipe'), product: link('Product', 'cc.Sprite'), recipeName: link('RecipeName', 'cc.Label') });
    addComponent(data, rootId, componentTypeByName('FarmButton'),
      { clickEvents: [], _interactable: true, _transition: 0, _target: ref(rootId) }, name + '/Button');
  } else Object.assign(fields, { product: link('Product', 'cc.Sprite'), itemName: link('IngredientName', 'cc.Label'), stock: link('IngredientStock', 'cc.Label') });
  addComponent(data, rootId, componentTypeByName(name + 'View'), fields, name + '/View');
  assertGraph(data, { file: destination });
  const uuid = uiPrefabUuid(name);
  outputs.push([destination, data], [destination + '.meta', { ver: '1.1.50', importer: 'prefab', imported: true, uuid, files: ['.json'], subMetas: {}, userData: { syncNodeName: name } }]);
  view[property] = { __uuid__: uuid, __expectedType__: 'cc.Prefab' }; view[previews] = [];
  for (const id of sourceIds) {
    const source = objects[id], parentId = source._parent.__id__, parent = objects[parentId];
    const order = parent._children.findIndex(r => r.__id__ === id); parent._children.splice(order, 1);
    const nested = appendNested(objects, { parentId, ownerRootId: owner, prefabUuid: uuid, sourceRootFileId: extracted.sourceRootFileId,
      instanceKey: 'FactoryBody/' + source._name, name: source._name, position: source._lpos, scale: source._lscale });
    parent._children.splice(order, 0, parent._children.pop()); view[previews].push(ref(nested));
    const instance = objects[objects[nested]._prefab.__id__].instance.__id__;
    function override(fileId, property, value) {
      const index = objects.length; objects[instance].propertyOverrides.push(ref(index));
      objects.push({ __type__: 'CCPropertyOverrideInfo', targetInfo: ref(index + 1), propertyPath: [property], value });
      objects.push({ __type__: 'cc.TargetInfo', localID: [fileId] });
    }
    if (!source._active) override(extracted.sourceRootFileId, '_active', false);
    if (name === 'RecipeChoice') {
      const oldSelected = objects[source._children.find(r => objects[r.__id__]._name === 'SelectedRecipe').__id__];
      override(data[data[child('SelectedRecipe')]._prefab.__id__].fileId, '_active', oldSelected._active);
    }
    subtree(id);
  }
  delete view[list];
}
const keep = view.layoutNodes.flatMap((r, i) => removed.has(r.__id__) ? [] : [i]);
for (const key of ['layoutNodes', ...baselineKeys]) view[key] = keep.map(i => view[key][i]);
const packed = compact(objects); assertGraph(packed, { file });
for (const [target, data] of outputs) write(target, data);
write(file, packed);
console.log('Extracted RecipeChoice and IngredientItem, with linked Editor samples and independent responsive baselines.');
