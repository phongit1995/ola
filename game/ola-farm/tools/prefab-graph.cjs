'use strict';
// Creator 3.8 serialized object graphs. These helpers preserve asset identity and
// reject unresolved cross-subtree links instead of silently producing null links.
const assert = require('node:assert/strict');
const { stableId } = require('./cocos-ids.cjs');
const ref = __id__ => ({ __id__ });
const clone = value => JSON.parse(JSON.stringify(value));
const hasId = value => value && typeof value === 'object' && Object.hasOwn(value, '__id__');
const metadataTypes = new Set(['cc.PrefabInfo', 'cc.CompPrefabInfo', 'cc.PrefabInstance', 'cc.TargetInfo', 'cc.TargetOverrideInfo', 'CCPropertyOverrideInfo', 'cc.MountedChildrenInfo', 'cc.MountedComponentsInfo']);

function walk(value, visit, path = []) {
  if (!value || typeof value !== 'object') return;
  visit(value, path);
  for (const [key, child] of Object.entries(value)) walk(child, visit, [...path, key]);
}

/** The owner is outside the instance; a scene is not itself a containing prefab. */
function containingPrefabRoot(objects, nodeId, rootId, prefabAsset = objects[0].__type__ === 'cc.Prefab') {
  let parentId = objects[nodeId]._parent?.__id__;
  const visited = new Set();
  while (parentId !== undefined) {
    assert.ok(!visited.has(parentId), 'Prefab parent chain has a cycle'); visited.add(parentId);
    if (parentId === rootId) return prefabAsset ? rootId : null;
    const parent = objects[parentId]; assert.ok(parent, 'Invalid prefab parent');
    const info = objects[parent._prefab?.__id__];
    if (info?.instance && info.root?.__id__ === parentId) return parentId;
    parentId = parent._parent?.__id__;
  }
  return null;
}

/** Remove unreachable records and update only local references, never UUIDs/fileIds. */
function compact(input) {
  const objects = clone(input), reachable = new Set(), pending = [0];
  while (pending.length) {
    const id = pending.pop(); if (reachable.has(id)) continue;
    assert.ok(Number.isInteger(id) && id >= 0 && objects[id], 'Dangling serialized reference: ' + id);
    reachable.add(id);
    walk(objects[id], value => { if (hasId(value)) pending.push(value.__id__); });
  }
  const order = [...reachable].sort((a, b) => a - b), ids = new Map(order.map((id, index) => [id, index]));
  const output = order.map(id => objects[id]);
  walk(output, value => { if (hasId(value)) value.__id__ = ids.get(value.__id__); });
  return output;
}

