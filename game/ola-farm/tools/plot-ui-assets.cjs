'use strict';
// Reproducible import of the plot bubble skin. PNG bytes are preserved; nine-slice borders come from the source manifest.
// The output is a runtime bundle, so the map can load it after boot. --check needs only the committed Cocos project.
const fs = require('node:fs'), path = require('node:path'), crypto = require('node:crypto');
const { stableId } = require('./cocos-ids.cjs');
const project = path.resolve(__dirname, '..'), repo = path.dirname(project), check = process.argv.includes('--check');
const source = JSON.parse(fs.readFileSync(path.join(project, 'source-assets/farm-plot-ui/manifest.json')));
const root = path.join(project, 'assets/farm/bundles/farm-plot-ui');
const imageTemplate = JSON.parse(fs.readFileSync(path.join(project, 'assets/farm/bundles/farm-town/images/egg.png.meta')));
const hash = b => crypto.createHash('sha256').update(b).digest('hex');
let changed = 0;
function write(file, content) {
  const next = typeof content === 'string' || Buffer.isBuffer(content) ? content : JSON.stringify(content, null, 2) + '\n';
  if (fs.existsSync(file) && (Buffer.from(next).equals(fs.readFileSync(file)) || (!Buffer.isBuffer(content) && String(next).replace(/\r\n/g, '\n') === fs.readFileSync(file, 'utf8').replace(/\r\n/g, '\n')))) return;
  if (check) throw Error('Plot UI output missing or stale: ' + path.relative(project, file));
  fs.mkdirSync(path.dirname(file), { recursive: true }); fs.writeFileSync(file, next); changed++;
}
const uuid = id => stableId('farm-plot-ui/' + id);
const assetMeta = (importer, id, ver, userData = {}, files = ['.json']) => ({ ver, importer, imported: true, uuid: id, files, subMetas: {}, userData });

const images = {};
for (const item of source.images) {
  const imageFile = path.join(root, 'images', item.id + '.png');
  if (!fs.existsSync(imageFile) || hash(fs.readFileSync(imageFile)) !== item.sha256) {
    if (check) throw Error('Missing or changed plot UI PNG: ' + item.id);
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
  const [left, bottom, right, top] = item.border;
  Object.assign(frame, { width: w, height: h, rawWidth: w, rawHeight: h, pivotX: .5, pivotY: .5, borderLeft: left, borderBottom: bottom, borderRight: right, borderTop: top });
  frame.vertices = { rawPosition: [-w/2,-h/2,0,w/2,-h/2,0,-w/2,h/2,0,w/2,h/2,0], indexes: [0,1,2,2,1,3], uv: [0,h,w,h,0,0,w,0], nuv: [0,0,1,0,0,1,1,1], minPos: [-w/2,-h/2,0], maxPos: [w/2,h/2,0] };
  write(imageFile + '.meta', imageMeta);
  images[item.id] = { resource: 'images/' + item.id, size: [w, h], border: item.border, sha256: item.sha256,
    sourceName: item.sourceName, sourceNode: item.sourceNode, note: item.note };
}
write(path.join(root, 'manifest.json'), { schemaVersion: 1, source: source.source, images });
write(path.join(root, 'manifest.json.meta'), assetMeta('json', uuid('manifest'), '2.0.1'));
write(root + '.meta', assetMeta('directory', uuid('directory'), '1.2.0',
  { isBundle: true, bundleName: 'farm-plot-ui', priority: 2, isRemoteBundle: false }, []));
write(path.join(root, 'images.meta'), assetMeta('directory', uuid('images'), '1.2.0', {}, []));
console.log(`${check ? 'Verified' : 'Prepared'} ${Object.keys(images).length} plot UI PNGs; ${changed} files updated.`);
