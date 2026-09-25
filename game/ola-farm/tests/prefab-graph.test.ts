import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import test from 'node:test';
const { UiPrefabBuilder } = require('../tools/ui-prefab-builder.cjs');
const { UI_PREFAB_PATHS, uiPrefabUuid } = require('../tools/ui-prefab-paths.cjs');
const { ref, clone, compact, assertGraph, extractSubtree, appendNested } = require('../tools/prefab-graph.cjs');
const instanceOf = (objects: any[], nodeId: number): any =>
  objects[objects[objects[nodeId]._prefab.__id__].instance.__id__];
const sceneGraph = (): any[] => [
  { __type__: 'cc.SceneAsset', scene: ref(1) },
  { __type__: 'cc.Scene', _name: 'Scene', _parent: null, _children: [ref(2)], _components: [], _prefab: null },
  { __type__: 'cc.Node', _name: 'Canvas', _parent: ref(1), _children: [], _components: [], _prefab: null },
];

test('subtree extraction keeps component links and assets without absorbing parent or sibling objects', () => {
  const b = new UiPrefabBuilder('Host', 1000, 900);
  const hud = b.node(b.root, 'Hud', 4, 9, 800, 90),
    label = b.label(hud, 'Counter', '25', 0, 0, 100, 30);
  const component = b.component(hud, 'TestView', { title: b.reference(label, 'cc.Label') });
  const sibling = b.node(b.root, 'Unrelated', 0, 0, 1, 1),
    original = clone(b.objects);
  const result = extractSubtree(b.objects, hud, { name: 'Hud', namespace: 'test/Hud' });
  assert.deepEqual(b.objects, original, 'extraction does not mutate the authored input');
  assert.equal(result.oldToNew.has(sibling), false);
  assert.equal(result.oldToNew.has(b.root), false);
  const objects = result.objects,
    root = objects[objects[0].data.__id__],
    view = objects[result.oldToNew.get(component)];
  assert.equal(root._parent, null);
  assert.deepEqual([root._lpos.x, root._lpos.y], [4, 9]);
  assert.equal(objects[view.title.__id__].__type__, 'cc.Label');
  assert.ok(objects[view.title.__id__]._font.__uuid__);
  assertGraph(objects);
  b.objects[component].external = ref(sibling);
  assert.throws(() => extractSubtree(b.objects, hud, { name: 'Hud' }), /cross-subtree/);
});

test('linked instances retain source identity while independent overrides survive compaction', () => {
  const b = new UiPrefabBuilder('Host', 1000, 900);
  // An unreachable record should move all later indexes without changing external identity.
  b.objects.push({ __type__: 'cc.TargetInfo', localID: ['unused'] });
  for (const [key, x] of [
    ['left', -100],
    ['right', 100],
  ] as const)
    appendNested(b.objects, {
      parentId: b.root,
      ownerRootId: b.root,
      prefabUuid: 'source-asset',
      sourceRootFileId: 'same-source-root',
      instanceKey: key,
      name: key,
      position: { x, y: 0 },
      scale: { x: 2, y: 2 },
    });
  assertGraph(b.objects);
  const packed = compact(b.objects);
  assertGraph(packed);
  assert.equal(packed.length, b.objects.length - 1);
  const infos = packed.filter((o: any) => o.__type__ === 'cc.PrefabInfo' && o.asset?.__uuid__);
  assert.deepEqual(
    infos.map((o: any) => o.fileId),
    ['same-source-root', 'same-source-root']
  );
  const instances = infos.map((o: any) => packed[o.instance.__id__]);
  assert.notEqual(instances[0].fileId, instances[1].fileId);
  for (const [i, instance] of instances.entries()) {
    const overrides = instance.propertyOverrides.map((r: any) => packed[r.__id__]);
    assert.deepEqual(
      overrides.map((o: any) => o.propertyPath),
      [['_name'], ['_lpos'], ['_lscale']]
    );
    assert.equal(overrides[1].value.x, i ? 100 : -100);
    overrides.forEach((o: any) => assert.deepEqual(packed[o.targetInfo.__id__].localID, ['same-source-root']));
  }
  assert.deepEqual(compact(packed), packed, 'repeat compaction is byte-stable');
  const missing = clone(packed);
  missing[missing[missing[0].data.__id__]._prefab.__id__].nestedPrefabInstanceRoots = [];
  assert.throws(() => assertGraph(missing), /unregistered nested prefab root/);
});