/** Validate local ownership plus optional external asset UUID/type resolution. */
function assertGraph(objects, { file = 'prefab', assetIndex } = {}) {
  const fail = message => file + ': ' + message;
  assert.ok(Array.isArray(objects) && objects.length, fail('empty graph'));
  const get = (link, type) => {
    assert.ok(hasId(link) && Number.isInteger(link.__id__) && link.__id__ >= 0 && objects[link.__id__], fail('invalid __id__'));
    const result = objects[link.__id__];
    if (type) assert.equal(result.__type__, type, fail('expected ' + type));
    return result;
  };
  walk(objects, value => {
    if (hasId(value)) get(value);
    if (value.__uuid__ && assetIndex) {
      const asset = assetIndex.get(value.__uuid__);
      assert.ok(asset, fail('missing external asset ' + value.__uuid__));
      if (value.__expectedType__ && asset.type) assert.equal(asset.type, value.__expectedType__, fail('wrong asset type ' + value.__uuid__));
    }
  });
  const asset = objects[0], root = get(asset.data ?? asset.scene), rootId = (asset.data ?? asset.scene).__id__;
  assert.ok(['cc.Prefab', 'cc.SceneAsset'].includes(asset.__type__), fail('expected prefab or scene asset'));
  assert.ok(['cc.Node', 'cc.Scene'].includes(root.__type__), fail('invalid root'));
  assert.equal(root._parent ?? null, null, fail('root has a parent'));
  const nodes = new Set(), visit = node => {
    assert.ok(!nodes.has(node), fail('duplicate child or cycle'));
    nodes.add(node);
    for (const link of node._children ?? []) {
      const child = get(link, 'cc.Node'); assert.equal(get(child._parent), node, fail('parent/child mismatch')); visit(child);
    }
    for (const link of node._components ?? []) {
      const component = get(link); assert.equal(get(component.node), node, fail('component owner mismatch'));
    }
  };
  visit(root);
  const registered = new Set((objects[root._prefab?.__id__]?.nestedPrefabInstanceRoots ?? []).map(link => get(link)));
  for (const node of nodes) {
    if (node === root || !objects[node._prefab?.__id__]?.asset?.__uuid__) continue;
    let parent = get(node._parent), nestedAncestor = false;
    while (parent !== root) {
      if (objects[parent._prefab?.__id__]?.asset?.__uuid__) { nestedAncestor = true; break; }
      parent = get(parent._parent);
    }
    if (!nestedAncestor) assert.ok(registered.has(node), fail('unregistered nested prefab root'));
  }
  const instanceOwners = new Map();
  for (const object of objects) {
    if (object.__type__ !== 'cc.PrefabInfo' || !object.instance) continue;
    const nestedRoot = get(object.root, 'cc.Node'), instance = get(object.instance, 'cc.PrefabInstance');
    assert.equal(get(nestedRoot._prefab), object, fail('instance root prefab info mismatch'));
    instanceOwners.set(nestedRoot, instance.prefabRootNode ? get(instance.prefabRootNode, 'cc.Node') : null);
  }
  for (const nestedRoot of instanceOwners.keys()) {
    const visited = new Set();
    for (let node = nestedRoot; node && instanceOwners.has(node); node = instanceOwners.get(node)) {
      assert.ok(!visited.has(node), fail('prefab instance ownership cycle'));
      visited.add(node);
    }
  }
  const ownedIds = new Set();
  for (const object of objects) {
    if (['cc.Node', 'cc.Scene'].includes(object.__type__)) assert.ok(nodes.has(object), fail('unreachable node'));
    if (object.node && !['cc.Node', 'cc.Scene'].includes(object.__type__)) {
      const owner = get(object.node, 'cc.Node');
      assert.ok(owner._components?.some(link => get(link) === object), fail('unattached component'));
      if (object.__prefab) get(object.__prefab, 'cc.CompPrefabInfo');
    }
    if (object.__type__ === 'cc.PrefabInfo') {
      get(object.root);
      if (object.instance) {
        const instance = get(object.instance, 'cc.PrefabInstance');
        // Creator's asset-db testPrefab-3-3-0 fixtures use the containing prefab
        // root in .prefab, and no owner for outermost instances in .scene.
        const ownerId = containingPrefabRoot(objects, object.root.__id__, rootId);
        assert.equal(instance.prefabRootNode?.__id__ ?? null, ownerId, fail('nested root mismatch'));
        assert.ok(object.asset?.__uuid__, fail('nested instance lacks source prefab'));
      }
      const listed = new Set();
      for (const link of object.nestedPrefabInstanceRoots ?? []) {
        const nested = get(link, 'cc.Node'); assert.ok(!listed.has(nested), fail('duplicate nested root')); listed.add(nested);
        const info = get(nested._prefab, 'cc.PrefabInfo'); assert.ok(info.asset?.__uuid__ && info.instance, fail('nested root lacks linked asset/instance'));
      }
    }
    // Source root fileIds intentionally repeat in separate linked instances.
    if (['cc.CompPrefabInfo', 'cc.PrefabInstance'].includes(object.__type__) || (object.__type__ === 'cc.PrefabInfo' && !object.asset?.__uuid__)) {
      assert.ok(object.fileId && !ownedIds.has(object.fileId), fail('missing/duplicate local fileId ' + object.fileId)); ownedIds.add(object.fileId);
    }
    if (object.__type__ === 'CCPropertyOverrideInfo') {
      const target = get(object.targetInfo, 'cc.TargetInfo'); assert.ok(target.localID.length && object.propertyPath?.length, fail('invalid property override'));
    }
    if (object.__type__ === 'cc.TargetOverrideInfo') {
      get(object.source); get(object.target, 'cc.Node'); get(object.targetInfo, 'cc.TargetInfo');
      assert.ok(object.propertyPath?.length, fail('invalid target override'));
    }
  }
  return objects;
}

