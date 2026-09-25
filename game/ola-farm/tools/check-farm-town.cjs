'use strict';
const fs=require('node:fs'),path=require('node:path'),crypto=require('node:crypto'),assert=require('node:assert/strict');
const root=path.resolve(__dirname,'..'),bundle=path.join(root,'assets/farm/bundles/farm-town'),read=p=>JSON.parse(fs.readFileSync(p,'utf8'));
const manifest=read(path.join(bundle,'manifest.json')),catalog=require('./load-farm-catalog.cjs').loadFarmCatalog();
const digest=p=>crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex'),uuids=new Set(),sprites=new Set();let bytes=0;
for(const [key,i] of Object.entries(manifest.images)){
  const p=path.join(bundle,i.resource+'.png'),meta=read(p+'.meta');assert.equal(digest(p),i.sha256,key);assert.equal(meta.uuid,i.uuid,key);
  assert.ok(!uuids.has(i.uuid));uuids.add(i.uuid);sprites.add(i.uuid+'@f9941');assert.equal(meta.subMetas.f9941.userData.trimType,'none');
  const png=fs.readFileSync(p);assert.deepEqual([png.readUInt32BE(16),png.readUInt32BE(20)],i.size);bytes+=png.length;
}
function refs(v,visit){if(Array.isArray(v))v.forEach(x=>refs(x,visit));else if(v&&typeof v==='object'){visit(v);Object.values(v).forEach(x=>refs(x,visit));}}
for(const [key,p] of Object.entries(manifest.prefabs)){
  // The audited Windows export used CRLF; Git may check it out with LF on macOS.
  const file=path.join(bundle,p.resource+'.prefab'),data=read(file);
  const windowsHash=crypto.createHash('sha256').update(fs.readFileSync(file,'utf8').replace(/\r?\n/g,'\r\n')).digest('hex');
  assert.ok(digest(file)===p.sha256||windowsHash===p.sha256||crypto.createHash('sha256').update(fs.readFileSync(file,'utf8').replace(/\r\n/g,'\n')).digest('hex')===p.sha256,key+': changed prefab content');
  let count=0;refs(data,v=>{if(v.__id__!==undefined)assert.ok(Number.isInteger(v.__id__)&&data[v.__id__],key);if(v.__uuid__)assert.ok(sprites.has(v.__uuid__),key+': outside bundle dependency '+v.__uuid__);if(v.__type__==='cc.Sprite'){count++;assert.ok(v._spriteFrame,key);}});assert.ok(count>0,key);
  if(['corn','cabbage'].includes(key)||key.startsWith('field-'))for(const n of ['Stage1','Stage2','Stage3'])assert.ok(data.some(d=>d.__type__==='cc.Node'&&d._name===n),key+'/'+n);
}
for(const f of catalog.farm)if(f.prefab)assert.ok(manifest.prefabs[f.prefab]);for(const m of catalog.machineTypes)if(m.prefab)assert.ok(manifest.prefabs[m.prefab]);for(const a of catalog.livestock)assert.ok(manifest.prefabs[a.prefab]);
const map=read(path.join(root,'assets/farm/prefabs/map/scenes.prefab')),group=map.find(n=>n.__type__==='cc.Node'&&n._name==='Buildings');
assert.deepEqual(group._children.map(r=>map[r.__id__]._name).sort(),catalog.machineTypes.flatMap(t=>t.buildSites.map(s=>s.buildingId)).sort());
assert.equal(catalog.contentProfile,'simple-1');assert.equal(catalog.farm.length,8);assert.equal(catalog.items.length,35);assert.equal(catalog.products.length,23);assert.equal(catalog.machineTypes.length,8);assert.equal(catalog.livestock.length,4);
assert.equal(new Set(catalog.items.map(i=>i.key)).size,35);
assert.equal(Object.keys(manifest.prefabs).length,21);
assert.equal(fs.readdirSync(path.join(bundle,'images')).filter(n=>n.endsWith('.png')).length,Object.keys(manifest.images).length);
assert.equal(fs.readdirSync(path.join(bundle,'prefabs')).filter(n=>n.endsWith('.prefab')).length,21);
const iconDefs=[...catalog.farm,...catalog.items,...catalog.products,...catalog.machineTypes,...catalog.livestock];
for(const i of iconDefs)if(i.image.startsWith('farm-town/'))assert.ok(manifest.images[i.image.slice(10)],i.image);
for(const name of ['farm-town-industries','farm-town-agriculture'])assert.ok(!fs.existsSync(path.join(root,'assets/farm/bundles',name)));
const expected=read(path.join(root,'tests/fixtures/farm-town-husbandry-scope.json'));
const cropBaseline=read(path.join(root,'tests/fixtures/simple-farm-catalog-v1.json'));
const identity=({price,sellPrice,duration,requiredLevel,harvestXP,yields,...crop})=>crop;
assert.deepEqual(catalog.farm.map(identity),cropBaseline.farm.map(identity),'Keep the accepted eight crop IDs and art; economy is balanced separately');
assert.deepEqual(catalog.items.map(i=>i.key).sort(),expected.items.map(i=>i.key).sort());
assert.deepEqual(catalog.products.map(r=>r.id).sort((a,b)=>a-b),expected.recipes.map(r=>r.id).sort((a,b)=>a-b));
for(const key of ['pig','sheep','yard-pigpen','yard-sheepfold','industry-loom']){
  const provenance=manifest.provenance[key],data=read(path.join(bundle,manifest.prefabs[key].resource+'.prefab'));
  assert.equal(provenance.kind,'projected-hierarchy',key+': needs gameplay hierarchy');
  assert.ok(provenance.source&&provenance.sourceApkSHA256,key+': missing source identity');
  assert.ok(provenance.layers.length>1,key+': a UI icon is not a layered gameplay prefab');
  assert.equal(data.filter(n=>n.__type__==='cc.Sprite').length,provenance.layers.length,key);
  for(const layer of provenance.layers){
    assert.ok(layer.sourcePath&&data.some(n=>n.__type__==='cc.Node'&&n._name===layer.node),key+'/'+layer.node);
    assert.ok(manifest.images[layer.image.slice(7)],key+': missing layer pixels');
  }
}
assert.equal(read(bundle+'.meta').userData.bundleName,'farm-town');
console.log(`Farm Town: ${Object.keys(manifest.images).length} PNG (${bytes} bytes), ${Object.keys(manifest.prefabs).length} prefabs, 16 separate machine anchors; hashes and dependencies valid.`);
const skin=path.join(root,'assets/farm/bundles/farm-town-ui'),skinManifest=read(path.join(skin,'manifest.json'));
for(const [key,i] of Object.entries(skinManifest.images)){
  const p=path.join(skin,i.resource+'.png'),png=fs.readFileSync(p);
  assert.equal(digest(p),i.sha256,key);assert.deepEqual([png.readUInt32BE(16),png.readUInt32BE(20)],i.size);
  assert.ok(i.border.every(n=>Number.isFinite(n)&&n>=0),key);
  assert.ok(i.border[0]+i.border[2]<i.size[0]&&i.border[1]+i.border[3]<i.size[1],key+': invalid nine-slice');
  assert.equal(read(p+'.meta').importer,'image',key);
}
console.log(`Farm Town UI: ${Object.keys(skinManifest.images).length} source PNGs, hashes and trimmed nine-slice borders valid.`);