test('linked prefab ownership follows the nearest containing prefab rather than the instance itself', () => {
  const b = new UiPrefabBuilder('Host'),
    holder = b.node(b.root, 'Holder');
  const outer = appendNested(b.objects, {
    parentId: holder,
    ownerRootId: b.root,
    prefabUuid: 'outer-asset',
    sourceRootFileId: 'outer-root',
    instanceKey: 'outer',
  });
  const inner = appendNested(b.objects, {
    parentId: outer,
    ownerRootId: outer,
    prefabUuid: 'inner-asset',
    sourceRootFileId: 'inner-root',
    instanceKey: 'inner',
  });
  // This is the ownership topology in Creator's testPrefab-3-3-0.prefab fixture:
  // the nested PrefabInfo names its own root, while prefabRootNode names the container.
  assert.equal(b.objects[b.objects[outer]._prefab.__id__].root.__id__, outer);
  assert.equal(instanceOf(b.objects, outer).prefabRootNode.__id__, b.root);
  assert.equal(instanceOf(b.objects, inner).prefabRootNode.__id__, outer);
  assertGraph(b.objects);
  for (const [nodeId, wrongOwner] of [
    [outer, holder],
    [outer, null],
    [inner, b.root],
  ]) {
    const invalid = clone(b.objects);
    instanceOf(invalid, nodeId!).prefabRootNode = wrongOwner === null ? null : ref(wrongOwner);
    assert.throws(
      () => assertGraph(invalid),
      /nested root mismatch/,
      'missing or skipped enclosing prefab is rejected'
    );
  }
});

test('outermost scene instances have no prefab owner and deeper instances retain their containing prefab', () => {
  const objects = sceneGraph();
  const outer = appendNested(objects, {
    parentId: 2,
    ownerRootId: 1,
    prefabUuid: 'outer-asset',
    sourceRootFileId: 'outer-root',
    instanceKey: 'scene-outer',
  });
  const inner = appendNested(objects, {
    parentId: outer,
    ownerRootId: outer,
    prefabUuid: 'inner-asset',
    sourceRootFileId: 'inner-root',
    instanceKey: 'scene-inner',
  });
  assert.equal(instanceOf(objects, outer).prefabRootNode, null);
  assert.equal(instanceOf(objects, inner).prefabRootNode.__id__, outer);
  assertGraph(objects);
  delete instanceOf(objects, outer).prefabRootNode;
  assertGraph(objects); // Creator's companion .scene fixture omits this outer owner.
  instanceOf(objects, outer).prefabRootNode = ref(2);
  assert.throws(() => assertGraph(objects), /nested root mismatch/, 'a Canvas is not a containing prefab');
});

test('a plain node with self-rooted metadata cannot become a containing prefab owner', () => {
  const b = new UiPrefabBuilder('Host'),
    holder = b.node(b.root, 'PlainHolder');
  const holderInfo = b.objects[b.objects[holder]._prefab.__id__];
  holderInfo.root = ref(holder);
  assert.equal(holderInfo.instance, undefined);
  const child = appendNested(b.objects, {
    parentId: holder,
    ownerRootId: b.root,
    prefabUuid: 'asset',
    sourceRootFileId: 'source-root',
    instanceKey: 'plain-holder-child',
  });
  assert.equal(
    instanceOf(b.objects, child).prefabRootNode.__id__,
    b.root,
    'ownership passes through plain metadata to the real prefab root'
  );
  assertGraph(b.objects);
  instanceOf(b.objects, child).prefabRootNode = ref(holder);
  assert.throws(() => assertGraph(b.objects), /nested root mismatch/);
});