/** Extract owned nodes/components/metadata; preserve internal links and report the old-to-new IDs. */
function extractSubtree(input, nodeId, { name, namespace = name } = {}) {
  const source = clone(input), selected = new Set(), paths = new Map();
  assert.ok(!source[source[nodeId]?._prefab?.__id__]?.asset?.__uuid__, 'Expand a linked instance before extracting its source subtree');
  function collect(id, path) {
    const node = source[id]; assert.equal(node?.__type__, 'cc.Node', 'Extraction root/child must be a Node');
    assert.ok(!selected.has(id), 'Repeated subtree node'); selected.add(id); paths.set(id, path);
    for (const [index, link] of (node._components ?? []).entries()) { selected.add(link.__id__); paths.set(link.__id__, path + '/component/' + source[link.__id__].__type__ + '/' + index); }
    const occurrences = new Map();
    for (const link of node._children ?? []) {
      const childName = source[link.__id__]._name, ordinal = occurrences.get(childName) ?? 0; occurrences.set(childName, ordinal + 1);
      collect(link.__id__, path + '/' + childName + (ordinal ? '#' + ordinal : ''));
    }
  }
  collect(nodeId, name ?? source[nodeId]._name);
  const pending = [...selected];
  while (pending.length) {
    const id = pending.pop(), object = source[id];
    if (object.__type__ === 'cc.PrefabInfo' && !object.asset?.__uuid__) {
      object.root = ref(nodeId); object.asset = ref(0);
      object.nestedPrefabInstanceRoots = (object.nestedPrefabInstanceRoots ?? []).filter(link => selected.has(link.__id__));
    }
    walk(object, value => {
      if (!hasId(value) || selected.has(value.__id__) || !metadataTypes.has(source[value.__id__]?.__type__)) return;
      selected.add(value.__id__); pending.push(value.__id__);
    });
  }
  source[nodeId]._parent = null;
  // An extracted instance used to belong to a prefab outside this subtree. Move
  // that ownership to the new asset root, retaining any nearer nested owner.
  for (const id of selected) {
    const object = source[id];
    if (object.__type__ !== 'cc.PrefabInfo' || !object.instance) continue;
    const ownerId = containingPrefabRoot(source, object.root.__id__, nodeId, true);
    source[object.instance.__id__].prefabRootNode = ownerId === null ? null : ref(ownerId);
  }
  const order = [...selected].sort((a, b) => a - b), oldToNew = new Map([[0, 0], ...order.map((id, index) => [id, index + 1])]);
  const objects = [{ __type__: 'cc.Prefab', _name: name ?? source[nodeId]._name, _objFlags: 0, __editorExtras__: {}, _native: '', data: ref(oldToNew.get(nodeId)), optimizationPolicy: 0, persistent: false, asyncLoadAssets: false }, ...order.map(id => source[id])];
  for (const object of objects.slice(1)) walk(object, (value, path) => {
    if (!hasId(value)) return;
    assert.ok(oldToNew.has(value.__id__), 'Unresolved cross-subtree reference: ' + path.join('.') + ' -> ' + value.__id__);
    value.__id__ = oldToNew.get(value.__id__);
  });
  const rootId = oldToNew.get(nodeId), root = objects[rootId]; root._name = name ?? root._name;
  for (const oldId of order) {
    const object = objects[oldToNew.get(oldId)];
    if (object.__type__ === 'cc.Node' && !object._prefab) {
      object._prefab = ref(objects.length);
      objects.push({ __type__: 'cc.PrefabInfo', root: ref(rootId), asset: ref(0), fileId: stableId(namespace + '/node/' + (object._id || paths.get(oldId))) });
    } else if (object.node && !metadataTypes.has(object.__type__) && !object.__prefab) {
      object.__prefab = ref(objects.length);
      objects.push({ __type__: 'cc.CompPrefabInfo', fileId: stableId(namespace + '/component/' + (object._id || paths.get(oldId))) });
    }
  }
  const info = objects[root._prefab.__id__];
  info.nestedPrefabInstanceRoots = objects.flatMap((object, id) => object.__type__ === 'cc.Node' && objects[object._prefab?.__id__]?.asset?.__uuid__ ? [ref(id)] : []);
  assertGraph(objects);
  return { objects, oldToNew, sourceRootFileId: info.fileId };
}

