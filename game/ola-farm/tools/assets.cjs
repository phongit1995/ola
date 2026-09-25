'use strict';
// Read-only checks of the Cocos-owned catalog and art. Never generates gameplay code.
const fs=require('node:fs'),path=require('node:path'),crypto=require('node:crypto'),assert=require('node:assert/strict');
const project=path.resolve(__dirname,'..'),resources=path.join(project,'assets/resources');
const read=f=>JSON.parse(fs.readFileSync(f,'utf8'));
const walk=d=>fs.readdirSync(d,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(d,e.name)):[path.join(d,e.name)]);
const manifest=read(path.join(project,'asset-manifest.json')),index=read(path.join(resources,'ported/asset-index.json'));
assert.equal(manifest.version,2);
assert.equal(Object.keys(index).length,manifest.entries.length);
for(const e of manifest.entries){
  assert.equal(index[e.source],e.resource);
  const file=path.resolve(resources,e.resource+path.extname(e.source));
  assert.ok(file.startsWith(resources+path.sep),'asset outside resources');
  const bytes=fs.readFileSync(file);
  assert.equal(bytes.length,e.bytes,'asset size '+e.source);
  assert.equal(crypto.createHash('sha256').update(bytes).digest('hex'),e.sha256,'asset hash '+e.source);
}
const game=read(path.join(resources,'ported/game.json'));
function references(value){
  if(typeof value==='string'&&/^(assets|data\/unity)\/.*\.(png|wav|ttf)$/i.test(value))assert.ok(index[value],'missing art '+value);
  else if(Array.isArray(value))value.forEach(references);
  else if(value&&typeof value==='object')Object.values(value).forEach(references);
}
references(game);
assert.equal(game.data.farm.length,9);assert.equal(game.data.products.length,16);
assert.ok(!('missions' in game.data)&&!('staff' in game.data));
const farmIds=new Set(game.data.farm.map(f=>f.id)),productIds=new Set(game.data.products.map(p=>p.id));
assert.equal(farmIds.size,9);assert.equal(productIds.size,16);
for(const f of game.data.farm){
  assert.ok(Number.isInteger(f.id)&&f.id>=1&&f.id<=9&&f.name&&f.key);
  assert.ok(f.group===(f.id<=4?'crop':f.id<=7?'pen':'pond'));
  assert.ok(Number.isFinite(f.price)&&f.price>=0&&Number.isFinite(f.duration)&&f.duration>0);
  assert.ok(f.yields.length===4&&f.yields.every(n=>Number.isSafeInteger(n)&&n>0));
  assert.ok(index['assets/sprites/'+f.image+'.png']);
}
for(const r of game.data.products){
  assert.ok(Number.isFinite(r.price)&&r.price>=0&&Number.isFinite(r.duration)&&r.duration>0);
  assert.ok(Number.isInteger(r.machine)&&r.machine>=1&&r.machine<=4);
  assert.ok(r.ingredients.length>0&&new Set(r.ingredients.map(i=>i.id)).size===r.ingredients.length);
  assert.ok(r.ingredients.every(i=>farmIds.has(i.id)&&Number.isSafeInteger(i.quantity)&&i.quantity>0));
  assert.ok(index['assets/sprites/'+r.image+'.png']);
}
const metadata=new Map();
for(const file of walk(path.join(project,'assets')).filter(f=>f.endsWith('.meta'))){
  const meta=read(file);assert.ok(meta.uuid&&!metadata.has(meta.uuid),'duplicate/missing UUID '+file);metadata.set(meta.uuid,file);
}
const prefabs=['map','items'].flatMap(d=>walk(path.join(project,'assets/farm/prefabs',d))).filter(f=>f.endsWith('.prefab'));
for(const file of prefabs){
  assert.ok(fs.existsSync(file+'.meta'),'missing metadata '+file);const objects=read(file);
  const scan=o=>{if(!o||typeof o!=='object')return;
    if(Object.hasOwn(o,'__id__'))assert.ok(Number.isInteger(o.__id__)&&o.__id__>=0&&o.__id__<objects.length,'bad reference '+file);
    if(o.__uuid__)assert.ok(metadata.has(o.__uuid__.split('@')[0]),'missing dependency '+o.__uuid__);
    Object.values(o).forEach(scan);
  };scan(objects);
}
console.log('Verified '+manifest.entries.length+' legacy art assets, '+prefabs.length+' prefabs, 9 legacy breeds and 16 legacy recipes entirely inside cocos/.');