test('prefab ownership rejects self references and multi-instance cycles without relaxing hierarchy checks', () => {
  const b = new UiPrefabBuilder('Host');
  const left = appendNested(b.objects, {
    parentId: b.root,
    ownerRootId: b.root,
    prefabUuid: 'asset',
    sourceRootFileId: 'source-root',
    instanceKey: 'left',
  });
  const right = appendNested(b.objects, {
    parentId: b.root,
    ownerRootId: b.root,
    prefabUuid: 'asset',
    sourceRootFileId: 'source-root',
    instanceKey: 'right',
  });
  const self = clone(b.objects);
  instanceOf(self, left).prefabRootNode = ref(left);
  assert.throws(() => assertGraph(self), /prefab instance ownership cycle/);
  const cycle = clone(b.objects);
  instanceOf(cycle, left).prefabRootNode = ref(right);
  instanceOf(cycle, right).prefabRootNode = ref(left);
  assert.throws(() => assertGraph(cycle), /prefab instance ownership cycle/);
  const sibling = clone(b.objects);
  instanceOf(sibling, left).prefabRootNode = ref(right);
  assert.throws(() => assertGraph(sibling), /nested root mismatch/);
  const hierarchy = clone(b.objects);
  hierarchy[left]._children.push(ref(left));
  assert.throws(() => assertGraph(hierarchy), /parent\/child mismatch|duplicate child or cycle/);
});

test('subtree extraction rebases outer prefab ownership and preserves an inner owner without capturing the old parent', () => {
  for (const origin of ['prefab', 'scene']) {
    const b = new UiPrefabBuilder('Host'),
      holder = b.node(b.root, 'Extracted');
    const source = origin === 'prefab' ? b.objects : sceneGraph(),
      rootId = 1,
      extractedId = origin === 'prefab' ? holder : 2;
    const outer = appendNested(source, {
      parentId: extractedId,
      ownerRootId: rootId,
      prefabUuid: 'outer-asset',
      sourceRootFileId: 'outer-root',
      instanceKey: origin + '/outer',
    });
    const inner = appendNested(source, {
      parentId: outer,
      ownerRootId: outer,
      prefabUuid: 'inner-asset',
      sourceRootFileId: 'inner-root',
      instanceKey: origin + '/inner',
    });
    assertGraph(source);
    const before = clone(source),
      result = extractSubtree(source, extractedId, { name: 'Extracted' }),
      objects = result.objects;
    assert.deepEqual(source, before, 'extraction leaves the source graph unchanged');
    assert.equal(result.oldToNew.has(rootId), false, 'the former enclosing prefab/scene is not copied');
    const newRoot = objects[0].data.__id__,
      newOuter = result.oldToNew.get(outer),
      newInner = result.oldToNew.get(inner);
    assert.equal(instanceOf(objects, newOuter).prefabRootNode.__id__, newRoot);
    assert.equal(instanceOf(objects, newInner).prefabRootNode.__id__, newOuter);
    assert.equal(objects[objects[newOuter]._prefab.__id__].asset.__uuid__, 'outer-asset');
    assert.equal(objects[objects[newInner]._prefab.__id__].asset.__uuid__, 'inner-asset');
    assertGraph(objects);
    assertGraph(compact(objects));
  }
});

test('graph validator rejects dangling links, wrong component ownership and unresolved or mistyped external assets', () => {
  const b = new UiPrefabBuilder('Host'),
    child = b.node(b.root, 'Child');
  const dangling = clone(b.objects);
  dangling[b.root]._children.push(ref(999));
  assert.throws(() => assertGraph(dangling), /invalid __id__/);
  const owner = clone(b.objects);
  owner[owner[child]._components[0].__id__].node = ref(b.root);
  assert.throws(() => assertGraph(owner), /component owner mismatch/);
  b.component(child, 'TestView', { art: { __uuid__: 'frame', __expectedType__: 'cc.SpriteFrame' } });
  assert.throws(() => assertGraph(b.objects, { assetIndex: new Map() }), /missing external asset/);
  assert.throws(
    () => assertGraph(b.objects, { assetIndex: new Map([['frame', { type: 'cc.Prefab' }]]) }),
    /wrong asset type/
  );
  assertGraph(b.objects, { assetIndex: new Map([['frame', { type: 'cc.SpriteFrame' }]]) });
});

