'use strict';
// Reproducible selected-image import. PNG bytes are preserved; pivot/trim offsets come from the source manifest.
// --check needs only the committed Cocos project, never reference/ or UnityPy.
const fs = require('node:fs'), path = require('node:path'), crypto = require('node:crypto');
const { stableId } = require('./cocos-ids.cjs');
const project = path.resolve(__dirname, '..'), repo = path.dirname(project), check = process.argv.includes('--check');
const source = JSON.parse(fs.readFileSync(path.join(project, 'source-assets/farm-beautify/manifest.json')));
const layout = JSON.parse(fs.readFileSync(path.join(project, 'source-assets/farm-beautify/layout.json')));
const root = path.join(project, 'assets/farm/data/farm-decor');
const template = JSON.parse(fs.readFileSync(path.join(project, 'assets/farm/prefabs/items/scenery/BroadleafTree.prefab')));
const imageTemplate = JSON.parse(fs.readFileSync(path.join(project, 'assets/farm/bundles/farm-town/images/egg.png.meta')));
const hash = b => crypto.createHash('sha256').update(b).digest('hex');
const ref = id => ({ __id__: id });
let changed = 0;
function write(file, content) {
  const next = typeof content === 'string' || Buffer.isBuffer(content) ? content : JSON.stringify(content, null, 2) + '\n';
  if (fs.existsSync(file) && (Buffer.from(next).equals(fs.readFileSync(file)) || (!Buffer.isBuffer(content) && String(next).replace(/\r\n/g, '\n') === fs.readFileSync(file, 'utf8').replace(/\r\n/g, '\n')))) return;
  if (check) throw Error('Decor output missing or stale: ' + path.relative(project, file));
  fs.mkdirSync(path.dirname(file), { recursive: true }); fs.writeFileSync(file, next); changed++;
}
const uuid = id => stableId('farm-decor/' + id);
const dependency = (id, type) => ({ __uuid__: id, __expectedType__: type });
function assetMeta(importer, id, ver, userData = {}, files = ['.json']) {
  return { ver, importer, imported: true, uuid: id, files, subMetas: {}, userData };
}

const registry = [];
for (const item of source.images) {
  const imageFile = path.join(project, item.runtimeImage), prefabFile = path.join(project, item.runtimePrefab);
  if (!fs.existsSync(imageFile) || hash(fs.readFileSync(imageFile)) !== item.sha256) {
    if (check) throw Error('Missing or changed decor PNG: ' + item.id);
    const input = path.join(repo, item.source);
    if (!fs.existsSync(input) || hash(fs.readFileSync(input)) !== item.sha256) throw Error('Source PNG missing or changed: ' + item.source);
    write(imageFile, fs.readFileSync(input));
  }
  const bytes = fs.readFileSync(imageFile);
  if (bytes.readUInt32BE(16) !== item.width || bytes.readUInt32BE(20) !== item.height) throw Error('Wrong image size: ' + item.id);
  const im = JSON.parse(JSON.stringify(imageTemplate)), oldUuid = im.uuid, imageUuid = uuid(item.id + '/image');
  const replace = value => {
    if (typeof value === 'string') return value.replaceAll(oldUuid, imageUuid).replaceAll('egg', item.id);
    if (Array.isArray(value)) return value.map(replace);
    if (value && typeof value === 'object') return Object.fromEntries(Object.entries(value).map(([k, v]) => [k, replace(v)]));
    return value;
  };
  const imageMeta = replace(im), frame = imageMeta.subMetas.f9941.userData, w = item.width, h = item.height;
  Object.assign(frame, { width: w, height: h, rawWidth: w, rawHeight: h, pivotX: .5, pivotY: .5 });
  frame.vertices = { rawPosition: [-w/2,-h/2,0,w/2,-h/2,0,-w/2,h/2,0,w/2,h/2,0], indexes: [0,1,2,2,1,3], uv: [0,h,w,h,0,0,w,0], nuv: [0,0,1,0,0,1,1,1], minPos: [-w/2,-h/2,0], maxPos: [w/2,h/2,0] };
  write(imageFile + '.meta', imageMeta);
  const p = JSON.parse(JSON.stringify(template)); p[0]._name = item.id;
  p.forEach((o, i) => {
    if (o.fileId) o.fileId = uuid(item.id + '/object/' + i);
    if (o.__type__ === 'cc.UITransform') o._contentSize = { __type__: 'cc.Size', width: w, height: h };
  });
  p[1]._name = item.id;
  p[2]._lpos.x = Math.round((.5 - item.anchor[0]) * w * 1000) / 1000;
  p[2]._lpos.y = Math.round((.5 - item.anchor[1]) * h * 1000) / 1000;
  p[8]._anchorPoint = { __type__: 'cc.Vec2', x: item.anchor[0], y: item.anchor[1] };
  p[5]._spriteFrame = dependency(imageUuid + '@f9941', 'cc.SpriteFrame');
  write(prefabFile, p);
  const prefabUuid = uuid(item.id + '/prefab');
  write(prefabFile + '.meta', assetMeta('prefab', prefabUuid, '1.1.50', { syncNodeName: item.id }));
  registry.push({ id: item.id, category: item.category, uuid: prefabUuid, rootId: p[10].fileId, width: w, height: h, anchor: item.anchor, resource: path.relative(path.join(project, 'assets/farm/prefabs'), prefabFile).replaceAll(path.sep, '/').replace(/\.prefab$/, ''), sha256: item.sha256 });
}
write(path.join(root, 'manifest.json'), { schemaVersion: 1, images: registry });
write(path.join(root, 'manifest.json.meta'), assetMeta('json', uuid('manifest'), '2.0.1'));
write(path.join(root, 'forest.json'), layout.forest);
write(path.join(root, 'forest.json.meta'), assetMeta('json', uuid('forest'), '2.0.1'));
write(root + '.meta', assetMeta('directory', uuid('directory'), '1.2.0', {}, []));
write(path.join(root, 'images.meta'), assetMeta('directory', uuid('images'), '1.2.0', {}, []));
write(path.join(root, 'images/decor.pac'), { __type__: 'cc.SpriteAtlas' });
write(path.join(root, 'images/decor.pac.meta'), assetMeta('auto-atlas', uuid('atlas'), '1.0.8', {
  maxWidth: 2048, maxHeight: 2048, padding: 2, allowRotation: false, forceSquared: false, powerOfTwo: true,
  algorithm: 'MaxRects', format: 'png', quality: 100, contourBleed: true, paddingBleed: true, filterUnused: true,
  removeTextureInBundle: true, removeImageInBundle: true, removeSpriteAtlasInBundle: true, compressSettings: {},
  textureSetting: { wrapModeS: 'clamp-to-edge', wrapModeT: 'clamp-to-edge', minfilter: 'linear', magfilter: 'linear', mipfilter: 'none', anisotropy: 0 },
}));
console.log(`${check ? 'Verified' : 'Prepared'} ${registry.length} decor PNGs/prefabs; ${changed} files updated.`);