/** Add a real compact nested instance and register it with the containing prefab/scene root. */
function appendNested(objects, { parentId, ownerRootId, prefabUuid, sourceRootFileId, instanceKey, name, position, scale }) {
  const id = objects.length, parent = objects[parentId], owner = objects[ownerRootId];
  assert.equal(parent?.__type__, 'cc.Node'); assert.ok(owner && prefabUuid && sourceRootFileId && instanceKey);
  objects.push({ __type__: 'cc.Node', _name: name ?? '', _objFlags: 0, _parent: ref(parentId), _children: [], _active: true, _components: [], _prefab: ref(id + 1), _lpos: { __type__: 'cc.Vec3', x: 0, y: 0, z: 0 }, _lrot: { __type__: 'cc.Quat', x: 0, y: 0, z: 0, w: 1 }, _lscale: { __type__: 'cc.Vec3', x: 1, y: 1, z: 1 }, _layer: 33554432, _euler: { __type__: 'cc.Vec3', x: 0, y: 0, z: 0 }, _id: '' });
  objects.push({ __type__: 'cc.PrefabInfo', root: ref(id), asset: { __uuid__: prefabUuid, __expectedType__: 'cc.Prefab' }, fileId: sourceRootFileId, instance: ref(id + 2) });
  const containingRootId = containingPrefabRoot(objects, id, (objects[0].data ?? objects[0].scene).__id__);
  const instance = { __type__: 'cc.PrefabInstance', fileId: stableId(instanceKey), prefabRootNode: containingRootId === null ? null : ref(containingRootId), mountedChildren: [], mountedComponents: [], propertyOverrides: [], removedComponents: [] }; objects.push(instance);
  for (const [property, value] of [['_name', name], ['_lpos', position && { __type__: 'cc.Vec3', x: position.x, y: position.y, z: position.z ?? 0 }], ['_lscale', scale && { __type__: 'cc.Vec3', x: scale.x, y: scale.y, z: scale.z ?? 1 }]]) {
    if (value === undefined) continue;
    const index = objects.length; instance.propertyOverrides.push(ref(index));
    objects.push({ __type__: 'CCPropertyOverrideInfo', targetInfo: ref(index + 1), propertyPath: [property], value });
    objects.push({ __type__: 'cc.TargetInfo', localID: [sourceRootFileId] });
  }
  parent._children.push(ref(id));
  if (!owner._prefab) {
    owner._prefab = ref(objects.length);
    objects.push({ __type__: 'cc.PrefabInfo', root: ref(ownerRootId), asset: objects[0].__type__ === 'cc.Prefab' ? ref(0) : null, fileId: stableId(instanceKey + '/owner'), nestedPrefabInstanceRoots: [] });
  }
  (objects[owner._prefab.__id__].nestedPrefabInstanceRoots ??= []).push(ref(id));
  return id;
}

module.exports = { ref, clone, compact, assertGraph, extractSubtree, appendNested };