test('every authored Cocos prefab and scene has valid local graph ownership and external assets', () => {
  const root = path.resolve(__dirname, '../assets');
  const walk = (dir: string): string[] =>
    fs
      .readdirSync(dir, { withFileTypes: true })
      .flatMap(entry => (entry.isDirectory() ? walk(path.join(dir, entry.name)) : [path.join(dir, entry.name)]));
  const files = walk(root),
    assets = new Map<string, { type?: string }>();
  // Creator 3.8.8 ships these native UI SpriteFrames outside the project asset tree:
  // engine/editor/assets/default_ui/{default_sprite_splash,default_progressbar}.png.meta.
  for (const uuid of ['7d8f9b89-4fd1-4c9f-a3ab-38ec7cded7ca@f9941', '24a704da-2867-446d-8d1a-5e920c75e09d@f9941'])
    assets.set(uuid, { type: 'cc.SpriteFrame' });
  const types: Record<string, string> = {
    prefab: 'cc.Prefab',
    scene: 'cc.SceneAsset',
    'sprite-frame': 'cc.SpriteFrame',
    texture: 'cc.Texture2D',
    image: 'cc.ImageAsset',
    font: 'cc.TTFFont',
    'ttf-font': 'cc.TTFFont',
    'bitmap-font': 'cc.BitmapFont',
    json: 'cc.JsonAsset',
    audio: 'cc.AudioClip',
  };
  const add = (meta: any) => {
    if (meta.uuid) assets.set(meta.uuid, { type: types[meta.importer] });
    Object.values(meta.subMetas ?? {}).forEach(add);
  };
  for (const file of files.filter(file => file.endsWith('.meta'))) add(JSON.parse(fs.readFileSync(file, 'utf8')));
  for (const file of files.filter(file => /\.(prefab|scene)$/.test(file)))
    assertGraph(JSON.parse(fs.readFileSync(file, 'utf8')), { file: path.relative(root, file), assetIndex: assets });
});

test('UI authoring paths cover every feature prefab and preserve its original asset identity', () => {
  const assets = path.resolve(__dirname, '../assets/farm');
  const files = fs
    .readdirSync(path.join(assets, 'prefabs/ui'), { recursive: true })
    .map(String)
    .filter(file => file.endsWith('.prefab'))
    .map(file => 'prefabs/ui/' + file.replace(/\\/g, '/'));
  assert.deepEqual([...Object.values(UI_PREFAB_PATHS)].sort(), files.sort());
  for (const [name, file] of Object.entries(UI_PREFAB_PATHS) as [string, string][]) {
    assert.match(file, /^prefabs\/ui\/[^/]+\.prefab$/, name + ' is a flat UI prefab');
    const meta = JSON.parse(fs.readFileSync(path.join(assets, file + '.meta'), 'utf8'));
    assert.equal(uiPrefabUuid(name), meta.uuid, name + ': regeneration must keep scene and nested links');
  }
});

test('authored UI ScrollViews use the serialized public axis and input properties of Creator 3.8', () => {
  // scroll-view.ts decorates these public fields. An underscore is silently ignored on import,
  // leaving both axes enabled and allowing an intended one-axis list to move the wrong way.
  const root = path.resolve(__dirname, '../assets/farm/prefabs/ui');
  let count = 0;
  for (const file of fs
    .readdirSync(root, { recursive: true })
    .map(String)
    .filter(file => file.endsWith('.prefab'))) {
    const objects = JSON.parse(fs.readFileSync(path.join(root, file), 'utf8'));
    for (const scroll of objects.filter((object: any) => object.__type__ === 'cc.ScrollView')) {
      count++;
      for (const property of ['horizontal', 'vertical', 'inertia', 'elastic', 'cancelInnerEvents']) {
        assert.equal(typeof scroll[property], 'boolean', file + ': ' + property + ' is explicitly serialized');
        assert.equal(
          Object.prototype.hasOwnProperty.call(scroll, '_' + property),
          false,
          file + ': ignored backing-field name ' + property
        );
      }
      assert.ok(scroll.horizontal || scroll.vertical, file + ': authored list has an enabled scroll axis');
      assert.ok(
        scroll._content && objects[scroll._content.__id__]?.__type__ === 'cc.Node',
        file + ': content uses the actual serialized backing field'
      );
    }
  }
  assert.ok(count >= 5, 'covers the independent Shop, inventory, factory, livestock and seed lists');
});
